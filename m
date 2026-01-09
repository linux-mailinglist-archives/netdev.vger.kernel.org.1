Return-Path: <netdev+bounces-248323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470DD06E9A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F54300E011
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96823EAB7;
	Fri,  9 Jan 2026 03:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659C318149;
	Fri,  9 Jan 2026 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927822; cv=none; b=K721wNJueFwqTRQJtJ6jRxO5ZyRFyTxV2BcUfWwlX0CpKLr7E4Lhm+9N3iJLnHsnkuvK0gKmFyarh2txQ1bL5aHUaM8TBAP1SMn4iqktAvPjoiC3wB/oe2/Qpvo7gWbhbPSOlVPQqWsipTAx0onX02iV4BYlaQiU7oa1GNgKzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927822; c=relaxed/simple;
	bh=AgCN7syOW90clP7U8S/cgQlEmAQhvUDyxIvK7AStBss=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU1OwFRQtM0bZ58OpqqIGR8auuEsPzJS9kLQa/hoEtI9NBvF/eBLe9MmqN1WUkq28eNpLer75uNBKBdhFsuML9+KCuLXY3elXfx0a8V8hxprUwlfEmkhGsVpaiKqRCTH0TX3eXxw8JCANkLavOkgOZqqaXxFAq/P1z6dCUjv1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1ve2mm-000000005l8-1FSA;
	Fri, 09 Jan 2026 03:03:36 +0000
Date: Fri, 9 Jan 2026 03:03:33 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: phy: realtek: reunify C22 and C45 drivers
Message-ID: <d8d6265c1555ba2ce766a19a515511753ae208bd.1767926665.git.daniel@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767926665.git.daniel@makrotopia.org>

Reunify the split C22/C45 drivers for the RTL8221B-VB-CG 2.5Gbps and
RTL8221B-VM-CG 2.5Gbps PHYs back into a single driver.
This is possible now by using all the driver operations previously used
by the C45 driver, as transparent access to all MMDs including
MDIO_MMD_VEND2 is now possible also over Clause-22 MDIO.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 72 ++++++--------------------
 1 file changed, 16 insertions(+), 56 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 886694ff995f6..d07d60bc1ce34 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1879,28 +1879,18 @@ static int rtl8221b_match_phy_device(struct phy_device *phydev,
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
@@ -2284,27 +2274,8 @@ static struct phy_driver realtek_drvs[] = {
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
@@ -2317,28 +2288,13 @@ static struct phy_driver realtek_drvs[] = {
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
@@ -2351,6 +2307,10 @@ static struct phy_driver realtek_drvs[] = {
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

