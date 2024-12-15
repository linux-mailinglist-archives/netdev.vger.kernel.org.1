Return-Path: <netdev+bounces-152001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16B9F2516
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4886E18858BE
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A121922FB;
	Sun, 15 Dec 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxGWBJNF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5711758B
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284235; cv=none; b=u2L4/01KmwpLOrAF6QY1bqHoSYRvlZogieuqIg/CYD5ioweQvgMZJcmJ01VmCsaukZGk4Yr3gnevL3HKlkXP/wqTbJRVMDbU40AzmCuptYMJYOfuC/d/4tML3Gv5k/tMwLc5y9J3eIcs+tSnmf7gqqSiotpfTVgn1JWlWMIeDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284235; c=relaxed/simple;
	bh=TBeamio0Yi88VQx9QAOzcjx9B0WIvU23/rv2y0lsgUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SfkDvGuBL6MP1piDpH5q6T40jDOG2jZsGrukQdkiuKTjQpZ5labgVzKidkgRl2tyJ6eShFi+3jTkavDYBkC0oK4x+TPhLgKexpK1p7e+n6FdxSAW4R1WA3sUR7D8DaX1joGo6ynQ+DyBfWe+X+I3/XL+dEGwpOgDfGDZWoYFrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxGWBJNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD81CC4CECE;
	Sun, 15 Dec 2024 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734284235;
	bh=TBeamio0Yi88VQx9QAOzcjx9B0WIvU23/rv2y0lsgUU=;
	h=From:Date:Subject:To:Cc:From;
	b=IxGWBJNFTkuIx7OEwmQzxbwphC6qjzLuGzX7i5KWbEWX3qrsqGXGOIZIKdh1th6t8
	 Pfvmz4Ygr+iiLmUtVFRfKBYF7H52v9fQWWMHDVarTEvkCuF7Xet52BGHDPijiOrMcm
	 US19X+/9iwgFoVeByCHAlN8853g+Dq1lrRpl3WJS2rQhIaEx2HonHwXH6WsZfY2Z8d
	 L+I1+jbeFoZUNgXRxu7qSH1zyAGkx2hcN+ofCwyRmuX8Xs9J8QlteaJwdXs3isF7/i
	 JUpxkZjBs9KUB0QcykWxycPMC5ouj5Ey5VnfQptOPl/zim7N23U6C1/vEHMkWundPK
	 174ETO4j8EOdg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Dec 2024 18:36:35 +0100
Subject: [PATCH net-next] net: airoha: Fix error patch in airoha_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-airoha_probe-error-path-fix-v1-1-dd299122d343@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKITX2cC/x3MMQqEMBBG4avI1A4kQbfwKiKS6L+baUyYiAiSu
 xu2/F7xHipQQaGpe0hxSZF0NNi+oy364weWvZmccYN1dmQvmqJfs6YAhmpSzv6M/JWbx7B9AnY
 DZ0DtkBUt/+/zUusLT50CkW0AAAA=
X-Change-ID: 20241215-airoha_probe-error-path-fix-5bc6bed0e20e
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Do not run napi_disable if airoha_hw_init() fails since Tx/Rx napi
has not been started yet. In order to fix the issue, introduce
airoha_qdma_disable_napi routine and remove napi_disable in
airoha_hw_cleanup().

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 33 ++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 6c683a12d5aa52dd9d966df123509075a989c0b3..5bbf5fee2802135ff6083233d0bda78f2ba5606a 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2138,17 +2138,14 @@ static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_disable(&qdma->q_rx[i].napi);
 		netif_napi_del(&qdma->q_rx[i].napi);
 		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
 		if (qdma->q_rx[i].page_pool)
 			page_pool_destroy(qdma->q_rx[i].page_pool);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
-		napi_disable(&qdma->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
-	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
 		if (!qdma->q_tx[i].ndesc)
@@ -2173,6 +2170,21 @@ static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 	}
 }
 
+static void airoha_qdma_disable_napi(struct airoha_qdma *qdma)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+		napi_disable(&qdma->q_tx_irq[i].napi);
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
+			continue;
+
+		napi_disable(&qdma->q_rx[i].napi);
+	}
+}
+
 static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
@@ -2738,7 +2750,7 @@ static int airoha_probe(struct platform_device *pdev)
 
 	err = airoha_hw_init(pdev, eth);
 	if (err)
-		goto error;
+		goto error_hw_cleanup;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
@@ -2753,13 +2765,16 @@ static int airoha_probe(struct platform_device *pdev)
 		err = airoha_alloc_gdm_port(eth, np);
 		if (err) {
 			of_node_put(np);
-			goto error;
+			goto error_napi_disable;
 		}
 	}
 
 	return 0;
 
-error:
+error_napi_disable:
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_disable_napi(&eth->qdma[i]);
+error_hw_cleanup:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_hw_cleanup(&eth->qdma[i]);
 
@@ -2780,8 +2795,10 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+		airoha_qdma_disable_napi(&eth->qdma[i]);
 		airoha_hw_cleanup(&eth->qdma[i]);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];

---
base-commit: 2c2b61d2138f472e50b5531ec0cb4a1485837e21
change-id: 20241215-airoha_probe-error-path-fix-5bc6bed0e20e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


