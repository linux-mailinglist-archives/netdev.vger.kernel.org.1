Return-Path: <netdev+bounces-223145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A67B580A1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4744C4800
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52736CC99;
	Mon, 15 Sep 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZyjSCYaD"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A536998A;
	Mon, 15 Sep 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949714; cv=none; b=jr4AMFDIlHms2LzpRqRCGHqW2qIHoD9T+o2u9uVlIYm1OhMgwuRKv6cEQcarn8DLWPGlWn2bhckc50whcfVnDDt8V8XzFyHpIVaZP3A0JWlS33MgHcF6kg7ch0JU29aSwzAlJ8tZTrvKUqF17NFMp+OR9sfaAPR7J3FmI9NdSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949714; c=relaxed/simple;
	bh=Ta4yuU5gjRUdHQ3T2GeTOnPa02+SvwvlZNIgEM1zQZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWzGbwcUxiqoab78x3GJXNK8JH3NgCl0lhgEjXgvYXh7ie+KnWYETntBAH9J7MgJ5kqAov18BBO7T45n5nXP5hf7gPxhcSS5wxEna44+W8M9UEoxMHKbQEnOh7JFzXWhqS1iTxMpVXh7jjT/NGZMo9eQ6eHLPkKredI9SetPZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZyjSCYaD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949710;
	bh=Ta4yuU5gjRUdHQ3T2GeTOnPa02+SvwvlZNIgEM1zQZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyjSCYaD4C1tjgym5w/PDKvU/wGSqQdjOQu1Uqm7hCmByqhm1ynsvCom+eb0k0RU8
	 BL3yDLT+HWtY2Et4CjW3ucSAz2/e886+x3MxMB+gDK7n0MaXQdNdSZ7t+TgdxcpolL
	 uDvEI+A0GxOgk3dz8p2CB4DcXxz+Vbo03iukdfIJLzM2vZbwzcS4GeyZPv+fYd40AH
	 CmcHvQJrPCNSa4CH4ix6vZ+9lz7VVjNcmC5zMiTzM98m/BYjJquxWpAr1qrQ5FLnJA
	 VzcHDrWFKigs8tu98FgHLVGxpOT5HJquwtqYMHHGYGqwtIwDM0IfFy1FYN24WsGoMQ
	 n8yWguez3BONA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C41A17E046C;
	Mon, 15 Sep 2025 17:21:49 +0200 (CEST)
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
Subject: [PATCH v6 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Date: Mon, 15 Sep 2025 17:19:43 +0200
Message-Id: <20250915151947.277983-24-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915151947.277983-1-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com>
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
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c | 80 ++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index fe5699411d8b..5b8969ff1985 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -157,7 +157,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
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
index 000000000000..fddb69d1c3eb
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
@@ -0,0 +1,80 @@
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


