Return-Path: <netdev+bounces-51915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A837FCAC6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C02B2170F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB75D4BD;
	Tue, 28 Nov 2023 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Prn5uUFU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B4B19B2
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GkAxCEyt3Lz2Ffvh3uAOkSYzE3BLUvLC+fI2FhE/bUk=; b=Prn5uUFUSNQgzDrsyhAScYANrL
	zIsj7SXU89CgFSDdyG9HU4vALBdqt0nyS+9cWhX+7GQcXJYTFCGmjUGVuTCoNSUQ2ch/wQDRhmrYV
	YG0JQMzQmCHyy/EsbF87cGzntXPQewkLYxNaijWmS3TlYdmAW5P/auYDt0PQvmlQoMyc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VJK-PP; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 8/8] dsa: qca8k: Use DSA common code for LEDs
Date: Wed, 29 Nov 2023 00:21:35 +0100
Message-Id: <20231128232135.358638-9-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than parse the device tree in the qca8k driver, make use of the
common code in the DSA core.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c |  11 +-
 drivers/net/dsa/qca/qca8k-leds.c | 255 +++++--------------------------
 drivers/net/dsa/qca/qca8k.h      |   9 --
 drivers/net/dsa/qca/qca8k_leds.h |  21 ++-
 4 files changed, 56 insertions(+), 240 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec57d9d52072..4929894a2b5d 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1838,10 +1838,6 @@ qca8k_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	ret = qca8k_setup_led_ctrl(priv);
-	if (ret)
-		return ret;
-
 	qca8k_setup_pcs(priv, &priv->pcs_port_0, 0);
 	qca8k_setup_pcs(priv, &priv->pcs_port_6, 6);
 
@@ -2018,6 +2014,13 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.port_lag_leave		= qca8k_port_lag_leave,
 	.conduit_state_change	= qca8k_conduit_change,
 	.connect_tag_protocol	= qca8k_connect_tag_protocol,
+#ifdef CONFIG_NET_DSA_QCA8K_LEDS_SUPPORT
+	.led_brightness_set	= qca8k_led_brightness_set,
+	.led_blink_set		= qca8k_led_blink_set,
+	.led_hw_control_is_supported = qca8k_led_hw_control_is_supported,
+	.led_hw_control_set	= qca8k_led_hw_control_set,
+	.led_hw_control_get	= qca8k_led_hw_control_get,
+#endif
 };
 
 static int
diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 90e30c2909e4..febae23b65a9 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -6,18 +6,6 @@
 #include "qca8k.h"
 #include "qca8k_leds.h"
 
-static u32 qca8k_phy_to_port(int phy)
-{
-	/* Internal PHY 0 has port at index 1.
-	 * Internal PHY 1 has port at index 2.
-	 * Internal PHY 2 has port at index 3.
-	 * Internal PHY 3 has port at index 4.
-	 * Internal PHY 4 has port at index 5.
-	 */
-
-	return phy + 1;
-}
-
 static int
 qca8k_get_enable_led_reg(int port_num, int led_num, struct qca8k_led_pattern_en *reg_info)
 {
@@ -91,15 +79,15 @@ qca8k_parse_netdev(unsigned long rules, u32 *offload_trigger)
 	return 0;
 }
 
-static int
-qca8k_led_brightness_set(struct qca8k_led *led,
-			 enum led_brightness brightness)
+int
+qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
+			 u8 led_num, enum led_brightness brightness)
 {
 	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
+	struct qca8k_priv *priv = ds->priv;
 	u32 mask, val;
 
-	qca8k_get_enable_led_reg(led->port_num, led->led_num, &reg_info);
+	qca8k_get_enable_led_reg(port_num, led_num, &reg_info);
 
 	val = QCA8K_LED_ALWAYS_OFF;
 	if (brightness)
@@ -139,7 +127,7 @@ qca8k_led_brightness_set(struct qca8k_led *led,
 	 * to calculate the shift and the correct reg due to this problem of
 	 * not having a 1:1 map of LED with the regs.
 	 */
-	if (led->port_num == 0 || led->port_num == 4) {
+	if (port_num == 0 || port_num == 4) {
 		mask = QCA8K_LED_PATTERN_EN_MASK;
 		val <<= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -151,51 +139,14 @@ qca8k_led_brightness_set(struct qca8k_led *led,
 				  val << reg_info.shift);
 }
 
-static int
-qca8k_cled_brightness_set_blocking(struct led_classdev *ldev,
-				   enum led_brightness brightness)
-{
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
-
-	return qca8k_led_brightness_set(led, brightness);
-}
-
-static enum led_brightness
-qca8k_led_brightness_get(struct qca8k_led *led)
-{
-	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
-	u32 val;
-	int ret;
-
-	qca8k_get_enable_led_reg(led->port_num, led->led_num, &reg_info);
-
-	ret = regmap_read(priv->regmap, reg_info.reg, &val);
-	if (ret)
-		return 0;
-
-	val >>= reg_info.shift;
-
-	if (led->port_num == 0 || led->port_num == 4) {
-		val &= QCA8K_LED_PATTERN_EN_MASK;
-		val >>= QCA8K_LED_PATTERN_EN_SHIFT;
-	} else {
-		val &= QCA8K_LED_PHY123_PATTERN_EN_MASK;
-	}
-
-	/* Assume brightness ON only when the LED is set to always ON */
-	return val == QCA8K_LED_ALWAYS_ON;
-}
-
-static int
-qca8k_cled_blink_set(struct led_classdev *ldev,
-		     unsigned long *delay_on,
-		     unsigned long *delay_off)
+int
+qca8k_led_blink_set(struct dsa_switch *ds, int port_num, u8 led_num,
+		    unsigned long *delay_on,
+		    unsigned long *delay_off)
 {
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
 	u32 mask, val = QCA8K_LED_ALWAYS_BLINK_4HZ;
 	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
+	struct qca8k_priv *priv = ds->priv;
 
 	if (*delay_on == 0 && *delay_off == 0) {
 		*delay_on = 125;
@@ -209,9 +160,9 @@ qca8k_cled_blink_set(struct led_classdev *ldev,
 		return -EINVAL;
 	}
 
-	qca8k_get_enable_led_reg(led->port_num, led->led_num, &reg_info);
+	qca8k_get_enable_led_reg(port_num, led_num, &reg_info);
 
-	if (led->port_num == 0 || led->port_num == 4) {
+	if (port_num == 0 || port_num == 4) {
 		mask = QCA8K_LED_PATTERN_EN_MASK;
 		val <<= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -225,20 +176,18 @@ qca8k_cled_blink_set(struct led_classdev *ldev,
 }
 
 static int
-qca8k_cled_trigger_offload(struct led_classdev *ldev, bool enable)
+qca8k_led_trigger_offload(struct qca8k_priv *priv, int port_num, u8 led_num,
+			  bool enable)
 {
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
-
 	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
 	u32 mask, val = QCA8K_LED_ALWAYS_OFF;
 
-	qca8k_get_enable_led_reg(led->port_num, led->led_num, &reg_info);
+	qca8k_get_enable_led_reg(port_num, led_num, &reg_info);
 
 	if (enable)
 		val = QCA8K_LED_RULE_CONTROLLED;
 
-	if (led->port_num == 0 || led->port_num == 4) {
+	if (port_num == 0 || port_num == 4) {
 		mask = QCA8K_LED_PATTERN_EN_MASK;
 		val <<= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -250,21 +199,18 @@ qca8k_cled_trigger_offload(struct led_classdev *ldev, bool enable)
 }
 
 static bool
-qca8k_cled_hw_control_status(struct led_classdev *ldev)
+qca8k_led_hw_control_status(struct qca8k_priv *priv, int port_num, u8 led_num)
 {
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
-
 	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
 	u32 val;
 
-	qca8k_get_enable_led_reg(led->port_num, led->led_num, &reg_info);
+	qca8k_get_enable_led_reg(port_num, led_num, &reg_info);
 
 	regmap_read(priv->regmap, reg_info.reg, &val);
 
 	val >>= reg_info.shift;
 
-	if (led->port_num == 0 || led->port_num == 4) {
+	if (port_num == 0 || port_num == 4) {
 		val &= QCA8K_LED_PATTERN_EN_MASK;
 		val >>= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -274,20 +220,22 @@ qca8k_cled_hw_control_status(struct led_classdev *ldev)
 	return val == QCA8K_LED_RULE_CONTROLLED;
 }
 
-static int
-qca8k_cled_hw_control_is_supported(struct led_classdev *ldev, unsigned long rules)
+int
+qca8k_led_hw_control_is_supported(struct dsa_switch *ds,
+				  int port, u8 led,
+				  unsigned long rules)
 {
 	u32 offload_trigger = 0;
 
 	return qca8k_parse_netdev(rules, &offload_trigger);
 }
 
-static int
-qca8k_cled_hw_control_set(struct led_classdev *ldev, unsigned long rules)
+int
+qca8k_led_hw_control_set(struct dsa_switch *ds, int port_num, u8 led_num,
+			 unsigned long rules)
 {
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
 	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
+	struct qca8k_priv *priv = ds->priv;
 	u32 offload_trigger = 0;
 	int ret;
 
@@ -295,31 +243,31 @@ qca8k_cled_hw_control_set(struct led_classdev *ldev, unsigned long rules)
 	if (ret)
 		return ret;
 
-	ret = qca8k_cled_trigger_offload(ldev, true);
+	ret = qca8k_led_trigger_offload(priv, port_num, led_num, true);
 	if (ret)
 		return ret;
 
-	qca8k_get_control_led_reg(led->port_num, led->led_num, &reg_info);
+	qca8k_get_control_led_reg(port_num, led_num, &reg_info);
 
 	return regmap_update_bits(priv->regmap, reg_info.reg,
 				  QCA8K_LED_RULE_MASK << reg_info.shift,
 				  offload_trigger << reg_info.shift);
 }
 
-static int
-qca8k_cled_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
+int
+qca8k_led_hw_control_get(struct dsa_switch *ds, int port_num, u8 led_num,
+			 unsigned long *rules)
 {
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
 	struct qca8k_led_pattern_en reg_info;
-	struct qca8k_priv *priv = led->priv;
+	struct qca8k_priv *priv = ds->priv;
 	u32 val;
 	int ret;
 
 	/* With hw control not active return err */
-	if (!qca8k_cled_hw_control_status(ldev))
+	if (!qca8k_led_hw_control_status(priv, port_num, led_num))
 		return -EINVAL;
 
-	qca8k_get_control_led_reg(led->port_num, led->led_num, &reg_info);
+	qca8k_get_control_led_reg(port_num, led_num, &reg_info);
 
 	ret = regmap_read(priv->regmap, reg_info.reg, &val);
 	if (ret)
@@ -346,134 +294,3 @@ qca8k_cled_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
 
 	return 0;
 }
-
-static struct device *qca8k_cled_hw_control_get_device(struct led_classdev *ldev)
-{
-	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
-	struct qca8k_priv *priv = led->priv;
-	struct dsa_port *dp;
-
-	dp = dsa_to_port(priv->ds, qca8k_phy_to_port(led->port_num));
-	if (!dp)
-		return NULL;
-	if (dp->user)
-		return &dp->user->dev;
-	return NULL;
-}
-
-static int
-qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int port_num)
-{
-	struct fwnode_handle *led = NULL, *leds = NULL;
-	struct led_init_data init_data = { };
-	struct dsa_switch *ds = priv->ds;
-	enum led_default_state state;
-	struct qca8k_led *port_led;
-	int led_num, led_index;
-	int ret;
-
-	leds = fwnode_get_named_child_node(port, "leds");
-	if (!leds) {
-		dev_dbg(priv->dev, "No Leds node specified in device tree for port %d!\n",
-			port_num);
-		return 0;
-	}
-
-	fwnode_for_each_child_node(leds, led) {
-		/* Reg represent the led number of the port.
-		 * Each port can have at most 3 leds attached
-		 * Commonly:
-		 * 1. is gigabit led
-		 * 2. is mbit led
-		 * 3. additional status led
-		 */
-		if (fwnode_property_read_u32(led, "reg", &led_num))
-			continue;
-
-		if (led_num >= QCA8K_LED_PORT_COUNT) {
-			dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
-				 led_num, port_num);
-			continue;
-		}
-
-		led_index = QCA8K_LED_PORT_INDEX(port_num, led_num);
-
-		port_led = &priv->ports_led[led_index];
-		port_led->port_num = port_num;
-		port_led->led_num = led_num;
-		port_led->priv = priv;
-
-		state = led_init_default_state_get(led);
-		switch (state) {
-		case LEDS_DEFSTATE_ON:
-			port_led->cdev.brightness = 1;
-			qca8k_led_brightness_set(port_led, 1);
-			break;
-		case LEDS_DEFSTATE_KEEP:
-			port_led->cdev.brightness =
-					qca8k_led_brightness_get(port_led);
-			break;
-		default:
-			port_led->cdev.brightness = 0;
-			qca8k_led_brightness_set(port_led, 0);
-		}
-
-		port_led->cdev.max_brightness = 1;
-		port_led->cdev.brightness_set_blocking = qca8k_cled_brightness_set_blocking;
-		port_led->cdev.blink_set = qca8k_cled_blink_set;
-		port_led->cdev.hw_control_is_supported = qca8k_cled_hw_control_is_supported;
-		port_led->cdev.hw_control_set = qca8k_cled_hw_control_set;
-		port_led->cdev.hw_control_get = qca8k_cled_hw_control_get;
-		port_led->cdev.hw_control_get_device = qca8k_cled_hw_control_get_device;
-		port_led->cdev.hw_control_trigger = "netdev";
-		init_data.default_label = ":port";
-		init_data.fwnode = led;
-		init_data.devname_mandatory = true;
-		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d", ds->user_mii_bus->id,
-						 port_num);
-		if (!init_data.devicename)
-			return -ENOMEM;
-
-		ret = devm_led_classdev_register_ext(priv->dev, &port_led->cdev, &init_data);
-		if (ret)
-			dev_warn(priv->dev, "Failed to init LED %d for port %d", led_num, port_num);
-
-		kfree(init_data.devicename);
-	}
-
-	return 0;
-}
-
-int
-qca8k_setup_led_ctrl(struct qca8k_priv *priv)
-{
-	struct fwnode_handle *ports, *port;
-	int port_num;
-	int ret;
-
-	ports = device_get_named_child_node(priv->dev, "ports");
-	if (!ports) {
-		dev_info(priv->dev, "No ports node specified in device tree!");
-		return 0;
-	}
-
-	fwnode_for_each_child_node(ports, port) {
-		if (fwnode_property_read_u32(port, "reg", &port_num))
-			continue;
-
-		/* Skip checking for CPU port 0 and CPU port 6 as not supported */
-		if (port_num == 0 || port_num == 6)
-			continue;
-
-		/* Each port can have at most 3 different leds attached.
-		 * Switch port starts from 0 to 6, but port 0 and 6 are CPU
-		 * port. The port index needs to be decreased by one to identify
-		 * the correct port for LED setup.
-		 */
-		ret = qca8k_parse_port_leds(priv, port, qca8k_port_to_phy(port_num));
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 2ac7e88f8da5..bf0f78f5390d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -433,14 +433,6 @@ struct qca8k_led_pattern_en {
 	u8 shift;
 };
 
-struct qca8k_led {
-	u8 port_num;
-	u8 led_num;
-	u16 old_rule;
-	struct qca8k_priv *priv;
-	struct led_classdev cdev;
-};
-
 struct qca8k_priv {
 	u8 switch_id;
 	u8 switch_revision;
@@ -465,7 +457,6 @@ struct qca8k_priv {
 	struct qca8k_pcs pcs_port_0;
 	struct qca8k_pcs pcs_port_6;
 	const struct qca8k_match_data *info;
-	struct qca8k_led ports_led[QCA8K_LED_COUNT];
 };
 
 struct qca8k_mib_desc {
diff --git a/drivers/net/dsa/qca/qca8k_leds.h b/drivers/net/dsa/qca/qca8k_leds.h
index ab367f05b173..1c020d0f2fdc 100644
--- a/drivers/net/dsa/qca/qca8k_leds.h
+++ b/drivers/net/dsa/qca/qca8k_leds.h
@@ -5,12 +5,17 @@
 
 /* Leds Support function */
 #ifdef CONFIG_NET_DSA_QCA8K_LEDS_SUPPORT
-int qca8k_setup_led_ctrl(struct qca8k_priv *priv);
-#else
-static inline int qca8k_setup_led_ctrl(struct qca8k_priv *priv)
-{
-	return 0;
-}
-#endif
-
+int qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
+			     u8 led_num, enum led_brightness brightness);
+int qca8k_led_blink_set(struct dsa_switch *ds, int port_num, u8 led_num,
+			unsigned long *delay_on,
+			unsigned long *delay_off);
+int qca8k_led_hw_control_is_supported(struct dsa_switch *ds,
+				      int port, u8 led,
+				      unsigned long rules);
+int qca8k_led_hw_control_set(struct dsa_switch *ds, int port_num, u8 led_num,
+			     unsigned long rules);
+int qca8k_led_hw_control_get(struct dsa_switch *ds, int port_num, u8 led_num,
+			     unsigned long *rules);
+#endif /* CONFIG_NET_DSA_QCA8K_LEDS_SUPPORT */
 #endif /* __QCA8K_LEDS_H */
-- 
2.42.0


