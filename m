Return-Path: <netdev+bounces-190906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F53AB9387
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CBC1BC16DA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE92214A7A;
	Fri, 16 May 2025 01:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADB214A6A;
	Fri, 16 May 2025 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357930; cv=none; b=gPZKGYcrBHO+NKhBCcZPo+V+U4ffeuhMLTjrHrGKj2l9YCOMkou/IhRfJW5vWpCigSShtGHXq+V642QfVZeGq1bFL3uQmtowEYC39BqUcnV+DWkLE9gTz5obz6ZYXpBSl6+uutE+w/cQXsInhWgQGYMVCfZFW0r7255837Ts/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357930; c=relaxed/simple;
	bh=ho1EXh6k1/nzQNtvq4LidrP8paWCSV1Tq22dfH9Tuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABfG8WLLZt8Fi/8vKRSZSNPUCYCvJq4H7OejPhlh3A3VAVswsavBHnjVLtg9fbgOIkKp5IfQ9KDE8452MSC4IgGRBO1KfAayewq2H32h/UDn47/sLZXwVZM6Nd5505j7oKu/dfBPpT0xazSzjHAs7D6W9zZjxm2AnUNPJAhbUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182DT.eswin.cn (unknown [10.12.97.162])
	by app2 (Coremail) with SMTP id TQJkCgAnxpTHkCZo8Jh8AA--.60891S2;
	Fri, 16 May 2025 09:11:39 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de,
	yong.liang.choong@linux.intel.com,
	rmk+kernel@armlinux.org.uk,
	jszhang@kernel.org,
	inochiama@gmail.com,
	jan.petrous@oss.nxp.com,
	dfustini@tenstorrent.com,
	0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v1 2/2] ethernet: eswin: Add eic7700 ethernet driver
Date: Fri, 16 May 2025 09:11:28 +0800
Message-ID: <20250516011130.818-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250516010849.784-1-weishangjuan@eswincomputing.com>
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAnxpTHkCZo8Jh8AA--.60891S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tF48tF1rXr48Xw18WFW5GFg_yoW8Cr18Ko
	Z3GFnxXw1rtF4UC3Z5tF1xGF9Iqa1kAws7CrW3Zr4UuFW3Z3W0qrZ0g343Xa1S9r4rtFyf
	Zr4kJr13XF47trZ5n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOc7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14
	v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E
	6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4
	kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRExR65UUUUU==
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Add Ethernet controller support for Eswin's eic7700 SoC. The driver
provides management and control of Ethernet signals for the eiC7700
series chips.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 521 ++++++++++++++++++
 3 files changed, 533 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 3c820ef56775..6a3970c92db7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -66,6 +66,17 @@ config DWMAC_ANARION
 
 	  This selects the Anarion SoC glue layer support for the stmmac driver.
 
+config DWMAC_EIC7700
+	tristate "Support for Eswin eic7700 ethernet driver"
+	select CRC32
+	select MII
+	depends on OF && HAS_DMA && ARCH_ESWIN || COMPILE_TEST
+	help
+	  This driver supports the Eswin EIC7700 Ethernet controller,
+	  which integrates Synopsys DesignWare QoS features. It enables
+	  high-speed networking with DMA acceleration and is optimized
+	  for embedded systems.
+
 config DWMAC_INGENIC
 	tristate "Ingenic MAC support"
 	default MACH_INGENIC
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 594883fb4164..c9279bafdbb1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -14,6 +14,7 @@ stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
 # Ordering matters. Generic driver must be last.
 obj-$(CONFIG_STMMAC_PLATFORM)	+= stmmac-platform.o
 obj-$(CONFIG_DWMAC_ANARION)	+= dwmac-anarion.o
+obj-$(CONFIG_DWMAC_EIC7700)	+= dwmac-eic7700.o
 obj-$(CONFIG_DWMAC_INGENIC)	+= dwmac-ingenic.o
 obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
new file mode 100644
index 000000000000..3483827e5652
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Eswin DWC Ethernet linux driver
+ *
+ * Authors: Shuang Liang <liangshuang@eswincomputing.com>
+ * Shangjuan Wei <weishangjuan@eswincomputing.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/ethtool.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/stmmac.h>
+#include "stmmac_platform.h"
+#include "dwmac4.h"
+#include <linux/mfd/syscon.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
+
+/* eth_phy_ctrl_offset eth0:0x100; eth1:0x200 */
+#define ETH_TX_CLK_SEL			BIT(16)
+#define ETH_PHY_INTF_SELI		BIT(0)
+
+/* eth_axi_lp_ctrl_offset eth0:0x108; eth1:0x208 */
+#define ETH_CSYSREQ_VAL			BIT(0)
+
+/* hsp_aclk_ctrl_offset (0x148) */
+#define HSP_ACLK_CLKEN				BIT(31)
+#define HSP_ACLK_DIVSOR				(0x2 << 4)
+
+/* hsp_cfg_ctrl_offset (0x14c) */
+#define HSP_CFG_CLKEN			BIT(31)
+#define SCU_HSP_PCLK_EN			BIT(30)
+#define HSP_CFG_CTRL_REGSET		(HSP_CFG_CLKEN | SCU_HSP_PCLK_EN)
+
+/* RTL8211F PHY Configurations for LEDs */
+#define PHY_ADDR				0
+#define PHY_PAGE_SWITCH_REG		31
+#define PHY_LED_CFG_REG			16
+#define PHY_LED_PAGE_CFG		0xd04
+
+struct dwc_qos_priv {
+	struct device *dev;
+	int dev_id;
+	struct regmap *crg_regmap;
+	struct regmap *hsp_regmap;
+	struct reset_control *rst;
+	struct clk *clk_app;
+	struct clk *clk_tx;
+	struct gpio_desc *phy_reset;
+	struct stmmac_priv *stmpriv;
+	int phyled_cfgs[3];
+	int phyaddr;
+	unsigned int dly_hsp_reg[3];
+	unsigned int dly_param_1000m[3];
+	unsigned int dly_param_100m[3];
+	unsigned int dly_param_10m[3];
+};
+
+static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
+				   struct plat_stmmacenet_data *plat_dat)
+{
+	struct device *dev = &pdev->dev;
+	u32 burst_map = 0;
+	u32 bit_index = 0;
+	u32 a_index = 0;
+
+	if (!plat_dat->axi) {
+		plat_dat->axi = kzalloc(sizeof(*plat_dat->axi), GFP_KERNEL);
+
+		if (!plat_dat->axi)
+			return -ENOMEM;
+	}
+
+	plat_dat->axi->axi_lpi_en = device_property_read_bool(dev,
+							      "snps,en-lpi");
+	if (device_property_read_u32(dev, "snps,write-requests",
+				     &plat_dat->axi->axi_wr_osr_lmt)) {
+		/**
+		 * Since the register has a reset value of 1, if property
+		 * is missing, default to 1.
+		 */
+		plat_dat->axi->axi_wr_osr_lmt = 1;
+	} else {
+		/**
+		 * If property exists, to keep the behavior from dwc_eth_qos,
+		 * subtract one after parsing.
+		 */
+		plat_dat->axi->axi_wr_osr_lmt--;
+	}
+
+	if (device_property_read_u32(dev, "snps,read-requests",
+				     &plat_dat->axi->axi_rd_osr_lmt)) {
+		/**
+		 * Since the register has a reset value of 1, if property
+		 * is missing, default to 1.
+		 */
+		plat_dat->axi->axi_rd_osr_lmt = 1;
+	} else {
+		/**
+		 * If property exists, to keep the behavior from dwc_eth_qos,
+		 * subtract one after parsing.
+		 */
+		plat_dat->axi->axi_rd_osr_lmt--;
+	}
+	device_property_read_u32(dev, "snps,burst-map", &burst_map);
+
+	/* converts burst-map bitmask to burst array */
+	for (bit_index = 0; bit_index < 7; bit_index++) {
+		if (burst_map & (1 << bit_index)) {
+			switch (bit_index) {
+			case 0:
+			plat_dat->axi->axi_blen[a_index] = 4; break;
+			case 1:
+			plat_dat->axi->axi_blen[a_index] = 8; break;
+			case 2:
+			plat_dat->axi->axi_blen[a_index] = 16; break;
+			case 3:
+			plat_dat->axi->axi_blen[a_index] = 32; break;
+			case 4:
+			plat_dat->axi->axi_blen[a_index] = 64; break;
+			case 5:
+			plat_dat->axi->axi_blen[a_index] = 128; break;
+			case 6:
+			plat_dat->axi->axi_blen[a_index] = 256; break;
+			default:
+			break;
+			}
+			a_index++;
+		}
+	}
+
+	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
+	plat_dat->has_gmac4 = 1;
+	plat_dat->dma_cfg->aal = 1;
+	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
+	plat_dat->pmt = 1;
+
+	return 0;
+}
+
+static void dwc_qos_fix_speed(void *priv, int speed, unsigned int mode)
+{
+	unsigned long rate = 125000000;
+	int i, err, data = 0;
+	struct dwc_qos_priv *dwc_priv = (struct dwc_qos_priv *)priv;
+
+	switch (speed) {
+	case SPEED_1000:
+		rate = 125000000;
+
+		for (i = 0; i < 3; i++)
+			regmap_write(dwc_priv->hsp_regmap,
+				     dwc_priv->dly_hsp_reg[i],
+				     dwc_priv->dly_param_1000m[i]);
+
+		if (dwc_priv->stmpriv) {
+			data = mdiobus_read(dwc_priv->stmpriv->mii, PHY_ADDR,
+					    PHY_PAGE_SWITCH_REG);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_PAGE_SWITCH_REG, PHY_LED_PAGE_CFG);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_LED_CFG_REG, dwc_priv->phyled_cfgs[0]);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_PAGE_SWITCH_REG, data);
+		}
+
+		break;
+	case SPEED_100:
+		rate = 25000000;
+
+		for (i = 0; i < 3; i++) {
+			regmap_write(dwc_priv->hsp_regmap,
+				     dwc_priv->dly_hsp_reg[i],
+				     dwc_priv->dly_param_100m[i]);
+		}
+
+		if (dwc_priv->stmpriv) {
+			data = mdiobus_read(dwc_priv->stmpriv->mii, PHY_ADDR,
+					    PHY_PAGE_SWITCH_REG);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_PAGE_SWITCH_REG, PHY_LED_PAGE_CFG);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_LED_CFG_REG, dwc_priv->phyled_cfgs[1]);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_PAGE_SWITCH_REG, data);
+		}
+
+		break;
+	case SPEED_10:
+		rate = 2500000;
+
+		for (i = 0; i < 3; i++) {
+			regmap_write(dwc_priv->hsp_regmap,
+				     dwc_priv->dly_hsp_reg[i],
+				     dwc_priv->dly_param_10m[i]);
+		}
+
+		if (dwc_priv->stmpriv) {
+			data = mdiobus_read(dwc_priv->stmpriv->mii, PHY_ADDR,
+					    PHY_PAGE_SWITCH_REG);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_PAGE_SWITCH_REG, PHY_LED_PAGE_CFG);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_LED_CFG_REG, dwc_priv->phyled_cfgs[2]);
+			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
+				      PHY_PAGE_SWITCH_REG, data);
+		}
+
+		break;
+	default:
+		dev_err(dwc_priv->dev, "invalid speed %u\n", speed);
+		break;
+	}
+
+	err = clk_set_rate(dwc_priv->clk_tx, rate);
+	if (err < 0)
+		dev_err(dwc_priv->dev, "failed to set TX rate: %d\n", err);
+}
+
+static int dwc_qos_probe(struct platform_device *pdev,
+			 struct plat_stmmacenet_data *plat_dat,
+			 struct stmmac_resources *stmmac_res)
+{
+	struct dwc_qos_priv *dwc_priv;
+	int ret;
+	int err;
+	u32 hsp_aclk_ctrl_offset;
+	u32 hsp_aclk_ctrl_regset;
+	u32 hsp_cfg_ctrl_offset;
+	u32 eth_axi_lp_ctrl_offset;
+	u32 eth_phy_ctrl_offset;
+	u32 eth_phy_ctrl_regset;
+
+	dwc_priv = devm_kzalloc(&pdev->dev, sizeof(*dwc_priv), GFP_KERNEL);
+	if (!dwc_priv)
+		return -ENOMEM;
+
+	if (device_property_read_u32(&pdev->dev, "id", &dwc_priv->dev_id)) {
+		dev_err(&pdev->dev, "Can not read device id!\n");
+		return -EINVAL;
+	}
+
+	dwc_priv->dev = &pdev->dev;
+	dwc_priv->phy_reset = devm_gpiod_get(&pdev->dev, "rst", GPIOD_OUT_LOW);
+	if (IS_ERR(dwc_priv->phy_reset)) {
+		dev_err(&pdev->dev, "Reset gpio not specified\n");
+		return -EINVAL;
+	}
+
+	gpiod_set_value(dwc_priv->phy_reset, 0);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,led-cfgs", 0,
+					 &dwc_priv->phyled_cfgs[0]);
+	if (ret)
+		dev_warn(&pdev->dev, "can't get phyaddr (%d)\n", ret);
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,led-cfgs", 0,
+					 &dwc_priv->phyled_cfgs[0]);
+	if (ret)
+		dev_warn(&pdev->dev, "can't get led cfgs for 1Gbps mode (%d)\n", ret);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,led-cfgs", 1,
+					 &dwc_priv->phyled_cfgs[1]);
+	if (ret)
+		dev_warn(&pdev->dev, "can't get led cfgs for 100Mbps mode (%d)\n", ret);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,led-cfgs", 2,
+					 &dwc_priv->phyled_cfgs[2]);
+	if (ret)
+		dev_warn(&pdev->dev, "can't get led cfgs for 10Mbps mode (%d)\n", ret);
+
+	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "eswin,dly_hsp_reg",
+						  &dwc_priv->dly_hsp_reg[0], 3, 0);
+	if (ret != 3) {
+		dev_err(&pdev->dev, "can't get delay hsp reg.ret(%d)\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-1000m",
+						  &dwc_priv->dly_param_1000m[0], 3, 0);
+	if (ret != 3) {
+		dev_err(&pdev->dev, "can't get delay param for 1Gbps mode (%d)\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-100m",
+						  &dwc_priv->dly_param_100m[0], 3, 0);
+	if (ret != 3) {
+		dev_err(&pdev->dev, "can't get delay param for 100Mbps mode (%d)\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-10m",
+						  &dwc_priv->dly_param_10m[0], 3, 0);
+	if (ret != 3) {
+		dev_err(&pdev->dev, "can't get delay param for 10Mbps mode (%d)\n", ret);
+		return ret;
+	}
+
+	dwc_priv->crg_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							       "eswin,syscrg_csr");
+	if (IS_ERR(dwc_priv->crg_regmap)) {
+		dev_dbg(&pdev->dev, "No syscrg_csr phandle specified\n");
+		return 0;
+	}
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 1,
+					 &hsp_aclk_ctrl_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "can't get hsp_aclk_ctrl_offset (%d)\n", ret);
+		return ret;
+	}
+	regmap_read(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, &hsp_aclk_ctrl_regset);
+	hsp_aclk_ctrl_regset |= (HSP_ACLK_CLKEN | HSP_ACLK_DIVSOR);
+	regmap_write(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, hsp_aclk_ctrl_regset);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 2,
+					 &hsp_cfg_ctrl_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "can't get hsp_cfg_ctrl_offset (%d)\n", ret);
+		return ret;
+	}
+	regmap_write(dwc_priv->crg_regmap, hsp_cfg_ctrl_offset, HSP_CFG_CTRL_REGSET);
+
+	dwc_priv->hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							       "eswin,hsp_sp_csr");
+	if (IS_ERR(dwc_priv->hsp_regmap)) {
+		dev_dbg(&pdev->dev, "No hsp_sp_csr phandle specified\n");
+		return 0;
+	}
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 2,
+					 &eth_phy_ctrl_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "can't get eth_phy_ctrl_offset (%d)\n", ret);
+		return ret;
+	}
+	regmap_read(dwc_priv->hsp_regmap, eth_phy_ctrl_offset, &eth_phy_ctrl_regset);
+	eth_phy_ctrl_regset |= (ETH_TX_CLK_SEL | ETH_PHY_INTF_SELI);
+	regmap_write(dwc_priv->hsp_regmap, eth_phy_ctrl_offset, eth_phy_ctrl_regset);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 3,
+					 &eth_axi_lp_ctrl_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "can't get eth_axi_lp_ctrl_offset (%d)\n", ret);
+		return ret;
+	}
+	regmap_write(dwc_priv->hsp_regmap, eth_axi_lp_ctrl_offset, ETH_CSYSREQ_VAL);
+
+	dwc_priv->clk_app = devm_clk_get(&pdev->dev, "app");
+	if (IS_ERR(dwc_priv->clk_app)) {
+		dev_err(&pdev->dev, "app clock not found.\n");
+		return PTR_ERR(dwc_priv->clk_app);
+	}
+
+	err = clk_prepare_enable(dwc_priv->clk_app);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable app clock: %d\n",
+			err);
+		return err;
+	}
+
+	dwc_priv->clk_tx = devm_clk_get(&pdev->dev, "tx");
+	if (IS_ERR(plat_dat->pclk)) {
+		dev_err(&pdev->dev, "tx clock not found.\n");
+		return PTR_ERR(dwc_priv->clk_tx);
+	}
+
+	err = clk_prepare_enable(dwc_priv->clk_tx);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable tx clock: %d\n", err);
+		return err;
+	}
+	dwc_priv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "ethrst");
+	if (IS_ERR(dwc_priv->rst))
+		return PTR_ERR(dwc_priv->rst);
+
+	ret = reset_control_assert(dwc_priv->rst);
+	WARN_ON(ret != 0);
+	ret = reset_control_deassert(dwc_priv->rst);
+	WARN_ON(ret != 0);
+
+	plat_dat->fix_mac_speed = dwc_qos_fix_speed;
+	plat_dat->bsp_priv = dwc_priv;
+	plat_dat->phy_addr = PHY_ADDR;
+
+	return 0;
+}
+
+static int dwc_qos_remove(struct platform_device *pdev)
+{
+	struct dwc_qos_priv *dwc_priv = get_stmmac_bsp_priv(&pdev->dev);
+
+	reset_control_assert(dwc_priv->rst);
+	clk_disable_unprepare(dwc_priv->clk_tx);
+	clk_disable_unprepare(dwc_priv->clk_app);
+
+	devm_gpiod_put(&pdev->dev, dwc_priv->phy_reset);
+
+	return 0;
+}
+
+struct dwc_eth_dwmac_data {
+	int (*probe)(struct platform_device *pdev,
+		     struct plat_stmmacenet_data *data,
+		     struct stmmac_resources *res);
+	int (*remove)(struct platform_device *pdev);
+};
+
+static const struct dwc_eth_dwmac_data dwc_qos_data = {
+	.probe = dwc_qos_probe,
+	.remove = dwc_qos_remove,
+};
+
+static int dwc_eth_dwmac_probe(struct platform_device *pdev)
+{
+	const struct dwc_eth_dwmac_data *data;
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct net_device *ndev = NULL;
+	struct stmmac_priv *stmpriv = NULL;
+	struct dwc_qos_priv *dwc_priv = NULL;
+	int ret;
+
+	data = device_get_match_data(&pdev->dev);
+
+	memset(&stmmac_res, 0, sizeof(struct stmmac_resources));
+
+	/**
+	 * Since stmmac_platform supports name IRQ only, basic platform
+	 * resource initialization is done in the glue logic.
+	 */
+	stmmac_res.irq = platform_get_irq(pdev, 0);
+	if (stmmac_res.irq < 0)
+		return stmmac_res.irq;
+	stmmac_res.wol_irq = stmmac_res.irq;
+	stmmac_res.addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(stmmac_res.addr))
+		return PTR_ERR(stmmac_res.addr);
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	ret = data->probe(pdev, plat_dat, &stmmac_res);
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to probe subdriver: %d\n",
+				ret);
+
+		return ret;
+	}
+
+	ret = dwc_eth_dwmac_config_dt(pdev, plat_dat);
+	if (ret)
+		goto remove;
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		goto remove;
+
+	ndev = dev_get_drvdata(&pdev->dev);
+	stmpriv = netdev_priv(ndev);
+	dwc_priv = (struct dwc_qos_priv *)plat_dat->bsp_priv;
+	dwc_priv->stmpriv = stmpriv;
+
+	return ret;
+
+remove:
+	data->remove(pdev);
+
+	return ret;
+}
+
+static void dwc_eth_dwmac_remove(struct platform_device *pdev)
+{
+	const struct dwc_eth_dwmac_data *data;
+	int err;
+
+	data = device_get_match_data(&pdev->dev);
+
+	stmmac_dvr_remove(&pdev->dev);
+
+	err = data->remove(pdev);
+	if (err < 0)
+		dev_err(&pdev->dev, "failed to remove subdriver: %d\n", err);
+}
+
+static const struct of_device_id dwc_eth_dwmac_match[] = {
+	{ .compatible = "eswin,eic7700-qos-eth", .data = &dwc_qos_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
+
+static struct platform_driver eic7700_eth_dwmac_driver = {
+	.probe  = dwc_eth_dwmac_probe,
+	.remove = dwc_eth_dwmac_remove,
+	.driver = {
+		.name           = "eic7700-eth-dwmac",
+		.pm             = &stmmac_pltfr_pm_ops,
+		.of_match_table = dwc_eth_dwmac_match,
+	},
+};
+module_platform_driver(eic7700_eth_dwmac_driver);
+
+MODULE_AUTHOR("Eswin");
+MODULE_AUTHOR("Shuang Liang <liangshuang@eswincomputing.com>");
+MODULE_AUTHOR("Shangjuan Wei <weishangjuan@eswincomputing.com>");
+MODULE_DESCRIPTION("Eswin eic7700 qos ethernet driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


