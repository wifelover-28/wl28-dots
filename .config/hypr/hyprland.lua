------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@120",
    position = "0x0",
    scale = 1,
    bitdepth = 10,
    --cm = "hdredid",
    --sdrbrightness = 2.25,
    --sdrsaturation = 1,
    --sdr_min_luminance = 0,
    --sdr_max_luminance = 65,
    vrr = 0,
})

hl.monitor({
    output    = "HDMI-A-1",
    mode      = "1920x1080@60",
    position  = "1920x0",
    scale     = 1,
    bitdepth = 8,
   -- vrr = 1,
})

hl.config({
    quirks = {
        prefer_hdr = 0
    },
    render = {
        cm_auto_hdr = 0
    },
    debug = {
        full_cm_proto = false
    },
    misc = {
        vrr = 0,
    }
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()

    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprshell run")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("swaync")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("bash -c '~/.config/hypr/xdg-portal-hyprland'")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal")
    hl.exec_cmd("/run/current-system/sw/bin/thunar --daemon")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,pkcs11,ssh")
end)



-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(00f7ffee)", "rgba(ff00ffee)"}, angle = 45 },
            inactive_border = "rgba(FFFFFF90)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0x1a1a1aee,
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
--hl.device({
--    name        = "steelseries-steelseries-rival-310-esports-mouse",
--    sensitivity = -0.5,
--})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local clean_mode = false

-- Universal toggle, works in any submap
hl.bind("SUPER + G", function()
    clean_mode = not clean_mode
end, { submap_universal = true })

-- Programs (gated by flag)
hl.bind("CTRL + ALT + T", function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("kitty")) end end)
hl.bind("ALT + M",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("pavucontrol")) end end)
hl.bind("ALT + D",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("discord")) end end)
hl.bind("ALT + E",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("thunar")) end end)
hl.bind("ALT + F",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("librewolf")) end end)
hl.bind("ALT + C",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("code")) end end)
hl.bind("ALT + R",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("kitty -e rmpc")) end end)
hl.bind("ALT + S",        function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("steam")) end end)
hl.bind("SUPER + TAB",    function() if not clean_mode then hl.dispatch(hl.dsp.exec_cmd("bash -c 'killall rofi || rofi -modi drun -show drun -show-icons'")) end end)

-- Notifications
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- WM binds
hl.bind("ALT + F4",    hl.dsp.window.close())
hl.bind("SUPER + F",   hl.dsp.window.fullscreen())
hl.bind("SUPER + SPACE", hl.dsp.window.float())

-- Mouse binds
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   nil, { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), nil, { mouse = true })

-- Media keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))

-- Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Screenshot
hl.bind(
    "SUPER + SHIFT + S",
    hl.dsp.exec_cmd("bash -c \"grim -g \\\"$(slurp -o)\\\" - | tee ~/Pictures/Screenshots/$(date +'%s_grim.png') | wl-copy\"")
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "Windscribe",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
