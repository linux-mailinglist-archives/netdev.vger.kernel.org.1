Return-Path: <netdev+bounces-145771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE19D0AF9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B8128288A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B31990DE;
	Mon, 18 Nov 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2QcqmJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5401990A8;
	Mon, 18 Nov 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918464; cv=none; b=TDwxQQUT/vkzthJNPkB9I3OD2ysf7kRr6XU5mxZTkDLdHDD3GuPRPT+dR1DyGUWsTRpkaUPp+95UdH9dUHPq2soIlI3jn2RKe74gPqdQ6+lpq2Vndf9lohSSeYJ3GcSZMkFzrXoQR++APvL4rMyt6kFVFlG03wXdEvour8i1/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918464; c=relaxed/simple;
	bh=PrEo5z7gTrWSitJ6tnO95QuGmdV5sGYL+dd1BM8kQSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ca3agiMsf9N6WtiwmiGyZxfEjgFAPdubtJly3NjJoNWhNcdWpGumnkesG8PUwoyNNmi6ypOOKmkW4T0K3cOXZeNSEPJcWQujionGVjBEyQCEvZFlt/CUNYGnHOVXd7tfHbVADAzupveTXZswYl2lBUYlduH45M1m/rGf15RwvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2QcqmJH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-211fb27cc6bso11266845ad.0;
        Mon, 18 Nov 2024 00:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731918462; x=1732523262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16HRfIBaIOQefaOEqHf21OoxuGB8KEMOdyUB3b6s3vM=;
        b=S2QcqmJHKo6js3N2kdKudHgyqhbbC3QJOxyZ3Zix50pAMLAURY5nZEjsoaNU2PeTfO
         laXNAPPHhMcu3JYGM4xnvTue41ubT8cKkwPEcNMHg7Kxwt0Ch9OGi6sFhDU1xgU/wm8d
         z4jOejRPrNToLk3pYZaKKksXCkcs7nxea1e/yR9OoWq5aXLPgL6K8gTKhio5nRfpNqww
         Lm2z7flhrGJ0TqxtVZ8bD8oO5YEG0yE96E4vqvnwhEC32qaGP3JwZR4PGaOuwWCM+nOw
         Zt6yodz4rv6OGkvaNizKvipj4n6ZvgewymDzbEA4yXgA1V4GdbMGzgEhzEHMEizsSu9M
         Pzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918462; x=1732523262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16HRfIBaIOQefaOEqHf21OoxuGB8KEMOdyUB3b6s3vM=;
        b=jOz80vbqZ14C67edWbLp499x+Mxt9TJ3W2rFjvwXB2vcNyltj5Hb7lCLJ/Xb1n1ZTm
         BeIWlBvSVA68C3EodS+vpObJfhUWTvPSVNHEQ34bjoVDBMcc1/Xf5DfNsgQt3WVP8fWH
         akcoVT8ec7iUYYZuD41YvTa0aE+8HM2FT/LjfY8cHmP1eoKavXKyv4ErDwcd4/ENiwqx
         dg6DTllM6iF4aQsSnpIUR+U8iWXlg5d+rMfX59DKVibi7kfvGcs76NcFs7off3N2IfvU
         MK2lDdX7noOnSXeV0ZcZxPgTuW/6LQu+Lj7zp/+q1Gbx+TLAfPRRfFLducT98QKBZVfE
         uv+g==
X-Forwarded-Encrypted: i=1; AJvYcCUEKSz2i23NxfFAv52mrpkHxvIlnXHdziWAGtQsTSNnkOUUZehPVfrN9k2ZD4FevHhvJum47G3X8stMom2D@vger.kernel.org, AJvYcCWbhmrEwBNeMZsIL/YT4aFBk0MgLaEA2doANXb7D7zI1lh6dXgqBJYi+zKkqipKD+Bj6Svg/VWoAR3e@vger.kernel.org, AJvYcCWkYo8MIhPnhvzJWWNgdGc7oq1hWbijHrbt76szydS/epBLXUL+o33Vs1HT9vwXT/wkAdkBi3ll@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1MHLEDOeTvbDwjZcXKOC+41P4BC5YwVdhjVACpjRo1i0IT9v
	Bwpmm9VkdrNqOpPeGe5NzysGHc6PCZkgbPvRzK17nEINCiLkiEwk
X-Google-Smtp-Source: AGHT+IEy6tC7uqAZ4pS3b+sguhSutRynYB4np+NWTuUGQ8eZTjHHPdGuobH+qioA32CEFRedVnT7Dw==
X-Received: by 2002:a17:903:32cd:b0:20b:6a57:bf3a with SMTP id d9443c01a7336-211d0d5b99amr184075665ad.1.1731918462011;
        Mon, 18 Nov 2024 00:27:42 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ebbf9esm51883815ad.45.2024.11.18.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:27:41 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
Date: Mon, 18 Nov 2024 16:27:07 +0800
Message-Id: <20241118082707.8504-4-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118082707.8504-1-a0987203069@gmail.com>
References: <20241118082707.8504-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac driver.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 180 ++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 05cc07b8f48c..55d94f669be3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -121,6 +121,17 @@ config DWMAC_MESON
 	  the stmmac device driver. This driver is used for Meson6,
 	  Meson8, Meson8b and GXBB SoCs.
 
+config DWMAC_NUVOTON
+	tristate "Nuvoton MA35 dwmac support"
+	default ARCH_MA35
+	depends on OF && (ARCH_MA35 || COMPILE_TEST)
+	select MFD_SYSCON
+	help
+	  Support for Ethernet controller on Nuvoton MA35 series SoC.
+
+	  This selects the Nuvoton MA35 series SoC glue layer support
+	  for the stmmac device driver.
+
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..c08fcfdd7b31 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
 obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
 obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
+obj-$(CONFIG_DWMAC_NUVOTON)	+= dwmac-nuvoton.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
new file mode 100644
index 000000000000..ac57384b393d
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Nuvoton DWMAC specific glue layer
+ *
+ * Copyright (C) 2024 Nuvoton Technology Corp.
+ *
+ * Author: Joey Lu <yclu4@nuvoton.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/stmmac.h>
+
+#include "stmmac.h"
+#include "stmmac_platform.h"
+
+#define REG_SYS_GMAC0MISCR  0x108
+#define REG_SYS_GMAC1MISCR  0x10C
+
+#define MISCR_RMII          BIT(0)
+
+/* 2000ps is mapped to 0 ~ 0xF */
+#define PATH_DELAY_DEC      134
+#define TX_DELAY_OFFSET     16
+#define TX_DELAY_MASK       GENMASK(19, 16)
+#define RX_DELAY_OFFSET     20
+#define RX_DELAY_MASK       GENMASK(23, 20)
+
+struct nvt_priv_data {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+};
+
+static struct nvt_priv_data *
+nuvoton_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
+{
+	struct device *dev = &pdev->dev;
+	struct nvt_priv_data *bsp_priv;
+	phy_interface_t phy_mode;
+	u32 tx_delay, rx_delay;
+	u32 macid, arg, reg;
+
+	bsp_priv = devm_kzalloc(dev, sizeof(*bsp_priv), GFP_KERNEL);
+	if (!bsp_priv)
+		return ERR_PTR(-ENOMEM);
+
+	bsp_priv->regmap =
+		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
+	if (IS_ERR(bsp_priv->regmap)) {
+		dev_err(dev, "Failed to get sys register\n");
+		return ERR_PTR(-ENODEV);
+	}
+	if (macid > 1) {
+		dev_err(dev, "Invalid sys arguments\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
+		tx_delay = 0; /* Default value is 0 */
+	} else {
+		if (arg <= 2000) {
+			tx_delay = (arg == 2000) ? 0xF : (arg / PATH_DELAY_DEC);
+			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay);
+		} else {
+			dev_err(dev, "Invalid Tx path delay argument.\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	if (of_property_read_u32(dev->of_node, "rx-internal-delay-ps", &arg)) {
+		rx_delay = 0; /* Default value is 0 */
+	} else {
+		if (arg <= 2000) {
+			rx_delay = (arg == 2000) ? 0xF : (arg / PATH_DELAY_DEC);
+			dev_dbg(dev, "Set Rx path delay to 0x%x\n", rx_delay);
+		} else {
+			dev_err(dev, "Invalid Rx path delay argument.\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	regmap_read(bsp_priv->regmap,
+		    macid == 0 ? REG_SYS_GMAC0MISCR : REG_SYS_GMAC1MISCR, &reg);
+	reg &= ~(TX_DELAY_MASK | RX_DELAY_MASK);
+
+	if (of_get_phy_mode(pdev->dev.of_node, &phy_mode)) {
+		dev_err(dev, "missing phy mode property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		reg &= ~MISCR_RMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		reg |= MISCR_RMII;
+		break;
+	default:
+		dev_err(dev, "Unsupported phy-mode (%d)\n", phy_mode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!(reg & MISCR_RMII)) {
+		reg |= tx_delay << TX_DELAY_OFFSET;
+		reg |= rx_delay << RX_DELAY_OFFSET;
+	}
+
+	regmap_write(bsp_priv->regmap,
+		     macid == 0 ? REG_SYS_GMAC0MISCR : REG_SYS_GMAC1MISCR, reg);
+
+	bsp_priv->pdev = pdev;
+
+	return bsp_priv;
+}
+
+static int nuvoton_gmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	/* Nuvoton DWMAC configs */
+	plat_dat->has_gmac = 1;
+	plat_dat->tx_fifo_size = 2048;
+	plat_dat->rx_fifo_size = 4096;
+	plat_dat->multicast_filter_bins = 0;
+	plat_dat->unicast_filter_entries = 8;
+	plat_dat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
+
+	plat_dat->bsp_priv = nuvoton_gmac_setup(pdev, plat_dat);
+	if (IS_ERR(plat_dat->bsp_priv)) {
+		ret = PTR_ERR(plat_dat->bsp_priv);
+		return ret;
+	}
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		return ret;
+
+	/* We support WoL by magic packet, override pmt to make it work! */
+	plat_dat->pmt = 1;
+	dev_info(&pdev->dev, "Wake-Up On Lan supported\n");
+	device_set_wakeup_capable(&pdev->dev, 1);
+
+	return 0;
+}
+
+static const struct of_device_id nuvoton_dwmac_match[] = {
+	{ .compatible = "nuvoton,ma35d1-dwmac"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nuvoton_dwmac_match);
+
+static struct platform_driver nuvoton_dwmac_driver = {
+	.probe  = nuvoton_gmac_probe,
+	.remove_new = stmmac_pltfr_remove,
+	.driver = {
+		.name           = "nuvoton-dwmac",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = nuvoton_dwmac_match,
+	},
+};
+module_platform_driver(nuvoton_dwmac_driver);
+
+MODULE_AUTHOR("Joey Lu <yclu4@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton DWMAC specific glue layer");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1


