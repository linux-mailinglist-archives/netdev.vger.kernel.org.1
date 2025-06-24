Return-Path: <netdev+bounces-200727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62087AE6992
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB866A4F13
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72752F2C4D;
	Tue, 24 Jun 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="njPcV2WS"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773302F19B8;
	Tue, 24 Jun 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775651; cv=none; b=iYuhsWdRLhPX1VoGHL/mDZVDmFxNlMqNQPOW6eWbUGC9X3vjMmgHLbvA+v8r7/oLbrFEqc0WGWwh8MeS6SgdPFLcyMxRW+/oY+8l5E8xFDSbVkDyRF9QW9uAel0ovAfGv07V2zED0KnFueMQtCtjwMTA/hGZtqYPqBpf3G4FtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775651; c=relaxed/simple;
	bh=/96BnuoGCVZ8rZue5kL+ylO9FAj55XWaSZhIgWZo+/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMrSIfS3uD7WFdb5TrvgGdSq3XInu1szLdFUHOYVAacSkvwwnkeTZGThPocBVsSBZTwVWWWXyYDm53kDUyg9Q8lPEA1Dmv8+O6PZH8pvMXthMZQ4Uw/5dB5zN+L5ZnBs8PDnpMV92USTIRye6WgV3+Y7CcjDcFUTEu7UWCCR2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=njPcV2WS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775648;
	bh=/96BnuoGCVZ8rZue5kL+ylO9FAj55XWaSZhIgWZo+/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njPcV2WS5L4I5aZ6/m+94X5xQt0c4i9CEm6GQ1A4XSFCi5mj4AkjYwO+LomEsc2ec
	 1d+M67IgK57/LL+7FN3dfJU/LqSNy1464UO/AoKsiLw6p0lP9bXkjfHEESPfZJysmr
	 Xhwa7t5znydyx/Gbzc2eLhKwuOhTKJKYJSFyw3qo1V4zWC1MpVTphPsPJime7zV7L/
	 qg2d44e/8iuS95h7arvP/LaqPEU8U8vHSgBlvI0F0x0tCS/Ge1pJiUXedkr0bMsYIR
	 V68cp3W2iPqr2u24JVBz3B/JfuVQXBhTsbBSSapUQ0TWnx8f+uhAxgeljU57KVqkRA
	 ut2AbOIkWCVOQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E35C517E0DE3;
	Tue, 24 Jun 2025 16:34:06 +0200 (CEST)
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
Subject: [PATCH v2 28/29] clk: mediatek: Add MT8196 vdecsys clock support
Date: Tue, 24 Jun 2025 16:32:19 +0200
Message-Id: <20250624143220.244549-29-laura.nao@collabora.com>
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

Add support for the MT8196 vdecsys clock controller, which provides
clock gate control for the video decoder.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig           |   7 +
 drivers/clk/mediatek/Makefile          |   1 +
 drivers/clk/mediatek/clk-mt8196-vdec.c | 253 +++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdec.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 6bcefb782b9c..fc20942a547e 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1124,6 +1124,13 @@ config COMMON_CLK_MT8196_UFSSYS
 	help
 	  This driver supports MediaTek MT8196 ufssys clocks.
 
+config COMMON_CLK_MT8196_VDECSYS
+	tristate "Clock driver for MediaTek MT8196 vdecsys"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 vdecsys clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e3fa5cc2163a..5d3b68649a53 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -172,6 +172,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o c
 					 clk-mt8196-ovl0.o clk-mt8196-ovl1.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_VDECSYS) += clk-mt8196-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-vdec.c b/drivers/clk/mediatek/clk-mt8196-vdec.c
new file mode 100644
index 000000000000..9de07a6c0db7
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-vdec.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs vde20_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vde20_hwv_regs = {
+	.set_ofs = 0x0088,
+	.clr_ofs = 0x008c,
+	.sta_ofs = 0x2c44,
+};
+
+static const struct mtk_gate_regs vde21_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vde21_hwv_regs = {
+	.set_ofs = 0x0080,
+	.clr_ofs = 0x0084,
+	.sta_ofs = 0x2c40,
+};
+
+static const struct mtk_gate_regs vde22_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+static const struct mtk_gate_regs vde22_hwv_regs = {
+	.set_ofs = 0x0078,
+	.clr_ofs = 0x007c,
+	.sta_ofs = 0x2c3c,
+};
+
+#define GATE_HWV_VDE20(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde20_cg_regs,			\
+		.hwv_regs = &vde20_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_VDE21(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde21_cg_regs,			\
+		.hwv_regs = &vde21_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_VDE22(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde22_cg_regs,			\
+		.hwv_regs = &vde22_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+	}
+
+static const struct mtk_gate vde2_clks[] = {
+	/* VDE20 */
+	GATE_HWV_VDE20(CLK_VDE2_VDEC_CKEN, "vde2_vdec_cken", "vdec", 0),
+	GATE_HWV_VDE20(CLK_VDE2_VDEC_ACTIVE, "vde2_vdec_active", "vdec", 4),
+	GATE_HWV_VDE20(CLK_VDE2_VDEC_CKEN_ENG, "vde2_vdec_cken_eng", "vdec", 8),
+	/* VDE21 */
+	GATE_HWV_VDE21(CLK_VDE2_LAT_CKEN, "vde2_lat_cken", "vdec", 0),
+	GATE_HWV_VDE21(CLK_VDE2_LAT_ACTIVE, "vde2_lat_active", "vdec", 4),
+	GATE_HWV_VDE21(CLK_VDE2_LAT_CKEN_ENG, "vde2_lat_cken_eng", "vdec", 8),
+	/* VDE22 */
+	GATE_HWV_VDE22(CLK_VDE2_LARB1_CKEN, "vde2_larb1_cken", "vdec", 0),
+};
+
+static const struct mtk_clk_desc vde2_mcd = {
+	.clks = vde2_clks,
+	.num_clks = ARRAY_SIZE(vde2_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct mtk_gate_regs vde10_hwv_regs = {
+	.set_ofs = 0x00a0,
+	.clr_ofs = 0x00a4,
+	.sta_ofs = 0x2c50,
+};
+
+static const struct mtk_gate_regs vde11_cg_regs = {
+	.set_ofs = 0x1e0,
+	.clr_ofs = 0x1e0,
+	.sta_ofs = 0x1e0,
+};
+
+static const struct mtk_gate_regs vde11_hwv_regs = {
+	.set_ofs = 0x00b0,
+	.clr_ofs = 0x00b4,
+	.sta_ofs = 0x2c58,
+};
+
+static const struct mtk_gate_regs vde12_cg_regs = {
+	.set_ofs = 0x1ec,
+	.clr_ofs = 0x1ec,
+	.sta_ofs = 0x1ec,
+};
+
+static const struct mtk_gate_regs vde12_hwv_regs = {
+	.set_ofs = 0x00a8,
+	.clr_ofs = 0x00ac,
+	.sta_ofs = 0x2c54,
+};
+
+static const struct mtk_gate_regs vde13_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vde13_hwv_regs = {
+	.set_ofs = 0x0098,
+	.clr_ofs = 0x009c,
+	.sta_ofs = 0x2c4c,
+};
+
+static const struct mtk_gate_regs vde14_hwv_regs = {
+	.set_ofs = 0x0090,
+	.clr_ofs = 0x0094,
+	.sta_ofs = 0x2c48,
+};
+
+#define GATE_HWV_VDE10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde20_cg_regs,			\
+		.hwv_regs = &vde10_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_VDE11(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &vde11_cg_regs,				\
+		.hwv_regs = &vde11_hwv_regs,			\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE,			\
+	}
+
+#define GATE_HWV_VDE12(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &vde12_cg_regs,				\
+		.hwv_regs = &vde12_hwv_regs,			\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE			\
+	}
+
+#define GATE_HWV_VDE13(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde13_cg_regs,			\
+		.hwv_regs = &vde13_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_VDE14(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde22_cg_regs,			\
+		.hwv_regs = &vde14_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+	}
+
+static const struct mtk_gate vde1_clks[] = {
+	/* VDE10 */
+	GATE_HWV_VDE10(CLK_VDE1_VDEC_CKEN, "vde1_vdec_cken", "vdec", 0),
+	GATE_HWV_VDE10(CLK_VDE1_VDEC_ACTIVE, "vde1_vdec_active", "vdec", 4),
+	GATE_HWV_VDE10(CLK_VDE1_VDEC_CKEN_ENG, "vde1_vdec_cken_eng", "vdec", 8),
+	/* VDE11 */
+	GATE_HWV_VDE11(CLK_VDE1_VDEC_SOC_IPS_EN, "vde1_vdec_soc_ips_en", "vdec", 0),
+	/* VDE12 */
+	GATE_HWV_VDE12(CLK_VDE1_VDEC_SOC_APTV_EN, "vde1_aptv_en", "ck_tck_26m_mx9_ck", 0),
+	GATE_HWV_VDE12(CLK_VDE1_VDEC_SOC_APTV_TOP_EN, "vde1_aptv_topen", "ck_tck_26m_mx9_ck", 1),
+	/* VDE13 */
+	GATE_HWV_VDE13(CLK_VDE1_LAT_CKEN, "vde1_lat_cken", "vdec", 0),
+	GATE_HWV_VDE13(CLK_VDE1_LAT_ACTIVE, "vde1_lat_active", "vdec", 4),
+	GATE_HWV_VDE13(CLK_VDE1_LAT_CKEN_ENG, "vde1_lat_cken_eng", "vdec", 8),
+	/* VDE14 */
+	GATE_HWV_VDE14(CLK_VDE1_LARB1_CKEN, "vde1_larb1_cken", "vdec", 0),
+};
+
+static const struct mtk_clk_desc vde1_mcd = {
+	.clks = vde1_clks,
+	.num_clks = ARRAY_SIZE(vde1_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_vdec[] = {
+	{ .compatible = "mediatek,mt8196-vdecsys", .data = &vde2_mcd },
+	{ .compatible = "mediatek,mt8196-vdecsys-soc", .data = &vde1_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vdec);
+
+static struct platform_driver clk_mt8196_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-vdec",
+		.of_match_table = of_match_clk_mt8196_vdec,
+	},
+};
+module_platform_driver(clk_mt8196_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 Video Decoders clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


