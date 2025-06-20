Return-Path: <netdev+bounces-199690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98769AE16B7
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096D51899F70
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7026E6F5;
	Fri, 20 Jun 2025 08:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D2246795
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409514; cv=none; b=thylfvwftwOfHy+BvpzRUSqnBNLRGAGTKPPGO2uPZ/i+fR7aZQ85WEpQaaYAe1YeEGG4KR8cqRYeNnapt/xBQHY0zWyAo51MlyHaDVMHMYMYX0mFyy+I0rkLJrxFcAJRDbaaSF7CZQo/qx6hUln244oq090rEQaQNGYesNAu268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409514; c=relaxed/simple;
	bh=fCuTA6LPdyrFAjMo1EhgMA4VBvcMEs7/AdDuWpFs4DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O1wT9H5BX41ChNNHOSndbu/39ZDJsB9ZtwhUBD8DKbI4Qs22cJoANP43MEVPIvok/ycsMHsbQPiH2tYjB84Qe7KkNCV8zbWVvY7eKA0a1BwyhZSkejaRtSiHLCLwQ6IOtHtTGt7/kP9ToxZ6ohF/w25Y4WwB8TWOBR3Lc2I4s8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uSXTO-0000IF-5M; Fri, 20 Jun 2025 10:51:46 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uSXTN-004QzW-28;
	Fri, 20 Jun 2025 10:51:45 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uSXTN-007nXi-1r;
	Fri, 20 Jun 2025 10:51:45 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v1 1/1] net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
Date: Fri, 20 Jun 2025 10:51:44 +0200
Message-Id: <20250620085144.1858723-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

A WARN may be triggered in __netif_napi_del_locked() during USB device
disconnect:

  WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350

This occurs because NAPI remains enabled when the device is unplugged and
teardown begins. While `napi_disable()` was previously called in the
`lan78xx_stop()` path, that function is not invoked on disconnect. Instead,
when using PHYLINK, the `mac_link_down()` callback is guaranteed to run
during disconnect, making it the correct place to disable NAPI.

Similarly, move `napi_enable()` to `mac_link_up()` to pair the lifecycle
with actual MAC state.

Full trace:
 lan78xx 1-1:1.0 enu1: Failed to read register index 0x000000c4. ret = -ENODEV
 lan78xx 1-1:1.0 enu1: Failed to set MAC down with error -ENODEV
 lan78xx 1-1:1.0 enu1: Link is Down
 lan78xx 1-1:1.0 enu1: Failed to read register index 0x00000120. ret = -ENODEV
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350
 Modules linked in: flexcan can_dev fuse
 CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.16.0-rc2-00624-ge926949dab03 #9 PREEMPT
 Hardware name: SKOV IMX8MP CPU revC - bd500 (DT)
 Workqueue: usb_hub_wq hub_event
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __netif_napi_del_locked+0x2b4/0x350
 lr : __netif_napi_del_locked+0x7c/0x350
 sp : ffffffc085b673c0
 x29: ffffffc085b673c0 x28: ffffff800b7f2000 x27: ffffff800b7f20d8
 x26: ffffff80110bcf58 x25: ffffff80110bd978 x24: 1ffffff0022179eb
 x23: ffffff80110bc000 x22: ffffff800b7f5000 x21: ffffff80110bc000
 x20: ffffff80110bcf38 x19: ffffff80110bcf28 x18: dfffffc000000000
 x17: ffffffc081578940 x16: ffffffc08284cee0 x15: 0000000000000028
 x14: 0000000000000006 x13: 0000000000040000 x12: ffffffb0022179e8
 x11: 1ffffff0022179e7 x10: ffffffb0022179e7 x9 : dfffffc000000000
 x8 : 0000004ffdde8619 x7 : ffffff80110bcf3f x6 : 0000000000000001
 x5 : ffffff80110bcf38 x4 : ffffff80110bcf38 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 1ffffff0022179e7 x0 : 0000000000000000
 Call trace:
  __netif_napi_del_locked+0x2b4/0x350 (P)
  lan78xx_disconnect+0xf4/0x360
  usb_unbind_interface+0x158/0x718
  device_remove+0x100/0x150
  device_release_driver_internal+0x308/0x478
  device_release_driver+0x1c/0x30
  bus_remove_device+0x1a8/0x368
  device_del+0x2e0/0x7b0
  usb_disable_device+0x244/0x540
  usb_disconnect+0x220/0x758
  hub_event+0x105c/0x35e0
  process_one_work+0x760/0x17b0
  worker_thread+0x768/0xce8
  kthread+0x3bc/0x690
  ret_from_fork+0x10/0x20
 irq event stamp: 211604
 hardirqs last  enabled at (211603): [<ffffffc0828cc9ec>] _raw_spin_unlock_irqrestore+0x84/0x98
 hardirqs last disabled at (211604): [<ffffffc0828a9a84>] el1_dbg+0x24/0x80
 softirqs last  enabled at (211296): [<ffffffc080095f10>] handle_softirqs+0x820/0xbc8
 softirqs last disabled at (210993): [<ffffffc080010288>] __do_softirq+0x18/0x20
 ---[ end trace 0000000000000000 ]---
 lan78xx 1-1:1.0 enu1: failed to kill vid 0081/0

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
This patch is intended for `net-next` since the issue existed before the
PHYLINK migration, but is more naturally and cleanly addressed now that
PHYLINK manages link state transitions.
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 565b9847e2ab..598fe0390112 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2281,6 +2281,7 @@ static void lan78xx_mac_link_down(struct phylink_config *config,
 	int ret;

 	netif_stop_queue(net);
+	napi_disable(&dev->napi);

 	/* MAC reset will not de-assert TXEN/RXEN, we need to stop them
 	 * manually before reset. TX and RX should be disabled before running
@@ -2505,6 +2506,7 @@ static void lan78xx_mac_link_up(struct phylink_config *config,
 	if (ret < 0)
 		goto link_up_fail;

+	napi_enable(&dev->napi);
 	netif_start_queue(net);

 	return;
@@ -3421,7 +3423,6 @@ static int lan78xx_open(struct net_device *net)

 	lan78xx_init_stats(dev);

-	napi_enable(&dev->napi);

 	set_bit(EVENT_DEV_OPEN, &dev->flags);

@@ -3494,7 +3495,6 @@ static int lan78xx_stop(struct net_device *net)
 		timer_delete_sync(&dev->stat_monitor);

 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
-	napi_disable(&dev->napi);

 	lan78xx_terminate_urbs(dev);

--
2.39.5


