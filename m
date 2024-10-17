Return-Path: <netdev+bounces-136560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83B9A2174
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F64D289313
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C31D4609;
	Thu, 17 Oct 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kyLQvg/m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C41925B2
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165970; cv=none; b=DeyORGwYbtJKwJCwU/BL9B4Wkp83/ph7pcpElXpGlDD8BvDT9fQLsEpxj4ydiGKOnTLIp6gjobPdg4UNFaMRvAFVEBIwfEmRFe6l0vH4l7fW35F8kBqTM1rcw1Ct6ptMVLunxBvbdlcgMzhCqBqD+6HJvbNfjyKwsv0RWWbxIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165970; c=relaxed/simple;
	bh=zEIYKI6DPweVf+O4s//ilmaYcEEZaQIYc2uBvuevGGE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dxu8jhw3SxClY/T3hmUpsAwoCdLBxIY/mUH55GPGJr5D4m76QAKOo0xKAbl0SzHmiSl+ilCi5DLJAv/KLxf2QAY33gLaZYyI3QfRRAj132v6sQA+xNX5+vgkEof2OKJz7OpIaVvv3+zvPtWHDnKavELatEAkMnJFNkii12ouZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kyLQvg/m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i/EZgnM68cHwtEqYZmHM+ZM9Y9YSC9kevP/UprigDZE=; b=kyLQvg/m4IbUR+GngDFFBtqZwY
	eix0iLJpIJKnRk1MQ0L2tCJQjiSSvhDrnEvKBRsxdVJA+Wclw4lWHBxmG/svZ4P4ECgqvL/i8Go7Y
	+861ep3+HldZwGHMnetfz+egWEqyaM0HH+c5kxvESsJe5yTshTd0n8fZDVKMzw1lBCe6aEYcIfs36
	4+E89rmFobHftchoCsYpwq02Vb5tXCAb3ElzHUxY6RDWETUJ36cXfBqC2FxMYdBarZKl28GSqUjfL
	KgtvNdUM/SgT2MInNIFCCMvyG0dPJbnbvBebEdCdnRWD39kmUftvn3GJxAIWbBNvEg92R3xN7UTj8
	JFGJWqXg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37936 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P3X-0006Ua-1I;
	Thu, 17 Oct 2024 12:52:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P3X-000EJx-ES; Thu, 17 Oct 2024 12:52:39 +0100
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/7] net: pcs: xpcs: use generic register definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P3X-000EJx-ES@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:52:39 +0100

As a general policy, we refer our generic register definitions over
vendor specific definitions. In XPCS, it appears that the register
layout follows a BMCR, BMSR and ADVERTISE register definition. We
already refer to this BMCR register using several different macros
which is confusing.

Convert the following register definitions to generic versions:

DW_VR_MII_MMD_CTRL => MII_BMCR
MDIO_CTRL1 => MII_BMCR
AN_CL37_EN => BMCR_ANENABLE
SGMII_SPEED_SS6 => BMCR_SPEED1000
SGMII_SPEED_SS13 => BMCR_SPEED100
MDIO_CTRL1_RESET => BMCR_RESET

DW_VR_MII_MMD_STS => MII_BMSR
DW_VR_MII_MMD_STS_LINK_STS => BMSR_LSTATUS

DW_FULL_DUPLEX => ADVERTISE_1000XFULL
iDW_HALF_DUPLEX => ADVERTISE_1000XHALF

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 64 ++++++++++++++++++++------------------
 drivers/net/pcs/pcs-xpcs.h | 12 -------
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index c69421e80d19..a5e2d93db285 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -223,8 +223,8 @@ static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 	int ret, val;
 
 	ret = read_poll_timeout(xpcs_read, val,
-				val < 0 || !(val & MDIO_CTRL1_RESET),
-				50000, 600000, true, xpcs, dev, MDIO_CTRL1);
+				val < 0 || !(val & BMCR_RESET),
+				50000, 600000, true, xpcs, dev, MII_BMCR);
 	if (val < 0)
 		ret = val;
 
@@ -250,7 +250,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		return -EINVAL;
 	}
 
-	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
+	ret = xpcs_write(xpcs, dev, MII_BMCR, BMCR_RESET);
 	if (ret < 0)
 		return ret;
 
@@ -343,7 +343,7 @@ static void xpcs_config_usxgmii(struct dw_xpcs *xpcs, int speed)
 	if (ret < 0)
 		goto out;
 
-	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, DW_USXGMII_SS_MASK,
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, DW_USXGMII_SS_MASK,
 			  speed_sel | DW_USXGMII_FULL);
 	if (ret < 0)
 		goto out;
@@ -646,19 +646,21 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	 *    speed/duplex mode change by HW after SGMII AN complete)
 	 * 5) VR_MII_MMD_CTRL Bit(12) [AN_ENABLE] = 1b (Enable SGMII AN)
 	 *
+	 * Note that VR_MII_MMD_CTRL is MII_BMCR.
+	 *
 	 * Note: Since it is MAC side SGMII, there is no need to set
 	 *	 SR_MII_AN_ADV. MAC side SGMII receives AN Tx Config from
 	 *	 PHY about the link state change after C28 AN is completed
 	 *	 between PHY and Link Partner. There is also no need to
 	 *	 trigger AN restart for MAC-side SGMII.
 	 */
-	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL);
+	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
 	if (mdio_ctrl < 0)
 		return mdio_ctrl;
 
-	if (mdio_ctrl & AN_CL37_EN) {
-		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL,
-				 mdio_ctrl & ~AN_CL37_EN);
+	if (mdio_ctrl & BMCR_ANENABLE) {
+		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+				 mdio_ctrl & ~BMCR_ANENABLE);
 		if (ret < 0)
 			return ret;
 	}
@@ -696,8 +698,8 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 		return ret;
 
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
-		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL,
-				 mdio_ctrl | AN_CL37_EN);
+		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+				 mdio_ctrl | BMCR_ANENABLE);
 
 	return ret;
 }
@@ -715,14 +717,16 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 	 * be disabled first:-
 	 * 1) VR_MII_MMD_CTRL Bit(12)[AN_ENABLE] = 0b
 	 * 2) VR_MII_AN_CTRL Bit(2:1)[PCS_MODE] = 00b (1000BASE-X C37)
+	 *
+	 * Note that VR_MII_MMD_CTRL is MII_BMCR.
 	 */
-	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL);
+	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
 	if (mdio_ctrl < 0)
 		return mdio_ctrl;
 
-	if (mdio_ctrl & AN_CL37_EN) {
-		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL,
-				 mdio_ctrl & ~AN_CL37_EN);
+	if (mdio_ctrl & BMCR_ANENABLE) {
+		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+				 mdio_ctrl & ~BMCR_ANENABLE);
 		if (ret < 0)
 			return ret;
 	}
@@ -760,8 +764,8 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 		return ret;
 
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
-		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL,
-				 mdio_ctrl | AN_CL37_EN);
+		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+				 mdio_ctrl | BMCR_ANENABLE);
 		if (ret < 0)
 			return ret;
 	}
@@ -780,9 +784,9 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 	if (ret < 0)
 		return ret;
 
-	return xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL,
-			   AN_CL37_EN | SGMII_SPEED_SS6 | SGMII_SPEED_SS13,
-			   SGMII_SPEED_SS6);
+	return xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+			   BMCR_ANENABLE | BMCR_SPEED1000 | BMCR_SPEED100,
+			   BMCR_SPEED1000);
 }
 
 static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
@@ -972,14 +976,14 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 		state->link = true;
 
-		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1);
+		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
 		if (speed < 0)
 			return speed;
 
-		speed &= SGMII_SPEED_SS13 | SGMII_SPEED_SS6;
-		if (speed == SGMII_SPEED_SS6)
+		speed &= BMCR_SPEED100 | BMCR_SPEED1000;
+		if (speed == BMCR_SPEED1000)
 			state->speed = SPEED_1000;
-		else if (speed == SGMII_SPEED_SS13)
+		else if (speed == BMCR_SPEED100)
 			state->speed = SPEED_100;
 		else if (speed == 0)
 			state->speed = SPEED_10;
@@ -988,9 +992,9 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 		if (duplex < 0)
 			return duplex;
 
-		if (duplex & DW_FULL_DUPLEX)
+		if (duplex & ADVERTISE_1000XFULL)
 			state->duplex = DUPLEX_FULL;
-		else if (duplex & DW_HALF_DUPLEX)
+		else if (duplex & ADVERTISE_1000XHALF)
 			state->duplex = DUPLEX_HALF;
 
 		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
@@ -1039,13 +1043,13 @@ static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
 {
 	int ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
+	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMSR);
 	if (ret < 0) {
 		state->link = 0;
 		return ret;
 	}
 
-	state->link = !!(ret & DW_VR_MII_MMD_STS_LINK_STS);
+	state->link = !!(ret & BMSR_LSTATUS);
 	if (!state->link)
 		return 0;
 
@@ -1109,7 +1113,7 @@ static void xpcs_link_up_sgmii(struct dw_xpcs *xpcs, unsigned int neg_mode,
 		return;
 
 	val = mii_bmcr_encode_fixed(speed, duplex);
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, val);
+	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR, val);
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
@@ -1141,7 +1145,7 @@ static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
 		dev_err(&xpcs->mdiodev->dev, "%s: half duplex not supported\n",
 			__func__);
 
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, val);
+	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR, val);
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
@@ -1164,7 +1168,7 @@ static void xpcs_an_restart(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
-	xpcs_modify(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, BMCR_ANRESTART,
+	xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
 		    BMCR_ANRESTART);
 }
 
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 9a22eed4404d..adc5a0b3c883 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -54,9 +54,6 @@
 
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
-#define DW_VR_MII_MMD_CTRL		0x0000
-#define DW_VR_MII_MMD_STS		0x0001
-#define DW_VR_MII_MMD_STS_LINK_STS	BIT(2)
 #define DW_VR_MII_DIG_CTRL1		0x8000
 #define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_INTR_STS		0x8002
@@ -93,15 +90,6 @@
 #define DW_VR_MII_C37_ANSGM_SP_1000		0x2
 #define DW_VR_MII_C37_ANSGM_SP_LNKSTS		BIT(4)
 
-/* SR MII MMD Control defines */
-#define AN_CL37_EN			BIT(12)	/* Enable Clause 37 auto-nego */
-#define SGMII_SPEED_SS13		BIT(13)	/* SGMII speed along with SS6 */
-#define SGMII_SPEED_SS6			BIT(6)	/* SGMII speed along with SS13 */
-
-/* SR MII MMD AN Advertisement defines */
-#define DW_HALF_DUPLEX			BIT(6)
-#define DW_FULL_DUPLEX			BIT(5)
-
 /* VR MII EEE Control 0 defines */
 #define DW_VR_MII_EEE_LTX_EN			BIT(0)  /* LPI Tx Enable */
 #define DW_VR_MII_EEE_LRX_EN			BIT(1)  /* LPI Rx Enable */
-- 
2.30.2


