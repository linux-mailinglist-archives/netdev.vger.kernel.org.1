Return-Path: <netdev+bounces-44657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011AB7D8F0B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D406FB2110D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351408F5B;
	Fri, 27 Oct 2023 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="p/vzyyew"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02A8F55
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:58:51 +0000 (UTC)
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 23:58:49 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D30116
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:58:48 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231027065744ba7cc1a472960badc7
        for <netdev@vger.kernel.org>;
        Fri, 27 Oct 2023 08:57:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=StlxXTJ9ndhwXG+eghED6C5pg72Yein/3cCWyyuaxMI=;
 b=p/vzyyew4+u6uQ1oMMtxKXwGJ2Y0L9LaIknrKiv9EbtxvXPk6TgP6ya1AATxfh7BsvuFKD
 elr5Z+fcX10yFI+t1gkVctAkdHMiufPwa+qVJJLeVIvy/NbwqSaoPFJgtvjdKIs8TC3fsPJq
 NMn3FRfDNY/JAhr81Qy+EvhZ9rc14=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Juergen Beisert <jbe@pengutronix.de>,
	Jerry Ray <jerry.ray@microchip.com>,
	Mans Rullgard <mans@mansr.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: lan9303: consequently nested-lock physical MDIO
Date: Fri, 27 Oct 2023 08:57:38 +0200
Message-ID: <20231027065741.534971-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

When LAN9303 is MDIO-connected two callchains exist into
mdio->bus->write():

1. switch ports 1&2 ("physical" PHYs):

virtual (switch-internal) MDIO bus (lan9303_switch_ops->phy_{read|write})->
  lan9303_mdio_phy_{read|write} -> mdiobus_{read|write}_nested

2. LAN9303 virtual PHY:

virtual MDIO bus (lan9303_phy_{read|write}) ->
  lan9303_virt_phy_reg_{read|write} -> regmap -> lan9303_mdio_{read|write}

If the latter functions just take
mutex_lock(&sw_dev->device->bus->mdio_lock) it triggers a LOCKDEP
false-positive splat. It's false-positive because the first
mdio_lock in the second callchain above belongs to virtual MDIO bus, the
second mdio_lock belongs to physical MDIO bus.

Consequent annotation in lan9303_mdio_{read|write} as nested lock
(similar to lan9303_mdio_phy_{read|write}, it's the same physical MDIO bus)
prevents the following splat:

WARNING: possible circular locking dependency detected
5.15.71 #1 Not tainted
------------------------------------------------------
kworker/u4:3/609 is trying to acquire lock:
ffff000011531c68 (lan9303_mdio:131:(&lan9303_mdio_regmap_config)->lock){+.+.}-{3:3}, at: regmap_lock_mutex
but task is already holding lock:
ffff0000114c44d8 (&bus->mdio_lock){+.+.}-{3:3}, at: mdiobus_read
which lock already depends on the new lock.
the existing dependency chain (in reverse order) is:
-> #1 (&bus->mdio_lock){+.+.}-{3:3}:
       lock_acquire
       __mutex_lock
       mutex_lock_nested
       lan9303_mdio_read
       _regmap_read
       regmap_read
       lan9303_probe
       lan9303_mdio_probe
       mdio_probe
       really_probe
       __driver_probe_device
       driver_probe_device
       __device_attach_driver
       bus_for_each_drv
       __device_attach
       device_initial_probe
       bus_probe_device
       deferred_probe_work_func
       process_one_work
       worker_thread
       kthread
       ret_from_fork
-> #0 (lan9303_mdio:131:(&lan9303_mdio_regmap_config)->lock){+.+.}-{3:3}:
       __lock_acquire
       lock_acquire.part.0
       lock_acquire
       __mutex_lock
       mutex_lock_nested
       regmap_lock_mutex
       regmap_read
       lan9303_phy_read
       dsa_slave_phy_read
       __mdiobus_read
       mdiobus_read
       get_phy_device
       mdiobus_scan
       __mdiobus_register
       dsa_register_switch
       lan9303_probe
       lan9303_mdio_probe
       mdio_probe
       really_probe
       __driver_probe_device
       driver_probe_device
       __device_attach_driver
       bus_for_each_drv
       __device_attach
       device_initial_probe
       bus_probe_device
       deferred_probe_work_func
       process_one_work
       worker_thread
       kthread
       ret_from_fork
other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&bus->mdio_lock);
                               lock(lan9303_mdio:131:(&lan9303_mdio_regmap_config)->lock);
                               lock(&bus->mdio_lock);
  lock(lan9303_mdio:131:(&lan9303_mdio_regmap_config)->lock);
*** DEADLOCK ***
5 locks held by kworker/u4:3/609:
 #0: ffff000002842938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work
 #1: ffff80000bacbd60 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work
 #2: ffff000007645178 (&dev->mutex){....}-{3:3}, at: __device_attach
 #3: ffff8000096e6e78 (dsa2_mutex){+.+.}-{3:3}, at: dsa_register_switch
 #4: ffff0000114c44d8 (&bus->mdio_lock){+.+.}-{3:3}, at: mdiobus_read
stack backtrace:
CPU: 1 PID: 609 Comm: kworker/u4:3 Not tainted 5.15.71 #1
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace
 show_stack
 dump_stack_lvl
 dump_stack
 print_circular_bug
 check_noncircular
 __lock_acquire
 lock_acquire.part.0
 lock_acquire
 __mutex_lock
 mutex_lock_nested
 regmap_lock_mutex
 regmap_read
 lan9303_phy_read
 dsa_slave_phy_read
 __mdiobus_read
 mdiobus_read
 get_phy_device
 mdiobus_scan
 __mdiobus_register
 dsa_register_switch
 lan9303_probe
 lan9303_mdio_probe
...

Cc: stable@vger.kernel.org
Fixes: dc7005831523 ("net: dsa: LAN9303: add MDIO managed mode support")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Tested with v5.15 vendor kernel, compiled against net-next/main
(cc54d2e2c58a). Affected code is unchanged since original introduction in
2017.

 drivers/net/dsa/lan9303_mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index d8ab2b77d201..167a86f39f27 100644
--- a/drivers/net/dsa/lan9303_mdio.c
+++ b/drivers/net/dsa/lan9303_mdio.c
@@ -32,7 +32,7 @@ static int lan9303_mdio_write(void *ctx, uint32_t reg, uint32_t val)
 	struct lan9303_mdio *sw_dev = (struct lan9303_mdio *)ctx;
 
 	reg <<= 2; /* reg num to offset */
-	mutex_lock(&sw_dev->device->bus->mdio_lock);
+	mutex_lock_nested(&sw_dev->device->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	lan9303_mdio_real_write(sw_dev->device, reg, val & 0xffff);
 	lan9303_mdio_real_write(sw_dev->device, reg + 2, (val >> 16) & 0xffff);
 	mutex_unlock(&sw_dev->device->bus->mdio_lock);
@@ -50,7 +50,7 @@ static int lan9303_mdio_read(void *ctx, uint32_t reg, uint32_t *val)
 	struct lan9303_mdio *sw_dev = (struct lan9303_mdio *)ctx;
 
 	reg <<= 2; /* reg num to offset */
-	mutex_lock(&sw_dev->device->bus->mdio_lock);
+	mutex_lock_nested(&sw_dev->device->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	*val = lan9303_mdio_real_read(sw_dev->device, reg);
 	*val |= (lan9303_mdio_real_read(sw_dev->device, reg + 2) << 16);
 	mutex_unlock(&sw_dev->device->bus->mdio_lock);
-- 
2.41.0


