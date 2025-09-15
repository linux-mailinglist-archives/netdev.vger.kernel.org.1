Return-Path: <netdev+bounces-223124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8152B5804C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52AF482796
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDAE30E0F2;
	Mon, 15 Sep 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aB/J7RWG"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25276312804;
	Mon, 15 Sep 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949690; cv=none; b=GhhkWG4SEB8WkD80bgQzmFeON6jdwN9ekwU4Hop8XhexbIhUdCYf1GYGm6qwNnqJVnHU7yITmJh9E4jhQd3r/12IE9tVB9NrdEwF33Y0692MLBlQvPY9159ZdUjhHczQlJ5YCMtLsyENbmlmZVchYsMTmJTHzVq7FOcMSgH1Y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949690; c=relaxed/simple;
	bh=ORVfgV7JCaC2aOtk08NoUH6wMTnh3QzlvhsZptAU/jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8pqlgFeEGD5IT9JEMBF9CIujuWX1pvUvv3LZrjA1arZEVSQTuuX4YTLqp5W/8dhNWIL/SwQsem2hy+nhbFfHJhfA+FKg/qvcu2NqzWnax0AyB9e0f1BaIw5fQUyJ2uMi5UiUqot9jjgkLrD5L5EIWkZjWkIXmLos3BhU8izH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aB/J7RWG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949686;
	bh=ORVfgV7JCaC2aOtk08NoUH6wMTnh3QzlvhsZptAU/jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aB/J7RWGCmlG2rHPfvOknTpDxv/4c1yDwByRSyjNFzJrZcqbYIk+zMHWYS1o1mYgy
	 Qu+UvCSsg934GiLU6le95/NER/XASMkG4rgx5dYn9Ys+bg2l5IOhwg6MuuluEsJ81n
	 DXzP1UJbIZ+turCmgC+tP30Y6T4KklVtM7j03wCnZ6S36A4vr8OHiHaq3HkU57XLEF
	 NOUeBHAxUThNYNZtcj5aOAmSy7uDmrZ0ZYyGfWS0YY/r0QPPg4XVuavQ5bMZXSC+1s
	 2vNM+MbBGPqOuqhP5E9kCFtXW1Y6jKib2opVhqvL74nrK6qnpVJwMgMin9UpHyevL0
	 OwrP8JL03lxBA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 844E417E132A;
	Mon, 15 Sep 2025 17:21:25 +0200 (CEST)
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
Subject: [PATCH v6 02/27] clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
Date: Mon, 15 Sep 2025 17:19:22 +0200
Message-Id: <20250915151947.277983-3-laura.nao@collabora.com>
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

MT8196 uses a combination of set/clr registers to control the PLL
enable state, along with a FENC bit to check the preparation status.
Add new set of PLL clock operations with support for set/clr enable and
FENC status logic.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 41 +++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-pll.h |  4 ++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 738524bfd8d2..51d14ce147e5 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -37,6 +37,13 @@ int mtk_pll_is_prepared(struct clk_hw *hw)
 	return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
 }
 
+static int mtk_pll_fenc_is_prepared(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	return !!(readl(pll->fenc_addr) & BIT(pll->data->fenc_sta_bit));
+}
+
 static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 		u32 pcw, int postdiv)
 {
@@ -277,6 +284,25 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 	writel(r, pll->pwr_addr);
 }
 
+static int mtk_pll_prepare_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	writel(BIT(pll->data->pll_en_bit), pll->en_set_addr);
+
+	/* Wait 20us after enable for the PLL to stabilize */
+	udelay(20);
+
+	return 0;
+}
+
+static void mtk_pll_unprepare_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	writel(BIT(pll->data->pll_en_bit), pll->en_clr_addr);
+}
+
 const struct clk_ops mtk_pll_ops = {
 	.is_prepared	= mtk_pll_is_prepared,
 	.prepare	= mtk_pll_prepare,
@@ -286,6 +312,16 @@ const struct clk_ops mtk_pll_ops = {
 	.set_rate	= mtk_pll_set_rate,
 };
 
+const struct clk_ops mtk_pll_fenc_clr_set_ops = {
+	.is_prepared	= mtk_pll_fenc_is_prepared,
+	.prepare	= mtk_pll_prepare_setclr,
+	.unprepare	= mtk_pll_unprepare_setclr,
+	.recalc_rate	= mtk_pll_recalc_rate,
+	.round_rate	= mtk_pll_round_rate,
+	.set_rate	= mtk_pll_set_rate,
+};
+EXPORT_SYMBOL_GPL(mtk_pll_fenc_clr_set_ops);
+
 struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 					const struct mtk_pll_data *data,
 					void __iomem *base,
@@ -318,6 +354,8 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 	pll->hw.init = &init;
 	pll->data = data;
 
+	pll->fenc_addr = base + data->fenc_sta_ofs;
+
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
 	init.ops = pll_ops;
@@ -340,12 +378,13 @@ struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 {
 	struct mtk_clk_pll *pll;
 	struct clk_hw *hw;
+	const struct clk_ops *pll_ops = data->ops ? data->ops : &mtk_pll_ops;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
+	hw = mtk_clk_register_pll_ops(pll, data, base, pll_ops);
 	if (IS_ERR(hw))
 		kfree(pll);
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index a795d4dfe056..d71c150ce83e 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -29,6 +29,7 @@ struct mtk_pll_data {
 	u32 reg;
 	u32 pwr_reg;
 	u32 en_mask;
+	u32 fenc_sta_ofs;
 	u32 pd_reg;
 	u32 tuner_reg;
 	u32 tuner_en_reg;
@@ -51,6 +52,7 @@ struct mtk_pll_data {
 	u32 en_clr_reg;
 	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 	u8 pcw_chg_bit;
+	u8 fenc_sta_bit;
 };
 
 /*
@@ -72,6 +74,7 @@ struct mtk_clk_pll {
 	void __iomem	*en_addr;
 	void __iomem	*en_set_addr;
 	void __iomem	*en_clr_addr;
+	void __iomem	*fenc_addr;
 	const struct mtk_pll_data *data;
 };
 
@@ -82,6 +85,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 			     struct clk_hw_onecell_data *clk_data);
 
 extern const struct clk_ops mtk_pll_ops;
+extern const struct clk_ops mtk_pll_fenc_clr_set_ops;
 
 static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
 {
-- 
2.39.5


