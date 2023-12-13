Return-Path: <netdev+bounces-56153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E447D80DFD4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E141C214E7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD27375;
	Tue, 12 Dec 2023 00:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CDB8;
	Mon, 11 Dec 2023 16:05:53 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rCqHJ-00020L-1F;
	Tue, 12 Dec 2023 00:05:38 +0000
Date: Tue, 12 Dec 2023 00:05:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Calling led_trigger_register() when attaching a PHY located on an SFP
module potentially (and practically) leads into a deadlock.
Fix this by not calling led_trigger_register() for PHYs localted on SFP
modules as such modules actually never got any LEDs.

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc4-next-20231208+ #0 Tainted: G           O
------------------------------------------------------
kworker/u8:2/43 is trying to acquire lock:
ffffffc08108c4e8 (triggers_list_lock){++++}-{3:3}, at: led_trigger_register+0x4c/0x1a8

but task is already holding lock:
ffffff80c5c6f318 (&sfp->sm_mutex){+.+.}-{3:3}, at: cleanup_module+0x2ba8/0x3120 [sfp]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (&sfp->sm_mutex){+.+.}-{3:3}:
       __mutex_lock+0x88/0x7a0
       mutex_lock_nested+0x20/0x28
       cleanup_module+0x2ae0/0x3120 [sfp]
       sfp_register_bus+0x5c/0x9c
       sfp_register_socket+0x48/0xd4
       cleanup_module+0x271c/0x3120 [sfp]
       platform_probe+0x64/0xb8
       really_probe+0x17c/0x3c0
       __driver_probe_device+0x78/0x164
       driver_probe_device+0x3c/0xd4
       __driver_attach+0xec/0x1f0
       bus_for_each_dev+0x60/0xa0
       driver_attach+0x20/0x28
       bus_add_driver+0x108/0x208
       driver_register+0x5c/0x118
       __platform_driver_register+0x24/0x2c
       init_module+0x28/0xa7c [sfp]
       do_one_initcall+0x70/0x2ec
       do_init_module+0x54/0x1e4
       load_module+0x1b78/0x1c8c
       __do_sys_init_module+0x1bc/0x2cc
       __arm64_sys_init_module+0x18/0x20
       invoke_syscall.constprop.0+0x4c/0xdc
       do_el0_svc+0x3c/0xbc
       el0_svc+0x34/0x80
       el0t_64_sync_handler+0xf8/0x124
       el0t_64_sync+0x150/0x154

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock+0x88/0x7a0
       mutex_lock_nested+0x20/0x28
       rtnl_lock+0x18/0x20
       set_device_name+0x30/0x130
       netdev_trig_activate+0x13c/0x1ac
       led_trigger_set+0x118/0x234
       led_trigger_write+0x104/0x17c
       sysfs_kf_bin_write+0x64/0x80
       kernfs_fop_write_iter+0x128/0x1b4
       vfs_write+0x178/0x2a4
       ksys_write+0x58/0xd4
       __arm64_sys_write+0x18/0x20
       invoke_syscall.constprop.0+0x4c/0xdc
       do_el0_svc+0x3c/0xbc
       el0_svc+0x34/0x80
       el0t_64_sync_handler+0xf8/0x124
       el0t_64_sync+0x150/0x154

-> #1 (&led_cdev->trigger_lock){++++}-{3:3}:
       down_write+0x4c/0x13c
       led_trigger_write+0xf8/0x17c
       sysfs_kf_bin_write+0x64/0x80
       kernfs_fop_write_iter+0x128/0x1b4
       vfs_write+0x178/0x2a4
       ksys_write+0x58/0xd4
       __arm64_sys_write+0x18/0x20
       invoke_syscall.constprop.0+0x4c/0xdc
       do_el0_svc+0x3c/0xbc
       el0_svc+0x34/0x80
       el0t_64_sync_handler+0xf8/0x124
       el0t_64_sync+0x150/0x154

-> #0 (triggers_list_lock){++++}-{3:3}:
       __lock_acquire+0x12a0/0x2014
       lock_acquire+0x100/0x2ac
       down_write+0x4c/0x13c
       led_trigger_register+0x4c/0x1a8
       phy_led_triggers_register+0x9c/0x214
       phy_attach_direct+0x154/0x36c
       phylink_attach_phy+0x30/0x60
       phylink_sfp_connect_phy+0x140/0x510
       sfp_add_phy+0x34/0x50
       init_module+0x15c/0xa7c [sfp]
       cleanup_module+0x1d94/0x3120 [sfp]
       cleanup_module+0x2bb4/0x3120 [sfp]
       process_one_work+0x1f8/0x4ec
       worker_thread+0x1e8/0x3d8
       kthread+0x104/0x110
       ret_from_fork+0x10/0x20

other info that might help us debug this:

Chain exists of:
  triggers_list_lock --> rtnl_mutex --> &sfp->sm_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sfp->sm_mutex);
                               lock(rtnl_mutex);
                               lock(&sfp->sm_mutex);
  lock(triggers_list_lock);

 *** DEADLOCK ***

4 locks held by kworker/u8:2/43:
 #0: ffffff80c000f938 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x150/0x4ec
 #1: ffffffc08214bde8 ((work_completion)(&(&sfp->timeout)->work)){+.+.}-{0:0}, at: process_one_work+0x150/0x4ec
 #2: ffffffc0810902f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x18/0x20
 #3: ffffff80c5c6f318 (&sfp->sm_mutex){+.+.}-{3:3}, at: cleanup_module+0x2ba8/0x3120 [sfp]

stack backtrace:
CPU: 0 PID: 43 Comm: kworker/u8:2 Tainted: G           O       6.7.0-rc4-next-20231208+ #0
Hardware name: Bananapi BPI-R4 (DT)
Workqueue: events_power_efficient cleanup_module [sfp]
Call trace:
 dump_backtrace+0xa8/0x10c
 show_stack+0x14/0x1c
 dump_stack_lvl+0x5c/0xa0
 dump_stack+0x14/0x1c
 print_circular_bug+0x328/0x430
 check_noncircular+0x124/0x134
 __lock_acquire+0x12a0/0x2014
 lock_acquire+0x100/0x2ac
 down_write+0x4c/0x13c
 led_trigger_register+0x4c/0x1a8
 phy_led_triggers_register+0x9c/0x214
 phy_attach_direct+0x154/0x36c
 phylink_attach_phy+0x30/0x60
 phylink_sfp_connect_phy+0x140/0x510
 sfp_add_phy+0x34/0x50
 init_module+0x15c/0xa7c [sfp]
 cleanup_module+0x1d94/0x3120 [sfp]
 cleanup_module+0x2bb4/0x3120 [sfp]
 process_one_work+0x1f8/0x4ec
 worker_thread+0x1e8/0x3d8
 kthread+0x104/0x110
 ret_from_fork+0x10/0x20

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phy_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d2caa89bf1fb8..08b87d7396eb9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1558,7 +1558,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		goto error;
 
 	phy_resume(phydev);
-	phy_led_triggers_register(phydev);
+	if (!phydev->is_on_sfp_module)
+		phy_led_triggers_register(phydev);
 
 	/**
 	 * If the external phy used by current mac interface is managed by
@@ -1827,7 +1828,8 @@ void phy_detach(struct phy_device *phydev)
 	}
 	phydev->phylink = NULL;
 
-	phy_led_triggers_unregister(phydev);
+	if (!phydev->is_on_sfp_module)
+		phy_led_triggers_unregister(phydev);
 
 	if (phydev->mdio.dev.driver)
 		module_put(phydev->mdio.dev.driver->owner);
-- 
2.43.0

