Return-Path: <netdev+bounces-130674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D598B15A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717411C20B6C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4AC645;
	Tue,  1 Oct 2024 00:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A55623;
	Tue,  1 Oct 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741866; cv=none; b=RPHAPAG3766eUD0PLNic9e2ObuhR34jUGQAmbEJ2lXiSOVSde5n7JmmVduxnkkpfcbaasclRGHZyBuiK2bn2eGCoKZDlqzP2DPF0EQwwKsifEphY4XLEy4nPZxHLtWiUAATcG9i6CgpHHVxmZ7wU4jRvpPk/Emr1Bj10F3HwFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741866; c=relaxed/simple;
	bh=SaidkWcP6ntsapJcQnPy8UMH7gpRrMS59tPUXcjGJh4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gjdQAy+gCoDg6hveCIADT+s9lR+zxk3O1v5KI+dRKVxiqye9GhaDeG8f/GcZ2nCML6HTC+2hW+zL4vDeJ5758hvhCY5PwUsTAdb1Mbb2Arli7TFp/2c3TO7BaxWDPlbovmSUqzX2CQ/dXeQDcigErnunPDHCt1F/pOrGNFGBXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1svQZu-0000000061k-0xCc;
	Tue, 01 Oct 2024 00:17:22 +0000
Date: Tue, 1 Oct 2024 01:17:18 +0100
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
Subject: [PATCH net-next] net: phy: mxl-gpy: add basic LED support
Message-ID: <b6ec9050339f8244ff898898a1cecc33b13a48fc.1727741563.git.daniel@makrotopia.org>
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
Changes since RFC:
 - only clear hw-control registers when brightness is set to LED_OFF
 - add ToDo comment about setting PWM brightness level (missing documentation)
 - first setup hw-control modes and then switch on hw-control in
   gpy_led_hw_control_set()
 - white space fixes
 - use reverse xmas-tree order for variable declarations

 drivers/net/phy/mxl-gpy.c | 218 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index d7d4755d6635..6279f88c4979 100644
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
@@ -848,6 +871,156 @@ static int gpy115_loopback(struct phy_device *phydev, bool enable)
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
+			 ((value == LED_OFF) ? PHY_LED_HWCONTROL(index) : 0) |
+			 PHY_LED_ON(index),
+			 (value == LED_OFF) ? 0 : PHY_LED_ON(index));
+	if (ret)
+		return ret;
+
+	/* ToDo: set PWM brightness */
+
+	/* clear HW LED setup */
+	if (value == LED_OFF)
+		return phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LED(index), 0);
+	else
+		return 0;
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
+	u16 val = 0;
+	int ret;
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
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LED(index), val);
+	if (ret)
+		return ret;
+
+	return phy_set_bits(phydev, PHY_LED, PHY_LED_HWCONTROL(index));
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
+			return -EINVAL;
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
@@ -865,6 +1038,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -883,6 +1061,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -900,6 +1083,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -918,6 +1106,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -935,6 +1128,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -953,6 +1151,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -970,6 +1173,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -988,6 +1196,11 @@ static struct phy_driver gpy_drivers[] = {
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
@@ -1005,6 +1218,11 @@ static struct phy_driver gpy_drivers[] = {
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

