Return-Path: <netdev+bounces-162967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59428A28A8A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5B18888B5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0B22CBC9;
	Wed,  5 Feb 2025 12:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5922ACC6
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759386; cv=none; b=RsZyaeVjsKl4C+XQAVJJga1CjQL9+68BnFSjhqnR/TafqZsrxcv1IPfviBeTQUHrnWNjbpBBxFq7zMtdbBK5RdBGM9c9j82B0qs0ttciRJT0vRReobHIg48GVa6IiJRk70jloxSQOT+9/BWYANylkp5HwM08VQsFLVKQdzSEHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759386; c=relaxed/simple;
	bh=/By+oCRZjiaYCiEru6w0iWiKL671JCi+VB1DA1Za1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLVjYRjEnLIBeOescm0nCsyl5xxTBC3EEA0T8IlYN48Y9czVJmCq4YiZsztHywDM49uSE7NJmK8P65pFRYb8Kw+A4rNGiVrU4i8pimyed3vkDVaRWKEeMcb+7h1bHdVHXPMmtPr3ADKJhAaYkTgv3FA9TfSfM24OaAKpE1bM0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oORIsVN5T+OqCrjya76M2g==
X-CSE-MsgGUID: 0ZKUtHwqQc6diYjxjsLPcg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 21:43:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7282741F8497;
	Wed,  5 Feb 2025 21:42:53 +0900 (JST)
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
Subject: [PATCH net-next v2 3/7] net: dsa: sja1105: Use of_get_available_child_by_name()
Date: Wed,  5 Feb 2025 12:42:23 +0000
Message-ID: <20250205124235.53285-4-biju.das.jz@bp.renesas.com>
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
sja1105_mdiobus_register().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped using _free().
---
 drivers/net/dsa/sja1105/sja1105_mdio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 84b7169f2974..8d535c033cef 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -468,13 +468,10 @@ int sja1105_mdiobus_register(struct dsa_switch *ds)
 	if (rc)
 		return rc;
 
-	mdio_node = of_get_child_by_name(switch_node, "mdios");
+	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
 	if (!mdio_node)
 		return 0;
 
-	if (!of_device_is_available(mdio_node))
-		goto out_put_mdio_node;
-
 	if (regs->mdio_100base_tx != SJA1105_RSV_ADDR) {
 		rc = sja1105_mdiobus_base_tx_register(priv, mdio_node);
 		if (rc)
@@ -487,7 +484,6 @@ int sja1105_mdiobus_register(struct dsa_switch *ds)
 			goto err_free_base_tx_mdiobus;
 	}
 
-out_put_mdio_node:
 	of_node_put(mdio_node);
 
 	return 0;
-- 
2.43.0


