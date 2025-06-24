Return-Path: <netdev+bounces-200722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B9DAE6977
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6114E0FA8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B162EF647;
	Tue, 24 Jun 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ATYryYk7"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268722ED172;
	Tue, 24 Jun 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775645; cv=none; b=lTvW3pGpJmSQK1JXMjcT4N+HrqyDlqmXXqi8u8sIvGW7BeE+MXFV3yeFXxuC7HOUlIZNPewEq1q/WmCCrtFyk0vShfC2kWgi/4j/2pAaCPmv74Ea3WX77if//QJrOrpfwedgAF685eflBZ05QcQ6tN5QNrB59Sb4X5qvPcKyi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775645; c=relaxed/simple;
	bh=sZV8OLkqOhbSwuBmWrI1H7PvIwdO/OMqtW7yi/SBd5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdO6cesci0aIWFnSW6trKwX7rntG8WXrQURirXPuX2BWwJfmWn2VIfzErJDLz4k2Vywjh5rp0uZt8HKNk1rQ+6cGqcuw+m8hNXtzSfzzu3Nr4ENvaumjNRSXlOGN4Lz4JLqmk0J8JveKSI5wVwQXw3VGW10Ypbwu2ZyAgG5FVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ATYryYk7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775641;
	bh=sZV8OLkqOhbSwuBmWrI1H7PvIwdO/OMqtW7yi/SBd5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATYryYk7Wp+eL2PiF7E8zgEvn8f5bqLURPkiqcZf6veK8x61ZDQawO7OpMBVNpa4W
	 E7vef97BeeEIE45hG/WeeLjLDdvjBM8tCFAZgfLi1UDxhA8GwdM16OokaxyahGeTyS
	 UhqoHwqbQAoBm7BCPEndClWvruUx+SPbnfu4xARmuU/MlTdBsOiSmtSv+YX/3ul5uM
	 DlynE76EOzXuBtsfhhoMEADN/xu7JOWAP3iJq6uZMFDm9dGBTqBvhPMiRoeS7T0ECf
	 sFXyzgyjiLbl3qIYIeW7wA7+uRloxRLerGK/upkiAPzsXPuuKez+o/E+gfygQG0oob
	 PgzhOFs1NI3pQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 94FA217E1090;
	Tue, 24 Jun 2025 16:34:00 +0200 (CEST)
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
Subject: [PATCH v2 23/29] clk: mediatek: Add MT8196 disp0 clock support
Date: Tue, 24 Jun 2025 16:32:14 +0200
Message-Id: <20250624143220.244549-24-laura.nao@collabora.com>
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

Add support for the MT8196 disp0 clock controller, which provides clock
gate control for the display system. It is integrated with the mtk-mmsys
driver, which registers the disp0 clock driver via
platform_device_register_data().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig            |   7 +
 drivers/clk/mediatek/Makefile           |   1 +
 drivers/clk/mediatek/clk-mt8196-disp0.c | 169 ++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp0.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 9735f37f1e09..6bcefb782b9c 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1103,6 +1103,13 @@ config COMMON_CLK_MT8196_MFGCFG
 	help
 	  This driver supports MediaTek MT8196 mfgcfg clocks.
 
+config COMMON_CLK_MT8196_MMSYS
+	tristate "Clock driver for MediaTek MT8196 mmsys"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 mmsys clocks.
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 31436c8e2a80..eacaec3d61ce 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -168,6 +168,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-disp0.c b/drivers/clk/mediatek/clk-mt8196-disp0.c
new file mode 100644
index 000000000000..ed74b6e3103f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-disp0.c
@@ -0,0 +1,169 @@
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
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm0_hwv_regs = {
+	.set_ofs = 0x0020,
+	.clr_ofs = 0x0024,
+	.sta_ofs = 0x2c10,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs mm1_hwv_regs = {
+	.set_ofs = 0x0028,
+	.clr_ofs = 0x002c,
+	.sta_ofs = 0x2c14,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mm0_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_HWV_MM0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm0_cg_regs,			\
+		.hwv_regs = &mm0_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags =  CLK_OPS_PARENT_ENABLE		\
+	}
+
+#define GATE_MM1(_id, _name, _parent, _shift) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mm1_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_HWV_MM1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm1_cg_regs,			\
+		.hwv_regs = &mm1_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_HWV_MM0(CLK_MM_CONFIG, "mm_config", "disp", 0),
+	GATE_HWV_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0", "disp", 1),
+	GATE_HWV_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "disp", 2),
+	GATE_HWV_MM0(CLK_MM_DISP_AAL1, "mm_disp_aal1", "disp", 3),
+	GATE_MM0(CLK_MM_DISP_C3D0, "mm_disp_c3d0", "disp", 4),
+	GATE_MM0(CLK_MM_DISP_C3D1, "mm_disp_c3d1", "disp", 5),
+	GATE_MM0(CLK_MM_DISP_C3D2, "mm_disp_c3d2", "disp", 6),
+	GATE_MM0(CLK_MM_DISP_C3D3, "mm_disp_c3d3", "disp", 7),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "disp", 8),
+	GATE_MM0(CLK_MM_DISP_CCORR1, "mm_disp_ccorr1", "disp", 9),
+	GATE_MM0(CLK_MM_DISP_CCORR2, "mm_disp_ccorr2", "disp", 10),
+	GATE_MM0(CLK_MM_DISP_CCORR3, "mm_disp_ccorr3", "disp", 11),
+	GATE_MM0(CLK_MM_DISP_CHIST0, "mm_disp_chist0", "disp", 12),
+	GATE_MM0(CLK_MM_DISP_CHIST1, "mm_disp_chist1", "disp", 13),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "disp", 14),
+	GATE_MM0(CLK_MM_DISP_COLOR1, "mm_disp_color1", "disp", 15),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "disp", 16),
+	GATE_MM0(CLK_MM_DISP_DITHER1, "mm_disp_dither1", "disp", 17),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC0, "mm_disp_dli_async0", "disp", 18),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC1, "mm_disp_dli_async1", "disp", 19),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC2, "mm_disp_dli_async2", "disp", 20),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC3, "mm_disp_dli_async3", "disp", 21),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC4, "mm_disp_dli_async4", "disp", 22),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC5, "mm_disp_dli_async5", "disp", 23),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC6, "mm_disp_dli_async6", "disp", 24),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC7, "mm_disp_dli_async7", "disp", 25),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC8, "mm_disp_dli_async8", "disp", 26),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC9, "mm_disp_dli_async9", "disp", 27),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC10, "mm_disp_dli_async10", "disp", 28),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC11, "mm_disp_dli_async11", "disp", 29),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC12, "mm_disp_dli_async12", "disp", 30),
+	GATE_HWV_MM0(CLK_MM_DISP_DLI_ASYNC13, "mm_disp_dli_async13", "disp", 31),
+	/* MM1 */
+	GATE_HWV_MM1(CLK_MM_DISP_DLI_ASYNC14, "mm_disp_dli_async14", "disp", 0),
+	GATE_HWV_MM1(CLK_MM_DISP_DLI_ASYNC15, "mm_disp_dli_async15", "disp", 1),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC0, "mm_disp_dlo_async0", "disp", 2),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC1, "mm_disp_dlo_async1", "disp", 3),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC2, "mm_disp_dlo_async2", "disp", 4),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC3, "mm_disp_dlo_async3", "disp", 5),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC4, "mm_disp_dlo_async4", "disp", 6),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC5, "mm_disp_dlo_async5", "disp", 7),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC6, "mm_disp_dlo_async6", "disp", 8),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC7, "mm_disp_dlo_async7", "disp", 9),
+	GATE_HWV_MM1(CLK_MM_DISP_DLO_ASYNC8, "mm_disp_dlo_async8", "disp", 10),
+	GATE_MM1(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "disp", 11),
+	GATE_MM1(CLK_MM_DISP_GAMMA1, "mm_disp_gamma1", "disp", 12),
+	GATE_MM1(CLK_MM_MDP_AAL0, "mm_mdp_aal0", "disp", 13),
+	GATE_MM1(CLK_MM_MDP_AAL1, "mm_mdp_aal1", "disp", 14),
+	GATE_HWV_MM1(CLK_MM_MDP_RDMA0, "mm_mdp_rdma0", "disp", 15),
+	GATE_HWV_MM1(CLK_MM_DISP_POSTMASK0, "mm_disp_postmask0", "disp", 16),
+	GATE_HWV_MM1(CLK_MM_DISP_POSTMASK1, "mm_disp_postmask1", "disp", 17),
+	GATE_HWV_MM1(CLK_MM_MDP_RSZ0, "mm_mdp_rsz0", "disp", 18),
+	GATE_HWV_MM1(CLK_MM_MDP_RSZ1, "mm_mdp_rsz1", "disp", 19),
+	GATE_HWV_MM1(CLK_MM_DISP_SPR0, "mm_disp_spr0", "disp", 20),
+	GATE_MM1(CLK_MM_DISP_TDSHP0, "mm_disp_tdshp0", "disp", 21),
+	GATE_MM1(CLK_MM_DISP_TDSHP1, "mm_disp_tdshp1", "disp", 22),
+	GATE_HWV_MM1(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "disp", 23),
+	GATE_HWV_MM1(CLK_MM_DISP_Y2R0, "mm_disp_y2r0", "disp", 24),
+	GATE_HWV_MM1(CLK_MM_SMI_SUB_COMM0, "mm_ssc", "disp", 25),
+	GATE_HWV_MM1(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0", "disp", 26),
+};
+
+static const struct mtk_clk_desc mm_mcd = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
+
+static const struct platform_device_id clk_mt8196_disp0_id_table[] = {
+	{ .name = "clk-mt8196-disp0", .driver_data = (kernel_ulong_t)&mm_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt8196_disp0_id_table);
+
+static struct platform_driver clk_mt8196_disp0_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-disp0",
+	},
+	.id_table = clk_mt8196_disp0_id_table,
+};
+module_platform_driver(clk_mt8196_disp0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 disp0 clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


