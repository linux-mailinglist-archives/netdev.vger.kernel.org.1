Return-Path: <netdev+bounces-165946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1750DA33C71
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FF83ABB0E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17562153ED;
	Thu, 13 Feb 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HysC6Nio"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4B2147FC;
	Thu, 13 Feb 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441788; cv=none; b=fiY0Af9yQv9J+L7cwn31JvNXIFQ0lqT70bW+m4GJ6X0AiqVF+Fk4KfKdirbM9Hnntqbl7J7dR8lJqCDSW3ICjZhwiEe5Q7LH4DPbFpp0UJ1RySVTUmIBsAVoUYampzJs35j1cLcj7ddfb6ArFgn5FEZHtSXLYjRr5XWo/ctpUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441788; c=relaxed/simple;
	bh=9lETPVo88vO01XtXfb0NXCceWEqn5Uv6ZSNkYCYNACs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AADjnOb0Cdoo6zLUk9Pc0py1liW+0qn9HOf21bP8x6Iy3Yy0nSR5afqhtNp8EvVY1cGNRElTgqv/wwQpht+H8gkR5NgOuNZ+mGU9f6IGoM0JNl+argox7wVs8pAaxcHOHnEP3HKs7R6mNKtmZgg7l6hgWzOkHLiVWoj62+w2EBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HysC6Nio; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 141054420D;
	Thu, 13 Feb 2025 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739441784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XvcDUqW+6V7sJ+NQgmk7dIFwTVv6TEBC2sY3q1Qe8Cc=;
	b=HysC6NioX+wT7UkkDVAshTphrIfXNt2x+5k2pzpSGOnvu71kYE6+675PlPp098oBt3QGdi
	SJ9QvyJVMzHIG+lE+xIzhi5AjWGINcgg4AwnD8Qsvptgq1LUYwOZ4N19EUEvizAAU2fZbL
	2w0fBTAe8M4xDWF8rsgJVghCGIkyy6ZB8oKfBb1g95dbkT2Dbirx3aHRP1ldfNz1uDN3LB
	qoUvzxdnoK7JTtp+TYDN0DjdMKl3m3ozRVVVLRmz/fgaWippD1IV1c2H35xC9c+o4yyT0L
	ShGWMT1/N8HN0FkMn7fSY+1TKgOWHvDNs28+/sKRHALvt93//23tJbcKZMeZqA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH net-next v4 08/15] net: phy: marvell: Support SFP through phy_port interface
Date: Thu, 13 Feb 2025 11:15:56 +0100
Message-ID: <20250213101606.1154014-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213101606.1154014-1-maxime.chevallier@bootlin.com>
References: <20250213101606.1154014-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Convert the Marvell driver (especially the 88e1512 driver) to use the
phy_port interface to handle SFPs. This means registering a
.attach_port() handler to detect when a serdes line interface is used
(most likely, and SFP module).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: no changes

 drivers/net/phy/marvell.c | 100 +++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 61 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index dd254e36ca8a..152cd602174f 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -29,10 +29,10 @@
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/phy.h>
+#include <linux/phy_port.h>
 #include <linux/marvell_phy.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
-#include <linux/sfp.h>
 
 #include <linux/io.h>
 #include <asm/irq.h>
@@ -3561,42 +3561,38 @@ static int marvell_probe(struct phy_device *phydev)
 	return marvell_hwmon_probe(phydev);
 }
 
-static int m88e1510_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+static int mv88e1510_port_configure_serdes(struct phy_port *port, bool enable,
+				    phy_interface_t interface)
 {
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
-	struct phy_device *phydev = upstream;
-	phy_interface_t interface;
+	struct phy_device *phydev = port_phydev(port);
 	struct device *dev;
 	int oldpage;
 	int ret = 0;
 	u16 mode;
 
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
-
 	dev = &phydev->mdio.dev;
 
-	sfp_parse_support(phydev->sfp_bus, id, supported, interfaces);
-	interface = sfp_select_interface(phydev->sfp_bus, supported);
-
-	dev_info(dev, "%s SFP module inserted\n", phy_modes(interface));
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_1000BASEX:
-		mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII_1000X;
+	if (enable) {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_1000BASEX:
+			mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII_1000X;
 
-		break;
-	case PHY_INTERFACE_MODE_100BASEX:
-		mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII_100FX;
+			break;
+		case PHY_INTERFACE_MODE_100BASEX:
+			mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII_100FX;
 
-		break;
-	case PHY_INTERFACE_MODE_SGMII:
-		mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII_SGMII;
+			break;
+		case PHY_INTERFACE_MODE_SGMII:
+			mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII_SGMII;
 
-		break;
-	default:
-		dev_err(dev, "Incompatible SFP module inserted\n");
+			break;
+		default:
+			dev_err(dev, "Incompatible SFP module inserted\n");
 
-		return -EINVAL;
+			return -EINVAL;
+		}
+	} else {
+		mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII;
 	}
 
 	oldpage = phy_select_page(phydev, MII_MARVELL_MODE_PAGE);
@@ -3613,49 +3609,30 @@ static int m88e1510_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 
 error:
 	return phy_restore_page(phydev, oldpage, ret);
-}
-
-static void m88e1510_sfp_remove(void *upstream)
-{
-	struct phy_device *phydev = upstream;
-	int oldpage;
-	int ret = 0;
-
-	oldpage = phy_select_page(phydev, MII_MARVELL_MODE_PAGE);
-	if (oldpage < 0)
-		goto error;
-
-	ret = __phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1,
-			   MII_88E1510_GEN_CTRL_REG_1_MODE_MASK,
-			   MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII);
-	if (ret < 0)
-		goto error;
 
-	ret = __phy_set_bits(phydev, MII_88E1510_GEN_CTRL_REG_1,
-			     MII_88E1510_GEN_CTRL_REG_1_RESET);
-
-error:
-	phy_restore_page(phydev, oldpage, ret);
+	return 0;
 }
 
-static const struct sfp_upstream_ops m88e1510_sfp_ops = {
-	.module_insert = m88e1510_sfp_insert,
-	.module_remove = m88e1510_sfp_remove,
-	.attach = phy_sfp_attach,
-	.detach = phy_sfp_detach,
-	.connect_phy = phy_sfp_connect_phy,
-	.disconnect_phy = phy_sfp_disconnect_phy,
+static const struct phy_port_ops mv88e1510_serdes_port_ops = {
+	.configure_mii = mv88e1510_port_configure_serdes,
 };
 
-static int m88e1510_probe(struct phy_device *phydev)
+static int m88e1510_attach_port(struct phy_device *phy_device,
+				struct phy_port *port)
 {
-	int err;
+	/* For classic Copper operation, we don't have any port-specific
+	 * control to do.
+	 */
+	if (!port->is_serdes)
+		return 0;
 
-	err = marvell_probe(phydev);
-	if (err)
-		return err;
+	port->ops = &mv88e1510_serdes_port_ops;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII, port->interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, port->interfaces);
+	__set_bit(PHY_INTERFACE_MODE_100BASEX, port->interfaces);
 
-	return phy_sfp_probe(phydev, &m88e1510_sfp_ops);
+	return 0;
 }
 
 static struct phy_driver marvell_drivers[] = {
@@ -3915,7 +3892,7 @@ static struct phy_driver marvell_drivers[] = {
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
 		.features = PHY_GBIT_FIBRE_FEATURES,
 		.flags = PHY_POLL_CABLE_TEST,
-		.probe = m88e1510_probe,
+		.probe = marvell_probe,
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
@@ -3941,6 +3918,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		.attach_port = m88e1510_attach_port,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1540,
-- 
2.48.1


