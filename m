Return-Path: <netdev+bounces-29471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD822783620
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B34C280F40
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8A1ADE8;
	Mon, 21 Aug 2023 23:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8723DF
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA1130
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659408; x=1724195408;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7yfKoEb/+5CMNMdyZVEgPorrACEW/cL+HbTA4KIup8=;
  b=PYzHPhtr4nu8FFodumg4pg/BCPEnStHB13Tt+bE4wGjpVFUtdHrr6dHz
   exUYddKYHtj4IgAiVSgTnSQNcwGpAndhULR3LXsaj17x/v3xDjzjrdvoe
   hs5DTauRFwgP0MX8wJ7SJ4eAzSjZtKMFhohMyC+QX+GblWNccBin8ae0R
   tePU3CrwFusakLODcqHgJl5AHgAMF1eI8zTJVm2MK0g9DH1ypkScjZdmJ
   czvUO+tMAvFwAUws+BKu6Zy4hv0xvrBVCsrAlnxgpfd30bXf3fTEtZis4
   c9U6GDRqvXgzKzwBAAYq32E2y5Y90hcUbXhrvgsNHii6Fv3q/c1FcHMob
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404723888"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="404723888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765543058"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="765543058"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 16:10:08 -0700
Subject: [net-next PATCH v2 1/9] net: Introduce new fields for napi and
 queue associations
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:15 -0700
Message-ID: <169266031496.10199.9655642930215889099.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the napi pointer in netdev queue for tracking the napi
instance for each queue. This achieves the queue<->napi mapping.

Introduce new napi fields 'napi_rxq_list' and 'napi_txq_list'
for rx and tx queue set associated with the napi. Add functions
to associate the queue with the napi and handle their removal
as well. This lists the queue/queue-set on the corresponding
irq line for each napi instance.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 include/linux/netdevice.h     |   16 +++++++++++++
 include/net/netdev_rx_queue.h |    3 ++
 net/core/dev.c                |   52 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..7645c0ba0995 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -346,6 +346,14 @@ struct gro_list {
  */
 #define GRO_HASH_BUCKETS	8
 
+/*
+ * napi queue container type
+ */
+enum q_type {
+	QUEUE_RX,
+	QUEUE_TX,
+};
+
 /*
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
@@ -380,6 +388,8 @@ struct napi_struct {
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
+	struct list_head	napi_rxq_list;
+	struct list_head	napi_txq_list;
 };
 
 enum {
@@ -655,6 +665,9 @@ struct netdev_queue {
 
 	unsigned long		state;
 
+	/* NAPI instance for the queue */
+	struct napi_struct      *napi;
+	struct list_head        q_list;
 #ifdef CONFIG_BQL
 	struct dql		dql;
 #endif
@@ -2609,6 +2622,9 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
+			 enum q_type type);
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..66bda0dfe71c 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -21,6 +21,9 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	struct list_head		q_list;
+	/* NAPI instance for the queue */
+	struct napi_struct		*napi;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index 17e6281e408c..ec4c469c9e1d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6391,6 +6391,42 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 }
 EXPORT_SYMBOL(dev_set_threaded);
 
+/**
+ * netif_napi_add_queue - Associate queue with the napi
+ * @napi: NAPI context
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ *
+ * Add queue with its corresponding napi context
+ */
+int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
+			 enum q_type type)
+{
+	struct net_device *dev = napi->dev;
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	if (!dev)
+		return -EINVAL;
+
+	switch (type) {
+	case QUEUE_RX:
+		rxq = __netif_get_rx_queue(dev, queue_index);
+		rxq->napi = napi;
+		list_add_rcu(&rxq->q_list, &napi->napi_rxq_list);
+		break;
+	case QUEUE_TX:
+		txq = netdev_get_tx_queue(dev, queue_index);
+		txq->napi = napi;
+		list_add_rcu(&txq->q_list, &napi->napi_txq_list);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(netif_napi_add_queue);
+
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {
@@ -6426,6 +6462,9 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = 0;
+
+	INIT_LIST_HEAD(&napi->napi_rxq_list);
+	INIT_LIST_HEAD(&napi->napi_txq_list);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
@@ -6487,6 +6526,18 @@ static void flush_gro_hash(struct napi_struct *napi)
 	}
 }
 
+static void napi_del_queues(struct napi_struct *napi)
+{
+	struct netdev_rx_queue *rx_queue, *rxq;
+	struct netdev_queue *tx_queue, *txq;
+
+	list_for_each_entry_safe(rx_queue, rxq, &napi->napi_rxq_list, q_list)
+		list_del_rcu(&rx_queue->q_list);
+
+	list_for_each_entry_safe(tx_queue, txq, &napi->napi_txq_list, q_list)
+		list_del_rcu(&tx_queue->q_list);
+}
+
 /* Must be called in process context */
 void __netif_napi_del(struct napi_struct *napi)
 {
@@ -6504,6 +6555,7 @@ void __netif_napi_del(struct napi_struct *napi)
 		kthread_stop(napi->thread);
 		napi->thread = NULL;
 	}
+	napi_del_queues(napi);
 }
 EXPORT_SYMBOL(__netif_napi_del);
 


