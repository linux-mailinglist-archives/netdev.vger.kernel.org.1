Return-Path: <netdev+bounces-171931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7EAA4F753
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447C51890D81
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DD1F790C;
	Wed,  5 Mar 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/LlYFOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6A1F8AC0;
	Wed,  5 Mar 2025 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156810; cv=none; b=q9aRE2VE/773INMlgsMU3S4QZuQRrU7jnw1alphfQmqWfsh7g96QazZ7vjwYBQEVbMcQktWzGnUHS61XMYWOP0PjRnQiAI7clSRuT/jKIdn8PCuMqGVyDIkHTdhqiammcGxzZ/jp21HR+QZALFdwzWmuRk2+iT0hMFl7CuEvOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156810; c=relaxed/simple;
	bh=AGPOsmkN5Fae072sh/GeM7rngO+K7bS+aZizA0BpZdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umPvNwlNkWCHcPY7k0ozJTbfGZglOaZQeipaXh7AA3lYwY1yKe5SXABmCs6iqR49TKmuz7ZgSztVwWIwsPF6ZCeOJhH96YPCUDtemZmaJ3DBqfIQgC1QVP1zwSr1o2latK2CDcXj08SujEpS5Z01mQ8VBbiKfzt27xkdvL0JRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/LlYFOt; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3d0e90c4eso49499585a.1;
        Tue, 04 Mar 2025 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741156807; x=1741761607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY6Pi0eVXjTj4iYGf3V3W021FfEKM0ai79ohmKI0mfc=;
        b=j/LlYFOt17K1wD0V3sGeDcP0hN5KIu361bG9rY6CCmK3blmB+mJtZHE51ofEli/VOH
         OEFgqwGLcjDAqhIikyxvcNPUJOLtVN9j+CkVtxQYZ42GBuy4rBSSMGydEcbRSZtUXh82
         Z6ih5VRjdVpGqxkr7AlMJU+WnDWNYTvcrNCMMpObfU3oAjmd5JZUvh05iOibV732up/J
         6QVkBnHffgMMWyvxtlIYmQ016WTO0vxT5Y8AVrCwas9ZHReXs6WDPitQjk3mSPTlcV3A
         blvb6q3YsCMe4emkP09n4JgB1t7su/2FgD6RjonVTnaS57I1gVQ4prsayfHUy3oRq/Fa
         B5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156807; x=1741761607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY6Pi0eVXjTj4iYGf3V3W021FfEKM0ai79ohmKI0mfc=;
        b=TULUDDMFElLKFa2KnQ1pnUsP5SmpZTk46fTIVmM7qD/YbG0B32BvfnuK5jPTdyITgG
         uZ5/715vUc0+ncEo2uVAwgqgokbUCnGJK0khqrKFy2eQQodtbfFt3yOt/el3/6NDzW+U
         wL2e6esYwLvJZA3XmnvcTmRlzowjsfleZPeIWRBKq1b3tYBP4o7Zps7yM6+Y3dQiaEGg
         5MKwLGFGA3SMz4p9v5TVt2lfFzzvVOo1wnOtK7PsE1JoRmNT1Uj/hhSpy5krKe4KbX/u
         yrwPMJ7jr+BWglf8udvX14aLLQGD0znEykTzepuE5IRKPaiDjAW0ue5fUw3kBReAd0ho
         HPkA==
X-Forwarded-Encrypted: i=1; AJvYcCW0zaLZzdOp1dUjjzTqgMOt6q2Xp01YNqcjH6gAfFjr/jvDxj0ZYZzD98PmLMdQ/YWmXyOIFX/SNdwRYWli@vger.kernel.org, AJvYcCXZ9wCKosTi8G3G4r0EeeAHI/Af95qKMCmTuW/qOCCCO7va1UHzjEUXHDgH5kGSoSvuUoOrioZftNeo@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXhImTPtixjp5qaVM2oMKbQWgGIMF6vwFo1VZBHdxh7h8A0Ke
	Q8wPm028VzIXaWm4ZlKC8+DPK2VCcdd7w+RZOIwvTr2u3W+QDwSJ
X-Gm-Gg: ASbGncsQrCI0YJpROcu2UXF9P25sV7pR3R11tAvhJhi3qp8PkvyUlvWo0cHRqjDcRFx
	IzcUiB/8awtcEQszLLLt67X+km6x3LnzJFyD43qdyFlUerkmq3Nj99PsvrO5ne9PO24p7BH7XV8
	kYxTWEJ6gyRGBCpd51uFP0mfuDtAl4d0IKRElSDFIgELBH9F8F+T+R6uFrBVgX9wPc7tF+Iq+v8
	na779g/1V3+p9g+ppEtgYB3Lts8vu+X4GCwBrDceLH/BStlAz6lJqii4cahM4rTPJQIVrJeZTUo
	3F4aKCqiPir6BWdJbSf5
X-Google-Smtp-Source: AGHT+IGwtGEt3KqPtzEArH9EO6uoLdPaUjiF2hOKrwwHaDa+GSJgxxkM/g83OEgs0VgyrS2u3iChTw==
X-Received: by 2002:a05:620a:2626:b0:7c3:c500:ca96 with SMTP id af79cd13be357-7c3d9172203mr291491985a.9.1741156807126;
        Tue, 04 Mar 2025 22:40:07 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3d9bcdcc3sm65443785a.60.2025.03.04.22.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 22:40:06 -0800 (PST)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v6 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Date: Wed,  5 Mar 2025 14:39:16 +0800
Message-ID: <20250305063920.803601-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305063920.803601-1-inochiama@gmail.com>
References: <20250305063920.803601-1-inochiama@gmail.com>
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
index 4cc85a36a1ab..b6ff51e1ebce 100644
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


