Return-Path: <netdev+bounces-200212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF0AE3C65
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3A81884FA0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9323E226;
	Mon, 23 Jun 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ddO/yesb"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408B23315E;
	Mon, 23 Jun 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674631; cv=none; b=qF3qD7hN+clhKlALm53VL6wg97Ogw+Qu3BuL0Eyy1p7erbyoiGKF+73LciFw072bwOgl6AA1ol46w/42ouCnKGP6UzTst+1oL6Ndr9ppFNhVtFWxLuiMg1S3HLGjw8petVdVp9KfZsPcm/t+73JTaOhBIsHZLitnZaTpHrfn+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674631; c=relaxed/simple;
	bh=wNy7ArrNq1Aj4Z/u6XgdPtfGnfQ0qQj1ihgD7HUsJ/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jN4z9nJJpHusIgrxmUZa26waOmVvxn0I04QEsi91EXr2K438PXM562csBoO0OfqtkwXN5KcD/3eEF37oeiHW8lnqazoFGqNEr5rACRIksNF//0BKTT13kl0K8cbHBY/fOrGUumwccAW5fd0oeBQnfekIjIr7NIAKEZQuB0Gim+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ddO/yesb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674627;
	bh=wNy7ArrNq1Aj4Z/u6XgdPtfGnfQ0qQj1ihgD7HUsJ/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddO/yesbUqWOAYqcVSZUDNJcNczqspnGF6RxG7IZ2A2+bBG7uweNvMM/SnysMwvsh
	 bVcFikKc8i0jm60EBv8Z8xruOkUu5BYzoiYo/vzxemOuaukEhVEGXxMS3Lay6+M9C/
	 kQeAGBSZlveRLsJotJEO8ygpcK/4TzLUW+CudGAyZmDtMoFpFsLj7HOZPMHY+JOIxv
	 QyKpS7oidPCmxr9cO2yT0p5AFpQ5w5kcbFN38fDRtL/JeIzHI0nIZOP4iVcZmhqqUk
	 7ufqsaiGaErFOeWkEZY/5JIkojgBB3PcqaDyJDBFGnSYTG0RcbyAMcTBb12+njCjml
	 Ntw5GdtU1LBig==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 699DD17E0FDB;
	Mon, 23 Jun 2025 12:30:26 +0200 (CEST)
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
Subject: [PATCH 01/30] clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
Date: Mon, 23 Jun 2025 12:29:11 +0200
Message-Id: <20250623102940.214269-2-laura.nao@collabora.com>
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

On MT8196, there are set/clr registers to control a shared PLL enable
register. These are intended to prevent different masters from
manipulating the PLLs independently. Add the corresponding en_set_reg
and en_clr_reg fields to the mtk_pll_data structure.

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


