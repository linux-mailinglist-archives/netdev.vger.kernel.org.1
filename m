Return-Path: <netdev+bounces-250383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F1D29F22
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E976A30051B9
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D033769B;
	Fri, 16 Jan 2026 02:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094433711D;
	Fri, 16 Jan 2026 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529385; cv=none; b=eqQK0i3JR9JLLAD2LR4H5kZxIDczAeC3qk1uij1jKNTmN91NCL44rG+WSBsKNX1rV5cI4Kf8DzBgEZsrJLZ16qK3ziwEF2zQ7HfQ2StAms7gYxl5YqXuw+mQFklunfJLMHlL0s5/VxV1mVji/RNk4vobM1Yfo5+rMzLUum0fnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529385; c=relaxed/simple;
	bh=onLWbZUbnTMgDK4y8kzfyvlIWWGQE8LKDFBj5Fq38Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FpbV9/qXnzNg4ayyfsT8l3zXMPCPG3u60fN+iCr2C15bTwc7TZdbzUZhhkM/GnwpUJS0JVPVGn+UwZiav9DJHBfLTx2SWioEhoqzwqSAAZtuU7K/Po23foKss0QcnpTMA9Gbea4Di4ZdeSFRLzRwCYMBnYDx1B1LpeOg9AUoCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:15 +0800
Subject: [PATCH net-next v2 04/15] net: ftgmac100: Use
 devm_alloc_etherdev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-4-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=1418;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=o3nIYAscEW7qqYCVm0zoQKSDXM36iO60MZ4R096iN0U=;
 b=gic25JcS3eBRR4XpdIuoBtLiVRLFnVJIo6qqo6u3jTa7qYLyGni7IJCvlYmWQXwoFzavWVKUJ
 1CEbj7ITmZzDgq1DBrXJ7VJQXExC+D3dBEcLZTfm3ucTPa/YQJ261Wn
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Make use of devm_alloc_etherdev() to simplify cleanup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index f07167cabf39..397ada43c851 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1877,11 +1877,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		return irq;
 
 	/* setup net_device */
-	netdev = alloc_etherdev(sizeof(*priv));
-	if (!netdev) {
-		err = -ENOMEM;
-		goto err_alloc_etherdev;
-	}
+	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
+	if (!netdev)
+		return -ENOMEM;
 
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
@@ -2080,8 +2078,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 err_ioremap:
 	release_resource(priv->res);
 err_req_mem:
-	free_netdev(netdev);
-err_alloc_etherdev:
 	return err;
 }
 
@@ -2112,7 +2108,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	release_resource(priv->res);
 
 	netif_napi_del(&priv->napi);
-	free_netdev(netdev);
 }
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {

-- 
2.34.1


