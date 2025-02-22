Return-Path: <netdev+bounces-168785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB760A40B0B
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641811765CE
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026520C496;
	Sat, 22 Feb 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Aotv2cac"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D820ADC7
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249940; cv=none; b=Wv2BeIhtBqshumR6qa0Mu+hHTq4C0aG0+w0ETSm4m+nargLQc7FVNCjdEy6oKgb537GYyq2fWOJQ/r8HWrSyHfm9xXgnADLEAySVTSgETvYuzmm7b1RpfvolcIFGrok686tzTLXu11L9CfwNqxDB6chgAi0tUjF254pNYVeJqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249940; c=relaxed/simple;
	bh=UY0FyJRMlomFXpdsqS5bq5DVioEPyygV8zmW/gG88kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWxhLiW+nZtBgnFex3nH8cDABwbfdV0ZxhXufRRIFMZx7U3XCKBouFGswjIQ40Lh624MCB2xNR/0OWZTC2smUHTKpCMj2HjXwQnntGxp5qkn7wnVV0RKpk9p22U86dQexHnOFDOLI8WrEa7NW+fkM6xY1A1QUsxt5a6DddDMho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Aotv2cac; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 602 invoked from network); 22 Feb 2025 19:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1740249534; bh=Gwr+idDjxQN3SNHVjwp8VdoQWjpx57hgt/rGSMwb5ic=;
          h=From:To:Cc:Subject;
          b=Aotv2cacfNr/eGllgU40PGE8fuGxtDEvEiVsLaJVscCZHSO6BYY3FQVD4UzV5CAyS
           xwDjYMOKMFcXCZ/qz5+8+ZBslkysgPk/DlEdxuyqjCYYffi2qeB3SnoPUwguDgspgX
           nTrZSK29m0pMY/BtXb3h3EKTDrYNC9tSxZ567yigX8pjEIw/WIVWpixONtyr3EbBId
           CdYZwnhugYDjb4L5C+2QCpoAOX/fvM9aH9IWNUU02+nnA/cdQqiyTRacro9hwoZW7K
           5kNVji9/M1G7AtkyRdlb/jAL3uayxEWp/M46aApmdQuwNp0wWnIjKrPuLjhLQetxGs
           DGwFkvGACEcRg==
Received: from 83.6.114.178.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.6.114.178])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <lxu@maxlinear.com>; 22 Feb 2025 19:38:20 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: lxu@maxlinear.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next 2/2] net: phy: mxl-gpy: add LED dimming support
Date: Sat, 22 Feb 2025 19:38:14 +0100
Message-Id: <20250222183814.3315-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250222183814.3315-1-olek2@wp.pl>
References: <20250222183814.3315-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: f029fd9ffb273f107fb38f4eb8b3f943
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [scME]                               

Some PHYs support LED dimming. The use case is a router that dims LEDs
at night. In the GPY2xx series, the PWM control register is common to
all LEDs. To avoid confusing users, only the first LED used has
brightness control enabled. In many routers only one LED is connected
to PHY. When the minimum or maximum value is set, the PWM is turned off.

As of now, only Maxlinear PHYs support dimming. In the future, support
may be extended to other PHYs such as the Realtek RTL8221B.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 100 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 94d9cb727121..321f2b5c260c 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -110,9 +110,11 @@
 #define VSPEC1_MBOX_DATA	0x5
 #define VSPEC1_MBOX_ADDRLO	0x6
 #define VSPEC1_MBOX_CMD		0x7
-#define VSPEC1_MBOX_CMD_ADDRHI	GENMASK(7, 0)
-#define VSPEC1_MBOX_CMD_RD	(0 << 8)
 #define VSPEC1_MBOX_CMD_READY	BIT(15)
+#define VSPEC1_MBOX_CMD_MASK	GENMASK(11, 8)
+#define VSPEC1_MBOX_CMD_WR	0x1
+#define VSPEC1_MBOX_CMD_RD	0x0
+#define VSPEC1_MBOX_CMD_ADDRHI	GENMASK(7, 0)
 
 /* WoL */
 #define VPSPEC2_WOL_CTL		0x0E06
@@ -124,6 +126,15 @@
 /* Internal registers, access via mbox */
 #define REG_GPIO0_OUT		0xd3ce00
 
+/* LED Brightness registers, access via mbox */
+#define LED_BRT_CTRL		0xd3cf84
+#define LED_BRT_CTRL_LVLMAX	GENMASK(15, 12)
+#define LED_BRT_CTRL_LVLMIN	GENMASK(11, 8)
+#define LED_BRT_CTRL_EN		BIT(5)
+#define LED_BRT_CTRL_TSEN	BIT(4)
+
+#define GPY_MAX_BRIGHTNESS	15
+
 struct gpy_priv {
 	/* serialize mailbox acesses */
 	struct mutex mbox_lock;
@@ -138,6 +149,9 @@ struct gpy_priv {
 	 * is enabled.
 	 */
 	u64 lb_dis_to;
+
+	/* LED index with brightness control enabled */
+	int br_led_index;
 };
 
 static const struct {
@@ -267,7 +281,7 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 	if (ret)
 		goto out;
 
-	cmd = VSPEC1_MBOX_CMD_RD;
+	cmd = FIELD_PREP(VSPEC1_MBOX_CMD_MASK, VSPEC1_MBOX_CMD_RD);
 	cmd |= FIELD_PREP(VSPEC1_MBOX_CMD_ADDRHI, addr >> 16);
 
 	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_MBOX_CMD, cmd);
@@ -293,6 +307,46 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 	return ret;
 }
 
+static int gpy_mbox_write(struct phy_device *phydev, u32 addr, u16 data)
+{
+	struct gpy_priv *priv = phydev->priv;
+	int val, ret;
+	u16 cmd;
+
+	mutex_lock(&priv->mbox_lock);
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_MBOX_DATA,
+			    data);
+	if (ret)
+		goto out;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_MBOX_ADDRLO,
+			    addr);
+	if (ret)
+		goto out;
+
+	cmd = FIELD_PREP(VSPEC1_MBOX_CMD_MASK, VSPEC1_MBOX_CMD_WR);
+	cmd |= FIELD_PREP(VSPEC1_MBOX_CMD_ADDRHI, addr >> 16);
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_MBOX_CMD, cmd);
+	if (ret)
+		goto out;
+
+	/* The mbox read is used in the interrupt workaround. It was observed
+	 * that a read might take up to 2.5ms. This is also the time for which
+	 * the interrupt line is stuck low. To be on the safe side, poll the
+	 * ready bit for 10ms.
+	 */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					VSPEC1_MBOX_CMD, val,
+					(val & VSPEC1_MBOX_CMD_READY),
+					500, 10000, false);
+
+out:
+	mutex_unlock(&priv->mbox_lock);
+	return ret;
+}
+
 static int gpy_config_init(struct phy_device *phydev)
 {
 	/* Nothing to configure. Configuration Requirement Placeholder */
@@ -323,6 +377,7 @@ static int gpy_probe(struct phy_device *phydev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	priv->br_led_index = -1;
 	phydev->priv = priv;
 	mutex_init(&priv->mbox_lock);
 
@@ -861,7 +916,8 @@ static int gpy115_loopback(struct phy_device *phydev, bool enable)
 static int gpy_led_brightness_set(struct phy_device *phydev,
 				  u8 index, enum led_brightness value)
 {
-	int ret;
+	struct gpy_priv *priv = phydev->priv;
+	int ret, reg;
 
 	if (index >= GPY_MAX_LEDS)
 		return -EINVAL;
@@ -874,7 +930,21 @@ static int gpy_led_brightness_set(struct phy_device *phydev,
 	if (ret)
 		return ret;
 
-	/* ToDo: set PWM brightness */
+	/* Set PWM brightness */
+	if (index == priv->br_led_index) {
+		if (value > LED_OFF && value < GPY_MAX_BRIGHTNESS) {
+			reg = LED_BRT_CTRL_EN;
+
+			reg |= FIELD_PREP(LED_BRT_CTRL_LVLMIN, 0x4);
+			reg |= FIELD_PREP(LED_BRT_CTRL_LVLMAX, value);
+		} else {
+			reg = LED_BRT_CTRL_TSEN;
+		}
+
+		ret = gpy_mbox_write(phydev, LED_BRT_CTRL, reg);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* clear HW LED setup */
 	if (value == LED_OFF)
@@ -883,6 +953,17 @@ static int gpy_led_brightness_set(struct phy_device *phydev,
 		return 0;
 }
 
+static int gpy_led_max_brightness(struct phy_device *phydev, u8 index)
+{
+	struct gpy_priv *priv = phydev->priv;
+
+	if (priv->br_led_index < 0) {
+		priv->br_led_index = index;
+		return GPY_MAX_BRIGHTNESS;
+	}
+
+	return 1;
+}
 static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK) |
 						 BIT(TRIGGER_NETDEV_LINK_10) |
 						 BIT(TRIGGER_NETDEV_LINK_100) |
@@ -1035,6 +1116,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1058,6 +1140,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy115_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1080,6 +1163,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy115_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1103,6 +1187,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1125,6 +1210,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1148,6 +1234,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1170,6 +1257,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1193,6 +1281,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
@@ -1215,6 +1304,7 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.led_brightness_set = gpy_led_brightness_set,
+		.led_max_brightness = gpy_led_max_brightness,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
-- 
2.39.5


