Return-Path: <netdev+bounces-42447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4656C7CEC4B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9181F22381
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D994291C;
	Wed, 18 Oct 2023 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMpo1O7r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26F39861
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:50:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB5B6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697673019; x=1729209019;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zNf5N5Hj0TZEAShkPHcEpxA8vOHMRLq5cnguWV1pkeA=;
  b=DMpo1O7roVBkT+531sg3oA10yxMGMsR2OfzmckspB4gEPHHgfa3TCZ2k
   u9bIUm0a/6kZhZiGiUoHNHt1R7G8i11X2XYtRARPuqqZbNIcljoXu7LBh
   GIwmHylbH1QsGwaJTL4JIjQCrxPEWuK3iDhrxONP152AKJzmldCoUoEPZ
   Fw76zb6bAbczWNhnEcBuMVtROOyG6kskeJGtBPmq+tkPDEgSHUnso1cSu
   RSd52Qh4ZVnNwajUhypjezVq0BL9OgAkEZljGpS7TS62L3eNeR5QJp7oC
   xuzl0zcnhpZl/QtrhikmKUITd+Z2U4pYLYM5MS2Zv6WQBY3YQDXVdC5b+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452610910"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452610910"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004008957"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1004008957"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 16:50:18 -0700
Subject: [net-next PATCH v5 02/10] net: Add queue and napi association
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Wed, 18 Oct 2023 17:06:12 -0700
Message-ID: <169767397220.6692.3324690864702221211.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
References: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
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
index 1c7681263d30..875933f86f41 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -642,6 +642,10 @@ struct netdev_queue {
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
@@ -2612,6 +2616,13 @@ static inline void *netdev_priv(const struct net_device *dev)
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
index 97e7b9833db9..e8add4fcf53f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6403,6 +6403,51 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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


