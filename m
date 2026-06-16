Return-Path: <netdev+bounces-299952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xuowFfeyMWoypQUAu9opvQ
	(envelope-from <netdev+bounces-299952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:32:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6A6953DC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:32:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rJv68cgo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299952-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B699730E810F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850337FF7F;
	Tue, 16 Jun 2026 20:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AAF37F724
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641971; cv=none; b=TcV3dY2bZ01Be5pUQJX0t7pVP1uuklS22pOLzFpoDnIrVOz1q6MUO/f3odeQA5Bx7qjS9EY4AXP9wqIdvmkHRNneSvETG1X9YIjv+J/CP9Y/p2vxVQsB5mvZnbYo588gZ2iy6RFhr2o9PrCNbiQD0j0ByQGUiT31XP8JhzCFCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641971; c=relaxed/simple;
	bh=DpdD7sebqPQAdE5b/BDXiFIHLag1ohfFL7bYS/flFwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHGcgM3UjQFnAEVfsoLPsn1gXAqEDqn976PE1x3vMxs/HSg9EPl+t3RDkrSwHI7bWM4bN+HchE+wuSdaKM24iwdeUR8urKSU0Pr3EJI9WqVTJpS6053hk4TiK2a7jvzAwKbBjQBY9Z/Hp7rOzOL2rnZK4lvpdrxANW8pA0vvw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJv68cgo; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6bb8a5980so1409095ad.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781641969; x=1782246769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DFJHkQb5Ov+Hz0CMeGTlHveS+yOdnR8WS+fqX65pR68=;
        b=rJv68cgonlQ+x5fglKd52iRdAjOb6qtnVfR6zWlI/Yd2vb2jgA8lcF4utje4eGIF7e
         YtClYRXpRsd5HOw63l7IHoTqNndLU+VOB/4xWs61V72na3kpTFLdvtMZPJbJ3E1Epn8i
         1lNPMwIBsHl9WdQGxPObcPBR1Dw8/5soB+cR0jzX9q4Mu7C9IRB+BcY+p4byEYklsGxb
         gmBBrx0JmZTVf4qMzhS70BnhMrPL5HC1sb1T5dfhg83Q/+c2hW/ovQTOlkfSPstQnndy
         hQhsW+7KSs2Xilv9bJ1K7ceVgd9AD4/NYM3n+6rUQMbFR9eOhlp982+ays+ruqRThiS/
         ueZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781641969; x=1782246769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFJHkQb5Ov+Hz0CMeGTlHveS+yOdnR8WS+fqX65pR68=;
        b=gIuOio6ZFgui1i+07aDwsIjBoCiWPvTfBNtPnPspZs/2c0OIEMVw1SqH8e47+IEDac
         BoSPT+fsKWXbHcyFCj7DnOXPn5zJrgEJtmqerCtvF1eMaf9xar9uwwxW1DA5twSolGp8
         mONbStG779+0GlEDys/d/wjXWyHU3lrpFZbUCkWkQP4bpgvBy4LWPder/9wmDy4yLClb
         8nYzGmKes+kOzyZJEWthippGYj7pt6zco5yFMwaDcVZ1t83Kfrwo7yAZ06G4Zu9qhUnt
         ovw7gMWu2+8UhdWWJINo2rEBhtnh6xIYva8az+33MByAJqjsbjcSB2+/494vd4xGz1nQ
         3QFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D7NDT5mOONYzr5BZzOVY0kCIdqk+gfSiB4jbacx6mmi3aSYybbTj7nb4drCNhI67fCXx8qqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQD52B0hIbQMNKmFI05CphXnqmjPleLlA+qhV7wrBexnESBtmN
	EDJNBmfsH0FsQwrlINuGHjqhL+JPPfTT5Jf66/dH/x8l+uJEWqHOGOEQ14PJEtxOGZw=
X-Gm-Gg: AfdE7cmCzdArrwf1pa9GUSfYzgp1PIrUm9n6/tdcSZbrBwWRLAn3swvwb+2q3cI22Mv
	umwfqiGpJko/cxKH+QvLRAwbTG0w5G9q6Q9xgy7W4yiMX96Qcjr+L48jIRkbG7ug2F/+3ygKHwR
	+5YFZ1TD3tVGnkIG0GZZBLVb/B/i9ARQ79JYGnBAAIhgHs/TVCSwV4a+ZUuvgzannkEnqrUKb+g
	iu3k31vVjsAlK/hROLb3kDRSW0efmT1hjjpHQHG4yKypJ57cTy9uCg9RhA7R4KC//LKkGh6mluQ
	lq4chteBgVvK+bl0nbxNn04stAVKml0qJsOWd/HQ3Whv1hnAGmG3WVevEe3Ib23fLfi07yZPVvE
	AvjpUNV0wKy/QBzqPIcY0yeR96BG4a4QglQoZk7KT+SiFQquXR90BFUnu3CZjMvWOnHfqULni7B
	zz5we68j7NV/7jiijvwjoFTz9E5bclLQVawKY8cLooKrHVGUB6iG9ksRpSuxuabJvhKeW1d4fJX
	GQDBiuGm2ZebJk5JP2T4x5z++CmHNMch330ETfixlfXDwG5T2mAZyWhOLEBmOpQeiHTVTdpcg==
X-Received: by 2002:a17:903:2411:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2c6bbf6ec32mr5855535ad.7.1781641969459;
        Tue, 16 Jun 2026 13:32:49 -0700 (PDT)
Received: from bloom.localdomain (S010680dac2bce256.cg.shawcable.net. [174.0.186.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8becesm146930445ad.56.2026.06.16.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:32:48 -0700 (PDT)
From: Jack Lee <skunkolee@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Lee <skunkolee@gmail.com>
Subject: [PATCH] net: faraday: ftmac100: convert to devm resource management
Date: Tue, 16 Jun 2026 13:32:33 -0700
Message-ID: <20260616203233.55234-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299952-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skunkolee@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[skunkolee@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skunkolee@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADE6A6953DC

Replace manual resource management with device-managed alternatives:
- alloc_etherdev() -> devm_alloc_etherdev()
- request_mem_region() + ioremap() -> devm_platform_ioremap_resource()

This simplifies error handling by removing manual cleanup in error
paths and the remove function, and eliminates the risk of resource
leaks.

Signed-off-by: Jack Lee <skunkolee@gmail.com>
---
 drivers/net/ethernet/faraday/ftmac100.c | 47 +++++--------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 5803a382f0ba..adb318925f44 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -49,7 +49,6 @@ struct ftmac100_descs {
 };
 
 struct ftmac100 {
-	struct resource *res;
 	void __iomem *base;
 	int irq;
 
@@ -1137,11 +1136,9 @@ static int ftmac100_probe(struct platform_device *pdev)
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
 	netdev->ethtool_ops = &ftmac100_ethtool_ops;
@@ -1150,7 +1147,7 @@ static int ftmac100_probe(struct platform_device *pdev)
 
 	err = platform_get_ethdev_address(&pdev->dev, netdev);
 	if (err == -EPROBE_DEFER)
-		goto defer_get_mac;
+		return err;
 
 	platform_set_drvdata(pdev, netdev);
 
@@ -1165,20 +1162,9 @@ static int ftmac100_probe(struct platform_device *pdev)
 	netif_napi_add(netdev, &priv->napi, ftmac100_poll);
 
 	/* map io memory */
-	priv->res = request_mem_region(res->start, resource_size(res),
-				       dev_name(&pdev->dev));
-	if (!priv->res) {
-		dev_err(&pdev->dev, "Could not reserve memory region\n");
-		err = -ENOMEM;
-		goto err_req_mem;
-	}
-
-	priv->base = ioremap(res->start, resource_size(res));
-	if (!priv->base) {
-		dev_err(&pdev->dev, "Failed to ioremap ethernet registers\n");
-		err = -EIO;
-		goto err_ioremap;
-	}
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
 
 	priv->irq = irq;
 
@@ -1208,32 +1194,17 @@ static int ftmac100_probe(struct platform_device *pdev)
 	return 0;
 
 err_register_netdev:
-	iounmap(priv->base);
-err_ioremap:
-	release_resource(priv->res);
-err_req_mem:
 	netif_napi_del(&priv->napi);
-defer_get_mac:
-	free_netdev(netdev);
-err_alloc_etherdev:
 	return err;
 }
 
 static void ftmac100_remove(struct platform_device *pdev)
 {
-	struct net_device *netdev;
-	struct ftmac100 *priv;
-
-	netdev = platform_get_drvdata(pdev);
-	priv = netdev_priv(netdev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct ftmac100 *priv = netdev_priv(netdev);
 
 	unregister_netdev(netdev);
-
-	iounmap(priv->base);
-	release_resource(priv->res);
-
 	netif_napi_del(&priv->napi);
-	free_netdev(netdev);
 }
 
 static const struct of_device_id ftmac100_of_ids[] = {
-- 
2.54.0


