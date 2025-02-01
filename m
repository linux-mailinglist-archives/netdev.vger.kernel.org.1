Return-Path: <netdev+bounces-161929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC8A24ADE
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787731885727
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3B1C5F26;
	Sat,  1 Feb 2025 16:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58162208A9
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429090; cv=none; b=c4HCLjleXcIIqBUuYpR1WEb1g7uhKKAstiaDk1VQGQzEFk4J1Ci9OhT8Se8PMKKtpYqqW27xJemjm/2kQWmKrO8YI8jYppLzP8QrubFVYzOgrh/YWpXP+Nr4dRHgVNXDrxR1VdMa6Nw98e5MCCVv/Od2PwOXPpDAq6phyxBLavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429090; c=relaxed/simple;
	bh=0B3NtJw1rSg4seYXOKNw+nYpNlRtZU8L1TqIdrpEazY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2qAjwx93byOoH92BLI+yqyNL63azqbJ1h0djB+VfbmW/9sUiSZWt5bIHeVsDC4St1EB5dOpcdpmpq6KVKcJ4a1g6zCkBr/EC+tPYsZ1xJjunGhOUmrNS0Mg2BPACoaIvvMSCLAT1TUrp2vSRvToYXutFS2eIS6SqJcx/Y2qzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: OJYml/URRRqhRyepLlSulg==
X-CSE-MsgGUID: 8/ZhOqqdSDCklXfIVLBpEQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2025 01:58:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CD7FB4018313;
	Sun,  2 Feb 2025 01:57:55 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rosen Penev <rosenp@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] net: ibm: emac: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 16:57:51 +0000
Message-ID: <20250201165753.53043-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper of_get_available_child_by_name() to simplify
emac_dt_mdio_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/ethernet/ibm/emac/core.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 25b8a3556004..079efc5ed9bc 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2550,26 +2550,19 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
 
 static int emac_dt_mdio_probe(struct emac_instance *dev)
 {
-	struct device_node *mii_np;
+	struct device_node *mii_np _free(device_node) =
+		of_get_available_child_by_name(dev->ofdev->dev.of_node, "mdio");
 	struct mii_bus *bus;
 	int res;
 
-	mii_np = of_get_child_by_name(dev->ofdev->dev.of_node, "mdio");
 	if (!mii_np) {
 		dev_err(&dev->ofdev->dev, "no mdio definition found.");
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(mii_np)) {
-		res = -ENODEV;
-		goto put_node;
-	}
-
 	bus = devm_mdiobus_alloc(&dev->ofdev->dev);
-	if (!bus) {
-		res = -ENOMEM;
-		goto put_node;
-	}
+	if (!bus)
+		return -ENOMEM;
 
 	bus->priv = dev->ndev;
 	bus->parent = dev->ndev->dev.parent;
@@ -2584,8 +2577,6 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
 			bus->name, res);
 	}
 
- put_node:
-	of_node_put(mii_np);
 	return res;
 }
 
-- 
2.43.0


