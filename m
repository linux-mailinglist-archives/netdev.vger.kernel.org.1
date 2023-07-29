Return-Path: <netdev+bounces-22478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5613767992
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDDE28285A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5031392;
	Sat, 29 Jul 2023 00:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E015BD
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:11 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6CE48
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590730; x=1722126730;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Anlup+/S8CMrAde87dR1WlNsa5+8g75mgxiqhK7v2Hs=;
  b=USVqKv5MCUgDVznbdgx7DPApyho7vCVQiKxcKR+BoQAWD4+zeKRkzI9F
   Q0Fz2iYkLkSK3Bwc+DG3PNehOiv6SiKZN/2Q0B+CfUW7PW0eKXdmdxYRL
   egb+F17u9cZpry5U7xrHegfpjC+esZtBK8qBAFlK8SkB6d/tQeSMJ87WY
   3SdTUlCAjEK/GgidklFhCSqnPHxPysdPPJzUnpDgbBatAtvdcSsRYZlSU
   yaPV9yHNKFiuTUUrcXs+6u5hIE5msJ0I7DEyn4eKyZfFhXJR9P7RiJZig
   WH61IQAjJceRubpbnX8SnH+P2ouXYPRx93IwzeN9kiHIdg1AKQ276++gP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="455069297"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="455069297"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="757358731"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="757358731"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 17:32:09 -0700
Subject: [net-next PATCH v1 1/9] net: Introduce new fields for napi and
 queue associations
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:46:56 -0700
Message-ID: <169059161688.3736.18170697577939556255.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/netdevice.h |   19 ++++++++++++++++
 net/core/dev.c            |   52 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 84c36a7f873f..7299872bfdff 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -342,6 +342,14 @@ struct gro_list {
  */
 #define GRO_HASH_BUCKETS	8
 
+/*
+ * napi queue container type
+ */
+enum queue_type {
+	NAPI_QUEUE_RX,
+	NAPI_QUEUE_TX,
+};
+
 /*
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
@@ -376,6 +384,8 @@ struct napi_struct {
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
+	struct list_head	napi_rxq_list;
+	struct list_head	napi_txq_list;
 };
 
 enum {
@@ -651,6 +661,9 @@ struct netdev_queue {
 
 	unsigned long		state;
 
+	/* NAPI instance for the queue */
+	struct napi_struct      *napi;
+	struct list_head        q_list;
 #ifdef CONFIG_BQL
 	struct dql		dql;
 #endif
@@ -796,6 +809,9 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	struct list_head		q_list;
+	/* NAPI instance for the queue */
+	struct napi_struct		*napi;
 } ____cacheline_aligned_in_smp;
 
 /*
@@ -2618,6 +2634,9 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
+			 enum queue_type type);
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index b58674774a57..875023ab614c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6389,6 +6389,42 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 }
 EXPORT_SYMBOL(dev_set_threaded);
 
+/**
+ * netif_napi_add_queue - Associate queue with the napi
+ * @napi: NAPI context
+ * @queue_index: Index of queue
+ * @queue_type: queue type as RX or TX
+ *
+ * Add queue with its corresponding napi context
+ */
+int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
+			 enum queue_type type)
+{
+	struct net_device *dev = napi->dev;
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	if (!dev)
+		return -EINVAL;
+
+	switch (type) {
+	case NAPI_QUEUE_RX:
+		rxq = __netif_get_rx_queue(dev, queue_index);
+		rxq->napi = napi;
+		list_add_rcu(&rxq->q_list, &napi->napi_rxq_list);
+		break;
+	case NAPI_QUEUE_TX:
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
@@ -6424,6 +6460,9 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = 0;
+
+	INIT_LIST_HEAD(&napi->napi_rxq_list);
+	INIT_LIST_HEAD(&napi->napi_txq_list);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
@@ -6485,6 +6524,18 @@ static void flush_gro_hash(struct napi_struct *napi)
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
@@ -6502,6 +6553,7 @@ void __netif_napi_del(struct napi_struct *napi)
 		kthread_stop(napi->thread);
 		napi->thread = NULL;
 	}
+	napi_del_queues(napi);
 }
 EXPORT_SYMBOL(__netif_napi_del);
 


