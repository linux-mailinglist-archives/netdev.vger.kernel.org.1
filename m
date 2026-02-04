Return-Path: <netdev+bounces-256578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKWHJkHagmnkcwMAu9opvQ
	(envelope-from <netdev+bounces-256578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:33:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 442A7E1FF7
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E65A303F54C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0C37F0FF;
	Wed,  4 Feb 2026 05:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478A37E30D;
	Wed,  4 Feb 2026 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182813; cv=none; b=N7EszN4mofdlKS0LXKvdoIlLmvvxTO3HvdS1POOReCo2MU9SIndNihjHl5FWyx846nxwZ31BveOjmWQrYGHxaLjnPzUDrgrEJRfmCwAD+t4+jHDG1r7SwP5Tem6pakNrkLjIPfBeTSdmcC0ft8a1lAfOqyu4c2PlqCjFbm4sHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182813; c=relaxed/simple;
	bh=/pgWTDi5+56ExcDOnn/4hchxZjnem104hwhxzKEl+e4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tPegWsbr7PiAk+FH0Z1lc6YW6l9Wg4ERmhtyOuYZAItvAMrZJ2NZfHWUQd5q9ZbJoNdMv8P4XzbyRHdVL/3xe5g7Pg3QjlNmadd7Ya3ev5rejJfRay0ocNbz20f+PYm2NcbyXRo2/EPlIjpYqCvRjZ0h/MDzZ6LbyuZlj7o5Cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Feb
 2026 13:26:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Feb 2026 13:26:32 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Feb 2026 13:26:41 +0800
Subject: [PATCH net-next v4 15/15] net: ftgmac100: Use
 devm_mdiobus_alloc/devm_of_mdiobus_register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-15-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=2368;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/pgWTDi5+56ExcDOnn/4hchxZjnem104hwhxzKEl+e4=;
 b=RLoUKIAJB5oAh5IMKBgKRSQlHBgdhCWFyroIccPCh3XpsKVJnMP6IZ4tT28Sk/nCRJLfNfPjb
 nmhIpTc5kwTB32yPJsceJ9fuCxQh38vRZ+x3n7hovOBLUWbX1lK+Jz3
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256578-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 442A7E1FF7
X-Rspamd-Action: no action

Make use of devm_ methods to allocate and register mdiobus to simplify
cleanup.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index d5cdd6ac65eb..b55216d3c77b 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1716,7 +1716,7 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	u32 reg;
 
 	/* initialize mdio bus */
-	priv->mii_bus = mdiobus_alloc();
+	priv->mii_bus = devm_mdiobus_alloc(priv->dev);
 	if (!priv->mii_bus)
 		return -EIO;
 
@@ -1742,19 +1742,14 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 
 	mdio_np = of_get_child_by_name(np, "mdio");
 
-	err = of_mdiobus_register(priv->mii_bus, mdio_np);
+	err = devm_of_mdiobus_register(priv->dev, priv->mii_bus, mdio_np);
+	of_node_put(mdio_np);
 	if (err) {
 		dev_err(priv->dev, "Cannot register MDIO bus!\n");
-		goto err_register_mdiobus;
+		return err;
 	}
 
-	of_node_put(mdio_np);
-
 	return 0;
-
-err_register_mdiobus:
-	mdiobus_free(priv->mii_bus);
-	return err;
 }
 
 static void ftgmac100_phy_disconnect(struct net_device *netdev)
@@ -1773,17 +1768,6 @@ static void ftgmac100_phy_disconnect(struct net_device *netdev)
 		fixed_phy_unregister(phydev);
 }
 
-static void ftgmac100_destroy_mdio(struct net_device *netdev)
-{
-	struct ftgmac100 *priv = netdev_priv(netdev);
-
-	if (!priv->mii_bus)
-		return;
-
-	mdiobus_unregister(priv->mii_bus);
-	mdiobus_free(priv->mii_bus);
-}
-
 static void ftgmac100_ncsi_handler(struct ncsi_dev *nd)
 {
 	if (unlikely(nd->state != ncsi_dev_state_functional))
@@ -2086,7 +2070,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	ftgmac100_phy_disconnect(netdev);
 	if (priv->ndev)
 		ncsi_unregister_dev(priv->ndev);
-	ftgmac100_destroy_mdio(netdev);
 	return err;
 }
 
@@ -2108,7 +2091,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	cancel_work_sync(&priv->reset_task);
 
 	ftgmac100_phy_disconnect(netdev);
-	ftgmac100_destroy_mdio(netdev);
 }
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {

-- 
2.34.1


