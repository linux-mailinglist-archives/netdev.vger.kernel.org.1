Return-Path: <netdev+bounces-211721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACA4B1B598
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90D0623A2E
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FF283C83;
	Tue,  5 Aug 2025 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zs2HWWkE"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C128151E;
	Tue,  5 Aug 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402161; cv=none; b=WoR69KCtO/4zGzYpbiDUnZBOq4hFv4/s7EVsOaniEGMd+jpLpxj7E6JYlzV/EA/w2CAtmA4zTZeOvh//4cDnQLKHmRHUrlqMSsqyJjKg8Ccb5aBxZMjR/nuYtscn8zzgee1lDtG4gB/e84SmfZZTJ4qy0O0kApMtnWAuHbMGzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402161; c=relaxed/simple;
	bh=UyTXbcK3+f6QC5IDq8b0OAZZd9gfcVfzQcn2y5+mZeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNHOh7AOzVuYl1mJIVX1bwUW9sTshMqdGO8yNTSZWRWGfHd0Tj0rLrnf1osM94pbtAVP5L7Q/mBxoxlguUKN+oDq0T8/jK8hGEWHu+5/FHZSnePzSB28Gu6rpwQP82lxMp/LNF3aUrXnZnujoTzbmrYbAAifZeOWcK2GCUNN3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zs2HWWkE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754402157;
	bh=UyTXbcK3+f6QC5IDq8b0OAZZd9gfcVfzQcn2y5+mZeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zs2HWWkEICcq6bRKjBKMyMrzotQHQusMy/GnR6xyobL9dVV/l2TtMF1R7id9KtxZe
	 exPrMUZo0S4iEme0IyHYg05GCyzxJHfMJxILkVor5cyVeJrSUb/V6h/HC4fSyBs9nl
	 lCsFQmudC6G8QsWS9hs8CYpbH7YncKEsGq1QD1YzQpJ5FuVuyfCN3yhpR68nD4q5rE
	 SRJmO4Beq/iHQImoMauHN7HL8xHM1v8d8ZMLT+ATPFPLMq6nUYPcJdA0YROhnPx+Vw
	 FpjU2shThuwht2rcm7xruOENW2TrOaF3k4fAovXn7YoN7j55g3MGTzNQXsAGGELQGN
	 DhFM52x8nY15w==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1976:d3fe:e682:e398])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 56A3317E04DA;
	Tue,  5 Aug 2025 15:55:56 +0200 (CEST)
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
Subject: [PATCH v4 16/27] clk: mediatek: Add MT8196 pextpsys clock support
Date: Tue,  5 Aug 2025 15:54:36 +0200
Message-Id: <20250805135447.149231-17-laura.nao@collabora.com>
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

Add support for the MT8196 pextpsys clock controller, which provides
clock gate control for PCIe.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig            |   7 ++
 drivers/clk/mediatek/Makefile           |   1 +
 drivers/clk/mediatek/clk-mt8196-pextp.c | 131 ++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-pextp.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d99c39a7f10e..c977719046a4 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1010,6 +1010,13 @@ config COMMON_CLK_MT8196
 	help
 	  This driver supports MediaTek MT8196 basic clocks.
 
+config COMMON_CLK_MT8196_PEXTPSYS
+	tristate "Clock driver for MediaTek MT8196 pextpsys"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 pextpsys clocks.
+
 config COMMON_CLK_MT8196_UFSSYS
 	tristate "Clock driver for MediaTek MT8196 ufssys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 1a497de00846..88f7d8a229c2 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
 				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
diff --git a/drivers/clk/mediatek/clk-mt8196-pextp.c b/drivers/clk/mediatek/clk-mt8196-pextp.c
new file mode 100644
index 000000000000..9a7623bf2b1c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-pextp.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <dt-bindings/reset/mediatek,mt8196-resets.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "reset.h"
+
+#define MT8196_PEXTP_RST0_SET_OFFSET	0x8
+
+static const struct mtk_gate_regs pext_cg_regs = {
+	.set_ofs = 0x18,
+	.clr_ofs = 0x1c,
+	.sta_ofs = 0x14,
+};
+
+#define GATE_PEXT(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &pext_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+static const struct mtk_gate pext_clks[] = {
+	GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_TL, "pext_pm0_tl", "tl", 0),
+	GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_REF, "pext_pm0_ref", "clk26m", 1),
+	GATE_PEXT(CLK_PEXT_PEXTP_PHY_P0_MCU_BUS, "pext_pp0_mcu_bus", "clk26m", 6),
+	GATE_PEXT(CLK_PEXT_PEXTP_PHY_P0_PEXTP_REF, "pext_pp0_pextp_ref", "clk26m", 7),
+	GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_AXI_250, "pext_pm0_axi_250", "ufs_pexpt0_mem_sub", 12),
+	GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_AHB_APB, "pext_pm0_ahb_apb", "ufs_pextp0_axi", 13),
+	GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_PL_P, "pext_pm0_pl_p", "clk26m", 14),
+	GATE_PEXT(CLK_PEXT_PEXTP_VLP_AO_P0_LP, "pext_pextp_vlp_ao_p0_lp", "clk26m", 19),
+};
+
+static u16 pext_rst_ofs[] = { MT8196_PEXTP_RST0_SET_OFFSET };
+
+static u16 pext_rst_idx_map[] = {
+	[MT8196_PEXTP0_RST0_PCIE0_MAC] = 0,
+	[MT8196_PEXTP0_RST0_PCIE0_PHY] = 1,
+};
+
+static const struct mtk_clk_rst_desc pext_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = pext_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pext_rst_ofs),
+	.rst_idx_map = pext_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(pext_rst_idx_map),
+};
+
+static const struct mtk_clk_desc pext_mcd = {
+	.clks = pext_clks,
+	.num_clks = ARRAY_SIZE(pext_clks),
+	.rst_desc = &pext_rst_desc,
+};
+
+static const struct mtk_gate pext1_clks[] = {
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_TL, "pext1_pm1_tl", "tl_p1", 0),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_REF, "pext1_pm1_ref", "clk26m", 1),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_TL, "pext1_pm2_tl", "tl_p2", 2),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_REF, "pext1_pm2_ref", "clk26m", 3),
+	GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P1_MCU_BUS, "pext1_pp1_mcu_bus", "clk26m", 8),
+	GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P1_PEXTP_REF, "pext1_pp1_pextp_ref", "clk26m", 9),
+	GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P2_MCU_BUS, "pext1_pp2_mcu_bus", "clk26m", 10),
+	GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P2_PEXTP_REF, "pext1_pp2_pextp_ref", "clk26m", 11),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_AXI_250, "pext1_pm1_axi_250",
+		   "pextp1_usb_axi", 16),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_AHB_APB, "pext1_pm1_ahb_apb",
+		   "pextp1_usb_mem_sub", 17),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_PL_P, "pext1_pm1_pl_p", "clk26m", 18),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_AXI_250, "pext1_pm2_axi_250",
+		   "pextp1_usb_axi", 19),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_AHB_APB, "pext1_pm2_ahb_apb",
+		   "pextp1_usb_mem_sub", 20),
+	GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_PL_P, "pext1_pm2_pl_p", "clk26m", 21),
+	GATE_PEXT(CLK_PEXT1_PEXTP_VLP_AO_P1_LP, "pext1_pextp_vlp_ao_p1_lp", "clk26m", 26),
+	GATE_PEXT(CLK_PEXT1_PEXTP_VLP_AO_P2_LP, "pext1_pextp_vlp_ao_p2_lp", "clk26m", 27),
+};
+
+static u16 pext1_rst_idx_map[] = {
+	[MT8196_PEXTP1_RST0_PCIE1_MAC] = 0,
+	[MT8196_PEXTP1_RST0_PCIE1_PHY] = 1,
+	[MT8196_PEXTP1_RST0_PCIE2_MAC] = 8,
+	[MT8196_PEXTP1_RST0_PCIE2_PHY] = 9,
+};
+
+static const struct mtk_clk_rst_desc pext1_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = pext_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pext_rst_ofs),
+	.rst_idx_map = pext1_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(pext1_rst_idx_map),
+};
+
+static const struct mtk_clk_desc pext1_mcd = {
+	.clks = pext1_clks,
+	.num_clks = ARRAY_SIZE(pext1_clks),
+	.rst_desc = &pext1_rst_desc,
+};
+
+static const struct of_device_id of_match_clk_mt8196_pextp[] = {
+	{ .compatible = "mediatek,mt8196-pextp0cfg-ao", .data = &pext_mcd },
+	{ .compatible = "mediatek,mt8196-pextp1cfg-ao", .data = &pext1_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_pextp);
+
+static struct platform_driver clk_mt8196_pextp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-pextp",
+		.of_match_table = of_match_clk_mt8196_pextp,
+	},
+};
+
+module_platform_driver(clk_mt8196_pextp_drv);
+MODULE_DESCRIPTION("MediaTek MT8196 PCIe transmit phy clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


