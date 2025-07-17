Return-Path: <netdev+bounces-207924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C0B09093
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266063B17E0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171032F9485;
	Thu, 17 Jul 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOUuYlOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0F1DE3C3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766136; cv=none; b=d7VlH3tZxQoNK61pLm6xXPxyvjRUCU22gSS78l/zYvDr2aEJAYIuM+OPudeD5rED1njY/OBcppTfzBRVMo0xeP0+cB9kI2EQm2nbO/68BmPk6s0SV1Oq9nm3GZJ6eIjZ72dDN0FcrTtkUj2uM+2M7YiKGQbK396gl9n/tvfEnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766136; c=relaxed/simple;
	bh=4ybQ3K8hC2oeaLRU6GTatvUcm8mz19/5k9XDjHDoS0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJb56QSXaPARdhHBw6j1kXqFzWlywIRwPOygkeBTNuUHUYZaDuQBl2GUWU8kJ5P7XDeIc752shcsDk+/f7IlCetVx4c2fUzgKu+bmbeD8kFONkJJqfo8BNzCyyAiB69m9BZo+osP7tLc9GKSvK8M8pV6XjryALZWAd8ipAtC8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOUuYlOP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740774348f6so1160754b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752766134; x=1753370934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUmKUKaEtptNOlmG9+YNDHZKLXLolJ+xmPvkn0Z3lec=;
        b=JOUuYlOPCQBMChBcCVuEoZgWwaPAja9AcygT+TkiC9/4gHl+h18E/8Pj+aNxbNMW1J
         LSim5Ll7r5PEYP4nytNBnqeE7cgRiYWj2IJs56PdB5v1QhXG0fEjsF6cD2TmAzVYfuHG
         mxX388iTYdoG4yVlKon3YcDS96KeziiAqPni70Ie7St8eTEkkHV9pDyxpDSJf3QZI3Dl
         ctxjgIFKewwYLbUicT31zSxM8LYL4OcCgKwEqq0BOi7CAEO1P3HT0yp60ldc8wQPEdM5
         OqBZGlElGvfNzLrX0VLnqbo5Pvvna+YZTXO0sBodtMLrBPpgkTp52UzZzs7Nv+RpdTdn
         EpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766134; x=1753370934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUmKUKaEtptNOlmG9+YNDHZKLXLolJ+xmPvkn0Z3lec=;
        b=br5b6L3EK7NO7qB312hIWv9WGRg8wzXcv92rBY4+r7CgW14WE8S2qFahzseTHN/7MR
         IS0DXsgmC6RGHdtwLgnBTyvnPB6UCltgQHYIWT1myop4OcCC6BLg+Pjjksr382yipeKv
         o7iS+FpUrrNQUa1Z1oX1Kod9N+zs3NjmMVHwugr6lgTuYOTLk9wtasoovviJtOOlwnDd
         wnqolrol8ZWlXwW/OEthupm5l+SbAdYsYUJQA6lwRVnqr3fvgRfAa5pfBkn2rtDBWKU4
         TpD+lkrBRHPPKa3lXj56LY1VmbsC+3NxWB+Lxm7lj9zckats+8V5H7u0FU7df3gFBmLe
         P7Kg==
X-Gm-Message-State: AOJu0YzQS+S1+UzTdDueJHR51c6sYj/S/Sdf5Q0sNniSOWT6F15CitMB
	dH9P11L0WH+oCUrhJAiCNZox2F9YZ57l4jX1xMmu3fFCBAosQxc9Zrjr1a7I6fWmN+cNqoz25aO
	1TmZ8ck+rS+CmW9OE2MEwlFVkQrHtCUqujssI0AvNWYFkdjouf33YbzzvvA5h8+O1X7/gt2dIQg
	AWJnhHSRYRmLenJVr3PkoqRjo6hEhSYecLnUG+GESISI4pfN4=
X-Google-Smtp-Source: AGHT+IEDdXhpxgApgGLRMTO/+Fqdbms8K5w0fha8waoo+UeCpx4Zx0XM0GDk6Y6GIhQtSIIDW4S+R/4HiBWpgA==
X-Received: from pfblo8.prod.google.com ([2002:a05:6a00:3d08:b0:746:21fd:3f7a])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a14:b0:749:421:efcc with SMTP id d2e1a72fcca58-756e7faa901mr9271359b3a.5.1752766133583;
 Thu, 17 Jul 2025 08:28:53 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:28:36 -0700
In-Reply-To: <20250717152839.973004-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717152839.973004-3-jeroendb@google.com>
Subject: [PATCH net-next v2 2/5] gve: merge xdp and xsk registration
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

The existence of both of these xdp_rxq and xsk_rxq is redundant. xdp_rxq
can be used in both the zero-copy mode and the copy mode case. XSK pool
memory model registration is prioritized over normal memory model
registration to ensure that memory model registration happens only once
per queue.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
v2: Remove unused napi_struct pointer
---
 drivers/net/ethernet/google/gve/gve.h      |  1 -
 drivers/net/ethernet/google/gve/gve_main.c | 27 ++++++++--------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 53899096e89e..b2be3fca4125 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -331,7 +331,6 @@ struct gve_rx_ring {
 
 	/* XDP stuff */
 	struct xdp_rxq_info xdp_rxq;
-	struct xdp_rxq_info xsk_rxq;
 	struct xsk_buff_pool *xsk_pool;
 	struct page_frag_cache page_cache; /* Page cache to allocate XDP frames */
 };
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5aca3145e6ab..cf8e1abdfa8e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1167,8 +1167,8 @@ static void gve_unreg_xsk_pool(struct gve_priv *priv, u16 qid)
 
 	rx = &priv->rx[qid];
 	rx->xsk_pool = NULL;
-	if (xdp_rxq_info_is_reg(&rx->xsk_rxq))
-		xdp_rxq_info_unreg(&rx->xsk_rxq);
+	if (xdp_rxq_info_is_reg(&rx->xdp_rxq))
+		xdp_rxq_info_unreg_mem_model(&rx->xdp_rxq);
 
 	if (!priv->tx)
 		return;
@@ -1178,18 +1178,12 @@ static void gve_unreg_xsk_pool(struct gve_priv *priv, u16 qid)
 static int gve_reg_xsk_pool(struct gve_priv *priv, struct net_device *dev,
 			    struct xsk_buff_pool *pool, u16 qid)
 {
-	struct napi_struct *napi;
 	struct gve_rx_ring *rx;
 	u16 tx_qid;
 	int err;
 
 	rx = &priv->rx[qid];
-	napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
-	err = xdp_rxq_info_reg(&rx->xsk_rxq, dev, qid, napi->napi_id);
-	if (err)
-		return err;
-
-	err = xdp_rxq_info_reg_mem_model(&rx->xsk_rxq,
+	err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
 					 MEM_TYPE_XSK_BUFF_POOL, pool);
 	if (err) {
 		gve_unreg_xsk_pool(priv, qid);
@@ -1232,6 +1226,8 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 		return 0;
 
 	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
+		struct xsk_buff_pool *xsk_pool;
+
 		rx = &priv->rx[i];
 		napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
 
@@ -1239,7 +1235,11 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 				       napi->napi_id);
 		if (err)
 			goto err;
-		if (gve_is_qpl(priv))
+
+		xsk_pool = xsk_get_pool_from_qid(dev, i);
+		if (xsk_pool)
+			err = gve_reg_xsk_pool(priv, dev, xsk_pool, i);
+		else if (gve_is_qpl(priv))
 			err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
 							 MEM_TYPE_PAGE_SHARED,
 							 NULL);
@@ -1249,13 +1249,6 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 							 rx->dqo.page_pool);
 		if (err)
 			goto err;
-		rx->xsk_pool = xsk_get_pool_from_qid(dev, i);
-		if (!rx->xsk_pool)
-			continue;
-
-		err = gve_reg_xsk_pool(priv, dev, rx->xsk_pool, i);
-		if (err)
-			goto err;
 	}
 	return 0;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


