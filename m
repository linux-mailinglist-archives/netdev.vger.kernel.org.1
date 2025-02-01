Return-Path: <netdev+bounces-161932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833DA24B0C
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421FE3A6A7B
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C111CAA64;
	Sat,  1 Feb 2025 17:28:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC321C8FCE
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430887; cv=none; b=gp5yXdppqOTKss58zFGz3tZ1ut8L7w5yebbnbRule/B/khTSHdQ4fLR2DelnR9Y+Ty4Y5cJggBGGtToLAW4Ez0naMbWIo5EzP8zl0NC5NuLpNEuyLK3CFkhvLPaXh060hyH+Z6kGxPBA3m3qMB5wp0lkMah5FQ1S262SeyYuASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430887; c=relaxed/simple;
	bh=4hM642y8txdXK3D2qV3tEgs2L22m1xCsrL/7xO84I6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIddIphRKKRRbnTJjy+8a5IhSZBqJSUeYIk9MDlzbyLaf7xLf7pAuHVnc1+gQP1XIK9Nvn4gZTKebMFcsOt7Rcaudkqr//x/e/d+SBanP9qdajTTeKF3BSj8BQFXJQhoD9Ho8nHT0WI1AVJaPbtgXPp3PmVfw/2V1BU9c+GyEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 1G7weM7jTkuXTAlgpHH4DA==
X-CSE-MsgGUID: 9Is9hnlbSAOWwxWubiFzSA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2025 02:28:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 56E61403A86F;
	Sun,  2 Feb 2025 02:27:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2] net: ethernet: actions: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 17:27:40 +0000
Message-ID: <20250201172745.56627-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper of_get_available_child_by_name() to simplify
owl_emac_mdio_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v3:
 * Dropped duplicate mdio_node declaration.

This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/ethernet/actions/owl-emac.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
index 115f48b3342c..c5a00c09b1ea 100644
--- a/drivers/net/ethernet/actions/owl-emac.c
+++ b/drivers/net/ethernet/actions/owl-emac.c
@@ -1322,23 +1322,15 @@ static int owl_emac_mdio_init(struct net_device *netdev)
 {
 	struct owl_emac_priv *priv = netdev_priv(netdev);
 	struct device *dev = owl_emac_get_dev(priv);
-	struct device_node *mdio_node;
-	int ret;
+	struct device_node *mdio_node _free(device_node) =
+		of_get_available_child_by_name(dev->of_node, "mdio");
 
-	mdio_node = of_get_child_by_name(dev->of_node, "mdio");
 	if (!mdio_node)
 		return -ENODEV;
 
-	if (!of_device_is_available(mdio_node)) {
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
 	priv->mii = devm_mdiobus_alloc(dev);
-	if (!priv->mii) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
+	if (!priv->mii)
+		return -ENOMEM;
 
 	snprintf(priv->mii->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 	priv->mii->name = "owl-emac-mdio";
@@ -1348,11 +1340,7 @@ static int owl_emac_mdio_init(struct net_device *netdev)
 	priv->mii->phy_mask = ~0; /* Mask out all PHYs from auto probing. */
 	priv->mii->priv = priv;
 
-	ret = devm_of_mdiobus_register(dev, priv->mii, mdio_node);
-
-err_put_node:
-	of_node_put(mdio_node);
-	return ret;
+	return devm_of_mdiobus_register(dev, priv->mii, mdio_node);
 }
 
 static int owl_emac_phy_init(struct net_device *netdev)
-- 
2.43.0


