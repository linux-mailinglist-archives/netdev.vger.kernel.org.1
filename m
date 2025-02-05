Return-Path: <netdev+bounces-163001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C172A28BA5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80543A8991
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD57DA7F;
	Wed,  5 Feb 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iGJ7HndG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCF39FD9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762089; cv=none; b=T5fKuFQ8ljt3qN/sl8oItDTBafafOJmUwzyItK4ipOBwojp8evRvw0HfWBWimTWYcJvq3WN08PFYpulqXpktiLMkFU63g/jsPqs95V3664akEcT8xjaH/Vn5b0Os8lSnVxt0fJ4Kj1eYHfzZDp3AxDuaieQWzE2M0lA9RsRvAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762089; c=relaxed/simple;
	bh=3PlLJZcP8OC74HnXFAbpqQFRcrnglawnEr5vic3QM0k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bJdM051rlDuus3YCLgDA3pdqpbkmXlxsfSs0GAB6JCbWGL42DBqLl7EhGx3md8xOFD++DZFVpV6r93DDKmcA02zicS1FDUXwrs9SzJguf3G/0anKFirJ3NHP9JW5dY4WgcnXbRj3HdCbUiEhHgwKje/NbhR/qo8XWlLeFqdPHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iGJ7HndG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7HVaWmgGyyrOnAA9z5Exym6c5MEuksHf2VUJi83xjho=; b=iGJ7HndGlTuWJVn81BaJ+jGqAT
	1+F4thWrZfo/r1VmduhghWBdwaq3/cYxmLcy/v8z3ddJpWfeKnpj/58Okhiq6IZBLK0xyXS2EgCVb
	Bxa9OYxE/xVTOqfE4//lRXCB83E/UAZkBGnSyX2oASzGATQ7OdSIUtnlDrq1n74mIW2k6ybN9xqUy
	k6J1VNOOkf1uLdUM0X5lneyOgxOO88T0ekvr2ntMYkqIxRCimjdOkHmzyGdQoEfjE4xIEZaiqFc0Q
	tuQNQfRiV0HyL3/wVVfK14jIkVPcftgtnJtHlugnGM9RmqHHFoylulzCNnasW7TsqZzr3HtgTkRha
	M/zwZLmQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57970 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffRh-000777-30;
	Wed, 05 Feb 2025 13:28:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffRO-003Z5o-8u; Wed, 05 Feb 2025 13:27:42 +0000
In-Reply-To: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	 UNGLinuxDriver@microchip.com,
	 Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 3/4] net: xpcs: add SGMII MAC manual update mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffRO-003Z5o-8u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:27:42 +0000

Older revisions of the XPCS IP do not support the MAC_AUTO_SW flag and
need the BMCR register updated with the speed information from the PHY.
Split the DW_XPCS_SGMII_MODE_MAC mode into _AUTO and _MANUAL variants,
where _AUTO mode means the update happens in hardware autonomously,
whereas the _MANUAL mode means that we need to update the BMCR register
when the link comes up.

This will be required for the older XPCS IP found in KSZ9477.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This needs further input from Tristram Ha / Microchip to work out a way
to detect KSZ9477 and set DW_XPCS_SGMII_MODE_MAC_MANUAL. On its own,
this patch does nothing.
---
 drivers/net/pcs/pcs-xpcs.c | 19 +++++++++++++------
 drivers/net/pcs/pcs-xpcs.h | 11 ++++++++---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 9d54c04ef6ee..1eba0c583f16 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -706,7 +706,8 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 		break;
 	}
 
-	if (xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC)
+	if (xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC_AUTO ||
+	    xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC_MANUAL)
 		tx_conf = DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII;
 	else
 		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
@@ -721,11 +722,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
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
 		mask |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
 		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
@@ -1151,7 +1155,9 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 {
 	int ret;
 
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED &&
+	    !(interface == PHY_INTERFACE_MODE_SGMII &&
+	      xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC_MANUAL))
 		return;
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
@@ -1168,10 +1174,11 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
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
index 892b85425787..96117bd9e2b6 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -121,15 +121,20 @@ enum dw_xpcs_sgmii_10_100 {
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
  * XPCS.
  */
 enum dw_xpcs_sgmii_mode {
-	DW_XPCS_SGMII_MODE_MAC,		/* XPCS is MAC on SGMII */
+	DW_XPCS_SGMII_MODE_MAC_AUTO,	/* XPCS is MAC, auto update */
+	DW_XPCS_SGMII_MODE_MAC_MANUAL,	/* XPCS is MAC, manual update */
 	DW_XPCS_SGMII_MODE_PHY_HW,	/* XPCS is PHY, tx_config from hw */
 };
 
-- 
2.30.2


