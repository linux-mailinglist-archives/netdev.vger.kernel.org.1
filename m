Return-Path: <netdev+bounces-113884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB270940424
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541F11F216DC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C157CA6B;
	Tue, 30 Jul 2024 02:08:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 726D429CE7;
	Tue, 30 Jul 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305333; cv=none; b=tV9PduYQKy3G6msKcBROfOuRrZKagW/V9+d9JkZ88L7e1c/hXdHT6YOlEdAGmQD/Q5DwQxz7nTtu763mr12Lm+CHrSvQ5LaCFGBuDa/AWUHEDsQjNRY6WJXu+jB6Ef+E1urBQedrv+KDzEXV+sEZZNmX+gQp73r0IeM00NXzyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305333; c=relaxed/simple;
	bh=OGoaHfFu1F1RbEuq1dYgdxktXaHsVoK5PHFP+qY3hdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=fGgN6xQUpm/S2XhX1GMLYPN9B6tQzWw8s3HsYWI7t1KEqjvGt6HCI6KXlxpmPRG8OTII5JtUZUF+/7xuiLuJjAxFd3GS12h3ox2vlvc8ppP0Ak6CyIao08VDTfa9WKR4uNRFTFgB/c0h7Q4pdLlmxgda+aLRe8Zc7eFfOFUTE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.3])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id C24CA60108572;
	Tue, 30 Jul 2024 08:48:33 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.3
From: Youwan Wang <youwan@nfschina.com>
To: rmk+kernel@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [net-next,v3] net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend
Date: Tue, 30 Jul 2024 08:48:24 +0800
Message-Id: <20240730004824.660520-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240709113735.630583-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Add a function that phylib can inquire of the driver whether WoL
 has been enabled at the PHY.

 If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
 we cannot suspend the PHY. Although the WOL status has been
 checked in phy_suspend(), returning -EBUSY(-16) would cause
 the Power Management (PM) to fail to suspend. Since
 phy_suspend() is an exported symbol (EXPORT_SYMBOL),
 timely error reporting is needed. Therefore, an additional
 check is performed here. If the PHY of the mido bus is enabled
 with WOL, we skip calling phy_suspend() to avoid PM failure.

 Why is phydev->attached_dev NULL? Was a MAC never attached to the PHY?
 Has the MAC disconnected the PHY as part of the suspend? It would be
 odd that a device being used for WoL would disconnect the PHY.

 it has been observed that the phydev->attached_dev is NULL, phydev is
 "stmmac-0:01", it not attached, but it will affect suspend and resume.
 The actually attached "stmmac-0:00" will not dpm_run_callback():
 mdio_bus_phy_suspend().

 log:
 [    5.932502] YT8521 Gigabit Ethernet stmmac-0:00: attached PHY driver
 (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
 [    5.932512] YT8521 Gigabit Ethernet stmmac-0:01: attached PHY driver
 (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
 [   24.566289] YT8521 Gigabit Ethernet stmmac-0:00: yt8521_read_status,
 link down, media: UTP

 log:
 [  322.631362] OOM killer disabled.
 [  322.631364] Freezing remaining freezable tasks
 [  322.632536] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
 [  322.632540] printk: Suspending console(s) (use no_console_suspend to debug)
 [  322.633052] YT8521 Gigabit Ethernet stmmac-0:01:
 PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x110 [libphy] returns -16
 [  322.633071] YT8521 Gigabit Ethernet stmmac-0:01:
 PM: failed to suspend: error -16
 [  322.669699] PM: Some devices failed to suspend, or early wake event detected
 [  322.669949] OOM killer enabled.
 [  322.669951] Restarting tasks ... done.
 [  322.671008] random: crng reseeded on system resumption
 [  322.671014] PM: suspend exit

 If the YT8521 driver adds phydrv->flags, ask the YT8521 driver to process
 WOL at suspend and resume time, the phydev->suspended_by_mdio_bus=1
 flag would cause the resume failure.

 log:
 [  260.814763] YT8521 Gigabit Ethernet stmmac-0:01:
 PM: dpm_run_callback():mdio_bus_phy_resume+0x0/0x160 [libphy] returns -95
 [  260.814782] YT8521 Gigabit Ethernet stmmac-0:01:
 PM: failed to resume: error -95

 -95 is EOPNOTSUPP. Where is that coming from?

 yt8511_config_init() -> ret = -EOPNOTSUPP;

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/net/phy/phy_device.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..c3ad6f6791ff 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -268,6 +268,15 @@ static struct phy_driver genphy_driver;
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
+static bool phy_drv_wol_enabled(struct phy_device *phydev)
+{
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+
+	phy_ethtool_get_wol(phydev, &wol);
+
+	return wol.wolopts != 0;
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -277,6 +286,13 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!drv || !phydrv->suspend)
 		return false;
 
+	/* If the PHY on the mido bus is not attached but has WOL enabled
+	 * we cannot suspend the PHY.
+	 */
+	if (!netdev && phy_drv_wol_enabled(phydev) &&
+	    !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
+		return false;
+
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
@@ -1850,7 +1866,6 @@ EXPORT_SYMBOL(phy_detach);
 
 int phy_suspend(struct phy_device *phydev)
 {
-	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *netdev = phydev->attached_dev;
 	struct phy_driver *phydrv = phydev->drv;
 	int ret;
@@ -1858,8 +1873,7 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->suspended)
 		return 0;
 
-	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = phy_drv_wol_enabled(phydev) || (netdev && netdev->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
-- 
2.25.1


