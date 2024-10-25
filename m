Return-Path: <netdev+bounces-138913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681229AF67F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F981C21471
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A214A84;
	Fri, 25 Oct 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+jWHOYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69013B58B;
	Fri, 25 Oct 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818637; cv=none; b=r4+45n2ZnvnzORPFb7iUhlB924L3gTpqXdzA8X8xzuSk4JnwlX3KlzbvOQrgzlL/1WeFckHgg1jA25Sktq+dQdKG24TR/i8gop3YdYl62v0cKMt6R9vHy1dr3QkUs7C2B6/bxO4Sd6uw0PVyBEkpcW3zToohUdrdPT1f7c0t9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818637; c=relaxed/simple;
	bh=W9i5Zg+RiJZ2r/kuY+MWyba1Q2p2aXsuX5p5r7Mw3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiMeZItpBYOa1x5oTGs3H3EOVSexxDwqStXRtCyQYb7rmFwH5Nqkwxt4i0D6kDGtiImBTd1kOid+mVEtO6Byy/gliO3DLURz524NqAthGsZc2DyIMj6avjUvjByG3NJMDL3srYdnQGHAVI1/XgtVZncaJ07vGJOFxu3APNdq/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+jWHOYU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbca51687so13586055ad.1;
        Thu, 24 Oct 2024 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729818634; x=1730423434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFxf4QxLF/toEmNXgaIElhCUJYLQZAP/bPPOulcpatY=;
        b=i+jWHOYUK39ol42lNCZfdU/lR+Etz/B2fhHq8pEKxS1srHrOMM+rJyhn+Bo+sx+OVx
         SNqgYPrrP9KBsoJhxzdMtKPxCGYMiB5koohFMRzkKKEHxDv1cEFyewF7Tex7BZu+niYF
         ZX12EMPwe3jUIO6pCR3S2Dv5X+r/TiNEUL3xy5M/N7XYS8wT2gQowIJ/qmGkTDnpKBAg
         5WNzBrFatTePy2khCrT/GfLh9FXaBHAZORTY/3c8EjbC48n2gSodZkEUtq5lLRyLRKEX
         gIx6+TLlcnmxZ6pbOBQpzWi7rGzIolFJluwrvJwqr12M+8Z45O8dlgpOynpaZHqu/Djc
         60TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818634; x=1730423434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFxf4QxLF/toEmNXgaIElhCUJYLQZAP/bPPOulcpatY=;
        b=cILnvRQyxJhB8qVyK+ksaoMnlXbYSeTowdiV4QuQ96peZV2BUFlvjcGFQkltMkzOVq
         4Zx6nBSIkJUnN6hcIqKFJcmgS5YjYgWMFQCtdvRDjCMDNC8bBmPMYucHsunGE82Zlya+
         rhxar3ve2gkilv0FGuAFoJNodGNPaO9IGYTi6o1Orkbm3YsBHER9+12TcKbsTxLpI3Wh
         +qSkd+6CfndE6aNHcpeJ5DRa2kp9z4Kf/oOTfqhNlKpv8CAbNultFf9Q7evrq1pbFaLT
         dAVqmXf+pZg8dSshAVut6vqsgJSMb46tWO0EksHx6brGFpFaORq9DZW9w51J4hnMD73U
         CkZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpDczaCr79L/UcZZnTCo/yuJtFBcJX9bTX2LVhZSPSdjt3GtGtqzpT7khDGk0iy4cwWNbeDMbbLvU7@vger.kernel.org, AJvYcCWM3cqZQRcAP4K8CfofHaZGiQI7fp+fJUuJ5B6IlxKpg+3NrzH3AaTnGAsaJtdILOTykx1bUsTfhlwqj+mw@vger.kernel.org, AJvYcCXX2miPpUfNyf4PzoflHO3+RXx7d86Vm8kPjogRFeLNzDjD5HxSioNvkcS4SBELvoc45i1lmcer@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdXGi8zxTL/Jm3YoLmXxyb8FW0+nQyu72uTRk7nOpJz/rJPVD
	GYNwjLbV7b/GzApxfD25B7k1YOe0O2fgbaBILrHere4S4TYMXg6Q
X-Google-Smtp-Source: AGHT+IFIq9qVzQMxjRua0X+FHJBdW6t1PsYawZfLFed4kLY+0QEbScHCnjfUEv7d3LnygX8Bdb/9XA==
X-Received: by 2002:a17:902:ea0f:b0:206:c486:4c4c with SMTP id d9443c01a7336-20fab2da20cmr102567405ad.57.1729818634564;
        Thu, 24 Oct 2024 18:10:34 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc082597sm554485ad.287.2024.10.24.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:10:34 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Date: Fri, 25 Oct 2024 09:10:00 +0800
Message-ID: <20241025011000.244350-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025011000.244350-1-inochiama@gmail.com>
References: <20241025011000.244350-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds Sophgo dwmac driver support on the Sophgo SG2044 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 109 ++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 05cc07b8f48c..bc44b21c593f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -169,6 +169,17 @@ config DWMAC_SOCFPGA
 	  for the stmmac device driver. This driver is used for
 	  arria5 and cyclone5 FPGA SoCs.
 
+config DWMAC_SOPHGO
+	tristate "Sophgo dwmac support"
+	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
+	default m if ARCH_SOPHGO
+	help
+	  Support for ethernet controllers on Sophgo RISC-V SoCs
+
+	  This selects the Sophgo SoC specific glue layer support
+	  for the stmmac device driver. This driver is used for the
+	  ethernet controllers on various Sophgo SoCs.
+
 config DWMAC_STARFIVE
 	tristate "StarFive dwmac support"
 	depends on OF && (ARCH_STARFIVE || COMPILE_TEST)
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..e1287b53047b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
+obj-$(CONFIG_DWMAC_SOPHGO)	+= dwmac-sophgo.o
 obj-$(CONFIG_DWMAC_STARFIVE)	+= dwmac-starfive.o
 obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
 obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
new file mode 100644
index 000000000000..8f37bcf86a73
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sophgo DWMAC platform driver
+ *
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/mfd/syscon.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+
+#include "stmmac_platform.h"
+
+struct sophgo_dwmac {
+	struct device *dev;
+	struct clk *clk_tx;
+};
+
+static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct sophgo_dwmac *dwmac = priv;
+	long rate;
+	int ret;
+
+	rate = rgmii_clock(speed);
+	if (ret < 0) {
+		dev_err(dwmac->dev, "invalid speed %u\n", speed);
+		return;
+	}
+
+	ret = clk_set_rate(dwmac->clk_tx, rate);
+	if (ret)
+		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
+}
+
+static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
+				    struct plat_stmmacenet_data *plat_dat,
+				    struct stmmac_resources *stmmac_res)
+{
+	struct sophgo_dwmac *dwmac;
+	int ret;
+
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
+	if (!dwmac)
+		return -ENOMEM;
+
+	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
+	if (IS_ERR(dwmac->clk_tx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
+				     "failed to get tx clock\n");
+
+	dwmac->dev = &pdev->dev;
+	plat_dat->bsp_priv = dwmac;
+	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat_dat->fix_mac_speed = sophgo_dwmac_fix_mac_speed;
+	plat_dat->multicast_filter_bins = 0;
+	plat_dat->unicast_filter_entries = 1;
+
+	return 0;
+}
+
+static int sophgo_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get resources\n");
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
+				     "dt configuration failed\n");
+
+	ret = sophgo_sg2044_dwmac_init(pdev, plat_dat, &stmmac_res);
+	if (ret)
+		return ret;
+
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id sophgo_dwmac_match[] = {
+	{ .compatible = "sophgo,sg2044-dwmac" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sophgo_dwmac_match);
+
+static struct platform_driver sophgo_dwmac_driver = {
+	.probe  = sophgo_dwmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name = "sophgo-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = sophgo_dwmac_match,
+	},
+};
+module_platform_driver(sophgo_dwmac_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@gmail.com>");
+MODULE_DESCRIPTION("Sophgo DWMAC platform driver");
+MODULE_LICENSE("GPL");
-- 
2.47.0


