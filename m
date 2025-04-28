Return-Path: <netdev+bounces-186438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39038A9F1AE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAA14600A7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB626A0DB;
	Mon, 28 Apr 2025 13:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1326D4C6
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845556; cv=none; b=W/oz5RNhCqbMm7KC2oE/1/mM5M3FtmbZ9HCXLaNwEfP9Li+t3AJ7qPvdTOEmRnnbNcSSlema/cLpPvvZc/VP/O2AzdUNnE0RTQ3NcsrFvPsLU8QiFV1oSlYQbh4UerXdUwy+fDA+5T4xzpM1dk9jdioqIA8olJKnfkpLVZl7sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845556; c=relaxed/simple;
	bh=CywE26rgas3evbSjo68DaIxIX7NCR5wqWdWiofqIa3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N00o5s4w7236qxDHct3qtOqA6qwm75oWjuklcfA+OWwQ4sIEI5QqlUVqqYoNf8lF6WLP3Dqbq8CiWJwaJG+lLKmqZKj1s+6M8eA0nVilfmZCsJV0eyNJVHtCxqLePBv1QUdL3vmPAvssgpyJcdCpYYPsqtlntdEnC0qZiIZTl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB7-0000MT-L6; Mon, 28 Apr 2025 15:05:45 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-0006FN-0e;
	Mon, 28 Apr 2025 15:05:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-00GJ7t-0N;
	Mon, 28 Apr 2025 15:05:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v7 04/12] net: usb: lan78xx: move LED DT configuration to helper
Date: Mon, 28 Apr 2025 15:05:34 +0200
Message-Id: <20250428130542.3879769-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428130542.3879769-1-o.rempel@pengutronix.de>
References: <20250428130542.3879769-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Extract the LED enable logic based on the "microchip,led-modes"
property into a new helper function lan78xx_configure_leds_from_dt().

This simplifies lan78xx_phy_init() and improves modularity.
No functional changes intended.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- this patch is added in v6
---
 drivers/net/usb/lan78xx.c | 72 +++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 7f1ecc415d53..07530eef82cb 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2649,6 +2649,49 @@ static int lan78xx_mac_prepare_for_phy(struct lan78xx_net *dev)
 	return 0;
 }
 
+/**
+ * lan78xx_configure_leds_from_dt() - Configure LED enables based on DT
+ * @dev: LAN78xx device
+ * @phydev: PHY device (must be valid)
+ *
+ * Reads "microchip,led-modes" property from the PHY's DT node and enables
+ * the corresponding number of LEDs by writing to HW_CFG.
+ *
+ * This helper preserves the original logic, enabling up to 4 LEDs.
+ * If the property is not present, this function does nothing.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+static int lan78xx_configure_leds_from_dt(struct lan78xx_net *dev,
+					  struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u32 reg;
+	int len, ret;
+
+	if (!np)
+		return 0;
+
+	len = of_property_count_elems_of_size(np, "microchip,led-modes",
+					      sizeof(u32));
+	if (len < 0)
+		return 0;
+
+	ret = lan78xx_read_reg(dev, HW_CFG, &reg);
+	if (ret < 0)
+		return ret;
+
+	reg &= ~(HW_CFG_LED0_EN_ | HW_CFG_LED1_EN_ |
+		 HW_CFG_LED2_EN_ | HW_CFG_LED3_EN_);
+
+	reg |= (len > 0) * HW_CFG_LED0_EN_ |
+	       (len > 1) * HW_CFG_LED1_EN_ |
+	       (len > 2) * HW_CFG_LED2_EN_ |
+	       (len > 3) * HW_CFG_LED3_EN_;
+
+	return lan78xx_write_reg(dev, HW_CFG, reg);
+}
+
 static int lan78xx_phy_init(struct lan78xx_net *dev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(fc) = { 0, };
@@ -2704,32 +2747,9 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	phy_support_eee(phydev);
 
-	if (phydev->mdio.dev.of_node) {
-		u32 reg;
-		int len;
-
-		len = of_property_count_elems_of_size(phydev->mdio.dev.of_node,
-						      "microchip,led-modes",
-						      sizeof(u32));
-		if (len >= 0) {
-			/* Ensure the appropriate LEDs are enabled */
-			ret = lan78xx_read_reg(dev, HW_CFG, &reg);
-			if (ret < 0)
-				return ret;
-
-			reg &= ~(HW_CFG_LED0_EN_ |
-				 HW_CFG_LED1_EN_ |
-				 HW_CFG_LED2_EN_ |
-				 HW_CFG_LED3_EN_);
-			reg |= (len > 0) * HW_CFG_LED0_EN_ |
-				(len > 1) * HW_CFG_LED1_EN_ |
-				(len > 2) * HW_CFG_LED2_EN_ |
-				(len > 3) * HW_CFG_LED3_EN_;
-			ret = lan78xx_write_reg(dev, HW_CFG, reg);
-			if (ret < 0)
-				return ret;
-		}
-	}
+	ret = lan78xx_configure_leds_from_dt(dev, phydev);
+	if (ret)
+		goto free_phy;
 
 	genphy_config_aneg(phydev);
 
-- 
2.39.5


