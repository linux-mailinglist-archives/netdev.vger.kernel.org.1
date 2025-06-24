Return-Path: <netdev+bounces-200705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08973AE692F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7523A168715
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC42DFA37;
	Tue, 24 Jun 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R7CgJfUW"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B42DCC06;
	Tue, 24 Jun 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775622; cv=none; b=RidT46qK8OH+L/qAS6K2tbu3ys/qlKozT6GCkJG5EuUUBroX0Jn77v8LomiaLS2l/iHfV/UH/+Tbpt/bg/EbKIS7f6Oa3bLrmfhnRGDBBIhvXF24/k45S4QcoRMkmMFg2tQaFdrnQkj/wpSBogYuN4Gnt84yTegg+mP8GwSlqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775622; c=relaxed/simple;
	bh=klP6Z1aV1eyxlTcl3AKzPnOACsLqgTD3I16ktsRtqv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dC5CcnyLmjCgKVXKInL317Y/Pg5V7auUvO8E8O2G9CkVk9cWcZI1jhIo8s8epb8+vwFg8QhpjPLttV4e10t6r+t2HkFaBnsDK+/D1ujBI/f1VcdsPBytYmGkdftZhWC/tby0bYzYJOlXDM0B1OvKTShxdz8YF1vjCMkDpAUC33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R7CgJfUW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775619;
	bh=klP6Z1aV1eyxlTcl3AKzPnOACsLqgTD3I16ktsRtqv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7CgJfUWV1SGdMfq+tI+tK3LmI0W+6vKN2T81rBSq9j5kDV0Jy+RIylAolIHE/D+A
	 jw1WVY4albHhDA3Tq0GNFBGmgMs9ieMvmP5WNxcJzlgR2+U9QGABUd9M+Uczgunotj
	 QEszEOCFfObucTJvngaPtxS4aTskxRWQB9apZpahAn3ySe0osgU6FNAyHUsvNbA4Hf
	 Jx0UtKGGABgbKLiRunSkixrB+BWaBdWBgb8KizIvoA2dvPK8bC4b40J0iKZWRPWQI1
	 HywX03FTIlv8PVylAP/hnbLqiubl/KUCYpH0khkilWYdyI7uNO/2D19Sy88HxycUsx
	 37nKJTNrrm6/w==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0172117E0EA4;
	Tue, 24 Jun 2025 16:33:37 +0200 (CEST)
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
Subject: [PATCH v2 06/29] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
Date: Tue, 24 Jun 2025 16:31:57 +0200
Message-Id: <20250624143220.244549-7-laura.nao@collabora.com>
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

MT8196 uses a HW voter for gate enable/disable control, with
set/clr/sta registers located in a separate regmap. Refactor
mtk_clk_register_gate() to take a struct mtk_gate instead of individual
parameters, avoiding the need to add three extra arguments to support
HW voter register offsets.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 35 ++++++++++++---------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 67d9e741c5e7..0375ccad4be3 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -152,12 +152,9 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
-static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name,
-					 const char *parent_name,
-					 struct regmap *regmap, int set_ofs,
-					 int clr_ofs, int sta_ofs, u8 bit,
-					 const struct clk_ops *ops,
-					 unsigned long flags)
+static struct clk_hw *mtk_clk_register_gate(struct device *dev,
+						const struct mtk_gate *gate,
+						struct regmap *regmap)
 {
 	struct mtk_clk_gate *cg;
 	int ret;
@@ -167,17 +164,17 @@ static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name
 	if (!cg)
 		return ERR_PTR(-ENOMEM);
 
-	init.name = name;
-	init.flags = flags | CLK_SET_RATE_PARENT;
-	init.parent_names = parent_name ? &parent_name : NULL;
-	init.num_parents = parent_name ? 1 : 0;
-	init.ops = ops;
+	init.name = gate->name;
+	init.flags = gate->flags | CLK_SET_RATE_PARENT;
+	init.parent_names = gate->parent_name ? &gate->parent_name : NULL;
+	init.num_parents = gate->parent_name ? 1 : 0;
+	init.ops = gate->ops;
 
 	cg->regmap = regmap;
-	cg->set_ofs = set_ofs;
-	cg->clr_ofs = clr_ofs;
-	cg->sta_ofs = sta_ofs;
-	cg->bit = bit;
+	cg->set_ofs = gate->regs->set_ofs;
+	cg->clr_ofs = gate->regs->clr_ofs;
+	cg->sta_ofs = gate->regs->sta_ofs;
+	cg->bit = gate->shift;
 
 	cg->hw.init = &init;
 
@@ -228,13 +225,7 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 			continue;
 		}
 
-		hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
-					    regmap,
-					    gate->regs->set_ofs,
-					    gate->regs->clr_ofs,
-					    gate->regs->sta_ofs,
-					    gate->shift, gate->ops,
-					    gate->flags);
+		hw = mtk_clk_register_gate(dev, gate, regmap);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name,
-- 
2.39.5


