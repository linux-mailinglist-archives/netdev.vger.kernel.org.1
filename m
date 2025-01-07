Return-Path: <netdev+bounces-155918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D73A04599
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5566D3A2DC8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA31F7064;
	Tue,  7 Jan 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMWsolpw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9E1F669F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266136; cv=none; b=n4Vm6RdLhvpZRi+S6b3Ch0aeWGdu99o/MYeGmr8avwsZiFRHN9XGSlt8AJwVY8q1Myjo3DiAh7SN0MvJTDczQv50Y7WRkQ3Dq8Ve9bCA6d3Tppwp05YmTr7rsL0wNf7l2al5xmZwt620taGFNn/5LzFbLilkIPwwdg3NO+YgC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266136; c=relaxed/simple;
	bh=2xt7SNuQjXFRdzF8hB7QfBBy7uWWe77Qh43cdPEOh8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaoXXoGaVBt/qztvDbWopJR0P0AQK2AxfY9KGL9dCZDBLWNUXPWn7DHilWl4guwgg0Yb0f5upDrAIs4nOy9EshdG4I+Div7oLz8nMToQuxLXJJUSdKpfhgzRlPBi+iWRCP2UUQosXDvnUlLoCsFUtxZqIbk3tRSjtApIoMCz+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMWsolpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DCDC4CEE1;
	Tue,  7 Jan 2025 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266136;
	bh=2xt7SNuQjXFRdzF8hB7QfBBy7uWWe77Qh43cdPEOh8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMWsolpwRSWznU/bNSxOs+kZ2UfbfFgpRcnb3AWxmt5X53w0MPjwDXcloXbOMl/ch
	 oj/mcvKJhx3ET/PUSJvHCrcF1j+0Urf+oqmGjCeXVD1CL0G6ehLQWSFuYAqFL3UGhG
	 JV2KVDGBy6zucy6IOyqnM9sKXrEjm0lLBrs+IfSR6nzIL1dBViNIDrlU5HLfiGsYWd
	 06Z2rcWZ7FSh/UW4FSqU4nGsOwteqvmSxBKTeR+HHxzECEIzVoNbUmbuX5mUCOOwUH
	 1zvuwmvJqLE1UYK8FxWEb10B9IzKxIVdRtrsnATv0y+oCAMUlk0O8rHkaE3L1u6sZZ
	 RNhQOpRBrE/tQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 4/8] netdevsim: allocate rqs individually
Date: Tue,  7 Jan 2025 08:08:42 -0800
Message-ID: <20250107160846.2223263-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
References: <20250107160846.2223263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make nsim->rqs an array of pointers and allocate them individually
so that we can swap them out one by one.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - allocate the array with kcalloc() instead of kvcalloc()
 - set GFP_KERNEL_ACCOUNT when allocating queues
---
 drivers/net/netdevsim/netdev.c    | 49 +++++++++++++++++++------------
 drivers/net/netdevsim/netdevsim.h |  2 +-
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a4aacd372cdd..7fa75f37ec49 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -69,7 +69,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	rxq = skb_get_queue_mapping(skb);
 	if (rxq >= peer_dev->num_rx_queues)
 		rxq = rxq % peer_dev->num_rx_queues;
-	rq = &peer_ns->rq[rxq];
+	rq = peer_ns->rq[rxq];
 
 	skb_tx_timestamp(skb);
 	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
@@ -388,13 +388,13 @@ static int nsim_init_napi(struct netdevsim *ns)
 	int err, i;
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-		rq = &ns->rq[i];
+		rq = ns->rq[i];
 
 		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-		rq = &ns->rq[i];
+		rq = ns->rq[i];
 
 		err = nsim_create_page_pool(rq);
 		if (err)
@@ -405,12 +405,12 @@ static int nsim_init_napi(struct netdevsim *ns)
 
 err_pp_destroy:
 	while (i--) {
-		page_pool_destroy(ns->rq[i].page_pool);
-		ns->rq[i].page_pool = NULL;
+		page_pool_destroy(ns->rq[i]->page_pool);
+		ns->rq[i]->page_pool = NULL;
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++)
-		__netif_napi_del(&ns->rq[i].napi);
+		__netif_napi_del(&ns->rq[i]->napi);
 
 	return err;
 }
@@ -421,7 +421,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 	int i;
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-		struct nsim_rq *rq = &ns->rq[i];
+		struct nsim_rq *rq = ns->rq[i];
 
 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
 		napi_enable(&rq->napi);
@@ -448,7 +448,7 @@ static void nsim_del_napi(struct netdevsim *ns)
 	int i;
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-		struct nsim_rq *rq = &ns->rq[i];
+		struct nsim_rq *rq = ns->rq[i];
 
 		napi_disable(&rq->napi);
 		__netif_napi_del(&rq->napi);
@@ -456,8 +456,8 @@ static void nsim_del_napi(struct netdevsim *ns)
 	synchronize_net();
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-		page_pool_destroy(ns->rq[i].page_pool);
-		ns->rq[i].page_pool = NULL;
+		page_pool_destroy(ns->rq[i]->page_pool);
+		ns->rq[i]->page_pool = NULL;
 	}
 }
 
@@ -628,7 +628,7 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 	if (!netif_running(ns->netdev) && val) {
 		ret = -ENETDOWN;
 	} else if (val) {
-		ns->page = page_pool_dev_alloc_pages(ns->rq[0].page_pool);
+		ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
@@ -677,15 +677,26 @@ static int nsim_queue_init(struct netdevsim *ns)
 	struct net_device *dev = ns->netdev;
 	int i;
 
-	ns->rq = kvcalloc(dev->num_rx_queues, sizeof(*ns->rq),
-			  GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
+	ns->rq = kcalloc(dev->num_rx_queues, sizeof(*ns->rq),
+			 GFP_KERNEL_ACCOUNT);
 	if (!ns->rq)
 		return -ENOMEM;
 
-	for (i = 0; i < dev->num_rx_queues; i++)
-		skb_queue_head_init(&ns->rq[i].skb_queue);
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		ns->rq[i] = kzalloc(sizeof(**ns->rq), GFP_KERNEL_ACCOUNT);
+		if (!ns->rq[i])
+			goto err_free_prev;
+
+		skb_queue_head_init(&ns->rq[i]->skb_queue);
+	}
 
 	return 0;
+
+err_free_prev:
+	while (i--)
+		kfree(ns->rq[i]);
+	kfree(ns->rq);
+	return -ENOMEM;
 }
 
 static void nsim_queue_free(struct netdevsim *ns)
@@ -693,11 +704,13 @@ static void nsim_queue_free(struct netdevsim *ns)
 	struct net_device *dev = ns->netdev;
 	int i;
 
-	for (i = 0; i < dev->num_rx_queues; i++)
-		skb_queue_purge_reason(&ns->rq[i].skb_queue,
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		skb_queue_purge_reason(&ns->rq[i]->skb_queue,
 				       SKB_DROP_REASON_QUEUE_PURGE);
+		kfree(ns->rq[i]);
+	}
 
-	kvfree(ns->rq);
+	kfree(ns->rq);
 	ns->rq = NULL;
 }
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bf02efa10956..80fde64f4a7a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -101,7 +101,7 @@ struct netdevsim {
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
 	struct mock_phc *phc;
-	struct nsim_rq *rq;
+	struct nsim_rq **rq;
 
 	u64 tx_packets;
 	u64 tx_bytes;
-- 
2.47.1


