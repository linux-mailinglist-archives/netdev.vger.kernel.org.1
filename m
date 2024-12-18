Return-Path: <netdev+bounces-152970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F49F675F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25637164D26
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761D1DDA34;
	Wed, 18 Dec 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXWbzG2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3A1B423B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528872; cv=none; b=q5B9zUH/THhHomyqbec6GDujGYb+FZbhXDS3FTgiiTmlY0SAIhng9DgVBWxDidwprB+BYq0NF1ix/gJO9yCO39UpCvBwJwYtT1wVD13WgO/0iGUX7GkAl3HixCp96x90h3CSN7BXEOERDPB5hJpm16LVKxK1c7bB/yXVkXOZdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528872; c=relaxed/simple;
	bh=9BgVkXA7sAnOzdE3qY+1AbaUb+6u5iOoRd5soMYqiXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V5fpilfONRv4fOMVVa4BMg6tH74dM3HMIJU3Bx9uW78kFoUqGKpL3h1iIol6RG33IPCjiz4c1vyqbIHK3zhiYyH0fVni7FG3b/Lse9tuJghBEgSRXY2HK7k4gYyablqjSVA3fheXvnf6P9gM0MhzWzRS3BLeGZDU1XGhrMzZD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXWbzG2m; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e8775611so5598538b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528870; x=1735133670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BaCLJGMJQz1qP4MJHET69CAtZwrd4CwtIMp86qT77Mc=;
        b=IXWbzG2mrE2Dgmp2VecBKZDqSTOTG+1q7SmlCb1dvlnUzHgd4wOwi5xd0t1j+XuxTX
         kAL2IEiCdUngsEiCuXaxY57WrRB1F7LE0RqRErFQEukXROCcX2q9uXy85pQZy50QGK1x
         ZfTsg31xaQ0ZmFeJMAa4VusJOuN6pNg7ZesloqvjFO+2WvK/TKh77xhU9H9nJUBw9wLz
         s4cIFFlES+h9i8E0FwqT9KG4pdE+a2AELeSsKNHICC8GIar9umw3LUgGkfv2qVjJ0ssb
         2ngQZHly+V4Mu1tC5706hCbX72a/EEVpj1mg/viqpAXmvS+rvlxfFBdT7fanj2esiAXJ
         ob3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528870; x=1735133670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaCLJGMJQz1qP4MJHET69CAtZwrd4CwtIMp86qT77Mc=;
        b=ikzhqfAXtlViMoLc0q6x9/wMirjBroSaHMhfZrOntI9aOYNc9ZxLu7DeBN51EvGd5p
         VrNRettF+qynNSRxGnkRIDgSN7VhwOhIJLaZnRdeR6f3AirWFnAoBOHBiFlHsF6zkz29
         YQ/tOlOt6gjI613N5NH4Sb1Iu+krtOEotr7mFouBeyrXx3ZySut+Y9viK0qz2JQ+xkzE
         QpJqZpcQakY//yT01QXZqtVkYR1EoQfsAiv6bV+tmEF0kV0ylDE9x+5ZviR5b9vWCvPy
         UEK/s1TvM2GoJifEUGdt5Tvw19H3hmy3xPnkAjg79wWT0FHXaz96jlj5C0u+Vh2SkG6F
         NMMg==
X-Gm-Message-State: AOJu0YwUQ/wTBLc3+SXB0LSb313zTyo7Bt5JajSpUTpAC4SSYu0DV1uG
	EcWJKPdHaVvJXm3vNdoSvtS0wRxRCp6TUNSRLBksuELeJSb+hmI3bAi8nHhIS0eXl4rcH/R3q5X
	nC6lBwWSnVqTy/mDKKktPIGeJ9x1jHfEaIVF9MKdgDvz14j1cn4BWhUY+WMkfX6sYODJyJpoWOr
	0kpFRQD6ovge6U8NPQEbWln0Phx4+k1c8EiU6avGAFV9ANLRC1OUj6jTYnYw7YtZQt
X-Google-Smtp-Source: AGHT+IEtLKXZPbOvOiUsezPjGdVej+2Jrgenj3uZFiHh0CPqYPWhY/GVn4ZOUteMHaxZiVYXA9nTm51H7JWqV6EAjaI=
X-Received: from pgmt35.prod.google.com ([2002:a63:2263:0:b0:7fd:5835:26d1])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:8408:b0:1e1:c26d:d7fd with SMTP id adf61e73a8af0-1e5b48a0f20mr4449943637.37.1734528870243;
 Wed, 18 Dec 2024 05:34:30 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:13 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-4-pkaligineedi@google.com>
Subject: [PATCH net 3/5] gve: guard XSK operations on the existence of queues
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch predicates the enabling and disabling of XSK pools on the
existence of queues. As it stands, if the interface is down, disabling
or enabling XSK pools would result in a crash, as the RX queue pointer
would be NULL. XSK pool registration will occur as part of the next
interface up.

Similarly, xsk_wakeup needs be guarded against queues disappearing
while the function is executing, so a check against the
GVE_PRIV_FLAGS_NAPI_ENABLED flag is added to synchronize with the
disabling of the bit and the synchronize_net() in gve_turndown.

Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5d7b0cc59959..e4e8ff4f9f80 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1623,8 +1623,8 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 	if (err)
 		return err;
 
-	/* If XDP prog is not installed, return */
-	if (!priv->xdp_prog)
+	/* If XDP prog is not installed or interface is down, return. */
+	if (!priv->xdp_prog || !netif_running(dev))
 		return 0;
 
 	rx = &priv->rx[qid];
@@ -1669,21 +1669,16 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	if (qid >= priv->rx_cfg.num_queues)
 		return -EINVAL;
 
-	/* If XDP prog is not installed, unmap DMA and return */
-	if (!priv->xdp_prog)
+	/* If XDP prog is not installed or interface is down, unmap DMA and
+	 * return.
+	 */
+	if (!priv->xdp_prog || !netif_running(dev))
 		goto done;
 
-	tx_qid = gve_xdp_tx_queue_id(priv, qid);
-	if (!netif_running(dev)) {
-		priv->rx[qid].xsk_pool = NULL;
-		xdp_rxq_info_unreg(&priv->rx[qid].xsk_rxq);
-		priv->tx[tx_qid].xsk_pool = NULL;
-		goto done;
-	}
-
 	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
 	napi_disable(napi_rx); /* make sure current rx poll is done */
 
+	tx_qid = gve_xdp_tx_queue_id(priv, qid);
 	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
 	napi_disable(napi_tx); /* make sure current tx poll is done */
 
@@ -1711,6 +1706,9 @@ static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	struct gve_priv *priv = netdev_priv(dev);
 	int tx_queue_id = gve_xdp_tx_queue_id(priv, queue_id);
 
+	if (!gve_get_napi_enabled(priv))
+		return -ENETDOWN;
+
 	if (queue_id >= priv->rx_cfg.num_queues || !priv->xdp_prog)
 		return -EINVAL;
 
-- 
2.47.1.613.gc27f4b7a9f-goog


