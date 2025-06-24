Return-Path: <netdev+bounces-200718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DEAE6929
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F55B7A6D85
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D1E2ECD30;
	Tue, 24 Jun 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wcv06ZNG"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBF2EA73E;
	Tue, 24 Jun 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775642; cv=none; b=KoYMPAh/yyv7CKPditJV4kldLFKPaV45Ot6pr9G7fshnqfL1eodKshaqQe09/7/JZ0fnOLSaBBSbmLTBYiwI6l5W9ENm+KZPjyFSFz6kYF4T1V7yOmYWIr4N5a0v59uk2lAFOyCbizvKR/TP8cI4RuSI5/R9BOY3XKs+ql+Eg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775642; c=relaxed/simple;
	bh=XxteZlriZXwOV7rELxqx+IQIELgRA44AU0tBWBFlVRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oqib+HY7J1tZ3PYY+KYfaaU0HSvffPcvigM/c1u8oNQfXTgjBsBXYR54wNTNQtWSDibEHhxq74Gf7226T6dCOs6vWfT50TMmcsZKdA4m9P6cqKF0ey6C6As2LX4i82vLd3JNDXUaa4UO5ybuiRreqn6DC9h4GFqVGIvwhbwpt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wcv06ZNG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775637;
	bh=XxteZlriZXwOV7rELxqx+IQIELgRA44AU0tBWBFlVRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wcv06ZNG4xs+TxKGo8m/lt1KeUkk04eywbDkx9mcRpAngrIyhHdvPsqfPd9ZHsbj7
	 fywdSIMMchuLGnCMwZKD00RXXvFxRVRHikDA9Aw7VaRISdj7c74UKqKguPwOdUOuvf
	 HMXAaJuf/YhF29EjiD0eT3g/Kwn5x0CmkMjcW6fTg5FtIHf2cD6muRybcYMoEF2O5N
	 CLUQEfTF56DWwBsWkjWc0i0FhQZA+Z4nXkja6PxavumpZyknYu9YtN0SmJpOHAyS4F
	 a3UQII4ZMS4By9RrQx8bW8WvENe60Rf5aSHuw9abrARF+nOX0lVcDZ56InZ0G9szDg
	 B/GVFt30advXA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA1E217E088B;
	Tue, 24 Jun 2025 16:33:55 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2 20/29] clk: mediatek: Add MT8196 mcu clock support
Date: Tue, 24 Jun 2025 16:32:11 +0200
Message-Id: <20250624143220.244549-21-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624143220.244549-1-laura.nao@collabora.com>
References: <20250624143220.244549-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MT8196 mcu clock controller, which provides PLL
control for MCU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |   7 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8196-mcu.c | 166 ++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mcu.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 6c556bec4531..ed1073c5b432 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1082,6 +1082,13 @@ config COMMON_CLK_MT8196_IMP_IIC_WRAP
 	help
 	  This driver supports MediaTek MT8196 i2c clocks.
 
+config COMMON_CLK_MT8196_MCUSYS
+	tristate "Clock driver for MediaTek MT8196 mcusys"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 mcusys clocks.
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 120cf20acdc1..7b284ccc1b48 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -165,6 +165,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
 				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-mcu.c b/drivers/clk/mediatek/clk-mt8196-mcu.c
new file mode 100644
index 000000000000..a08d1597cc88
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-mcu.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
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
+#define ARMPLL_LL_CON0	0x008
+#define ARMPLL_LL_CON1	0x00c
+#define ARMPLL_LL_CON2	0x010
+#define ARMPLL_LL_CON3	0x014
+#define ARMPLL_BL_CON0	0x008
+#define ARMPLL_BL_CON1	0x00c
+#define ARMPLL_BL_CON2	0x010
+#define ARMPLL_BL_CON3	0x014
+#define ARMPLL_B_CON0	0x008
+#define ARMPLL_B_CON1	0x00c
+#define ARMPLL_B_CON2	0x010
+#define ARMPLL_B_CON3	0x014
+#define CCIPLL_CON0	0x008
+#define CCIPLL_CON1	0x00c
+#define CCIPLL_CON2	0x010
+#define CCIPLL_CON3	0x014
+#define PTPPLL_CON0	0x008
+#define PTPPLL_CON1	0x00c
+#define PTPPLL_CON2	0x010
+#define PTPPLL_CON3	0x014
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
+static const struct mtk_pll_data cpu_bl_plls[] = {
+	PLL(CLK_CPBL_ARMPLL_BL, "armpll-bl", ARMPLL_BL_CON0, ARMPLL_BL_CON0, 0,
+	    0, PLL_AO, BIT(0), ARMPLL_BL_CON1, 24, 0, 0, 0, ARMPLL_BL_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data cpu_b_plls[] = {
+	PLL(CLK_CPB_ARMPLL_B, "armpll-b", ARMPLL_B_CON0, ARMPLL_B_CON0, 0, 0,
+	    PLL_AO, BIT(0), ARMPLL_B_CON1, 24, 0, 0, 0, ARMPLL_B_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data cpu_ll_plls[] = {
+	PLL(CLK_CPLL_ARMPLL_LL, "armpll-ll", ARMPLL_LL_CON0, ARMPLL_LL_CON0, 0,
+	    0, PLL_AO, BIT(0), ARMPLL_LL_CON1, 24, 0, 0, 0, ARMPLL_LL_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data cci_plls[] = {
+	PLL(CLK_CCIPLL, "ccipll", CCIPLL_CON0, CCIPLL_CON0, 0, 0, PLL_AO,
+	    BIT(0), CCIPLL_CON1, 24, 0, 0, 0, CCIPLL_CON1, 0, 22),
+};
+
+static const struct mtk_pll_data ptp_plls[] = {
+	PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,
+	    BIT(0), PTPPLL_CON1, 24, 0, 0, 0, PTPPLL_CON1, 0, 22),
+};
+
+static const struct of_device_id of_match_clk_mt8196_mcu[] = {
+	{ .compatible = "mediatek,mt8196-armpll-bl-pll-ctrl",
+	  .data = &cpu_bl_plls },
+	{ .compatible = "mediatek,mt8196-armpll-b-pll-ctrl",
+	  .data = &cpu_b_plls },
+	{ .compatible = "mediatek,mt8196-armpll-ll-pll-ctrl",
+	  .data = &cpu_ll_plls },
+	{ .compatible = "mediatek,mt8196-ccipll-pll-ctrl", .data = &cci_plls },
+	{ .compatible = "mediatek,mt8196-ptppll-pll-ctrl", .data = &ptp_plls },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mcu);
+
+static int clk_mt8196_mcu_probe(struct platform_device *pdev)
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
+static void clk_mt8196_mcu_remove(struct platform_device *pdev)
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
+static struct platform_driver clk_mt8196_mcu_drv = {
+	.probe = clk_mt8196_mcu_probe,
+	.remove = clk_mt8196_mcu_remove,
+	.driver = {
+		.name = "clk-mt8196-mcu",
+		.of_match_table = of_match_clk_mt8196_mcu,
+	},
+};
+module_platform_driver(clk_mt8196_mcu_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 mcusys clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


