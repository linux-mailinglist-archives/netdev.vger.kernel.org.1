Return-Path: <netdev+bounces-133419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A3995DBB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196F81C215AE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D81311AC;
	Wed,  9 Oct 2024 02:28:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788602943F;
	Wed,  9 Oct 2024 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440925; cv=none; b=Hy6DjrT8ZjSuP3xfVYQWGTpOJ81xR4xcxtaHT2ooWEcAn3fi2+/5fn5SuMyVfcilHn8RP102Q8uTqhYQDzdgvkNeC3YJyisO0yU56drtDiZqyY03VmSYmYxOWd8J7GPLV1mv0BYR6TVcWMYV80To3jCmVGt7iUXKkKPAU+qX+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440925; c=relaxed/simple;
	bh=Dhd7syeMdwvGGEkHVqdnnSNx3dM5PqqIhlyje3yog5A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DpW8ddBu5MaGawA2Gz8jjGNKNywpKZ6O9CcC0CT6eWqC8uyWH+B63i+IHObByNr+dXE1lXZwHnv4iN3V3qpjKMzcPJXjDELAmfKuPcKGrSU0v10v/YPRMViD9LVla7/3XHFU3CBYlO7507Q85cgNptBIWL1xLksXKLyIao1zJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syMRJ-000000003Vr-17Tc;
	Wed, 09 Oct 2024 02:28:37 +0000
Date: Wed, 9 Oct 2024 03:28:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
Message-ID: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
total: 0 errors, 1 warnings, 0 checks, 336 lines checked

The intel-xway PHY driver predates the PHY LED framework and currently
initializes all LED pins to equal default values.

Add PHY LED functions to the drivers and don't set default values if
LEDs are defined in device tree.

According the datasheets 3 LEDs are supported on all Intel XWAY PHYs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Note that this patch depends on patch
"net: phy: support 'active-high' property for PHY LEDs"
to be merged first.

See also
https://patchwork.kernel.org/project/netdevbpf/list/?series=895863

 drivers/net/phy/intel-xway.c | 247 +++++++++++++++++++++++++++++++++--
 1 file changed, 238 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 3c032868ef04..d2958d63641c 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -151,6 +151,13 @@
 #define XWAY_MMD_LED3H			0x01E8
 #define XWAY_MMD_LED3L			0x01E9
 
+#define XWAY_GPHY_MAX_LEDS		3
+#define XWAY_GPHY_LED_INV(idx)		BIT(12 + (idx))
+#define XWAY_GPHY_LED_EN(idx)		BIT(8 + (idx))
+#define XWAY_GPHY_LED_DA(idx)		BIT(idx)
+#define XWAY_MMD_LEDxH(idx)		(XWAY_MMD_LED0H + 2 * (idx))
+#define XWAY_MMD_LEDxL(idx)		(XWAY_MMD_LED0L + 2 * (idx))
+
 #define PHY_ID_PHY11G_1_3		0x030260D1
 #define PHY_ID_PHY22F_1_3		0x030260E1
 #define PHY_ID_PHY11G_1_4		0xD565A400
@@ -229,20 +236,12 @@ static int xway_gphy_rgmii_init(struct phy_device *phydev)
 			  XWAY_MDIO_MIICTRL_TXSKEW_MASK, val);
 }
 
-static int xway_gphy_config_init(struct phy_device *phydev)
+static int xway_gphy_init_leds(struct phy_device *phydev)
 {
 	int err;
 	u32 ledxh;
 	u32 ledxl;
 
-	/* Mask all interrupts */
-	err = phy_write(phydev, XWAY_MDIO_IMASK, 0);
-	if (err)
-		return err;
-
-	/* Clear all pending interrupts */
-	phy_read(phydev, XWAY_MDIO_ISTAT);
-
 	/* Ensure that integrated led function is enabled for all leds */
 	err = phy_write(phydev, XWAY_MDIO_LED,
 			XWAY_MDIO_LED_LED0_EN |
@@ -276,6 +275,26 @@ static int xway_gphy_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LED2H, ledxh);
 	phy_write_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LED2L, ledxl);
 
+	return 0;
+}
+
+static int xway_gphy_config_init(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	int err;
+
+	/* Mask all interrupts */
+	err = phy_write(phydev, XWAY_MDIO_IMASK, 0);
+	if (err)
+		return err;
+
+	/* Use default LED configuration if 'leds' node isn't defined */
+	if (!of_get_child_by_name(np, "leds"))
+		xway_gphy_init_leds(phydev);
+
+	/* Clear all pending interrupts */
+	phy_read(phydev, XWAY_MDIO_ISTAT);
+
 	err = xway_gphy_rgmii_init(phydev);
 	if (err)
 		return err;
@@ -347,6 +366,166 @@ static irqreturn_t xway_gphy_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int xway_gphy_led_brightness_set(struct phy_device *phydev,
+					u8 index, enum led_brightness value)
+{
+	int ret;
+
+	if (index >= XWAY_GPHY_MAX_LEDS)
+		return -EINVAL;
+
+	/* clear EN and set manual LED state */
+	ret = phy_modify(phydev, XWAY_MDIO_LED,
+			 ((value == LED_OFF) ? XWAY_GPHY_LED_EN(index) : 0) |
+			 XWAY_GPHY_LED_DA(index),
+			 (value == LED_OFF) ? 0 : XWAY_GPHY_LED_DA(index));
+	if (ret)
+		return ret;
+
+	/* clear HW LED setup */
+	if (value == LED_OFF) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LEDxH(index), 0);
+		if (ret)
+			return ret;
+
+		return phy_write_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LEDxL(index), 0);
+	} else {
+		return 0;
+	}
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK) |
+						 BIT(TRIGGER_NETDEV_LINK_10) |
+						 BIT(TRIGGER_NETDEV_LINK_100) |
+						 BIT(TRIGGER_NETDEV_LINK_1000) |
+						 BIT(TRIGGER_NETDEV_RX) |
+						 BIT(TRIGGER_NETDEV_TX));
+
+static int xway_gphy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					 unsigned long rules)
+{
+	if (index >= XWAY_GPHY_MAX_LEDS)
+		return -EINVAL;
+
+	/* activity triggers are not possible without combination with a link
+	 * trigger.
+	 */
+	if (rules & (BIT(TRIGGER_NETDEV_RX) | BIT(TRIGGER_NETDEV_TX)) &&
+	    !(rules & (BIT(TRIGGER_NETDEV_LINK) |
+		       BIT(TRIGGER_NETDEV_LINK_10) |
+		       BIT(TRIGGER_NETDEV_LINK_100) |
+		       BIT(TRIGGER_NETDEV_LINK_1000))))
+		return -EOPNOTSUPP;
+
+	/* All other combinations of the supported triggers are allowed */
+	if (rules & ~supported_triggers)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int xway_gphy_led_hw_control_get(struct phy_device *phydev, u8 index,
+					unsigned long *rules)
+{
+	int lval, hval;
+
+	if (index >= XWAY_GPHY_MAX_LEDS)
+		return -EINVAL;
+
+	hval = phy_read_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LEDxH(index));
+	if (hval < 0)
+		return hval;
+
+	lval = phy_read_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LEDxL(index));
+	if (lval < 0)
+		return lval;
+
+	if (hval & XWAY_MMD_LEDxH_CON_LINK10)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
+
+	if (hval & XWAY_MMD_LEDxH_CON_LINK100)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+
+	if (hval & XWAY_MMD_LEDxH_CON_LINK1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	if ((hval & XWAY_MMD_LEDxH_CON_LINK10) &&
+	    (hval & XWAY_MMD_LEDxH_CON_LINK100) &&
+	    (hval & XWAY_MMD_LEDxH_CON_LINK1000))
+		*rules |= BIT(TRIGGER_NETDEV_LINK);
+
+	if (lval & XWAY_MMD_LEDxL_PULSE_TXACT)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	if (lval & XWAY_MMD_LEDxL_PULSE_RXACT)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+
+	return 0;
+}
+
+static int xway_gphy_led_hw_control_set(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	u16 hval = 0, lval = 0;
+	int ret;
+
+	if (index >= XWAY_GPHY_MAX_LEDS)
+		return -EINVAL;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_10))
+		hval |= XWAY_MMD_LEDxH_CON_LINK10;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_100))
+		hval |= XWAY_MMD_LEDxH_CON_LINK100;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK) ||
+	    rules & BIT(TRIGGER_NETDEV_LINK_1000))
+		hval |= XWAY_MMD_LEDxH_CON_LINK1000;
+
+	if (rules & BIT(TRIGGER_NETDEV_TX))
+		lval |= XWAY_MMD_LEDxL_PULSE_TXACT;
+
+	if (rules & BIT(TRIGGER_NETDEV_RX))
+		lval |= XWAY_MMD_LEDxL_PULSE_RXACT;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LEDxH(index), hval);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, XWAY_MMD_LEDxL(index), lval);
+	if (ret)
+		return ret;
+
+	return phy_set_bits(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_EN(index));
+}
+
+static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
+				      unsigned long modes)
+{
+	bool active_low = false;
+	u32 mode;
+
+	if (index >= XWAY_GPHY_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			active_low = true;
+			break;
+		case PHY_LED_ACTIVE_HIGH:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return phy_modify(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index),
+			  active_low ? XWAY_GPHY_LED_INV(index) : 0);
+}
+
 static struct phy_driver xway_gphy[] = {
 	{
 		.phy_id		= PHY_ID_PHY11G_1_3,
@@ -359,6 +538,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_3,
 		.phy_id_mask	= 0xffffffff,
@@ -370,6 +554,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_1_4,
 		.phy_id_mask	= 0xffffffff,
@@ -381,6 +570,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_4,
 		.phy_id_mask	= 0xffffffff,
@@ -392,6 +586,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_1_5,
 		.phy_id_mask	= 0xffffffff,
@@ -402,6 +601,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_5,
 		.phy_id_mask	= 0xffffffff,
@@ -412,6 +616,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_1,
 		.phy_id_mask	= 0xffffffff,
@@ -422,6 +631,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_VR9_1_1,
 		.phy_id_mask	= 0xffffffff,
@@ -432,6 +646,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
@@ -442,6 +661,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
@@ -452,6 +676,11 @@ static struct phy_driver xway_gphy[] = {
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+		.led_brightness_set = xway_gphy_led_brightness_set,
+		.led_hw_is_supported = xway_gphy_led_hw_is_supported,
+		.led_hw_control_get = xway_gphy_led_hw_control_get,
+		.led_hw_control_set = xway_gphy_led_hw_control_set,
+		.led_polarity_set = xway_gphy_led_polarity_set,
 	},
 };
 module_phy_driver(xway_gphy);
-- 
2.47.0


