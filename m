Return-Path: <netdev+bounces-248325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C08ABD06E8E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A858B303738D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446F2E7160;
	Fri,  9 Jan 2026 03:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAC3064A0;
	Fri,  9 Jan 2026 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927844; cv=none; b=pIPku4eX3BHT9GFZrG7FhKYh+anqWELkcTDRmxiOJvMxtE3k7xcqW1mTz1xiqIv9N9tXqF1TIi3Ka2R49DyucnzWop57XK6E06CW0eZp44IQS0yWUqXnysdrsdB9LYuhihp5FoH0yd73V9UUvQDP68gH24UWGtA38GYzZ+HbNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927844; c=relaxed/simple;
	bh=WzlgF0HbsNG48TpSAMxJTbYiUuyvClyfGICfhRLJfQQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7FK0eIK7jUN3lsMU8seMK1dOmydv3LW5yf4JD/XBSf3Bn8OquDAT4OHZPRKW9VlG265CzMuaxkpq1w6uyOBQilnecob/zJ2whKYYjDrwq7kLJCRziuCiwdmvn2OjrE8AweCXa3stPcdqo41wS77JlbeqjgUsmHMlhFzt/u1QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1ve2n8-000000005m1-2Aqa;
	Fri, 09 Jan 2026 03:03:58 +0000
Date: Fri, 9 Jan 2026 03:03:55 +0000
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
Subject: [PATCH net-next 5/5] net: phy: realtek: simplify bogus paged
 operations
Message-ID: <37d675ff02e38807edbd3940a3818478d0dd28ee.1767926665.git.daniel@makrotopia.org>
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

Only registers 0x10~0x17 are affected by the value in the page
selection register 0x1f. Hence there is no point in using paged
operations when accessing any other registers.
Simplify the driver by using the normal phy_read and phy_write
operations for registers which are anyway not affected by paging.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 5712372c71f91..e3687e4216052 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -67,7 +67,6 @@
 #define RTL8211E_DELAY_MASK			GENMASK(13, 11)
 
 /* RTL8211F PHY configuration */
-#define RTL8211F_PHYCR_PAGE			0xa43
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_ALDPS_PLL_OFF			BIT(1)
 #define RTL8211F_ALDPS_ENABLE			BIT(2)
@@ -77,7 +76,6 @@
 #define RTL8211F_CLKOUT_EN			BIT(0)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
 
-#define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
 /* RTL8211F LED configuration */
@@ -332,7 +330,7 @@ static int rtl8211f_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+	err = phy_read(phydev, RTL8211F_INSR);
 
 	return (err < 0) ? err : 0;
 }
@@ -478,7 +476,7 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
 {
 	int irq_status;
 
-	irq_status = phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+	irq_status = phy_read(phydev, RTL8211F_INSR);
 	if (irq_status < 0) {
 		phy_error(phydev);
 		return IRQ_NONE;
@@ -669,8 +667,8 @@ static int rtl8211f_config_clk_out(struct phy_device *phydev)
 				       RTL8211FVD_CLKOUT_REG,
 				       RTL8211FVD_CLKOUT_EN, 0);
 	else
-		ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-				       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
+		ret = phy_modify(phydev, RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
+				 0);
 	if (ret)
 		return ret;
 
@@ -695,15 +693,14 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
 	if (!priv->enable_aldps)
 		return 0;
 
-	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
-				mask, mask);
+	return phy_modify(phydev, RTL8211F_PHYCR1, mask, mask);
 }
 
 static int rtl8211f_config_phy_eee(struct phy_device *phydev)
 {
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
-	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
-				RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
+	return phy_modify(phydev, RTL8211F_PHYCR2,
+			  RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 }
 
 static int rtl8211f_config_init(struct phy_device *phydev)
@@ -769,7 +766,7 @@ static int rtl8211f_suspend(struct phy_device *phydev)
 			goto err;
 
 		/* Read the INSR to clear any pending interrupt */
-		phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+		phy_read(phydev, RTL8211F_INSR);
 
 		/* Reset the WoL to ensure that an event is picked up.
 		 * Unless we do this, even if we receive another packet,
-- 
2.52.0

