Return-Path: <netdev+bounces-218205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D5B3B757
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613B73A5C7F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8DB31195B;
	Fri, 29 Aug 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mdXnKEtm"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783030F554;
	Fri, 29 Aug 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459277; cv=none; b=ogV4xYgJLrZ8HAfiec0/sjUd5HVScYS1xmgMlJQuyd6FfTD8KTSF/kO/Q0n6vSmkeL0SVA2JwXor4WC5hHBdzByQ2p5BYerSP/fsnMh8eIBW9m/rPDKIZrY7cNDrUoDLw6B7rm8pWtheqtGFgzab1YLP0hP0Avyz0rRnNT7TL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459277; c=relaxed/simple;
	bh=zW3L7POIsmWS1mMf3ekJNMWYt3u/uJ8CEPuhATMwiSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSRiMVgP9Mgq/Zno66U/N+1uXL1D18xTVvjJrUhvG+DbhlVo5JnG6Pc5G/e4d6lUq4NJdu3oqarKK9ElotpBFeeL3w9oFyAGfjCxIA1P0qUViGTKKhCQ4tlwbIfxtFWT4cmC1yVoFkz6tKVzHcNIMrLlfjfbFG+51lnJj1IrdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mdXnKEtm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756459271;
	bh=zW3L7POIsmWS1mMf3ekJNMWYt3u/uJ8CEPuhATMwiSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdXnKEtmSAX964asehcdbi2MsLdaGStFgdF6SEVL1KbhFvp7gLfTaGAZQX6fqSmmb
	 7DKdEBxDKpyrVRYl1+NH7pmsEHsVnx0pdvf/SHG6XXEavwShWSNz4V1t9utbPh7bGY
	 26LuUAMU5L6+OmtSOmD5ykxvhSpqKbfNwAzSbOx/IG2SlQc4TpZvhnFNEZ7TUcf9Km
	 0Jc2cBAb8SV3RMP70+PJMPRzzoLKSOEPiKDEYe1k2OLjn3C/uxY0aB/HaQp6MT/SXY
	 GD6t4XPvGqqVlZFZMK+iA/ESOvmjf1HVJcwEVSSywAvDVR6xIsloIyUV8JeisAoNIe
	 HhbHeYZroiQRw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:f5b1:db54:a11a:c333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 56DD317E12B9;
	Fri, 29 Aug 2025 11:21:10 +0200 (CEST)
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
Subject: [PATCH v5 14/27] clk: mediatek: Add MT8196 peripheral clock support
Date: Fri, 29 Aug 2025 11:19:00 +0200
Message-Id: <20250829091913.131528-15-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829091913.131528-1-laura.nao@collabora.com>
References: <20250829091913.131528-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MT8196 peripheral clock controller, which provides
clock gate control for dma/flashif/msdc/pwm/spi/uart.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Makefile             |   3 +-
 drivers/clk/mediatek/clk-mt8196-peri_ao.c | 142 ++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-peri_ao.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 031e7ac38804..8888ffd3d7ba 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -151,7 +151,8 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
-				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o
+				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
+				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-peri_ao.c b/drivers/clk/mediatek/clk-mt8196-peri_ao.c
new file mode 100644
index 000000000000..f227a86c5d60
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-peri_ao.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs peri_ao0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs peri_ao1_cg_regs = {
+	.set_ofs = 0x2c,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x14,
+};
+
+static const struct mtk_gate_regs peri_ao1_hwv_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x000c,
+	.sta_ofs = 0x2c04,
+};
+
+static const struct mtk_gate_regs peri_ao2_cg_regs = {
+	.set_ofs = 0x34,
+	.clr_ofs = 0x38,
+	.sta_ofs = 0x18,
+};
+
+#define GATE_PERI_AO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &peri_ao0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_PERI_AO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &peri_ao1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_HWV_PERI_AO1(_id, _name, _parent, _shift) {\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &peri_ao1_cg_regs,		\
+		.hwv_regs = &peri_ao1_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+	}
+
+#define GATE_PERI_AO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &peri_ao2_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate peri_ao_clks[] = {
+	/* PERI_AO0 */
+	GATE_PERI_AO0(CLK_PERI_AO_UART0_BCLK, "peri_ao_uart0_bclk", "uart", 0),
+	GATE_PERI_AO0(CLK_PERI_AO_UART1_BCLK, "peri_ao_uart1_bclk", "uart", 1),
+	GATE_PERI_AO0(CLK_PERI_AO_UART2_BCLK, "peri_ao_uart2_bclk", "uart", 2),
+	GATE_PERI_AO0(CLK_PERI_AO_UART3_BCLK, "peri_ao_uart3_bclk", "uart", 3),
+	GATE_PERI_AO0(CLK_PERI_AO_UART4_BCLK, "peri_ao_uart4_bclk", "uart", 4),
+	GATE_PERI_AO0(CLK_PERI_AO_UART5_BCLK, "peri_ao_uart5_bclk", "uart", 5),
+	GATE_PERI_AO0(CLK_PERI_AO_PWM_X16W_HCLK, "peri_ao_pwm_x16w", "p_axi", 12),
+	GATE_PERI_AO0(CLK_PERI_AO_PWM_X16W_BCLK, "peri_ao_pwm_x16w_bclk", "pwm", 13),
+	GATE_PERI_AO0(CLK_PERI_AO_PWM_PWM_BCLK0, "peri_ao_pwm_pwm_bclk0", "pwm", 14),
+	GATE_PERI_AO0(CLK_PERI_AO_PWM_PWM_BCLK1, "peri_ao_pwm_pwm_bclk1", "pwm", 15),
+	GATE_PERI_AO0(CLK_PERI_AO_PWM_PWM_BCLK2, "peri_ao_pwm_pwm_bclk2", "pwm", 16),
+	GATE_PERI_AO0(CLK_PERI_AO_PWM_PWM_BCLK3, "peri_ao_pwm_pwm_bclk3", "pwm", 17),
+	/* PERI_AO1 */
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI0_BCLK, "peri_ao_spi0_bclk", "spi0_b", 0),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI1_BCLK, "peri_ao_spi1_bclk", "spi1_b", 2),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI2_BCLK, "peri_ao_spi2_bclk", "spi2_b", 3),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI3_BCLK, "peri_ao_spi3_bclk", "spi3_b", 4),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI4_BCLK, "peri_ao_spi4_bclk", "spi4_b", 5),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI5_BCLK, "peri_ao_spi5_bclk", "spi5_b", 6),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI6_BCLK, "peri_ao_spi6_bclk", "spi6_b", 7),
+	GATE_HWV_PERI_AO1(CLK_PERI_AO_SPI7_BCLK, "peri_ao_spi7_bclk", "spi7_b", 8),
+	GATE_PERI_AO1(CLK_PERI_AO_FLASHIF_FLASH, "peri_ao_flashif_flash", "peri_ao_flashif_27m",
+		      18),
+	GATE_PERI_AO1(CLK_PERI_AO_FLASHIF_27M, "peri_ao_flashif_27m", "sflash", 19),
+	GATE_PERI_AO1(CLK_PERI_AO_FLASHIF_DRAM, "peri_ao_flashif_dram", "p_axi", 20),
+	GATE_PERI_AO1(CLK_PERI_AO_FLASHIF_AXI, "peri_ao_flashif_axi", "peri_ao_flashif_dram", 21),
+	GATE_PERI_AO1(CLK_PERI_AO_FLASHIF_BCLK, "peri_ao_flashif_bclk", "p_axi", 22),
+	GATE_PERI_AO1(CLK_PERI_AO_AP_DMA_X32W_BCLK, "peri_ao_ap_dma_x32w_bclk", "p_axi", 26),
+	/* PERI_AO2 */
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC1_MSDC_SRC, "peri_ao_msdc1_msdc_src", "msdc30_1", 1),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC1_HCLK, "peri_ao_msdc1", "peri_ao_msdc1_axi", 2),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC1_AXI, "peri_ao_msdc1_axi", "p_axi", 3),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC1_HCLK_WRAP, "peri_ao_msdc1_h_wrap", "peri_ao_msdc1", 4),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC2_MSDC_SRC, "peri_ao_msdc2_msdc_src", "msdc30_2", 10),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC2_HCLK, "peri_ao_msdc2", "peri_ao_msdc2_axi", 11),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC2_AXI, "peri_ao_msdc2_axi", "p_axi", 12),
+	GATE_PERI_AO2(CLK_PERI_AO_MSDC2_HCLK_WRAP, "peri_ao_msdc2_h_wrap", "peri_ao_msdc2", 13),
+};
+
+static const struct mtk_clk_desc peri_ao_mcd = {
+	.clks = peri_ao_clks,
+	.num_clks = ARRAY_SIZE(peri_ao_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8196_peri_ao[] = {
+	{ .compatible = "mediatek,mt8196-pericfg-ao", .data = &peri_ao_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_peri_ao);
+
+static struct platform_driver clk_mt8196_peri_ao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-peri-ao",
+		.of_match_table = of_match_clk_mt8196_peri_ao,
+	},
+};
+
+MODULE_DESCRIPTION("MediaTek MT8196 pericfg_ao clock controller driver");
+module_platform_driver(clk_mt8196_peri_ao_drv);
+MODULE_LICENSE("GPL");
-- 
2.39.5


