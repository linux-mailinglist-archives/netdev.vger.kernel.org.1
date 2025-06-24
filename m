Return-Path: <netdev+bounces-200715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5FAE690E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA337B471A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345E2E764C;
	Tue, 24 Jun 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lrLYwC1B"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF362E62AC;
	Tue, 24 Jun 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775636; cv=none; b=K+k5+HCBbgJg32rtN+aoTgnwdi5JEN6B/Pn1S7RgAXNT76PE6llgSz6VH2sg1OIeF8U03BpDUFibKsebREv88Y9bd0tFS38EiJ+ZhLfl2G7ON12r9ffhZ+m438GgfVX7K1L7E+9jNYvtU7bF6jarIMzOl/4ljQYPp2A3f4LsaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775636; c=relaxed/simple;
	bh=votyLIDaI2OVokn2ZsItATBtAymLH6ZkR3IIUoNFEJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfzdGf3H/IFKHvUn9k71/J7nmntm91u/2VMpefGhPasYYGl9m1GkyCRDcyeIMsLR4/QDwDDBoQX0aJGV6jjG/WDNV1HHK8r4FY7dCfoYaqz55ynXUUiWjd2eNLAyeYJtXY+uNszLtKZMXUq0RxhrRNdSJA9ZD5DAT3xLy9WgDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lrLYwC1B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775631;
	bh=votyLIDaI2OVokn2ZsItATBtAymLH6ZkR3IIUoNFEJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrLYwC1BbGhl1bVQ1OPOhrJp2Mx5/IDUBNFf+cOMhIqHYFZaO2CMx/txxTd00g337
	 +dYjKoSgDh4P8XPJLAOIdGdWMTwU1jRXk9PnOZw2GfrvKmEAGCNevgiwxwNPp9zyog
	 FGYJpYTJ8qRZEgUmUAsHsH19ufzZNfLWsYPByGONWmQCqzFdtML1ovT19hNdFpV0BM
	 OciicYoTMTRWP1yNSPAEDHNkMxCWIdbmaQIVBnff3SlqAWL1Y0lwfZQyR4QuXNOKFl
	 yyvSQFTZwLzJgTZyjztNd142yxwV7DAUh6NHowEo3ejtlkqWYyTWinStht01lHENq9
	 p+/H1JQaVHPVw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D727B17E0EA4;
	Tue, 24 Jun 2025 16:33:50 +0200 (CEST)
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
Subject: [PATCH v2 16/29] clk: mediatek: Add MT8196 ufssys clock support
Date: Tue, 24 Jun 2025 16:32:07 +0200
Message-Id: <20250624143220.244549-17-laura.nao@collabora.com>
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

Add support for the MT8196 ufssys clock controller, which provides clock
gate control for UFS.

Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig             |   7 ++
 drivers/clk/mediatek/Makefile            |   1 +
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c | 109 +++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index c55a7c8bdcc5..848624792a23 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1068,6 +1068,13 @@ config COMMON_CLK_MT8196
 	help
 	  This driver supports MediaTek MT8196 basic clocks.
 
+config COMMON_CLK_MT8196_UFSSYS
+	tristate "Clock driver for MediaTek MT8196 ufssys"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 ufssys clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index fc941b5baf04..ee6a1bb5ce38 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
 				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-ufs_ao.c b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
new file mode 100644
index 000000000000..858706b3ba6f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
@@ -0,0 +1,109 @@
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
+
+#define MT8196_UFSAO_RST0_SET_OFFSET	0x48
+#define MT8196_UFSAO_RST1_SET_OFFSET	0x148
+
+static const struct mtk_gate_regs ufsao0_cg_regs = {
+	.set_ofs = 0x108,
+	.clr_ofs = 0x10c,
+	.sta_ofs = 0x104,
+};
+
+static const struct mtk_gate_regs ufsao1_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSAO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ufsao0_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_UFSAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ufsao1_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate ufsao_clks[] = {
+	/* UFSAO0 */
+	GATE_UFSAO0(CLK_UFSAO_UFSHCI_UFS, "ufsao_ufshci_ufs", "ufs", 0),
+	GATE_UFSAO0(CLK_UFSAO_UFSHCI_AES, "ufsao_ufshci_aes", "aes_ufsfde", 1),
+	/* UFSAO1 */
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_TX_SYM, "ufsao_unipro_tx_sym", "clk26m", 0),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM0, "ufsao_unipro_rx_sym0", "clk26m", 1),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM1, "ufsao_unipro_rx_sym1", "clk26m", 2),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_SYS, "ufsao_unipro_sys", "ufs", 3),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_SAP, "ufsao_unipro_sap", "clk26m", 4),
+	GATE_UFSAO1(CLK_UFSAO_PHY_SAP, "ufsao_phy_sap", "clk26m", 8),
+};
+
+static u16 ufsao_rst_ofs[] = {
+	MT8196_UFSAO_RST0_SET_OFFSET,
+	MT8196_UFSAO_RST1_SET_OFFSET
+};
+
+static u16 ufsao_rst_idx_map[] = {
+	[MT8196_UFSAO_RST0_UFS_MPHY] = 8,
+	[MT8196_UFSAO_RST1_UFS_UNIPRO] = 1 * RST_NR_PER_BANK + 0,
+	[MT8196_UFSAO_RST1_UFS_CRYPTO] = 1 * RST_NR_PER_BANK + 1,
+	[MT8196_UFSAO_RST1_UFSHCI] = 1 * RST_NR_PER_BANK + 2,
+};
+
+static const struct mtk_clk_rst_desc ufsao_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = ufsao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(ufsao_rst_ofs),
+	.rst_idx_map = ufsao_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(ufsao_rst_idx_map),
+};
+
+static const struct mtk_clk_desc ufsao_mcd = {
+	.clks = ufsao_clks,
+	.num_clks = ARRAY_SIZE(ufsao_clks),
+	.rst_desc = &ufsao_rst_desc,
+};
+
+static const struct of_device_id of_match_clk_mt8196_ufs_ao[] = {
+	{ .compatible = "mediatek,mt8196-ufscfg-ao", .data = &ufsao_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_ufs_ao);
+
+static struct platform_driver clk_mt8196_ufs_ao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-ufs-ao",
+		.of_match_table = of_match_clk_mt8196_ufs_ao,
+	},
+};
+
+module_platform_driver(clk_mt8196_ufs_ao_drv);
+MODULE_DESCRIPTION("MediaTek MT8196 ufs_ao clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


