Return-Path: <netdev+bounces-161924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBAA24A45
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F51886F5B
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D21C3BFC;
	Sat,  1 Feb 2025 16:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54B2F56
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426909; cv=none; b=E1lfo9MUdFhYfuYyEwQ5vXqCoz4ZSUdLTLUFrE+X6ff6GAfC+Yix37XKT567/RXROq91l2lCQjpjO7XD6UDKc2XjB+didxxUsTql7BJ+iHeASGWLnYVSaT6L3fOWBm4b8c4ntUvwuLbb86Pb+wsLz66HTaTNd4jknONE6rznuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426909; c=relaxed/simple;
	bh=y4sDzbpr4Q6SWPKe2a4JLfsLFr7cMZW6KIFKvYSXGrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atBA8i1pAIuTifUd3fjXjFfe1+M9oNlWpIj+5556lWKCBx9Pgal42npRpEe0m/e4+s8/aBIHUWmU7MhnXBopYmCxt8TPobEJ7yo36F8eL/0N+FonLvtU2KA4C0fop3ZEV1fiJGcKk/Esc2/rT+8oyrYadwiUDvritgDAVaTSr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: AgGFxWtbTL2lG5Lg6U9uWg==
X-CSE-MsgGUID: l+OeNAZxSs+/vPP+FVGizw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2025 01:21:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DBB7B401E6AA;
	Sun,  2 Feb 2025 01:21:37 +0900 (JST)
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
Subject: [PATCH] net: ethernet: mtk-star-emac: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 16:21:32 +0000
Message-ID: <20250201162135.46443-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper of_get_available_child_by_name() to simplify
mtk_star_mdio_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 24 ++++---------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 25989c79c92e..beb0500fe9d5 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1422,25 +1422,15 @@ static int mtk_star_mdio_init(struct net_device *ndev)
 {
 	struct mtk_star_priv *priv = netdev_priv(ndev);
 	struct device *dev = mtk_star_get_dev(priv);
-	struct device_node *of_node, *mdio_node;
-	int ret;
-
-	of_node = dev->of_node;
+	struct device_node *mdio_node _free(device_node) =
+		of_get_available_child_by_name(dev->of_node, "mdio");
 
-	mdio_node = of_get_child_by_name(of_node, "mdio");
 	if (!mdio_node)
 		return -ENODEV;
 
-	if (!of_device_is_available(mdio_node)) {
-		ret = -ENODEV;
-		goto out_put_node;
-	}
-
 	priv->mii = devm_mdiobus_alloc(dev);
-	if (!priv->mii) {
-		ret = -ENOMEM;
-		goto out_put_node;
-	}
+	if (!priv->mii)
+		return -ENOMEM;
 
 	snprintf(priv->mii->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 	priv->mii->name = "mtk-mac-mdio";
@@ -1449,11 +1439,7 @@ static int mtk_star_mdio_init(struct net_device *ndev)
 	priv->mii->write = mtk_star_mdio_write;
 	priv->mii->priv = priv;
 
-	ret = devm_of_mdiobus_register(dev, priv->mii, mdio_node);
-
-out_put_node:
-	of_node_put(mdio_node);
-	return ret;
+	return devm_of_mdiobus_register(dev, priv->mii, mdio_node);
 }
 
 static __maybe_unused int mtk_star_suspend(struct device *dev)
-- 
2.43.0


