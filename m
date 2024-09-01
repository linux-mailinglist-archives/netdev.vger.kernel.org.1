Return-Path: <netdev+bounces-124009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B5967598
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0D1C20EB0
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0A14B954;
	Sun,  1 Sep 2024 08:36:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698493BBC2;
	Sun,  1 Sep 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179774; cv=none; b=I2phdc0woJiicWq9uRwAUAqdWepuSGnhVquPLUQ/RH6NdC4PXQGOZ74vQE9RODRWeq+jQO3PM2OxlEKwqpeOnjoOc/FuglSOKpEP2JmuvrlQSE1AO7w1ugkL+7zrstPraeC7ILGaG+K17Kbh1YY4UshquXO1izL+ddxjhg4NFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179774; c=relaxed/simple;
	bh=yQS3tWV//Su/OYzBm7nBfbPeYl6SV3thKjNIDmBpXqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkjAczAv/5HZNI1rpbaKxSkDmzkbbIlfSP0XPKgQobOVZEo5iqNo+ynjOwSMx/+DEnPoMtRTbrYeB7SvVThE4MFOPf9gDojnbc3Gs/k8Ll/bsVsWWpHG1iLzQXc3mxkXfCU2xklDdqT6PMHiJPFcXj90sMaN60Oxmy9WS2E8Fv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z7fmnGt_1725179755)
          by smtp.aliyun-inc.com;
          Sun, 01 Sep 2024 16:35:58 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v5 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Sun,  1 Sep 2024 01:35:26 -0700
Message-Id: <20240901083526.163784-3-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the motorcomm yt8821 2.5G ethernet phy. Verified the
driver on BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
which is developed by Guangdong Bipai Technology Co., Ltd..

yt8821 2.5G ethernet phy works in AUTO_BX2500_SGMII or FORCE_BX2500
interface, supports 2.5G/1000M/100M/10M speeds, and wol(magic package).

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
v5:
  - added debug log when phy_select_page() returns an error.
v4:
  - removed all these pointless goto err_restore_page;
v3:
  - used existing API genphy_c45_pma_read_ext_abilities() to make source
    code more concise in yt8821_get_features().
  - used existing API genphy_c45_read_lpa() to make source code more
    concise in yt8821_read_status().
  - updated to return yt8521_aneg_done_paged() in yt8821_aneg_done();
  - moved __set_bit(PHY_INTERFACE_MODE_2500BASEX,
    phydev->possible_interfaces); out of these if() statements.
v2:
  - removed motorcomm,chip-mode property in DT.
  - modified the magic numbers of _SETTING macro.
  - added ":" after returns in function's DOC.
  - updated YTPHY_SSR_SPEED_2500M val from 0x4 ((0x0 << 14) | BIT(9)).
  - yt8821gen_init_paged(phydev, YT8521_RSSR_FIBER_SPACE) and
    yt8821gen_init_paged(phydev, YT8521_RSSR_UTP_SPACE) updated to
    yt8821_serdes_init() and yt8821_utp_init().
  - removed phydev->irq = PHY_POLL; in yt8821_config_init().
  - instead of phydev_info(), phydev_dbg() used in yt8821_read_status().
  - instead of __assign_bit(), __set_bit() used.
v1:
  - https://lore.kernel.org/netdev/20240727091906.1108588-1-Frank.Sae@motor-comm.com/
  - https://lore.kernel.org/netdev/20240727092009.1108640-1-Frank.Sae@motor-comm.com/
  - https://lore.kernel.org/netdev/20240727092031.1108690-1-Frank.Sae@motor-comm.com/
---
 drivers/net/phy/motorcomm.c | 671 +++++++++++++++++++++++++++++++++++-
 1 file changed, 667 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index fe0aabe12622..0e91f5d1a4fd 100644
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
@@ -16,8 +16,8 @@
 #define PHY_ID_YT8521		0x0000011a
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
-
-/* YT8521/YT8531S Register Overview
+#define PHY_ID_YT8821		0x4f51ea19
+/* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
  * |	UTP MII			|	FIBER MII		|
@@ -50,6 +50,8 @@
 #define YTPHY_SSR_SPEED_10M			((0x0 << 14))
 #define YTPHY_SSR_SPEED_100M			((0x1 << 14))
 #define YTPHY_SSR_SPEED_1000M			((0x2 << 14))
+#define YTPHY_SSR_SPEED_10G			((0x3 << 14))
+#define YTPHY_SSR_SPEED_2500M			((0x0 << 14) | BIT(9))
 #define YTPHY_SSR_DUPLEX_OFFSET			13
 #define YTPHY_SSR_DUPLEX			BIT(13)
 #define YTPHY_SSR_PAGE_RECEIVED			BIT(12)
@@ -268,12 +270,89 @@
 #define YT8531_SCR_CLK_SRC_REF_25M		4
 #define YT8531_SCR_CLK_SRC_SSC_25M		5
 
+#define YT8821_SDS_EXT_CSR_CTRL_REG			0x23
+#define YT8821_SDS_EXT_CSR_VCO_LDO_EN			BIT(15)
+#define YT8821_SDS_EXT_CSR_VCO_BIAS_LPF_EN		BIT(8)
+
+#define YT8821_UTP_EXT_PI_CTRL_REG			0x56
+#define YT8821_UTP_EXT_PI_RST_N_FIFO			BIT(5)
+#define YT8821_UTP_EXT_PI_TX_CLK_SEL_AFE		BIT(4)
+#define YT8821_UTP_EXT_PI_RX_CLK_3_SEL_AFE		BIT(3)
+#define YT8821_UTP_EXT_PI_RX_CLK_2_SEL_AFE		BIT(2)
+#define YT8821_UTP_EXT_PI_RX_CLK_1_SEL_AFE		BIT(1)
+#define YT8821_UTP_EXT_PI_RX_CLK_0_SEL_AFE		BIT(0)
+
+#define YT8821_UTP_EXT_VCT_CFG6_CTRL_REG		0x97
+#define YT8821_UTP_EXT_FECHO_AMP_TH_HUGE		GENMASK(15, 8)
+
+#define YT8821_UTP_EXT_ECHO_CTRL_REG			0x336
+#define YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000		GENMASK(14, 8)
+
+#define YT8821_UTP_EXT_GAIN_CTRL_REG			0x340
+#define YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_RPDN_CTRL_REG			0x34E
+#define YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500		BIT(15)
+#define YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500		BIT(7)
+#define YT8821_UTP_EXT_RPDN_IPR_SHT_2500		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG		0x36A
+#define YT8821_UTP_EXT_TH_20DB_2500			GENMASK(15, 0)
+
+#define YT8821_UTP_EXT_TRACE_CTRL_REG			0x372
+#define YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500		GENMASK(14, 8)
+#define YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_ALPHA_IPR_CTRL_REG		0x374
+#define YT8821_UTP_EXT_ALPHA_SHT_2500			GENMASK(14, 8)
+#define YT8821_UTP_EXT_IPR_LNG_2500			GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_PLL_CTRL_REG			0x450
+#define YT8821_UTP_EXT_PLL_SPARE_CFG			GENMASK(7, 0)
+
+#define YT8821_UTP_EXT_DAC_IMID_CH_2_3_CTRL_REG		0x466
+#define YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG		GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_DAC_IMID_CH_0_1_CTRL_REG		0x467
+#define YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG		GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_DAC_IMSB_CH_2_3_CTRL_REG		0x468
+#define YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG		GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_DAC_IMSB_CH_0_1_CTRL_REG		0x469
+#define YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG		GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG		0x4B3
+#define YT8821_UTP_EXT_MU_COARSE_FR_F_FFE		GENMASK(14, 12)
+#define YT8821_UTP_EXT_MU_COARSE_FR_F_FBE		GENMASK(10, 8)
+
+#define YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG		0x4B5
+#define YT8821_UTP_EXT_MU_FINE_FR_F_FFE			GENMASK(14, 12)
+#define YT8821_UTP_EXT_MU_FINE_FR_F_FBE			GENMASK(10, 8)
+
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG		0x4D2
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_OTHER		GENMASK(7, 4)
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_2500		GENMASK(3, 0)
+
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG		0x4D3
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_OTHER		GENMASK(7, 4)
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_2500		GENMASK(3, 0)
+
+#define YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG		0x660
+#define YT8821_UTP_EXT_NFR_TX_ABILITY			BIT(3)
 /* Extended Register  end */
 
 #define YTPHY_DTS_OUTPUT_CLK_DIS		0
 #define YTPHY_DTS_OUTPUT_CLK_25M		25000000
 #define YTPHY_DTS_OUTPUT_CLK_125M		125000000
 
+#define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
+#define YT8821_CHIP_MODE_FORCE_BX2500		1
+
 struct yt8521_priv {
 	/* combo_advertising is used for case of YT8521 in combo mode,
 	 * this means that yt8521 may work in utp or fiber mode which depends
@@ -2249,6 +2328,572 @@ static int yt8521_get_features(struct phy_device *phydev)
 	return ret;
 }
 
+/**
+ * yt8821_get_features - read mmd register to get 2.5G capability
+ * @phydev: target phy_device struct
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_ext_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_read_abilities(phydev);
+}
+
+/**
+ * yt8821_get_rate_matching - read register to get phy chip mode
+ * @phydev: target phy_device struct
+ * @iface: PHY data interface type
+ *
+ * Returns: rate matching type or negative errno code
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
+	if (FIELD_GET(YT8521_CCR_MODE_SEL_MASK, val) ==
+	    YT8821_CHIP_MODE_FORCE_BX2500)
+		return RATE_MATCH_PAUSE;
+
+	return RATE_MATCH_NONE;
+}
+
+/**
+ * yt8821_aneg_done() - determines the auto negotiation result
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0(no link)or 1(utp link) or negative errno code
+ */
+static int yt8821_aneg_done(struct phy_device *phydev)
+{
+	return yt8521_aneg_done_paged(phydev, YT8521_RSSR_UTP_SPACE);
+}
+
+/**
+ * yt8821_serdes_init() - serdes init
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_serdes_init(struct phy_device *phydev)
+{
+	int old_page;
+	int ret = 0;
+	u16 mask;
+	u16 set;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_FIBER_SPACE);
+	if (old_page < 0) {
+		phydev_err(phydev, "Failed to select page: %d\n",
+			   old_page);
+		goto err_restore_page;
+	}
+
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_SDS_EXT_CSR_VCO_LDO_EN |
+		YT8821_SDS_EXT_CSR_VCO_BIAS_LPF_EN;
+	set = YT8821_SDS_EXT_CSR_VCO_LDO_EN;
+	ret = ytphy_modify_ext(phydev, YT8821_SDS_EXT_CSR_CTRL_REG, mask,
+			       set);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8821_utp_init() - utp init
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_utp_init(struct phy_device *phydev)
+{
+	int old_page;
+	int ret = 0;
+	u16 mask;
+	u16 save;
+	u16 set;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
+	if (old_page < 0) {
+		phydev_err(phydev, "Failed to select page: %d\n",
+			   old_page);
+		goto err_restore_page;
+	}
+
+	mask = YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500 |
+		YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500 |
+		YT8821_UTP_EXT_RPDN_IPR_SHT_2500;
+	set = YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500 |
+		YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500;
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_RPDN_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_VGA_LPF1_CAP_OTHER |
+		YT8821_UTP_EXT_VGA_LPF1_CAP_2500;
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG,
+			       mask, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_VGA_LPF2_CAP_OTHER |
+		YT8821_UTP_EXT_VGA_LPF2_CAP_2500;
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG,
+			       mask, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500 |
+		YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500;
+	set = FIELD_PREP(YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500, 0x5a) |
+		FIELD_PREP(YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500, 0x3c);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_TRACE_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_IPR_LNG_2500;
+	set = FIELD_PREP(YT8821_UTP_EXT_IPR_LNG_2500, 0x6c);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_ALPHA_IPR_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000;
+	set = FIELD_PREP(YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000, 0x2a);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_ECHO_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000;
+	set = FIELD_PREP(YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000, 0x22);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_GAIN_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TH_20DB_2500;
+	set = FIELD_PREP(YT8821_UTP_EXT_TH_20DB_2500, 0x8000);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_MU_COARSE_FR_F_FFE |
+		YT8821_UTP_EXT_MU_COARSE_FR_F_FBE;
+	set = FIELD_PREP(YT8821_UTP_EXT_MU_COARSE_FR_F_FFE, 0x7) |
+		FIELD_PREP(YT8821_UTP_EXT_MU_COARSE_FR_F_FBE, 0x7);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_MU_FINE_FR_F_FFE |
+		YT8821_UTP_EXT_MU_FINE_FR_F_FBE;
+	set = FIELD_PREP(YT8821_UTP_EXT_MU_FINE_FR_F_FFE, 0x2) |
+		FIELD_PREP(YT8821_UTP_EXT_MU_FINE_FR_F_FBE, 0x2);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* save YT8821_UTP_EXT_PI_CTRL_REG's val for use later */
+	ret = ytphy_read_ext(phydev, YT8821_UTP_EXT_PI_CTRL_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	save = ret;
+
+	mask = YT8821_UTP_EXT_PI_TX_CLK_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_3_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_2_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_1_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_0_SEL_AFE;
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_PI_CTRL_REG,
+			       mask, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* restore YT8821_UTP_EXT_PI_CTRL_REG's val */
+	ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_PI_CTRL_REG, save);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_FECHO_AMP_TH_HUGE;
+	set = FIELD_PREP(YT8821_UTP_EXT_FECHO_AMP_TH_HUGE, 0x38);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_VCT_CFG6_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_NFR_TX_ABILITY;
+	set = YT8821_UTP_EXT_NFR_TX_ABILITY;
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_PLL_SPARE_CFG;
+	set = FIELD_PREP(YT8821_UTP_EXT_PLL_SPARE_CFG, 0xe9);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_PLL_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG |
+		YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMID_CH_2_3_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG |
+		YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMID_CH_0_1_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG |
+		YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMSB_CH_2_3_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG |
+		YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMSB_CH_0_1_CTRL_REG,
+			       mask, set);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8821_auto_sleep_config() - phy auto sleep config
+ * @phydev: a pointer to a &struct phy_device
+ * @enable: true enable auto sleep, false disable auto sleep
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_auto_sleep_config(struct phy_device *phydev,
+				    bool enable)
+{
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
+	if (old_page < 0) {
+		phydev_err(phydev, "Failed to select page: %d\n",
+			   old_page);
+		goto err_restore_page;
+	}
+
+	ret = ytphy_modify_ext(phydev,
+			       YT8521_EXTREG_SLEEP_CONTROL1_REG,
+			       YT8521_ESC1R_SLEEP_SW,
+			       enable ? 1 : 0);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8821_soft_reset() - soft reset utp and serdes
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
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
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_config_init(struct phy_device *phydev)
+{
+	u8 mode = YT8821_CHIP_MODE_AUTO_BX2500_SGMII;
+	int ret;
+	u16 set;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX)
+		mode = YT8821_CHIP_MODE_FORCE_BX2500;
+
+	set = FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, mode);
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8521_CHIP_CONFIG_REG,
+					 YT8521_CCR_MODE_SEL_MASK,
+					 set);
+	if (ret < 0)
+		return ret;
+
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  phydev->possible_interfaces);
+
+	if (mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  phydev->possible_interfaces);
+
+		phydev->rate_matching = RATE_MATCH_NONE;
+	} else if (mode == YT8821_CHIP_MODE_FORCE_BX2500) {
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+	}
+
+	ret = yt8821_serdes_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = yt8821_utp_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* disable auto sleep */
+	ret = yt8821_auto_sleep_config(phydev, false);
+	if (ret < 0)
+		return ret;
+
+	/* soft reset */
+	return yt8821_soft_reset(phydev);
+}
+
+/**
+ * yt8821_adjust_status() - update speed and duplex to phydev
+ * @phydev: a pointer to a &struct phy_device
+ * @val: read from YTPHY_SPECIFIC_STATUS_REG
+ */
+static void yt8821_adjust_status(struct phy_device *phydev, int val)
+{
+	int speed, duplex;
+	int speed_mode;
+
+	duplex = FIELD_GET(YTPHY_SSR_DUPLEX, val);
+	speed_mode = val & YTPHY_SSR_SPEED_MASK;
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
+	case YTPHY_SSR_SPEED_2500M:
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
+		phydev_warn(phydev, "phy speed err :%d\n", phydev->speed);
+		break;
+	}
+}
+
+/**
+ * yt8821_read_status() -  determines the negotiated speed and duplex
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_read_status(struct phy_device *phydev)
+{
+	int link;
+	int ret;
+	int val;
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
+	if (phydev->autoneg_complete) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	link = val & YTPHY_SSR_LINK;
+	if (link)
+		yt8821_adjust_status(phydev, val);
+
+	if (link) {
+		if (phydev->link == 0)
+			phydev_dbg(phydev,
+				   "%s, phy addr: %d, link up\n",
+				   __func__, phydev->mdio.addr);
+		phydev->link = 1;
+	} else {
+		if (phydev->link == 1)
+			phydev_dbg(phydev,
+				   "%s, phy addr: %d, link down\n",
+				   __func__, phydev->mdio.addr);
+		phydev->link = 0;
+	}
+
+	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	if (val < 0)
+		return val;
+
+	if (FIELD_GET(YT8521_CCR_MODE_SEL_MASK, val) ==
+	    YT8821_CHIP_MODE_AUTO_BX2500_SGMII)
+		yt8821_update_interface(phydev);
+
+	return 0;
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
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_modify_utp_fiber_bmcr(struct phy_device *phydev,
+					u16 mask, u16 set)
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
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_suspend(struct phy_device *phydev)
+{
+	int wol_config;
+
+	wol_config = ytphy_read_ext_with_lock(phydev,
+					      YTPHY_WOL_CONFIG_REG);
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
+ * Returns: 0 or negative errno code
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
+	wol_config = ytphy_read_ext_with_lock(phydev,
+					      YTPHY_WOL_CONFIG_REG);
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
@@ -2304,11 +2949,28 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
+		.name			= "YT8821 2.5Gbps PHY",
+		.get_features		= yt8821_get_features,
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
@@ -2318,6 +2980,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8521) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
 	{ /* sentinel */ }
 };
 
-- 
2.34.1


