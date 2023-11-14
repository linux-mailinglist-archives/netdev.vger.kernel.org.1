Return-Path: <netdev+bounces-47546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025267EA74B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12903B20AAC
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E713115A2;
	Tue, 14 Nov 2023 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2fTeP2p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24C1385
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E0115
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920806; x=1731456806;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wz93IKB+XjOVUSIkUW9DWnbGjuk6gzqZ5zw+/lYf3iA=;
  b=L2fTeP2pLg9fpQYCbJYAS4GnCuYI6KbEe5ZCZVuqAAzMGgqv2Q2QPAqM
   M9U71M7Z5hI1kXl5jJq2KZjrUeM0pS5JNa/P1UMNZcKaF27D+wdFFHZWx
   RZwX0aDRl2ss9rSdq03ADSmHw26gXVuNRRqC9ZRna0a/48hwbJgql/7gm
   Kp2RNNv3sNaQ6YOkIoMn06FS9nTZP0GEaRpiU/8PJlIpgYYNyvABmS8Zh
   cPUfw4dVN+tYdHciHlTzGJop+AQ68PbkAN2RnEUsy/qXU5VZYBO997/5G
   RdAqzie7WyxSE/HMB7aBYqHah+2ZOnfkvtiB5YMk72IdA11aGexBanLXI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3618612"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3618612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793569651"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="793569651"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2023 16:13:26 -0800
Subject: [net-next PATCH v7 02/10] net: Add queue and napi association
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:29:42 -0800
Message-ID: <169992178212.3867.2038917280785989662.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add the napi pointer in netdev queue for tracking the napi
instance for each queue. This achieves the queue<->napi mapping.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/linux/netdevice.h     |   11 ++++++++++
 include/net/netdev_rx_queue.h |    4 ++++
 net/core/dev.c                |   45 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a16c9cc063fe..8c8010e78240 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -665,6 +665,10 @@ struct netdev_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool    *pool;
 #endif
+	/* NAPI instance for the queue
+	 * Readers and writers must hold RTNL
+	 */
+	struct napi_struct      *napi;
 /*
  * write-mostly part
  */
@@ -2639,6 +2643,13 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+void netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
+			  struct napi_struct *napi);
+
+void __netif_queue_set_napi(unsigned int queue_index,
+			    enum netdev_queue_type type,
+			    struct napi_struct *napi);
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..aa1716fb0e53 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -21,6 +21,10 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	/* NAPI instance for the queue
+	 * Readers and writers must hold RTNL
+	 */
+	struct napi_struct		*napi;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..54ee5139ddd5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6398,6 +6398,51 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 }
 EXPORT_SYMBOL(dev_set_threaded);
 
+/**
+ * __netif_queue_set_napi - Associate queue with the napi
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context
+ *
+ * Set queue with its corresponding napi context. This should be done after
+ * registering the NAPI handler for the queue-vector and the queues have been
+ * mapped to the corresponding interrupt vector.
+ */
+void __netif_queue_set_napi(unsigned int queue_index,
+			    enum netdev_queue_type type,
+			    struct napi_struct *napi)
+{
+	struct net_device *dev = napi->dev;
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	if (WARN_ON_ONCE(!dev))
+		return;
+
+	switch (type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		rxq = __netif_get_rx_queue(dev, queue_index);
+		rxq->napi = napi;
+		return;
+	case NETDEV_QUEUE_TYPE_TX:
+		txq = netdev_get_tx_queue(dev, queue_index);
+		txq->napi = napi;
+		return;
+	default:
+		return;
+	}
+}
+EXPORT_SYMBOL(__netif_queue_set_napi);
+
+void netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
+			  struct napi_struct *napi)
+{
+	rtnl_lock();
+	__netif_queue_set_napi(queue_index, type, napi);
+	rtnl_unlock();
+}
+EXPORT_SYMBOL(netif_queue_set_napi);
+
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {


