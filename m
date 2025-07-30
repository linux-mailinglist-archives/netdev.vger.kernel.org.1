Return-Path: <netdev+bounces-210964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F04B15ED3
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA758177719
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76D2BDC32;
	Wed, 30 Jul 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uj7yGlvu"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEB29E117;
	Wed, 30 Jul 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873113; cv=none; b=YDnMbGs1NmN0LEgwOhF+QYKcnZr07/pPNk4QFJ9Ur0l+577xVTP67Vu7As4epGEfurIAnwZ+leuze1ww3NysRl0i3JBACW2ozUNUYnlX52VHvYiM8JjrMHz1M4Y4DN9USWxWyHqsaVA1dvghpN9A3VbMhJr5oJ1KRdCxeWAlxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873113; c=relaxed/simple;
	bh=s1fyy9HWisbnyoHzKXDdSQs+wdl21Vqf4cj5n9a+1JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaHtPNP5VCLkK9G3mu3QL8XV/H5A+bvyxS9gRGlZOABLS3iPieT8JqGdkLFB/qEe7H1QFGrKkCk2w1XQxOkmURHmqZLCH5C9UTXGDqb1K/hCJoxUV43mtoyoFTt9mNBzEKwggrsgPHaPEopuWL58oVJM5dKevGGPJusT3PfwDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uj7yGlvu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873109;
	bh=s1fyy9HWisbnyoHzKXDdSQs+wdl21Vqf4cj5n9a+1JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uj7yGlvuHmJwtxsJjm4GM8RxRWcFDgZrKPj2KPa7cCstHYLPCAZiVgsxp6B5FgKrU
	 7INsTDr48je9y+wp8yPSb/eOHHJtoLERXAaiEO18QU2IMwz5wBp8wM9AQoYa78m5WU
	 f+zxS+nDkW5qopwCWEYeJqp0qoXqlXLbg/xGDJlWyw/vrfJJh0lM1AnDx/JS3Vu5Av
	 IopEzbcAknUgNgfHslU2UxNaDq38FJd7x6kOTvjHCXdsqW19tQCcf7ZD9iyHeIwhoh
	 2Dzd8Dm02+qpaioxC7ufCatLggv8RhSwnxR+RsLD9PrNdnmk+rEU2REFQdvFRteqzU
	 ADvJMVtfPVJXA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CDCD317E1319;
	Wed, 30 Jul 2025 12:58:28 +0200 (CEST)
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
Subject: [PATCH v3 17/27] clk: mediatek: Add MT8196 I2C clock support
Date: Wed, 30 Jul 2025 12:56:43 +0200
Message-Id: <20250730105653.64910-18-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730105653.64910-1-laura.nao@collabora.com>
References: <20250730105653.64910-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the MT8196 I2C clock controller, which provides clock
gate control for I2C.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig                  |   7 ++
 drivers/clk/mediatek/Makefile                 |   1 +
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    | 117 ++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index cd12e7ff3e12..09aeffc9887c 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1068,6 +1068,13 @@ config COMMON_CLK_MT8196
 	help
 	  This driver supports MediaTek MT8196 basic clocks.
 
+config COMMON_CLK_MT8196_IMP_IIC_WRAP
+	tristate "Clock driver for MediaTek MT8196 imp_iic_wrap"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 i2c clocks.
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 21e768f67283..d2d731213af3 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
 				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
new file mode 100644
index 000000000000..98db1476e72c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs imp_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMP(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &imp_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate impc_clks[] = {
+	GATE_IMP(CLK_IMPC_I2C11, "impc_i2c11", "i2c_p", 0),
+	GATE_IMP(CLK_IMPC_I2C12, "impc_i2c12", "i2c_p", 1),
+	GATE_IMP(CLK_IMPC_I2C13, "impc_i2c13", "i2c_p", 2),
+	GATE_IMP(CLK_IMPC_I2C14, "impc_i2c14", "i2c_p", 3),
+};
+
+static const struct mtk_clk_desc impc_mcd = {
+	.clks = impc_clks,
+	.num_clks = ARRAY_SIZE(impc_clks),
+};
+
+static const struct mtk_gate impe_clks[] = {
+	GATE_IMP(CLK_IMPE_I2C5, "impe_i2c5", "i2c_east", 0),
+};
+
+static const struct mtk_clk_desc impe_mcd = {
+	.clks = impe_clks,
+	.num_clks = ARRAY_SIZE(impe_clks),
+};
+
+static const struct mtk_gate_regs impn_hwv_regs = {
+	.set_ofs = 0x0000,
+	.clr_ofs = 0x0004,
+	.sta_ofs = 0x2c00,
+};
+
+#define GATE_HWV_IMPN(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &imp_cg_regs,			\
+		.hwv_regs = &impn_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate impn_clks[] = {
+	GATE_IMP(CLK_IMPN_I2C1, "impn_i2c1", "i2c_north", 0),
+	GATE_IMP(CLK_IMPN_I2C2, "impn_i2c2", "i2c_north", 1),
+	GATE_IMP(CLK_IMPN_I2C4, "impn_i2c4", "i2c_north", 2),
+	GATE_HWV_IMPN(CLK_IMPN_I2C7, "impn_i2c7", "i2c_north", 3),
+	GATE_IMP(CLK_IMPN_I2C8, "impn_i2c8", "i2c_north", 4),
+	GATE_IMP(CLK_IMPN_I2C9, "impn_i2c9", "i2c_north", 5),
+};
+
+static const struct mtk_clk_desc impn_mcd = {
+	.clks = impn_clks,
+	.num_clks = ARRAY_SIZE(impn_clks),
+};
+
+static const struct mtk_gate impw_clks[] = {
+	GATE_IMP(CLK_IMPW_I2C0, "impw_i2c0", "i2c_west", 0),
+	GATE_IMP(CLK_IMPW_I2C3, "impw_i2c3", "i2c_west", 1),
+	GATE_IMP(CLK_IMPW_I2C6, "impw_i2c6", "i2c_west", 2),
+	GATE_IMP(CLK_IMPW_I2C10, "impw_i2c10", "i2c_west", 3),
+};
+
+static const struct mtk_clk_desc impw_mcd = {
+	.clks = impw_clks,
+	.num_clks = ARRAY_SIZE(impw_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8196_imp_iic_wrap[] = {
+	{ .compatible = "mediatek,mt8196-imp-iic-wrap-c", .data = &impc_mcd },
+	{ .compatible = "mediatek,mt8196-imp-iic-wrap-e", .data = &impe_mcd },
+	{ .compatible = "mediatek,mt8196-imp-iic-wrap-n", .data = &impn_mcd },
+	{ .compatible = "mediatek,mt8196-imp-iic-wrap-w", .data = &impw_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_imp_iic_wrap);
+
+static struct platform_driver clk_mt8196_imp_iic_wrap_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-imp_iic_wrap",
+		.of_match_table = of_match_clk_mt8196_imp_iic_wrap,
+	},
+};
+module_platform_driver(clk_mt8196_imp_iic_wrap_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 I2C Wrapper clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


