Return-Path: <netdev+bounces-162968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E130A28A8E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5509168390
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7622CBF0;
	Wed,  5 Feb 2025 12:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA62151987
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759389; cv=none; b=nPJJpjmB5o/zJBtSOhJOGtYy/lVxKq+m7Gv3hUurNwI/tREH1grGIISUOnK9ffjzflBaB+trvjn81IHwNXiwapoj4SD70ED5jfqP1HAIkossMmQdlDwZIJNQrVal3MIhFIn851m4ecMmdN4TEcr05sevnwbbZAuD8GKO4CPVtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759389; c=relaxed/simple;
	bh=H33hURR7xzjz1AVHWTdUM2TEYSjtNcmtPyyliQYYmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Ogn8fO/WJk/8c8t8psLFCV4RvaJEefN/MevEid+I9zGm3YTqpeQJFDheVD7yp2EjMWS66xwqoCLvJj4gzxvTdaSCFwogpC2e+E0w4vPS7NX26MwJXbi+v/FZb3/2CpNWBUMAbQTUoqWIG4+6mbHyhnVfDETzkCQ9CBjA1+h2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: KTNcS2wNQMaUlothZ7KZaQ==
X-CSE-MsgGUID: zctjB0xES0S1VXpVZgYMxQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 21:43:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 45B7241F86AB;
	Wed,  5 Feb 2025 21:42:56 +0900 (JST)
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
Subject: [PATCH net-next v2 4/7] net: ethernet: mtk-star-emac: Use of_get_available_child_by_name()
Date: Wed,  5 Feb 2025 12:42:24 +0000
Message-ID: <20250205124235.53285-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 *  Dropped using _free()
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 25989c79c92e..76f202d7f055 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1427,15 +1427,10 @@ static int mtk_star_mdio_init(struct net_device *ndev)
 
 	of_node = dev->of_node;
 
-	mdio_node = of_get_child_by_name(of_node, "mdio");
+	mdio_node = of_get_available_child_by_name(of_node, "mdio");
 	if (!mdio_node)
 		return -ENODEV;
 
-	if (!of_device_is_available(mdio_node)) {
-		ret = -ENODEV;
-		goto out_put_node;
-	}
-
 	priv->mii = devm_mdiobus_alloc(dev);
 	if (!priv->mii) {
 		ret = -ENOMEM;
-- 
2.43.0


