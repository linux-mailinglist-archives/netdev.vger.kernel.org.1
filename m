Return-Path: <netdev+bounces-53141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A0801751
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8861F210FB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC03F8DB;
	Fri,  1 Dec 2023 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2JxC+X1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF80D90
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701472326; x=1733008326;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FCzJN/iqtjbB7m5QOWUp+z/VEjPtpEeqXBsVlCqr1z0=;
  b=T2JxC+X1daoOP2d/d9Zw7ORTEXFb/jVW83hAZWLsUlEQybSrs2YyQKL8
   yr7ud5jth+lmt84/7jT82AWCG/uY8CZBt9WCLxo6gRvusAd1bcrFUi4F2
   BUOytaevQHYAUQNlt7Mw/xkYjDb4F91dvHpzRGBcBI5pFY/2pfMFsGUM1
   seamAf9Wy847bXW/ol3h8Fv/o+t77GsI7ptiGI8038BuxnszcxGBbjlQD
   pwoRPIdD0DL6h+pvu2YN7Rwv0RKDw/TPKwsH8paDAhuPnmEpR3od8ZBCE
   +RWvFbVGGHsCFMq99k6w9GdMUa0SlGwHmzIeo0Up+st3YQWznwtjXZon4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="397450585"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="397450585"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1017177783"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1017177783"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2023 15:12:05 -0800
Subject: [net-next PATCH v11 02/11] net: Add queue and napi association
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 01 Dec 2023 15:28:34 -0800
Message-ID: <170147331483.5260.15723438819994285695.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
References: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
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
 include/linux/netdevice.h     |    8 ++++++++
 include/net/netdev_rx_queue.h |    4 ++++
 net/core/dev.c                |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c2d74bc112dd..5ddff11cbe26 100644
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
@@ -2657,6 +2661,10 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+			  enum netdev_queue_type type,
+			  struct napi_struct *napi);
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
index 3950ced396b5..0a2eecbeef38 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6400,6 +6400,43 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 }
 EXPORT_SYMBOL(dev_set_threaded);
 
+/**
+ * netif_queue_set_napi - Associate queue with the napi
+ * @dev: device to which NAPI and queue belong
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context, pass NULL to clear previously set NAPI
+ *
+ * Set queue with its corresponding napi context. This should be done after
+ * registering the NAPI handler for the queue-vector and the queues have been
+ * mapped to the corresponding interrupt vector.
+ */
+void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+			  enum netdev_queue_type type, struct napi_struct *napi)
+{
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	if (WARN_ON_ONCE(napi && !napi->dev))
+		return;
+	if (dev->reg_state >= NETREG_REGISTERED)
+		ASSERT_RTNL();
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
+EXPORT_SYMBOL(netif_queue_set_napi);
+
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {


