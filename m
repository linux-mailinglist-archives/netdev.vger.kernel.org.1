Return-Path: <netdev+bounces-29474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767E783624
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D562D280F58
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF671ADDB;
	Mon, 21 Aug 2023 23:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE71B7E7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DC131
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659425; x=1724195425;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5+FQvVqJ0cJMRlbsHxdxetncKR68ITtto6XWrYXvu8s=;
  b=lwbbsWvg9PCADk6y8vLuFyzJAAaSxSJqNecKTZdEmRy9k2d1M5+eBv1o
   PLRHBmmc8rEQuVWVXBrW8B+FsvVtlUL2CHMK/N5y80Qxhmy+xcATi0/yo
   2WZNshBjcuTqTMHBWE2gJb2NikpnixZSpa4mpItXA8voHog0/B8IE8DdN
   FXUfOfDz8hTXUkFCtQqfVA0DZ1+FiWezp10vvONrG/EZmY9Sr1ojXvXB3
   NU1DcbLr131pqbdL7WMvX4nniv7rVbGTXNg2wihoIxeEFUiQXRRBui2iH
   cX3wxMBdSezmT0xY92QAqM85DqCub9W23/cGwupqvwi/F4GEdUqWm5LbH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358707711"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="358707711"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739086041"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="739086041"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 16:10:24 -0700
Subject: [net-next PATCH v2 4/9] net: Move kernel helpers for queue index
 outside sysfs
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:31 -0700
Message-ID: <169266033119.10199.3382453499474113876.stgit@anambiarhost.jf.intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kernel helpers for retrieving tx/rx queue index
(get_netdev_queue_index and get_netdev_rx_queue_index)
are restricted to sysfs, move this out for more usability.
Also, replace BUG_ON with DEBUG_NET_WARN_ON_ONCE.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 include/linux/netdevice.h     |   12 ++++++++++++
 include/net/netdev_rx_queue.h |    4 +---
 net/core/net-sysfs.c          |   11 -----------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7645c0ba0995..4ec86d9aceb2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2503,6 +2503,18 @@ struct netdev_queue *netdev_get_tx_queue(const struct net_device *dev,
 	return &dev->_tx[index];
 }
 
+static inline
+unsigned int get_netdev_queue_index(struct netdev_queue *queue)
+{
+	struct net_device *dev = queue->dev;
+	unsigned int i;
+
+	i = queue - dev->_tx;
+	DEBUG_NET_WARN_ON_ONCE(i >= dev->num_tx_queues);
+
+	return i;
+}
+
 static inline struct netdev_queue *skb_get_tx_queue(const struct net_device *dev,
 						    const struct sk_buff *skb)
 {
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 66bda0dfe71c..ac58fa7c2532 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -42,15 +42,13 @@ __netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
 	return dev->_rx + rxq;
 }
 
-#ifdef CONFIG_SYSFS
 static inline unsigned int
 get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 {
 	struct net_device *dev = queue->dev;
 	int index = queue - dev->_rx;
 
-	BUG_ON(index >= dev->num_rx_queues);
+	DEBUG_NET_WARN_ON_ONCE(index >= dev->num_rx_queues);
 	return index;
 }
 #endif
-#endif
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fccaa5bac0ed..858d50503e4f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1240,17 +1240,6 @@ static ssize_t tx_timeout_show(struct netdev_queue *queue, char *buf)
 	return sysfs_emit(buf, fmt_ulong, trans_timeout);
 }
 
-static unsigned int get_netdev_queue_index(struct netdev_queue *queue)
-{
-	struct net_device *dev = queue->dev;
-	unsigned int i;
-
-	i = queue - dev->_tx;
-	BUG_ON(i >= dev->num_tx_queues);
-
-	return i;
-}
-
 static ssize_t traffic_class_show(struct netdev_queue *queue,
 				  char *buf)
 {


