Return-Path: <netdev+bounces-246889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C85CF2212
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A447D301E9AB
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632D2D77FF;
	Mon,  5 Jan 2026 07:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFC2D5410;
	Mon,  5 Jan 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596961; cv=none; b=JsGYkO494SuZJ+gcb53zyLFEVRlDSdAWcy/nGoYDKu03cvxYD3KI1XZwl7fFEcPHP/rGJYD2ao5+44YwSylNVS0tl38RBn9O/6nx6nb1OxSQS6mPUHJCVq8zEX2ZI9oZ5oobXSwVlwjf9Dpi2wlp9t+KHG5dpuV2s/qaahQ7YL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596961; c=relaxed/simple;
	bh=SOWs+5iZWnENSrRyzkpfSl7DW/3CbwKEya9ptBY6DQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tsma1WlQnqrqt5ZvwPw04OtDXe4C8tZ3Y88NmPZfo0qi1cjat8ewNEGmxjSUn3PDDXQAN+wzJAcszyXkn41eJVJyROlLrwS7AJskF+HCn4DnZh2ikVg+t/PJmf6FryhBb1JwKpxdp3j2vGVFOGr7tQ/03/gd05XZ5RSodmSPZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:52 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:52 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:55 +0800
Subject: [PATCH 09/15] net: ftgmac100: Always register the MDIO bus when it
 exists
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-9-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=2219;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=wOY86KFy16/fdZZiuRKZeVWVJXfvqR4ytPNJAoapJLM=;
 b=kD+09PBLOMPBH/WRbHW3ty3ncGp/GeSM1aVoFKmBCUD/PPA439I/M7/GgZVeIZRwGjgb73q0L
 1Z7YBZEgTgxBXHA0FJHvnAN0RgG9FyjLum9J1osLRqKFBR0B43R+x8L
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Both the Aspeed 2400 and 2500 and the original faraday version of the
MAC have MDIO bus controllers as part of the MAC. Since it exists,
always registering it makes the code simpler, and causes no harm. If
there is no mdio node in device tree, of_mdiobus_register() will fall
back to mdiobus_register(), making it safe.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1bdc6793e817..327e29064793 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1958,6 +1958,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		priv->txdes0_edotr_mask = BIT(15);
 	}
 
+	if (priv->mac_id == FTGMAC100_FARADAY ||
+	    priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500) {
+		err = ftgmac100_setup_mdio(netdev);
+		if (err)
+			goto err_phy_connect;
+	}
+
 	if (np && of_get_property(np, "use-ncsi", NULL)) {
 		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
 		if (err)
@@ -1966,18 +1974,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			  of_get_property(np, "phy-handle", NULL))) {
 		struct phy_device *phy;
 
-		/* Support "mdio"/"phy" child nodes for ast2400/2500 with
-		 * an embedded MDIO controller. Automatically scan the DTS for
-		 * available PHYs and register them.
-		 */
-		if (of_get_property(np, "phy-handle", NULL) &&
-		    (priv->mac_id == FTGMAC100_AST2400 ||
-		     priv->mac_id == FTGMAC100_AST2500)) {
-			err = ftgmac100_setup_mdio(netdev);
-			if (err)
-				goto err_setup_mdio;
-		}
-
 		phy = of_phy_get_and_connect(priv->netdev, np,
 					     &ftgmac100_adjust_link);
 		if (!phy) {
@@ -2000,9 +1996,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * PHYs.
 		 */
 		priv->use_ncsi = false;
-		err = ftgmac100_setup_mdio(netdev);
-		if (err)
-			goto err_setup_mdio;
 
 		err = ftgmac100_mii_probe(netdev);
 		if (err) {

-- 
2.34.1


