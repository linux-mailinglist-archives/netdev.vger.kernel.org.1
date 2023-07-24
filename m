Return-Path: <netdev+bounces-20360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C675F285
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381481C20850
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A121079F1;
	Mon, 24 Jul 2023 10:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FA8481
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:15:51 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642471BEC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:15:36 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193675tzk32u8f
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:34 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJnXVu7PkBCSJWw0SqhCafAKrx4NUNLsKIxpSENib6e+JMPAurxFj
	tbSY3rregWJCuzCAFSWvv3RHwmsocI8K7GIxpCIjBnK0iRrGDxC1Vq0d4EvMlRiZAUZ2A31
	VK21/UXEXaDa5iRtrN2WkTvX+SKRsdeYzEFFruMT4+8W5E3H2MxifFQUiM+pT8ujGIowlkv
	8qF4HjN8P+DQT4hbqQ1MLEtl/3098aEH/mVH7HwgYoCCCag+lDY6clxqFgKrQDnowTc3i2t
	x6uGLz3vI00czToPkcfkgF7yjsNbu+QT8yeQiBQaRsVz7/hC5ndLy0Gxt+Iega/CmGOrkAY
	bUBBBE1AP0WQFJInLkkpNk//YMr6WQk5fZ2GLjxKjJil6ib7zLUY/wCm0d1pCakz1xVhhcM
	UR4ti6nTNOrHqkwZ+6agWA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7352745186088034008
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/7] net: pcs: xpcs: support to switch mode for Wangxun NICs
Date: Mon, 24 Jul 2023 18:23:36 +0800
Message-Id: <20230724102341.10401-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230724102341.10401-1-jiawenwu@trustnetic.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

According to chapter 6 of DesignWare Cores Ethernet PCS (version 3.20a)
and custom design manual, add a configuration flow for switching interface
mode.

If the interface changes, the following setting is required:
1. wait VR_XS_PCS_DIG_STS bit(4, 2) [PSEQ_STATE] = 100b (Power-Good)
2. write SR_XS_PCS_CTRL2 to select various PCS type
3. write SR_PMA_CTRL1 and/or SR_XS_PCS_CTRL1 for link speed
4. program PMA registers
5. write VR_XS_PCS_DIG_CTRL1 bit(15) [VR_RST] = 1b (Vendor-Specific
   Soft Reset)
6. wait for VR_XS_PCS_DIG_CTRL1 bit(15) [VR_RST] to get cleared

Only 10GBASE-R/SGMII/1000BASE-X modes are planned for the current Wangxun
devices. And there is a quirk for Wangxun devices to switch mode although
the interface in phylink state has not changed, since PCS will change to
default 10GBASE-R when the ethernet driver(txgbe) do LAN reset.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 MAINTAINERS                   |   1 +
 drivers/net/pcs/Makefile      |   2 +-
 drivers/net/pcs/pcs-xpcs-wx.c | 189 ++++++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c    |  12 ++-
 drivers/net/pcs/pcs-xpcs.h    |   7 ++
 include/linux/pcs/pcs-xpcs.h  |   1 +
 6 files changed, 207 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-wx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 990e3fce753c..feebec1f97ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22887,6 +22887,7 @@ S:	Maintained
 W:	https://www.net-swift.com
 F:	Documentation/networking/device_drivers/ethernet/wangxun/*
 F:	drivers/net/ethernet/wangxun/
+F:	drivers/net/pcs/pcs-xpcs-wx.c
 
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@linux-watchdog.org>
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index ea662a7989b2..fb1694192ae6 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PCS drivers
 
-pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-nxp.o
+pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
 obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
 obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
new file mode 100644
index 000000000000..6d1df34958bd
--- /dev/null
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2023 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/pcs/pcs-xpcs.h>
+#include <linux/mdio.h>
+#include "pcs-xpcs.h"
+
+/* VR_XS_PMA_MMD */
+#define TXGBE_PMA_MMD			0x8020
+#define TXGBE_TX_GENCTL1		0x11
+#define TXGBE_TX_GENCTL1_VBOOST_LVL	GENMASK(10, 8)
+#define TXGBE_TX_GENCTL1_VBOOST_EN0	BIT(4)
+#define TXGBE_TX_GEN_CTL2		0x12
+#define TXGBE_TX_RATE_CTL		0x14
+#define TXGBE_RX_GEN_CTL2		0x32
+#define TXGBE_RX_GEN_CTL3		0x33
+#define TXGBE_RX_GEN_CTL3_LOS_TRSHLD0	GENMASK(2, 0)
+#define TXGBE_RX_RATE_CTL		0x34
+#define TXGBE_RX_EQ_ATTN_CTL		0x37
+#define TXGBE_RX_EQ_ATTN_LVL0		GENMASK(2, 0)
+#define TXGBE_RX_EQ_CTL0		0x38
+#define TXGBE_RX_EQ_CTL4		0x3C
+#define TXGBE_RX_EQ_CTL4_CONT_ADAPT0	BIT(0)
+#define TXGBE_AFE_DFE_ENABLE		0x3D
+#define TXGBE_DFE_EN_0			BIT(4)
+#define TXGBE_AFE_EN_0			BIT(0)
+#define TXGBE_DFE_TAP_CTL0		0x3E
+#define TXGBE_MPLLA_CTL0		0x51
+#define TXGBE_MPLLA_CTL2		0x53
+#define TXGBE_MPLLA_CTL3		0x57
+#define TXGBE_MISC_CTL0			0x70
+#define TXGBE_VCO_CAL_LD0		0x72
+#define TXGBE_VCO_CAL_REF0		0x76
+
+static int txgbe_read_pma(struct dw_xpcs *xpcs, int reg)
+{
+	return xpcs_read(xpcs, MDIO_MMD_PMAPMD, TXGBE_PMA_MMD + reg);
+}
+
+static int txgbe_write_pma(struct dw_xpcs *xpcs, int reg, u16 val)
+{
+	return xpcs_write(xpcs, MDIO_MMD_PMAPMD, TXGBE_PMA_MMD + reg, val);
+}
+
+static void txgbe_pma_config_10gbaser(struct dw_xpcs *xpcs)
+{
+	int val;
+
+	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x21);
+	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0);
+	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
+	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
+	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
+	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, 0xCF00);
+	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_LD0, 0x549);
+	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_REF0, 0x29);
+	txgbe_write_pma(xpcs, TXGBE_TX_RATE_CTL, 0);
+	txgbe_write_pma(xpcs, TXGBE_RX_RATE_CTL, 0);
+	txgbe_write_pma(xpcs, TXGBE_TX_GEN_CTL2, 0x300);
+	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL2, 0x300);
+	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL2, 0x600);
+
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, 0x45);
+	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
+	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0xBE);
+	val = txgbe_read_pma(xpcs, TXGBE_AFE_DFE_ENABLE);
+	val &= ~(TXGBE_DFE_EN_0 | TXGBE_AFE_EN_0);
+	txgbe_write_pma(xpcs, TXGBE_AFE_DFE_ENABLE, val);
+	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_CTL4);
+	val &= ~TXGBE_RX_EQ_CTL4_CONT_ADAPT0;
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL4, val);
+}
+
+static void txgbe_pma_config_1g(struct dw_xpcs *xpcs)
+{
+	int val;
+
+	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
+	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
+	val &= ~TXGBE_TX_GENCTL1_VBOOST_EN0;
+	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
+	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, 0xCF00);
+
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, 0x7706);
+	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
+	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0);
+	val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
+	val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+
+	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x20);
+	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0x46);
+	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_LD0, 0x540);
+	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_REF0, 0x2A);
+	txgbe_write_pma(xpcs, TXGBE_AFE_DFE_ENABLE, 0);
+	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL4, 0x10);
+	txgbe_write_pma(xpcs, TXGBE_TX_RATE_CTL, 0x3);
+	txgbe_write_pma(xpcs, TXGBE_RX_RATE_CTL, 0x3);
+	txgbe_write_pma(xpcs, TXGBE_TX_GEN_CTL2, 0x100);
+	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL2, 0x100);
+	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL2, 0x200);
+}
+
+static int txgbe_pcs_poll_power_up(struct dw_xpcs *xpcs)
+{
+	int val, ret;
+
+	/* Wait xpcs power-up good */
+	ret = read_poll_timeout(xpcs_read_vpcs, val,
+				(val & DW_PSEQ_ST) == DW_PSEQ_ST_GOOD,
+				10000, 1000000, false,
+				xpcs, DW_VR_XS_PCS_DIG_STS);
+	if (ret < 0)
+		pr_err("%s: xpcs power-up timeout\n", __func__);
+
+	return ret;
+}
+
+static int txgbe_pma_init_done(struct dw_xpcs *xpcs)
+{
+	int val, ret;
+
+	xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_VR_RST);
+
+	/* wait pma initialization done */
+	ret = read_poll_timeout(xpcs_read_vpcs, val, !(val & DW_VR_RST),
+				100000, 10000000, false,
+				xpcs, DW_VR_XS_PCS_DIG_CTRL1);
+	if (ret < 0)
+		pr_err("%s: xpcs pma initialization timeout\n", __func__);
+
+	return ret;
+}
+
+static bool txgbe_xpcs_mode_quirk(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	/* When txgbe do LAN reset, PCS will change to default 10GBASE-R mode */
+	ret = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_CTRL2);
+	ret &= MDIO_PCS_CTRL2_TYPE;
+	if (ret == MDIO_PCS_CTRL2_10GBR &&
+	    xpcs->interface != PHY_INTERFACE_MODE_10GBASER)
+		return true;
+
+	return false;
+}
+
+int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
+{
+	int val, ret;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		break;
+	default:
+		return 0;
+	}
+
+	if (xpcs->interface == interface && !txgbe_xpcs_mode_quirk(xpcs))
+		return 0;
+
+	xpcs->interface = interface;
+
+	ret = txgbe_pcs_poll_power_up(xpcs);
+	if (ret < 0)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_10GBASER) {
+		xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2, MDIO_PCS_CTRL2_10GBR);
+		val = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_CTRL1);
+		val |= MDIO_CTRL1_SPEED10G;
+		xpcs_write(xpcs, MDIO_MMD_PMAPMD, MDIO_CTRL1, val);
+		txgbe_pma_config_10gbaser(xpcs);
+	} else {
+		xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2, MDIO_PCS_CTRL2_10GBX);
+		xpcs_write(xpcs, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0);
+		xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL1, 0);
+		txgbe_pma_config_1g(xpcs);
+	}
+
+	return txgbe_pma_init_done(xpcs);
+}
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 79a34ffb7518..82fe45845ebd 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -228,12 +228,12 @@ static int xpcs_write_vendor(struct dw_xpcs *xpcs, int dev, int reg,
 	return xpcs_write(xpcs, dev, DW_VENDOR | reg, val);
 }
 
-static int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg)
+int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg)
 {
 	return xpcs_read_vendor(xpcs, MDIO_MMD_PCS, reg);
 }
 
-static int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
+int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
 {
 	return xpcs_write_vendor(xpcs, MDIO_MMD_PCS, reg, val);
 }
@@ -826,6 +826,12 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	if (!compat)
 		return -ENODEV;
 
+	if (xpcs_dev_is_txgbe(xpcs)) {
+		ret = txgbe_xpcs_switch_mode(xpcs, interface);
+		if (ret)
+			return ret;
+	}
+
 	switch (compat->an_mode) {
 	case DW_10GBASER:
 		break;
@@ -1294,8 +1300,6 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 
 		xpcs->pcs.ops = &xpcs_phylink_ops;
 		xpcs->pcs.neg_mode = true;
-		if (compat->an_mode == DW_10GBASER)
-			return xpcs;
 
 		if (!xpcs_dev_is_txgbe(xpcs))
 			xpcs->pcs.poll = true;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 68c6b5a62088..2657138391af 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -15,8 +15,12 @@
 /* VR_XS_PCS */
 #define DW_USXGMII_RST			BIT(10)
 #define DW_USXGMII_EN			BIT(9)
+#define DW_VR_XS_PCS_DIG_CTRL1		0x0000
+#define DW_VR_RST			BIT(15)
 #define DW_VR_XS_PCS_DIG_STS		0x0010
 #define DW_RXFIFO_ERR			GENMASK(6, 5)
+#define DW_PSEQ_ST			GENMASK(4, 2)
+#define DW_PSEQ_ST_GOOD			FIELD_PREP(GENMASK(4, 2), 0x4)
 
 /* SR_MII */
 #define DW_USXGMII_FULL			BIT(8)
@@ -106,6 +110,9 @@
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val);
+int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg);
+int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val);
 int nxp_sja1105_sgmii_pma_config(struct dw_xpcs *xpcs);
 int nxp_sja1110_sgmii_pma_config(struct dw_xpcs *xpcs);
 int nxp_sja1110_2500basex_pma_config(struct dw_xpcs *xpcs);
+int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index fb60c7e28623..da8a0708c50f 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -28,6 +28,7 @@ struct dw_xpcs {
 	struct mdio_device *mdiodev;
 	const struct xpcs_id *id;
 	struct phylink_pcs pcs;
+	phy_interface_t interface;
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.27.0


