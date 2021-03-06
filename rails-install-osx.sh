#!/bin/sh
PACKAGE_URL="http://dl.dropbox.com/u/132031/tokaidoapp.tgz"
TOKAIDO_DIR="$HOME/.tokaidoapp"
RUBY_VERSION="1.9.3-p194"

function mktmpdir() {
dir=$(mktemp -t tokaido-XXXX)
rm -rf $dir
mkdir -p $dir
echo $dir
}

tmpdir=$(mktmpdir)
cd $tmpdir
echo "Downloading Tokaido.app"
curl $PACKAGE_URL -\# -o - | tar zxf -

echo "Setting up Tokaido.app"
mkdir -p $TOKAIDO_DIR
mkdir -p $TOKAIDO_DIR/rubies
mkdir -p $TOKAIDO_DIR/gems
mv .tokaidoapp/rubies/$RUBY_VERSION $TOKAIDO_DIR/rubies/
mv .tokaidoapp/gems/$RUBY_VERSION $TOKAIDO_DIR/gems/
mv .tokaidoapp/tokaidoapp.sh $TOKAIDO_DIR/

rm -rf $tmpdir

echo "[[ -s $HOME/.tokaidoapp/tokaidoapp.sh ]] && source $HOME/.tokaidoapp/tokaidoapp.sh" >> $HOME/.profile
source $HOME/.tokaidoapp/tokaidoapp.sh

echo -e "\n- - - - - - - - - \n"
echo -e "Now we are going to print some information to check that everything is done:\n"

echo    " ,;;;, ,;;;,"
echo -n ";;;' ';' ';;; Should be ruby 1.9.3p194: "
ruby -v | cut -c 1-14
echo    ";;;       ;;;"
echo -n " ';;,   ,;;'  Should be Rails 3.2.3: "
rails -v
echo    "   ';;,;;'"
echo    "     ';'"
echo -e "\n- - - - - - - - - \n"

echo "Done!"
echo "Please restart your terminal."
