Return-Path: <netdev+bounces-246885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F7CF2221
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B93B304A10D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639802D77EA;
	Mon,  5 Jan 2026 07:09:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E892D6624;
	Mon,  5 Jan 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596953; cv=none; b=ZiuFZ7FHLArGpC+brYiZqLdFaOFyCG6VJkNrdII0FPfnBw7rFGCjhq4jsdKVIk0FecX7DPKV+NKMIAxaU2L2Wmu5d9T/fUEm9wGQmXTXD063/0LJPSMtNhAah9eZLOvJ4NLyA1XxPlO+gb2XMiMMuuNeOZNFB9hjVEVYXm7sSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596953; c=relaxed/simple;
	bh=eEr+uM5vvxZ541jxelgE7V5Ie2nLwqMUcKYDSddDAtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TKT0NI+iOafTDz165P3SgjDLW7xQYhb4f+SLW9B0EkUh7e/Hxann6JdImjZNK0mMTC5vMqNWUmHr1tf8cz4aGEX6qSEqaAdaBIV098IWlf/+4wSg/4I9kARQLDRTioy8rZQ/H25uP750PeTw+hwitqooUo01NxxctR6DtGZrs4I=
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
Date: Mon, 5 Jan 2026 15:08:51 +0800
Subject: [PATCH 05/15] net: ftgmac100: Use
 devm_request_memory_region/devm_ioremap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-5-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=1951;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=X4ifaGbvFBJZb8lE1fJWWlYBPPVj5TIu19iwHqOwH0A=;
 b=0BLXwbd6NADaT5092oijtRabW2nd6wnVEYEObcVznYBx5C6oSJjWjt8X4bcx0Xd2AzkzdK5xt
 cce4cDsZiwvCkTEKlzuJl+hQhgdwa6TLYbp9Uy3Au8ggj1sz2cKe7F0
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Make use of devm_ methods to request and remap the device memory to
simplify cleanup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 75c7ab43e7e9..c23d5d675c5f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1898,19 +1898,18 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	INIT_WORK(&priv->reset_task, ftgmac100_reset_task);
 
 	/* map io memory */
-	priv->res = request_mem_region(res->start, resource_size(res),
-				       dev_name(&pdev->dev));
+	priv->res = devm_request_mem_region(&pdev->dev,
+					    res->start, resource_size(res),
+					    dev_name(&pdev->dev));
 	if (!priv->res) {
 		dev_err(&pdev->dev, "Could not reserve memory region\n");
-		err = -ENOMEM;
-		goto err_req_mem;
+		return -ENOMEM;
 	}
 
-	priv->base = ioremap(res->start, resource_size(res));
+	priv->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!priv->base) {
 		dev_err(&pdev->dev, "Failed to ioremap ethernet registers\n");
-		err = -EIO;
-		goto err_ioremap;
+		return -EIO;
 	}
 
 	netdev->irq = irq;
@@ -2075,10 +2074,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		ncsi_unregister_dev(priv->ndev);
 	ftgmac100_destroy_mdio(netdev);
 err_setup_mdio:
-	iounmap(priv->base);
-err_ioremap:
-	release_resource(priv->res);
-err_req_mem:
 	return err;
 }
 
@@ -2105,9 +2100,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	ftgmac100_phy_disconnect(netdev);
 	ftgmac100_destroy_mdio(netdev);
 
-	iounmap(priv->base);
-	release_resource(priv->res);
-
 	netif_napi_del(&priv->napi);
 }
 

-- 
2.34.1


