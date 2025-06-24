Return-Path: <netdev+bounces-200700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5079AE68E2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0A37B378C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC122D5C79;
	Tue, 24 Jun 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gW8at1hc"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB62D4B54;
	Tue, 24 Jun 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775617; cv=none; b=gVVP0laejxk7qiR6yIJwKVPBhKFEm3M0hrojrVlw45vZCEp6S/2ckoFtUznfbjiylVvwABCPArK4MGOTTTTTH11aucCfP5umg89XdSDiiOyqSXFToINj5/bWUJgX/dm3Syd01e4w7+MNCmfXyMZLSXp7bsDdQtWatVStqQZ5StI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775617; c=relaxed/simple;
	bh=Uflxb8D7XG3tp2VzLTr16pJYzl9EZeSkDxvJ5OFSD48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGGbFJ3Z0tZnPYyyVDqyY5S5d4wgWRyYSE79Pk+HfeUITlhxetN3pkhqrYGwdisF+JEaDfhzNOFVcYrhb+JP4/uvmFlyNtboqAEoV2zBGFib7DgBTFrge0CSLqlLm9/q/Ea9L9dXLzSU0ywgdFK4KEw+5mUgTDCmqHKs2+rjJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gW8at1hc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775612;
	bh=Uflxb8D7XG3tp2VzLTr16pJYzl9EZeSkDxvJ5OFSD48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gW8at1hcc7qF7nCwvCyqla1GgD7BA9eAwvkoP3MI1RrtouTuFpqmRzp1VoBITH3Yq
	 Fo4lC1A5jT6wcgtRAZ7Sw7HburosHEqnjeEZZUrOpw1pblYRmnyM+O+pjalyg3Ek8K
	 O9GrcLal1tosgR/TrbGrcWhRVitdZliWMqAFsdMH5aplevrI3yTjJEr7PdmUI/rApX
	 dXZ8tzjluJsozaC2Id38Qx1b6KeIN8hzyEVeJIqn491URczBpG6lQgS+0b6occW++4
	 DLtgEhYFWAVu/J6cHZ9ecBzqnhHcZJRYJH1l6nS2w56qJoMGKdwQf8Mx8L0e907+7a
	 OLCierGsgexBw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B5B4B17E0EA4;
	Tue, 24 Jun 2025 16:33:31 +0200 (CEST)
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
Subject: [PATCH v2 01/29] clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
Date: Tue, 24 Jun 2025 16:31:52 +0200
Message-Id: <20250624143220.244549-2-laura.nao@collabora.com>
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

On MT8196, there are set/clr registers to control a shared PLL enable
register. These are intended to prevent different masters from
manipulating the PLLs independently. Add the corresponding en_set_reg
and en_clr_reg fields to the mtk_pll_data structure.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 4 ++++
 drivers/clk/mediatek/clk-pll.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index ce453e1718e5..49ca25dd5418 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -308,6 +308,10 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 		pll->en_addr = base + data->en_reg;
 	else
 		pll->en_addr = pll->base_addr + REG_CON0;
+	if (data->en_set_reg)
+		pll->en_set_addr = base + data->en_set_reg;
+	if (data->en_clr_reg)
+		pll->en_clr_addr = base + data->en_clr_reg;
 	pll->hw.init = &init;
 	pll->data = data;
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index 285c8db958b3..c4d06bb11516 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -47,6 +47,8 @@ struct mtk_pll_data {
 	const struct mtk_pll_div_table *div_table;
 	const char *parent_name;
 	u32 en_reg;
+	u32 en_set_reg;
+	u32 en_clr_reg;
 	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 	u8 pcw_chg_bit;
 };
@@ -68,6 +70,8 @@ struct mtk_clk_pll {
 	void __iomem	*pcw_addr;
 	void __iomem	*pcw_chg_addr;
 	void __iomem	*en_addr;
+	void __iomem	*en_set_addr;
+	void __iomem	*en_clr_addr;
 	const struct mtk_pll_data *data;
 };
 
-- 
2.39.5


