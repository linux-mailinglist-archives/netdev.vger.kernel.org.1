Return-Path: <netdev+bounces-149479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814249E5BF4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC26818878B1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985922D4C5;
	Thu,  5 Dec 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkJEa3SX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA3229B08;
	Thu,  5 Dec 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417014; cv=none; b=t2DlZvrf2V5G4wWrHiX7yM4dVAJlygzpwCRQltFq2fqn+U2REV0hzI9/hXGitjSCNuZTigK9yWCqGRri7aAkLeNJzAfkylkXomdZaMXIYOulxziE0A47OwKp2Y2x5mr5j/bskXKWD1YrR/FbUTmqeJLzlIv7kox0RV+7b4vYoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417014; c=relaxed/simple;
	bh=CVwfivX9Uoq8NW5yyYwUfH3ih4XNtxHdoR6gSNW6mVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7NrkBIIFu3uNtSs2SAsubVa4aa7ZmT/hU4+rZdh7ShJu5Nk7p+x8ne+JgkWvQ/ZYnCzmkoWCrj29tCrfVx/1hmaHzsO3Iysox+t8wQKZR0Cv8MsjvcIqD45C9C8JLbwd2gIrxQu9AJ7tKT3najmQAMwTj29IHdYIXwvhx1ZAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkJEa3SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C844C2BCAF;
	Thu,  5 Dec 2024 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733417013;
	bh=CVwfivX9Uoq8NW5yyYwUfH3ih4XNtxHdoR6gSNW6mVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QkJEa3SXMX9I46KupgMfdwl3/sKCOCIXL6J/O8orMYJGanieHb0LvzAFPlLfcHXfw
	 EevdqDawNwYayMYzQnhb9o7k3KRaCtWCJfyCSYfuz094OfmqHEjiijs1lPPBe3nAzx
	 TEHNN47WieMXCL4efoPFGXI2AqGapim+zO3Hj0TYchXdZObIz0fyZju6cmiWDFddD8
	 doRtD5M2NbK3Q4wmlrPJcGpyCY+AxPJUUNWY8yh3iD/j8QiEFmW6xyxhBnTYYA4+2t
	 r6wxtBFuTVWrz8x2tG5I0MrwJpucYqvSbz+PHPPw87cn0xZq1oVRANdxnrkQmT++pq
	 BRQeg8g+rjpug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F547E77178;
	Thu,  5 Dec 2024 16:43:33 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Thu, 05 Dec 2024 17:43:11 +0100
Subject: [PATCH net-next v8 14/15] net: stmmac: dwmac-s32: add basic NXP
 S32G/S32R glue driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-upstream_s32cc_gmac-v8-14-ec1d180df815@oss.nxp.com>
References: <20241205-upstream_s32cc_gmac-v8-0-ec1d180df815@oss.nxp.com>
In-Reply-To: <20241205-upstream_s32cc_gmac-v8-0-ec1d180df815@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
 0x1207@gmail.com, fancer.lancer@gmail.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417009; l=7585;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=D7duZN/WctLYyRUUnIZQfArfNj1uNxuP0Pm+u+Oln5c=;
 b=52oMys99dOfuJkPG8QBHZJT/kZXM5UX2dJoO6SOwm7agHVISqJWq6dJr21tjfNxmVikfaJ3px
 BTOtzpNOIAuDbUcE37vYpXVWY89TwsZd3ffRfWX1GYv8j3BvLrueJll
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

NXP S32G2xx/S32G3xx and S32R45 are automotive grade SoCs
that integrate one or two Synopsys DWMAC 5.10/5.20 IPs.

The basic driver supports only RGMII interface.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig     |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile    |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 202 ++++++++++++++++++++++++
 3 files changed, 215 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 6658536a4e17..4cc85a36a1ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -154,6 +154,18 @@ config DWMAC_RZN1
 	  the stmmac device driver. This support can make use of a custom MII
 	  converter PCS device.
 
+config DWMAC_S32
+	tristate "NXP S32G/S32R GMAC support"
+	default ARCH_S32
+	depends on OF && (ARCH_S32 || COMPILE_TEST)
+	help
+	  Support for ethernet controller on NXP S32CC SOCs.
+
+	  This selects NXP SoC glue layer support for the stmmac
+	  device driver. This driver is used for the S32CC series
+	  SOCs GMAC ethernet controller, ie. S32G2xx, S32G3xx and
+	  S32R45.
+
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_INTEL_SOCFPGA
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 2389fd261344..b26f0e79c2b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
+obj-$(CONFIG_DWMAC_S32)		+= dwmac-s32.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
 obj-$(CONFIG_DWMAC_STARFIVE)	+= dwmac-starfive.o
 obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
new file mode 100644
index 000000000000..9cc0e5817416
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP S32G/R GMAC glue layer
+ *
+ * Copyright 2019-2024 NXP
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/of_address.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
+#include <linux/stmmac.h>
+
+#include "stmmac_platform.h"
+
+#define GMAC_INTF_RATE_125M	125000000	/* 125MHz */
+
+/* SoC PHY interface control register */
+#define PHY_INTF_SEL_MII	0x00
+#define PHY_INTF_SEL_SGMII	0x01
+#define PHY_INTF_SEL_RGMII	0x02
+#define PHY_INTF_SEL_RMII	0x08
+
+struct s32_priv_data {
+	void __iomem *ioaddr;
+	void __iomem *ctrl_sts;
+	struct device *dev;
+	phy_interface_t *intf_mode;
+	struct clk *tx_clk;
+	struct clk *rx_clk;
+};
+
+static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
+{
+	writel(PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+
+	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
+
+	return 0;
+}
+
+static int s32_gmac_init(struct platform_device *pdev, void *priv)
+{
+	struct s32_priv_data *gmac = priv;
+	int ret;
+
+	/* Set initial TX interface clock */
+	ret = clk_prepare_enable(gmac->tx_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't enable tx clock\n");
+		return ret;
+	}
+	ret = clk_set_rate(gmac->tx_clk, GMAC_INTF_RATE_125M);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set tx clock\n");
+		goto err_tx_disable;
+	}
+
+	/* Set initial RX interface clock */
+	ret = clk_prepare_enable(gmac->rx_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't enable rx clock\n");
+		goto err_tx_disable;
+	}
+	ret = clk_set_rate(gmac->rx_clk, GMAC_INTF_RATE_125M);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set rx clock\n");
+		goto err_txrx_disable;
+	}
+
+	/* Set interface mode */
+	ret = s32_gmac_write_phy_intf_select(gmac);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set PHY interface mode\n");
+		goto err_txrx_disable;
+	}
+
+	return 0;
+
+err_txrx_disable:
+	clk_disable_unprepare(gmac->rx_clk);
+err_tx_disable:
+	clk_disable_unprepare(gmac->tx_clk);
+	return ret;
+}
+
+static void s32_gmac_exit(struct platform_device *pdev, void *priv)
+{
+	struct s32_priv_data *gmac = priv;
+
+	clk_disable_unprepare(gmac->tx_clk);
+	clk_disable_unprepare(gmac->rx_clk);
+}
+
+static void s32_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct s32_priv_data *gmac = priv;
+	long tx_clk_rate;
+	int ret;
+
+	tx_clk_rate = rgmii_clock(speed);
+	if (tx_clk_rate < 0) {
+		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", speed);
+		return;
+	}
+
+	dev_dbg(gmac->dev, "Set tx clock to %ld Hz\n", tx_clk_rate);
+	ret = clk_set_rate(gmac->tx_clk, tx_clk_rate);
+	if (ret)
+		dev_err(gmac->dev, "Can't set tx clock\n");
+}
+
+static int s32_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat;
+	struct device *dev = &pdev->dev;
+	struct stmmac_resources res;
+	struct s32_priv_data *gmac;
+	int ret;
+
+	gmac = devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
+	if (!gmac)
+		return -ENOMEM;
+
+	gmac->dev = &pdev->dev;
+
+	ret = stmmac_get_platform_resources(pdev, &res);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get platform resources\n");
+
+	plat = devm_stmmac_probe_config_dt(pdev, res.mac);
+	if (IS_ERR(plat))
+		return dev_err_probe(dev, PTR_ERR(plat),
+				     "dt configuration failed\n");
+
+	/* PHY interface mode control reg */
+	gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+	if (IS_ERR(gmac->ctrl_sts))
+		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
+				     "S32CC config region is missing\n");
+
+	/* tx clock */
+	gmac->tx_clk = devm_clk_get(&pdev->dev, "tx");
+	if (IS_ERR(gmac->tx_clk))
+		return dev_err_probe(dev, PTR_ERR(gmac->tx_clk),
+				     "tx clock not found\n");
+
+	/* rx clock */
+	gmac->rx_clk = devm_clk_get(&pdev->dev, "rx");
+	if (IS_ERR(gmac->rx_clk))
+		return dev_err_probe(dev, PTR_ERR(gmac->rx_clk),
+				     "rx clock not found\n");
+
+	gmac->intf_mode = &plat->phy_interface;
+	gmac->ioaddr = res.addr;
+
+	/* S32CC core feature set */
+	plat->has_gmac4 = true;
+	plat->pmt = 1;
+	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat->rx_fifo_size = 20480;
+	plat->tx_fifo_size = 20480;
+
+	plat->init = s32_gmac_init;
+	plat->exit = s32_gmac_exit;
+	plat->fix_mac_speed = s32_fix_mac_speed;
+
+	plat->bsp_priv = gmac;
+
+	return stmmac_pltfr_probe(pdev, plat, &res);
+}
+
+static const struct of_device_id s32_dwmac_match[] = {
+	{ .compatible = "nxp,s32g2-dwmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s32_dwmac_match);
+
+static struct platform_driver s32_dwmac_driver = {
+	.probe = s32_dwmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name = "s32-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = s32_dwmac_match,
+	},
+};
+module_platform_driver(s32_dwmac_driver);
+
+MODULE_AUTHOR("Jan Petrous (OSS) <jan.petrous@oss.nxp.com>");
+MODULE_DESCRIPTION("NXP S32G/R common chassis GMAC driver");
+MODULE_LICENSE("GPL");
+

-- 
2.47.0



