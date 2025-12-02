Return-Path: <netdev+bounces-243189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C24C9B2F9
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D253A6272
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219BF28853E;
	Tue,  2 Dec 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="och9ENZG"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23F301714
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671722; cv=none; b=CWxBC+gxg4xP69RcLCm+5eG8xnwKfiaYIZKC6ptH9SUBmyqkYzMLpnSnWNpszkJc5hiMDgyUkGbbCyM7TXs+FZfHr1wBkC0FTZPCGaiY7LUG6snmMArewWIjQJV7OH3sdRUrHOvwd+Uf3IwpBOj0sZOIqrNqWZypUOVEEgV5A2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671722; c=relaxed/simple;
	bh=ii2+WtBXojxJJQ5VLoSw/fbDnrW80eNQiwDtF4c5lAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mprR3lqORTuAxd8fMQI7ETlfovPLm1G8bTNjK0PqcE8Hkeq/Ssl8g3sttZv2AovhphDHuXp86OyP5MtvW9qQPSjw2MOJrgzcOvit7S0RQDvlyw8rZPV2m0B27uuMb1njKrNcTl6268c8ZRZlYC2cI2hiEos/jDhdntRwy1eXIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=och9ENZG; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=och9ENZG;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5B2AMWJI2341656
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 10:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1764670951; bh=b7+PtiVGY7ZsuMRe6KMXqn5dYSvfYOUB0llRxgoMcTA=;
	h=From:To:Cc:Subject:Date:Message-ID:From;
	b=och9ENZG1ZGN3DchJvsEQcWdHsXde+Lxg6oZBiY+Df5CHYG4fIwiDgB5ATPl36CVN
	 bXbZIZ0Qwy/x3+Fe+N/ri3Mz/zq3FCScQgjmX+/oUcN0fmYrY7FSTD51HY5ziKZ1cA
	 Q5Mv+rcs6rGeheCo77GmMoOrpsO6mXf2JAlJsWtM=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5B2AMVCk2719902
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 11:22:31 +0100
Received: (nullmailer pid 1681547 invoked by uid 1000);
	Tue, 02 Dec 2025 10:22:31 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
Date: Tue,  2 Dec 2025 11:22:22 +0100
Message-ID: <20251202102222.1681522-1-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

The Airoha AN8811HB is mostly compatible with the EN8811H, adding 10Base-T
support and reducing power consumption.

Based on the vendor driver written by "Lucien.Jheng <lucien.jheng@airoha.com>"

The required firmware is not yet available in linux-firmware, but can be
downloaded from
https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/HEAD/21.02/files/target/linux/mediatek/base-files/lib/firmware/airoha/an8811hb

The driver has been tested with two firmware versions:

 Airoha AN8811HB mdio-bus:0d: MD32 firmware version: 25092412
 Airoha AN8811HB mdio-bus:0d: MD32 firmware version: 25110702

Cc: Lucien.Jheng <lucienzx159@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
Hello!

I am currently testing a couple of consumer routers with AN8811HB phys
and neeeded a driver. Sending this as an RFC for now, for several
reasons:
 - maybe some of you already had other plans for this?
 - firmware is not yet available in linux-firmware
 - I have no device with EN8811H so I can't verify that I didn't break
   it
 - not sure everyone agrees about merging this into the EN8811H driver?
 - there are probably missing parts here - EEE support for example

This patch should be applied on top of Vladimir's serdes polarity
series.

The AN8811HB changes are based solely on the vendor driver at
https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/HEAD/21.02/files/target/linux/mediatek/files-5.4/drivers/net/phy/air_an8811hb.c

The vendor driver is nice and clean, and could probably be used
as-is. But most of it appear to be a copy of the mainline
air_en8811h.c driver.  Such copying makes sense for a vendor who don't
care much about maintaining software for obsolete hardware. But it
creates problems for us. Maintaining duplicated code does not work
over time. IMHO it is easier to merge it from the start when that's
possible.

Appreciating any comments, including "stop this nonsense and wait for
my submission" :-)

And if someone is able to test on a EN8811H then I would be extremely
grateful.  That's obviously a requirement before I can upgrade this
from RFC


Bjørn


 drivers/net/phy/air_en8811h.c | 371 ++++++++++++++++++++++++++++++----
 1 file changed, 328 insertions(+), 43 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 4171fecb1def..2dd16e21d1ad 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Driver for the Airoha EN8811H 2.5 Gigabit PHY.
+ * Driver for the Airoha EN8811H and AN8811HB 2.5 Gigabit PHYs.
  *
- * Limitations of the EN8811H:
+ * Limitations:
  * - Only full duplex supported
  * - Forced speed (AN off) is not supported by hardware (100Mbps)
  *
  * Source originated from airoha's en8811h.c and en8811h.h v1.2.1
- *
- * Copyright (C) 2023 Airoha Technology Corp.
+ * with AN8811HB bits from air_an8811hb.c v0.0.4
+ #
+ * Copyright (C) 2023, 2025 Airoha Technology Corp.
  */
 
 #include <linux/clk.h>
@@ -21,9 +22,12 @@
 #include <linux/unaligned.h>
 
 #define EN8811H_PHY_ID		0x03a2a411
+#define AN8811HB_PHY_ID		0xc0ff04a0
 
 #define EN8811H_MD32_DM		"airoha/EthMD32.dm.bin"
 #define EN8811H_MD32_DSP	"airoha/EthMD32.DSP.bin"
+#define AN8811HB_MD32_DM	"airoha/an8811hb/EthMD32_CRC.DM.bin"
+#define AN8811HB_MD32_DSP	"airoha/an8811hb/EthMD32_CRC.DSP.bin"
 
 #define AIR_FW_ADDR_DM	0x00000000
 #define AIR_FW_ADDR_DSP	0x00100000
@@ -31,6 +35,7 @@
 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
 #define   AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
+#define   AIR_AUX_CTRL_STATUS_SPEED_10		0x0
 #define   AIR_AUX_CTRL_STATUS_SPEED_100		0x4
 #define   AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
 #define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
@@ -56,6 +61,7 @@
 #define EN8811H_PHY_FW_STATUS		0x8009
 #define   EN8811H_PHY_READY			0x02
 
+#define AIR_PHY_MCU_CMD_0		0x800b
 #define AIR_PHY_MCU_CMD_1		0x800c
 #define AIR_PHY_MCU_CMD_1_MODE1			0x0
 #define AIR_PHY_MCU_CMD_2		0x800d
@@ -65,6 +71,10 @@
 #define AIR_PHY_MCU_CMD_3_DOCMD			0x1100
 #define AIR_PHY_MCU_CMD_4		0x800f
 #define AIR_PHY_MCU_CMD_4_MODE1			0x0002
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_A		0x00d7
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_B		0x00d8
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_C		0x00d9
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_D		0x00da
 #define AIR_PHY_MCU_CMD_4_INTCLR		0x00e4
 
 /* Registers on MDIO_MMD_VEND2 */
@@ -106,6 +116,9 @@
 #define   AIR_PHY_LED_BLINK_2500RX		BIT(11)
 
 /* Registers on BUCKPBUS */
+#define AIR_PHY_CONTROL			0x3a9c
+#define   AIR_PHY_CONTROL_INTERNAL		BIT(11)
+
 #define EN8811H_2P5G_LPA		0x3b30
 #define   EN8811H_2P5G_LPA_2P5G			BIT(0)
 
@@ -129,6 +142,34 @@
 #define EN8811H_FW_CTRL_2		0x800000
 #define EN8811H_FW_CTRL_2_LOADING		BIT(11)
 
+#define AN8811HB_CRC_PM_SET1		0xf020c
+#define AN8811HB_CRC_PM_MON2		0xf0218
+#define AN8811HB_CRC_PM_MON3		0xf021c
+#define AN8811HB_CRC_DM_SET1		0xf0224
+#define AN8811HB_CRC_DM_MON2		0xf0230
+#define AN8811HB_CRC_DM_MON3		0xf0234
+#define   AN8811HB_CRC_RD_EN			BIT(0)
+#define   AN8811HB_CRC_ST			(BIT(0) | BIT(1))
+#define   AN8811HB_CRC_CHECK_PASS		BIT(0)
+
+#define AN8811HB_TX_POLARITY		0x5ce004
+#define   AN8811HB_TX_POLARITY_NORMAL		BIT(7)
+#define AN8811HB_RX_POLARITY		0x5ce61c
+#define   AN8811HB_RX_POLARITY_NORMAL		BIT(7)
+
+#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
+#define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
+
+#define AN8811HB_HWTRAP1		0x5cf910
+#define AN8811HB_HWTRAP2		0x5cf914
+#define   AN8811HB_HWTRAP2_CKO			BIT(28)
+
+#define AN8811HB_CLK_DRV		0x5cf9e4
+#define AN8811HB_CLK_DRV_CKO_MASK		GENMASK(14, 12)
+#define   AN8811HB_CLK_DRV_CKOPWD		BIT(12)
+#define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
+#define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
+
 /* Led definitions */
 #define EN8811H_LED_COUNT	3
 
@@ -461,33 +502,92 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 	return 0;
 }
 
+static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
+			      u32 mon2, u32 mon3)
+{
+	u32 pbus_value;
+	int retry = 25;
+	int ret;
+
+	/* Configure CRC */
+	ret = air_buckpbus_reg_modify(phydev, set1,
+				      AN8811HB_CRC_RD_EN,
+				      AN8811HB_CRC_RD_EN);
+	if (ret < 0)
+		return ret;
+	air_buckpbus_reg_read(phydev, set1, &pbus_value);
+
+	do {
+		mdelay(300);
+		air_buckpbus_reg_read(phydev, mon2, &pbus_value);
+
+		if (pbus_value & AN8811HB_CRC_ST) {
+			air_buckpbus_reg_read(phydev, mon3, &pbus_value);
+			phydev_info(phydev, "CRC Check %s!\n",
+				    pbus_value & AN8811HB_CRC_CHECK_PASS ? "PASS" : "FAIL");
+			break;
+		}
+
+		if (!retry) {
+			phydev_err(phydev, "CRC Check is not ready (%u)\n", pbus_value);
+			return -ENODEV;
+		}
+	} while (--retry);
+
+	return air_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN, 0);
+}
+
 static int en8811h_load_firmware(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	const struct firmware *fw1, *fw2;
+	bool en8811h;
 	int ret;
 
-	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
-	if (ret < 0)
-		return ret;
+	switch (phydev->phy_id & PHY_ID_MATCH_MODEL_MASK) {
+	case EN8811H_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
+		ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
+		if (ret < 0)
+			return ret;
 
-	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
-	if (ret < 0)
-		goto en8811h_load_firmware_rel1;
+		ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
+		if (ret < 0)
+			goto en8811h_load_firmware_rel1;
+
+		en8811h = true;
+		break;
+
+	case AN8811HB_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
+		ret = request_firmware_direct(&fw1, AN8811HB_MD32_DM, dev);
+		if (ret < 0)
+			return ret;
+
+		ret = request_firmware_direct(&fw2, AN8811HB_MD32_DSP, dev);
+		if (ret < 0)
+			goto en8811h_load_firmware_rel1;
+		break;
+	default:
+		return -ENODEV;
+	}
 
 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_START);
+	if (ret == 0 && en8811h)
+		ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+					      EN8811H_FW_CTRL_2_LOADING,
+					      EN8811H_FW_CTRL_2_LOADING);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-				      EN8811H_FW_CTRL_2_LOADING,
-				      EN8811H_FW_CTRL_2_LOADING);
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
+	if (ret == 0 && !en8811h)
+		ret = an8811hb_check_crc(phydev, AN8811HB_CRC_DM_SET1,
+					 AN8811HB_CRC_DM_MON2,
+					 AN8811HB_CRC_DM_MON3);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
@@ -495,8 +595,13 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-				      EN8811H_FW_CTRL_2_LOADING, 0);
+	if (en8811h)
+		ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+					      EN8811H_FW_CTRL_2_LOADING, 0);
+	else
+		ret = an8811hb_check_crc(phydev, AN8811HB_CRC_PM_SET1,
+					 AN8811HB_CRC_PM_MON2,
+					 AN8811HB_CRC_PM_MON3);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
@@ -820,6 +925,80 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	return 0;
 };
 
+static unsigned long an8811hb_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & AN8811HB_HWTRAP2_CKO) ? 50000000 : 25000000;
+}
+
+static int an8811hb_clk_enable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				       AN8811HB_CLK_DRV_CKO_MASK,
+				       AN8811HB_CLK_DRV_CKO_MASK);
+}
+
+static void an8811hb_clk_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				AN8811HB_CLK_DRV_CKO_MASK, 0);
+}
+
+static int an8811hb_clk_is_enabled(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_CLK_DRV, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & AN8811HB_CLK_DRV_CKO_MASK);
+}
+
+static int an8811hb_clk_save_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	priv->cko_is_enabled = an8811hb_clk_is_enabled(hw);
+
+	return 0;
+}
+
+static void an8811hb_clk_restore_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	if (!priv->cko_is_enabled)
+		an8811hb_clk_disable(hw);
+}
+
+static const struct clk_ops an8811hb_clk_ops = {
+	.recalc_rate		= an8811hb_clk_recalc_rate,
+	.enable			= an8811hb_clk_enable,
+	.disable		= an8811hb_clk_disable,
+	.is_enabled		= an8811hb_clk_is_enabled,
+	.save_context		= an8811hb_clk_save_context,
+	.restore_context	= an8811hb_clk_restore_context,
+};
+
 static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent)
 {
@@ -894,8 +1073,9 @@ static const struct clk_ops en8811h_clk_ops = {
 	.restore_context	= en8811h_clk_restore_context,
 };
 
-static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
+static int en8811h_clk_provider_setup(struct phy_device *phydev, struct clk_hw *hw)
 {
+	struct device *dev = &phydev->mdio.dev;
 	struct clk_init_data init;
 	int ret;
 
@@ -907,7 +1087,16 @@ static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
 	if (!init.name)
 		return -ENOMEM;
 
-	init.ops = &en8811h_clk_ops;
+	switch (phydev->phy_id & PHY_ID_MATCH_MODEL_MASK) {
+	case EN8811H_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
+		init.ops = &en8811h_clk_ops;
+		break;
+	case AN8811HB_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
+		init.ops = &an8811hb_clk_ops;
+		break;
+	default:
+		return -ENODEV;
+	}
 	init.flags = 0;
 	init.num_parents = 0;
 	hw->init = &init;
@@ -952,8 +1141,9 @@ static int en8811h_probe(struct phy_device *phydev)
 	}
 
 	priv->phydev = phydev;
+
 	/* Co-Clock Output */
-	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
+	ret = en8811h_clk_provider_setup(phydev, &priv->hw);
 	if (ret)
 		return ret;
 
@@ -967,32 +1157,61 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
-static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+static bool airphy_invert_rx(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
-	int pol, default_pol;
-	u32 pbus_value = 0;
+	int default_pol  = PHY_POL_NORMAL;
 
-	default_pol = PHY_POL_NORMAL;
 	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
 		default_pol = PHY_POL_INVERT;
 
-	pol = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
-				  PHY_POL_NORMAL | PHY_POL_INVERT, default_pol);
-	if (pol < 0)
-		return pol;
-	if (pol == PHY_POL_INVERT)
-		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+	return phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				   PHY_POL_NORMAL | PHY_POL_INVERT, default_pol)
+		== PHY_POL_INVERT;
+}
+
+static bool airphy_invert_tx(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int default_pol  = PHY_POL_NORMAL;
 
-	default_pol = PHY_POL_NORMAL;
 	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
 		default_pol = PHY_POL_INVERT;
 
-	pol = phy_get_tx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
-				  PHY_POL_NORMAL | PHY_POL_INVERT, default_pol);
-	if (pol < 0)
-		return pol;
-	if (pol == PHY_POL_NORMAL)
+	return phy_get_tx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				   PHY_POL_NORMAL | PHY_POL_INVERT, default_pol)
+		== PHY_POL_INVERT;
+}
+
+static int an8811hb_config_serdes_polarity(struct phy_device *phydev)
+{
+	u32 pbus_value = 0;
+	int ret;
+
+	if (!airphy_invert_rx(phydev))
+		pbus_value |=  AN8811HB_RX_POLARITY_NORMAL;
+	ret = air_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
+				      AN8811HB_RX_POLARITY_NORMAL,
+				      pbus_value);
+	if (ret < 0)
+		return ret;
+
+	pbus_value = 0;
+	if (!airphy_invert_tx(phydev))
+		pbus_value |=  AN8811HB_TX_POLARITY_NORMAL;
+	return air_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
+				       AN8811HB_TX_POLARITY_NORMAL,
+				       pbus_value);
+}
+
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+{
+	u32 pbus_value = 0;
+
+	if (airphy_invert_rx(phydev))
+		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+
+	if (!airphy_invert_tx(phydev))
 		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
 
 	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
@@ -1000,6 +1219,33 @@ static int en8811h_config_serdes_polarity(struct phy_device *phydev)
 				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
 }
 
+static int an8811hb_config_init(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	/* If restart happened in .probe(), no need to restart now */
+	if (priv->mcu_needs_restart) {
+		ret = en8811h_restart_mcu(phydev);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Next calls to .config_init() mcu needs to restart */
+		priv->mcu_needs_restart = true;
+	}
+
+	ret = an8811hb_config_serdes_polarity(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
+			    AIR_LED_MODE_USER_DEFINE);
+	if (ret < 0)
+		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
+
+	return ret;
+}
+
 static int en8811h_config_init(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
@@ -1113,13 +1359,25 @@ static int en8811h_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Get link partner 2.5GBASE-T ability from vendor register */
-	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
-	if (ret < 0)
-		return ret;
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			 phydev->lp_advertising,
-			 pbus_value & EN8811H_2P5G_LPA_2P5G);
+	switch (phydev->phy_id & PHY_ID_MATCH_MODEL_MASK) {
+	case EN8811H_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
+		/* Get link partner 2.5GBASE-T ability from vendor register */
+		ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
+		if (ret < 0)
+			return ret;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising,
+				 pbus_value & EN8811H_2P5G_LPA_2P5G);
+		break;
+	case AN8811HB_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+		if (val < 0)
+			return val;
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising,
+				 val & MDIO_AN_10GBT_STAT_LP2_5G);
+	}
 
 	if (phydev->autoneg_complete)
 		phy_resolve_aneg_pause(phydev);
@@ -1141,6 +1399,9 @@ static int en8811h_read_status(struct phy_device *phydev)
 	case AIR_AUX_CTRL_STATUS_SPEED_100:
 		phydev->speed = SPEED_100;
 		break;
+	case AIR_AUX_CTRL_STATUS_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
 	}
 
 	/* Firmware before version 24011202 has no vendor register 2P5G_LPA.
@@ -1225,20 +1486,44 @@ static struct phy_driver en8811h_driver[] = {
 	.led_brightness_set	= air_led_brightness_set,
 	.led_hw_control_set	= air_led_hw_control_set,
 	.led_hw_control_get	= air_led_hw_control_get,
+},
+{
+	PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID),
+	.name			= "Airoha AN8811HB",
+	.probe			= en8811h_probe,
+	.get_features		= en8811h_get_features,
+	.config_init		= an8811hb_config_init,
+	.get_rate_matching	= en8811h_get_rate_matching,
+	.config_aneg		= en8811h_config_aneg,
+	.read_status		= en8811h_read_status,
+	.resume			= en8811h_resume,
+	.suspend		= en8811h_suspend,
+	.config_intr		= en8811h_clear_intr,
+	.handle_interrupt	= en8811h_handle_interrupt,
+	.led_hw_is_supported	= en8811h_led_hw_is_supported,
+	.read_page		= air_phy_read_page,
+	.write_page		= air_phy_write_page,
+	.led_blink_set		= air_led_blink_set,
+	.led_brightness_set	= air_led_brightness_set,
+	.led_hw_control_set	= air_led_hw_control_set,
+	.led_hw_control_get	= air_led_hw_control_get,
 } };
 
 module_phy_driver(en8811h_driver);
 
 static const struct mdio_device_id __maybe_unused en8811h_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(EN8811H_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(mdio, en8811h_tbl);
 MODULE_FIRMWARE(EN8811H_MD32_DM);
 MODULE_FIRMWARE(EN8811H_MD32_DSP);
+MODULE_FIRMWARE(AN8811HB_MD32_DM);
+MODULE_FIRMWARE(AN8811HB_MD32_DSP);
 
-MODULE_DESCRIPTION("Airoha EN8811H PHY drivers");
+MODULE_DESCRIPTION("Airoha EN8811H and AN8811HB PHY drivers");
 MODULE_AUTHOR("Airoha");
 MODULE_AUTHOR("Eric Woudstra <ericwouds@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.47.3


