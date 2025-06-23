Return-Path: <netdev+bounces-200229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85088AE3CB4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841D33A748B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82990256C83;
	Mon, 23 Jun 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IQOK1cwd"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBE2550BB;
	Mon, 23 Jun 2025 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674654; cv=none; b=XMsNZJl9pChhDhNOzC6A+Dj0gO104ih8i2LP72OxB/TeGMOhyfribsiSWOqOw5K1WZF443EmmAF+92mpo/OJ6GGna3MpibcPAShaDzGdJF30jJuf20XaMi+QisQ0dep3W9kt62edsoP3rFtZIJrJareWbN2NR06GjUR0bfV6fEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674654; c=relaxed/simple;
	bh=05BOMJ+q1jaIbzW+jpCPylbuGVZf6t+0TIJ3Rxy3/G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNdE3d3lISI7cmo/3/YvndRpAaEo38cyLjFRS9xVpr4evzUXTKuIPVXWIVCfgiU0nkr61jB+xsucsFukfNqLluQXv80L2aKAjWZaTkjj0G3Fbj4+euoJ+BaK8FjyJc0YQ8X/9r8sx/hhrZcwlqP2xTiIVQimA5V7iL4USUjKFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IQOK1cwd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674650;
	bh=05BOMJ+q1jaIbzW+jpCPylbuGVZf6t+0TIJ3Rxy3/G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQOK1cwdaxoPfy895sYzSjAMzLsKDMmVb7RMgHSxd91pF8+rnR7OB9xQChygGwszj
	 k1NeQTrUAeQ/9uJozYbozJfeiWG78lXhpOlioVXpSpmr9Sbp6Kn5ph1pfqmhkbyDhV
	 /IgFyA28tU23G2xPUjwbC4ea/kyCo8G97+LD3T12X/8X9Ho3sZX9LyGbGplwvV/NM5
	 SbVBHsYvB7pD86qMhFbvhIp4Q6OpdEN37hmvQtcRIf2wEgm/y8bVwedmM4FAF5R4zE
	 8C6iI0fYL41B8zUJSVbzwFi/jDqsSjEwmyjGRbGwjxHOYchchQdqIkimivayrhO0G5
	 wnDjQIZJb7Q0A==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC48517E0FDB;
	Mon, 23 Jun 2025 12:30:48 +0200 (CEST)
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
Subject: [PATCH 18/30] clk: mediatek: Add MT8196 I2C clock support
Date: Mon, 23 Jun 2025 12:29:28 +0200
Message-Id: <20250623102940.214269-19-laura.nao@collabora.com>
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

Add support for the MT8196 I2C clock controller, which provides clock
gate control for I2C.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig                  |   7 ++
 drivers/clk/mediatek/Makefile                 |   1 +
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    | 117 ++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d4c97f64b42a..6c556bec4531 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1075,6 +1075,13 @@ config COMMON_CLK_MT8196_ADSP
 	help
 	  This driver supports MediaTek MT8196 adsp clocks
 
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
index 6a34ee2f7855..120cf20acdc1 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
 				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
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


