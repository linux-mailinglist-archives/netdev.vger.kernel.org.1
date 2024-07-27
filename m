Return-Path: <netdev+bounces-113349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1493DE1C
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DC9B22755
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62711481B7;
	Sat, 27 Jul 2024 09:20:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-108.mail.aliyun.com (out28-108.mail.aliyun.com [115.124.28.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25374381D4;
	Sat, 27 Jul 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072048; cv=none; b=m8yT7s+0jefgSniqstiQpdtSaVz0gQL/xyAN56wuDf3mjo0g3TSCZpBzH1DkK0m+fqKbucaODd4jI5WPnQ6FxNLjwzum4kKlB6IW3mmYgUtes5bI73rhYYOh+9a7ergIlsGxnKBWM7BuuufVgJeyvh0lRNc2deudTK75OOXmB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072048; c=relaxed/simple;
	bh=74A2s7vxWkQUAFkfwzhHlPEAfhym4PNH7y5ZZsp0RZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqe2zMSiyZpV39v4+fkFvagzMBqDp+62bBUUwtqIuVObN2jFH+8MMhcxwMkBdLwDk3FZyPYxx/xRT1E+FvDkm4Pd1r/iN9nsbqxWALm1CBNITWO6EbT5pcDS/r9ULd81ePHDBkou8wdVfOyOZ+RRxxpqRb29MmOSZFmEDplZLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;BR=01201311R191S32rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00906682-0.148041-0.842893;FP=14625825964503354483|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=frank.sae@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.Yb7C3Yx_1722072033;
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Yb7C3Yx_1722072033)
          by smtp.aliyun-inc.com;
          Sat, 27 Jul 2024 17:20:40 +0800
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Sat, 27 Jul 2024 02:20:31 -0700
Message-Id: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Add a driver for the motorcomm yt8821 2.5G ethernet phy.
 Verified the driver on
 BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
 which is developed by Guangdong Bipai Technology Co., Ltd..
 On the board, yt8821 2.5G ethernet phy works in
 AUTO_BX2500_SGMII or FORCE_BX2500 interface,
 supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
 Since some functions of yt8821 are similar to YT8521
 so some functions for yt8821 can be reused.

Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 639 +++++++++++++++++++++++++++++++++++-
 1 file changed, 636 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 7a11fdb687cc..a432b27dd849 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8531/8531S PHY driver.
+ * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
@@ -16,7 +16,7 @@
 #define PHY_ID_YT8521		0x0000011a
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
-
+#define PHY_ID_YT8821		0x4f51ea19
 /* YT8521/YT8531S Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
@@ -52,6 +52,15 @@
 #define YTPHY_SSR_SPEED_10M			0x0
 #define YTPHY_SSR_SPEED_100M			0x1
 #define YTPHY_SSR_SPEED_1000M			0x2
+/* bit9 as speed_mode[2], bit15:14 as Speed_mode[1:0]
+ * Speed_mode[2:0]:
+ * 100 = 2P5G
+ * 011 = 10G
+ * 010 = 1000 Mbps
+ * 001 = 100 Mbps
+ * 000 = 10 Mbps
+ */
+#define YT8821_SSR_SPEED_2500M			0x4
 #define YTPHY_SSR_DUPLEX_OFFSET			13
 #define YTPHY_SSR_DUPLEX			BIT(13)
 #define YTPHY_SSR_PAGE_RECEIVED			BIT(12)
@@ -270,12 +279,59 @@
 #define YT8531_SCR_CLK_SRC_REF_25M		4
 #define YT8531_SCR_CLK_SRC_SSC_25M		5
 
+#define YT8821_SDS_EXT_CSR_CTRL_REG			0x23
+#define YT8821_SDS_EXT_CSR_PLL_SETTING			0x8605
+#define YT8821_UTP_EXT_FFE_IPR_CTRL_REG			0x34E
+#define YT8821_UTP_EXT_FFE_SETTING			0x8080
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG		0x4D2
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_SHT_SETTING		0x5200
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG		0x4D3
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_SHT_SETTING		0x5200
+#define YT8821_UTP_EXT_TRACE_CTRL_REG			0x372
+#define YT8821_UTP_EXT_TRACE_LNG_MED_GAIN_THR_SETTING	0x5A3C
+#define YT8821_UTP_EXT_IPR_CTRL_REG			0x374
+#define YT8821_UTP_EXT_IPR_ALPHA_IPR_SETTING		0x7C6C
+#define YT8821_UTP_EXT_ECHO_CTRL_REG			0x336
+#define YT8821_UTP_EXT_ECHO_SETTING			0xAA0A
+#define YT8821_UTP_EXT_GAIN_CTRL_REG			0x340
+#define YT8821_UTP_EXT_AGC_MED_GAIN_SETTING		0x3022
+#define YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG		0x36A
+#define YT8821_UTP_EXT_TH_20DB_2500_SETTING		0x8000
+#define YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG		0x4B3
+#define YT8821_UTP_EXT_MU_COARSE_FR_FFE_GN_DC_SETTING	0x7711
+#define YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG		0x4B5
+#define YT8821_UTP_EXT_MU_FINE_FR_FFE_GN_DC_SETTING	0x2211
+#define YT8821_UTP_EXT_ANALOG_CFG7_CTRL_REG		0x56
+#define YT8821_UTP_EXT_ANALOG_CFG7_RESET		0x20
+#define YT8821_UTP_EXT_ANALOG_CFG7_PI_CLK_SEL_AFE	0x3F
+#define YT8821_UTP_EXT_VCT_CFG6_CTRL_REG		0x97
+#define YT8821_UTP_EXT_VCT_CFG6_FECHO_AMP_TH_SETTING	0x380C
+#define YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG		0x660
+#define YT8821_UTP_EXT_TXGE_NFR_FR_SETTING		0x112A
+#define YT8821_UTP_EXT_PLL_CTRL_REG			0x450
+#define YT8821_UTP_EXT_PLL_SPARE_SETTING		0xE9
+#define YT8821_UTP_EXT_DAC_IMID_CHANNEL23_CTRL_REG	0x466
+#define YT8821_UTP_EXT_DAC_IMID_CHANNEL23_SETTING	0x6464
+#define YT8821_UTP_EXT_DAC_IMID_CHANNEL01_CTRL_REG	0x467
+#define YT8821_UTP_EXT_DAC_IMID_CHANNEL01_SETTING	0x6464
+#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_CTRL_REG	0x468
+#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_SETTING	0x6464
+#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_CTRL_REG	0x469
+#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_SETTING	0x6464
 /* Extended Register  end */
 
 #define YTPHY_DTS_OUTPUT_CLK_DIS		0
 #define YTPHY_DTS_OUTPUT_CLK_25M		25000000
 #define YTPHY_DTS_OUTPUT_CLK_125M		125000000
 
+#define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
+#define YT8821_CHIP_MODE_FORCE_BX2500		1
+
+struct yt8821_priv {
+	/* chip mode: AUTO_BX2500_SGMII/FORCE_BX2500 */
+	u32 chip_mode;
+};
+
 struct yt8521_priv {
 	/* combo_advertising is used for case of YT8521 in combo mode,
 	 * this means that yt8521 may work in utp or fiber mode which depends
@@ -2252,6 +2308,564 @@ static int yt8521_get_features(struct phy_device *phydev)
 	return ret;
 }
 
+/**
+ * yt8821_probe() - read dts to get chip mode
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_probe(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
+	struct yt8821_priv *priv;
+	u8 chip_mode;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	if (of_property_read_u8(node, "motorcomm,chip-mode", &chip_mode))
+		chip_mode = YT8821_CHIP_MODE_FORCE_BX2500;
+
+	switch (chip_mode) {
+	case YT8821_CHIP_MODE_AUTO_BX2500_SGMII:
+		priv->chip_mode = YT8821_CHIP_MODE_AUTO_BX2500_SGMII;
+		break;
+	case YT8821_CHIP_MODE_FORCE_BX2500:
+		priv->chip_mode = YT8821_CHIP_MODE_FORCE_BX2500;
+		break;
+	default:
+		phydev_warn(phydev, "chip_mode err:%d\n", chip_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * yt8821_get_features - read mmd register to get 2.5G capability
+ * @phydev: target phy_device struct
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_get_features(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
+
+	return genphy_read_abilities(phydev);
+}
+
+/**
+ * yt8821_get_rate_matching - read register to get phy chip mode
+ * @phydev: target phy_device struct
+ * @iface: PHY data interface type
+ *
+ * returns rate matching type or negative errno code
+ */
+static int yt8821_get_rate_matching(struct phy_device *phydev,
+				    phy_interface_t iface)
+{
+	int val;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	if (val < 0)
+		return val;
+
+	if ((val & YT8521_CCR_MODE_SEL_MASK) ==
+		YT8821_CHIP_MODE_FORCE_BX2500) {
+		return RATE_MATCH_PAUSE;
+	}
+
+	return RATE_MATCH_NONE;
+}
+
+/**
+ * yt8821_aneg_done() - determines the auto negotiation result
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0(no link)or 1(utp link) or negative errno code
+ */
+static int yt8821_aneg_done(struct phy_device *phydev)
+{
+	int link;
+
+	link = yt8521_aneg_done_paged(phydev, YT8521_RSSR_UTP_SPACE);
+
+	return link;
+}
+
+/**
+ * yt8821gen_init_paged() - generic initialization according to page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: The reg page(YT8521_RSSR_FIBER_SPACE/YT8521_RSSR_UTP_SPACE) to
+ * operate.
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821gen_init_paged(struct phy_device *phydev, int page)
+{
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, page & YT8521_RSSR_SPACE_MASK);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	if (page & YT8521_RSSR_SPACE_MASK) {
+		/* sds init */
+		ret = __phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, YT8821_SDS_EXT_CSR_CTRL_REG,
+				      YT8821_SDS_EXT_CSR_PLL_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+	} else {
+		/* utp init */
+		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_FFE_IPR_CTRL_REG,
+				      YT8821_UTP_EXT_FFE_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG,
+				      YT8821_UTP_EXT_VGA_LPF1_CAP_SHT_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG,
+				      YT8821_UTP_EXT_VGA_LPF2_CAP_SHT_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_TRACE_CTRL_REG,
+				      YT8821_UTP_EXT_TRACE_LNG_MED_GAIN_THR_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_IPR_CTRL_REG,
+				      YT8821_UTP_EXT_IPR_ALPHA_IPR_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_ECHO_CTRL_REG,
+				      YT8821_UTP_EXT_ECHO_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_GAIN_CTRL_REG,
+				      YT8821_UTP_EXT_AGC_MED_GAIN_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG,
+				      YT8821_UTP_EXT_TH_20DB_2500_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG,
+				      YT8821_UTP_EXT_MU_COARSE_FR_FFE_GN_DC_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG,
+				      YT8821_UTP_EXT_MU_FINE_FR_FFE_GN_DC_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_ANALOG_CFG7_CTRL_REG,
+				      YT8821_UTP_EXT_ANALOG_CFG7_RESET);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_ANALOG_CFG7_CTRL_REG,
+				      YT8821_UTP_EXT_ANALOG_CFG7_PI_CLK_SEL_AFE);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_VCT_CFG6_CTRL_REG,
+				      YT8821_UTP_EXT_VCT_CFG6_FECHO_AMP_TH_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG,
+				      YT8821_UTP_EXT_TXGE_NFR_FR_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_PLL_CTRL_REG,
+				      YT8821_UTP_EXT_PLL_SPARE_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_DAC_IMID_CHANNEL23_CTRL_REG,
+				      YT8821_UTP_EXT_DAC_IMID_CHANNEL23_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_DAC_IMID_CHANNEL01_CTRL_REG,
+				      YT8821_UTP_EXT_DAC_IMID_CHANNEL01_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_CTRL_REG,
+				      YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev,
+				      YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_CTRL_REG,
+				      YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_SETTING);
+		if (ret < 0)
+			goto err_restore_page;
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8821gen_init() - generic initialization
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821gen_init(struct phy_device *phydev)
+{
+	int ret = 0;
+
+	ret = yt8821gen_init_paged(phydev, YT8521_RSSR_FIBER_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return yt8821gen_init_paged(phydev, YT8521_RSSR_UTP_SPACE);
+}
+
+/**
+ * yt8821_auto_sleep_config() - phy auto sleep config
+ * @phydev: a pointer to a &struct phy_device
+ * @enable: true enable auto sleep, false disable auto sleep
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_auto_sleep_config(struct phy_device *phydev, bool enable)
+{
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	ret = ytphy_modify_ext(phydev,
+			       YT8521_EXTREG_SLEEP_CONTROL1_REG,
+			       YT8521_ESC1R_SLEEP_SW,
+			       enable ? 1 : 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8821_soft_reset() - soft reset utp and serdes
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_soft_reset(struct phy_device *phydev)
+{
+	return ytphy_modify_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG,
+					  YT8521_CCR_SW_RST, 0);
+}
+
+/**
+ * yt8821_config_init() - phy initializatioin
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_config_init(struct phy_device *phydev)
+{
+	struct yt8821_priv *priv = phydev->priv;
+	int ret, val;
+
+	phydev->irq = PHY_POLL;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	if (priv->chip_mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YT8521_CHIP_CONFIG_REG,
+						 YT8521_CCR_MODE_SEL_MASK,
+						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 0));
+		if (ret < 0)
+			return ret;
+
+		__assign_bit(PHY_INTERFACE_MODE_2500BASEX,
+			     phydev->possible_interfaces,
+			     true);
+		__assign_bit(PHY_INTERFACE_MODE_SGMII,
+			     phydev->possible_interfaces,
+			     true);
+
+		phydev->rate_matching = RATE_MATCH_NONE;
+	} else if (priv->chip_mode == YT8821_CHIP_MODE_FORCE_BX2500) {
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YT8521_CHIP_CONFIG_REG,
+						 YT8521_CCR_MODE_SEL_MASK,
+						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 1));
+		if (ret < 0)
+			return ret;
+
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+	}
+
+	ret = yt8821gen_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* disable auto sleep */
+	ret = yt8821_auto_sleep_config(phydev, false);
+	if (ret < 0)
+		return ret;
+
+	/* soft reset */
+	yt8821_soft_reset(phydev);
+
+	return ret;
+}
+
+/**
+ * yt8821_adjust_status() - update speed and duplex to phydev
+ * @phydev: a pointer to a &struct phy_device
+ * @val: read from YTPHY_SPECIFIC_STATUS_REG
+ */
+static void yt8821_adjust_status(struct phy_device *phydev, int val)
+{
+	int speed_mode, duplex;
+	int speed_mode_low, speed_mode_high;
+	int speed = SPEED_UNKNOWN;
+
+	duplex = FIELD_GET(YTPHY_SSR_DUPLEX, val);
+
+	speed_mode_low = FIELD_GET(GENMASK(15, 14), val);
+	speed_mode_high = FIELD_GET(BIT(9), val);
+	speed_mode = FIELD_PREP(BIT(2), speed_mode_high) |
+			FIELD_PREP(GENMASK(1, 0), speed_mode_low);
+	switch (speed_mode) {
+	case YTPHY_SSR_SPEED_10M:
+		speed = SPEED_10;
+		break;
+	case YTPHY_SSR_SPEED_100M:
+		speed = SPEED_100;
+		break;
+	case YTPHY_SSR_SPEED_1000M:
+		speed = SPEED_1000;
+		break;
+	case YT8821_SSR_SPEED_2500M:
+		speed = SPEED_2500;
+		break;
+	default:
+		speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	phydev->speed = speed;
+	phydev->duplex = duplex;
+}
+
+/**
+ * yt8821_update_interface() - update interface per current speed
+ * @phydev: a pointer to a &struct phy_device
+ */
+static void yt8821_update_interface(struct phy_device *phydev)
+{
+	if (!phydev->link)
+		return;
+
+	switch (phydev->speed) {
+	case SPEED_2500:
+		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		break;
+	case SPEED_1000:
+	case SPEED_100:
+	case SPEED_10:
+		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		break;
+	default:
+		phydev_warn(phydev, "phy speed err:%d\n", phydev->speed);
+		break;
+	}
+}
+
+/**
+ * yt8821_read_status() -  determines the negotiated speed and duplex
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_read_status(struct phy_device *phydev)
+{
+	struct yt8821_priv *priv = phydev->priv;
+	int old_page;
+	int ret = 0;
+	int link;
+	int val;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		int lpadv = phy_read_mmd(phydev,
+					 MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+
+		if (lpadv < 0)
+			return lpadv;
+
+		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
+						  lpadv);
+	}
+
+	ret = ytphy_write_ext_with_lock(phydev,
+					YT8521_REG_SPACE_SELECT_REG,
+					YT8521_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	val = __phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	if (val < 0) {
+		ret = val;
+		goto err_restore_page;
+	}
+
+	link = val & YTPHY_SSR_LINK;
+	if (link)
+		yt8821_adjust_status(phydev, val);
+
+	if (link) {
+		if (phydev->link == 0)
+			phydev_info(phydev,
+				    "%s, phy addr: %d, link up, mii reg 0x%x = 0x%x\n",
+				    __func__, phydev->mdio.addr,
+				    YTPHY_SPECIFIC_STATUS_REG,
+				    (unsigned int)val);
+		phydev->link = 1;
+	} else {
+		if (phydev->link == 1)
+			phydev_info(phydev, "%s, phy addr: %d, link down\n",
+				    __func__, phydev->mdio.addr);
+		phydev->link = 0;
+	}
+
+	if (priv->chip_mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII)
+		yt8821_update_interface(phydev);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8821_modify_utp_fiber_bmcr - bits modify a PHY's BMCR register
+ * @phydev: the phy_device struct
+ * @mask: bit mask of bits to clear
+ * @set: bit mask of bits to set
+ *
+ * NOTE: Convenience function which allows a PHY's BMCR register to be
+ * modified as new register value = (old register value & ~mask) | set.
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_modify_utp_fiber_bmcr(struct phy_device *phydev, u16 mask,
+					u16 set)
+{
+	int ret;
+
+	ret = yt8521_modify_bmcr_paged(phydev, YT8521_RSSR_UTP_SPACE,
+				       mask, set);
+	if (ret < 0)
+		return ret;
+
+	return yt8521_modify_bmcr_paged(phydev, YT8521_RSSR_FIBER_SPACE,
+					mask, set);
+}
+
+/**
+ * yt8821_suspend() - suspend the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_suspend(struct phy_device *phydev)
+{
+	int wol_config;
+
+	wol_config = ytphy_read_ext_with_lock(phydev, YTPHY_WOL_CONFIG_REG);
+	if (wol_config < 0)
+		return wol_config;
+
+	/* if wol enable, do nothing */
+	if (wol_config & YTPHY_WCR_ENABLE)
+		return 0;
+
+	return yt8821_modify_utp_fiber_bmcr(phydev, 0, BMCR_PDOWN);
+}
+
+/**
+ * yt8821_resume() - resume the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8821_resume(struct phy_device *phydev)
+{
+	int wol_config;
+	int ret;
+
+	/* disable auto sleep */
+	ret = yt8821_auto_sleep_config(phydev, false);
+	if (ret < 0)
+		return ret;
+
+	wol_config = ytphy_read_ext_with_lock(phydev, YTPHY_WOL_CONFIG_REG);
+	if (wol_config < 0)
+		return wol_config;
+
+	/* if wol enable, do nothing */
+	if (wol_config & YTPHY_WCR_ENABLE)
+		return 0;
+
+	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
+}
+
 static struct phy_driver motorcomm_phy_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
@@ -2307,11 +2921,29 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
+		.name			= "YT8821 2.5Gbps PHY",
+		.get_features		= yt8821_get_features,
+		.probe			= yt8821_probe,
+		.read_page		= yt8521_read_page,
+		.write_page		= yt8521_write_page,
+		.get_wol		= ytphy_get_wol,
+		.set_wol		= ytphy_set_wol,
+		.config_aneg		= genphy_config_aneg,
+		.aneg_done		= yt8821_aneg_done,
+		.config_init		= yt8821_config_init,
+		.get_rate_matching	= yt8821_get_rate_matching,
+		.read_status		= yt8821_read_status,
+		.soft_reset		= yt8821_soft_reset,
+		.suspend		= yt8821_suspend,
+		.resume			= yt8821_resume,
+	},
 };
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
 MODULE_LICENSE("GPL");
@@ -2321,6 +2953,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8521) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1


