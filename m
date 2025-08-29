Return-Path: <netdev+bounces-218193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905BB3B729
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA53BA420
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638C3081A8;
	Fri, 29 Aug 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hAB7WQ9Q"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9730505D;
	Fri, 29 Aug 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459267; cv=none; b=iC/aCEBo4BTNWMIQV79Gv82ZeMbLm93igt7koBaMcjR3sXE+UW70DW3W5VN6CTVJ5/j7eDqOsiDUAAGTAsB5Wwgh9+dVui6sDSc8byXxForr93wvtzzC4ZX7QqoEycFesHJXzGAHEjE54gyeYpTFzl6Eg2r50/Pn98zbKlW5wPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459267; c=relaxed/simple;
	bh=VoNHArVKJHheM4m4+fk2gAoKWZNKxoMFzo/aP2dZ4Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWBj6pbASooHdoTAUTV+LRVg0oi6zavXoJi45RSj61JKquhmALVKwg1imPn+CGCTulLuf4uGj60bXcawBjn11eTzoKXtHG9vzNE2Xr3SA17/3qlwMXNZpQCt5+AgJnWCk6xzPU9JKntS5kjblfZnhjzM5Z+mlY7FmKmyLoEk158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hAB7WQ9Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756459261;
	bh=VoNHArVKJHheM4m4+fk2gAoKWZNKxoMFzo/aP2dZ4Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAB7WQ9QTcKcwy/boi3CqsVaRlsvkWzyXbdfUSZkv/GEGBoS0KePZfU4ieiBJlIfk
	 QGTaqIkypc7FcQrrfJuI2Z1dIiFPEYCL1FGDdH4yXdjN4XOXbYbNWpx+tX6cfQ1AbA
	 ok7MjOsMQwxhPGMRGxO8+30M1s86Pr3vzZ2oeWvWMwkjvQuLUVNnm3oso7h7D++2cu
	 UqDCBNMZpngOc4xvQlPGvR55TYlFh045a2UoriKJ/OPKkfZ0NrgC1+f8/3onVbzNai
	 jSelPZajCGfLaKvtUlVoh+rX6rQA/OKkyXYiNFk/GYfDdtNEAhXiaELRFsiErR+tSw
	 d3V7TD9p4MsnQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:f5b1:db54:a11a:c333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C80D417E12BC;
	Fri, 29 Aug 2025 11:21:00 +0200 (CEST)
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
Subject: [PATCH v5 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
Date: Fri, 29 Aug 2025 11:18:52 +0200
Message-Id: <20250829091913.131528-7-laura.nao@collabora.com>
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

MT8196 uses a HW voter for gate enable/disable control, with
set/clr/sta registers located in a separate regmap. Refactor
mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
it in struct mtk_clk_gate. This allows reuse of the static gate data
(including HW voter register offsets) without adding extra function
arguments, and removes redundant duplication in the runtime data struct.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 52 ++++++++++++---------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 67d9e741c5e7..816e5f2d4079 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -17,10 +17,7 @@
 struct mtk_clk_gate {
 	struct clk_hw	hw;
 	struct regmap	*regmap;
-	int		set_ofs;
-	int		clr_ofs;
-	int		sta_ofs;
-	u8		bit;
+	const struct mtk_gate *gate;
 };
 
 static inline struct mtk_clk_gate *to_mtk_clk_gate(struct clk_hw *hw)
@@ -33,9 +30,9 @@ static u32 mtk_get_clockgating(struct clk_hw *hw)
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
 	u32 val;
 
-	regmap_read(cg->regmap, cg->sta_ofs, &val);
+	regmap_read(cg->regmap, cg->gate->regs->sta_ofs, &val);
 
-	return val & BIT(cg->bit);
+	return val & BIT(cg->gate->shift);
 }
 
 static int mtk_cg_bit_is_cleared(struct clk_hw *hw)
@@ -52,28 +49,30 @@ static void mtk_cg_set_bit(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
 
-	regmap_write(cg->regmap, cg->set_ofs, BIT(cg->bit));
+	regmap_write(cg->regmap, cg->gate->regs->set_ofs, BIT(cg->gate->shift));
 }
 
 static void mtk_cg_clr_bit(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
 
-	regmap_write(cg->regmap, cg->clr_ofs, BIT(cg->bit));
+	regmap_write(cg->regmap, cg->gate->regs->clr_ofs, BIT(cg->gate->shift));
 }
 
 static void mtk_cg_set_bit_no_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
 
-	regmap_set_bits(cg->regmap, cg->sta_ofs, BIT(cg->bit));
+	regmap_set_bits(cg->regmap, cg->gate->regs->sta_ofs,
+			BIT(cg->gate->shift));
 }
 
 static void mtk_cg_clr_bit_no_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
 
-	regmap_clear_bits(cg->regmap, cg->sta_ofs, BIT(cg->bit));
+	regmap_clear_bits(cg->regmap, cg->gate->regs->sta_ofs,
+			  BIT(cg->gate->shift));
 }
 
 static int mtk_cg_enable(struct clk_hw *hw)
@@ -152,12 +151,9 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
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
@@ -167,18 +163,14 @@ static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name
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
-
+	cg->gate = gate;
 	cg->hw.init = &init;
 
 	ret = clk_hw_register(dev, &cg->hw);
@@ -228,13 +220,7 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
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


