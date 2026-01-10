Return-Path: <netdev+bounces-248666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A07D0CD62
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 149EA3012AAD
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823A524E4C3;
	Sat, 10 Jan 2026 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="ah4Qwaf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCF22173D
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012132; cv=none; b=F0MAFYksmSjvLbvb+vO3Thj827cm69vfml1vxodq8d/dIdl8Y2buZmPDSVxwXY4qN1uCdTkARjji3I2iM2o4NScRgiO5fPSzFvBjGjKHuOWjeJNZWERoBjD7z2w8+x4IA7Z1ooYcEGa5hCEwHOv2BoQB8iAEGIWb9lllpLdp2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012132; c=relaxed/simple;
	bh=Dnxh8sb29haGhCiOAryzaMc9erxkIKQTcrK4cP1kif0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhNn/tVZO6qf6Rfa4879799nTV/pIXKh1BAKiUcVtdzs43hmbs6fbbW5ybDLIeuk8FTRVRn/Z9hYKgSKQNERtZliIRgvGT6wTk6YcAq2TbpYpFxA88Ai38qXFy450Q8r0N1yAA9AVy/l+U7MBM/aGgCqzfWtKReqesU+WdQHTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=ah4Qwaf/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c3259da34so3018867a91.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 18:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1768012129; x=1768616929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg1KQlHbkSdYgtTHkTb4TEaugE2VkLT6mkvL0fKcs9U=;
        b=ah4Qwaf/NPNgT+u65jSzLIP2XzHwRfKU3xnVyO3V6GKq3hutCN+WUqT7zZOaOcwz+7
         NFs2TZZBGx0tvD6J4LT5xTZMmLjMTDJYUemtfmxyJAiD2y9ipNI/QguAVSZQ8nd3eVfF
         CT2Ta3s0RoRuJsRh2eU67hEL+ib3+WBswktTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768012129; x=1768616929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg1KQlHbkSdYgtTHkTb4TEaugE2VkLT6mkvL0fKcs9U=;
        b=jfv1AGa11Gdq6/CZdRtVdL56BmN9h2X/o8tbpEEBeUt9IQAt9d4sWXnkpGe5iEZEtf
         ekbB2pZe9QMO8gu/ejJvFkKfl+LFowhigdUZ8DCeR6IiRc4ATREV9FM8XAxDDqE1Krg1
         j6BYV8PLOBzFENskUrdZT/bUAjiesR1m9HOxTQAKbBOxdwYDF2IUyFMe4p3FDHICvVfS
         nY6m1/kqJ549XZBlGlWpAx+/E74kzpDMC29UitydFx0OUc5K7j4u8UIj6X53Nax6UidT
         VkU52Ms3ORLzlkxFnCcQYrNEQeTBt0hnS1JeXUprEvH4rGZ8fE2cgPoICzUfl5gAHguB
         8jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGESDkEUhTvtZ/075EZQi3auSVUZTEzvzg1ACPQJ0hg9GfinJJfDE4E2bXKODN7JaXITxLNdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlI1KKc2ERCuCZvnFHp9HkVjA5bUsdVlqHFacK3JraKQq+szV
	JoE0TiiN6qdssCkCq6l1D3FYC2SXdto7cAYkNexqwuxSTpZANmj+aZbLem6NYisUqlw=
X-Gm-Gg: AY/fxX6Zc+o7QJSHhEYo8Bm3u+F2wgZYQRPUTmhLm9uP7gfeMNJliLROOHm18zHzofU
	o0K0s0eiG0jPOwTw31fJa5Y76CEMkxilNG2Fz4Kr67iu1lcMaqcd4TSLmZAQpZAoQiOxgIw+TLN
	aEOrJ8U9mcNNIfIItNwZ3Gg+cT2JaD/cDAT/qQr/Od1aLPpGmhRWT4rAAH39mPOldrfxiI5Mtqh
	tWOWcS6HI40Qi1WJ8UhN6H9QR9lnw1Gk9ELB2cbLbqLMKqW1Q5W6xMDtbny0gonZwkq7pBGQpn6
	PgFeW3fHdJyKIXZOyzX4/S8mAfKbroGCQeSOQln7iK2DwgkPZQvq60EK5sqIaxQUuz7NWzZUGUm
	eaONc/dnnzoIWU65frrHjQxczBEIowvRSLxgy3q7zj9ifHYVeQw6wcnOWbrrVTp8N2+WX1sDa4h
	5ZUBYb9h0PBIVb0TLW8BDyGwiOmuwTS+FvXFYkrGpYPoPapMydZC9MuskH+3bDFU3hX3WlQwL/j
	j8=
X-Google-Smtp-Source: AGHT+IFlo/9lxdre3yXq1NOxIeo0BBIcQbZRTk47Fc9YsAHDGaTVCagUQaR7bHJjPqhAzjeRLQ5C0w==
X-Received: by 2002:a17:90b:568d:b0:340:29a1:1b0c with SMTP id 98e67ed59e1d1-34f68bcf7damr12107186a91.7.1768012128887;
        Fri, 09 Jan 2026 18:28:48 -0800 (PST)
Received: from kinako.work.home.arpa (p1536247-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.212.247])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34f6b7b3e7fsm4368666a91.2.2026.01.09.18.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:28:48 -0800 (PST)
From: Daniel Palmer <daniel@thingy.jp>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacky_chou@aspeedtech.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] net: ftgmac100: reduce calls to of_device_is_compatible()
Date: Sat, 10 Jan 2026 11:28:27 +0900
Message-ID: <20260110022827.2067386-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftgmac100_probe() calls of_device_is_compatible() with the same arguments
multiple times.

Just call of_device_is_compatible() once for each variant, save the result
into a local variable and use the variable instead.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---

I am looking through callers to of_device_is_compatible() and noticed this.
I have build tested but I don't have this hardware so I haven't tested if
it works or not. I don't see why it wouldn't. This only saves 8 bytes of code
in my build so its not massive but I think the code makes more sense after
this.

 drivers/net/ethernet/faraday/ftgmac100.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a863f7841210..1588d3c79ddf 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1840,7 +1840,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct net_device *netdev;
 	struct phy_device *phydev;
 	struct ftgmac100 *priv;
-	struct device_node *np;
+	struct device_node *np = pdev->dev.of_node;
+	bool is_ast2400 = false;
+	bool is_ast2500 = false;
+	bool is_ast2600 = false;
 	int err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1900,10 +1903,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (err)
 		goto err_phy_connect;
 
-	np = pdev->dev.of_node;
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
+	if (np) {
+		is_ast2400 = of_device_is_compatible(np, "aspeed,ast2400-mac");
+		is_ast2500 = !is_ast2400 && of_device_is_compatible(np, "aspeed,ast2500-mac");
+		is_ast2600 = !is_ast2500 && of_device_is_compatible(np, "aspeed,ast2600-mac");
+	}
+
+	if (is_ast2400 || is_ast2500 || is_ast2600) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1948,8 +1954,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * available PHYs and register them.
 		 */
 		if (of_get_property(np, "phy-handle", NULL) &&
-		    (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		     of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
+		    (is_ast2400 || is_ast2500)) {
 			err = ftgmac100_setup_mdio(netdev);
 			if (err)
 				goto err_setup_mdio;
@@ -2001,7 +2006,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 
 		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		if (is_ast2600)
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
@@ -2019,11 +2024,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	/* AST2400  doesn't have working HW checksum generation */
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
+	if (is_ast2400)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	/* AST2600 tx checksum with NCSI is broken */
-	if (priv->use_ncsi && of_device_is_compatible(np, "aspeed,ast2600-mac"))
+	if (priv->use_ncsi && is_ast2600)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	if (np && of_get_property(np, "no-hw-checksum", NULL))
-- 
2.51.0


