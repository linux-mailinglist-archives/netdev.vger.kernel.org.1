Return-Path: <netdev+bounces-114447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF85942A0A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0198CB236FD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3B1AAE3E;
	Wed, 31 Jul 2024 09:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1B8C618B04;
	Wed, 31 Jul 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417368; cv=none; b=Sd4uIiKYi2cF++8jY2u13wb917PprSv3rZB/+sRhmhj/EKD+8A85DxDwUUnwxIhoby/L2mAWLnHo+3azBsj3bd2DhSSb4oI42tWtOLnwOZYIqrEzBPhMMEpi96LkdZWGrgyqP+ElS5/MSioR+1GIe6u0CQePOM1INymn9Uq5W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417368; c=relaxed/simple;
	bh=XlHX40UfltCi30+lIask3v2Ve30eJqGeq0QdnxbKbPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=qln6voaLg3ONO3hE0HfDlv3jvWcpsxvXGJCvv9cUXEHCEViMWs3DN+cLTdoETND3jCjYHhEs296ZpKtkK6k7XX2K3mJfzYELCMXYmzXIN/ZmjK3fyA9hjHzwtdHTJTEt/XipXJsAZLylWfZyjeBKSzNjVhPzUmLShsJdL5c24Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 0012F6022F61E;
	Wed, 31 Jul 2024 17:15:45 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	youwan@nfschina.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [net-next,v4] net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend
Date: Wed, 31 Jul 2024 17:15:37 +0800
Message-Id: <20240731091537.771391-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZqdM1rwbmIED/0WC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
we cannot suspend the PHY. Although the WOL status has been
checked in phy_suspend(), returning -EBUSY(-16) would cause
the Power Management (PM) to fail to suspend. Since
phy_suspend() is an exported symbol (EXPORT_SYMBOL),
timely error reporting is needed. Therefore, an additional
check is performed here. If the PHY of the mido bus is enabled
with WOL, we skip calling phy_suspend() to avoid PM failure.

From the following logs, it has been observed that the phydev->attached_dev
is NULL, phydev is "stmmac-0:01", it not attached, but it will affect suspend
and resume.The actually attached "stmmac-0:00" will not dpm_run_callback():
mdio_bus_phy_suspend().

init log:
[    5.932502] YT8521 Gigabit Ethernet stmmac-0:00: attached PHY driver
(mii_bus:phy_addr=stmmac-0:00, irq=POLL)
[    5.932512] YT8521 Gigabit Ethernet stmmac-0:01: attached PHY driver
(mii_bus:phy_addr=stmmac-0:01, irq=POLL)
[   24.566289] YT8521 Gigabit Ethernet stmmac-0:00: yt8521_read_status,
link down, media: UTP

suspend log:
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

Add a function that phylib can inquire of the driver whether WoL
has been enabled at the PHY.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Youwan Wang <youwan@nfschina.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/phy/phy_device.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7752e9386b40..34752a87f98f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -279,6 +279,15 @@ static struct phy_driver genphy_driver;
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
@@ -288,6 +297,12 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!drv || !phydrv->suspend)
 		return false;
 
+	/* If the PHY on the mido bus is not attached but has WOL enabled
+	 * we cannot suspend the PHY.
+	 */
+	if (!netdev && phy_drv_wol_enabled(phydev))
+		return false;
+
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
@@ -1975,7 +1990,6 @@ EXPORT_SYMBOL(phy_detach);
 
 int phy_suspend(struct phy_device *phydev)
 {
-	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *netdev = phydev->attached_dev;
 	const struct phy_driver *phydrv = phydev->drv;
 	int ret;
@@ -1983,8 +1997,7 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->suspended || !phydrv)
 		return 0;
 
-	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts ||
+	phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
 			      (netdev && netdev->ethtool->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
-- 
2.25.1


