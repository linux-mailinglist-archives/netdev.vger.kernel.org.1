Return-Path: <netdev+bounces-214092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BAB283DD
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74983B01541
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83D309DD1;
	Fri, 15 Aug 2025 16:33:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A742D47F4;
	Fri, 15 Aug 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275635; cv=none; b=kRy24ptn4CTyFmXaSjoe5PK2JOAzbN+f3K0i0NZORZ1geJytscpLofPfRRYycDuntW646WUQh/kESjBCSNvpA5oKj1km0wquUZIUJQWVa//USjBQJ5B18eXeSrxv8XBfIePcoJt0dXg/PBxMH+NawF9GjOScI7b02w5jgnZ4uMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275635; c=relaxed/simple;
	bh=G8W7rkMydmb13EPAfIudb6Ic8i6THLzXrtgDyxDu0vo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bz9SWCOH7htqhXnv2hgJju/KjWN27oRaOuiZ7mhari8bRoCi1NYgkGYIgD4lB1KenmawYMHrY4mN6zRlbM2l1qumm/jBiau2VbQM8yCmWKInZ863bYxSVMqb1LT8Qnw3QpcN5uylP749xUjqYtNJOmj3p27FFMiu4abT5+FjtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1umxNF-000000002e0-1TQa;
	Fri, 15 Aug 2025 16:33:49 +0000
Date: Fri, 15 Aug 2025 17:33:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: phy: mxl-86110: add basic support for
 MxL86111 PHY
Message-ID: <aJ9hZ6kan3Wlhxkt@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add basic support for the MxL86111 PHY which in addition to the features
of the MxL86110 also comes with an SGMII interface.
Setup the interface mode and take care of in-band-an.

Currently only RGMII-to-UTP and SGMII-to-UTP modes are supported while the
PHY would also support RGMII-to-1000Base-X, including automatic selection
of the Fiber or UTP link depending on the presence of a link partner.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-86110.c | 325 ++++++++++++++++++++++++++++++++++--
 1 file changed, 311 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index 60c69c445e80..7fc7f21635e4 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -15,6 +15,7 @@
 
 /* PHY ID */
 #define PHY_ID_MXL86110		0xc1335580
+#define PHY_ID_MXL86111		0xc1335588
 
 /* required to access extended registers */
 #define MXL86110_EXTD_REG_ADDR_OFFSET			0x1E
@@ -22,7 +23,15 @@
 #define PHY_IRQ_ENABLE_REG				0x12
 #define PHY_IRQ_ENABLE_REG_WOL				BIT(6)
 
-/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
+/* different pages for EXTD access for MXL86111 */
+/* SerDes/PHY Control Access Register - COM_EXT_SMI_SDS_PHY */
+#define MXL86111_EXT_SMI_SDS_PHY_REG			0xA000
+#define MXL86111_EXT_SMI_SDS_PHYSPACE_MASK		BIT(1)
+#define MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE		(0x1 << 1)
+#define MXL86111_EXT_SMI_SDS_PHYUTP_SPACE		(0x0 << 1)
+#define MXL86111_EXT_SMI_SDS_PHY_AUTO			0xff
+
+/* SyncE Configuration Register - COM_EXT_SYNCE_CFG */
 #define MXL86110_EXT_SYNCE_CFG_REG			0xA012
 #define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL		BIT(4)
 #define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN	BIT(5)
@@ -117,9 +126,67 @@
 
 /* Chip Configuration Register - COM_EXT_CHIP_CFG */
 #define MXL86110_EXT_CHIP_CFG_REG			0xA001
+#define MXL86111_EXT_CHIP_CFG_MODE_SEL_MASK		GENMASK(2, 0)
+#define MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_RGMII		0
+#define MXL86111_EXT_CHIP_CFG_MODE_FIBER_TO_RGMII	1
+#define MXL86111_EXT_CHIP_CFG_MODE_UTP_FIBER_TO_RGMII	2
+#define MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_SGMII		3
+#define MXL86111_EXT_CHIP_CFG_MODE_SGPHY_TO_RGMAC	4
+#define MXL86111_EXT_CHIP_CFG_MODE_SGMAC_TO_RGPHY	5
+#define MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_FIBER_AUTO	6
+#define MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_FIBER_FORCE	7
+
+#define MXL86111_EXT_CHIP_CFG_CLDO_MASK			GENMASK(5, 4)
+#define MXL86111_EXT_CHIP_CFG_CLDO_3V3			0
+#define MXL86111_EXT_CHIP_CFG_CLDO_2V5			1
+#define MXL86111_EXT_CHIP_CFG_CLDO_1V8_2		2
+#define MXL86111_EXT_CHIP_CFG_CLDO_1V8_3		3
+#define MXL86111_EXT_CHIP_CFG_CLDO_SHIFT		4
+#define MXL86111_EXT_CHIP_CFG_ELDO			BIT(6)
 #define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE		BIT(8)
 #define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE		BIT(15)
 
+/* Specific Status Register - PHY_STAT */
+#define MXL86111_PHY_STAT_REG				0x11
+#define MXL86111_PHY_STAT_SPEED_MASK			GENMASK(15, 14)
+#define MXL86111_PHY_STAT_SPEED_OFFSET			14
+#define MXL86111_PHY_STAT_SPEED_10M			0x0
+#define MXL86111_PHY_STAT_SPEED_100M			0x1
+#define MXL86111_PHY_STAT_SPEED_1000M			0x2
+#define MXL86111_PHY_STAT_DPX_OFFSET			13
+#define MXL86111_PHY_STAT_DPX				BIT(13)
+#define MXL86111_PHY_STAT_LSRT				BIT(10)
+
+/* 3 phy reg page modes,auto mode combines utp and fiber mode*/
+#define MXL86111_MODE_FIBER				0x1
+#define MXL86111_MODE_UTP				0x2
+#define MXL86111_MODE_AUTO				0x3
+
+/* FIBER Auto-Negotiation link partner ability - SDS_AN_LPA */
+#define MXL86111_SDS_AN_LPA_PAUSE			(0x3 << 7)
+#define MXL86111_SDS_AN_LPA_ASYM_PAUSE			(0x2 << 7)
+
+/* Miscellaneous Control Register - COM_EXT _MISC_CFG */
+#define MXL86111_EXT_MISC_CONFIG_REG			0xa006
+#define MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL		BIT(0)
+#define MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL_1000BX	(0x1 << 0)
+#define MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL_100BX	(0x0 << 0)
+
+/* Phy fiber Link timer cfg2 Register - EXT_SDS_LINK_TIMER_CFG2 */
+#define MXL86111_EXT_SDS_LINK_TIMER_CFG2_REG		0xA5
+#define MXL86111_EXT_SDS_LINK_TIMER_CFG2_EN_AUTOSEN	BIT(15)
+
+/* default values of PHY register, required for Dual Media mode */
+#define MII_BMSR_DEFAULT_VAL		0x7949
+#define MII_ESTATUS_DEFAULT_VAL		0x2000
+
+/* Timeout in ms for PHY SW reset check in STD_CTRL/SDS_CTRL */
+#define BMCR_RESET_TIMEOUT		500
+
+/* PL P1 requires optimized RGMII timing for 1.8V RGMII voltage
+ */
+#define MXL86111_PL_P1				0x500
+
 /**
  * __mxl86110_write_extended_reg() - write to a PHY's extended register
  * @phydev: pointer to the PHY device structure
@@ -571,22 +638,15 @@ static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
 }
 
 /**
- * mxl86110_config_init() - initialize the PHY
+ * mxl86110_config_rgmii_delay() - configure RGMII delays
  * @phydev: pointer to the phy_device
  *
  * Return: 0 or negative errno code
  */
-static int mxl86110_config_init(struct phy_device *phydev)
+static int mxl86110_config_rgmii_delay(struct phy_device *phydev)
 {
-	u16 val = 0;
 	int ret;
-
-	phy_lock_mdio_bus(phydev);
-
-	/* configure syncE / clk output */
-	ret = mxl86110_synce_clk_cfg(phydev);
-	if (ret < 0)
-		goto out;
+	u16 val;
 
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
@@ -628,6 +688,31 @@ static int mxl86110_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		goto out;
 
+out:
+	return ret;
+}
+
+/**
+ * mxl86110_config_init() - initialize the MXL86110 PHY
+ * @phydev: pointer to the phy_device
+ *
+ * Return: 0 or negative errno code
+ */
+static int mxl86110_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* configure syncE / clk output */
+	ret = mxl86110_synce_clk_cfg(phydev);
+	if (ret < 0)
+		goto out;
+
+	ret = mxl86110_config_rgmii_delay(phydev);
+	if (ret < 0)
+		goto out;
+
 	ret = mxl86110_enable_led_activity_blink(phydev);
 	if (ret < 0)
 		goto out;
@@ -639,6 +724,201 @@ static int mxl86110_config_init(struct phy_device *phydev)
 	return ret;
 }
 
+/**
+ * mxl86111_probe() - validate bootstrap chip config and set UTP page
+ * @phydev: pointer to the phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int mxl86111_probe(struct phy_device *phydev)
+{
+	int chip_config;
+	u16 reg_page;
+	int ret;
+
+	chip_config = mxl86110_read_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG);
+	if (chip_config < 0)
+		return chip_config;
+
+	switch (chip_config & MXL86111_EXT_CHIP_CFG_MODE_SEL_MASK) {
+	case MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_SGMII:
+	case MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_RGMII:
+		phydev->port = PORT_TP;
+		reg_page = MXL86111_EXT_SMI_SDS_PHYUTP_SPACE;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = mxl86110_write_extended_reg(phydev,
+					  MXL86111_EXT_SMI_SDS_PHY_REG,
+					  MXL86111_EXT_SMI_SDS_PHYUTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * mxl86111_config_init() - initialize the MXL86111 PHY
+ * @phydev: pointer to the phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int mxl86111_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* configure syncE / clk output */
+	ret = mxl86110_synce_clk_cfg(phydev);
+	if (ret < 0)
+		goto out;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_100BASEX:
+		ret = __mxl86110_modify_extended_reg(phydev,
+						     MXL86111_EXT_MISC_CONFIG_REG,
+						     MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL,
+						     MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL_100BX);
+		if (ret < 0)
+			goto out;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		ret = __mxl86110_modify_extended_reg(phydev,
+						     MXL86111_EXT_MISC_CONFIG_REG,
+						     MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL,
+						     MXL86111_EXT_MISC_CONFIG_FIB_SPEED_SEL_1000BX);
+		if (ret < 0)
+			goto out;
+		break;
+	default:
+		/* RGMII modes */
+		ret = mxl86110_config_rgmii_delay(phydev);
+		if (ret < 0)
+			goto out;
+		ret = __mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
+						     MXL86110_EXT_RGMII_CFG1_FULL_MASK, ret);
+
+		/* PL P1 requires optimized RGMII timing for 1.8V RGMII voltage
+		 */
+		ret = __mxl86110_read_extended_reg(phydev, 0xf);
+		if (ret < 0)
+			goto out;
+
+		if (ret == MXL86111_PL_P1) {
+			ret = __mxl86110_read_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG);
+			if (ret < 0)
+				goto out;
+
+			/* check if LDO is in 1.8V mode */
+			switch (FIELD_GET(MXL86111_EXT_CHIP_CFG_CLDO_MASK, ret)) {
+			case MXL86111_EXT_CHIP_CFG_CLDO_1V8_3:
+			case MXL86111_EXT_CHIP_CFG_CLDO_1V8_2:
+				ret = __mxl86110_write_extended_reg(phydev, 0xa010, 0xabff);
+				if (ret < 0)
+					goto out;
+				break;
+			default:
+				break;
+			}
+		}
+		break;
+	}
+
+	ret = mxl86110_enable_led_activity_blink(phydev);
+	if (ret < 0)
+		goto out;
+
+	ret = mxl86110_broadcast_cfg(phydev);
+out:
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+/**
+ * mxl86111_read_page() - read reg page
+ * @phydev: pointer to the phy_device
+ *
+ * returns current reg space of mxl86111 or negative errno code
+ */
+static int mxl86111_read_page(struct phy_device *phydev)
+{
+	int page;
+
+	page = __mxl86110_read_extended_reg(phydev, MXL86111_EXT_SMI_SDS_PHY_REG);
+	if (page < 0)
+		return page;
+
+	return page & MXL86111_EXT_SMI_SDS_PHYSPACE_MASK;
+};
+
+/**
+ * mxl86111_write_page() - Set reg page
+ * @phydev: pointer to the phy_device
+ * @page: The reg page to set
+ *
+ * returns 0 or negative errno code
+ */
+static int mxl86111_write_page(struct phy_device *phydev, int page)
+{
+	return __mxl86110_modify_extended_reg(phydev, MXL86111_EXT_SMI_SDS_PHY_REG,
+					      MXL86111_EXT_SMI_SDS_PHYSPACE_MASK, page);
+};
+
+static int mxl86111_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	int ret;
+
+	ret = phy_modify_paged(phydev, MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE,
+			       MII_BMCR, BMCR_ANENABLE,
+			       (modes == LINK_INBAND_DISABLE) ? 0 : BMCR_ANENABLE);
+	if (ret < 0)
+		goto out;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __mxl86110_modify_extended_reg(phydev, MXL86111_EXT_SDS_LINK_TIMER_CFG2_REG,
+					     MXL86111_EXT_SDS_LINK_TIMER_CFG2_EN_AUTOSEN,
+					     (modes == LINK_INBAND_DISABLE) ? 0 :
+					     MXL86111_EXT_SDS_LINK_TIMER_CFG2_EN_AUTOSEN);
+	if (ret < 0)
+		goto out;
+
+	ret = __mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG,
+					     MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE, 0);
+	if (ret < 0)
+		goto out;
+
+	/* For fiber forced mode, power down/up to re-aneg */
+	if (modes != LINK_INBAND_DISABLE) {
+		__phy_modify(phydev, MII_BMCR, 0, BMCR_PDOWN);
+		usleep_range(1000, 1050);
+		__phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	}
+
+out:
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static unsigned int mxl86111_inband_caps(struct phy_device *phydev,
+					 phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_100BASEX:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+	default:
+		return 0;
+	}
+}
+
 static struct phy_driver mxl_phy_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
@@ -648,8 +928,24 @@ static struct phy_driver mxl_phy_drvs[] = {
 		.set_wol		= mxl86110_set_wol,
 		.led_brightness_set	= mxl86110_led_brightness_set,
 		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
-		.led_hw_control_get     = mxl86110_led_hw_control_get,
-		.led_hw_control_set     = mxl86110_led_hw_control_set,
+		.led_hw_control_get	= mxl86110_led_hw_control_get,
+		.led_hw_control_set	= mxl86110_led_hw_control_set,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_MXL86111),
+		.name			= "MXL86111 Gigabit Ethernet",
+		.probe			= mxl86111_probe,
+		.config_init		= mxl86111_config_init,
+		.get_wol		= mxl86110_get_wol,
+		.set_wol		= mxl86110_set_wol,
+		.inband_caps		= mxl86111_inband_caps,
+		.config_inband		= mxl86111_config_inband,
+		.read_page		= mxl86111_read_page,
+		.write_page		= mxl86111_write_page,
+		.led_brightness_set	= mxl86110_led_brightness_set,
+		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
+		.led_hw_control_get	= mxl86110_led_hw_control_get,
+		.led_hw_control_set	= mxl86110_led_hw_control_set,
 	},
 };
 
@@ -657,11 +953,12 @@ module_phy_driver(mxl_phy_drvs);
 
 static const struct mdio_device_id __maybe_unused mxl_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_MXL86110) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_MXL86111) },
 	{  }
 };
 
 MODULE_DEVICE_TABLE(mdio, mxl_tbl);
 
-MODULE_DESCRIPTION("MaxLinear MXL86110 PHY driver");
+MODULE_DESCRIPTION("MaxLinear MXL86110/MXL86111 PHY driver");
 MODULE_AUTHOR("Stefano Radaelli");
 MODULE_LICENSE("GPL");
-- 
2.50.1


