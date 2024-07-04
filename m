Return-Path: <netdev+bounces-109213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEAD927616
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0692B1F2412A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAD1AE861;
	Thu,  4 Jul 2024 12:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AD62A1822FB;
	Thu,  4 Jul 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096354; cv=none; b=galaTWH1VeP2QfMru8W3lsqBgVsifjJlPARstgQccp30t3Y2i++yeloW5/pkx7vMr8HJ+NaDewUOtmQzdrCQ+BRqq7AYh5DRVrRTBNAmdb5BL/XVMH+JEskyCQmNwZ5lEdW34EDOLhjLzLujj07u9vrYFviOmhinqZGdmPzsZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096354; c=relaxed/simple;
	bh=fqDu8pYK9AkqEy53xImbufF/zeWILv9N9MLM8NviZwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/y3/xo4RvG1oJh9hp/O2p0sSN0qTgXSZgkRVH3ggJ5cR5giLIthxcjeV/udDO7gDrX0UBPjs9Nwo4pbf1bvsdS0syfL0rX3lCiuMDC2XybEzJSyAt6R931ueCGsHzx2nT9PBsol19Otv156J41NlyQtd6r4YUTE2yrsoNJcSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.3])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 880BA606D1292;
	Thu,  4 Jul 2024 20:32:13 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.3
From: Youwan Wang <youwan@nfschina.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [net-next,v1] net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend
Date: Thu,  4 Jul 2024 20:32:00 +0800
Message-Id: <20240704123200.603654-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
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

Thank you all for your analysis.
I am using the Linux kernel version 6.6, the current system is
utilizing ACPI firmware. However, in terms of configuration,
the system only includes MAC layer configuration while lacking
PHY configuration. Furthermore, it has been observed that the
phydev->attached_dev is NULL, phydev is "stmmac-0:01", it not
attached, but it will affect suspend and resume. The actually
attached "stmmac-0:00" will not dpm_run_callback():
mdio_bus_phy_suspend().

The current modification is solely aimed at ensuring that PHY
have WOL enabled but are not attached are calling phy_suspend()

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

log:
[  260.814763] YT8521 Gigabit Ethernet stmmac-0:01:
PM: dpm_run_callback():mdio_bus_phy_resume+0x0/0x160 [libphy] returns -95
[  260.814782] YT8521 Gigabit Ethernet stmmac-0:01:
PM: failed to resume: error -95

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/net/phy/phy_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..0564decf701f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -270,6 +270,7 @@ static DEFINE_MUTEX(phy_fixup_lock);
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
 	struct net_device *netdev = phydev->attached_dev;
@@ -277,6 +278,15 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!drv || !phydrv->suspend)
 		return false;
 
+	/* If the PHY on the mido bus is not attached but has WOL enabled
+	 * we cannot suspend the PHY.
+	 */
+	phy_ethtool_get_wol(phydev, &wol);
+	phydev->wol_enabled = !!(wol.wolopts);
+	if (!netdev && phydev->wol_enabled &&
+	    !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
+		return false;
+
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
-- 
2.25.1


