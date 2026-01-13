Return-Path: <netdev+bounces-249306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F4D168C0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6B963048D80
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917534BA40;
	Tue, 13 Jan 2026 03:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61917346FC8;
	Tue, 13 Jan 2026 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275874; cv=none; b=HM1mGyqtXxzM1KVPV9NEtogIyB47fN4CgRcsK38S5qXJmADXsfZRWSW5e2nFtxLdWCYgooPpETgy3BjM58idVrZrQQo9ic6cm3b2YLvmt3aG7LYX0ck+fpgcZZN9NnGyVUceYEfXrXm28CmmBPX4HhFctm3yqLqeOhOb989W1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275874; c=relaxed/simple;
	bh=D6jaX+T2Ty56vMuNiH0I3jaW1WG0HYDH33ZQKrpxhXE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUMKd0EKD22EANNXUERf+2iWL2OzdlOllH39VK2bEvc3GqWkVa9b0QsTiIWFYL+BZx83voYM3rpRFxKha03enNQ2N3rdixShctLt9RfZYZxRaFHXguvtv4Rm4Ztr5gjp9mUe8VULtS2a+bs2YTB8iLTWpx3/wtIj+czU0FU+nds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfVKW-000000001VE-2FTY;
	Tue, 13 Jan 2026 03:44:28 +0000
Date: Tue, 13 Jan 2026 03:44:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Michael Klein <michael@fossekall.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] net: phy: realtek: reunify C22 and C45 drivers
Message-ID: <bffcb85fdc20e07056976962d3caaa1be5d0ddb0.1768275364.git.daniel@makrotopia.org>
References: <cover.1768275364.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768275364.git.daniel@makrotopia.org>

Reunify the split C22/C45 drivers for the RTL8221B-VB-CG 2.5Gbps and
RTL8221B-VM-CG 2.5Gbps PHYs back into a single driver.

This is possible now by using all the driver operations previously used
by the C45 driver, as transparent access to all MMDs including
MDIO_MMD_VEND2 is now possible also over Clause-22 MDIO.

The unified driver will still only use Clause-45 access on any Clause-45
capable busses while still working fine on Clause-22 busses.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: improve commit message

 drivers/net/phy/realtek/realtek_main.c | 72 ++++++--------------------
 1 file changed, 16 insertions(+), 56 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 74980b2d66157..4512fad3f64b8 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1880,28 +1880,18 @@ static int rtl8221b_match_phy_device(struct phy_device *phydev,
 	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
 }
 
-static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev,
-					       const struct phy_driver *phydrv)
+static int rtl8221b_vb_cg_match_phy_device(struct phy_device *phydev,
+					   const struct phy_driver *phydrv)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true) ||
+	       rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
 }
 
-static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev,
-					       const struct phy_driver *phydrv)
+static int rtl8221b_vm_cg_match_phy_device(struct phy_device *phydev,
+					   const struct phy_driver *phydrv)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
-}
-
-static int rtl8221b_vm_cg_c22_match_phy_device(struct phy_device *phydev,
-					       const struct phy_driver *phydrv)
-{
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, false);
-}
-
-static int rtl8221b_vm_cg_c45_match_phy_device(struct phy_device *phydev,
-					       const struct phy_driver *phydrv)
-{
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, true);
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, true) ||
+	       rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, false);
 }
 
 static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev,
@@ -2324,27 +2314,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_mmd	= rtl822xb_read_mmd,
 		.write_mmd	= rtl822xb_write_mmd,
 	}, {
-		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
-		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
-		.config_intr	= rtl8221b_config_intr,
-		.handle_interrupt = rtl8221b_handle_interrupt,
-		.probe		= rtl822x_probe,
-		.get_features	= rtl822x_get_features,
-		.config_aneg	= rtl822x_config_aneg,
-		.config_init	= rtl822xb_config_init,
-		.inband_caps	= rtl822x_inband_caps,
-		.config_inband	= rtl822x_config_inband,
-		.get_rate_matching = rtl822xb_get_rate_matching,
-		.read_status	= rtl822xb_read_status,
-		.suspend	= genphy_suspend,
-		.resume		= rtlgen_resume,
-		.read_page	= rtl821x_read_page,
-		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822xb_read_mmd,
-		.write_mmd	= rtl822xb_write_mmd,
-	}, {
-		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
-		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.match_phy_device = rtl8221b_vb_cg_match_phy_device,
+		.name		= "RTL8221B-VB-CG 2.5Gbps PHY",
 		.config_intr	= rtl8221b_config_intr,
 		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
@@ -2357,28 +2328,13 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtl822xb_c45_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtlgen_c45_resume,
-	}, {
-		.match_phy_device = rtl8221b_vm_cg_c22_match_phy_device,
-		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
-		.config_intr	= rtl8221b_config_intr,
-		.handle_interrupt = rtl8221b_handle_interrupt,
-		.probe		= rtl822x_probe,
-		.get_features	= rtl822x_get_features,
-		.config_aneg	= rtl822x_config_aneg,
-		.config_init	= rtl822xb_config_init,
-		.inband_caps	= rtl822x_inband_caps,
-		.config_inband	= rtl822x_config_inband,
-		.get_rate_matching = rtl822xb_get_rate_matching,
-		.read_status	= rtl822xb_read_status,
-		.suspend	= genphy_suspend,
-		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822xb_read_mmd,
 		.write_mmd	= rtl822xb_write_mmd,
 	}, {
-		.match_phy_device = rtl8221b_vm_cg_c45_match_phy_device,
-		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
+		.match_phy_device = rtl8221b_vm_cg_match_phy_device,
+		.name		= "RTL8221B-VM-CG 2.5Gbps PHY",
 		.config_intr	= rtl8221b_config_intr,
 		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
@@ -2391,6 +2347,10 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtl822xb_c45_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtlgen_c45_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		.match_phy_device = rtl8251b_c45_match_phy_device,
 		.name		= "RTL8251B 5Gbps PHY",
-- 
2.52.0

