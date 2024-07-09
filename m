Return-Path: <netdev+bounces-110230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B764C92B871
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A63AB23A8B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0062149C79;
	Tue,  9 Jul 2024 11:38:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9E5CC1E522;
	Tue,  9 Jul 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525089; cv=none; b=GuxDigbkG0yRbjjAFFb4RUNSYo7/hKfgpvQbSViugW2eOUCTYLpmLWW2C9lVYYNESHOILp1mpmw1Mutd43mpvojVRPKGwzxc+DZon5pMJ86WhhPH/SKztvXZY4UpIHZSiyQYB+XKWkewt3hr34dFVSq7Y9DdIcTD4vs1H/mKZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525089; c=relaxed/simple;
	bh=yzbqRSzWb8fvXvy1Dgn9DHVf8RicMrJFrbyPqm3bJoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=cNKpRGDisNleVI5GWsZhIFLPsAGrp3hHOWMaGUDHeuM1bDo+AKxJQ74Qpj1l7Xsus7eIqmjwOYouJfxjJXfsT9VLTjCGfC8hCD2zmDSc+Vb+zbExccL5ZoJRq2VxyjYS3avBP371FHAoDrult1WxeYy3CiHCgRpkNdfmQ0l0S7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.4])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id D01A7606B6DA6;
	Tue,  9 Jul 2024 19:37:53 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.4
From: Youwan Wang <youwan@nfschina.com>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	youwan@nfschina.com
Subject: [net-next,v2] net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend
Date: Tue,  9 Jul 2024 19:37:35 +0800
Message-Id: <20240709113735.630583-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b61cae2b-6b94-465e-b4e4-6c220c6c66d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
>> we cannot suspend the PHY. Although the WOL status has been
>> checked in phy_suspend(), returning -EBUSY(-16) would cause
>> the Power Management (PM) to fail to suspend. Since
>> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
>> timely error reporting is needed. Therefore, an additional
>> check is performed here. If the PHY of the mido bus is enabled
>> with WOL, we skip calling phy_suspend() to avoid PM failure.
>>
>> Thank you all for your analysis.
>> I am using the Linux kernel version 6.6, the current system is
>> utilizing ACPI firmware. However, in terms of configuration,
>> the system only includes MAC layer configuration while lacking
>> PHY configuration. Furthermore, it has been observed that the
>> phydev->attached_dev is NULL
>>
>> Is it possible to add a judgment about netdev is NULL?
>> if (!netdev && phydev->wol_enabled &&
>>     !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))

>Comments like this should be placed below the --- so they don't make
>it into the commit message.

>Why is phydev->attached_dev NULL? Was a MAC never attached to the PHY?
>Has the MAC disconnected the PHY as part of the suspend? It would be
>odd that a device being used for WoL would disconnect the PHY.

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

>>
>> log:
>> [  322.631362] OOM killer disabled.
>> [  322.631364] Freezing remaining freezable tasks
>> [  322.632536] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [  322.632540] printk: Suspending console(s) (use no_console_suspend to debug)
>> [  322.633052] YT8521 Gigabit Ethernet stmmac-0:01:
>> PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x110 [libphy] returns -16
>> [  322.633071] YT8521 Gigabit Ethernet stmmac-0:01:
>> PM: failed to suspend: error -16
>> [  322.669699] PM: Some devices failed to suspend, or early wake event detected
>> [  322.669949] OOM killer enabled.
>> [  322.669951] Restarting tasks ... done.
>> [  322.671008] random: crng reseeded on system resumption
>> [  322.671014] PM: suspend exit
>>
>> If the YT8521 driver adds phydrv->flags, ask the YT8521 driver to process
>> WOL at suspend and resume time, the phydev->suspended_by_mdio_bus=1
>> flag would cause the resume failure.
>>
>> log:
>> [  260.814763] YT8521 Gigabit Ethernet stmmac-0:01:
>> PM: dpm_run_callback():mdio_bus_phy_resume+0x0/0x160 [libphy] returns -95
>> [  260.814782] YT8521 Gigabit Ethernet stmmac-0:01:
>> PM: failed to resume: error -95

>-95 is EOPNOTSUPP. Where is that coming from?

yt8511_config_init() -> ret = -EOPNOTSUPP;

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


