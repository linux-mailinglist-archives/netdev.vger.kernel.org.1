Return-Path: <netdev+bounces-161930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4676BA24AF8
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1756D3A6E9F
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507D1ADC9D;
	Sat,  1 Feb 2025 17:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32914AD22
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430146; cv=none; b=ZCepy6dGaF+Qsz7WYk08PoJSZipT8H3pyrquSaDT5RJsBJqn9pIETmVbJ966Pj2o2d8hp7fI6wLBVzcQGy4iZqos+qfGMkiVXnd5J3CevMtnoNlzXjuCkvYx9+MHnV0q3+d2w/pMmMiNn3XDwzroNev4RAkOj8GjlVr1KSsq1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430146; c=relaxed/simple;
	bh=BlKQdV4hR32f/zfALQJ+8XWUpNZ4XFeraVGTQDPY15c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxUfMOLPA4Nc4hH3kuQ60uYdRztobUYEf3TnpZXKHkckqCt+/nV2YJnA3w23s4V/Sa4NFbJdqoUB1npgQpvKvaz+EuoOTYZ+4kkiPAis3Fl+UaVIWdJ0Uvw5nWZgfG4sMqP81fK5kpDOm5LwKw5tjhPeOp7Un/a/EnDRlSCLrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Tq4Nmjg8Qh6eCHLyTkiFJg==
X-CSE-MsgGUID: Zxdm66+1QWqsMWWy3aLtYw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2025 02:15:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D546A401CED4;
	Sun,  2 Feb 2025 02:15:32 +0900 (JST)
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
Subject: [PATCH] net: ethernet: actions: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 17:15:18 +0000
Message-ID: <20250201171530.54612-1-biju.das.jz@bp.renesas.com>
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
This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/ethernet/actions/owl-emac.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
index 115f48b3342c..3457ce041335 100644
--- a/drivers/net/ethernet/actions/owl-emac.c
+++ b/drivers/net/ethernet/actions/owl-emac.c
@@ -1323,22 +1323,15 @@ static int owl_emac_mdio_init(struct net_device *netdev)
 	struct owl_emac_priv *priv = netdev_priv(netdev);
 	struct device *dev = owl_emac_get_dev(priv);
 	struct device_node *mdio_node;
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
@@ -1348,11 +1341,7 @@ static int owl_emac_mdio_init(struct net_device *netdev)
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


