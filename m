Return-Path: <netdev+bounces-256902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOpKi31g2kwwQMAu9opvQ
	(envelope-from <netdev+bounces-256902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:41:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71130EDBB7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 515173012502
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA92C0282;
	Thu,  5 Feb 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMd4hE3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59A29B8EF
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255624; cv=none; b=P7VNt031FV32yurjSkii+9b4i46Nk/HDO6elLw+NGStvbrZMo+Uj4HxH1cnELCsNLOL2GiPuP9n/j8molJdCUy0Lxiiq1JB/Xy/7hdPx73oOd6ar5clc1lJg20X8Mopr2VyuHhFvIHuL/gueylTP3UOTkFqBl6Zd9+xPGRVH2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255624; c=relaxed/simple;
	bh=6OxCW4/8eX3SpcYcTZYAJWte6AYr5sqqDRBYC5C+QDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhjvuhw6jyzKQ4ppiDU/imIpTdytRKKyE2Ay2CTU5A2P7qcE2yipB1SweVWqIdf1sVb81Ri+11dhvgyqu+PWeFtcJElDr3t9s8pRxPgzSGYnvruQ16XGIXaFIiueo53AcFAaJUToE781LT9s2ndRcsMM2FFVllcXGlXWMqtHkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMd4hE3E; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c718c5481so187537a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 17:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770255624; x=1770860424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql7XnrRQpwwnuceZEbbuf6WcOeUUcSgZ0nMQ4Ij9Jcw=;
        b=WMd4hE3E8ddbmXyv75ll9TVh08Z/baImh3wG9e2AKRfe42iCuKkcl/8TSbsjNuNDBa
         40gmNBKK2QlxbtW82Q3yA+HI0cwQJOkUzbMd2h/EmMne+Dl35vMbNyBmO0WTujz9gny6
         dRyAH7tdogFEuuwruOr/O0+LHkwH3O6jt3dfOVU4VEm1M5z3K+0KY7sAWE76cZaHru7r
         Sj4qSGeL9vuhhsWvsFV917IlMb4IHX26Zl9QTjrQFNG0VEhkY7nqg0Fc564uiBL6eCls
         eD/N4BS/qH8izR4uFgbimh9TNsqTIeWlgnkUESJ2ePLWt0jNxVj0VxCjyRfm1Eo9HTae
         t2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770255624; x=1770860424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ql7XnrRQpwwnuceZEbbuf6WcOeUUcSgZ0nMQ4Ij9Jcw=;
        b=NQLKPgEUSCXvFlCVCeyb2XO6WDnFlpppzlZJ4ySVI0ziZ4XravDrWAqOCIGJeZA8iJ
         SqbWHD3QmekUlg0Sn7BKZfUnelysD+B/yvv0AarjrhJdkmZQSpLItt+levMOa5kD3l6m
         9Fx6ovVN8sSWRDpyLvpu+FbkbrAnYSFS5pWmT35g6sTThbjF1aOfbxh+4jI4dqp0yYQl
         jQuI7Jod7WoN5inUdlTwyoGlPfyNY5OxxpWzPre5v+/7T0HBwT3Edt3kCGjXvHjaBRNk
         UT7bKNOUwYzv9ZGYrHym+THQSqwpQ48UduItp5w5xMcWVzCz7370l2Ib9pWGbauZ0064
         l+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDxH8soKdd8djcWKkSbEy12afilCfIwvBJ1fmuAotu6DcP2CwxOt7gJPZEtwnXNaRz3+N6jqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4isYTLRntN3bfI092vOykqQwCRMAkGRSK0+bNcpVqTp7wqRD
	NxP0OFRRPqsbZ/OOycRIAhkj/zscNWn6V4rKcWm9QLUFHaok/RNZPkFo
X-Gm-Gg: AZuq6aIV2JqCe3ereapzUt7WVrjtwdjyPY0Hnc7WckFja4/JiVUZcAUV8AOFKhuGxsI
	f9wZm2VSNCFm1vFT+Yqt5EfEtPiSTt86VrC/S+z9F4nqqGn14ZWAFGUpjZWgT7ZS01qc/6hyG7m
	WR1v5FXkdWz/7eA2bWvlsemEwOm0lyEeXmNVnWupUSaLixv+jNmceiLFjimi5/MyhR2ef/aEJV3
	o+Y47ajGKhKDvcxa99bXHJZKh9c3Ncxr+92k7uU1cwoE56R1ceUZ3YLOfaSPxvuYveF5hcfKcA9
	ZUyv0PtmEylj7OzjyOdrqa3PJsQ5jfmxtQMzHbYdLv38swq/nKtINpj6VgvaA7kAtezGs7GEXyu
	/GRAjvkVaM5JjQoynT9uj7J22azGVttuN/7NYFAIZx5nDEmEzpIg8PrONkAg59J18xgzbtDEczl
	5XsKz2nIKz4KF//AYEhSTWX5S0DnzPEXWEa7w4viJ+I3GRWQYgGOmwkwCblmmgob86SYrAoa/s
X-Received: by 2002:a17:90b:5823:b0:34c:cb3c:f549 with SMTP id 98e67ed59e1d1-35487207d74mr3923205a91.29.1770255623678;
        Wed, 04 Feb 2026 17:40:23 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c487a7bsm673571a91.16.2026.02.04.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 17:40:23 -0800 (PST)
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
	Joey Lu <a0987203069@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v11 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
Date: Thu,  5 Feb 2026 09:40:05 +0800
Message-ID: <20260205014006.735408-4-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205014006.735408-1-a0987203069@gmail.com>
References: <20260205014006.735408-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com,lunn.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71130EDBB7
X-Rspamd-Action: no action

Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 173 ++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 07088d03dbab..861f1c6c14f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -132,6 +132,18 @@ config DWMAC_MESON
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
+	  for the stmmac device driver. The nuvoton-dwmac driver is
+	  used for MA35 series SoCs.
+
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c9263987ef8d..4ade030b634f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
 obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
 obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
+obj-$(CONFIG_DWMAC_NUVOTON)	+= dwmac-nuvoton.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_RENESAS_GBETH) += dwmac-renesas-gbeth.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
new file mode 100644
index 000000000000..dd233e0a32ee
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Nuvoton DWMAC specific glue layer
+ *
+ * Copyright (C) 2025 Nuvoton Technology Corp.
+ *
+ * Author: Joey Lu <a0987203069@gmail.com>
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
+#define NVT_REG_SYS_GMAC0MISCR  0x108
+#define NVT_REG_SYS_GMAC1MISCR  0x10C
+
+#define NVT_MISCR_RMII          BIT(0)
+
+/* Two thousand picoseconds are evenly mapped to a 4-bit field,
+ * resulting in each step being 2000/15 picoseconds.
+ */
+#define NVT_PATH_DELAY_STEP     134
+#define NVT_TX_DELAY_MASK       GENMASK(19, 16)
+#define NVT_RX_DELAY_MASK       GENMASK(23, 20)
+
+struct nvt_priv_data {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+};
+
+static struct nvt_priv_data *
+nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
+{
+	struct device *dev = &pdev->dev;
+	struct nvt_priv_data *bsp_priv;
+	phy_interface_t phy_mode;
+	u32 macid, arg, reg;
+	u32 tx_delay_step;
+	u32 rx_delay_step;
+	u32 miscr;
+
+	bsp_priv = devm_kzalloc(dev, sizeof(*bsp_priv), GFP_KERNEL);
+	if (!bsp_priv)
+		return ERR_PTR(-ENOMEM);
+
+	bsp_priv->regmap =
+		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
+	if (IS_ERR(bsp_priv->regmap))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bsp_priv->regmap),
+				     "Failed to get sys register\n"));
+	if (macid > 1) {
+		dev_err(dev, "Invalid sys arguments\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
+		tx_delay_step = 0;
+	} else {
+		if (arg <= 2000) {
+			tx_delay_step = (arg == 2000) ? 0xf : (arg / NVT_PATH_DELAY_STEP);
+			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay_step);
+		} else {
+			dev_err(dev, "Invalid Tx path delay argument.\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	if (of_property_read_u32(dev->of_node, "rx-internal-delay-ps", &arg)) {
+		rx_delay_step = 0;
+	} else {
+		if (arg <= 2000) {
+			rx_delay_step = (arg == 2000) ? 0xf : (arg / NVT_PATH_DELAY_STEP);
+			dev_dbg(dev, "Set Rx path delay to 0x%x\n", rx_delay_step);
+		} else {
+			dev_err(dev, "Invalid Rx path delay argument.\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	miscr = (macid == 0) ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR;
+	regmap_read(bsp_priv->regmap, miscr, &reg);
+	reg &= ~(NVT_TX_DELAY_MASK | NVT_RX_DELAY_MASK);
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
+		reg &= ~NVT_MISCR_RMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		reg |= NVT_MISCR_RMII;
+		break;
+	default:
+		dev_err(dev, "Unsupported phy-mode (%d)\n", phy_mode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!(reg & NVT_MISCR_RMII)) {
+		reg |= FIELD_PREP(NVT_TX_DELAY_MASK, tx_delay_step);
+		reg |= FIELD_PREP(NVT_RX_DELAY_MASK, rx_delay_step);
+	}
+
+	regmap_write(bsp_priv->regmap, miscr, reg);
+
+	bsp_priv->pdev = pdev;
+
+	return bsp_priv;
+}
+
+static int nvt_gmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct nvt_priv_data *priv_data;
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
+	plat_dat->core_type = DWMAC_CORE_GMAC;
+	plat_dat->tx_fifo_size = 2048;
+	plat_dat->rx_fifo_size = 4096;
+	plat_dat->multicast_filter_bins = 0;
+	plat_dat->unicast_filter_entries = 8;
+
+	priv_data = nvt_gmac_setup(pdev, plat_dat);
+	if (IS_ERR(priv_data))
+		return PTR_ERR(priv_data);
+
+	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id nvt_dwmac_match[] = {
+	{ .compatible = "nuvoton,ma35d1-dwmac"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nvt_dwmac_match);
+
+static struct platform_driver nvt_dwmac_driver = {
+	.probe  = nvt_gmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name           = "nuvoton-dwmac",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = nvt_dwmac_match,
+	},
+};
+module_platform_driver(nvt_dwmac_driver);
+
+MODULE_AUTHOR("Joey Lu <a0987203069@gmail.com>");
+MODULE_DESCRIPTION("Nuvoton DWMAC specific glue layer");
+MODULE_LICENSE("GPL");
-- 
2.43.0


