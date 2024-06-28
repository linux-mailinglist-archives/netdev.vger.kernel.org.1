Return-Path: <netdev+bounces-107562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DF91B6A9
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F319B23B42
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 06:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5AD3FB88;
	Fri, 28 Jun 2024 06:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 529A752F7A;
	Fri, 28 Jun 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554646; cv=none; b=tpZBEv/J0rIH9Xp1f80PstMy5tKwTpGyNzqWxxze3Oiv9F81yXYNI1CKQxkJxSHdFKtU0tMv131T44FlLZn0FrjCb8jPy2NTkWio9igIHNj51ZlMuW3bA2wp/PzWbfeGqkQWeNFWz6qs8netm3uuctk3AnUtvq+tAlGwqHCMPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554646; c=relaxed/simple;
	bh=c//nUK97LhQ4i/gqtAJZzEghbJ3QsRwBqd/pKLM7OAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=me5c+KWPnx0PASd04coC4vebyfmByb5WujLDvAy92+VkyAlElFNzv8nbSXcByC+egO9QSbZIh8GEDp0dJeC69Nbo0txsU2+rNdWEcUZ44Ig+cSkgm9ttihy0xGIfgjrLLcfIFOfzccveR8PS+E+i/Oo73VBIzeol8Ka6WhAAsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 6725D612A4BD4;
	Fri, 28 Jun 2024 14:03:28 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
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
Subject: [PATCH] net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend
Date: Fri, 28 Jun 2024 14:03:18 +0800
Message-Id: <20240628060318.458925-1-youwan@nfschina.com>
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

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/net/phy/phy_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..c766130e2c41 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -270,6 +270,7 @@ static DEFINE_MUTEX(phy_fixup_lock);
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
 	struct net_device *netdev = phydev->attached_dev;
@@ -277,6 +278,14 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!drv || !phydrv->suspend)
 		return false;
 
+	/* If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
+	 * we cannot suspend the PHY.
+	 */
+	phy_ethtool_get_wol(phydev, &wol);
+	phydev->wol_enabled = !!(wol.wolopts);
+	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
+		return false;
+
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
-- 
2.25.1


