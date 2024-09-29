Return-Path: <netdev+bounces-130255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD3989834
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 00:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BB31C20FDC
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111217C9AC;
	Sun, 29 Sep 2024 22:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80F144D1A;
	Sun, 29 Sep 2024 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727647367; cv=none; b=XtURXYvmwBjHzaBh0uiKPmjITxPrwtWfrwvHdx2QV+XicHSpJ+JSAofL1Qf3qn+A63zvx4Ju7H6TNz6ZEHe/bMhdOa2WSoVBB0Js43Fg1QqTf9w6BH+8Uhtl44YHlEIGAMUM8C59CD1dy3m8Xkh0g5U95O8bcWh8wgVJ0CfEIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727647367; c=relaxed/simple;
	bh=3B+Efk6LwEpH7qQJ/Vjl75IduNUnBUJ481ltwFF4sug=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nS5UvnwxnZkW9gt1fSsvmz4y38Wswc4Gl/9VPOQMxZEBNpr3gZeFRsPj7hn7wLgKi+YT7R1CHHGeZ0JgB459YnYoWzXQYuVySdJ5kN1pWw3kcBfmVlTZhAA6Pqa9k0TfdD/CEVcpq3NwJZGuMtTR2IA2plQog2KP0a40WLqVnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sv1zk-000000000CX-0EhH;
	Sun, 29 Sep 2024 22:02:24 +0000
Date: Sun, 29 Sep 2024 23:02:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Bauer <mail@david-bauer.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next] net: phy: mxl-gpy: add basic LED support
Message-ID: <55a1f247beb80c11aa7c8a24509dd77bcf0c1338.1727645992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add basic support for LEDs connected to MaxLinear GPY2xx and GPY115 PHYs.
The PHYs allow up to 4 LEDs to be connected.
Implement controlling LEDs in software as well as netdev trigger offloading
and LED polarity setup.

The hardware claims to support 16 PWM brightness levels but there is no
documentation on how to use that feature, hence this is not supported.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 212 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index e5f8ac4b4604..1fc636588c18 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -38,6 +38,7 @@
 #define PHY_MIISTAT		0x18	/* MII state */
 #define PHY_IMASK		0x19	/* interrupt mask */
 #define PHY_ISTAT		0x1A	/* interrupt status */
+#define PHY_LED			0x1B	/* LEDs */
 #define PHY_FWV			0x1E	/* firmware version */
 
 #define PHY_MIISTAT_SPD_MASK	GENMASK(2, 0)
@@ -61,6 +62,11 @@
 				 PHY_IMASK_ADSC | \
 				 PHY_IMASK_ANC)
 
+#define GPY_MAX_LEDS		4
+#define PHY_LED_POLARITY(idx)	BIT(12 + (idx))
+#define PHY_LED_HWCONTROL(idx)	BIT(8 + (idx))
+#define PHY_LED_ON(idx)		BIT(idx)
+
 #define PHY_FWV_REL_MASK	BIT(15)
 #define PHY_FWV_MAJOR_MASK	GENMASK(11, 8)
 #define PHY_FWV_MINOR_MASK	GENMASK(7, 0)
@@ -72,6 +78,23 @@
 #define PHY_MDI_MDI_X_CD	0x1
 #define PHY_MDI_MDI_X_CROSS	0x0
 
+/* LED */
+#define VSPEC1_LED(idx)		(1 + (idx))
+#define VSPEC1_LED_BLINKS	GENMASK(15, 12)
+#define VSPEC1_LED_PULSE	GENMASK(11, 8)
+#define VSPEC1_LED_CON		GENMASK(7, 4)
+#define VSPEC1_LED_BLINKF	GENMASK(3, 0)
+
+#define VSPEC1_LED_LINK10	BIT(0)
+#define VSPEC1_LED_LINK100	BIT(1)
+#define VSPEC1_LED_LINK1000	BIT(2)
+#define VSPEC1_LED_LINK2500	BIT(3)
+
+#define VSPEC1_LED_TXACT	BIT(0)
+#define VSPEC1_LED_RXACT	BIT(1)
+#define VSPEC1_LED_COL		BIT(2)
+#define VSPEC1_LED_NO_CON	BIT(3)
+
 /* SGMII */
 #define VSPEC1_SGMII_CTRL	0x08
 #define VSPEC1_SGMII_CTRL_ANEN	BIT(12)		/* Aneg enable */
@@ -835,6 +858,150 @@ static int gpy115_loopback(struct phy_device *phydev, bool enable)
 	return genphy_soft_reset(phydev);
 }
 
+static int gpy_led_brightness_set(struct phy_device *phydev,
+				  u8 index, enum led_brightness value)
+{
+	int ret;
+
+	if (index >= GPY_MAX_LEDS)
+		return -EINVAL;
+
+	/* clear HWCONTROL and set manual LED state */
+	ret = phy_modify(phydev, PHY_LED,
+			 PHY_LED_HWCONTROL(index) | PHY_LED_ON(index),
+			 (value == LED_OFF) ? 0 : PHY_LED_ON(index));
+	if (ret)
+		return ret;
+
+	/* clear HW LED setup */
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LED(index), 0);
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK) |
+						 BIT(TRIGGER_NETDEV_LINK_100) |
+						 BIT(TRIGGER_NETDEV_LINK_1000) |
+						 BIT(TRIGGER_NETDEV_LINK_2500) |
+						 BIT(TRIGGER_NETDEV_RX) |
+						 BIT(TRIGGER_NETDEV_TX));
+
+static int gpy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				   unsigned long rules)
+{
+	if (index >= GPY_MAX_LEDS)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~supported_triggers)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int gpy_led_hw_control_get(struct phy_device *phydev, u8 index,
+				  unsigned long *rules)
+{
+	int val;
+
+	if (index >= GPY_MAX_LEDS)
+		return -EINVAL;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LED(index));
+	if (val < 0)
+		return val;
+
+	if (FIELD_GET(VSPEC1_LED_CON, val) & VSPEC1_LED_LINK10)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
+
+	if (FIELD_GET(VSPEC1_LED_CON, val) & VSPEC1_LED_LINK100)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+
+	if (FIELD_GET(VSPEC1_LED_CON, val) & VSPEC1_LED_LINK1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	if (FIELD_GET(VSPEC1_LED_CON, val) & VSPEC1_LED_LINK2500)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+
+	if (FIELD_GET(VSPEC1_LED_CON, val) == (VSPEC1_LED_LINK10 |
+					       VSPEC1_LED_LINK100 |
+					       VSPEC1_LED_LINK1000 |
+					       VSPEC1_LED_LINK2500))
+		*rules |= BIT(TRIGGER_NETDEV_LINK);
+
+	if (FIELD_GET(VSPEC1_LED_PULSE, val) & VSPEC1_LED_TXACT)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	if (FIELD_GET(VSPEC1_LED_PULSE, val) & VSPEC1_LED_RXACT)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+
+	return 0;
+}
+
+static int gpy_led_hw_control_set(struct phy_device *phydev, u8 index,
+				  unsigned long rules)
+{
+	int ret;
+	u16 val = 0;
+
+	if (index >= GPY_MAX_LEDS)
+		return -EINVAL;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_10))
+		val |= FIELD_PREP(VSPEC1_LED_CON, VSPEC1_LED_LINK10);
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_100))
+		val |= FIELD_PREP(VSPEC1_LED_CON, VSPEC1_LED_LINK100);
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_1000))
+		val |= FIELD_PREP(VSPEC1_LED_CON, VSPEC1_LED_LINK1000);
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_2500))
+		val |= FIELD_PREP(VSPEC1_LED_CON, VSPEC1_LED_LINK2500);
+
+	if (rules & BIT(TRIGGER_NETDEV_TX))
+		val |= FIELD_PREP(VSPEC1_LED_PULSE, VSPEC1_LED_TXACT);
+
+	if (rules & BIT(TRIGGER_NETDEV_RX))
+		val |= FIELD_PREP(VSPEC1_LED_PULSE, VSPEC1_LED_RXACT);
+
+	/* allow RX/TX pulse without link indication */
+	if ((rules & BIT(TRIGGER_NETDEV_TX) || rules & BIT(TRIGGER_NETDEV_RX)) &&
+	    !(val & VSPEC1_LED_CON))
+		val |= FIELD_PREP(VSPEC1_LED_PULSE, VSPEC1_LED_NO_CON) | VSPEC1_LED_CON;
+
+	ret = phy_set_bits(phydev, PHY_LED, PHY_LED_HWCONTROL(index));
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LED(index), val);
+}
+
+static int gpy_led_polarity_set(struct phy_device *phydev, int index,
+				unsigned long modes)
+{
+	bool active_low = false;
+	u32 mode;
+
+	if (index >= GPY_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			active_low = true;
+			break;
+		default:
+		return -EINVAL;
+		}
+	}
+
+	return phy_modify(phydev, PHY_LED, PHY_LED_POLARITY(index),
+			  active_low ? 0 : PHY_LED_POLARITY(index));
+}
+
 static struct phy_driver gpy_drivers[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY2xx),
@@ -852,6 +1019,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		.phy_id		= PHY_ID_GPY115B,
@@ -870,6 +1042,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy115_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY115C),
@@ -887,6 +1064,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy115_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		.phy_id		= PHY_ID_GPY211B,
@@ -905,6 +1087,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY211C),
@@ -922,6 +1109,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		.phy_id		= PHY_ID_GPY212B,
@@ -940,6 +1132,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY212C),
@@ -957,6 +1154,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		.phy_id		= PHY_ID_GPY215B,
@@ -975,6 +1177,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY215C),
@@ -992,6 +1199,11 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241B),
-- 
2.46.2


