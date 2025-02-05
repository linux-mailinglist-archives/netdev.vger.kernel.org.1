Return-Path: <netdev+bounces-162937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AABA2882B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406301679BE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5822AE65;
	Wed,  5 Feb 2025 10:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78622B5A3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751952; cv=none; b=Y1IoGEvJ0eDC1O2h5bsDxSJmwlKk3Z/Y3lsUh4ZTDtt1oc0PIkxQBNsOs0B1VAIc3ay9NU4aGtDdXBGoCkWjzr5VHUpihOaCj7OdeWWG5V39XZOW1BRw6t+6RLTkSplxry+XQnq9K/6cwzqwyXfVfJ1InUrG8Ym+2ajll3ycylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751952; c=relaxed/simple;
	bh=P0VU7UMU1X2gguhoQwApVSnZes7wcczyANucJcp6haI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XlH7Ciq3VrxsnFUgVfxk3WhYLEFujk7b0SIQDXrGsMZBD/DKjB63W/07RQErZRcXtrF0Rz3SirZA/UwaMIqEzKqAPgesxj4G7vRIfo0Opnov3Xg4Q3ume4CJWlEROeiB6IkwaqoqG5A8ErbVLED5TTz/1T56FUiQZWpUIY1sHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfcnx-0003EZ-3I; Wed, 05 Feb 2025 11:38:49 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfcnv-003cUo-1b;
	Wed, 05 Feb 2025 11:38:47 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfcnv-009XYV-1O;
	Wed, 05 Feb 2025 11:38:47 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 1/1] net: phy: dp83td510: introduce LED framework support
Date: Wed,  5 Feb 2025 11:38:46 +0100
Message-Id: <20250205103846.2273833-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

Add LED brightness, mode, HW control and polarity functions to enable
external LED control in the TI DP83TD510 PHY.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83td510.c | 187 ++++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index a42af9c168ec..23af1ac194fa 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -204,10 +204,191 @@ struct dp83td510_priv {
 #define DP83TD510E_UNKN_030E				0x30e
 #define DP83TD510E_030E_VAL				0x2520
 
+#define DP83TD510E_LEDS_CFG_1				0x460
+#define DP83TD510E_LED_FN(idx, val)		(((val) & 0xf) << ((idx) * 4))
+#define DP83TD510E_LED_FN_MASK(idx)			(0xf << ((idx) * 4))
+/* link OK */
+#define DP83TD510E_LED_MODE_LINK_OK			0x0
+/* TX/RX activity */
+#define DP83TD510E_LED_MODE_TX_RX_ACTIVITY		0x1
+/* TX activity */
+#define DP83TD510E_LED_MODE_TX_ACTIVITY			0x2
+/* RX activity */
+#define DP83TD510E_LED_MODE_RX_ACTIVITY			0x3
+/* LR */
+#define DP83TD510E_LED_MODE_LR				0x4
+/* SR */
+#define DP83TD510E_LED_MODE_SR				0x5
+/* LED SPEED: High for 10Base-T */
+#define DP83TD510E_LED_MODE_LED_SPEED			0x6
+/* Duplex mode */
+#define DP83TD510E_LED_MODE_DUPLEX			0x7
+/* link + blink on activity with stretch option */
+#define DP83TD510E_LED_MODE_LINK_BLINK			0x8
+/* blink on activity with stretch option */
+#define DP83TD510E_LED_MODE_BLINK_ACTIVITY		0x9
+/* blink on tx activity with stretch option */
+#define DP83TD510E_LED_MODE_BLINK_TX			0xa
+/* blink on rx activity with stretch option */
+#define DP83TD510E_LED_MODE_BLINK_RX			0xb
+/* link_lost */
+#define DP83TD510E_LED_MODE_LINK_LOST			0xc
+/* PRBS error: toggles on error */
+#define DP83TD510E_LED_MODE_PRBS_ERROR			0xd
+/* XMII TX/RX Error with stretch option */
+#define DP83TD510E_LED_MODE_XMII_ERR			0xe
+
+#define DP83TD510E_LED_COUNT				4
+
+#define DP83TD510E_LEDS_CFG_2				0x469
+#define DP83TD510E_LED_POLARITY(idx)			BIT((idx) * 4 + 2)
+#define DP83TD510E_LED_DRV_VAL(idx)			BIT((idx) * 4 + 1)
+#define DP83TD510E_LED_DRV_EN(idx)			BIT((idx) * 4)
+
 #define DP83TD510E_ALCD_STAT				0xa9f
 #define DP83TD510E_ALCD_COMPLETE			BIT(15)
 #define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
 
+static int dp83td510_led_brightness_set(struct phy_device *phydev, u8 index,
+					enum led_brightness brightness)
+{
+	u32 val;
+
+	if (index >= DP83TD510E_LED_COUNT)
+		return -EINVAL;
+
+	val = DP83TD510E_LED_DRV_EN(index);
+
+	if (brightness)
+		val |= DP83TD510E_LED_DRV_VAL(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_LEDS_CFG_2,
+			      DP83TD510E_LED_DRV_VAL(index) |
+			      DP83TD510E_LED_DRV_EN(index), val);
+}
+
+static int dp83td510_led_mode(u8 index, unsigned long rules)
+{
+	if (index >= DP83TD510E_LED_COUNT)
+		return -EINVAL;
+
+	switch (rules) {
+	case BIT(TRIGGER_NETDEV_LINK):
+		return DP83TD510E_LED_MODE_LINK_OK;
+	case BIT(TRIGGER_NETDEV_LINK_10):
+		return DP83TD510E_LED_MODE_LED_SPEED;
+	case BIT(TRIGGER_NETDEV_FULL_DUPLEX):
+		return DP83TD510E_LED_MODE_DUPLEX;
+	case BIT(TRIGGER_NETDEV_TX):
+		return DP83TD510E_LED_MODE_TX_ACTIVITY;
+	case BIT(TRIGGER_NETDEV_RX):
+		return DP83TD510E_LED_MODE_RX_ACTIVITY;
+	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return DP83TD510E_LED_MODE_TX_RX_ACTIVITY;
+	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
+			BIT(TRIGGER_NETDEV_RX):
+		return DP83TD510E_LED_MODE_LINK_BLINK;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int dp83td510_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					 unsigned long rules)
+{
+	int ret;
+
+	ret = dp83td510_led_mode(index, rules);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dp83td510_led_hw_control_set(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	int mode, ret;
+
+	mode = dp83td510_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_LEDS_CFG_1,
+			     DP83TD510E_LED_FN_MASK(index),
+			     DP83TD510E_LED_FN(index, mode));
+	if (ret)
+		return ret;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_LEDS_CFG_2,
+				DP83TD510E_LED_DRV_EN(index), 0);
+}
+
+static int dp83td510_led_hw_control_get(struct phy_device *phydev,
+					u8 index, unsigned long *rules)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_LEDS_CFG_1);
+	if (val < 0)
+		return val;
+
+	val &= DP83TD510E_LED_FN_MASK(index);
+	val >>= index * 4;
+
+	switch (val) {
+	case DP83TD510E_LED_MODE_LINK_OK:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+	/* LED mode: LED SPEED (10BaseT1L indicator) */
+	case DP83TD510E_LED_MODE_LED_SPEED:
+		*rules = BIT(TRIGGER_NETDEV_LINK_10);
+		break;
+	case DP83TD510E_LED_MODE_DUPLEX:
+		*rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX);
+		break;
+	case DP83TD510E_LED_MODE_TX_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_TX);
+		break;
+	case DP83TD510E_LED_MODE_RX_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_RX);
+		break;
+	case DP83TD510E_LED_MODE_TX_RX_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+		break;
+	case DP83TD510E_LED_MODE_LINK_BLINK:
+		*rules = BIT(TRIGGER_NETDEV_LINK) |
+			 BIT(TRIGGER_NETDEV_TX) |
+			 BIT(TRIGGER_NETDEV_RX);
+		break;
+	default:
+		*rules = 0;
+		break;
+	}
+
+	return 0;
+}
+
+static int dp83td510_led_polarity_set(struct phy_device *phydev, int index,
+				      unsigned long modes)
+{
+	u16 polarity = DP83TD510E_LED_POLARITY(index);
+	u32 mode;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			polarity = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_LEDS_CFG_2,
+			      DP83TD510E_LED_POLARITY(index), polarity);
+}
+
 /**
  * dp83td510_update_stats - Update the PHY statistics for the DP83TD510 PHY.
  * @phydev: Pointer to the phy_device structure.
@@ -712,6 +893,12 @@ static struct phy_driver dp83td510_driver[] = {
 	.get_phy_stats	= dp83td510_get_phy_stats,
 	.update_stats	= dp83td510_update_stats,
 
+	.led_brightness_set = dp83td510_led_brightness_set,
+	.led_hw_is_supported = dp83td510_led_hw_is_supported,
+	.led_hw_control_set = dp83td510_led_hw_control_set,
+	.led_hw_control_get = dp83td510_led_hw_control_get,
+	.led_polarity_set = dp83td510_led_polarity_set,
+
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 } };
-- 
2.39.5


