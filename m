Return-Path: <netdev+bounces-155064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20879A00E29
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F214F1884B87
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320A1FCD13;
	Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk1UHclc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2161FCD04
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930801; cv=none; b=KbkYScUNpHQGxQdGR82L7gJ1lEAN4s3uahAMR/69Cr4P7HcXg+k/sCj2Z7sJii9WwFlyRcxkdz3EExo8WVjR0NoLhHbR8Pj7251wL4mTTYUSVajaJU97rC5xA7plnbrU4pVrIjlj+DEAshfsroApB8KW/YpdNle6w9foyGSGa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930801; c=relaxed/simple;
	bh=lWdqjdz3Q8Z/bU1gvZsxjA8UZ68ZbhNo/PSacBzpivI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY+p2th9zqHR6f/aA+DMgFoVNQQwQ5usss36IcPur5GA7SyrTbiS9fDUezCNtrjrbOtXQZ6KyztnYGwo5cejLo1HqvzXXJzGcIoySoJd8P7auMmGlrYR3lq74sIh/TfGsd6p8URuZplA+jnKNhb/6dxaTlu6eirN4oPG1hO8SZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk1UHclc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A564EC4CEE1;
	Fri,  3 Jan 2025 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930800;
	bh=lWdqjdz3Q8Z/bU1gvZsxjA8UZ68ZbhNo/PSacBzpivI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nk1UHclcADbbLcCV6az8q4jhMqvESb/qDLpiZA/q8jSZjALlTxO17fZFoM22g6uvG
	 ZLHRytO6VR7Sifc3ubLPxSr5g1/vTkA7psN7d0QO7/0TOoECz+2UKgV1usYIi6vtJE
	 y9vew+iSenyTd1K69hsnkFImkA208JuJ2t1EJ7JaGPSbDQ0EW1VoqssoQ+QMMRG4Ti
	 wLaVIei+QkM2Lsf+XWH7qUCwFyRpOjBn0uX/g4zbcUUoDSbHIcCw3xo6SeqUyqmklc
	 5soK5QEoZwLCg6xPnFgTkCQcWMqA6ozsyGFt6Q+kMIUomzc+9a3ATRmYPae/eN7zYK
	 vbRwXzP6KcSpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/8] netdevsim: allocate rqs individually
Date: Fri,  3 Jan 2025 10:59:49 -0800
Message-ID: <20250103185954.1236510-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make nsim->rqs an array of pointers and allocate them individually
so that we can swap them out one by one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c    | 43 ++++++++++++++++++++-----------
 drivers/net/netdevsim/netdevsim.h |  2 +-
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a4aacd372cdd..7487697ac417 100644
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
@@ -682,10 +682,21 @@ static int nsim_queue_init(struct netdevsim *ns)
 	if (!ns->rq)
 		return -ENOMEM;
 
-	for (i = 0; i < dev->num_rx_queues; i++)
-		skb_queue_head_init(&ns->rq[i].skb_queue);
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		ns->rq[i] = kzalloc(sizeof(**ns->rq), GFP_KERNEL);
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
@@ -693,9 +704,11 @@ static void nsim_queue_free(struct netdevsim *ns)
 	struct net_device *dev = ns->netdev;
 	int i;
 
-	for (i = 0; i < dev->num_rx_queues; i++)
-		skb_queue_purge_reason(&ns->rq[i].skb_queue,
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		skb_queue_purge_reason(&ns->rq[i]->skb_queue,
 				       SKB_DROP_REASON_QUEUE_PURGE);
+		kfree(ns->rq[i]);
+	}
 
 	kvfree(ns->rq);
 	ns->rq = NULL;
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


