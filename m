Return-Path: <netdev+bounces-200241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121CAE3CD2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904227A337E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136125DB18;
	Mon, 23 Jun 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EdwuI3RH"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67625D1FE;
	Mon, 23 Jun 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674670; cv=none; b=ZSqGeAUJWEt5tugseEyDe0ni3GpUV5oB2uDOAyPkVynObPd55HwSeBQJrhS79jO/iqOLpbM99hPWipBkZtm7NfDuVfRcb/3h2p6wSqfx1CH8TyBS6BZk6gGbLmmwPjo+Ghw5OXJ3NPo2x9Jy8sMD9sRbHRTPRUTYee08+IHRrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674670; c=relaxed/simple;
	bh=dJ5sI20tp1diFS6ne8k9ATvo0R0aRFweq4g1hPQN7tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HM8o9Cxq/G5Eg9H8g16sXsNKVQ/fHoBxLJrCtF4Qd1/8QjMAQmtjJR1lto5LXANt76q+iZijXk9GEtup4M1cN52zF+vPgRqvOaQkHQUe4tmRG5ZxacH0y08qEvGoTMYCwKiIiZsmgpbQSLg9XfaUYWYXbNRz/P4fIhCrIXWMtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EdwuI3RH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674667;
	bh=dJ5sI20tp1diFS6ne8k9ATvo0R0aRFweq4g1hPQN7tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdwuI3RHPSaWXVGlwOKWMiXklZfBngTs/iIh/+CMyUWzLjO7WZpnWLgcFAA4VcxfP
	 pGqrXE3EEq2sfPyp9BMMA8LQZv8KY5rqFIRl6GYnv1u4ftDIkROpmdgUJVl3JR3nIN
	 7NCZCqor4k7gsTSLN4CdCoB7vT5Yi4SROa2wD4pqouD3KobSyJq0CC5YCcZ1ZtdBLI
	 /k5ABruNxpzvy7euyBpvWjIEKP09qaNkhb64zveXU+hYPhZY5V6ExRD8HHrVPV1ACA
	 ZB1Dco7EecSLEuPgl6FZfNy/M638hR4lU18u8N/D1hQIAB27iYWEsilH8GhMvxAl4w
	 gOlsmGWsuym4g==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EAD1417E0FDB;
	Mon, 23 Jun 2025 12:31:05 +0200 (CEST)
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
Subject: [PATCH 30/30] clk: mediatek: mt8196: Add UFS and PEXTP0/1 reset controllers
Date: Mon, 23 Jun 2025 12:29:40 +0200
Message-Id: <20250623102940.214269-31-laura.nao@collabora.com>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add definitions to register the reset controllers found in the
UFS and PEXTP clock controllers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-mt8196-pextp.c  | 36 ++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c | 25 ++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8196-pextp.c b/drivers/clk/mediatek/clk-mt8196-pextp.c
index 938100e4836b..9a7623bf2b1c 100644
--- a/drivers/clk/mediatek/clk-mt8196-pextp.c
+++ b/drivers/clk/mediatek/clk-mt8196-pextp.c
@@ -6,6 +6,7 @@
  *                    Laura Nao <laura.nao@collabora.com>
  */
 #include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <dt-bindings/reset/mediatek,mt8196-resets.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -13,6 +14,9 @@
 
 #include "clk-gate.h"
 #include "clk-mtk.h"
+#include "reset.h"
+
+#define MT8196_PEXTP_RST0_SET_OFFSET	0x8
 
 static const struct mtk_gate_regs pext_cg_regs = {
 	.set_ofs = 0x18,
@@ -41,9 +45,25 @@ static const struct mtk_gate pext_clks[] = {
 	GATE_PEXT(CLK_PEXT_PEXTP_VLP_AO_P0_LP, "pext_pextp_vlp_ao_p0_lp", "clk26m", 19),
 };
 
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
 static const struct mtk_clk_desc pext_mcd = {
 	.clks = pext_clks,
 	.num_clks = ARRAY_SIZE(pext_clks),
+	.rst_desc = &pext_rst_desc,
 };
 
 static const struct mtk_gate pext1_clks[] = {
@@ -69,9 +89,25 @@ static const struct mtk_gate pext1_clks[] = {
 	GATE_PEXT(CLK_PEXT1_PEXTP_VLP_AO_P2_LP, "pext1_pextp_vlp_ao_p2_lp", "clk26m", 27),
 };
 
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
 static const struct mtk_clk_desc pext1_mcd = {
 	.clks = pext1_clks,
 	.num_clks = ARRAY_SIZE(pext1_clks),
+	.rst_desc = &pext1_rst_desc,
 };
 
 static const struct of_device_id of_match_clk_mt8196_pextp[] = {
diff --git a/drivers/clk/mediatek/clk-mt8196-ufs_ao.c b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
index 49f4f4af7f41..858706b3ba6f 100644
--- a/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
+++ b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
@@ -6,6 +6,7 @@
  *                    Laura Nao <laura.nao@collabora.com>
  */
 #include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <dt-bindings/reset/mediatek,mt8196-resets.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -14,6 +15,9 @@
 #include "clk-gate.h"
 #include "clk-mtk.h"
 
+#define MT8196_UFSAO_RST0_SET_OFFSET	0x48
+#define MT8196_UFSAO_RST1_SET_OFFSET	0x148
+
 static const struct mtk_gate_regs ufsao0_cg_regs = {
 	.set_ofs = 0x108,
 	.clr_ofs = 0x10c,
@@ -59,9 +63,30 @@ static const struct mtk_gate ufsao_clks[] = {
 	GATE_UFSAO1(CLK_UFSAO_PHY_SAP, "ufsao_phy_sap", "clk26m", 8),
 };
 
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
 static const struct mtk_clk_desc ufsao_mcd = {
 	.clks = ufsao_clks,
 	.num_clks = ARRAY_SIZE(ufsao_clks),
+	.rst_desc = &ufsao_rst_desc,
 };
 
 static const struct of_device_id of_match_clk_mt8196_ufs_ao[] = {
-- 
2.39.5


