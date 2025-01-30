Return-Path: <netdev+bounces-161679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F274CA23349
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F2E1623D9
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C191F03C3;
	Thu, 30 Jan 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pAOGNf1x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949D17597;
	Thu, 30 Jan 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258973; cv=none; b=BeNXGev4Lx832K2lju/hPWwDLHBvKQNsVIO/8pDpODCB06WmtWUCwKLZfw8/KL02d04kS9+37La6uW7XH9WXi7kr454JMTwrvRKH6PRVCw26xsfv6mpBgQsPQr2o1ZxRYcy3F2rhrvySSU9rWAPmOOraSLuRZkL3zx8DXOgijRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258973; c=relaxed/simple;
	bh=owHGhlOxqkTJZf1QKp2zLFkv9bpKwBGaiiWtVHtyhuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVZ7wCGIxlIRSx7FduoOv9iOzyoy6vlSTwMT2ZRlmAWVFEukv4S+KDKvmXLEyhK3FhSkd3xiOu8mN5m92ZxsjjYDEvSFOUIn5OWsxFBYRy3wkOEGvTbyS3P9ljI20UMGa/2Tjp1IEAKhAdmh8cKzyPaTluelvwCaKB+am3mxALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pAOGNf1x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xasRZEja/joABEkMp98bjtx1gSYQAG+ohRktNZoL2vw=; b=pAOGNf1xfxkTbyoApyyRbDfzwb
	bM7Cxb4AHGNfMqMoMr3h2AGCgs8xtWfDH5dRjvQP8u1YVRhfqHblcg6ciXkf1trQwKNC/xPk3zcjh
	E6vkLZoLEn2aySQuEEvHcleEMEOgoI94h3wH3ITNDI6ly34tAqlNslSAx+mq3jANZzkMOPwCApztY
	2rcrq6gMPN3fjKSX0+9fldOThtJXOMJ0aM0i0TrK186i2+mHTOj9C+jnaGFgL3GqGopXiH7yu/9+B
	Vcu8oAYh4yfiX2S3xCo4Y4NSkxE+hc4vCkiueJCVT2KPmRRjsBrbcP2Ww8zGyo0EO+wYcAQ6IdZtn
	fyqYpsaw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdYYn-0004nx-15;
	Thu, 30 Jan 2025 17:42:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdYYj-0004wV-2A;
	Thu, 30 Jan 2025 17:42:33 +0000
Date: Thu, 30 Jan 2025 17:42:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5u6CajmOV6T1Tkv@shell.armlinux.org.uk>
References: <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <20250129230549.kwkcxdn62mghdlx3@skbuf>
 <Z5t0RvoUOhxqeh25@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dB35/U62McMbXIoP"
Content-Disposition: inline
In-Reply-To: <Z5t0RvoUOhxqeh25@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>


--dB35/U62McMbXIoP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2025 at 12:44:54PM +0000, Russell King (Oracle) wrote:
> @@ -1123,7 +1126,9 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
>  {
>  	int ret;
>  
> -	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED &&
> +	    !(interface == PHY_INTERFACE_MODE_SGMII &&
> +	      xpcs->sgmii_mode == )
                                  ^ DW_XPCS_SGMII_MODE_MAC_MANUAL

Not sure where that went. :(

>  		return;
>  
>  	if (interface == PHY_INTERFACE_MODE_1000BASEX) {

Note that with this change, we also need to change the xpcs_write() to
BMCR at the end of this function to xpcs_modify() so we don't clear the
AN-enable bit. It's also a good idea in general to only modify the bits
we need to modify.

New patch attached.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--dB35/U62McMbXIoP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-xpcs-add-support-for-manual-update-for-SGMII.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: xpcs: add support for manual update for SGMII

Older revisions of the XPCS IP do not support the MAC_AUTO_SW flag and
need the BMCR register updated with the speed information from the PHY.
Split the DW_XPCS_SGMII_MODE_MAC mode into _AUTO and _MANUAL variants,
where _AUTO mode means the update happens in hardware autonomously,
whereas the _MANUAL mode means that we need to update the BMCR register
when the link comes up.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 16 +++++++++++-----
 drivers/net/pcs/pcs-xpcs.h | 11 ++++++++---
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e7aad3c402a4..29269d5c5f3a 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -691,11 +691,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	mask = DW_VR_MII_DIG_CTRL1_2G5_EN | DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
 	switch (xpcs->sgmii_mode) {
-	case DW_XPCS_SGMII_MODE_MAC:
+	case DW_XPCS_SGMII_MODE_MAC_AUTO:
 		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 			val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 		break;
 
+	case DW_XPCS_SGMII_MODE_MAC_MANUAL:
+		break;
+
 	case DW_XPCS_SGMII_MODE_PHY_HW:
 		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
 		fallthrough;
@@ -1123,7 +1126,9 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 {
 	int ret;
 
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED &&
+	    !(interface == PHY_INTERFACE_MODE_SGMII &&
+	      xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC_MANUAL)
 		return;
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
@@ -1140,10 +1145,11 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 				__func__);
 	}
 
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
-			 mii_bmcr_encode_fixed(speed, duplex));
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+			  BMCR_SPEED1000 | BMCR_FULLDPLX | BMCR_SPEED100,
+			  mii_bmcr_encode_fixed(speed, duplex));
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
+		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_modify returned %pe\n",
 			__func__, ERR_PTR(ret));
 }
 
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 4bd6a82f1a18..be8fab40b012 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -112,8 +112,12 @@ enum dw_xpcs_sgmii_10_100 {
 };
 
 /* The SGMII mode:
- * DW_XPCS_SGMII_MODE_MAC: the XPCS acts as a MAC, reading and acknowledging
- * the config word.
+ * DW_XPCS_SGMII_MODE_MAC_AUTO: the XPCS acts as a MAC, accepting the
+ * parameters from the PHY end of the SGMII link and acknowledging the
+ * config word. The XPCS autonomously switches speed.
+ *
+ * DW_XPCS_SGMII_MODE_MAC_MANUAL: the XPCS acts as a MAC as above, but
+ * does not autonomously switch speed.
  *
  * DW_XPCS_SGMII_MODE_PHY_HW: the XPCS acts as a PHY, deriving the tx_config
  * bits 15 (link), 12 (duplex) and 11:10 (speed) from hardware inputs to the
@@ -125,7 +129,8 @@ enum dw_xpcs_sgmii_10_100 {
  * integration documentation states that MII_ADVERTISE must be written last.
  */
 enum dw_xpcs_sgmii_mode {
-	DW_XPCS_SGMII_MODE_MAC,		/* XPCS is MAC on SGMII */
+	DW_XPCS_SGMII_MODE_MAC_AUTO,	/* XPCS is MAC, auto update */
+	DW_XPCS_SGMII_MODE_MAC_MANUAL,	/* XPCS is MAC, manual update */
 	DW_XPCS_SGMII_MODE_PHY_HW,	/* XPCS is PHY, tx_config from hw */
 	DW_XPCS_SGMII_MODE_PHY_REG,	/* XPCS is PHY, tx_config from regs */
 };
-- 
2.30.2


--dB35/U62McMbXIoP--

