Return-Path: <netdev+bounces-210967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD54B15EDC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD693AC460
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B102BEFE2;
	Wed, 30 Jul 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q7mimemA"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0292BE054;
	Wed, 30 Jul 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873116; cv=none; b=rRno7g2W7BzlojCo1bFCFrpGTUDqGLZHyXAywecKFuF5mfRg5EbaOnEQkPMa4WRqlmKqeeK+R3YxS2Ov6tSCER7NKwDOvoZEkkQt6HMwaAbkuT3neUavkqrwZHjzg61Opm5COqT4/yAQ0BJ1Ond/4dDXWeHgGficlyg3xTJPP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873116; c=relaxed/simple;
	bh=Ptji+DVpWI/LZwY6g2hnSXLJgVcInZqiTbErWdc4Tbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWQIzc38TfRf1xdAVlM8WrXuoczQibIWya75O6nnvYZ5e4pBGk3h7GdXS3rIWHFfWD49nZGWrhDK1xU7Cout72TWefSwUQrNm5wp2VlPQ9a8SMyxYbnHMGNVQ/4odL1kafoeLn1NIH90Nc/qBTytFcnuxO9dUwj8em3cXKQwMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q7mimemA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873112;
	bh=Ptji+DVpWI/LZwY6g2hnSXLJgVcInZqiTbErWdc4Tbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7mimemAgGiqaz6UeWw6ymR3YtDweAtmHX3a7EDypVzWK14CznaJTcq870Jvq28oy
	 jgJA7Ut3/Trk2z311JqEH963uUti8UslyGmMGcpm3vLfFHW1hJuKKhIt8mkAKRge+O
	 qxdPzSpj49rtvZ0Pwp32/5NkqVkejt5Y+totXD0Cnr7vWfiJJS2k07C1x3Ht3r7dfE
	 swlDzDR6lIzcNyAZdrEAm//qg+7Xy9YQMzQWXiwW0j+ZzC6hgKtqwKiTiGf9kfGX7u
	 VACeR0hMYicLvPypnCBy0Ls5eSDc7Sto7XCI9I4uWjPi2GXcOPy4lOalaaBkfIAj2w
	 4ntAeiU1v1tYw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DA7517E130E;
	Wed, 30 Jul 2025 12:58:31 +0200 (CEST)
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
Subject: [PATCH v3 19/27] clk: mediatek: Add MT8196 mdpsys clock support
Date: Wed, 30 Jul 2025 12:56:45 +0200
Message-Id: <20250730105653.64910-20-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730105653.64910-1-laura.nao@collabora.com>
References: <20250730105653.64910-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the MT8196 mdpsys clock controller, which provides clock
gate control for MDP.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig             |   7 +
 drivers/clk/mediatek/Makefile            |   1 +
 drivers/clk/mediatek/clk-mt8196-mdpsys.c | 187 +++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 15d17e81865e..8ae5a0546202 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1082,6 +1082,13 @@ config COMMON_CLK_MT8196_MCUSYS
 	help
 	  This driver supports MediaTek MT8196 mcusys clocks.
 
+config COMMON_CLK_MT8196_MDPSYS
+	tristate "Clock driver for MediaTek MT8196 mdpsys"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 mdpsys clocks.
+
 config COMMON_CLK_MT8196_PEXTPSYS
 	tristate "Clock driver for MediaTek MT8196 pextpsys"
 	depends on COMMON_CLK_MT8196
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 3353ac67a2f1..5c327a7239bc 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -165,6 +165,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
 				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-mdpsys.c b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
new file mode 100644
index 000000000000..87ac3b52fcbc
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
@@ -0,0 +1,187 @@
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
+static const struct mtk_gate_regs mdp0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mdp1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs mdp2_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+#define GATE_MDP0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp0_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_MDP1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp1_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_MDP2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp2_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate mdp1_clks[] = {
+	/* MDP1-0 */
+	GATE_MDP0(CLK_MDP1_MDP_MUTEX0, "mdp1_mdp_mutex0", "mdp", 0),
+	GATE_MDP0(CLK_MDP1_SMI0, "mdp1_smi0", "mdp", 1),
+	GATE_MDP0(CLK_MDP1_APB_BUS, "mdp1_apb_bus", "mdp", 2),
+	GATE_MDP0(CLK_MDP1_MDP_RDMA0, "mdp1_mdp_rdma0", "mdp", 3),
+	GATE_MDP0(CLK_MDP1_MDP_RDMA1, "mdp1_mdp_rdma1", "mdp", 4),
+	GATE_MDP0(CLK_MDP1_MDP_RDMA2, "mdp1_mdp_rdma2", "mdp", 5),
+	GATE_MDP0(CLK_MDP1_MDP_BIRSZ0, "mdp1_mdp_birsz0", "mdp", 6),
+	GATE_MDP0(CLK_MDP1_MDP_HDR0, "mdp1_mdp_hdr0", "mdp", 7),
+	GATE_MDP0(CLK_MDP1_MDP_AAL0, "mdp1_mdp_aal0", "mdp", 8),
+	GATE_MDP0(CLK_MDP1_MDP_RSZ0, "mdp1_mdp_rsz0", "mdp", 9),
+	GATE_MDP0(CLK_MDP1_MDP_RSZ2, "mdp1_mdp_rsz2", "mdp", 10),
+	GATE_MDP0(CLK_MDP1_MDP_TDSHP0, "mdp1_mdp_tdshp0", "mdp", 11),
+	GATE_MDP0(CLK_MDP1_MDP_COLOR0, "mdp1_mdp_color0", "mdp", 12),
+	GATE_MDP0(CLK_MDP1_MDP_WROT0, "mdp1_mdp_wrot0", "mdp", 13),
+	GATE_MDP0(CLK_MDP1_MDP_WROT1, "mdp1_mdp_wrot1", "mdp", 14),
+	GATE_MDP0(CLK_MDP1_MDP_WROT2, "mdp1_mdp_wrot2", "mdp", 15),
+	GATE_MDP0(CLK_MDP1_MDP_FAKE_ENG0, "mdp1_mdp_fake_eng0", "mdp", 16),
+	GATE_MDP0(CLK_MDP1_APB_DB, "mdp1_apb_db", "mdp", 17),
+	GATE_MDP0(CLK_MDP1_MDP_DLI_ASYNC0, "mdp1_mdp_dli_async0", "mdp", 18),
+	GATE_MDP0(CLK_MDP1_MDP_DLI_ASYNC1, "mdp1_mdp_dli_async1", "mdp", 19),
+	GATE_MDP0(CLK_MDP1_MDP_DLO_ASYNC0, "mdp1_mdp_dlo_async0", "mdp", 20),
+	GATE_MDP0(CLK_MDP1_MDP_DLO_ASYNC1, "mdp1_mdp_dlo_async1", "mdp", 21),
+	GATE_MDP0(CLK_MDP1_MDP_DLI_ASYNC2, "mdp1_mdp_dli_async2", "mdp", 22),
+	GATE_MDP0(CLK_MDP1_MDP_DLO_ASYNC2, "mdp1_mdp_dlo_async2", "mdp", 23),
+	GATE_MDP0(CLK_MDP1_MDP_DLO_ASYNC3, "mdp1_mdp_dlo_async3", "mdp", 24),
+	GATE_MDP0(CLK_MDP1_IMG_DL_ASYNC0, "mdp1_img_dl_async0", "mdp", 25),
+	GATE_MDP0(CLK_MDP1_MDP_RROT0, "mdp1_mdp_rrot0", "mdp", 26),
+	GATE_MDP0(CLK_MDP1_MDP_MERGE0, "mdp1_mdp_merge0", "mdp", 27),
+	GATE_MDP0(CLK_MDP1_MDP_C3D0, "mdp1_mdp_c3d0", "mdp", 28),
+	GATE_MDP0(CLK_MDP1_MDP_FG0, "mdp1_mdp_fg0", "mdp", 29),
+	GATE_MDP0(CLK_MDP1_MDP_CLA2, "mdp1_mdp_cla2", "mdp", 30),
+	GATE_MDP0(CLK_MDP1_MDP_DLO_ASYNC4, "mdp1_mdp_dlo_async4", "mdp", 31),
+	/* MDP1-1 */
+	GATE_MDP1(CLK_MDP1_VPP_RSZ0, "mdp1_vpp_rsz0", "mdp", 0),
+	GATE_MDP1(CLK_MDP1_VPP_RSZ1, "mdp1_vpp_rsz1", "mdp", 1),
+	GATE_MDP1(CLK_MDP1_MDP_DLO_ASYNC5, "mdp1_mdp_dlo_async5", "mdp", 2),
+	GATE_MDP1(CLK_MDP1_IMG0, "mdp1_img0", "mdp", 3),
+	GATE_MDP1(CLK_MDP1_F26M, "mdp1_f26m", "clk26m", 27),
+	/* MDP1-2 */
+	GATE_MDP2(CLK_MDP1_IMG_DL_RELAY0, "mdp1_img_dl_relay0", "mdp", 0),
+	GATE_MDP2(CLK_MDP1_IMG_DL_RELAY1, "mdp1_img_dl_relay1", "mdp", 8),
+};
+
+static const struct mtk_clk_desc mdp1_mcd = {
+	.clks = mdp1_clks,
+	.num_clks = ARRAY_SIZE(mdp1_clks),
+	.need_runtime_pm = true,
+};
+
+
+static const struct mtk_gate mdp_clks[] = {
+	/* MDP0 */
+	GATE_MDP0(CLK_MDP_MDP_MUTEX0, "mdp_mdp_mutex0", "mdp", 0),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "mdp", 1),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "mdp", 2),
+	GATE_MDP0(CLK_MDP_MDP_RDMA0, "mdp_mdp_rdma0", "mdp", 3),
+	GATE_MDP0(CLK_MDP_MDP_RDMA1, "mdp_mdp_rdma1", "mdp", 4),
+	GATE_MDP0(CLK_MDP_MDP_RDMA2, "mdp_mdp_rdma2", "mdp", 5),
+	GATE_MDP0(CLK_MDP_MDP_BIRSZ0, "mdp_mdp_birsz0", "mdp", 6),
+	GATE_MDP0(CLK_MDP_MDP_HDR0, "mdp_mdp_hdr0", "mdp", 7),
+	GATE_MDP0(CLK_MDP_MDP_AAL0, "mdp_mdp_aal0", "mdp", 8),
+	GATE_MDP0(CLK_MDP_MDP_RSZ0, "mdp_mdp_rsz0", "mdp", 9),
+	GATE_MDP0(CLK_MDP_MDP_RSZ2, "mdp_mdp_rsz2", "mdp", 10),
+	GATE_MDP0(CLK_MDP_MDP_TDSHP0, "mdp_mdp_tdshp0", "mdp", 11),
+	GATE_MDP0(CLK_MDP_MDP_COLOR0, "mdp_mdp_color0", "mdp", 12),
+	GATE_MDP0(CLK_MDP_MDP_WROT0, "mdp_mdp_wrot0", "mdp", 13),
+	GATE_MDP0(CLK_MDP_MDP_WROT1, "mdp_mdp_wrot1", "mdp", 14),
+	GATE_MDP0(CLK_MDP_MDP_WROT2, "mdp_mdp_wrot2", "mdp", 15),
+	GATE_MDP0(CLK_MDP_MDP_FAKE_ENG0, "mdp_mdp_fake_eng0", "mdp", 16),
+	GATE_MDP0(CLK_MDP_APB_DB, "mdp_apb_db", "mdp", 17),
+	GATE_MDP0(CLK_MDP_MDP_DLI_ASYNC0, "mdp_mdp_dli_async0", "mdp", 18),
+	GATE_MDP0(CLK_MDP_MDP_DLI_ASYNC1, "mdp_mdp_dli_async1", "mdp", 19),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC0, "mdp_mdp_dlo_async0", "mdp", 20),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC1, "mdp_mdp_dlo_async1", "mdp", 21),
+	GATE_MDP0(CLK_MDP_MDP_DLI_ASYNC2, "mdp_mdp_dli_async2", "mdp", 22),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC2, "mdp_mdp_dlo_async2", "mdp", 23),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC3, "mdp_mdp_dlo_async3", "mdp", 24),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC0, "mdp_img_dl_async0", "mdp", 25),
+	GATE_MDP0(CLK_MDP_MDP_RROT0, "mdp_mdp_rrot0", "mdp", 26),
+	GATE_MDP0(CLK_MDP_MDP_MERGE0, "mdp_mdp_merge0", "mdp", 27),
+	GATE_MDP0(CLK_MDP_MDP_C3D0, "mdp_mdp_c3d0", "mdp", 28),
+	GATE_MDP0(CLK_MDP_MDP_FG0, "mdp_mdp_fg0", "mdp", 29),
+	GATE_MDP0(CLK_MDP_MDP_CLA2, "mdp_mdp_cla2", "mdp", 30),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC4, "mdp_mdp_dlo_async4", "mdp", 31),
+	/* MDP1 */
+	GATE_MDP1(CLK_MDP_VPP_RSZ0, "mdp_vpp_rsz0", "mdp", 0),
+	GATE_MDP1(CLK_MDP_VPP_RSZ1, "mdp_vpp_rsz1", "mdp", 1),
+	GATE_MDP1(CLK_MDP_MDP_DLO_ASYNC5, "mdp_mdp_dlo_async5", "mdp", 2),
+	GATE_MDP1(CLK_MDP_IMG0, "mdp_img0", "mdp", 3),
+	GATE_MDP1(CLK_MDP_F26M, "mdp_f26m", "clk26m", 27),
+	/* MDP2 */
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY0, "mdp_img_dl_relay0", "mdp", 0),
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY1, "mdp_img_dl_relay1", "mdp", 8),
+};
+
+static const struct mtk_clk_desc mdp_mcd = {
+	.clks = mdp_clks,
+	.num_clks = ARRAY_SIZE(mdp_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_mdpsys[] = {
+	{ .compatible = "mediatek,mt8196-mdpsys1", .data = &mdp1_mcd },
+	{ .compatible = "mediatek,mt8196-mdpsys0", .data = &mdp_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mdpsys);
+
+static struct platform_driver clk_mt8196_mdpsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-mdpsys",
+		.of_match_table = of_match_clk_mt8196_mdpsys,
+	},
+};
+module_platform_driver(clk_mt8196_mdpsys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 Multimedia Data Path clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


