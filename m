Return-Path: <netdev+bounces-161931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5069EA24B09
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FE93A6D25
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42E1C8FCE;
	Sat,  1 Feb 2025 17:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4A1C5F36
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430597; cv=none; b=OQxnn2TVR+QSdVJEJFoHm+o4EGZWeJBRsVrdgevD+O0Z7PQ7gHBN6Z9GSOEdwPsYJ/OKj/ue4dpjReHJLMfrFUsNsUCTZeO7FByJmRrUpJ45tcOMoTN3K0c6bQxvoyWPmjaRjs0evRb4NuLZfpqiyVSBHyl5KQuwMmfxayUl2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430597; c=relaxed/simple;
	bh=VSNX0U6HZFJYlzcEie1qszxS8ja+G7NjMUYNRNbE3aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdnQZ0d8WdQeNkP2QWGTtlBWskitFnU84/FGWj+mOQnrE7PWQ9aLpl0P3MNqXYabrosFW5NYSYDe5fhIJ7OsyvWljImXzMcEFR9cSzAxCNqHKFLVkFf1KXsvDHlMWZSudEtPy3Vk5PrQg1F547PYE9LEBSu5QqMN1VVeaY6JEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 19DO66UsQvC5nwOyinA5Tg==
X-CSE-MsgGUID: WMx+ps2zQIqUKFzcM/jIGQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2025 02:23:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 764AA4038594;
	Sun,  2 Feb 2025 02:23:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] net: ethernet: mtk_eth_soc: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 17:22:53 +0000
Message-ID: <20250201172258.56148-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper of_get_available_child_by_name() to simplify
mtk_mdio_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 25 +++++----------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53485142938c..b318a5b58608 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -826,26 +826,18 @@ static const struct phylink_mac_ops mtk_phylink_ops = {
 static int mtk_mdio_init(struct mtk_eth *eth)
 {
 	unsigned int max_clk = 2500000, divider;
-	struct device_node *mii_np;
-	int ret;
+	struct device_node *mii_np _free(device_node) =
+		of_get_available_child_by_name(eth->dev->of_node, "mdio-bus");
 	u32 val;
 
-	mii_np = of_get_child_by_name(eth->dev->of_node, "mdio-bus");
 	if (!mii_np) {
 		dev_err(eth->dev, "no %s child node found", "mdio-bus");
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(mii_np)) {
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
 	eth->mii_bus = devm_mdiobus_alloc(eth->dev);
-	if (!eth->mii_bus) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
+	if (!eth->mii_bus)
+		return -ENOMEM;
 
 	eth->mii_bus->name = "mdio";
 	eth->mii_bus->read = mtk_mdio_read_c22;
@@ -860,8 +852,7 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 	if (!of_property_read_u32(mii_np, "clock-frequency", &val)) {
 		if (val > MDC_MAX_FREQ || val < MDC_MAX_FREQ / MDC_MAX_DIVIDER) {
 			dev_err(eth->dev, "MDIO clock frequency out of range");
-			ret = -EINVAL;
-			goto err_put_node;
+			return -EINVAL;
 		}
 		max_clk = val;
 	}
@@ -879,11 +870,7 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 
 	dev_dbg(eth->dev, "MDC is running on %d Hz\n", MDC_MAX_FREQ / divider);
 
-	ret = of_mdiobus_register(eth->mii_bus, mii_np);
-
-err_put_node:
-	of_node_put(mii_np);
-	return ret;
+	return of_mdiobus_register(eth->mii_bus, mii_np);
 }
 
 static void mtk_mdio_cleanup(struct mtk_eth *eth)
-- 
2.43.0


