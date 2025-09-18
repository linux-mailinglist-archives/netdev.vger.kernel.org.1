Return-Path: <netdev+bounces-210971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD70B15EE9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34543B86DC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CFA2C325F;
	Wed, 30 Jul 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B+cuBrzT"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B22C1593;
	Wed, 30 Jul 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873121; cv=none; b=ZuDj+733oIutKeNYOct5lY30thR3yJTFcR3DPsdbXUTE+Ci2v5IE76lS2GdsIyOwoFO7yYlIRdnE7vbkYftBb77XgXsudpipaM58eD0WMKdnJbCYXRj4UZ8dkJ66XXE81iF3PUBFJEsRilsItggleD3/QawlJR1MGDqnLmBDxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873121; c=relaxed/simple;
	bh=ZK94npaF3Ue2iNgsO2VA2hWNWGA52KEIw4vwhkwb63U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVzhaP9zVibVHRWbUeLoGm19KSx58mByYcM08l65AzSyrp546HdCj8+dD41U4BebmmnEtmHSmfRq4hp3mFN0J7L4PyGhws+rmu59OkoLvtz3zbKYFp3F0UXFTGbVjdOfwbdWLBVnyWV9hoiw59OgYC+ADg/Zvlu0GEd7sBWcpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B+cuBrzT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873118;
	bh=ZK94npaF3Ue2iNgsO2VA2hWNWGA52KEIw4vwhkwb63U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+cuBrzTiw86sSiK2YOI5ZlSw5kI3Tb4AwT0+tQYbEzug84YYrZqGc5Mxp324E8e4
	 ZdilverbZLibA+TdB1+oKI0qduGhBK5NTNETgxVdrMgDwxmYfglC08tqQKI8ThOnyl
	 0XaLBUAhewIOWjhdGylLbaibujh7WWKRvAXY1C3n+5nNHGcfFG8Id2rhXOzhu9UriA
	 Oe7lGnk7q/PIawhYYld3tMvjUuqOcJoeZyKq7hw4VAOTgysLhBSco+EVyuT6bminWj
	 xP8NUVUyGkv1kW9hDJf+QKxkp47FDH+ceOHUSSgis+vnuyBfKEL8woBIid7Z7LtmTN
	 HP5fcAbJ1qn3w==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DCD0017E1511;
	Wed, 30 Jul 2025 12:58:36 +0200 (CEST)
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
Subject: [PATCH v3 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Date: Wed, 30 Jul 2025 12:56:49 +0200
Message-Id: <20250730105653.64910-24-laura.nao@collabora.com>
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

Add support for the MT8196 disp-ao clock controller, which provides
clock gate control for the display system. It is integrated with the
mtk-mmsys driver, which registers the disp-ao clock driver via
platform_device_register_data().

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Makefile              |  2 +-
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c | 79 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 195a473efb6c..4318b6dd4085 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -167,7 +167,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
-obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o clk-mt8196-vdisp_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
diff --git a/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
new file mode 100644
index 000000000000..b4708f34ccdb
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
@@ -0,0 +1,79 @@
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
+static const struct mtk_gate_regs mm_v_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm_v_hwv_regs = {
+	.set_ofs = 0x0030,
+	.clr_ofs = 0x0034,
+	.sta_ofs = 0x2c18,
+};
+
+#define GATE_MM_AO_V(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm_v_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IS_CRITICAL,		\
+	}
+
+#define GATE_HWV_MM_V(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm_v_cg_regs,			\
+		.hwv_regs = &mm_v_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mm_v_clks[] = {
+	GATE_HWV_MM_V(CLK_MM_V_DISP_VDISP_AO_CONFIG, "mm_v_disp_vdisp_ao_config", "disp", 0),
+	GATE_HWV_MM_V(CLK_MM_V_DISP_DPC, "mm_v_disp_dpc", "disp", 16),
+	GATE_MM_AO_V(CLK_MM_V_SMI_SUB_SOMM0, "mm_v_smi_sub_somm0", "disp", 2),
+};
+
+static const struct mtk_clk_desc mm_v_mcd = {
+	.clks = mm_v_clks,
+	.num_clks = ARRAY_SIZE(mm_v_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8196_vdisp_ao[] = {
+	{ .compatible = "mediatek,mt8196-vdisp-ao", .data = &mm_v_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vdisp_ao);
+
+static struct platform_driver clk_mt8196_vdisp_ao_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-vdisp-ao",
+		.of_match_table = of_match_clk_mt8196_vdisp_ao,
+	},
+};
+module_platform_driver(clk_mt8196_vdisp_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 vdisp_ao clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


