Return-Path: <netdev+bounces-223142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888AB58096
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EE93BB03E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2D36996F;
	Mon, 15 Sep 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eaW61prd"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983013629A0;
	Mon, 15 Sep 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949711; cv=none; b=mZTMj8uT3XAK63fHJTexaC71wKzIjbZrEj8O0qX8YUGsSDb7PgDxxVklqWVJei8Qz/q0DeOVVUvz+5dzl/gUJQK0rWA9gCaONWUUZpijDwxmcEwfSQWWjHVygTYTl8KXoD7wo0Zq/bDKQso65XhiyrX41IKsJqhtV0jx878wm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949711; c=relaxed/simple;
	bh=ZHU/3tmdBD0CvUCFaWQ8xJdkHl6uD0n0E+V1jtNzUbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m70B2KH0U966yKfFm+bag8PLxYc40vWcBbVaW3PIeK5kkwGui+3Ms+EcJqDJvQmUrKEc9rNhoI5LRuopH1glBNqsND1CkvzMfmWIkUf/S2G3NzDkMJkXqepkP1gcFX66DzF588o93ORG/EoQg0pBPL61h8/ZaWmZAtxMeup5+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eaW61prd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949706;
	bh=ZHU/3tmdBD0CvUCFaWQ8xJdkHl6uD0n0E+V1jtNzUbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaW61prd2+L5mhmKlnqGJpdoopHIYGQFUIJ2V4ojinMzU8BhvJFrpfrPdBd7GjMQC
	 qTTYsTLCzUu+y4Cdyr2wXBmYaQiJAuY2BxFqz8/mdD6Bh3G7LwE0Qp+Qe4zmF3Y7ko
	 nnzNfodEIg2V5D9ZtN1XHIyd5VhmS41i0pwmPBnn5WtX/RUuK6oVVF8g+g50sC/8XX
	 c33yjTqY4XtK5rLxICHYW0dZcnLFvvR5Qu9CFKJtqDwNUAWWao08cFyKB2WZmy1VJN
	 yJiASXQYG3FIr2+brns/XpKN0aOuR9qQIAyMO3fC4Hm9gIew4CVchYXQKx3lGe2S7Y
	 JMvXoTeqEwPZw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4DAF17E1340;
	Mon, 15 Sep 2025 17:21:45 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v6 20/27] clk: mediatek: Add MT8196 mfg clock support
Date: Mon, 15 Sep 2025 17:19:40 +0200
Message-Id: <20250915151947.277983-21-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915151947.277983-1-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the MT8196 mfg clock controller, which provides PLL
control for the GPU.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |   7 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8196-mfg.c | 150 ++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mfg.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 68ac08cf8e82..1990721ec418 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1031,6 +1031,13 @@ config COMMON_CLK_MT8196_MDPSYS
 	help
 	  This driver supports MediaTek MT8196 mdpsys clocks.
 
+config COMMON_CLK_MT8196_MFGCFG
+	tristate "Clock driver for MediaTek MT8196 mfgcfg"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 mfgcfg clocks.
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d2d8bc43e45b..0040a3968858 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
new file mode 100644
index 000000000000..ae1eb9de79ae
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#define MFGPLL_CON0	0x008
+#define MFGPLL_CON1	0x00c
+#define MFGPLL_CON2	0x010
+#define MFGPLL_CON3	0x014
+#define MFGPLL_SC0_CON0	0x008
+#define MFGPLL_SC0_CON1	0x00c
+#define MFGPLL_SC0_CON2	0x010
+#define MFGPLL_SC0_CON3	0x014
+#define MFGPLL_SC1_CON0	0x008
+#define MFGPLL_SC1_CON1	0x00c
+#define MFGPLL_SC1_CON2	0x010
+#define MFGPLL_SC1_CON3	0x014
+
+#define MT8196_PLL_FMAX		(3800UL * MHZ)
+#define MT8196_PLL_FMIN		(1500UL * MHZ)
+#define MT8196_INTEGER_BITS	8
+
+#define PLL(_id, _name, _reg, _en_reg, _en_mask, _pll_en_bit,	\
+	    _flags, _rst_bar_mask,				\
+	    _pd_reg, _pd_shift, _tuner_reg,			\
+	    _tuner_en_reg, _tuner_en_bit,			\
+	    _pcw_reg, _pcw_shift, _pcwbits) {			\
+		.id = _id,					\
+		.name = _name,					\
+		.reg = _reg,					\
+		.en_reg = _en_reg,				\
+		.en_mask = _en_mask,				\
+		.pll_en_bit = _pll_en_bit,			\
+		.flags = _flags,				\
+		.rst_bar_mask = _rst_bar_mask,			\
+		.fmax = MT8196_PLL_FMAX,			\
+		.fmin = MT8196_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8196_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data mfg_ao_plls[] = {
+	PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0, MFGPLL_CON0, 0, 0, 0,
+	    BIT(0), MFGPLL_CON1, 24, 0, 0, 0,
+	    MFGPLL_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data mfgsc0_ao_plls[] = {
+	PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
+	    MFGPLL_SC0_CON0, 0, 0, 0, BIT(0), MFGPLL_SC0_CON1, 24, 0, 0, 0,
+	    MFGPLL_SC0_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data mfgsc1_ao_plls[] = {
+	PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
+	    MFGPLL_SC1_CON0, 0, 0, 0, BIT(0), MFGPLL_SC1_CON1, 24, 0, 0, 0,
+	    MFGPLL_SC1_CON1, 0, 22),
+};
+
+static const struct of_device_id of_match_clk_mt8196_mfg[] = {
+	{ .compatible = "mediatek,mt8196-mfgpll-pll-ctrl",
+	  .data = &mfg_ao_plls },
+	{ .compatible = "mediatek,mt8196-mfgpll-sc0-pll-ctrl",
+	  .data = &mfgsc0_ao_plls },
+	{ .compatible = "mediatek,mt8196-mfgpll-sc1-pll-ctrl",
+	  .data = &mfgsc1_ao_plls },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mfg);
+
+static int clk_mt8196_mfg_probe(struct platform_device *pdev)
+{
+	const struct mtk_pll_data *plls;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	const int num_plls = 1;
+	int r;
+
+	plls = of_device_get_match_data(&pdev->dev);
+	if (!plls)
+		return -EINVAL;
+
+	clk_data = mtk_alloc_clk_data(num_plls);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, plls, num_plls, clk_data);
+	if (r)
+		goto free_clk_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return r;
+
+unregister_plls:
+	mtk_clk_unregister_plls(plls, num_plls, clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+
+	return r;
+}
+
+static void clk_mt8196_mfg_remove(struct platform_device *pdev)
+{
+	const struct mtk_pll_data *plls = of_device_get_match_data(&pdev->dev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(plls, 1, clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static struct platform_driver clk_mt8196_mfg_drv = {
+	.probe = clk_mt8196_mfg_probe,
+	.remove = clk_mt8196_mfg_remove,
+	.driver = {
+		.name = "clk-mt8196-mfg",
+		.of_match_table = of_match_clk_mt8196_mfg,
+	},
+};
+module_platform_driver(clk_mt8196_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 GPU mfg clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


