require_dependency "bcms_kcfinder/application_controller"

module BcmsKcfinder
  class BrowseController < ApplicationController

    def index
    end

    def init
      @section = Cms::Section.find_by_name_path("/")
      render :json => {tree: {name: "My Site",
                              readable: true,
                              writable: false,
                              removable: false,
                              hasDirs: !@section.child_sections.empty?,
                              dirs: child_sections_to_dirs},
                       files: show_files(@section.pages)}.to_json
    end

    def command
      raise "Error: The command '#{params[:command]}' is not implemented yet."
    end

    private

    def show_files(files)
      files.map do |file|
        {
            name: file.name,
            size: file.file_size,
            mtime: 1338607220,
            date: "06\/02\/2012 03:20 AM",
            readable: true,
            writeable: true,
            bigIcon: true,
            smallIcon: true,
            thumb: false,
            smallThumb: false
        }
      end
    end

    def child_sections_to_dirs
      @section.sections.map do |child|
        {
            name: child.name,
            readable: true,
            writable: true,
            removable: true,
            hasDirs: !child.child_sections.empty?,
            current: false,
            dirs: []
        }
      end
    end
  end
end
