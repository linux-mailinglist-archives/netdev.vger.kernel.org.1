Return-Path: <netdev+bounces-207923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116AB09092
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7D17AF2D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AEE2F8C52;
	Thu, 17 Jul 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4D8E906X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AE2F85F5
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766134; cv=none; b=MH2LV0lZif+X/E9axVTQ8CnNYVnTehl53D5uUnBZtZGVCY3IIBmRJFl51Pn3b7droLUqyMINFEeX4sBWK0XXWd05q2Tdcqwx7W+23omIwAKHPJNTr0iZNww8eHPJeTfcS5co6WA90x+a4WwNIGtZWbKDOxc+IUcuTdDRyGnskvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766134; c=relaxed/simple;
	bh=Ksek1jq4bgQnHtHPjYXimxCPNu+P3UDu88fs9vwC4UI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pCir/yysA3Xk5QT8hkD8kXRl1fl7pwOqoBdkTt7Bw41G9hCdWrEM060uD+0LdxdffyZ9cU70brjtEty2N7Sq+noCzucE3Xk7hwSMDz9/55R0ZofGpxiFbOGvtQpCg89dmMlK/3k4E7DSkPWaMk2AwjyqppfLs+E7b4g97C+qiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4D8E906X; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-749177ad09fso525894b3a.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752766132; x=1753370932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WIk8YOSIS+Pqnbx/OqM6PIa47QIXC7QErRsaLAJmlI=;
        b=4D8E906XWa79IQkaEO+yQoNDve0IC2AasW1q5sVtoaliLSIDW7SM93I/rBuL1Cf210
         b7zFvDR70tBo4pR671IONYeI7B3s1bNKSfo45ubQW5DsGXXy1sJqyU1Wl6xwIuSusxPY
         WXPzi45X4yya0btkpxBfwSvw2B8/VtnYSfTvL811NJ9OtpG+t938XaH2MGgvp1FzNhBY
         agtGrZeIIYDWyqp0pAQCdRXqAwiTHAjTA9baFPmzas3Wg5u80/gz+3xll7yDBYScMyr7
         rDQwDUgLVFwGfrBdzVcj1flNwRSZcMeDNvR61emjUXtU2nMfhOzY9MGtnPWmoJZdhbA/
         PWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766132; x=1753370932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WIk8YOSIS+Pqnbx/OqM6PIa47QIXC7QErRsaLAJmlI=;
        b=ChY78mmZGItlV9JOJq8OIkSs2Z1SnGlGnDtONzkl0Yck9eylR3GSQ3z4tJ3iFW+shF
         9sDUkoII42Pe7UB7eVrn4pAvC1MnPZu6WPBseVpYCw9VatVZcm2ICw4mfKJlLmNlRXwt
         MHD5ya1FoQ1Ens4a/9tTUKIVX7Yd+8h/lMJ/4s3WXduuiJmDlTZ1+sQu2CBCZSjY8E0q
         QwMfE4RJ6CbTK36ImFE+0jVwv5Iv5oCk2n36Sv9RIgc1ST8593UUGONxUvMI16uBXPKo
         2auSOqXRAWQSGTRDy4FhjAEuZW2S3VzfjA6J2dWCpurrmRcWc+LrXZSPr/HyQaUyFC6f
         qWgg==
X-Gm-Message-State: AOJu0YyIw6o6ZvGT2Vjyb7YuFYTD0D+y17dJ65aNlbp+yhO6oOSxhrfZ
	RZlnrpzvjl7D8USIHdKyxRR49tVsw8VZQyJhHzCBy/jOhS2yaqvtUk4DZbXNz7ZOKXBy6Xm2swm
	BlDuCjjZAn471wYRDFhtmdtWwMtx5liHvGhAksdROE1hHPooUNboCu725pCteZTmccq/aKgWk5c
	faTf01Iq8O2kWTEFYnvHEE6lvZX+fYbyj5Zv6uxBlqGGldwz4=
X-Google-Smtp-Source: AGHT+IHmPg1mcY50QBjKIBJTDsDlMnEzHbOfamNfzvbDtxw9VCaFVxw3g5a1TBWGF/RiPJgierM4ruqcPmf0Qg==
X-Received: from pfbjt4.prod.google.com ([2002:a05:6a00:91c4:b0:747:a8e8:603e])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c90:b0:757:51d:9af9 with SMTP id d2e1a72fcca58-7571f716dcemr9767171b3a.0.1752766132192;
 Thu, 17 Jul 2025 08:28:52 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:28:35 -0700
In-Reply-To: <20250717152839.973004-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717152839.973004-2-jeroendb@google.com>
Subject: [PATCH net-next v2 1/5] gve: deduplicate xdp info and xsk pool
 registration logic
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

The XDP registration path currently has a lot of reused logic, leading
changes to the codepaths to be unnecessarily complex. gve_reg_xsk_pool
extracts the logic of registering an XSK pool with a queue into a method
that can be used by both XDP_SETUP_XSK_POOL and gve_reg_xdp_info.
gve_unreg_xdp_info is used to undo XDP info registration in the error
path instead of explicitly unregistering the XDP info, as it is more
complete and idempotent.

This patch will be followed by other changes to the XDP registration
logic, and will simplify those changes due to the use of common methods.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 169 ++++++++++-----------
 1 file changed, 83 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index be461751ff31..5aca3145e6ab 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1158,13 +1158,75 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
 static void gve_turndown(struct gve_priv *priv);
 static void gve_turnup(struct gve_priv *priv);
 
+static void gve_unreg_xsk_pool(struct gve_priv *priv, u16 qid)
+{
+	struct gve_rx_ring *rx;
+
+	if (!priv->rx)
+		return;
+
+	rx = &priv->rx[qid];
+	rx->xsk_pool = NULL;
+	if (xdp_rxq_info_is_reg(&rx->xsk_rxq))
+		xdp_rxq_info_unreg(&rx->xsk_rxq);
+
+	if (!priv->tx)
+		return;
+	priv->tx[gve_xdp_tx_queue_id(priv, qid)].xsk_pool = NULL;
+}
+
+static int gve_reg_xsk_pool(struct gve_priv *priv, struct net_device *dev,
+			    struct xsk_buff_pool *pool, u16 qid)
+{
+	struct napi_struct *napi;
+	struct gve_rx_ring *rx;
+	u16 tx_qid;
+	int err;
+
+	rx = &priv->rx[qid];
+	napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
+	err = xdp_rxq_info_reg(&rx->xsk_rxq, dev, qid, napi->napi_id);
+	if (err)
+		return err;
+
+	err = xdp_rxq_info_reg_mem_model(&rx->xsk_rxq,
+					 MEM_TYPE_XSK_BUFF_POOL, pool);
+	if (err) {
+		gve_unreg_xsk_pool(priv, qid);
+		return err;
+	}
+
+	rx->xsk_pool = pool;
+
+	tx_qid = gve_xdp_tx_queue_id(priv, qid);
+	priv->tx[tx_qid].xsk_pool = pool;
+
+	return 0;
+}
+
+static void gve_unreg_xdp_info(struct gve_priv *priv)
+{
+	int i;
+
+	if (!priv->tx_cfg.num_xdp_queues || !priv->rx)
+		return;
+
+	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
+		struct gve_rx_ring *rx = &priv->rx[i];
+
+		if (xdp_rxq_info_is_reg(&rx->xdp_rxq))
+			xdp_rxq_info_unreg(&rx->xdp_rxq);
+
+		gve_unreg_xsk_pool(priv, i);
+	}
+}
+
 static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 {
 	struct napi_struct *napi;
 	struct gve_rx_ring *rx;
 	int err = 0;
-	int i, j;
-	u32 tx_qid;
+	int i;
 
 	if (!priv->tx_cfg.num_xdp_queues)
 		return 0;
@@ -1188,59 +1250,20 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 		if (err)
 			goto err;
 		rx->xsk_pool = xsk_get_pool_from_qid(dev, i);
-		if (rx->xsk_pool) {
-			err = xdp_rxq_info_reg(&rx->xsk_rxq, dev, i,
-					       napi->napi_id);
-			if (err)
-				goto err;
-			err = xdp_rxq_info_reg_mem_model(&rx->xsk_rxq,
-							 MEM_TYPE_XSK_BUFF_POOL, NULL);
-			if (err)
-				goto err;
-			xsk_pool_set_rxq_info(rx->xsk_pool,
-					      &rx->xsk_rxq);
-		}
-	}
+		if (!rx->xsk_pool)
+			continue;
 
-	for (i = 0; i < priv->tx_cfg.num_xdp_queues; i++) {
-		tx_qid = gve_xdp_tx_queue_id(priv, i);
-		priv->tx[tx_qid].xsk_pool = xsk_get_pool_from_qid(dev, i);
+		err = gve_reg_xsk_pool(priv, dev, rx->xsk_pool, i);
+		if (err)
+			goto err;
 	}
 	return 0;
 
 err:
-	for (j = i; j >= 0; j--) {
-		rx = &priv->rx[j];
-		if (xdp_rxq_info_is_reg(&rx->xdp_rxq))
-			xdp_rxq_info_unreg(&rx->xdp_rxq);
-		if (xdp_rxq_info_is_reg(&rx->xsk_rxq))
-			xdp_rxq_info_unreg(&rx->xsk_rxq);
-	}
+	gve_unreg_xdp_info(priv);
 	return err;
 }
 
-static void gve_unreg_xdp_info(struct gve_priv *priv)
-{
-	int i, tx_qid;
-
-	if (!priv->tx_cfg.num_xdp_queues || !priv->rx || !priv->tx)
-		return;
-
-	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
-		struct gve_rx_ring *rx = &priv->rx[i];
-
-		xdp_rxq_info_unreg(&rx->xdp_rxq);
-		if (rx->xsk_pool) {
-			xdp_rxq_info_unreg(&rx->xsk_rxq);
-			rx->xsk_pool = NULL;
-		}
-	}
-
-	for (i = 0; i < priv->tx_cfg.num_xdp_queues; i++) {
-		tx_qid = gve_xdp_tx_queue_id(priv, i);
-		priv->tx[tx_qid].xsk_pool = NULL;
-	}
-}
 
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
@@ -1555,9 +1578,6 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 			       u16 qid)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct napi_struct *napi;
-	struct gve_rx_ring *rx;
-	int tx_qid;
 	int err;
 
 	if (qid >= priv->rx_cfg.num_queues) {
@@ -1579,30 +1599,12 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 	if (!priv->xdp_prog || !netif_running(dev))
 		return 0;
 
-	rx = &priv->rx[qid];
-	napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
-	err = xdp_rxq_info_reg(&rx->xsk_rxq, dev, qid, napi->napi_id);
+	err = gve_reg_xsk_pool(priv, dev, pool, qid);
 	if (err)
-		goto err;
-
-	err = xdp_rxq_info_reg_mem_model(&rx->xsk_rxq,
-					 MEM_TYPE_XSK_BUFF_POOL, NULL);
-	if (err)
-		goto err;
-
-	xsk_pool_set_rxq_info(pool, &rx->xsk_rxq);
-	rx->xsk_pool = pool;
-
-	tx_qid = gve_xdp_tx_queue_id(priv, qid);
-	priv->tx[tx_qid].xsk_pool = pool;
+		xsk_pool_dma_unmap(pool,
+				   DMA_ATTR_SKIP_CPU_SYNC |
+				   DMA_ATTR_WEAK_ORDERING);
 
-	return 0;
-err:
-	if (xdp_rxq_info_is_reg(&rx->xsk_rxq))
-		xdp_rxq_info_unreg(&rx->xsk_rxq);
-
-	xsk_pool_dma_unmap(pool,
-			   DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	return err;
 }
 
@@ -1615,17 +1617,17 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	struct xsk_buff_pool *pool;
 	int tx_qid;
 
-	pool = xsk_get_pool_from_qid(dev, qid);
-	if (!pool)
-		return -EINVAL;
 	if (qid >= priv->rx_cfg.num_queues)
 		return -EINVAL;
 
-	/* If XDP prog is not installed or interface is down, unmap DMA and
-	 * return.
-	 */
-	if (!priv->xdp_prog || !netif_running(dev))
-		goto done;
+	pool = xsk_get_pool_from_qid(dev, qid);
+	if (pool)
+		xsk_pool_dma_unmap(pool,
+				   DMA_ATTR_SKIP_CPU_SYNC |
+				   DMA_ATTR_WEAK_ORDERING);
+
+	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
+		return 0;
 
 	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
 	napi_disable(napi_rx); /* make sure current rx poll is done */
@@ -1634,9 +1636,7 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
 	napi_disable(napi_tx); /* make sure current tx poll is done */
 
-	priv->rx[qid].xsk_pool = NULL;
-	xdp_rxq_info_unreg(&priv->rx[qid].xsk_rxq);
-	priv->tx[tx_qid].xsk_pool = NULL;
+	gve_unreg_xsk_pool(priv, qid);
 	smp_mb(); /* Make sure it is visible to the workers on datapath */
 
 	napi_enable(napi_rx);
@@ -1647,9 +1647,6 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
 		napi_schedule(napi_tx);
 
-done:
-	xsk_pool_dma_unmap(pool,
-			   DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	return 0;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


