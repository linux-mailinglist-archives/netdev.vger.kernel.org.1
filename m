Return-Path: <netdev+bounces-155066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB399A00E2B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381817A02FA
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19D1FCFC5;
	Fri,  3 Jan 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrUZ2hbv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930D1FCF7D
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930802; cv=none; b=Z8Db6blLwlWB7wvBzn+FGt/k1xqeqHzK5s5dlW6R8AcEiXvbJWY7gtSzavhscEkYxxCzEbOB3HACmEmkiRztUqHrCjz3OKO901+7D6GzvR4r+xuwxb4Wbp7N0iumNSUJMG0IlmsRi6kGVzArL8EDB2Di2OzL/ff6BlE6e7oJEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930802; c=relaxed/simple;
	bh=GB8er5N5aTfpvBvUiPDisLOcyXBV9UmnYw5M58Mqxm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpRhtaKYwKtAVn3l2xl5gZMtZ77Cy/znJV8S0QwhQ3dw7r79WOU3/w3uJdF3WcKuP7G1BsG3xyjHN7SxMV+Z/yLwCPwb9R/ROke+DiUtCowaCNlt91eeTnOZA1SdDo1WWfHagWl1p1pGWNBCUMz3l6LzMMLb7qiPjEd6XguwugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrUZ2hbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700C8C4CED2;
	Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930801;
	bh=GB8er5N5aTfpvBvUiPDisLOcyXBV9UmnYw5M58Mqxm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrUZ2hbvd4FKwJZhecauxtaR54xSD8HBB4RrBhNfXFeKBMl5StYOvSB/uvvZ+VwIT
	 FpTGXbuHwb5T909aKcLWkGlEn/OKy8ahX1VQEHqrvwciXzMfk/8OIfTBltX3mvaYRT
	 AKJrihzXeUMM5rCNG+wfwzFvXZg/ofdxHvXzvSd39KNkUlhqg5qRvehFKcWQmM+F92
	 PtWGS/k7owFF+iXdcnvmcmHqV60zor4c5Tkq/0O0MHpvLJ5ZYj+wX6CkWqeM+NTUvY
	 2/9SbxsUXW4hP0ehOsfYJanKkQSZtb0QWmxt8diqIqiJr1RcOrIkOKJjeZyiNpReLl
	 bUl9G4vmGpK4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/8] netdevsim: add queue management API support
Date: Fri,  3 Jan 2025 10:59:51 -0800
Message-ID: <20250103185954.1236510-7-kuba@kernel.org>
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

Add queue management API support. We need a way to reset queues
to test NAPI reordering, the queue management API provides a
handy scaffolding for that.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c    | 135 +++++++++++++++++++++++++++---
 drivers/net/netdevsim/netdevsim.h |   2 +
 2 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e1bd3c1563b7..86614292314a 100644
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
@@ -613,6 +612,117 @@ static void nsim_queue_free(struct nsim_rq *rq)
 	kfree(rq);
 }
 
+/* Queue reset mode is controled by ns->rq_reset_mode.
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
+	if (qmem->pp)
+		page_pool_destroy(qmem->pp);
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
@@ -739,6 +849,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
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


