Return-Path: <netdev+bounces-251354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EACD3BE7F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55F6C4EC2FA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297BD357709;
	Tue, 20 Jan 2026 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVAfMYHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F03570DD
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883797; cv=none; b=OO24+wCEqLgim7zGtXtCCF9mu6OCUIZZ+CiV++0Sv3IF8t19NJ5VOVhsDBX6vh9OrYuDdU7tcmeCLmcmLTdYGGc2O+5NPlpFIfiNrpzBMVZjKFcxB8CthQ1zNdELZW/+cbpz+8g6Mdjib5IYi9UHae+v9Q92fR+CmHt3buBss7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883797; c=relaxed/simple;
	bh=3tH/+6lIxO4URvJgO1n8gy+tjRuroAKNkBz1xRvUGX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVgZf2fwFmCCp/Pja1DLfbi87xLk5i7TE2L5wwfb+rL+vZf1AP9Fx3dxAxwJMZ54lzyqg4FnHSvCDBNTgvz1nP2Hj9Xa0L8TNwAAbyELAxBZEHVStoPGpTiFEMRQGX08WIDm9msxQERfNz43dUCiAU/4ounz78Pwd/fUsN70HoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVAfMYHL; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12336c0a8b6so10539404c88.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768883794; x=1769488594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyReD0FGPHyCNo3ka9EshiTdpLiW7lhhWJbYHeoeAsk=;
        b=fVAfMYHLBeYXHSXJgPefI7JpULQC9uRR0QbhaMokhm6Rx39lwV0LtTQhPIkkEIDNIn
         de7h1bY0g68d+uUyPVY/bk4X4Lu+sG5BrPJ+GNWpNcRZNUy50OPdgcT7W//nbvvEjKRs
         p8sFe8fdDruhx8PftdzaFjo2feu1gl+OUW79ED0nfDyFlGHGU7tFujSs9yf0KCKjq/Gi
         y7KGLEaqJpofig9U4bg7UDjCmvyvtKlYqM0iPfDGFFzB++t+cgr1qmFpQobYDE+++6Ts
         w7W4gAJF70w72yvylTri5PFvkrVKkouqZjHAJrnCT6n30g0047V4qLX2+XgWNQEFx0wg
         pAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768883794; x=1769488594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyReD0FGPHyCNo3ka9EshiTdpLiW7lhhWJbYHeoeAsk=;
        b=YgQJzDdiTXe/9JdAb7OOrR6FH7wGpyr77OkNWTzjpacZd5mo+MNekknCgsxbNlAGLZ
         DPn8wo0se2RdabQ1lLu9Zfx/+30fntZ9jGCiFr2W6N+V6+O37z5dNj57rPcJOes/7tDY
         aCk/h68yN0wJKPegZHMxk3ugo0UdZj/XWB5qxUs5QFGxkCn/0D7EZin+hYk5qUDCFhzt
         hpDVJpy7lK+ujFnUbrcb7zfPMgCvf5XG2rrdC4MWgWBB6nTviDw4LIYJkwTa1ujCGpQ/
         sI7kRkV50AOUdLx3kvV2RmcmiHALNgrsZB/Q9/ehTPvjIF0HjOafBeHiFlLqd7NWVs9X
         CiIw==
X-Gm-Message-State: AOJu0YwTIUngk1R/Ro0wA+KsljTuxks79LHNGnkSMsUVtMZD2CyIMAJV
	uhrULO00RQDmCnv1+V14J7+2Bsx1NfRuKrTixH5LNrB/Vi2LCoK5Ib6S
X-Gm-Gg: AY/fxX7vzQPpULpcjqgN7uUXUZPOAq5pHD7GkcUyqsDEfnPhR0UfWBf3DGFHmrbGMvD
	8Bkwqmul7w0YRaQ1tKJU0eyyY3ex3TEEIOaGiOSHVt4KYKqg/JIZ89Ex/jfeS3ekLL5rtRyHiCc
	BZ9O+B7ll4kbWUQJeWf7leAcGoBjuBl9+eSlxBU1d65qXP8VLHz31whMauUO60ACrRMmsICDV/b
	sj+9o0jRSfMCm35dBOc2aJfOuvDLaBnLPv+F3mhNJlycQQGekSEe12uI8wutYHdh9WxPvnGsPfM
	nQ14N58+NYbekxindCiSvtIoT7NNuVqBL7Uk0AzFP1PjFOYd9UBarAyaQdE0ODqcueLrb72YOUx
	qPYW6stGrKi7SApR0yVtfm598ugJ897kyXarSCbXm9ddIJj4onX2A1SGnpgDMSB/WanPLdkCYyE
	HRv3SbAc1PMH6o9irzTg+S
X-Received: by 2002:a05:7022:2385:b0:119:e569:fb9b with SMTP id a92af1059eb24-1244a6fca7cmr8955362c88.10.1768883794022;
        Mon, 19 Jan 2026 20:36:34 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6bd8e7cd9sm14617890eec.16.2026.01.19.20.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 20:36:33 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3 SoC
Date: Tue, 20 Jan 2026 12:36:08 +0800
Message-ID: <20260120043609.910302-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120043609.910302-1-inochiama@gmail.com>
References: <20260120043609.910302-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds Spacemit dwmac driver support on the Spacemit K3 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 224 ++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 907fe2e927f0..583a4692f5da 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -216,6 +216,18 @@ config DWMAC_SOPHGO
 	  for the stmmac device driver. This driver is used for the
 	  ethernet controllers on various Sophgo SoCs.
 
+config DWMAC_SPACEMIT
+	tristate "Spacemit dwmac support"
+	depends on OF && (ARCH_SPACEMIT || COMPILE_TEST)
+	select MFD_SYSCON
+	default m if ARCH_SPACEMIT
+	help
+	  Support for ethernet controllers on Spacemit RISC-V SoCs
+
+	  This selects the Spacemit platform specific glue layer support
+	  for the stmmac device driver. This driver is used for the
+	  Spacemit K3 ethernet controllers.
+
 config DWMAC_STARFIVE
 	tristate "StarFive dwmac support"
 	depends on OF && (ARCH_STARFIVE || COMPILE_TEST)
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 7bf528731034..9e32045631d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
 obj-$(CONFIG_DWMAC_S32)		+= dwmac-s32.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
 obj-$(CONFIG_DWMAC_SOPHGO)	+= dwmac-sophgo.o
+obj-$(CONFIG_DWMAC_SPACEMIT)	+= dwmac-spacemit.o
 obj-$(CONFIG_DWMAC_STARFIVE)	+= dwmac-starfive.o
 obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
 obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
new file mode 100644
index 000000000000..72744e60d02a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Spacemit DWMAC platform driver
+ *
+ * Copyright (C) 2026 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include "stmmac_platform.h"
+
+/* ctrl register bits */
+#define PHY_INTF_RGMII			BIT(3)
+#define PHY_INTF_MII			BIT(4)
+
+#define WAKE_IRQ_EN			BIT(9)
+#define PHY_IRQ_EN			BIT(12)
+
+/* dline register bits */
+#define RGMII_RX_DLINE_EN		BIT(0)
+#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
+#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
+#define RGMII_TX_DLINE_EN		BIT(16)
+#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
+#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
+
+#define MAX_DLINE_DELAY_CODE		0xff
+
+struct spacemit_dwmac {
+	struct device *dev;
+	struct clk *tx;
+};
+
+/* Note: the delay step value is at 0.1ps */
+static const unsigned int k3_delay_step_10x[4] = {
+	367, 493, 559, 685
+};
+
+static int spacemit_dwmac_set_delay(struct regmap *apmu,
+				    unsigned int dline_offset,
+				    unsigned int tx_code, unsigned int tx_config,
+				    unsigned int rx_code, unsigned int rx_config)
+{
+	unsigned int mask, val;
+
+	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
+	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
+	val = FIELD_PREP(RGMII_TX_DLINE_CODE, tx_config) |
+	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
+	      FIELD_PREP(RGMII_TX_DLINE_CODE, rx_config) |
+	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
+
+	return regmap_update_bits(apmu, dline_offset, mask, val);
+}
+
+static int spacemit_dwmac_detected_delay_value(unsigned int delay,
+					       unsigned int *config)
+{
+	int i;
+	int code, best_code = 0;
+	unsigned int best_delay = 0;
+	unsigned int best_config = 0;
+
+	if (delay == 0)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
+		unsigned int step = k3_delay_step_10x[i];
+
+		for (code = 1; code <= MAX_DLINE_DELAY_CODE; code++) {
+			/*
+			 * Note K3 require a specific factor for calculate
+			 * the delay, in this scenario it is 0.9. So the
+			 * formula is code * step / 10 * 0.9
+			 */
+			unsigned int tmp = code * step * 9 / 10 / 10;
+
+			if (abs(tmp - delay) < abs(best_delay - delay)) {
+				best_code = code;
+				best_delay = tmp;
+				best_config = i;
+			}
+		}
+	}
+
+	*config = best_config;
+
+	return best_code;
+}
+
+static int spacemit_dwmac_fix_delay(struct plat_stmmacenet_data *plat_dat,
+				    struct regmap *apmu,
+				    unsigned int dline_offset,
+				    unsigned int tx_delay, unsigned int rx_delay)
+{
+	bool mac_rxid = rx_delay != 0;
+	bool mac_txid = tx_delay != 0;
+	unsigned int rx_config = 0;
+	unsigned int tx_config = 0;
+	unsigned int rx_code;
+	unsigned int tx_code;
+
+	plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+								  mac_txid,
+								  mac_rxid);
+
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+		return -EINVAL;
+
+	rx_code = spacemit_dwmac_detected_delay_value(rx_delay, &rx_config);
+	tx_code = spacemit_dwmac_detected_delay_value(tx_delay, &tx_config);
+
+	return spacemit_dwmac_set_delay(apmu, dline_offset,
+					tx_code, tx_config,
+					rx_code, rx_config);
+}
+
+static int spacemit_dwmac_update_ifconfig(struct plat_stmmacenet_data *plat_dat,
+					  struct stmmac_resources *stmmac_res,
+					  struct regmap *apmu,
+					  unsigned int ctrl_offset)
+{
+	unsigned int mask = PHY_INTF_MII | PHY_INTF_RGMII | WAKE_IRQ_EN;
+	unsigned int val = 0;
+
+	switch (plat_dat->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		val |= PHY_INTF_MII;
+		break;
+
+	case PHY_INTERFACE_MODE_RMII:
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= PHY_INTF_RGMII;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (stmmac_res->wol_irq >= 0)
+		val |= WAKE_IRQ_EN;
+
+	return regmap_update_bits(apmu, ctrl_offset, mask, val);
+}
+
+static int spacemit_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	unsigned int rx_delay = 0;
+	unsigned int tx_delay = 0;
+	struct regmap *apmu;
+	unsigned int offset[2];
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get platform resources\n");
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "failed to parse DT parameters\n");
+
+	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
+	if (IS_ERR(plat_dat->clk_tx_i))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
+				     "failed to get tx clock\n");
+
+	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node, "spacemit,apmu", 2, offset);
+	if (IS_ERR(apmu))
+		return dev_err_probe(dev, PTR_ERR(apmu),
+				"Failed to get apmu regmap\n");
+
+	ret = spacemit_dwmac_update_ifconfig(plat_dat, &stmmac_res,
+					     apmu, offset[0]);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure ifconfig\n");
+
+	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps", &tx_delay);
+	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps", &rx_delay);
+
+	ret = spacemit_dwmac_fix_delay(plat_dat, apmu, offset[1], tx_delay, rx_delay);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure delay\n");
+
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id spacemit_dwmac_match[] = {
+	{ .compatible = "spacemit,k3-dwmac" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spacemit_dwmac_match);
+
+static struct platform_driver spacemit_dwmac_driver = {
+	.probe  = spacemit_dwmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name = "spacemit-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = spacemit_dwmac_match,
+	},
+};
+module_platform_driver(spacemit_dwmac_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@gmail.com>");
+MODULE_DESCRIPTION("Spacemit DWMAC platform driver");
+MODULE_LICENSE("GPL");
-- 
2.52.0


