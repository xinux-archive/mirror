#!/bin/bash
cd "$(dirname "$0")"

ok=`tput setaf 2`
warning=`tput setaf 1`
reset=`tput sgr0`

logom() {
    LOGO="
-----------------------------------------------
            _  __ _
           | |/ /(_)___  __  ___  __
           |   // / __ \/ / / / |/_/
          /   |/ / / / / /_/ />  <
         /_/|_/_/_/ /_/\__,_/_/|_|
-----------------------------------------------
Improve the Linux alongside Uzbek developers...    
"
    printf "${ok}$LOGO${reset}\n\n"
}

gitm() {

    # Why not logo?
    logom

    # Get all updates from the cloud
    printf "${warning}Fetching up all updates... ${reset}\n"
    git pull
    printf "\n"

    # Add up all files to a commit
    printf "${warning}Adding all files to commit... ${reset}\n"
    git add --all .
    printf "\n"

    # Assigning a commit message
    printf "${warning}Type a commit message here: ${reset}"
    read input
    printf "\n"
    
    # Commiting...
    printf "${warning}Ok, now let's apply this to a commit... ${reset}\n"
    git commit -m "$input"
    printf "\n"

    # Pushing all updates to the cloud
    printf "${warning}Uploading all changes to the cloud ${reset}\n"
    git push -u origin master
    printf "\n"

    # Program is finally happy
    printf "${warning}Job is done!${reset}"
    exit 0
}

cleanm() {

    # Why not logo?
    logom

    mv .git/config config
    rm -rf .git
    sh ./setup-git*
    mv config .git/config
    git add --all .
    git commit -m "Monthly cleaning"
    git push origin master --force
    exit 0
}

setupm() {

    # Why not logo?
    logom

    # Adding some option here
    set -e

    # Initializing a git repository
    printf "${warning}Let's initialize a git repository here... ${reset}\n"
    git init
    printf "\n"

    # Let's save some credentials here...
    
    ## Username here
    printf "\n${warning}Enter your full name for the git credentials: ${reset}"
    read username
    printf "\n${warning}Saving your name address to its database ... ${reset}\n"
    git config --global user.name "$username"
    printf "${warning}Saving the username to its database ... ${reset}\n"

    ## Full Name here
    printf "\n${warning}Enter your email address here to the git credentials: ${reset}"
    read email
    printf "\n${warning}Saving your email address to its database ... ${reset}\n"
    git config --global user.email "$email"

    ## Setting vim as the main git editor
    printf "\n${warning}Taking the 'vim' editor as the main one ... ${reset}\n"
    sudo git config --system core.editor vim

    # Setting up caching and push configs
    printf "\n${warning}Let me set up some additional useful configurations ... ${reset}\n"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=25000'
    git config --global push.default simple
    
    # Job is done
    printf "\n${warning}Program has successfully finished its job! ${reset}\n"
    exit 0
}

helpm() {

    # Why not logo?
    logom

    # Defining the guide message
    USAGE="
usage: ./mirror [ git | clean | setup ]
        
        git         Automates all tasks of git
                    source version control system

        clean       This script should be run in
                    monthly intercel. This script cleans
                    caches of unnesecarry git garbages

        setup       Startup script that fill configure
                    an environment for brand new arch
                    linux installations
    "

    # Let's print the message now
    printf "${ok}$USAGE${reset}"
    exit 0
}

updatem() {

    # Let's open the x86_64 directory
    printf "\n${warning}Opening the packages folder ... ${reset}\n"
    cd ./x86_64

    # Update its databse of x86_64 packages
    printf "\n${warning}Updating the database ... ${reset}\n"
    repo-add xinux.db.tar.gz *.pkg.tar.zst


    # Return back to its directory
    printf "\n${warning}Yahoo, now let's get back to the old stage ... ${reset}\n"
    cd ../
    
    # Job is done
    printf "\n${warning}Program has successfully finished its job! ${reset}\n"
    exit 0
}

# If user does not pass some argument, get some help =)
if [ $# -eq 0 ]
then
    helpm
fi

# The place where I capture all arguments
# Execution of all initialized functions
while [ $# -gt 0 ]
do
    key="$1"
    
    case $key in

        # The git case
        git)
            gitm
            break
            ;;

        # Database Updater
        update)
            updatem
            break
            ;;
    
        # The cleaning phase
        clean)
            cleanm
            break
            ;;
    
        # Setup stage
        setup)
            setupm
            break
            ;;
    
        # Any exceptional keys
        *)
            helpm
            break
            ;;
    
    esac

done
unset key
