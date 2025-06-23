Return-Path: <netdev+bounces-200236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30931AE3CD7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8080416236E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83925BEF6;
	Mon, 23 Jun 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZxMjO1p7"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893E25B312;
	Mon, 23 Jun 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674664; cv=none; b=QAk72bT9XsCGXSNTBXrY3f4izdxxo5/YIVrsVAXRX9hyiL8kdjrG/WKJ8zN7sRoLjoVuZfHZUMK8B2WXp1csWwoIyd0O7WPSvUyFsIXFnTBenx4guJACSFtP3d7+ClMJKiiDAiDn+PqutwSctYzdsYnzjhVwHTbwPNLGWlhfrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674664; c=relaxed/simple;
	bh=ljEj/gEF8R1gZsMdeFloinu3W7mnCZQuU41qzZP1HOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJPeAuRZs6Ewm1fUfWE4Ri5RcxQNX1k9MikHCDOiVBNbUfLPU3RRpD4rjJO3x7g+NkzheDk8nGw/5xToLu4xGNDgkaJsRqsf6hAGFzu6WP4W/J2pM9CmBk3CrdbPjIaeDfEe/QZVBjuOcm+m63IdFAcGMOlR0EIMCDlucG+RY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZxMjO1p7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674660;
	bh=ljEj/gEF8R1gZsMdeFloinu3W7mnCZQuU41qzZP1HOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxMjO1p7I3/lRlW/9koxArhcKEiHCkwhwk7/3+c43d4ptBEm5H5iy7KaUzyBPf2/O
	 iyd98Ix+NNGvnTh/B667XbfQ0/RUEs4JaZHMvjpkZjs5u8r2yOTRjyjbpEf+SuU4SM
	 DsOV7i8wr9J6Ni+X5I5zvtscdQG3ultCvQBGDhrYABgXoO3QJTBNi3qTeU7GWqcJp9
	 4pcyCWWS47+u+zfdsczNuh8N3toM2CX3j9qzd2pJ6tbMnvHykb5D+9K7P4aAlNNMpi
	 YCuIx2H3V9QcyP9GktGcxRkNOAzEQV6B7O1T9IQ9GKMXg+4+207jlPJoNLjPdGvb8C
	 RjsjqojghcSOw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B12E17E0D64;
	Mon, 23 Jun 2025 12:30:59 +0200 (CEST)
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
Subject: [PATCH 25/30] clk: mediatek: Add MT8196 ovl0 clock support
Date: Mon, 23 Jun 2025 12:29:35 +0200
Message-Id: <20250623102940.214269-26-laura.nao@collabora.com>
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

Add support for the MT8196 ovl0 clock controller, which provides clock
gate control for the display system. It is integrated with the mtk-mmsys
driver, which registers the ovl0 clock driver via
platform_device_register_data().

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Makefile          |   3 +-
 drivers/clk/mediatek/clk-mt8196-ovl0.c | 154 +++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl0.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 112607da29ab..14a3caac04e4 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -168,7 +168,8 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
-obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o clk-mt8196-vdisp_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o clk-mt8196-vdisp_ao.o \
+					 clk-mt8196-ovl0.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-ovl0.c b/drivers/clk/mediatek/clk-mt8196-ovl0.c
new file mode 100644
index 000000000000..3527a1c0c08b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-ovl0.c
@@ -0,0 +1,154 @@
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
+static const struct mtk_gate_regs ovl0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs ovl0_hwv_regs = {
+	.set_ofs = 0x0060,
+	.clr_ofs = 0x0064,
+	.sta_ofs = 0x2c30,
+};
+
+static const struct mtk_gate_regs ovl1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs ovl1_hwv_regs = {
+	.set_ofs = 0x0068,
+	.clr_ofs = 0x006c,
+	.sta_ofs = 0x2c34,
+};
+
+#define GATE_HWV_OVL0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ovl0_cg_regs,			\
+		.hwv_regs = &ovl0_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_OVL1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ovl1_cg_regs,			\
+		.hwv_regs = &ovl1_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ovl_clks[] = {
+	/* OVL0 */
+	GATE_HWV_OVL0(CLK_OVLSYS_CONFIG, "ovlsys_config", "disp", 0),
+	GATE_HWV_OVL0(CLK_OVL_FAKE_ENG0, "ovl_fake_eng0", "disp", 1),
+	GATE_HWV_OVL0(CLK_OVL_FAKE_ENG1, "ovl_fake_eng1", "disp", 2),
+	GATE_HWV_OVL0(CLK_OVL_MUTEX0, "ovl_mutex0", "disp", 3),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA0, "ovl_exdma0", "disp", 4),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA1, "ovl_exdma1", "disp", 5),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA2, "ovl_exdma2", "disp", 6),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA3, "ovl_exdma3", "disp", 7),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA4, "ovl_exdma4", "disp", 8),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA5, "ovl_exdma5", "disp", 9),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA6, "ovl_exdma6", "disp", 10),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA7, "ovl_exdma7", "disp", 11),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA8, "ovl_exdma8", "disp", 12),
+	GATE_HWV_OVL0(CLK_OVL_EXDMA9, "ovl_exdma9", "disp", 13),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER0, "ovl_blender0", "disp", 14),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER1, "ovl_blender1", "disp", 15),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER2, "ovl_blender2", "disp", 16),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER3, "ovl_blender3", "disp", 17),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER4, "ovl_blender4", "disp", 18),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER5, "ovl_blender5", "disp", 19),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER6, "ovl_blender6", "disp", 20),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER7, "ovl_blender7", "disp", 21),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER8, "ovl_blender8", "disp", 22),
+	GATE_HWV_OVL0(CLK_OVL_BLENDER9, "ovl_blender9", "disp", 23),
+	GATE_HWV_OVL0(CLK_OVL_OUTPROC0, "ovl_outproc0", "disp", 24),
+	GATE_HWV_OVL0(CLK_OVL_OUTPROC1, "ovl_outproc1", "disp", 25),
+	GATE_HWV_OVL0(CLK_OVL_OUTPROC2, "ovl_outproc2", "disp", 26),
+	GATE_HWV_OVL0(CLK_OVL_OUTPROC3, "ovl_outproc3", "disp", 27),
+	GATE_HWV_OVL0(CLK_OVL_OUTPROC4, "ovl_outproc4", "disp", 28),
+	GATE_HWV_OVL0(CLK_OVL_OUTPROC5, "ovl_outproc5", "disp", 29),
+	GATE_HWV_OVL0(CLK_OVL_MDP_RSZ0, "ovl_mdp_rsz0", "disp", 30),
+	GATE_HWV_OVL0(CLK_OVL_MDP_RSZ1, "ovl_mdp_rsz1", "disp", 31),
+	/* OVL1 */
+	GATE_HWV_OVL1(CLK_OVL_DISP_WDMA0, "ovl_disp_wdma0", "disp", 0),
+	GATE_HWV_OVL1(CLK_OVL_DISP_WDMA1, "ovl_disp_wdma1", "disp", 1),
+	GATE_HWV_OVL1(CLK_OVL_UFBC_WDMA0, "ovl_ufbc_wdma0", "disp", 2),
+	GATE_HWV_OVL1(CLK_OVL_MDP_RDMA0, "ovl_mdp_rdma0", "disp", 3),
+	GATE_HWV_OVL1(CLK_OVL_MDP_RDMA1, "ovl_mdp_rdma1", "disp", 4),
+	GATE_HWV_OVL1(CLK_OVL_BWM0, "ovl_bwm0", "disp", 5),
+	GATE_HWV_OVL1(CLK_OVL_DLI0, "ovl_dli0", "disp", 6),
+	GATE_HWV_OVL1(CLK_OVL_DLI1, "ovl_dli1", "disp", 7),
+	GATE_HWV_OVL1(CLK_OVL_DLI2, "ovl_dli2", "disp", 8),
+	GATE_HWV_OVL1(CLK_OVL_DLI3, "ovl_dli3", "disp", 9),
+	GATE_HWV_OVL1(CLK_OVL_DLI4, "ovl_dli4", "disp", 10),
+	GATE_HWV_OVL1(CLK_OVL_DLI5, "ovl_dli5", "disp", 11),
+	GATE_HWV_OVL1(CLK_OVL_DLI6, "ovl_dli6", "disp", 12),
+	GATE_HWV_OVL1(CLK_OVL_DLI7, "ovl_dli7", "disp", 13),
+	GATE_HWV_OVL1(CLK_OVL_DLI8, "ovl_dli8", "disp", 14),
+	GATE_HWV_OVL1(CLK_OVL_DLO0, "ovl_dlo0", "disp", 15),
+	GATE_HWV_OVL1(CLK_OVL_DLO1, "ovl_dlo1", "disp", 16),
+	GATE_HWV_OVL1(CLK_OVL_DLO2, "ovl_dlo2", "disp", 17),
+	GATE_HWV_OVL1(CLK_OVL_DLO3, "ovl_dlo3", "disp", 18),
+	GATE_HWV_OVL1(CLK_OVL_DLO4, "ovl_dlo4", "disp", 19),
+	GATE_HWV_OVL1(CLK_OVL_DLO5, "ovl_dlo5", "disp", 20),
+	GATE_HWV_OVL1(CLK_OVL_DLO6, "ovl_dlo6", "disp", 21),
+	GATE_HWV_OVL1(CLK_OVL_DLO7, "ovl_dlo7", "disp", 22),
+	GATE_HWV_OVL1(CLK_OVL_DLO8, "ovl_dlo8", "disp", 23),
+	GATE_HWV_OVL1(CLK_OVL_DLO9, "ovl_dlo9", "disp", 24),
+	GATE_HWV_OVL1(CLK_OVL_DLO10, "ovl_dlo10", "disp", 25),
+	GATE_HWV_OVL1(CLK_OVL_DLO11, "ovl_dlo11", "disp", 26),
+	GATE_HWV_OVL1(CLK_OVL_DLO12, "ovl_dlo12", "disp", 27),
+	GATE_HWV_OVL1(CLK_OVLSYS_RELAY0, "ovlsys_relay0", "disp", 28),
+	GATE_HWV_OVL1(CLK_OVL_INLINEROT0, "ovl_inlinerot0", "disp", 29),
+	GATE_HWV_OVL1(CLK_OVL_SMI, "ovl_smi", "disp", 30),
+};
+
+static const struct mtk_clk_desc ovl_mcd = {
+	.clks = ovl_clks,
+	.num_clks = ARRAY_SIZE(ovl_clks),
+};
+
+static const struct platform_device_id clk_mt8196_ovl0_id_table[] = {
+	{ .name = "clk-mt8196-ovl0", .driver_data = (kernel_ulong_t)&ovl_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt8196_ovl0_id_table);
+
+static struct platform_driver clk_mt8196_ovl0_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-ovl0",
+	},
+	.id_table = clk_mt8196_ovl0_id_table,
+};
+module_platform_driver(clk_mt8196_ovl0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 ovl0 clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


