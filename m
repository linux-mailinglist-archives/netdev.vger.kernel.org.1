Return-Path: <netdev+bounces-200221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22828AE3C93
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EDF1766ED
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E324DCF8;
	Mon, 23 Jun 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qk1BvkY2"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B41A0731;
	Mon, 23 Jun 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674643; cv=none; b=QpEtc04H4uk85TOUndsCf0AkiwyNKn8BjXKcmov+d7cDvXxGzLFtgV1B+8OK1ytDqd4oBwYvUCEAHf1efs6j9rF5IUWe+Ll0Q0I/1HHx0M+/gqhmaJa6YZGDN0kPzZF6Sa2sJ0+CjlRhYiVx2f8ByWn7+dIc4c5le4+nrXWAEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674643; c=relaxed/simple;
	bh=rtTo+s8/cPSOxK34MZq0Qaqga/Ac0a1hyJAlJBj+VtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VE8BR5Hd7uxSnhQWY1DT4OB25guWzvFxoeRqvqxnw8ZPGkBaBSplmTcef8RmPiBHelo8qfLxsqp5V9zqlKW9rPI3fhwr+sxdOfxifAoMkKrKKYeqEhCoRVZo+u0/NyjCYjci//0yjQcB+Bmm9k8WIkL0SmVY3Olj38a35IzEACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qk1BvkY2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674639;
	bh=rtTo+s8/cPSOxK34MZq0Qaqga/Ac0a1hyJAlJBj+VtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qk1BvkY2ydP+Mvtp0s5my3gqdgzZijWQwz97DuoNMINeKTmrQa+O9o+/KWD9+KLK7
	 VT8DWsfxkXvbshPu2Uew2XnF9AmVofZip3/8MQdWBzJjYyYQxnGCMDdKQhEcsOZUcJ
	 UDO0vA70w2mrT9o3om0AKLc8zdp3W+aNoSoXhOC7ByGkvBk1sPMEEdhaN5WSSFeaik
	 tNOPxZtgte0tlESbB0VcBZEVetqre0zfAoDK2Y2ShG/kgNG3EodsEm0mHKQNGVyskP
	 3HyDLUUd0RkBh+F4kAgPVeNOYyG7cCSWZ9XIhtmN5oC9TcOdpObMsp+oUTy+T+KcbJ
	 07ycMVkQqq6Zg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 53BE017E0D64;
	Mon, 23 Jun 2025 12:30:38 +0200 (CEST)
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
Subject: [PATCH 10/30] clk: mediatek: Add MT8196 apmixedsys clock support
Date: Mon, 23 Jun 2025 12:29:20 +0200
Message-Id: <20250623102940.214269-11-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623102940.214269-1-laura.nao@collabora.com>
References: <20250623102940.214269-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MT8196 apmixedsys clock controller, which provides
PLLs generated from SoC 26m.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig                 |   8 +
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c | 203 +++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ff8a87112969..c55a7c8bdcc5 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1060,6 +1060,14 @@ config COMMON_CLK_MT8195_VENCSYS
 	help
 	  This driver supports MediaTek MT8195 vencsys clocks.
 
+config COMMON_CLK_MT8196
+	tristate "Clock driver for MediaTek MT8196"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	help
+	  This driver supports MediaTek MT8196 basic clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 73004e318702..b1773d2bcb3d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -160,6 +160,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS) += clk-mt8195-vdo0.o clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
new file mode 100644
index 000000000000..4bd617d30295
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
@@ -0,0 +1,203 @@
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
+/* APMIXEDSYS PLL control register offsets */
+#define MAINPLL_CON0	0x250
+#define MAINPLL_CON1	0x254
+#define UNIVPLL_CON0	0x264
+#define UNIVPLL_CON1	0x268
+#define MSDCPLL_CON0	0x278
+#define MSDCPLL_CON1	0x27c
+#define ADSPPLL_CON0	0x28c
+#define ADSPPLL_CON1	0x290
+#define EMIPLL_CON0	0x2a0
+#define EMIPLL_CON1	0x2a4
+#define EMIPLL2_CON0	0x2b4
+#define EMIPLL2_CON1	0x2b8
+#define NET1PLL_CON0	0x2c8
+#define NET1PLL_CON1	0x2cc
+#define SGMIIPLL_CON0	0x2dc
+#define SGMIIPLL_CON1	0x2e0
+
+/* APMIXEDSYS_GP2 PLL control register offsets*/
+#define MAINPLL2_CON0	0x250
+#define MAINPLL2_CON1	0x254
+#define UNIVPLL2_CON0	0x264
+#define UNIVPLL2_CON1	0x268
+#define MMPLL2_CON0	0x278
+#define MMPLL2_CON1	0x27c
+#define IMGPLL_CON0	0x28c
+#define IMGPLL_CON1	0x290
+#define TVDPLL1_CON0	0x2a0
+#define TVDPLL1_CON1	0x2a4
+#define TVDPLL2_CON0	0x2b4
+#define TVDPLL2_CON1	0x2b8
+#define TVDPLL3_CON0	0x2c8
+#define TVDPLL3_CON1	0x2cc
+
+#define PLLEN_ALL	0x080
+#define PLLEN_ALL_SET	0x084
+#define PLLEN_ALL_CLR	0x088
+
+#define FENC_STATUS_CON0	0x03c
+
+#define MT8196_PLL_FMAX		(3800UL * MHZ)
+#define MT8196_PLL_FMIN		(1500UL * MHZ)
+#define MT8196_INTEGER_BITS	8
+
+#define PLL_FENC(_id, _name, _reg, _fenc_sta_ofs, _fenc_sta_bit,\
+			_flags, _pd_reg, _pd_shift,		\
+			_pcw_reg, _pcw_shift, _pcwbits,		\
+			_pll_en_bit) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.reg = _reg,					\
+		.fenc_sta_ofs = _fenc_sta_ofs,			\
+		.fenc_sta_bit = _fenc_sta_bit,			\
+		.flags = _flags,				\
+		.fmax = MT8196_PLL_FMAX,			\
+		.fmin = MT8196_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8196_INTEGER_BITS,		\
+		.en_reg = PLLEN_ALL,				\
+		.en_set_reg = PLLEN_ALL_SET,			\
+		.en_clr_reg = PLLEN_ALL_CLR,			\
+		.pll_en_bit = _pll_en_bit,			\
+		.ops = &mtk_pll_fenc_clr_set_ops,		\
+}
+
+struct mtk_pll_desc {
+	const struct mtk_pll_data *clks;
+	size_t num_clks;
+};
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_FENC(CLK_APMIXED_MAINPLL, "mainpll", MAINPLL_CON0, FENC_STATUS_CON0,
+		 7, PLL_AO, MAINPLL_CON1, 24, MAINPLL_CON1, 0, 22, 0),
+	PLL_FENC(CLK_APMIXED_UNIVPLL, "univpll", UNIVPLL_CON0, FENC_STATUS_CON0,
+		 6, 0, UNIVPLL_CON1, 24, UNIVPLL_CON1, 0, 22, 1),
+	PLL_FENC(CLK_APMIXED_MSDCPLL, "msdcpll", MSDCPLL_CON0, FENC_STATUS_CON0,
+		 5, 0, MSDCPLL_CON1, 24, MSDCPLL_CON1, 0, 22, 2),
+	PLL_FENC(CLK_APMIXED_ADSPPLL, "adsppll", ADSPPLL_CON0, FENC_STATUS_CON0,
+		 4, 0, ADSPPLL_CON1, 24, ADSPPLL_CON1, 0, 22, 3),
+	PLL_FENC(CLK_APMIXED_EMIPLL, "emipll", EMIPLL_CON0, FENC_STATUS_CON0, 3,
+		 PLL_AO, EMIPLL_CON1, 24, EMIPLL_CON1, 0, 22, 4),
+	PLL_FENC(CLK_APMIXED_EMIPLL2, "emipll2", EMIPLL2_CON0, FENC_STATUS_CON0,
+		 2, PLL_AO, EMIPLL2_CON1, 24, EMIPLL2_CON1, 0, 22, 5),
+	PLL_FENC(CLK_APMIXED_NET1PLL, "net1pll", NET1PLL_CON0, FENC_STATUS_CON0,
+		 1, 0, NET1PLL_CON1, 24, NET1PLL_CON1, 0, 22, 6),
+	PLL_FENC(CLK_APMIXED_SGMIIPLL, "sgmiipll", SGMIIPLL_CON0, FENC_STATUS_CON0,
+		 0, 0, SGMIIPLL_CON1, 24, SGMIIPLL_CON1, 0, 22, 7),
+};
+
+static const struct mtk_pll_desc apmixed_desc = {
+	.clks = apmixed_plls,
+	.num_clks = ARRAY_SIZE(apmixed_plls),
+};
+
+static const struct mtk_pll_data apmixed2_plls[] = {
+	PLL_FENC(CLK_APMIXED2_MAINPLL2, "mainpll2", MAINPLL2_CON0, FENC_STATUS_CON0,
+		 6, 0, MAINPLL2_CON1, 24, MAINPLL2_CON1, 0, 22, 0),
+	PLL_FENC(CLK_APMIXED2_UNIVPLL2, "univpll2", UNIVPLL2_CON0, FENC_STATUS_CON0,
+		 5, 0, UNIVPLL2_CON1, 24, UNIVPLL2_CON1, 0, 22, 1),
+	PLL_FENC(CLK_APMIXED2_MMPLL2, "mmpll2", MMPLL2_CON0, FENC_STATUS_CON0,
+		 4, 0, MMPLL2_CON1, 24, MMPLL2_CON1, 0, 22, 2),
+	PLL_FENC(CLK_APMIXED2_IMGPLL, "imgpll", IMGPLL_CON0, FENC_STATUS_CON0,
+		 3, 0, IMGPLL_CON1, 24, IMGPLL_CON1, 0, 22, 3),
+	PLL_FENC(CLK_APMIXED2_TVDPLL1, "tvdpll1", TVDPLL1_CON0, FENC_STATUS_CON0,
+		 2, 0, TVDPLL1_CON1, 24, TVDPLL1_CON1, 0, 22, 4),
+	PLL_FENC(CLK_APMIXED2_TVDPLL2, "tvdpll2", TVDPLL2_CON0, FENC_STATUS_CON0,
+		 1, 0, TVDPLL2_CON1, 24, TVDPLL2_CON1, 0, 22, 5),
+	PLL_FENC(CLK_APMIXED2_TVDPLL3, "tvdpll3", TVDPLL3_CON0, FENC_STATUS_CON0,
+		 0, 0, TVDPLL3_CON1, 24, TVDPLL3_CON1, 0, 22, 6),
+};
+
+static const struct mtk_pll_desc apmixed2_desc = {
+	.clks = apmixed2_plls,
+	.num_clks = ARRAY_SIZE(apmixed2_plls),
+};
+
+static int clk_mt8196_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	const struct mtk_pll_desc *mcd;
+	int r;
+
+	mcd = device_get_match_data(&pdev->dev);
+	if (!mcd)
+		return -EINVAL;
+
+	clk_data = mtk_alloc_clk_data(mcd->num_clks);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, mcd->clks, mcd->num_clks, clk_data);
+	if (r)
+		goto free_apmixed_data;
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
+	mtk_clk_unregister_plls(mcd->clks, mcd->num_clks, clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static void clk_mt8196_apmixed_remove(struct platform_device *pdev)
+{
+	const struct mtk_pll_desc *mcd = device_get_match_data(&pdev->dev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(mcd->clks, mcd->num_clks, clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt8196_apmixed[] = {
+	{ .compatible = "mediatek,mt8196-apmixedsys", .data = &apmixed_desc },
+	{ .compatible = "mediatek,mt8196-apmixedsys-gp2",
+	  .data = &apmixed2_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_apmixed);
+
+static struct platform_driver clk_mt8196_apmixed_drv = {
+	.probe = clk_mt8196_apmixed_probe,
+	.remove = clk_mt8196_apmixed_remove,
+	.driver = {
+		.name = "clk-mt8196-apmixed",
+		.of_match_table = of_match_clk_mt8196_apmixed,
+	},
+};
+module_platform_driver(clk_mt8196_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 apmixedsys clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


