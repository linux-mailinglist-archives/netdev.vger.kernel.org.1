Return-Path: <netdev+bounces-223123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C956B5804A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B669E168686
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0EA32F770;
	Mon, 15 Sep 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mrEt3/iJ"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC2279346;
	Mon, 15 Sep 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949688; cv=none; b=Eh87JYvx2BqoBcUhVdK5JYE2VwxiEuH57Ndm8NclR2uwhiHaqw60VygtDcJ8l1ZR/SWhEVzKBjiesf2I9kfCpobso6/SCMA1xZsyHwhAtw28apR8wMQvGZeZPGgfbrwWNuI9C7WtQi1ebuv1aeQKhMp3foT6Ec/FYdDZ3MPoWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949688; c=relaxed/simple;
	bh=/7sqPcbtCd8jm02oZTng8epEpSVEFjyxzlb4qFilT30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCfuOZBOrGPtOR7V1uiJmKhyLlDnETbBpYYbMnFmoTT4pAaJyjHrUnGX8CjSIWwknuFSIqkA5ULorAe1HlA3ffa2tSIWmyZCWYMTmta9gEwqLlhzv+ZT2T3vJsiYoqkk0TR10v4Ix+7lYY/cUjKUhVhetROj3hvaEeBI+0Wn0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mrEt3/iJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949685;
	bh=/7sqPcbtCd8jm02oZTng8epEpSVEFjyxzlb4qFilT30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrEt3/iJpQHhlPI3b65lkh5ATvbE02aXV0UsVmz/bNKwcRxBN/tOTOGX8TIrmOYrK
	 LKWNcZIQKfaJ0PAxHu8zoE+gVQ7KPMR9vwJw5kwA0J3eiH/P0FtM4mYSjUNaYK9FZT
	 GSZ5KglMVoQHOGDUyC0B0Yz1pRxESTOfJJvEPAX+YBFcY1AoYwF69oX5+PAYUKcpM0
	 ZV478IUQWeMEkmLFpDXpn3wpRY622WUw9H+tDPVupAcqiZIZn/BZqVfHksi3GYP3zv
	 JnUzg95NGrIOMU6DSH6Z23NtOaWx7LALN7axH2ifSKfSqi/FPNB2N+2ByPjDA9NstT
	 FOAL7HUn2whkw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F27A17E090D;
	Mon, 15 Sep 2025 17:21:24 +0200 (CEST)
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
Subject: [PATCH v6 01/27] clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
Date: Mon, 15 Sep 2025 17:19:21 +0200
Message-Id: <20250915151947.277983-2-laura.nao@collabora.com>
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

On MT8196, there are set/clr registers to control a shared PLL enable
register. These are intended to prevent different masters from
manipulating the PLLs independently. Add the corresponding en_set_reg
and en_clr_reg fields to the mtk_pll_data structure.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 4 ++++
 drivers/clk/mediatek/clk-pll.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 139d3bfcf45f..738524bfd8d2 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -311,6 +311,10 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
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
index 670fa2e9b898..a795d4dfe056 100644
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


