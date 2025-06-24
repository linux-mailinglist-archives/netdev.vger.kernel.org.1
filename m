Return-Path: <netdev+bounces-200712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDBAE694B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EB41C24F7E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00172E6107;
	Tue, 24 Jun 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dMhtJxeP"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C02E2F17;
	Tue, 24 Jun 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775632; cv=none; b=pexUOR9aEt+fLtE86DJe4QaTmhIJ0oN0gtXc3Z2xnNRX2FJWNqUvjnVJtwyELYmnXQWmEvigf0uefMVRngcTQqJ594Wil94wFAVGIBU3PwfcUDv/RIiRTaBFE21vN5UhGqzohVkpxV+F7heMYLvVqvhYuI8PLzcGYwDMSbFGXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775632; c=relaxed/simple;
	bh=zf5puNI2WPvX+i3sxDuWQAp3AL34tSyrYuAUwVTYt4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2F2Lero+NK7CEsaDjX67jRALYnbt/JQGYbn7FfN2k/u0jpEz4O/PZpjc/bcRCtKN+zpRK1GgTFblsp+aaLlpD8CRlN2MwLZ2OXZTOqJ2wkQiadoHuG3uYFRg99cQHRjW1Ng7HQOrlSLYzmSIPOE/UKl0wZPWU9OjnNXs4H5wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dMhtJxeP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775628;
	bh=zf5puNI2WPvX+i3sxDuWQAp3AL34tSyrYuAUwVTYt4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMhtJxePh9r8MciTJwoNyTfQzRVhKj3PTPiLpuP1xDId3zVUaVH7kqIjzvIizqO2h
	 rqZ2OMhcimDaMh7cA2Akp19LG1KGTGPJfb+IzdRVWLhxNZgMMm94h1W4lxZEQLclqK
	 gTgdM1WTEqdbVAeCZ5G+nUT5tgjTVGuCmwPJPyDb+0HK2lonBgwWk+jaNmezpnWWV/
	 MBVa6NCf3HuuIS/Q1i3kBG31qz8Jj7P6irYTGU7sIzkMXtG+Ks3ELcePQan2vUcGlS
	 vgSaJUyI6q8P/Q0JQP2wun/Y2lfxUKhnAqVNBRBX9bm1zmhl1U08EYG5A6angrcrRS
	 bkis0NTF5qOaw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 07A0E17E1090;
	Tue, 24 Jun 2025 16:33:46 +0200 (CEST)
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
Subject: [PATCH v2 13/29] clk: mediatek: Add MT8196 topckgen2 clock support
Date: Tue, 24 Jun 2025 16:32:04 +0200
Message-Id: <20250624143220.244549-14-laura.nao@collabora.com>
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

Add support for the MT8196 topckgen2 clock controller, which provides
muxes and dividers for clock selection in other IP blocks.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Makefile               |   3 +-
 drivers/clk/mediatek/clk-mt8196-topckgen2.c | 662 ++++++++++++++++++++
 2 files changed, 664 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen2.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index bc0e86e20074..0688d7bf4979 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -160,7 +160,8 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS) += clk-mt8195-vdo0.o clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
-obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
+				   clk-mt8196-topckgen2.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-topckgen2.c b/drivers/clk/mediatek/clk-mt8196-topckgen2.c
new file mode 100644
index 000000000000..189bb81d3dce
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-topckgen2.c
@@ -0,0 +1,662 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+/* MUX SEL REG */
+#define CKSYS2_CLK_CFG_UPDATE		0x0004
+#define CKSYS2_CLK_CFG_0		0x0010
+#define CKSYS2_CLK_CFG_0_SET		0x0014
+#define CKSYS2_CLK_CFG_0_CLR		0x0018
+#define CKSYS2_CLK_CFG_1		0x0020
+#define CKSYS2_CLK_CFG_1_SET		0x0024
+#define CKSYS2_CLK_CFG_1_CLR		0x0028
+#define CKSYS2_CLK_CFG_2		0x0030
+#define CKSYS2_CLK_CFG_2_SET		0x0034
+#define CKSYS2_CLK_CFG_2_CLR		0x0038
+#define CKSYS2_CLK_CFG_3		0x0040
+#define CKSYS2_CLK_CFG_3_SET		0x0044
+#define CKSYS2_CLK_CFG_3_CLR		0x0048
+#define CKSYS2_CLK_CFG_4		0x0050
+#define CKSYS2_CLK_CFG_4_SET		0x0054
+#define CKSYS2_CLK_CFG_4_CLR		0x0058
+#define CKSYS2_CLK_CFG_5		0x0060
+#define CKSYS2_CLK_CFG_5_SET		0x0064
+#define CKSYS2_CLK_CFG_5_CLR		0x0068
+#define CKSYS2_CLK_CFG_6		0x0070
+#define CKSYS2_CLK_CFG_6_SET		0x0074
+#define CKSYS2_CLK_CFG_6_CLR		0x0078
+#define CKSYS2_CLK_FENC_STATUS_MON_0	0x0174
+
+/* MUX SHIFT */
+#define TOP_MUX_SENINF0_SHIFT		0
+#define TOP_MUX_SENINF1_SHIFT		1
+#define TOP_MUX_SENINF2_SHIFT		2
+#define TOP_MUX_SENINF3_SHIFT		3
+#define TOP_MUX_SENINF4_SHIFT		4
+#define TOP_MUX_SENINF5_SHIFT		5
+#define TOP_MUX_IMG1_SHIFT		6
+#define TOP_MUX_IPE_SHIFT		7
+#define TOP_MUX_CAM_SHIFT		8
+#define TOP_MUX_CAMTM_SHIFT		9
+#define TOP_MUX_DPE_SHIFT		10
+#define TOP_MUX_VDEC_SHIFT		11
+#define TOP_MUX_CCUSYS_SHIFT		12
+#define TOP_MUX_CCUTM_SHIFT		13
+#define TOP_MUX_VENC_SHIFT		14
+#define TOP_MUX_DVO_SHIFT		15
+#define TOP_MUX_DVO_FAVT_SHIFT		16
+#define TOP_MUX_DP1_SHIFT		17
+#define TOP_MUX_DP0_SHIFT		18
+#define TOP_MUX_DISP_SHIFT		19
+#define TOP_MUX_MDP_SHIFT		20
+#define TOP_MUX_MMINFRA_SHIFT		21
+#define TOP_MUX_MMINFRA_SNOC_SHIFT	22
+#define TOP_MUX_MMUP_SHIFT		23
+#define TOP_MUX_MMINFRA_AO_SHIFT	26
+
+/* HW Voter REG */
+#define HWV_CG_30_SET		0x0058
+#define HWV_CG_30_CLR		0x005c
+#define HWV_CG_30_DONE		0x2c2c
+
+#define MM_HWV_CG_30_SET	0x00f0
+#define MM_HWV_CG_30_CLR	0x00f4
+#define MM_HWV_CG_30_DONE	0x2c78
+#define MM_HWV_CG_31_SET	0x00f8
+#define MM_HWV_CG_31_CLR	0x00fc
+#define MM_HWV_CG_31_DONE	0x2c7c
+#define MM_HWV_CG_32_SET	0x0100
+#define MM_HWV_CG_32_CLR	0x0104
+#define MM_HWV_CG_32_DONE	0x2c80
+#define MM_HWV_CG_33_SET	0x0108
+#define MM_HWV_CG_33_CLR	0x010c
+#define MM_HWV_CG_33_DONE	0x2c84
+#define MM_HWV_CG_34_SET	0x0110
+#define MM_HWV_CG_34_CLR	0x0114
+#define MM_HWV_CG_34_DONE	0x2c88
+#define MM_HWV_CG_35_SET	0x0118
+#define MM_HWV_CG_35_CLR	0x011c
+#define MM_HWV_CG_35_DONE	0x2c8c
+#define MM_HWV_CG_36_SET	0x0120
+#define MM_HWV_CG_36_CLR	0x0124
+#define MM_HWV_CG_36_DONE	0x2c90
+#define MM_HWV_MUX_UPDATE_31_0	0x0240
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP2_MAINPLL2_D2, "mainpll2_d2", "mainpll2", 1, 2),
+	FACTOR(CLK_TOP2_MAINPLL2_D3, "mainpll2_d3", "mainpll2", 1, 3),
+	FACTOR(CLK_TOP2_MAINPLL2_D4, "mainpll2_d4", "mainpll2", 1, 4),
+	FACTOR(CLK_TOP2_MAINPLL2_D4_D2, "mainpll2_d4_d2", "mainpll2", 1, 8),
+	FACTOR(CLK_TOP2_MAINPLL2_D4_D4, "mainpll2_d4_d4", "mainpll2", 1, 16),
+	FACTOR(CLK_TOP2_MAINPLL2_D5, "mainpll2_d5", "mainpll2", 1, 5),
+	FACTOR(CLK_TOP2_MAINPLL2_D5_D2, "mainpll2_d5_d2", "mainpll2", 1, 10),
+	FACTOR(CLK_TOP2_MAINPLL2_D6, "mainpll2_d6", "mainpll2", 1, 6),
+	FACTOR(CLK_TOP2_MAINPLL2_D6_D2, "mainpll2_d6_d2", "mainpll2", 1, 12),
+	FACTOR(CLK_TOP2_MAINPLL2_D7, "mainpll2_d7", "mainpll2", 1, 7),
+	FACTOR(CLK_TOP2_MAINPLL2_D7_D2, "mainpll2_d7_d2", "mainpll2", 1, 14),
+	FACTOR(CLK_TOP2_MAINPLL2_D9, "mainpll2_d9", "mainpll2", 1, 9),
+	FACTOR(CLK_TOP2_UNIVPLL2_D3, "univpll2_d3", "univpll2", 1, 3),
+	FACTOR(CLK_TOP2_UNIVPLL2_D4, "univpll2_d4", "univpll2", 1, 4),
+	FACTOR(CLK_TOP2_UNIVPLL2_D4_D2, "univpll2_d4_d2", "univpll2", 1, 8),
+	FACTOR(CLK_TOP2_UNIVPLL2_D5, "univpll2_d5", "univpll2", 1, 5),
+	FACTOR(CLK_TOP2_UNIVPLL2_D5_D2, "univpll2_d5_d2", "univpll2", 1, 10),
+	FACTOR(CLK_TOP2_UNIVPLL2_D6, "univpll2_d6", "univpll2", 1, 6),
+	FACTOR(CLK_TOP2_UNIVPLL2_D6_D2, "univpll2_d6_d2", "univpll2", 1, 12),
+	FACTOR(CLK_TOP2_UNIVPLL2_D6_D4, "univpll2_d6_d4", "univpll2", 1, 24),
+	FACTOR(CLK_TOP2_UNIVPLL2_D7, "univpll2_d7", "univpll2", 1, 7),
+	FACTOR(CLK_TOP2_IMGPLL_D2, "imgpll_d2", "imgpll", 1, 2),
+	FACTOR(CLK_TOP2_IMGPLL_D4, "imgpll_d4", "imgpll", 1, 4),
+	FACTOR(CLK_TOP2_IMGPLL_D5, "imgpll_d5", "imgpll", 1, 5),
+	FACTOR(CLK_TOP2_IMGPLL_D5_D2, "imgpll_d5_d2", "imgpll", 1, 10),
+	FACTOR(CLK_TOP2_MMPLL2_D3, "mmpll2_d3", "mmpll2", 1, 3),
+	FACTOR(CLK_TOP2_MMPLL2_D4, "mmpll2_d4", "mmpll2", 1, 4),
+	FACTOR(CLK_TOP2_MMPLL2_D4_D2, "mmpll2_d4_d2", "mmpll2", 1, 8),
+	FACTOR(CLK_TOP2_MMPLL2_D5, "mmpll2_d5", "mmpll2", 1, 5),
+	FACTOR(CLK_TOP2_MMPLL2_D5_D2, "mmpll2_d5_d2", "mmpll2", 1, 10),
+	FACTOR(CLK_TOP2_MMPLL2_D6, "mmpll2_d6", "mmpll2", 1, 6),
+	FACTOR(CLK_TOP2_MMPLL2_D6_D2, "mmpll2_d6_d2", "mmpll2", 1, 12),
+	FACTOR(CLK_TOP2_MMPLL2_D7, "mmpll2_d7", "mmpll2", 1, 7),
+	FACTOR(CLK_TOP2_MMPLL2_D9, "mmpll2_d9", "mmpll2", 1, 9),
+	FACTOR(CLK_TOP2_TVDPLL1_D4, "tvdpll1_d4", "tvdpll1", 1, 4),
+	FACTOR(CLK_TOP2_TVDPLL1_D8, "tvdpll1_d8", "tvdpll1", 1, 8),
+	FACTOR(CLK_TOP2_TVDPLL1_D16, "tvdpll1_d16", "tvdpll1", 1, 16),
+	FACTOR(CLK_TOP2_TVDPLL2_D2, "tvdpll2_d2", "tvdpll2", 1, 2),
+	FACTOR(CLK_TOP2_TVDPLL2_D4, "tvdpll2_d4", "tvdpll2", 1, 4),
+	FACTOR(CLK_TOP2_TVDPLL2_D8, "tvdpll2_d8", "tvdpll2", 1, 8),
+	FACTOR(CLK_TOP2_TVDPLL2_D16, "tvdpll2_d16", "tvdpll2", 92, 1473),
+	FACTOR(CLK_TOP2_TVDPLL3_D2, "tvdpll3_d2", "tvdpll3", 1, 2),
+	FACTOR(CLK_TOP2_TVDPLL3_D4, "tvdpll3_d4", "tvdpll3", 1, 4),
+	FACTOR(CLK_TOP2_TVDPLL3_D8, "tvdpll3_d8", "tvdpll3", 1, 8),
+	FACTOR(CLK_TOP2_TVDPLL3_D16, "tvdpll3_d16", "tvdpll3", 92, 1473),
+};
+
+static const char * const seninf0_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"univpll2_d6_d2",
+	"mainpll2_d9",
+	"ck_osc_d2",
+	"mainpll2_d4_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"univpll2_d7",
+	"mainpll2_d6",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"univpll2_d5"
+};
+
+static const char * const seninf1_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"univpll2_d6_d2",
+	"mainpll2_d9",
+	"ck_osc_d2",
+	"mainpll2_d4_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"univpll2_d7",
+	"mainpll2_d6",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"univpll2_d5"
+};
+
+static const char * const seninf2_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"univpll2_d6_d2",
+	"mainpll2_d9",
+	"ck_osc_d2",
+	"mainpll2_d4_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"univpll2_d7",
+	"mainpll2_d6",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"univpll2_d5"
+};
+
+static const char * const seninf3_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"univpll2_d6_d2",
+	"mainpll2_d9",
+	"ck_osc_d2",
+	"mainpll2_d4_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"univpll2_d7",
+	"mainpll2_d6",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"univpll2_d5"
+};
+
+static const char * const seninf4_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"univpll2_d6_d2",
+	"mainpll2_d9",
+	"ck_osc_d2",
+	"mainpll2_d4_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"univpll2_d7",
+	"mainpll2_d6",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"univpll2_d5"
+};
+
+static const char * const seninf5_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"univpll2_d6_d2",
+	"mainpll2_d9",
+	"ck_osc_d2",
+	"mainpll2_d4_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"univpll2_d7",
+	"mainpll2_d6",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"univpll2_d5"
+};
+
+static const char * const img1_parents[] = {
+	"clk26m",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"mmpll2_d6_d2",
+	"ck_osc_d2",
+	"imgpll_d5_d2",
+	"mmpll2_d5_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"mmpll2_d5",
+	"univpll2_d4",
+	"imgpll_d4"
+};
+
+static const char * const ipe_parents[] = {
+	"clk26m",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck_osc_d2",
+	"univpll2_d6",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"imgpll_d5",
+	"ck_mainpll_d4",
+	"mmpll2_d5",
+	"imgpll_d4"
+};
+
+static const char * const cam_parents[] = {
+	"clk26m",
+	"ck_osc_d10",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck_osc_d2",
+	"mmpll2_d5_d2",
+	"univpll2_d4_d2",
+	"univpll2_d7",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"mmpll2_d5",
+	"univpll2_d4",
+	"imgpll_d4",
+	"mmpll2_d4"
+};
+
+static const char * const camtm_parents[] = {
+	"clk26m",
+	"univpll2_d6_d4",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"univpll2_d6_d2"
+};
+
+static const char * const dpe_parents[] = {
+	"clk26m",
+	"mmpll2_d5_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"mmpll2_d5",
+	"imgpll_d4",
+	"mmpll2_d4"
+};
+
+static const char * const vdec_parents[] = {
+	"clk26m",
+	"ck_mainpll_d5_d2",
+	"mainpll2_d4_d4",
+	"mainpll2_d7_d2",
+	"mainpll2_d6_d2",
+	"mainpll2_d5_d2",
+	"mainpll2_d9",
+	"mainpll2_d4_d2",
+	"mainpll2_d7",
+	"mainpll2_d6",
+	"univpll2_d6",
+	"mainpll2_d5",
+	"mainpll2_d4",
+	"imgpll_d2"
+};
+
+static const char * const ccusys_parents[] = {
+	"clk26m",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck_osc_d2",
+	"mmpll2_d5_d2",
+	"univpll2_d4_d2",
+	"mmpll2_d7",
+	"univpll2_d6",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"mainpll2_d4",
+	"mainpll2_d3",
+	"univpll2_d3"
+};
+
+static const char * const ccutm_parents[] = {
+	"clk26m",
+	"univpll2_d6_d4",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"univpll2_d6_d2"
+};
+
+static const char * const venc_parents[] = {
+	"clk26m",
+	"mainpll2_d5_d2",
+	"univpll2_d5_d2",
+	"mainpll2_d4_d2",
+	"mmpll2_d9",
+	"univpll2_d4_d2",
+	"mmpll2_d4_d2",
+	"mainpll2_d6",
+	"univpll2_d6",
+	"mainpll2_d5",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"mainpll2_d4",
+	"univpll2_d4",
+	"univpll2_d3"
+};
+
+static const char * const dp1_parents[] = {
+	"clk26m",
+	"tvdpll2_d16",
+	"tvdpll2_d8",
+	"tvdpll2_d4",
+	"tvdpll2_d2"
+};
+
+static const char * const dp0_parents[] = {
+	"clk26m",
+	"tvdpll1_d16",
+	"tvdpll1_d8",
+	"tvdpll1_d4",
+	"ck_tvdpll1_d2"
+};
+
+static const char * const disp_parents[] = {
+	"clk26m",
+	"ck_mainpll_d5_d2",
+	"ck_mainpll_d4_d2",
+	"ck_mainpll_d6",
+	"mainpll2_d5",
+	"mmpll2_d6",
+	"mainpll2_d4",
+	"univpll2_d4",
+	"mainpll2_d3"
+};
+
+static const char * const mdp_parents[] = {
+	"clk26m",
+	"ck_mainpll_d5_d2",
+	"mainpll2_d5_d2",
+	"mmpll2_d6_d2",
+	"mainpll2_d9",
+	"mainpll2_d4_d2",
+	"mainpll2_d7",
+	"mainpll2_d6",
+	"mainpll2_d5",
+	"mmpll2_d6",
+	"mainpll2_d4",
+	"univpll2_d4",
+	"mainpll2_d3"
+};
+
+static const char * const mminfra_parents[] = {
+	"clk26m",
+	"ck_osc_d4",
+	"ck_mainpll_d7_d2",
+	"ck_mainpll_d5_d2",
+	"ck_mainpll_d9",
+	"mmpll2_d6_d2",
+	"mainpll2_d4_d2",
+	"ck_mainpll_d6",
+	"univpll2_d6",
+	"mainpll2_d5",
+	"mmpll2_d6",
+	"univpll2_d5",
+	"mainpll2_d4",
+	"univpll2_d4",
+	"mainpll2_d3",
+	"univpll2_d3"
+};
+
+static const char * const mminfra_snoc_parents[] = {
+	"clk26m",
+	"ck_osc_d4",
+	"ck_mainpll_d7_d2",
+	"ck_mainpll_d9",
+	"ck_mainpll_d7",
+	"ck_mainpll_d6",
+	"mmpll2_d4_d2",
+	"ck_mainpll_d5",
+	"ck_mainpll_d4",
+	"univpll2_d4",
+	"mmpll2_d4",
+	"mainpll2_d3",
+	"univpll2_d3",
+	"mmpll2_d3",
+	"mainpll2_d2"
+};
+
+static const char * const mmup_parents[] = {
+	"clk26m",
+	"mainpll2_d6",
+	"mainpll2_d5",
+	"ck_osc_d2",
+	"ck_osc",
+	"ck_mainpll_d4",
+	"univpll2_d4",
+	"mainpll2_d3"
+};
+
+static const char * const mminfra_ao_parents[] = {
+	"clk26m",
+	"ck_osc_d4",
+	"ck_mainpll_d3"
+};
+
+static const char * const dvo_parents[] = {
+	"clk26m",
+	"tvdpll3_d16",
+	"tvdpll3_d8",
+	"tvdpll3_d4",
+	"tvdpll3_d2"
+};
+
+static const char * const dvo_favt_parents[] = {
+	"clk26m",
+	"tvdpll3_d16",
+	"tvdpll3_d8",
+	"tvdpll3_d4",
+	"vlp_apll1",
+	"vlp_apll2",
+	"tvdpll3_d2"
+};
+
+static const struct mtk_mux top_muxes[] = {
+	/* CKSYS2_CLK_CFG_0 */
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_SENINF0, "seninf0", seninf0_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR,
+		MM_HWV_CG_30_DONE, MM_HWV_CG_30_SET, MM_HWV_CG_30_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF0_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 31),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_SENINF1, "seninf1", seninf1_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR,
+		MM_HWV_CG_30_DONE, MM_HWV_CG_30_SET, MM_HWV_CG_30_CLR,
+		8, 4, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF1_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 30),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_SENINF2, "seninf2", seninf2_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR,
+		MM_HWV_CG_30_DONE, MM_HWV_CG_30_SET, MM_HWV_CG_30_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF2_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 29),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_SENINF3, "seninf3", seninf3_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR,
+		MM_HWV_CG_30_DONE, MM_HWV_CG_30_SET, MM_HWV_CG_30_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF3_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 28),
+	/* CKSYS2_CLK_CFG_1 */
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_SENINF4, "seninf4", seninf4_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR,
+		MM_HWV_CG_31_DONE, MM_HWV_CG_31_SET, MM_HWV_CG_31_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF4_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 27),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_SENINF5, "seninf5", seninf5_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR,
+		MM_HWV_CG_31_DONE, MM_HWV_CG_31_SET, MM_HWV_CG_31_CLR,
+		8, 4, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF5_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 26),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_IMG1, "img1", img1_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR,
+		MM_HWV_CG_31_DONE, MM_HWV_CG_31_SET, MM_HWV_CG_31_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_IMG1_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 25),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_IPE, "ipe", ipe_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR,
+		MM_HWV_CG_31_DONE, MM_HWV_CG_31_SET, MM_HWV_CG_31_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_IPE_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 24),
+	/* CKSYS2_CLK_CFG_2 */
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_CAM, "cam", cam_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR,
+		MM_HWV_CG_32_DONE, MM_HWV_CG_32_SET, MM_HWV_CG_32_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CAM_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 23),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_CAMTM, "camtm", camtm_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR,
+		MM_HWV_CG_32_DONE, MM_HWV_CG_32_SET, MM_HWV_CG_32_CLR,
+		8, 3, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CAMTM_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 22),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_DPE, "dpe", dpe_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR,
+		MM_HWV_CG_32_DONE, MM_HWV_CG_32_SET, MM_HWV_CG_32_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DPE_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 21),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_VDEC, "vdec", vdec_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR,
+		MM_HWV_CG_32_DONE, MM_HWV_CG_32_SET, MM_HWV_CG_32_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_VDEC_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 20),
+	/* CKSYS2_CLK_CFG_3 */
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_CCUSYS, "ccusys", ccusys_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR,
+		MM_HWV_CG_33_DONE, MM_HWV_CG_33_SET, MM_HWV_CG_33_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CCUSYS_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 19),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_CCUTM, "ccutm", ccutm_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR,
+		MM_HWV_CG_33_DONE, MM_HWV_CG_33_SET, MM_HWV_CG_33_CLR,
+		8, 3, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CCUTM_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 18),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_VENC, "venc", venc_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR,
+		MM_HWV_CG_33_DONE, MM_HWV_CG_33_SET, MM_HWV_CG_33_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_VENC_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 17),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_TOP2_DVO, "dvo", dvo_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR,
+		24, 3, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DVO_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 16),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_TOP2_DVO_FAVT, "dvo_favt", dvo_favt_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		0, 3, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DVO_FAVT_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 15),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_TOP2_DP1, "dp1", dp1_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		8, 3, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DP1_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 14),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_TOP2_DP0, "dp0", dp0_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		16, 3, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DP0_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 13),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_DISP, "disp", disp_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		MM_HWV_CG_34_DONE, MM_HWV_CG_34_SET, MM_HWV_CG_34_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DISP_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 12),
+	/* CKSYS2_CLK_CFG_5 */
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_MDP, "mdp", mdp_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR,
+		MM_HWV_CG_35_DONE, MM_HWV_CG_35_SET, MM_HWV_CG_35_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MDP_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 11),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_MMINFRA, "mminfra", mminfra_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR,
+		MM_HWV_CG_35_DONE, MM_HWV_CG_35_SET, MM_HWV_CG_35_CLR,
+		8, 4, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMINFRA_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 10),
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_MMINFRA_SNOC, "mminfra_snoc", mminfra_snoc_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR,
+		MM_HWV_CG_35_DONE, MM_HWV_CG_35_SET, MM_HWV_CG_35_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMINFRA_SNOC_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 9),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_TOP2_MMUP, "mmup", mmup_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR,
+		24, 3, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMUP_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 8),
+	/* CKSYS2_CLK_CFG_6 */
+	MUX_GATE_HWV_FENC_CLR_SET_UPD(CLK_TOP2_MMINFRA_AO, "mminfra_ao", mminfra_ao_parents,
+		CKSYS2_CLK_CFG_6, CKSYS2_CLK_CFG_6_SET, CKSYS2_CLK_CFG_6_CLR,
+		MM_HWV_CG_36_DONE, MM_HWV_CG_36_SET, MM_HWV_CG_36_CLR,
+		16, 2, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMINFRA_AO_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 5),
+};
+
+static const struct mtk_clk_desc topck_desc = {
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+};
+
+static const struct of_device_id of_match_clk_mt8196_ck[] = {
+	{ .compatible = "mediatek,mt8196-topckgen-gp2", .data = &topck_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_ck);
+
+static struct platform_driver clk_mt8196_topck_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-topck2",
+		.of_match_table = of_match_clk_mt8196_ck,
+	},
+};
+
+MODULE_DESCRIPTION("MediaTek MT8196 GP2 top clock generators driver");
+module_platform_driver(clk_mt8196_topck_drv);
+MODULE_LICENSE("GPL");
-- 
2.39.5


