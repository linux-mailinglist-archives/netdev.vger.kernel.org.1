Return-Path: <netdev+bounces-50110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCAC7F4A45
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C228138C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E64E1D6;
	Wed, 22 Nov 2023 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mGBhX0ij"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69212A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pRzk5SC69W/lqbUNrFI70himzKlPdzwX94w/3YVemlY=; b=mGBhX0ijFyL/UJnnK9Z4BXWVWA
	r0cBWLAZKpU5Kd8V1ApTi2FJ5BfCuu/q5rtUUJVz9burfdqqv/MECo6U9h8huVcnvWeVpj95BAFdw
	qd3+r4XbGJSHLfG1cG5hO6OhYkigcf2v1swoXLytGuq8L7Qpy5VUcWAQSRzDooJX+qJmNoPPPTfn0
	Fw1CsG8NA3MJre1GzUqXcQI8uSfMHBhGgQDuOtFNZcje/Naf0JT8sOIrfiuIwV3wHtq3jLBXifphG
	O1COyFOjwAc2AZhcH1Rief1+viloeLjZNZiXfB4AUSBM3bVpY5wKuIl/ZNZ/m/d5+W+2aNBLuCBFu
	xUnlVHRQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52158 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5pCE-0000Kf-0D;
	Wed, 22 Nov 2023 15:31:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5pCG-00DAH1-04; Wed, 22 Nov 2023 15:31:24 +0000
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Marek Beh__n" <kabel@kernel.org>
Subject: [PATCH RFC net-next 02/10] net: phy: marvell10g: table driven mactype
 decode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5pCG-00DAH1-04@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 22 Nov 2023 15:31:24 +0000

Replace the code-based mactype decode with a table driven approach.
This will allow us to fill in the possible_interfaces cleanly.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell10g.c | 197 +++++++++++++++++++++--------------
 1 file changed, 120 insertions(+), 77 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index d4bb90d76881..a880b3375dee 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -141,13 +141,21 @@ enum {
 	MV_V2_TEMP_UNKNOWN	= 0x9600, /* unknown function */
 };
 
+struct mv3310_mactype {
+	bool valid;
+	bool fixed_interface;
+	phy_interface_t interface_10g;
+};
+
 struct mv3310_chip {
 	bool (*has_downshift)(struct phy_device *phydev);
 	void (*init_supported_interfaces)(unsigned long *mask);
 	int (*get_mactype)(struct phy_device *phydev);
 	int (*set_mactype)(struct phy_device *phydev, int mactype);
 	int (*select_mactype)(unsigned long *interfaces);
-	int (*init_interface)(struct phy_device *phydev, int mactype);
+
+	const struct mv3310_mactype *mactypes;
+	size_t n_mactypes;
 
 #ifdef CONFIG_HWMON
 	int (*hwmon_read_temp_reg)(struct phy_device *phydev);
@@ -156,11 +164,10 @@ struct mv3310_chip {
 
 struct mv3310_priv {
 	DECLARE_BITMAP(supported_interfaces, PHY_INTERFACE_MODE_MAX);
+	const struct mv3310_mactype *mactype;
 
 	u32 firmware_ver;
 	bool has_downshift;
-	bool rate_match;
-	phy_interface_t const_interface;
 
 	struct device *hwmon_dev;
 	char *hwmon_name;
@@ -702,71 +709,99 @@ static int mv3310_select_mactype(unsigned long *interfaces)
 		return -1;
 }
 
-static int mv2110_init_interface(struct phy_device *phydev, int mactype)
-{
-	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
-
-	priv->rate_match = false;
-
-	if (mactype == MV_PMA_21X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH)
-		priv->rate_match = true;
-
-	if (mactype == MV_PMA_21X0_PORT_CTRL_MACTYPE_USXGMII)
-		priv->const_interface = PHY_INTERFACE_MODE_USXGMII;
-	else if (mactype == MV_PMA_21X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH)
-		priv->const_interface = PHY_INTERFACE_MODE_10GBASER;
-	else if (mactype == MV_PMA_21X0_PORT_CTRL_MACTYPE_5GBASER ||
-		 mactype == MV_PMA_21X0_PORT_CTRL_MACTYPE_5GBASER_NO_SGMII_AN)
-		priv->const_interface = PHY_INTERFACE_MODE_NA;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int mv3310_init_interface(struct phy_device *phydev, int mactype)
-{
-	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
-
-	priv->rate_match = false;
-
-	if (mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH ||
-	    mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI_RATE_MATCH ||
-	    mactype == MV_V2_3310_PORT_CTRL_MACTYPE_XAUI_RATE_MATCH)
-		priv->rate_match = true;
-
-	if (mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_USXGMII)
-		priv->const_interface = PHY_INTERFACE_MODE_USXGMII;
-	else if (mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH ||
-		 mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_NO_SGMII_AN ||
-		 mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER)
-		priv->const_interface = PHY_INTERFACE_MODE_10GBASER;
-	else if (mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI_RATE_MATCH ||
-		 mactype == MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI)
-		priv->const_interface = PHY_INTERFACE_MODE_RXAUI;
-	else if (mactype == MV_V2_3310_PORT_CTRL_MACTYPE_XAUI_RATE_MATCH ||
-		 mactype == MV_V2_3310_PORT_CTRL_MACTYPE_XAUI)
-		priv->const_interface = PHY_INTERFACE_MODE_XAUI;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int mv3340_init_interface(struct phy_device *phydev, int mactype)
-{
-	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
-	int err = 0;
-
-	priv->rate_match = false;
+static const struct mv3310_mactype mv2110_mactypes[] = {
+	[MV_PMA_21X0_PORT_CTRL_MACTYPE_USXGMII] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_USXGMII,
+	},
+	[MV_PMA_21X0_PORT_CTRL_MACTYPE_5GBASER] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_NA,
+	},
+	[MV_PMA_21X0_PORT_CTRL_MACTYPE_5GBASER_NO_SGMII_AN] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_NA,
+	},
+	[MV_PMA_21X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+};
 
-	if (mactype == MV_V2_3340_PORT_CTRL_MACTYPE_RXAUI_NO_SGMII_AN)
-		priv->const_interface = PHY_INTERFACE_MODE_RXAUI;
-	else
-		err = mv3310_init_interface(phydev, mactype);
+static const struct mv3310_mactype mv3310_mactypes[] = {
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_RXAUI,
+	},
+	[MV_V2_3310_PORT_CTRL_MACTYPE_XAUI_RATE_MATCH] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_XAUI,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI_RATE_MATCH] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_RXAUI,
+	},
+	[MV_V2_3310_PORT_CTRL_MACTYPE_XAUI] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_XAUI,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_NO_SGMII_AN] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_USXGMII] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_USXGMII,
+	},
+};
 
-	return err;
-}
+static const struct mv3310_mactype mv3340_mactypes[] = {
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_RXAUI,
+	},
+	[MV_V2_3340_PORT_CTRL_MACTYPE_RXAUI_NO_SGMII_AN] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_RXAUI,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI_RATE_MATCH] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_RXAUI,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_NO_SGMII_AN] = {
+		.valid = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_10GBASER,
+	},
+	[MV_V2_33X0_PORT_CTRL_MACTYPE_USXGMII] = {
+		.valid = true,
+		.fixed_interface = true,
+		.interface_10g = PHY_INTERFACE_MODE_USXGMII,
+	},
+};
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
@@ -803,12 +838,13 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (mactype < 0)
 		return mactype;
 
-	err = chip->init_interface(phydev, mactype);
-	if (err) {
+	if (mactype >= chip->n_mactypes || !chip->mactypes[mactype].valid) {
 		phydev_err(phydev, "MACTYPE configuration invalid\n");
-		return err;
+		return -EINVAL;
 	}
 
+	priv->mactype = &chip->mactypes[mactype];
+
 	/* Enable EDPD mode - saving 600mW */
 	err = mv3310_set_edpd(phydev, ETHTOOL_PHY_EDPD_DFLT_TX_MSECS);
 	if (err)
@@ -935,9 +971,8 @@ static void mv3310_update_interface(struct phy_device *phydev)
 	 *
 	 * In USXGMII mode the PHY interface mode is also fixed.
 	 */
-	if (priv->rate_match ||
-	    priv->const_interface == PHY_INTERFACE_MODE_USXGMII) {
-		phydev->interface = priv->const_interface;
+	if (priv->mactype->fixed_interface) {
+		phydev->interface = priv->mactype->interface_10g;
 		return;
 	}
 
@@ -949,7 +984,7 @@ static void mv3310_update_interface(struct phy_device *phydev)
 	 */
 	switch (phydev->speed) {
 	case SPEED_10000:
-		phydev->interface = priv->const_interface;
+		phydev->interface = priv->mactype->interface_10g;
 		break;
 	case SPEED_5000:
 		phydev->interface = PHY_INTERFACE_MODE_5GBASER;
@@ -1163,7 +1198,9 @@ static const struct mv3310_chip mv3310_type = {
 	.get_mactype = mv3310_get_mactype,
 	.set_mactype = mv3310_set_mactype,
 	.select_mactype = mv3310_select_mactype,
-	.init_interface = mv3310_init_interface,
+
+	.mactypes = mv3310_mactypes,
+	.n_mactypes = ARRAY_SIZE(mv3310_mactypes),
 
 #ifdef CONFIG_HWMON
 	.hwmon_read_temp_reg = mv3310_hwmon_read_temp_reg,
@@ -1176,7 +1213,9 @@ static const struct mv3310_chip mv3340_type = {
 	.get_mactype = mv3310_get_mactype,
 	.set_mactype = mv3310_set_mactype,
 	.select_mactype = mv3310_select_mactype,
-	.init_interface = mv3340_init_interface,
+
+	.mactypes = mv3340_mactypes,
+	.n_mactypes = ARRAY_SIZE(mv3340_mactypes),
 
 #ifdef CONFIG_HWMON
 	.hwmon_read_temp_reg = mv3310_hwmon_read_temp_reg,
@@ -1188,7 +1227,9 @@ static const struct mv3310_chip mv2110_type = {
 	.get_mactype = mv2110_get_mactype,
 	.set_mactype = mv2110_set_mactype,
 	.select_mactype = mv2110_select_mactype,
-	.init_interface = mv2110_init_interface,
+
+	.mactypes = mv2110_mactypes,
+	.n_mactypes = ARRAY_SIZE(mv2110_mactypes),
 
 #ifdef CONFIG_HWMON
 	.hwmon_read_temp_reg = mv2110_hwmon_read_temp_reg,
@@ -1200,7 +1241,9 @@ static const struct mv3310_chip mv2111_type = {
 	.get_mactype = mv2110_get_mactype,
 	.set_mactype = mv2110_set_mactype,
 	.select_mactype = mv2110_select_mactype,
-	.init_interface = mv2110_init_interface,
+
+	.mactypes = mv2110_mactypes,
+	.n_mactypes = ARRAY_SIZE(mv2110_mactypes),
 
 #ifdef CONFIG_HWMON
 	.hwmon_read_temp_reg = mv2110_hwmon_read_temp_reg,
-- 
2.30.2


