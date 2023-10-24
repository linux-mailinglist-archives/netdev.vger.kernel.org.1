Return-Path: <netdev+bounces-43706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D47D44CD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4171B2817AB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4834A29;
	Tue, 24 Oct 2023 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiVfbGf4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5577E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:17:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA0DE
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110271; x=1729646271;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwwW7XzzNAYjt/HTmDlkuxJdiNh6RrYtb6cirqVBNhc=;
  b=jiVfbGf4Ah1J9okjcdwUAdQaBdoW6yzPRtlOQxIejbT7/bGwR+UcJr6v
   OM4kyJZldICCeZVcZkWH501ndzXULEn+w8MuPRsEal9YAYrWI9uUmeVO6
   4407ez9ciIZ8E3Dee+3QJBD/9yhH3iieVdPWFykF+WkfwbJnWYiszMwHG
   Y4EMcWqw/aJOoN/C6QOXAl6XTDzZ9vVLc+poDNX6mmGJYPPu5bxgWNIyt
   3iC+V/Vd7xOVsXU8TWTqUkTJY7xf15LA5u1qlg/G4GuUx/CTG5TcnP6LG
   Ie0bmSxrSCLhcyqE7KqdS17xbdjewWgstgw+5373HikdtCRRMZ3kdSAPT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385857764"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385857764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708111837"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="708111837"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 18:17:50 -0700
Subject: [net-next PATCH v6 02/10] net: Add queue and napi association
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 23 Oct 2023 18:33:29 -0700
Message-ID: <169811120946.59034.3550609703322092104.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
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
index b8bf669212cc..f1e0d23a5465 100644
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
@@ -2635,6 +2639,13 @@ static inline void *netdev_priv(const struct net_device *dev)
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
index 1025dc79bc49..ba8fe3b6240b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6428,6 +6428,51 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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


