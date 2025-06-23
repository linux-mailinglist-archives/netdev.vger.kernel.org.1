Return-Path: <netdev+bounces-200215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF9AE3C71
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55427A4598
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7024502D;
	Mon, 23 Jun 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kCUCo9l1"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55231519BC;
	Mon, 23 Jun 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674634; cv=none; b=YlV+DGawVbu1MKAdtu06GEriSOgY+hzPnzcQbJrG7GwJf7CICFmEeKj/l7YFZSaQZ1x3V8jfFhptw9pQbohgMs+0LgNMm3BZq2pLsutF86rH5P9HFZNbv4Uj81f7TEQ1kXtOZ5lmHPDA40yBL7SG5uzTGpwSqSonUbU2AMkSrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674634; c=relaxed/simple;
	bh=HY3hx8TjLRafybj9HhnIIPoxLJ5Qree4c2MTO+3U5YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRTphkomeUA6clvFDYdB9dzqBk3K+3hhVXuHuUS0oSqtOb8R8bEe5vOtBkJiQZ/GRKeGgcpZMwS+dFG0wEBo6T8Jm+itAMEwYzuMEtoOUwAtKbikhQzNHwNMpHnxN5wraT48YDVkPQtsiI+AwP+PqlbvUY/SDRPXocP65w6bAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kCUCo9l1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674631;
	bh=HY3hx8TjLRafybj9HhnIIPoxLJ5Qree4c2MTO+3U5YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCUCo9l1xa/wHioASU7j9+B2pmNoj37DOvIKFbmrC/bcjFN2iBGKLXzyNE5tPt+Bz
	 oHEHp131pf5ndcDxPBO+VfYYyzzC30qk2OoPNZqKlxR1QNiu+GUtFf1MLNiFhQf4gq
	 qBHIa3VKcaHp1T9ncnOrn95/veZMzdrg5BySyqTVyK99puVsNTqy7S3kRdnceDmhlj
	 opXEzA44FvYWAfzOfLRUFOYHz2RqSGVZMKkWr+lE5dZwOpNU5YLRp7X6UJGqLKLHop
	 zqcjGsvQEKtAJhpAqOwZ9Lv2VJZxZWoJJ0rUbANkZcl/tqsbpKt06mBOCczKANF2Bp
	 HQi6GXSkfK8ug==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 56FAC17E156E;
	Mon, 23 Jun 2025 12:30:30 +0200 (CEST)
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
Subject: [PATCH 04/30] clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
Date: Mon, 23 Jun 2025 12:29:14 +0200
Message-Id: <20250623102940.214269-5-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623102940.214269-1-laura.nao@collabora.com>
References: <20250623102940.214269-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On MT8196, some clock controllers use a separate regmap for hardware
voting via set/clear/status registers. Add mtk_clk_get_hwv_regmap() to
retrieve this optional regmap, avoiding duplicated lookup code in 
mtk_clk_register_muxes() and mtk_clk_register_gate().

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 16 ++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index ba1d1c495bc2..19cd27941747 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -685,4 +685,20 @@ void mtk_clk_simple_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
 
+struct regmap *mtk_clk_get_hwv_regmap(struct device_node *node)
+{
+	struct device_node *hwv_node;
+	struct regmap *regmap_hwv;
+
+	hwv_node = of_parse_phandle(node, "mediatek,hardware-voter", 0);
+	if (!hwv_node)
+		return NULL;
+
+	regmap_hwv = device_node_to_regmap(hwv_node);
+	of_node_put(hwv_node);
+
+	return regmap_hwv;
+}
+EXPORT_SYMBOL_GPL(mtk_clk_get_hwv_regmap);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 136a4bc6dbe6..8ed2c9208b1f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -247,5 +247,6 @@ int mtk_clk_pdev_probe(struct platform_device *pdev);
 void mtk_clk_pdev_remove(struct platform_device *pdev);
 int mtk_clk_simple_probe(struct platform_device *pdev);
 void mtk_clk_simple_remove(struct platform_device *pdev);
+struct regmap *mtk_clk_get_hwv_regmap(struct device_node *node);
 
 #endif /* __DRV_CLK_MTK_H */
-- 
2.39.5


