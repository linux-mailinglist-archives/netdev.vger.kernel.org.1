Return-Path: <netdev+bounces-218191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EB0B3B714
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77322466DD0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985EF3054D9;
	Fri, 29 Aug 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bj4BY5Jq"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F37303C88;
	Fri, 29 Aug 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459266; cv=none; b=FF05hy+bLSrEL++eANlOLB7O2klVcCgWGqd8/L+lR0GckHDdt/SK9S5oSwcHe0zzxU+h5m2Y8ST71fEO8becGN5Yt+oFSuEsqZs5VfBWLgS/jjdgFB+1z6M8u4mi4+W57dDqMXdVluZquoKNBO/iSZvaIqklAjIdYntK9irAC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459266; c=relaxed/simple;
	bh=MkmPom8GgGjs52Gor5GuOumtcIlh7BGnxS2f/vdVOew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALTfnJ8NSObrniyqCdXNcBUiattk7YZzAxU17D2pxAG7Sr9FthU4akvw0oGkG7EQFiKmwsOFfsHIzli8un5/zk0dAiMjmTkHtaHTiRK3mxcvVv4b25P3bhJIE8Bw9n7MgH7LtyNCO8jLYK1kQevmAn+H+G6ZXuqKszyAcyfdHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bj4BY5Jq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756459256;
	bh=MkmPom8GgGjs52Gor5GuOumtcIlh7BGnxS2f/vdVOew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bj4BY5JqyzMs79JZaf/M+S+fr0GwkigaUIQUWxiw1vejOWxQJE1HcxHJBiBoeiNtT
	 p59jI3hxk1nVq30ulTpyGqO2uVp6pehz6RuW9I9NpWDnr36WoogrxX1uJpAiX4YJJp
	 c+NXGyhsv3vbJeNjXcWo+vTzwpUS/097c6FOqADvvS+DqQRW4OvVQDTORz5SzjASuF
	 RbOtyDcV7N12OzYdBJBXjuaAjk2TPIgVKDwFnQTi4qPzrPmuOOQuTVvnyBmX9Ji29x
	 BU0FTTfUbyebKjkvNzwC2Qc3IB5/a5tao3mZkPWExO6mb0v5aVzsyeYIgdKZKwhLMi
	 8ihnOsy1c1mng==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:f5b1:db54:a11a:c333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 39C0817E1299;
	Fri, 29 Aug 2025 11:20:55 +0200 (CEST)
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
Subject: [PATCH v5 02/27] clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
Date: Fri, 29 Aug 2025 11:18:48 +0200
Message-Id: <20250829091913.131528-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829091913.131528-1-laura.nao@collabora.com>
References: <20250829091913.131528-1-laura.nao@collabora.com>
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
index 49ca25dd5418..d717a120793b 100644
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
@@ -274,6 +281,25 @@ void mtk_pll_unprepare(struct clk_hw *hw)
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
@@ -283,6 +309,16 @@ const struct clk_ops mtk_pll_ops = {
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
@@ -315,6 +351,8 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 	pll->hw.init = &init;
 	pll->data = data;
 
+	pll->fenc_addr = base + data->fenc_sta_ofs;
+
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
 	init.ops = pll_ops;
@@ -337,12 +375,13 @@ struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
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
index c4d06bb11516..c6346c21c784 100644
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


