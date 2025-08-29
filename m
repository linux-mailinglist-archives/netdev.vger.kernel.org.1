Return-Path: <netdev+bounces-218196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118D6B3B723
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75AD171319
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D43090C4;
	Fri, 29 Aug 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="meAcL0Zh"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A23054CE;
	Fri, 29 Aug 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459268; cv=none; b=bpCi2hQDwcGWjtHCxw9XqCU9ddAe6IKaojg+lga+CqyBRx2MyTWO99ZQKZ2CNc0/ja2qh5wIaYS0P1CU0IvIkIdOH65eruEzYElN+gOLp/c78J25PtG7xL4OZdk443pYRCJxp2TUXiJwgE/yXNa8Zkyymh6mPz0KeMJfm1QGcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459268; c=relaxed/simple;
	bh=y/P+FPCXH4aX8jtnTkUBgDHbGcECOoCrXxvz0EPV99Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1r6hNGv06DoMsxtytwHh7y/p3T8pxvFkZ83cmilP/q+D+sMFypxQNIR4zDGRf8r+qWRRF3A7bS/lpZt7KKJPxQ7bD8r08Lt4vKzkTZWgPV93NVW+iuB73dYqnj3p8Ct8/uCWGbAL33okZcX1V89AFskpclnGT0xmQq5VHhWgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=meAcL0Zh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756459259;
	bh=y/P+FPCXH4aX8jtnTkUBgDHbGcECOoCrXxvz0EPV99Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meAcL0ZhwrR3MaUlpszpdIIDIg/d7+db9v7KD0FlU2ET/FxLCQZfLHNcQklJnDoi9
	 LNG+2m2pmHURGmE+R3zZYcWMjYboCxYm6xg2NMnhjFlX54zyymIrByUcz9i1BQAfQf
	 nzi5lldbl1vk6QzBhpJiSEH0eeYABLspEQigfr1kp8mZY6jeHwsNV0/ct9SV24wFjM
	 R/q65/Iynuo9t2PSjy8AWKc8EA8Q+yAa4v9musoLmGaM1U5BekBFBr1h4NhklBlXu4
	 qzlOGKDF4bcTxXvyejDe4pLp2U2CGAOSxjw+qKK2NjriUbGIElPJM6UXu3nUe/USus
	 rotGVab8pFbtQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:f5b1:db54:a11a:c333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 620A717E12A2;
	Fri, 29 Aug 2025 11:20:58 +0200 (CEST)
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
Subject: [PATCH v5 04/27] clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
Date: Fri, 29 Aug 2025 11:18:50 +0200
Message-Id: <20250829091913.131528-5-laura.nao@collabora.com>
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

On MT8196, some clock controllers use a separate regmap for hardware
voting via set/clear/status registers. Add mtk_clk_get_hwv_regmap() to
retrieve this optional regmap, avoiding duplicated lookup code in 
mtk_clk_register_muxes() and mtk_clk_register_gate().

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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
index c17fe1c2d732..11962fac43ea 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -245,5 +245,6 @@ int mtk_clk_pdev_probe(struct platform_device *pdev);
 void mtk_clk_pdev_remove(struct platform_device *pdev);
 int mtk_clk_simple_probe(struct platform_device *pdev);
 void mtk_clk_simple_remove(struct platform_device *pdev);
+struct regmap *mtk_clk_get_hwv_regmap(struct device_node *node);
 
 #endif /* __DRV_CLK_MTK_H */
-- 
2.39.5


