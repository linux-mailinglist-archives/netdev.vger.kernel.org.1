Return-Path: <netdev+bounces-172728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A8A55D07
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6813AC0F0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541718DB0C;
	Fri,  7 Mar 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzOmfpCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88B18DB19;
	Fri,  7 Mar 2025 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310235; cv=none; b=PnIEWOdzeALDdnopbhx9b0D8BnGu7t+uAH/Tvv2tjXH7FOyXvsOBLYOLdSk6sI0Q/cvs8VCK7ZA4FL7ApMJjk+bLJxikMG17QyiXZLT97pT9ImfQVN6A0YAn/deG0mSmPKzqXqDvlvG1Fji6HOSsmDTc/hao8cf0aDjFf8z+1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310235; c=relaxed/simple;
	bh=rT53SCaaVbGJ+Kz/KOPyoeMMs/52CFfpuNNV1WCsgfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxdbHWHlDm6ODLKyAcglaBWwrLN1L1WHpVeFUzLLtbIbL5EIdEVcQmLVtTWG19udtizTQMdHt0XR06YfSXgB1zBAgMcxAlYitalP5D72xBH1UmBtwpj2Ot97vBUrpQj4fGirv//ngeiIW8fYFQ4Oarb39vxg09SmqyZg8+l5gsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzOmfpCc; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso21261726d6.2;
        Thu, 06 Mar 2025 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310233; x=1741915033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gXTk8qUZUrnOwHtwmCMyQivc0+1c+3MiZGe5M0qnaw=;
        b=mzOmfpCcrU3QI59xi7Mhl3CaSA9BZBTF3/kQMZEN3SnQPjKly5Hbeyj13ZBAqvEkoy
         +GVNR7A2CyUpqXK5m7kqbB8NrIqjDlD2Y24TCEdvCn8FAzBiDGSMlTO8EEL0qekYXGee
         Q4cRD+qJP1z4GQQI1XkcjSKnDSdX5Tg65tI87gWKHFPMiLt+Ko1eNN75RU2xDC/upmrH
         HUsdOw3T796sJU9+5XSg8jp8rxTnVgJO3TZFylEYZHkm9NUp9aNwtZoqAA+Zf8qAfShj
         8IlB6HdCccAMu5A9R7mHrcszmoROmbSkakAbCyon7677s8XVe+07wCRWsYxLcfdZWbRV
         PXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310233; x=1741915033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gXTk8qUZUrnOwHtwmCMyQivc0+1c+3MiZGe5M0qnaw=;
        b=twQf6/ipT2b+3tDi0HHspRT1MK5q4u2M9O9L9mogdvo9b7Qr6dOcn8wSLIzoFnTp4g
         OEHPQt8jlSrim+uN0GBuL9v03ClZxvgo5rOiDcU4H1AzQyziCMkaF8V02bZhHvWC6vKH
         0dH/1WnRB5KPUdsys+PUQLW/5Xurjia7CVUmQxDmvb8Ms+1L4oROHBH8xjIr3pfmLVsd
         7UOLBCXZocIBoWJIuDs4TrdLq9IAKMMBKJTZEWApQbuGvVnuZVLN00zaRQm25NhWxpCL
         oygXDsyPyjkQ8q6CO0sieXFuk8FV0ojuGzljmoRTofpbyrxOJBeCraJUFejJ6HVUC8xx
         6VOg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJLJ9ARFw68QjR0NOyfxlW4rt9t3T/zDg5lghJz+RnLUHtGDDm/QHZ+RsuO0OcSGmfk3ID6KXJWBeDUVm@vger.kernel.org, AJvYcCWH1elGCkdHxf0ZUFXUfnsj8Y7oYw/2HUnNNIc8hcHMSrOhldMR/v9fgF20QqhHqyglk2RgamurbMo1@vger.kernel.org, AJvYcCXmYtSnkI00TQ61KZFsm0R5cjdj7CxViptSwsP9z0+R9i7RSYSQnAhAVWstP03aqHPia4DoJwfu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvze9lburQBgGQqFJigI6hfmvKra+XUj7a1KqXo3AWv8PlF6jR
	41nqp8X9XlS7vMwP/Vtg8lb770FqBfxbr2nWo861HGdwRpmY/YBb
X-Gm-Gg: ASbGncuBszjw475Xg4ebKeoswm20Qur26KDjJu4PmzF5dXghuQCDjuMuM4grIWpxiLT
	QqJuAc2njYZm1QNMgICJFHf3KzgKLaKqzPHGXoXXyAOKg3sCNeNguLe/KmR8pOocXnZiXK8kqNw
	bzia94XkdjzyIpg+rLw2Izz5s6U3p57P8rRMoLxutKSs9Muyz7dC/0ecnpYmUPf8obCRAIbYljP
	Kxt21TVydGs4QxNCT8wD6d8yU7KSqnZrHXL7AmWN6c1TYJcQ+3qsFT7HEkXigeheLLy+A8Breia
	r9oo2+0g72iJeZ6wKjTd
X-Google-Smtp-Source: AGHT+IHE+8EL46HeTkJY4qWuwltpuYkIIW0VnLRZHZ2+pqBFKA0/3mal8lXCevauY19bM/VgFFuWpQ==
X-Received: by 2002:a05:6214:1c49:b0:6e8:fa72:be47 with SMTP id 6a1803df08f44-6e900604eaamr17255846d6.8.1741310232912;
        Thu, 06 Mar 2025 17:17:12 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f707cc6csm13409996d6.11.2025.03.06.17.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:17:11 -0800 (PST)
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v7 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Date: Fri,  7 Mar 2025 09:16:17 +0800
Message-ID: <20250307011623.440792-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307011623.440792-1-inochiama@gmail.com>
References: <20250307011623.440792-1-inochiama@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   | 11 +++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 75 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index c5f94a67b3f2..3c820ef56775 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -181,6 +181,17 @@ config DWMAC_SOCFPGA
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
index b26f0e79c2b3..594883fb4164 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
 obj-$(CONFIG_DWMAC_S32)		+= dwmac-s32.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
+obj-$(CONFIG_DWMAC_SOPHGO)	+= dwmac-sophgo.o
 obj-$(CONFIG_DWMAC_STARFIVE)	+= dwmac-starfive.o
 obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
 obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
new file mode 100644
index 000000000000..3303784cbbf8
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sophgo DWMAC platform driver
+ *
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include "stmmac_platform.h"
+
+static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
+				    struct plat_stmmacenet_data *plat_dat,
+				    struct stmmac_resources *stmmac_res)
+{
+	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
+	if (IS_ERR(plat_dat->clk_tx_i))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
+				     "failed to get tx clock\n");
+
+	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
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
+	struct device *dev = &pdev->dev;
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
+	ret = sophgo_sg2044_dwmac_init(pdev, plat_dat, &stmmac_res);
+	if (ret)
+		return ret;
+
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
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
2.48.1


