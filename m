Return-Path: <netdev+bounces-161928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA421A24AC1
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501FD1653EF
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA651C3C1C;
	Sat,  1 Feb 2025 16:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131CB1B414B
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428621; cv=none; b=tOKCyLwOc+oiUMkKD7Hb1oVS/PYszoobm4OT7eNddxqfmWkCNdIfgLTfcLrcOQ6kmNGDOqq017t1v3jQDaa3hEpNQWVya4icDF83MlKk1y0nUhkhHIfDVvfX/2BGHSnIQzJlJXiuhmJYbStPcPA5HPtxmU8f2u8ZQZuN5RImtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428621; c=relaxed/simple;
	bh=3jMXCLGKjDGJdYTHLMOBJZ/M3qxMjnGaDd3D1svFUqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuuPaxIfqRl9vDHaxQ2GLwcmY8ePofyyOETODQMIa8RzJAxt0XhjALlgXnzqOGBa3voqPG2cmeo/SiWfZNzQBDb3YffGFyR8hZUMt+ug9FcfVJ/zXhTd6qpUx0utkiHZz3Ypp+lSln9/01NM3EehMckZ4fM6Uk0WXBwhmX2oFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: bYLq1BmsRCWr353Tn4G0DQ==
X-CSE-MsgGUID: s2AsiSGoREyE1hcxwAIUGg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2025 01:50:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C4093401EFA0;
	Sun,  2 Feb 2025 01:50:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] net: dsa: sja1105: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 16:49:57 +0000
Message-ID: <20250201164959.51643-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper of_get_available_child_by_name() to simplify
sja1105_mdiobus_register().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/dsa/sja1105/sja1105_mdio.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 84b7169f2974..d73bf5c9525b 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -461,24 +461,21 @@ int sja1105_mdiobus_register(struct dsa_switch *ds)
 	struct sja1105_private *priv = ds->priv;
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct device_node *switch_node = ds->dev->of_node;
-	struct device_node *mdio_node;
+	struct device_node *mdio_node _free(device_node) =
+		of_get_available_child_by_name(switch_node, "mdios");
 	int rc;
 
 	rc = sja1105_mdiobus_pcs_register(priv);
 	if (rc)
 		return rc;
 
-	mdio_node = of_get_child_by_name(switch_node, "mdios");
 	if (!mdio_node)
 		return 0;
 
-	if (!of_device_is_available(mdio_node))
-		goto out_put_mdio_node;
-
 	if (regs->mdio_100base_tx != SJA1105_RSV_ADDR) {
 		rc = sja1105_mdiobus_base_tx_register(priv, mdio_node);
 		if (rc)
-			goto err_put_mdio_node;
+			goto err_pcs_unregister;
 	}
 
 	if (regs->mdio_100base_t1 != SJA1105_RSV_ADDR) {
@@ -487,15 +484,11 @@ int sja1105_mdiobus_register(struct dsa_switch *ds)
 			goto err_free_base_tx_mdiobus;
 	}
 
-out_put_mdio_node:
-	of_node_put(mdio_node);
-
 	return 0;
 
 err_free_base_tx_mdiobus:
 	sja1105_mdiobus_base_tx_unregister(priv);
-err_put_mdio_node:
-	of_node_put(mdio_node);
+err_pcs_unregister:
 	sja1105_mdiobus_pcs_unregister(priv);
 
 	return rc;
-- 
2.43.0


