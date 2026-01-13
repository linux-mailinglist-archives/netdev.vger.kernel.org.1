Return-Path: <netdev+bounces-249308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43602D168B7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 208EC3012AAF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929834C9A9;
	Tue, 13 Jan 2026 03:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD334B402;
	Tue, 13 Jan 2026 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275891; cv=none; b=r81GKGS72+/2F177yzJafhQrB2Egdj5JCUpOreoNvKQxqlUhyFqq6/Ch6Ffx8hyvYDLcA/hxEM2jeC1f/HX2A3/CJqAwlE1UFavpNTQ28b+YzdAxxvnPaHuTZUwxqeGyoZRlspiALg265tDf3/cfvxB+P+JkfoZ/jKMhHDMs+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275891; c=relaxed/simple;
	bh=NEAUdBrd7GLl5xTCc1kpmwGN5yG334eMqysWwH8Ip5w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKE9q0Xqv6dq/qcrXbubUB35PXNdllcThTO9+9RCrLLMBbvHwWElUbTd5sR2GqdYwnJGkN8LPHLZBPAhR+jg5TlxhmDi1O8gxoYfqDbDoskd/89ZHxDuO3//I4qQs1phZMS8mBVxI5hqiizkbJCuLzfviKH5yV7ToXMnDAmI7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfVKn-000000001WH-2Iy1;
	Tue, 13 Jan 2026 03:44:45 +0000
Date: Tue, 13 Jan 2026 03:44:42 +0000
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
Subject: [PATCH v2 5/5] net: phy: realtek: simplify bogus paged operations
Message-ID: <0c5cbb66ce3e72a011d76f8c3d61ebcac44483bb.1768275364.git.daniel@makrotopia.org>
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

Only registers 0x10~0x17 are affected by the value in the page
selection register 0x1f. Hence there is no point in using paged
operations when accessing any other registers.
Simplify the driver by using the normal phy_read and phy_write
operations for registers which are anyway not affected by paging.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/phy/realtek/realtek_main.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 8f1c8424e7f94..1b0d0602ee40d 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -68,7 +68,6 @@
 #define RTL8211E_DELAY_MASK			GENMASK(13, 11)
 
 /* RTL8211F PHY configuration */
-#define RTL8211F_PHYCR_PAGE			0xa43
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_ALDPS_PLL_OFF			BIT(1)
 #define RTL8211F_ALDPS_ENABLE			BIT(2)
@@ -78,7 +77,6 @@
 #define RTL8211F_CLKOUT_EN			BIT(0)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
 
-#define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
 /* RTL8211F LED configuration */
@@ -333,7 +331,7 @@ static int rtl8211f_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+	err = phy_read(phydev, RTL8211F_INSR);
 
 	return (err < 0) ? err : 0;
 }
@@ -479,7 +477,7 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
 {
 	int irq_status;
 
-	irq_status = phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+	irq_status = phy_read(phydev, RTL8211F_INSR);
 	if (irq_status < 0) {
 		phy_error(phydev);
 		return IRQ_NONE;
@@ -670,8 +668,8 @@ static int rtl8211f_config_clk_out(struct phy_device *phydev)
 				       RTL8211FVD_CLKOUT_REG,
 				       RTL8211FVD_CLKOUT_EN, 0);
 	else
-		ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-				       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
+		ret = phy_modify(phydev, RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
+				 0);
 	if (ret)
 		return ret;
 
@@ -696,15 +694,14 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
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
@@ -770,7 +767,7 @@ static int rtl8211f_suspend(struct phy_device *phydev)
 			goto err;
 
 		/* Read the INSR to clear any pending interrupt */
-		phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
+		phy_read(phydev, RTL8211F_INSR);
 
 		/* Reset the WoL to ensure that an event is picked up.
 		 * Unless we do this, even if we receive another packet,
-- 
2.52.0

