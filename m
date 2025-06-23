Return-Path: <netdev+bounces-200228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C874BAE3CAE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11D33AF1C3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857E255F5C;
	Mon, 23 Jun 2025 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qsBRhxAd"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7E253B7E;
	Mon, 23 Jun 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674653; cv=none; b=up4OGRZAiBrOpnFbjJBs+ZVsU/pZtdlF6A8FBafeyPBGEaQ8zwGDVUL6GBiJ3PokXxcZNiNW9Zbx9afdLoTfo2Y7NifuZ7SvgVbzJ44Xzc9dRvz9BXYM6nedPkQHV7arrH+ZiThLHHjLi3idGNt+OEO/B6yq9eXc0o5fzbMbtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674653; c=relaxed/simple;
	bh=O8uMQDzgtHpuRnJZ1Ko6AFlERKgEA4TweH465A90b9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPf9uEFvJfCeGrKzHKGYQAUNS6AUQsqC5E76Ye8PuLfkwL0S3dvLZaoMvpGeyFhD1Ie3Ze0BDEOoabcI1eq9Vr3h1a/QBItcMZiMHxDW7RGDSGSjMgOJC/mplEyCyEdkfjTdI0a+anWnCb/2rrYyYH1DUwCSLLPAv0bsgBMDrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qsBRhxAd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674648;
	bh=O8uMQDzgtHpuRnJZ1Ko6AFlERKgEA4TweH465A90b9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsBRhxAdqJeZjdhxKZiC6gYZK4tNxS8RBOKrxfp4di9JJvYpl0FTqK2ayzwBjxylY
	 DXqpC5Xqh/gbE2BoCHGwGzIbnV80nrlFT9krNgSP7U9nx5cSrWn/iCcDj6Ju4yMoVS
	 WR79+Gxxrt7+UHRLJOhYmgGkKlNeHJ4nIIqQMnrEXN++9mU+tS6pxYiK4tnt8JfoVo
	 PANYzJ+YV9fnPj5iyAQL62HLFMxg2Gk+3ae88mqTpwN4MfQL/gKogETAcNZ3eUJUsj
	 LFf6kzS3Six1kPYX2ZAeUqIno94hgCImz+YIE9ypV+1MfJQE+OvQOBCUkT7Zk/f80b
	 R/PtDGtV4n0OA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 985AE17E10D5;
	Mon, 23 Jun 2025 12:30:47 +0200 (CEST)
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
Subject: [PATCH 17/30] clk: mediatek: Add MT8196 adsp clock support
Date: Mon, 23 Jun 2025 12:29:27 +0200
Message-Id: <20250623102940.214269-18-laura.nao@collabora.com>
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

Add support for the MT8196 adsp clock controller, which provides clock
gate control for Audio DSP.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig           |   7 +
 drivers/clk/mediatek/Makefile          |   1 +
 drivers/clk/mediatek/clk-mt8196-adsp.c | 193 +++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index cd12e7ff3e12..d4c97f64b42a 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1068,6 +1068,13 @@ config COMMON_CLK_MT8196
 	help
 	  This driver supports MediaTek MT8196 basic clocks.
 
+config COMMON_CLK_MT8196_ADSP
+	tristate "Clock driver for MediaTek MT8196 adsp"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 adsp clocks
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 21e768f67283..6a34ee2f7855 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
 				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-adsp.c b/drivers/clk/mediatek/clk-mt8196-adsp.c
new file mode 100644
index 000000000000..2c1852b77aa8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-adsp.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
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
+static const struct mtk_gate_regs afe0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs afe1_cg_regs = {
+	.set_ofs = 0x10,
+	.clr_ofs = 0x10,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs afe2_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+static const struct mtk_gate_regs afe3_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x8,
+};
+
+static const struct mtk_gate_regs afe4_cg_regs = {
+	.set_ofs = 0xc,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0xc,
+};
+
+#define GATE_AFE0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe0_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe1_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe2_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE3(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe3_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE4(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe4_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+static const struct mtk_gate afe_clks[] = {
+	/* AFE0 */
+	GATE_AFE0(CLK_AFE_PCM1, "afe_pcm1", "clk26m", 13),
+	GATE_AFE0(CLK_AFE_PCM0, "afe_pcm0", "clk26m", 14),
+	GATE_AFE0(CLK_AFE_CM2, "afe_cm2", "clk26m", 16),
+	GATE_AFE0(CLK_AFE_CM1, "afe_cm1", "clk26m", 17),
+	GATE_AFE0(CLK_AFE_CM0, "afe_cm0", "clk26m", 18),
+	GATE_AFE0(CLK_AFE_STF, "afe_stf", "clk26m", 19),
+	GATE_AFE0(CLK_AFE_HW_GAIN23, "afe_hw_gain23", "clk26m", 20),
+	GATE_AFE0(CLK_AFE_HW_GAIN01, "afe_hw_gain01", "clk26m", 21),
+	GATE_AFE0(CLK_AFE_FM_I2S, "afe_fm_i2s", "clk26m", 24),
+	GATE_AFE0(CLK_AFE_MTKAIFV4, "afe_mtkaifv4", "clk26m", 25),
+	/* AFE1 */
+	GATE_AFE1(CLK_AFE_AUDIO_HOPPING, "afe_audio_hopping_ck", "clk26m", 0),
+	GATE_AFE1(CLK_AFE_AUDIO_F26M, "afe_audio_f26m_ck", "clk26m", 1),
+	GATE_AFE1(CLK_AFE_APLL1, "afe_apll1_ck", "aud_1", 2),
+	GATE_AFE1(CLK_AFE_APLL2, "afe_apll2_ck", "aud_2", 3),
+	GATE_AFE1(CLK_AFE_H208M, "afe_h208m_ck", "vlp_audio_h", 4),
+	GATE_AFE1(CLK_AFE_APLL_TUNER2, "afe_apll_tuner2", "vlp_aud_engen2", 12),
+	GATE_AFE1(CLK_AFE_APLL_TUNER1, "afe_apll_tuner1", "vlp_aud_engen1", 13),
+	/* AFE2 */
+	GATE_AFE2(CLK_AFE_UL2_ADC_HIRES_TML, "afe_ul2_aht", "vlp_audio_h", 12),
+	GATE_AFE2(CLK_AFE_UL2_ADC_HIRES, "afe_ul2_adc_hires", "vlp_audio_h", 13),
+	GATE_AFE2(CLK_AFE_UL2_TML, "afe_ul2_tml", "clk26m", 14),
+	GATE_AFE2(CLK_AFE_UL2_ADC, "afe_ul2_adc", "clk26m", 15),
+	GATE_AFE2(CLK_AFE_UL1_ADC_HIRES_TML, "afe_ul1_aht", "vlp_audio_h", 16),
+	GATE_AFE2(CLK_AFE_UL1_ADC_HIRES, "afe_ul1_adc_hires", "vlp_audio_h", 17),
+	GATE_AFE2(CLK_AFE_UL1_TML, "afe_ul1_tml", "clk26m", 18),
+	GATE_AFE2(CLK_AFE_UL1_ADC, "afe_ul1_adc", "clk26m", 19),
+	GATE_AFE2(CLK_AFE_UL0_ADC_HIRES_TML, "afe_ul0_aht", "vlp_audio_h", 20),
+	GATE_AFE2(CLK_AFE_UL0_ADC_HIRES, "afe_ul0_adc_hires", "vlp_audio_h", 21),
+	GATE_AFE2(CLK_AFE_UL0_TML, "afe_ul0_tml", "clk26m", 22),
+	GATE_AFE2(CLK_AFE_UL0_ADC, "afe_ul0_adc", "clk26m", 23),
+	/* AFE3 */
+	GATE_AFE3(CLK_AFE_ETDM_IN6, "afe_etdm_in6", "clk26m", 7),
+	GATE_AFE3(CLK_AFE_ETDM_IN5, "afe_etdm_in5", "clk26m", 8),
+	GATE_AFE3(CLK_AFE_ETDM_IN4, "afe_etdm_in4", "clk26m", 9),
+	GATE_AFE3(CLK_AFE_ETDM_IN3, "afe_etdm_in3", "clk26m", 10),
+	GATE_AFE3(CLK_AFE_ETDM_IN2, "afe_etdm_in2", "clk26m", 11),
+	GATE_AFE3(CLK_AFE_ETDM_IN1, "afe_etdm_in1", "clk26m", 12),
+	GATE_AFE3(CLK_AFE_ETDM_IN0, "afe_etdm_in0", "clk26m", 13),
+	GATE_AFE3(CLK_AFE_ETDM_OUT6, "afe_etdm_out6", "clk26m", 15),
+	GATE_AFE3(CLK_AFE_ETDM_OUT5, "afe_etdm_out5", "clk26m", 16),
+	GATE_AFE3(CLK_AFE_ETDM_OUT4, "afe_etdm_out4", "clk26m", 17),
+	GATE_AFE3(CLK_AFE_ETDM_OUT3, "afe_etdm_out3", "clk26m", 18),
+	GATE_AFE3(CLK_AFE_ETDM_OUT2, "afe_etdm_out2", "clk26m", 19),
+	GATE_AFE3(CLK_AFE_ETDM_OUT1, "afe_etdm_out1", "clk26m", 20),
+	GATE_AFE3(CLK_AFE_ETDM_OUT0, "afe_etdm_out0", "clk26m", 21),
+	GATE_AFE3(CLK_AFE_TDM_OUT, "afe_tdm_out", "aud_1", 24),
+	/* AFE4 */
+	GATE_AFE4(CLK_AFE_GENERAL15_ASRC, "afe_general15_asrc", "clk26m", 9),
+	GATE_AFE4(CLK_AFE_GENERAL14_ASRC, "afe_general14_asrc", "clk26m", 10),
+	GATE_AFE4(CLK_AFE_GENERAL13_ASRC, "afe_general13_asrc", "clk26m", 11),
+	GATE_AFE4(CLK_AFE_GENERAL12_ASRC, "afe_general12_asrc", "clk26m", 12),
+	GATE_AFE4(CLK_AFE_GENERAL11_ASRC, "afe_general11_asrc", "clk26m", 13),
+	GATE_AFE4(CLK_AFE_GENERAL10_ASRC, "afe_general10_asrc", "clk26m", 14),
+	GATE_AFE4(CLK_AFE_GENERAL9_ASRC, "afe_general9_asrc", "clk26m", 15),
+	GATE_AFE4(CLK_AFE_GENERAL8_ASRC, "afe_general8_asrc", "clk26m", 16),
+	GATE_AFE4(CLK_AFE_GENERAL7_ASRC, "afe_general7_asrc", "clk26m", 17),
+	GATE_AFE4(CLK_AFE_GENERAL6_ASRC, "afe_general6_asrc", "clk26m", 18),
+	GATE_AFE4(CLK_AFE_GENERAL5_ASRC, "afe_general5_asrc", "clk26m", 19),
+	GATE_AFE4(CLK_AFE_GENERAL4_ASRC, "afe_general4_asrc", "clk26m", 20),
+	GATE_AFE4(CLK_AFE_GENERAL3_ASRC, "afe_general3_asrc", "clk26m", 21),
+	GATE_AFE4(CLK_AFE_GENERAL2_ASRC, "afe_general2_asrc", "clk26m", 22),
+	GATE_AFE4(CLK_AFE_GENERAL1_ASRC, "afe_general1_asrc", "clk26m", 23),
+	GATE_AFE4(CLK_AFE_GENERAL0_ASRC, "afe_general0_asrc", "clk26m", 24),
+	GATE_AFE4(CLK_AFE_CONNSYS_I2S_ASRC, "afe_connsys_i2s_asrc", "clk26m", 25),
+};
+
+static const struct mtk_clk_desc afe_mcd = {
+	.clks = afe_clks,
+	.num_clks = ARRAY_SIZE(afe_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_adsp[] = {
+	{ .compatible = "mediatek,mt8196-adsp", .data = &afe_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_adsp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-adsp",
+		.of_match_table = of_match_clk_mt8196_adsp,
+	},
+};
+module_platform_driver(clk_mt8196_adsp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 AudioDSP clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


