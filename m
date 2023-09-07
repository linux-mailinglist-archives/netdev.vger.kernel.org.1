Return-Path: <netdev+bounces-32452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47A797A1E
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF12816C8
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864CA13AE3;
	Thu,  7 Sep 2023 17:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A8134D0
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:31:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29308BC
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 10:30:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qeFbL-0005Px-Dm; Thu, 07 Sep 2023 16:03:19 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1qeFbK-004fNB-J4; Thu, 07 Sep 2023 16:03:18 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qeFbK-002pFg-5m; Thu, 07 Sep 2023 16:03:18 +0200
Date: Thu, 7 Sep 2023 16:03:18 +0200
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>
Subject: possible circular locking dependency in netdev LED trigger
Message-ID: <20230907140318.GB637806@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From: Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I am very happy that phy LED trigger support is finally merged. Thanks
Andrew and Christion for making this happen :)

I am currently giving the LED support on the dp83867 phy a try. I got
the following log splat when doing a "echo netdev > /sys/class/leds/.../trigger"
on one of the DP83867 provided phy LEDs.

In the netdevice open path we first take &rtnl_mutex in devinet_ioctl()
and afterwards &triggers_list_lock in led_trigger_register().
The other path takes the locks in the opposite order: First it takes
&triggers_list_lock first in led_trigger_write() and then &rtnl_mutex
in register_netdevice_notifier(), so a classical ABBA deadlock. At least
that's what I see from looking at the code, I am a bit confused by the
lockdep output.

Any idea how we can solve this?

Sascha

-------------------------------8<---------------------------------------

[   53.942317] ======================================================
[   53.948607] WARNING: possible circular locking dependency detected
[   53.954898] 6.5.0-11704-g3f86ed6ec0b3 #367 Not tainted
[   53.960136] ------------------------------------------------------
[   53.966426] sh/579 is trying to acquire lock:
[   53.970872] ffff800082354af8 (pernet_ops_rwsem){+.+.}-{4:4}, at: register_netdevice_notifier+0x30/0x12c
[   53.980539]
[   53.980539] but task is already holding lock:
[   53.986485] ffff000004f2de68 (&led_cdev->trigger_lock){+.+.}-{4:4}, at: led_trigger_write+0x100/0x14c
[   53.995959]
[   53.995959] which lock already depends on the new lock.
[   53.995959]
[   54.004282]
[   54.004282] the existing dependency chain (in reverse order) is:
[   54.011898]
[   54.011898] -> #3 (&led_cdev->trigger_lock){+.+.}-{4:4}:
[   54.018877]        down_write+0x5c/0x120
[   54.022911]        led_trigger_set_default+0x40/0xd0
[   54.028001]        led_classdev_register_ext+0x2b8/0x3c8
[   54.033442]        __sdhci_add_host+0x1e4/0x368
[   54.038083]        sdhci_add_host+0x3c/0x50
[   54.042375]        sdhci_arasan_probe+0x9dc/0xaa4
[   54.047191]        platform_probe+0x68/0xc4
[   54.051481]        really_probe+0x148/0x2ac
[   54.055768]        __driver_probe_device+0x78/0x12c
[   54.060759]        driver_probe_device+0xd8/0x160
[   54.065574]        __device_attach_driver+0xb8/0x138
[   54.070657]        bus_for_each_drv+0x80/0xdc
[   54.075118]        __device_attach_async_helper+0xb0/0xd4
[   54.080635]        async_run_entry_fn+0x34/0xe0
[   54.085274]        process_one_work+0x1ec/0x51c
[   54.089920]        worker_thread+0x1ec/0x3e4
[   54.094300]        kthread+0x120/0x124
[   54.098147]        ret_from_fork+0x10/0x20
[   54.102343]
[   54.102343] -> #2 (triggers_list_lock){++++}-{4:4}:
[   54.108880]        down_write+0x5c/0x120
[   54.112915]        led_trigger_register+0x50/0x1b4
[   54.117822]        phy_led_triggers_register+0xa4/0x244
[   54.123167]        phy_attach_direct+0x158/0x378
[   54.127906]        phylink_fwnode_phy_connect+0x8c/0x10c
[   54.133331]        phylink_of_phy_connect+0x1c/0x28
[   54.138316]        macb_phylink_connect+0x48/0x120
[   54.143220]        macb_open+0x214/0x34c
[   54.147235]        __dev_open+0x100/0x1e0
[   54.151351]        __dev_change_flags+0x19c/0x21c
[   54.156167]        dev_change_flags+0x24/0x6c
[   54.160632]        devinet_ioctl+0x488/0x7d8
[   54.165007]        inet_ioctl+0x1e8/0x1f8
[   54.169117]        sock_do_ioctl+0x48/0xf8
[   54.173317]        sock_ioctl+0x250/0x374
[   54.177433]        __arm64_sys_ioctl+0xac/0xf0
[   54.181989]        invoke_syscall+0x48/0x114
[   54.186370]        el0_svc_common.constprop.0+0xc0/0xe0
[   54.191719]        do_el0_svc+0x1c/0x28
[   54.195660]        el0_svc+0x58/0x114
[   54.199413]        el0t_64_sync_handler+0x100/0x12c
[   54.204403]        el0t_64_sync+0x190/0x194
[   54.208685]
[   54.208685] -> #1 (rtnl_mutex){+.+.}-{4:4}:
[   54.214515]        __mutex_lock+0xa0/0x7b0
[   54.218717]        mutex_lock_nested+0x24/0x30
[   54.223270]        rtnl_lock+0x1c/0x28
[   54.227115]        register_netdevice_notifier+0x38/0x12c
[   54.232640]        rtnetlink_init+0x2c/0x50c
[   54.237016]        netlink_proto_init+0x148/0x1e0
[   54.241832]        do_one_initcall+0x74/0x2f8
[   54.246287]        kernel_init_freeable+0x290/0x4d0
[   54.251278]        kernel_init+0x24/0x1dc
[   54.255389]        ret_from_fork+0x10/0x20
[   54.259581]
[   54.259581] -> #0 (pernet_ops_rwsem){+.+.}-{4:4}:
[   54.265943]        __lock_acquire+0x1358/0x1f64
[   54.270578]        lock_acquire+0x1ec/0x30c
[   54.274860]        down_write+0x5c/0x120
[   54.278893]        register_netdevice_notifier+0x30/0x12c
[   54.284426]        netdev_trig_activate+0x178/0x1dc
[   54.289418]        led_trigger_set+0x130/0x260
[   54.293978]        led_trigger_write+0x10c/0x14c
[   54.298709]        sysfs_kf_bin_write+0x68/0x88
[   54.303353]        kernfs_fop_write_iter+0x120/0x1b0
[   54.308437]        vfs_write+0x194/0x2a8
[   54.312458]        ksys_write+0x6c/0x100
[   54.316477]        __arm64_sys_write+0x1c/0x28
[   54.321024]        invoke_syscall+0x48/0x114
[   54.325405]        el0_svc_common.constprop.0+0xc0/0xe0
[   54.330756]        do_el0_svc+0x1c/0x28
[   54.334695]        el0_svc+0x58/0x114
[   54.338451]        el0t_64_sync_handler+0x100/0x12c
[   54.343442]        el0t_64_sync+0x190/0x194
[   54.347721]
[   54.347721] other info that might help us debug this:
[   54.347721]
[   54.355873] Chain exists of:
[   54.355873]   pernet_ops_rwsem --> triggers_list_lock --> &led_cdev->trigger_lock
[   54.355873]
[   54.367981]  Possible unsafe locking scenario:
[   54.367981]
[   54.374013]        CPU0                    CPU1
[   54.378633]        ----                    ----
[   54.383251]   lock(&led_cdev->trigger_lock);
[   54.387629]                                lock(triggers_list_lock);
[   54.394126]                                lock(&led_cdev->trigger_lock);
[   54.401056]   lock(pernet_ops_rwsem);
[   54.404827]
[   54.404827]  *** DEADLOCK ***
[   54.404827]
[   54.410856] 6 locks held by sh/579:
[   54.414425]  #0: ffff00000549f418 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xa4/0x2a8
[   54.422598]  #1: ffff000007e90890 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf0/0x1b0
[   54.431637]  #2: ffff000004f69f28 (kn->active#39){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf8/0x1b0
[   54.440963]  #3: ffff000004f2df70 (&led_cdev->led_access){+.+.}-{4:4}, at: led_trigger_write+0x3c/0x14c
[   54.450629]  #4: ffff800082340c08 (triggers_list_lock){++++}-{4:4}, at: led_trigger_write+0x94/0x14c
[   54.460026]  #5: ffff000004f2de68 (&led_cdev->trigger_lock){+.+.}-{4:4}, at: led_trigger_write+0x100/0x14c
[   54.469953]
[   54.469953] stack backtrace:
[   54.474405] CPU: 1 PID: 579 Comm: sh Not tainted 6.5.0-11704-g3f86ed6ec0b3 #367
[   54.481865] Hardware name: Wolfvision ZynqMP PF4 (DT)
[   54.487012] Call trace:
[   54.489520]  dump_backtrace+0x98/0xf0
[   54.493276]  show_stack+0x18/0x24
[   54.496674]  dump_stack_lvl+0x60/0xac
[   54.500429]  dump_stack+0x18/0x24
[   54.503826]  print_circular_bug+0x284/0x364
[   54.508108]  check_noncircular+0x158/0x16c
[   54.512299]  __lock_acquire+0x1358/0x1f64
[   54.516405]  lock_acquire+0x1ec/0x30c
[   54.520158]  down_write+0x5c/0x120
[   54.523662]  register_netdevice_notifier+0x30/0x12c
[   54.528665]  netdev_trig_activate+0x178/0x1dc
[   54.533127]  led_trigger_set+0x130/0x260
[   54.537158]  led_trigger_write+0x10c/0x14c
[   54.541361]  sysfs_kf_bin_write+0x68/0x88
[   54.545474]  kernfs_fop_write_iter+0x120/0x1b0
[   54.550029]  vfs_write+0x194/0x2a8
[   54.553521]  ksys_write+0x6c/0x100
[   54.557008]  __arm64_sys_write+0x1c/0x28
[   54.561028]  invoke_syscall+0x48/0x114
[   54.564878]  el0_svc_common.constprop.0+0xc0/0xe0
[   54.569701]  do_el0_svc+0x1c/0x28
[   54.573110]  el0_svc+0x58/0x114
[   54.576337]  el0t_64_sync_handler+0x100/0x12c
[   54.580798]  el0t_64_sync+0x190/0x194

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

