Return-Path: <netdev+bounces-211727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74AB1B5AA
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877943AC03F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB01286436;
	Tue,  5 Aug 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nYZxr61t"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A572857CF;
	Tue,  5 Aug 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402168; cv=none; b=VeMMzmmZ0cCalAMCKVjsj0jBkEANaJwBbol8AINA75C1XAlpZy8ZbQJXUWkX09EMPJwk37JGzOQZFd1aWdZ4ua3GUWwVgd9PNcBVmsecNU7TW9FrNH6LK8uLwNWr9v7leLy8Y/qWW/DKiCGNL5mnrHH1QH4oNdOnk3H6bPGOVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402168; c=relaxed/simple;
	bh=SiRYXkYq3hRbTpjDkQUrfAcA3n1KuUrPKCkqPWB2JCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6U9Xvcex3TKka+xfi2riSzOuX1ZXtfQzeYbO+Ke+EeCyueSkJKdHdVnsN65hPfmJTQ+fHFYj6TngqAQW9KRaVnGewd+hckXjJdo3hY0CrxEjh/huaCVABCtDzleVJ5a2AtJO64ka1zDVGqGMuNdeToQsgC4klxRYOtEADah8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nYZxr61t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754402164;
	bh=SiRYXkYq3hRbTpjDkQUrfAcA3n1KuUrPKCkqPWB2JCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYZxr61tK2bh5pJ2Ml5xlwslQfj2f1BdoaewnFKDmdQpZkUg/utNwghGl3YO6qq9U
	 0nfXKp8QiyJqI9NPH/65+izAh7EmQLv/ye5sMnVwIjkOZxzBxp1HJGl2fMTfDkMBau
	 WNTKfbeG8Px/lgLnOw1uYpeWVk6qGDmrkE2YBlyyy2Cb6nZ6Wjn9AwYsTgRg/ardBG
	 KqtIejizzZi+RE5kychUmOEH7E62Gz4syYnq//2KrdbrU+1ETHbopIVX++TypXPL88
	 jZdlXxWsr8SkbI/BrbO0zKnIie0KT5vMhTz6pGkZ18+uQW+tl7jruOGJf9HPcxwuh5
	 CUvxRae/eKuRw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1976:d3fe:e682:e398])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CCFAD17E0DB9;
	Tue,  5 Aug 2025 15:56:03 +0200 (CEST)
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
Subject: [PATCH v4 22/27] clk: mediatek: Add MT8196 disp1 clock support
Date: Tue,  5 Aug 2025 15:54:42 +0200
Message-Id: <20250805135447.149231-23-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805135447.149231-1-laura.nao@collabora.com>
References: <20250805135447.149231-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the MT8196 disp1 clock controller, which provides clock
gate control for the display system. It is integrated with the mtk-mmsys
driver, which registers the disp1 clock driver via
platform_device_register_data().

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Makefile           |   2 +-
 drivers/clk/mediatek/clk-mt8196-disp1.c | 170 ++++++++++++++++++++++++
 2 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp1.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index a8c681f9fe64..fe5699411d8b 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -157,7 +157,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
-obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-disp1.c b/drivers/clk/mediatek/clk-mt8196-disp1.c
new file mode 100644
index 000000000000..76176fbe93f8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-disp1.c
@@ -0,0 +1,170 @@
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
+static const struct mtk_gate_regs mm10_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm10_hwv_regs = {
+	.set_ofs = 0x0010,
+	.clr_ofs = 0x0014,
+	.sta_ofs = 0x2c08,
+};
+
+static const struct mtk_gate_regs mm11_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs mm11_hwv_regs = {
+	.set_ofs = 0x0018,
+	.clr_ofs = 0x001c,
+	.sta_ofs = 0x2c0c,
+};
+
+#define GATE_MM10(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mm10_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_HWV_MM10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm10_cg_regs,			\
+		.hwv_regs = &mm10_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_MM11(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mm11_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_HWV_MM11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm11_cg_regs,			\
+		.hwv_regs = &mm11_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mm1_clks[] = {
+	/* MM10 */
+	GATE_HWV_MM10(CLK_MM1_DISPSYS1_CONFIG, "mm1_dispsys1_config", "disp", 0),
+	GATE_HWV_MM10(CLK_MM1_DISPSYS1_S_CONFIG, "mm1_dispsys1_s_config", "disp", 1),
+	GATE_HWV_MM10(CLK_MM1_DISP_MUTEX0, "mm1_disp_mutex0", "disp", 2),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC20, "mm1_disp_dli_async20", "disp", 3),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC21, "mm1_disp_dli_async21", "disp", 4),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC22, "mm1_disp_dli_async22", "disp", 5),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC23, "mm1_disp_dli_async23", "disp", 6),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC24, "mm1_disp_dli_async24", "disp", 7),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC25, "mm1_disp_dli_async25", "disp", 8),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC26, "mm1_disp_dli_async26", "disp", 9),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC27, "mm1_disp_dli_async27", "disp", 10),
+	GATE_HWV_MM10(CLK_MM1_DISP_DLI_ASYNC28, "mm1_disp_dli_async28", "disp", 11),
+	GATE_HWV_MM10(CLK_MM1_DISP_RELAY0, "mm1_disp_relay0", "disp", 12),
+	GATE_HWV_MM10(CLK_MM1_DISP_RELAY1, "mm1_disp_relay1", "disp", 13),
+	GATE_HWV_MM10(CLK_MM1_DISP_RELAY2, "mm1_disp_relay2", "disp", 14),
+	GATE_HWV_MM10(CLK_MM1_DISP_RELAY3, "mm1_disp_relay3", "disp", 15),
+	GATE_HWV_MM10(CLK_MM1_DISP_DP_INTF0, "mm1_DP_CLK", "disp", 16),
+	GATE_HWV_MM10(CLK_MM1_DISP_DP_INTF1, "mm1_disp_dp_intf1", "disp", 17),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSC_WRAP0, "mm1_disp_dsc_wrap0", "disp", 18),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSC_WRAP1, "mm1_disp_dsc_wrap1", "disp", 19),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSC_WRAP2, "mm1_disp_dsc_wrap2", "disp", 20),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSC_WRAP3, "mm1_disp_dsc_wrap3", "disp", 21),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSI0, "mm1_CLK0", "disp", 22),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSI1, "mm1_CLK1", "disp", 23),
+	GATE_HWV_MM10(CLK_MM1_DISP_DSI2, "mm1_CLK2", "disp", 24),
+	GATE_HWV_MM10(CLK_MM1_DISP_DVO0, "mm1_disp_dvo0", "disp", 25),
+	GATE_HWV_MM10(CLK_MM1_DISP_GDMA0, "mm1_disp_gdma0", "disp", 26),
+	GATE_HWV_MM10(CLK_MM1_DISP_MERGE0, "mm1_disp_merge0", "disp", 27),
+	GATE_HWV_MM10(CLK_MM1_DISP_MERGE1, "mm1_disp_merge1", "disp", 28),
+	GATE_HWV_MM10(CLK_MM1_DISP_MERGE2, "mm1_disp_merge2", "disp", 29),
+	GATE_HWV_MM10(CLK_MM1_DISP_ODDMR0, "mm1_disp_oddmr0", "disp", 30),
+	GATE_HWV_MM10(CLK_MM1_DISP_POSTALIGN0, "mm1_disp_postalign0", "disp", 31),
+	/* MM11 */
+	GATE_HWV_MM11(CLK_MM1_DISP_DITHER2, "mm1_disp_dither2", "disp", 0),
+	GATE_HWV_MM11(CLK_MM1_DISP_R2Y0, "mm1_disp_r2y0", "disp", 1),
+	GATE_HWV_MM11(CLK_MM1_DISP_SPLITTER0, "mm1_disp_splitter0", "disp", 2),
+	GATE_HWV_MM11(CLK_MM1_DISP_SPLITTER1, "mm1_disp_splitter1", "disp", 3),
+	GATE_HWV_MM11(CLK_MM1_DISP_SPLITTER2, "mm1_disp_splitter2", "disp", 4),
+	GATE_HWV_MM11(CLK_MM1_DISP_SPLITTER3, "mm1_disp_splitter3", "disp", 5),
+	GATE_HWV_MM11(CLK_MM1_DISP_VDCM0, "mm1_disp_vdcm0", "disp", 6),
+	GATE_HWV_MM11(CLK_MM1_DISP_WDMA1, "mm1_disp_wdma1", "disp", 7),
+	GATE_HWV_MM11(CLK_MM1_DISP_WDMA2, "mm1_disp_wdma2", "disp", 8),
+	GATE_HWV_MM11(CLK_MM1_DISP_WDMA3, "mm1_disp_wdma3", "disp", 9),
+	GATE_HWV_MM11(CLK_MM1_DISP_WDMA4, "mm1_disp_wdma4", "disp", 10),
+	GATE_HWV_MM11(CLK_MM1_MDP_RDMA1, "mm1_mdp_rdma1", "disp", 11),
+	GATE_HWV_MM11(CLK_MM1_SMI_LARB0, "mm1_smi_larb0", "disp", 12),
+	GATE_HWV_MM11(CLK_MM1_MOD1, "mm1_mod1", "clk26m", 13),
+	GATE_HWV_MM11(CLK_MM1_MOD2, "mm1_mod2", "clk26m", 14),
+	GATE_HWV_MM11(CLK_MM1_MOD3, "mm1_mod3", "clk26m", 15),
+	GATE_HWV_MM11(CLK_MM1_MOD4, "mm1_mod4", "dp0", 16),
+	GATE_HWV_MM11(CLK_MM1_MOD5, "mm1_mod5", "dp1", 17),
+	GATE_HWV_MM11(CLK_MM1_MOD6, "mm1_mod6", "dp1", 18),
+	GATE_HWV_MM11(CLK_MM1_CG0, "mm1_cg0", "disp", 20),
+	GATE_HWV_MM11(CLK_MM1_CG1, "mm1_cg1", "disp", 21),
+	GATE_HWV_MM11(CLK_MM1_CG2, "mm1_cg2", "disp", 22),
+	GATE_HWV_MM11(CLK_MM1_CG3, "mm1_cg3", "disp", 23),
+	GATE_HWV_MM11(CLK_MM1_CG4, "mm1_cg4", "disp", 24),
+	GATE_HWV_MM11(CLK_MM1_CG5, "mm1_cg5", "disp", 25),
+	GATE_HWV_MM11(CLK_MM1_CG6, "mm1_cg6", "disp", 26),
+	GATE_HWV_MM11(CLK_MM1_CG7, "mm1_cg7", "disp", 27),
+	GATE_HWV_MM11(CLK_MM1_F26M, "mm1_f26m_ck", "clk26m", 28),
+};
+
+static const struct mtk_clk_desc mm1_mcd = {
+	.clks = mm1_clks,
+	.num_clks = ARRAY_SIZE(mm1_clks),
+};
+
+static const struct platform_device_id clk_mt8196_disp1_id_table[] = {
+	{ .name = "clk-mt8196-disp1", .driver_data = (kernel_ulong_t)&mm1_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt8196_disp1_id_table);
+
+static struct platform_driver clk_mt8196_disp1_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-disp1",
+	},
+	.id_table = clk_mt8196_disp1_id_table,
+};
+module_platform_driver(clk_mt8196_disp1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 disp1 clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


