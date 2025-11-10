Return-Path: <netdev+bounces-237363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD2C499BF
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7CD188D1A4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F81263F28;
	Mon, 10 Nov 2025 22:35:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468423E320;
	Mon, 10 Nov 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814109; cv=none; b=Evmq3dwdOpMBERwOFEO9hvHfFJBj9CUTIXXO1U0+WjJCOJzs/awQybZTPBoi32+VXYCgfO53mukISBxETtE06l7PTxntLrSFXzbhIpKAMNKIAUM9pukdbyKarkk3/Sy3eygmbm0NZKBlSvmz9PT+jWvecy3IZLqnm/zh+3QX7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814109; c=relaxed/simple;
	bh=g2BAFRnjlw4boE7/Gk6NSAv2V3yMnOdgYAEtIhWcnIE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee3swTsxICp3+UWaY/WEOZzCOZKai7aqiEXzL9foNqSSEgdTi0K8IXFbQNSlrJsH8t48zR0F9hD/oxljzuup53noUcOBOCXnwifJlG+RiFKdXHcdrOIvQlimw5UmyZPTWNBYlEuDiMmonVj7tX4eKcPdKNfHsyv1wAITalCBiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vIaTW-000000003yP-3kZw;
	Mon, 10 Nov 2025 22:35:02 +0000
Date: Mon, 10 Nov 2025 22:35:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: phy: mxl-gpy: add MxL862xx support
Message-ID: <5e61cac4897c8deec35a4032b5be8f85a5e45650.1762813829.git.daniel@makrotopia.org>
References: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>

Add PHY driver support for Maxlinear 86252 and 86282 switches.
The PHYs built-into those switches are just like any other GPY 2.5G PHYs
with the exception of the temperature sensor data being encoded in a
different way.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 70 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 3320a42ef43cf..d14520f66a1d5 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -18,6 +18,7 @@
 /* PHY ID */
 #define PHY_ID_GPYx15B_MASK	0xFFFFFFFC
 #define PHY_ID_GPY21xB_MASK	0xFFFFFFF9
+#define PHY_ID_MXL862XX_MASK	0xFFFFFF00
 #define PHY_ID_GPY2xx		0x67C9DC00
 #define PHY_ID_GPY115B		0x67C9DF00
 #define PHY_ID_GPY115C		0x67C9DF10
@@ -31,6 +32,7 @@
 #define PHY_ID_GPY241BM		0x67C9DE80
 #define PHY_ID_GPY245B		0x67C9DEC0
 #define PHY_ID_MXL86211C		0xC1335400
+#define PHY_ID_MXL862XX		0xC1335500
 
 #define PHY_CTL1		0x13
 #define PHY_CTL1_MDICD		BIT(3)
@@ -200,6 +202,29 @@ static int gpy_hwmon_read(struct device *dev,
 	return 0;
 }
 
+static int mxl862xx_hwmon_read(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *value)
+{
+	struct phy_device *phydev = dev_get_drvdata(dev);
+	long tmp;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_TEMP_STA);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ENODATA;
+
+	tmp = (s16)ret;
+	tmp *= 78125;
+	tmp /= 10000;
+
+	*value = tmp;
+
+	return 0;
+}
+
 static umode_t gpy_hwmon_is_visible(const void *data,
 				    enum hwmon_sensor_types type,
 				    u32 attr, int channel)
@@ -217,19 +242,34 @@ static const struct hwmon_ops gpy_hwmon_hwmon_ops = {
 	.read		= gpy_hwmon_read,
 };
 
+static const struct hwmon_ops mxl862xx_hwmon_hwmon_ops = {
+	.is_visible	= gpy_hwmon_is_visible,
+	.read		= mxl862xx_hwmon_read,
+};
+
 static const struct hwmon_chip_info gpy_hwmon_chip_info = {
 	.ops		= &gpy_hwmon_hwmon_ops,
 	.info		= gpy_hwmon_info,
 };
 
+static const struct hwmon_chip_info mxl862xx_hwmon_chip_info = {
+	.ops		= &mxl862xx_hwmon_hwmon_ops,
+	.info		= gpy_hwmon_info,
+};
+
 static int gpy_hwmon_register(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	const struct hwmon_chip_info *info;
 	struct device *hwmon_dev;
 
+	if ((phydev->phy_id & PHY_ID_MXL862XX_MASK) == PHY_ID_MXL862XX)
+		info = &mxl862xx_hwmon_chip_info;
+	else
+		info = &gpy_hwmon_chip_info;
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
-							 &gpy_hwmon_chip_info,
-							 NULL);
+							 info, NULL);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
@@ -541,7 +581,7 @@ static int gpy_update_interface(struct phy_device *phydev)
 	/* Interface mode is fixed for USXGMII and integrated PHY */
 	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
 	    phydev->interface == PHY_INTERFACE_MODE_INTERNAL)
-		return -EINVAL;
+		return 0;
 
 	/* Automatically switch SERDES interface between SGMII and 2500-BaseX
 	 * according to speed. Disable ANEG in 2500-BaseX mode.
@@ -1292,6 +1332,29 @@ static struct phy_driver gpy_drivers[] = {
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
 	},
+	{
+		.phy_id		= PHY_ID_MXL862XX,
+		.phy_id_mask	= PHY_ID_MXL862XX_MASK,
+		.name		= "MaxLinear Ethernet MxL862XX",
+		.get_features	= genphy_c45_pma_read_abilities,
+		.config_init	= gpy_config_init,
+		.probe		= gpy_probe,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.config_aneg	= gpy_config_aneg,
+		.aneg_done	= genphy_c45_aneg_done,
+		.read_status	= gpy_read_status,
+		.config_intr	= gpy_config_intr,
+		.handle_interrupt = gpy_handle_interrupt,
+		.set_wol	= gpy_set_wol,
+		.get_wol	= gpy_get_wol,
+		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
+	},
 };
 module_phy_driver(gpy_drivers);
 
@@ -1308,6 +1371,7 @@ static const struct mdio_device_id __maybe_unused gpy_tbl[] = {
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY241B)},
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM)},
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY245B)},
+	{PHY_ID_MXL862XX, PHY_ID_MXL862XX_MASK},
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, gpy_tbl);
-- 
2.51.2

