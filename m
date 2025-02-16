Return-Path: <netdev+bounces-166776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A708A37435
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 13:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C01216DF6E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4F198E75;
	Sun, 16 Feb 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiR6rXEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE61922DC;
	Sun, 16 Feb 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709637; cv=none; b=Vvq5M82bZrEPihE4RRgRRYakx6qQKKE6euNfxrL7rMVZ4LrgrDMQMmw3TNIX7spkgA8Z33DHLXRqLT7+rdhUPQpas6uSEILBerD2LK5MxraLg7R10mv48EJd2Pv0yzUXLx0bysO4WZd8T/fSqohYbmEeD0CotVgK4RDNP7OI54I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709637; c=relaxed/simple;
	bh=kkpRmg7dfrqyyZBDXszSTNFWh85+p3znHc57Ikm1oiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgKnOor5f1XQ9x8vKdizJCh2mAF+UJXrbQ+Ig/nlIOyhUmBtv/fvORd3ovaz4i5ZQXneqb0lAmd/buy9sJgcZLpdQXamPbun5BxRbLlHqfdC8LLZnbOeB2lNu9bAi7irM1PQYwcQA5jB2HuhJ4vR1QbHIMC2CibrnxI7zhpesJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiR6rXEP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e66a7e2754so13479676d6.3;
        Sun, 16 Feb 2025 04:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739709634; x=1740314434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KFRnQlxBlj8MitIqq9TpK3sWiM8HCVYDpiQS/J2Je0=;
        b=UiR6rXEPI7bJFryhUjQPUybhAMszu5jlmbTxewG/mL+sJTDPVumAd9LozLkIa/uBPz
         uj7btlXIKkuArXG5AkS8dUfGKPVMxYG8uFd4+QFg9pPvfOb1gha0R283Hgv6C9cCYOEF
         09H4rzUSkclAPCrEI51Ppg/y8TnpFlFEGyXq2m9ZcPz40g+8VnIJB2bit7r24ZHvW5BN
         RrmdX0GxLiY9yBcEmk3BsISQDC3PHseGDVQvKXapCD3tr5uaRZY1fO/IyLxc2T81NH1+
         tjcJwriQJDzeeFxKk2WAj2HY2We9rdA+AyYldRJ8ZSXnDxz4X311tXlteisdmABORsl+
         dnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709635; x=1740314435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KFRnQlxBlj8MitIqq9TpK3sWiM8HCVYDpiQS/J2Je0=;
        b=pyDznvFzLfjyJtS18eudddsv7lyoazEIu9rdBeNhHkSZ2kTtIujIWMcP32nDppT62/
         p7Rocek/gKc/8xYTX+tDAzO1piSMrNr5qKCAwycNo590tuD8wQa4Jv6IDLBg9i7uZ/Kz
         wilW8mClH3yJGlXX9VJziVQM6IEdyG8SSxoRTC8R4ENbvwQ67qsT2WANu/kZeEWamSc1
         aT3V6GM6FYz8kdgFp87BogeVCrYHMiLniaBAuY1cjmct04Ph1vVg0g2z8j+jYrwxaYjZ
         P5trM+2x12cymlEEDpBmBt1NolANOOgTeqrPLvlJPYfQXeCJdEydDGbZ+kMy/TIz8MBa
         jsPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmGqseaxo8NywbysScN+tXRO1z8AxZZv1vJbJfQvD+M8PG8YskjRYHZdBTzPTrFOWcMyBkeoUEwUzDnKr1@vger.kernel.org, AJvYcCVRcGP87Al/G5yp+ZCtavpsbqa47OgzJIhxahPcS6BBYq7MomHPfoVSOZkRSjq+x3jOTCxmr7PvK5rE@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzydLBSPFOMkvhrr3kylt+2aGTxMt751agff8YDL75LeAnsds
	DDCGXXyfd+PzFrdunRVomnnUtU5l7fgp7W7XD1ZoPMVwDyOGhXNt
X-Gm-Gg: ASbGncui9n7HXawa63xXR7kvtpMB1Y4q0wKTUX+aP73othpkLm1vPjK6ISZMW/qGJMk
	CBXLWiY0PfuT9TC/9QYfHA0tKlAArEP8KJV1jTVpcKzXdm1oximgDyC5kJ7jIKLMz/oCIq6YLyn
	NH+JVliwhfPvt/5XF/bx4qOy7cBsW9tfp1a6Xo9pJXEPoT3i+1EIs954y87Se3Tkk8YGNDWLKF2
	2v/Bf/XKW9tDM/Yv+D3NjCNX0db91QP8ezfuxJ+hnyrSWvxQGp3FS4PwUbQ0IlBo/8=
X-Google-Smtp-Source: AGHT+IHtPqzqpeM26zZRpTzLLu/33zKztkr8vbt8BLSYA3H4NJ3o65rJ7atKUIP33d/TkeRY7YUrcg==
X-Received: by 2002:a05:6214:dc5:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6e66cd1a6dfmr88111666d6.29.1739709634524;
        Sun, 16 Feb 2025 04:40:34 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d9f3458sm41060086d6.92.2025.02.16.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:40:34 -0800 (PST)
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
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Furong Xu <0x1207@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
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
Subject: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Date: Sun, 16 Feb 2025 20:39:51 +0800
Message-ID: <20250216123953.1252523-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216123953.1252523-1-inochiama@gmail.com>
References: <20250216123953.1252523-1-inochiama@gmail.com>
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
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 107 ++++++++++++++++++
 3 files changed, 119 insertions(+)
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
index 000000000000..93ea280da6bd
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -0,0 +1,107 @@
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
+		dev_err(dwmac->dev, "failed to set tx rate %ld: %pe\n",
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


