Return-Path: <netdev+bounces-240992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7907C7D1A6
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73F7D353235
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968C13B5AE;
	Sat, 22 Nov 2025 13:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7ED2030A;
	Sat, 22 Nov 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763818437; cv=none; b=pvBzZMKyfEI1wMH+EC/9u1H+6ti23mH+0gwvHroRvzrTYcoo0t26wWxJ3I1qGR48ZauglyRljmsf/2TuT5nCqAJs1FGztIG0vcKzgWb1XCM839axRKKbMEx13ZQpKr86ksdqnAQrJdneF5HySIdpWWM5VfjsaRI+IMSwFEBmDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763818437; c=relaxed/simple;
	bh=PvjU0J1grbPMuqmyhWJ/2yDn2p/ycBDOvqr0megBNqQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjzgwZ4stDTwoA0a1z4+240lN5o7E4v5zf/WosRJrCM7a4uezEBY61pE0ghJ82W72IO0tB+cXRTcbtxLK+KJedWMkknRVuWdI2kKjBd9TxO96qtYh27k/gB+DxuZUPf5d+51Op5LMDFEebtptzJrdMmhzMEetwFzKXXAWkNKHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vMnkM-000000002qb-1qiQ;
	Sat, 22 Nov 2025 13:33:50 +0000
Date: Sat, 22 Nov 2025 13:33:47 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: phy: mxl-gpy: add support for MxL86252
 and MxL86282
Message-ID: <a6cd7fe461b011cec2b59dffaf34e9c8b0819059.1763818120.git.daniel@makrotopia.org>
References: <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>

Add PHY driver support for Maxlinear MxL86252 and MxL86282 switches.
The PHYs built-into those switches are just like any other GPY 2.5G PHYs
with the exception of the temperature sensor data being encoded in a
different way.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 * drop change in gpy_update_interface(), it has been merged as a 
   separate patch via net tree
 * add dedicated PHY-ID for each product

 drivers/net/phy/mxl-gpy.c | 91 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index bea9072ac4a8d..58d8dd718445c 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -31,6 +31,8 @@
 #define PHY_ID_GPY241BM		0x67C9DE80
 #define PHY_ID_GPY245B		0x67C9DEC0
 #define PHY_ID_MXL86211C	0xC1335400
+#define PHY_ID_MXL86252		0xC1335520
+#define PHY_ID_MXL86282		0xC1335500
 
 #define PHY_CTL1		0x13
 #define PHY_CTL1_MDICD		BIT(3)
@@ -200,6 +202,29 @@ static int gpy_hwmon_read(struct device *dev,
 	return 0;
 }
 
+static int mxl862x2_hwmon_read(struct device *dev,
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
@@ -217,19 +242,35 @@ static const struct hwmon_ops gpy_hwmon_hwmon_ops = {
 	.read		= gpy_hwmon_read,
 };
 
+static const struct hwmon_ops mxl862x2_hwmon_hwmon_ops = {
+	.is_visible	= gpy_hwmon_is_visible,
+	.read		= mxl862x2_hwmon_read,
+};
+
 static const struct hwmon_chip_info gpy_hwmon_chip_info = {
 	.ops		= &gpy_hwmon_hwmon_ops,
 	.info		= gpy_hwmon_info,
 };
 
+static const struct hwmon_chip_info mxl862x2_hwmon_chip_info = {
+	.ops		= &mxl862x2_hwmon_hwmon_ops,
+	.info		= gpy_hwmon_info,
+};
+
 static int gpy_hwmon_register(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	const struct hwmon_chip_info *info;
 	struct device *hwmon_dev;
 
+	if (phy_id_compare_model(phydev->phy_id, PHY_ID_MXL86252) ||
+	    phy_id_compare_model(phydev->phy_id, PHY_ID_MXL86282))
+		info = &mxl862x2_hwmon_chip_info;
+	else
+		info = &gpy_hwmon_chip_info;
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
-							 &gpy_hwmon_chip_info,
-							 NULL);
+							 info, NULL);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
@@ -1291,6 +1332,50 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_MXL86252),
+		.name		= "MaxLinear Ethernet MxL86252",
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
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_MXL86282),
+		.name		= "MaxLinear Ethernet MxL86282",
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
 
@@ -1308,6 +1393,8 @@ static const struct mdio_device_id __maybe_unused gpy_tbl[] = {
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM)},
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY245B)},
 	{PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C)},
+	{PHY_ID_MATCH_MODEL(PHY_ID_MXL86252)},
+	{PHY_ID_MATCH_MODEL(PHY_ID_MXL86282)},
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, gpy_tbl);
-- 
2.52.0

