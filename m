Return-Path: <netdev+bounces-223140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB02B580A7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC571885B0A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894A536299E;
	Mon, 15 Sep 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q1UGDHwP"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321E35CEB5;
	Mon, 15 Sep 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949708; cv=none; b=a7+X5j0pNG2pcJbLT4MOGnQzbOQIhfA1xfB6w3zjvpB0d7viptkkWGe+0qTNM7o+ilARlsDSpjrrwoaZkKK6eFVXkpZ1cZicY4Rz+JYMwYzhOumoO6IuJrxG+tU47jAy8ZAS+Lca07GbBPKbPiDTEffIS95bFXRNgYWz9majLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949708; c=relaxed/simple;
	bh=eCbxBzKf9iUFjDYBRLkdqjG13ZIGNuqL9W1Y03OU5/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr5y7FVGPiBmivsQTpRLFDw4hQSqdZFQa9PwP8L8WR0cpFaKVgVSWrRK9XFszPyMiYCrFydwgA2KE6ajjS36/hWky9yUfOhOSOgpVJ7FasWeln3O+sHKjoY8FsDuaflLLE+i9aCZwRvfmmP/oxXo7M7YJULLqMFW3GdxFsX0Ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q1UGDHwP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949704;
	bh=eCbxBzKf9iUFjDYBRLkdqjG13ZIGNuqL9W1Y03OU5/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1UGDHwPItokRrGtaECu45gYPoAKNCgjkDgAiADRG2N9fcSTfWlBbAxW7jpPt0pZQ
	 7YOLftTJ1QhbGWJTkDX9RCi59pvcQDWOs/BSK31SMoz5XLH7oYeaisYurxBDYF6ej5
	 zAKhvZxQDB4woaZEgBghVTBqkW8FpPkQKjHrBFloamTgh1n4MZYJ2/RfKveRpE0pVN
	 rrRBfq3wBhLvJ0TNCh5QpyRcA1YB6bWrE+IToAiEUKdMHInZTilAzfFYX8VTbtyPgK
	 vFZTQUeuGLxr2FoKH+i+3eUC+xdishW57KNsgm/7H55S6REBCtmizcI9IxqwEKPxKn
	 u7Gtpdd/o54HQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B475017E090D;
	Mon, 15 Sep 2025 17:21:43 +0200 (CEST)
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
Subject: [PATCH v6 18/27] clk: mediatek: Add MT8196 mcu clock support
Date: Mon, 15 Sep 2025 17:19:38 +0200
Message-Id: <20250915151947.277983-19-laura.nao@collabora.com>
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

Add support for the MT8196 mcu clock controller, which provides PLL
control for MCU.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |   7 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8196-mcu.c | 167 ++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mcu.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index fe2697b64ef0..8e5cdae80748 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1017,6 +1017,13 @@ config COMMON_CLK_MT8196_IMP_IIC_WRAP
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
index 241e7f5e7316..46358623c3e5 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
 				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-mcu.c b/drivers/clk/mediatek/clk-mt8196-mcu.c
new file mode 100644
index 000000000000..5cbcc411ae73
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-mcu.c
@@ -0,0 +1,167 @@
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


