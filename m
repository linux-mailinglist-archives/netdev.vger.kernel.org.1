Return-Path: <netdev+bounces-148246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA29E0E83
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362DA282A50
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268981E1035;
	Mon,  2 Dec 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3u3ZQ3j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005A1E0B87;
	Mon,  2 Dec 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177026; cv=none; b=gyMWuEVhAKwfWqDNOXMp+a9sqbU5KddhtDdYVK40XnKY8lidLgrS6F1JcEvdNnGWEaoGSCW2kehMwtrfGJrsqZgUmfqGt8taVi3z8HQcA0MF0HqRLnCvMd/OcuwD1NKHUBmAWf+p7fcBDW7GLL9sp4NNQ4dAXqG7QbfvFXCcIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177026; c=relaxed/simple;
	bh=AnO4R5j10w0FZih8smewfXdNr/fzYaVAE8TD7GxYUsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4w3tvN7T9uIyFWt0PgD0dNR9yWG9YndZFvDQU+vOtA6uQQuq4oOc4EL9E5GAlKzblhTYAykbHVh3e8LJKzRh9obVZjy3eG3WpU20OuOHK7zuw+ACtbFYmT0muWKXJtX14RZrC5DxFyhqFiNKNPp5oe/1pIZnN0pCZGRSgd+OR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3u3ZQ3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF175C4AF10;
	Mon,  2 Dec 2024 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733177025;
	bh=AnO4R5j10w0FZih8smewfXdNr/fzYaVAE8TD7GxYUsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c3u3ZQ3j/+UvUZNRbxr/0rLA0C0b0yoDN79b46U/VcwDRDqXyCMH9ZhSdXsz5mRCF
	 UaM5S1R1HQIRW4hJC/sleJK/lYQeBNVQDUvd5Czlbl516echx0LdQvFhkmHQy0VYEo
	 pggzcENWeILAHIa6xM0nGgu0xWDc8SnEaJxfy7S8DyYvog94ldLzSgaRQZzH5v9zFH
	 E2nhLnwFFMRsQz12nVUiN4to4nC8E0OsTeOQShrpnSO2cXjsombpnbotvs6Df5rrUG
	 KdYNEheV5sfEZPKUHgUo53LnJ/CmHK4yFa55m5Gox7GT78Pv7vaZv8wwo037rNnI4q
	 GSS6AEaE4sUgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ACCE69E9B;
	Mon,  2 Dec 2024 22:03:45 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Mon, 02 Dec 2024 23:03:53 +0100
Subject: [PATCH net-next v7 14/15] net: stmmac: dwmac-s32: add basic NXP
 S32G/S32R glue driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-upstream_s32cc_gmac-v7-14-bc3e1f9f656e@oss.nxp.com>
References: <20241202-upstream_s32cc_gmac-v7-0-bc3e1f9f656e@oss.nxp.com>
In-Reply-To: <20241202-upstream_s32cc_gmac-v7-0-bc3e1f9f656e@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733177022; l=7205;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=qUYNPbDOjNkOyElyWl7BlSsQNIBb0+hkETF3fWGpFIs=;
 b=NRwwqIFLSLDRWVtaEY+U4k3Z0VspGg5na1mXQdB2vWtPdgJdhOJyUf1ESKV+7z0ZllRndSHBl
 l64C5mBb8i8CZU2drxEs3Fn54ZOTBuIMC7W4Z8PVUDqz7L/7tRh/0/1
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 189 ++++++++++++++++++++++++
 3 files changed, 202 insertions(+)

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
index 000000000000..1853a6b26e46
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -0,0 +1,189 @@
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
+#define GMAC_TX_RATE_125M	125000000	/* 125MHz */
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
+	ret = clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
+	if (!ret)
+		ret = clk_prepare_enable(gmac->tx_clk);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set tx clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(gmac->rx_clk);
+	if (ret) {
+		clk_disable_unprepare(gmac->tx_clk);
+		dev_err(&pdev->dev, "Can't set rx clock\n");
+		return ret;
+	}
+
+	ret = s32_gmac_write_phy_intf_select(gmac);
+	if (ret) {
+		clk_disable_unprepare(gmac->tx_clk);
+		clk_disable_unprepare(gmac->rx_clk);
+		dev_err(&pdev->dev, "Can't set PHY interface mode\n");
+		return ret;
+	}
+
+	return 0;
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



