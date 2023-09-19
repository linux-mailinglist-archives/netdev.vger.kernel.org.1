Return-Path: <netdev+bounces-35091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91FE7A6E88
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67691C20323
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2743B2AA;
	Tue, 19 Sep 2023 22:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256E3B291
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD4C0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161732; x=1726697732;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WhHfZAjvfhDGHypHoZliu8btlXYu7HXtD48tDwbRmt8=;
  b=hHkbzRIAATdP1DldouVxh+Q+CyR/V8IVJHCxQznYmuy9chpdnwKj7zlq
   LiWHW7/udINpHlB871M82lY1VGWCBeBu8ftpVRSzeH4jo5f4fwF5KRGVZ
   mw5J1JTZkstZdn1mC04RaMjHV2M6dRlyk+d5kQMafk6827fySkaeSllKU
   bI5O9gkr+oEeOz7R3eC/4DPi+o1GRUnwpyTwFCl6vpBrgkp9a95VMD7Fl
   SZMdTo/g0HNJEfVWTuyV0hXI2ngXEPxSRyi3Cd/AWeX0bBCgxThz3S6Ng
   iXjQwVZVDKI+j39LwdDn6YziUEhHLwlVuXmm7xYOrEEfuYLLBSEUbk4E1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="382813030"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="382813030"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="1077162435"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="1077162435"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2023 15:11:57 -0700
Subject: [net-next PATCH v3 02/10] net: Add queue and napi association
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:27:25 -0700
Message-ID: <169516244584.7377.16939532936643936800.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
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

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/linux/netdevice.h     |    5 +++++
 include/net/netdev_rx_queue.h |    2 ++
 net/core/dev.c                |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index db3d8429d50d..69e363918e4b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -657,6 +657,8 @@ struct netdev_queue {
 
 	unsigned long		state;
 
+	/* NAPI instance for the queue */
+	struct napi_struct      *napi;
 #ifdef CONFIG_BQL
 	struct dql		dql;
 #endif
@@ -2618,6 +2620,9 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
+			 enum netdev_queue_type type);
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..2e65b03d214d 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -21,6 +21,8 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	/* NAPI instance for the queue */
+	struct napi_struct		*napi;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index cc03a5758d2d..508b1d799681 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6394,6 +6394,40 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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
+			 enum netdev_queue_type type)
+{
+	struct net_device *dev = napi->dev;
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	if (!dev)
+		return -EINVAL;
+
+	switch (type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		rxq = __netif_get_rx_queue(dev, queue_index);
+		rxq->napi = napi;
+		break;
+	case NETDEV_QUEUE_TYPE_TX:
+		txq = netdev_get_tx_queue(dev, queue_index);
+		txq->napi = napi;
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


