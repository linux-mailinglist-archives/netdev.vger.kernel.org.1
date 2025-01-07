Return-Path: <netdev+bounces-155920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123AA045D1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CC218878C7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE51F6675;
	Tue,  7 Jan 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4C42Xkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFA1F3D4C
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266137; cv=none; b=F17NusbJnshyvpy1AlBFX/h39yWltzI8+T9KzMxCczWDdXCTxS3yCAwLey1JJqmzg0TEy0fxBcQ2SSoA4JsHtaplfm7if6jN3lh6tphX4lt4whr6XQjS51sQNn+saB/9M3pmgyoKr1/ZrANR/RmqYQ/VfNE3IXjz1BwUesGrhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266137; c=relaxed/simple;
	bh=9WUIun7vfS520YBITwy8P+aLt7r8APq873Bb1o69+Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDOdbxv4EgMxYB+cpHh1Sc7YxWM/G3QP+w6oM/1QLuorKoZ3duU8r4goaam/34P1mPLiphI5PWxzLu86VAAuRH/Ky6BXCyVedWOkOBz++3JssmAS4tVfZBuy+VeRW/asPtRJ2tgkN39Xm95MxWfvu+lzOxKzmGiRu4WaD+/bdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4C42Xkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDECDC4CEE0;
	Tue,  7 Jan 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266137;
	bh=9WUIun7vfS520YBITwy8P+aLt7r8APq873Bb1o69+Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4C42XkvA/K5KmsF4MuXtdQtdHL2ClPRYPmIJaHhR9rqc2j0As22YZ4BTkuNb1r2S
	 IcXN98YVX7zrj7SOlNiJn6yxXWgEIH/tf7PtiVLorDYttGWX8nMS6SGrGqxzOZLyuM
	 cxJz9dDzUSxBb14oo23QGX0qcbcxSUE1ElOLjtjSu9Ql95ohuGELN+LA/cNdMB9wzm
	 +aOjcKYhnMGC6QFvch/k6fVWpcj05zNAg6HPT4xZQo5dClaUJxGM+czOFvn5uDXQ5T
	 ZIPClv+NyJANwEJZsWZzba6eYZ7CEQ98upSotRHgzOcTInFJ078Nm1mGvPcN056MUq
	 VVjkGy0GxT9sA==
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
Subject: [PATCH net-next v2 6/8] netdevsim: add queue management API support
Date: Tue,  7 Jan 2025 08:08:44 -0800
Message-ID: <20250107160846.2223263-7-kuba@kernel.org>
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

Add queue management API support. We need a way to reset queues
to test NAPI reordering, the queue management API provides a
handy scaffolding for that.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - don't null-check page pool before page_pool_destroy()
 - controled -> controlled
---
 drivers/net/netdevsim/netdev.c    | 134 +++++++++++++++++++++++++++---
 drivers/net/netdevsim/netdevsim.h |   2 +
 2 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 7b80796dbe26..cfb079a34532 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -359,25 +359,24 @@ static int nsim_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
-static int nsim_create_page_pool(struct nsim_rq *rq)
+static int nsim_create_page_pool(struct page_pool **p, struct napi_struct *napi)
 {
-	struct page_pool_params p = {
+	struct page_pool_params params = {
 		.order = 0,
 		.pool_size = NSIM_RING_SIZE,
 		.nid = NUMA_NO_NODE,
-		.dev = &rq->napi.dev->dev,
-		.napi = &rq->napi,
+		.dev = &napi->dev->dev,
+		.napi = napi,
 		.dma_dir = DMA_BIDIRECTIONAL,
-		.netdev = rq->napi.dev,
+		.netdev = napi->dev,
 	};
+	struct page_pool *pool;
 
-	rq->page_pool = page_pool_create(&p);
-	if (IS_ERR(rq->page_pool)) {
-		int err = PTR_ERR(rq->page_pool);
+	pool = page_pool_create(&params);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
 
-		rq->page_pool = NULL;
-		return err;
-	}
+	*p = pool;
 	return 0;
 }
 
@@ -396,7 +395,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		err = nsim_create_page_pool(rq);
+		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
 		if (err)
 			goto err_pp_destroy;
 	}
@@ -613,6 +612,116 @@ static void nsim_queue_free(struct nsim_rq *rq)
 	kfree(rq);
 }
 
+/* Queue reset mode is controlled by ns->rq_reset_mode.
+ * - normal - new NAPI new pool (old NAPI enabled when new added)
+ * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
+ * - mode 2 - new NAPI new pool (old NAPI removed before new added)
+ * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
+ */
+struct nsim_queue_mem {
+	struct nsim_rq *rq;
+	struct page_pool *pp;
+};
+
+static int
+nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
+{
+	struct nsim_queue_mem *qmem = per_queue_mem;
+	struct netdevsim *ns = netdev_priv(dev);
+	int err;
+
+	if (ns->rq_reset_mode > 3)
+		return -EINVAL;
+
+	if (ns->rq_reset_mode == 1)
+		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
+
+	qmem->rq = nsim_queue_alloc();
+	if (!qmem->rq)
+		return -ENOMEM;
+
+	err = nsim_create_page_pool(&qmem->rq->page_pool, &qmem->rq->napi);
+	if (err)
+		goto err_free;
+
+	if (!ns->rq_reset_mode)
+		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+
+	return 0;
+
+err_free:
+	nsim_queue_free(qmem->rq);
+	return err;
+}
+
+static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
+{
+	struct nsim_queue_mem *qmem = per_queue_mem;
+	struct netdevsim *ns = netdev_priv(dev);
+
+	page_pool_destroy(qmem->pp);
+	if (qmem->rq) {
+		if (!ns->rq_reset_mode)
+			netif_napi_del(&qmem->rq->napi);
+		page_pool_destroy(qmem->rq->page_pool);
+		nsim_queue_free(qmem->rq);
+	}
+}
+
+static int
+nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
+{
+	struct nsim_queue_mem *qmem = per_queue_mem;
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (ns->rq_reset_mode == 1) {
+		ns->rq[idx]->page_pool = qmem->pp;
+		napi_enable(&ns->rq[idx]->napi);
+		return 0;
+	}
+
+	/* netif_napi_add()/_del() should normally be called from alloc/free,
+	 * here we want to test various call orders.
+	 */
+	if (ns->rq_reset_mode == 2) {
+		netif_napi_del(&ns->rq[idx]->napi);
+		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+	} else if (ns->rq_reset_mode == 3) {
+		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_del(&ns->rq[idx]->napi);
+	}
+
+	ns->rq[idx] = qmem->rq;
+	napi_enable(&ns->rq[idx]->napi);
+
+	return 0;
+}
+
+static int nsim_queue_stop(struct net_device *dev, void *per_queue_mem, int idx)
+{
+	struct nsim_queue_mem *qmem = per_queue_mem;
+	struct netdevsim *ns = netdev_priv(dev);
+
+	napi_disable(&ns->rq[idx]->napi);
+
+	if (ns->rq_reset_mode == 1) {
+		qmem->pp = ns->rq[idx]->page_pool;
+		page_pool_disable_direct_recycling(qmem->pp);
+	} else {
+		qmem->rq = ns->rq[idx];
+	}
+
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
+	.ndo_queue_mem_size	= sizeof(struct nsim_queue_mem),
+	.ndo_queue_mem_alloc	= nsim_queue_mem_alloc,
+	.ndo_queue_mem_free	= nsim_queue_mem_free,
+	.ndo_queue_start	= nsim_queue_start,
+	.ndo_queue_stop		= nsim_queue_stop,
+};
+
 static ssize_t
 nsim_pp_hold_read(struct file *file, char __user *data,
 		  size_t count, loff_t *ppos)
@@ -739,6 +848,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
+	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 80fde64f4a7a..8c50969b1240 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -103,6 +103,8 @@ struct netdevsim {
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
+	int rq_reset_mode;
+
 	u64 tx_packets;
 	u64 tx_bytes;
 	u64 tx_dropped;
-- 
2.47.1


