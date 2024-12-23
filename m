Return-Path: <netdev+bounces-153983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C659B9FA8DA
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 02:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A2E1885A67
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A722FBA3F;
	Mon, 23 Dec 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZU1kdFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB5364D6;
	Mon, 23 Dec 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734915574; cv=none; b=b7PtgCwM7jxGYus3ps5/0UDLcg6FD9fSus0kLY5GZwIA4Il1Fh91veXm71TiFHPA0pFCe/UzyFkiErxGJ10LpEznX0ZbN3z8Byzf6Sdbx96ZxmmUn38IUnnZZrgvDCxowfBMJG/zw/0dmi/9KfaiVrtTf7xjkGQRIDPQm2gA6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734915574; c=relaxed/simple;
	bh=lYkvdYzvLx9+N909oP0UT60cVLQ2L5Mw+4bjH4vmpK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a60bjJZ05EGuCCPBJfuCQV3YvrhM7tcQT6jGPiOKiBwdfD8OtuISsz76Kfmr9qUYQKO1ZuYvAG9fth6rOyYMZdgyuw4d73V7st+lWqLmjpUVl3mvWMGUrTdGkgRA+Rcn0sbaemcl41uiwZhbgUQdVlPvXt1A4dHpOTAoISVHnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZU1kdFg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467838e75ffso45648701cf.3;
        Sun, 22 Dec 2024 16:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734915572; x=1735520372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSgmUq6fWDAYGhUiI+1p1Nvpascpw09NerCf1YnBrAA=;
        b=WZU1kdFgiwdp4vUAgKEqMPx8pdpDTo1c9oqv3gU+zxN99i4HE6M+1FYsLLKYNS6nl/
         ESdhEy9i8ts01rBNcV2myGtx9Y6LT/q1vVBnddKhL9r2z0bwnci1ZIl23yRz8L+O3VjP
         8CLSnGfdOZwnrobiKr6AA9Zf8OARUnmCIYdTLk08v3uOg/YpenVTNWUHp3dNmQa2FLrV
         GJ1ABS4zU/mS/ktE5JNtFNMTSvDLbBi2qxEui/0GXXKdfoJ91npRTrRZsj9RnWUxckkW
         EI4WwM1Z8FLbN1I/Q6cx7uW7mmbefRr5/ioL1WlB1TyzXKxjdRy9FvfL8iNAvKroMove
         Itnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734915572; x=1735520372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSgmUq6fWDAYGhUiI+1p1Nvpascpw09NerCf1YnBrAA=;
        b=edc2jDgulsus0zQlDiJHMARX2B/b1P571mun5ZsPV0so1dTy3pNqY6Ag8ck4akwSs3
         4yqhQBPgWZGcRycqnRhTgE5wCQ43+zjp7tyB335FkcyOEJVBnDbrGk/99MmLnRkXRFD3
         kYtpro0Jddvhng843OonRn5yAR8TFlYFXh00i9yaP+UDVesHWGrZUJcq+qm6R8u84n08
         JqdkKsXt3FD+IWc1+cismQo/jhP0FBl2/BlESd6XDZg1K6QmtQSlted5e3l3dilNX2ve
         4jUiEIkMr0JXk93OUEDuU+uo4vARWZHjejQmbpRitvHK3qWyQbA71ne10MdkjdmAPM47
         WI7A==
X-Forwarded-Encrypted: i=1; AJvYcCUkPVoHb8Wto6MvRHFShgNql24P81bmHT443kPPW/Ym/GPZN+h6z0kUXPJn6wkcuUAT3izCikKc@vger.kernel.org, AJvYcCV/kLfQ4xQeaul65QJYHsWK1XHBYQGXqcGhJtp05pjMgJLyaQd97pykAiroQe1Rag4AbvHuguEslDBBU/iQ@vger.kernel.org, AJvYcCX0zigqNgONUrwlZyaaJnIQ84aEU0O5Fz8BA6Oufdq7oCIkEc6AxVeR2yn+mxgOuez9SAkZFsgj0090@vger.kernel.org
X-Gm-Message-State: AOJu0YzqKMiFlrJALOtjqfYTlUKCa+Es7c+2AJITXsNCVXhm3flqvqty
	ti9gSXD5Olu798UYE9n8CKOkmv+TvKRIW/7uqJfuDdWUGgxfoC2Z
X-Gm-Gg: ASbGncuDSduk7c8Pcpt+pojmdB1UoIgPMfeAFYwypBV2nA2TRiYhEM1T+aL6Ey3suLM
	Wt81OZ5S65352/1IM62WLp6Sm2kTBeOlKknQJsD3/Cot6NGrAltqeWCK8Fdo2AcVVhRVyu7YvMX
	oidxMv6S77B9M9D4+Ycla1tXvi1VeD60gqjji204GcYT0eIhKCSJbatmWq3r/kGBrP/hgwnk1GI
	qNOdBbkD1C0SX1eBjGDD6Qad6xlQT3+
X-Google-Smtp-Source: AGHT+IHjz7WDJXZngk0HiOawE5i+rAuNn2t3oiKW5rDk4l39S/7Vt67KkTJKlnank9Y1jvPWV5vKBA==
X-Received: by 2002:ac8:59cf:0:b0:466:9824:16ef with SMTP id d75a77b69052e-46a4a8b5f64mr181259011cf.3.1734915571686;
        Sun, 22 Dec 2024 16:59:31 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb33b11sm39454091cf.72.2024.12.22.16.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 16:59:30 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v3 3/3] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Date: Mon, 23 Dec 2024 08:58:39 +0800
Message-ID: <20241223005843.483805-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223005843.483805-1-inochiama@gmail.com>
References: <20241223005843.483805-1-inochiama@gmail.com>
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
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 105 ++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 6658536a4e17..23085d27ace6 100644
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
index 2389fd261344..36f21c86568d 100644
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
index 000000000000..a4997cc0294a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sophgo DWMAC platform driver
+ *
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/mod_devicetable.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
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
+	if (rate < 0) {
+		dev_err(dwmac->dev, "invalid speed %u\n", speed);
+		return;
+	}
+
+	ret = clk_set_rate(dwmac->clk_tx, rate);
+	if (ret)
+		dev_err(dwmac->dev, "failed to set tx rate %lu: %pe\n",
+			rate, ERR_PTR(ret));
+}
+
+static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
+				    struct plat_stmmacenet_data *plat_dat,
+				    struct stmmac_resources *stmmac_res)
+{
+	struct sophgo_dwmac *dwmac;
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
2.47.1


