Return-Path: <netdev+bounces-210973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95DB15EF1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE589565D58
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5492D193B;
	Wed, 30 Jul 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R1+rsdyY"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573C2C327F;
	Wed, 30 Jul 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873124; cv=none; b=Zlyl5HW51BJ9P4v9zVhVUVqmb4Ng3Q5vfM/nA0y9OA8xx71KQi23A/Ffe2UgMuHWCAs/RcDNkNL/nGfLg7XSn4gBAnLYHbUS/oAtLOoeE6Z262z/A+gK9PkILftFbqjREtrSRfHwrxbHdg9O9m9T7CQPT79Tus56ExzRgHNHPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873124; c=relaxed/simple;
	bh=QjyvYG5AfkcIeaOcgxPt5yYRgaDyrBOCLWDy+vZ+wcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9R1h7MdT5S5UDfZM+M6EFQkT96d5CBCfPe0dvucHCvSZxK+Bu2uA3IiLkQMKuYPAr+RL5kmYfNvCpgfh4BbsXeoAx6jjem/SQt7yYh0Azx4ofHfu3OdskOQu9y4zzinWpUfcBhgBVQtikZifY+q7c0yR3UT9P33ZZ6KUTxkY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R1+rsdyY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873120;
	bh=QjyvYG5AfkcIeaOcgxPt5yYRgaDyrBOCLWDy+vZ+wcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1+rsdyYwQaRcJEuig2GN8xkPhQFwiA0nvYEZSmPdSikESL4hD8Jpob5qaX9I2jKu
	 dB/UeBm1zGwrveZpfMesvmsuqewE65G91vTvSUjFjcLYgnzS6C+r9KnTPHxqJCsWgd
	 A5bzG46z9ePzdynzGGVFtZICCQDVk8eNg0fY+66+vPxsq//WalKJcRxBSprjX5ElDr
	 I/GUkwcAMYoSZl0iWdUk6mXcqhXBHOZTYp5aev7vAHor4w6jb33yboqY+d5jK8s3Lr
	 DDWkSxPQaw8/oelbevDuCGCNPEDiXv1LZ9EchF6iJWtOlgE3zwPBVVX4G9ti3t3Fr4
	 DbxqGtrszLhVQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8230117E15A8;
	Wed, 30 Jul 2025 12:58:39 +0200 (CEST)
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
Subject: [PATCH v3 25/27] clk: mediatek: Add MT8196 ovl1 clock support
Date: Wed, 30 Jul 2025 12:56:51 +0200
Message-Id: <20250730105653.64910-26-laura.nao@collabora.com>
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

Add support for the MT8196 ovl1 clock controller, which provides clock
gate control for the display system. It is integrated with the mtk-mmsys
driver, which registers the ovl1 clock driver via
platform_device_register_data().

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-mt8196-ovl1.c | 153 +++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl1.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 25b03519ee81..7e8d7d5fce68 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -168,7 +168,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o clk-mt8196-vdisp_ao.o \
-					 clk-mt8196-ovl0.o
+					 clk-mt8196-ovl0.o clk-mt8196-ovl1.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-ovl1.c b/drivers/clk/mediatek/clk-mt8196-ovl1.c
new file mode 100644
index 000000000000..b6a820cce80e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-ovl1.c
@@ -0,0 +1,153 @@
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
+static const struct mtk_gate_regs ovl10_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs ovl10_hwv_regs = {
+	.set_ofs = 0x0050,
+	.clr_ofs = 0x0054,
+	.sta_ofs = 0x2c28,
+};
+
+static const struct mtk_gate_regs ovl11_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs ovl11_hwv_regs = {
+	.set_ofs = 0x0058,
+	.clr_ofs = 0x005c,
+	.sta_ofs = 0x2c2c,
+};
+
+#define GATE_HWV_OVL10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ovl10_cg_regs,			\
+		.hwv_regs = &ovl10_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags =  CLK_OPS_PARENT_ENABLE,	\
+	}
+
+#define GATE_HWV_OVL11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ovl11_cg_regs,			\
+		.hwv_regs = &ovl11_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ovl1_clks[] = {
+	/* OVL10 */
+	GATE_HWV_OVL10(CLK_OVL1_OVLSYS_CONFIG, "ovl1_ovlsys_config", "disp", 0),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_FAKE_ENG0, "ovl1_ovl_fake_eng0", "disp", 1),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_FAKE_ENG1, "ovl1_ovl_fake_eng1", "disp", 2),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_MUTEX0, "ovl1_ovl_mutex0", "disp", 3),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA0, "ovl1_ovl_exdma0", "disp", 4),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA1, "ovl1_ovl_exdma1", "disp", 5),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA2, "ovl1_ovl_exdma2", "disp", 6),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA3, "ovl1_ovl_exdma3", "disp", 7),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA4, "ovl1_ovl_exdma4", "disp", 8),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA5, "ovl1_ovl_exdma5", "disp", 9),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA6, "ovl1_ovl_exdma6", "disp", 10),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA7, "ovl1_ovl_exdma7", "disp", 11),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA8, "ovl1_ovl_exdma8", "disp", 12),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_EXDMA9, "ovl1_ovl_exdma9", "disp", 13),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER0, "ovl1_ovl_blender0", "disp", 14),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER1, "ovl1_ovl_blender1", "disp", 15),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER2, "ovl1_ovl_blender2", "disp", 16),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER3, "ovl1_ovl_blender3", "disp", 17),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER4, "ovl1_ovl_blender4", "disp", 18),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER5, "ovl1_ovl_blender5", "disp", 19),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER6, "ovl1_ovl_blender6", "disp", 20),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER7, "ovl1_ovl_blender7", "disp", 21),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER8, "ovl1_ovl_blender8", "disp", 22),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_BLENDER9, "ovl1_ovl_blender9", "disp", 23),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_OUTPROC0, "ovl1_ovl_outproc0", "disp", 24),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_OUTPROC1, "ovl1_ovl_outproc1", "disp", 25),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_OUTPROC2, "ovl1_ovl_outproc2", "disp", 26),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_OUTPROC3, "ovl1_ovl_outproc3", "disp", 27),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_OUTPROC4, "ovl1_ovl_outproc4", "disp", 28),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_OUTPROC5, "ovl1_ovl_outproc5", "disp", 29),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_MDP_RSZ0, "ovl1_ovl_mdp_rsz0", "disp", 30),
+	GATE_HWV_OVL10(CLK_OVL1_OVL_MDP_RSZ1, "ovl1_ovl_mdp_rsz1", "disp", 31),
+	/* OVL11 */
+	GATE_HWV_OVL11(CLK_OVL1_OVL_DISP_WDMA0, "ovl1_ovl_disp_wdma0", "disp", 0),
+	GATE_HWV_OVL11(CLK_OVL1_OVL_DISP_WDMA1, "ovl1_ovl_disp_wdma1", "disp", 1),
+	GATE_HWV_OVL11(CLK_OVL1_OVL_UFBC_WDMA0, "ovl1_ovl_ufbc_wdma0", "disp", 2),
+	GATE_HWV_OVL11(CLK_OVL1_OVL_MDP_RDMA0, "ovl1_ovl_mdp_rdma0", "disp", 3),
+	GATE_HWV_OVL11(CLK_OVL1_OVL_MDP_RDMA1, "ovl1_ovl_mdp_rdma1", "disp", 4),
+	GATE_HWV_OVL11(CLK_OVL1_OVL_BWM0, "ovl1_ovl_bwm0", "disp", 5),
+	GATE_HWV_OVL11(CLK_OVL1_DLI0, "ovl1_dli0", "disp", 6),
+	GATE_HWV_OVL11(CLK_OVL1_DLI1, "ovl1_dli1", "disp", 7),
+	GATE_HWV_OVL11(CLK_OVL1_DLI2, "ovl1_dli2", "disp", 8),
+	GATE_HWV_OVL11(CLK_OVL1_DLI3, "ovl1_dli3", "disp", 9),
+	GATE_HWV_OVL11(CLK_OVL1_DLI4, "ovl1_dli4", "disp", 10),
+	GATE_HWV_OVL11(CLK_OVL1_DLI5, "ovl1_dli5", "disp", 11),
+	GATE_HWV_OVL11(CLK_OVL1_DLI6, "ovl1_dli6", "disp", 12),
+	GATE_HWV_OVL11(CLK_OVL1_DLI7, "ovl1_dli7", "disp", 13),
+	GATE_HWV_OVL11(CLK_OVL1_DLI8, "ovl1_dli8", "disp", 14),
+	GATE_HWV_OVL11(CLK_OVL1_DLO0, "ovl1_dlo0", "disp", 15),
+	GATE_HWV_OVL11(CLK_OVL1_DLO1, "ovl1_dlo1", "disp", 16),
+	GATE_HWV_OVL11(CLK_OVL1_DLO2, "ovl1_dlo2", "disp", 17),
+	GATE_HWV_OVL11(CLK_OVL1_DLO3, "ovl1_dlo3", "disp", 18),
+	GATE_HWV_OVL11(CLK_OVL1_DLO4, "ovl1_dlo4", "disp", 19),
+	GATE_HWV_OVL11(CLK_OVL1_DLO5, "ovl1_dlo5", "disp", 20),
+	GATE_HWV_OVL11(CLK_OVL1_DLO6, "ovl1_dlo6", "disp", 21),
+	GATE_HWV_OVL11(CLK_OVL1_DLO7, "ovl1_dlo7", "disp", 22),
+	GATE_HWV_OVL11(CLK_OVL1_DLO8, "ovl1_dlo8", "disp", 23),
+	GATE_HWV_OVL11(CLK_OVL1_DLO9, "ovl1_dlo9", "disp", 24),
+	GATE_HWV_OVL11(CLK_OVL1_DLO10, "ovl1_dlo10", "disp", 25),
+	GATE_HWV_OVL11(CLK_OVL1_DLO11, "ovl1_dlo11", "disp", 26),
+	GATE_HWV_OVL11(CLK_OVL1_DLO12, "ovl1_dlo12", "disp", 27),
+	GATE_HWV_OVL11(CLK_OVL1_OVLSYS_RELAY0, "ovl1_ovlsys_relay0", "disp", 28),
+	GATE_HWV_OVL11(CLK_OVL1_OVL_INLINEROT0, "ovl1_ovl_inlinerot0", "disp", 29),
+	GATE_HWV_OVL11(CLK_OVL1_SMI, "ovl1_smi", "disp", 30),
+};
+
+static const struct mtk_clk_desc ovl1_mcd = {
+	.clks = ovl1_clks,
+	.num_clks = ARRAY_SIZE(ovl1_clks),
+};
+
+static const struct platform_device_id clk_mt8196_ovl1_id_table[] = {
+	{ .name = "clk-mt8196-ovl1", .driver_data = (kernel_ulong_t)&ovl1_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt8196_ovl1_id_table);
+
+static struct platform_driver clk_mt8196_ovl1_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-ovl1",
+	},
+	.id_table = clk_mt8196_ovl1_id_table,
+};
+module_platform_driver(clk_mt8196_ovl1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 ovl1 clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


