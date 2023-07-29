Return-Path: <netdev+bounces-22481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC0976799A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283A41C21982
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1164C;
	Sat, 29 Jul 2023 00:32:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41418ECA
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:26 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2C2135
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590745; x=1722126745;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gDlfG5Y0zxxXm2SsfnjyAs6hq+ELU7wDDomhVeUPLHg=;
  b=N6J/7bonRg4kpdViOxXGaSVtm1FqvxsnFFjve1d1qGKw4sYlFEbzC5Wy
   1ijiVEk+Y5LIllGD1yRe4AurGpbt10g3XZq9vH5zZOfDmeBvxpPEHVrsj
   PX7vubDcG2/M6Le4VdJ/2WChPwJQwTPzL1BzaLbLpx8MrWTzJ/aSC1djh
   m3yNV2nPoTXfHhY99NAQCJhSJ0J5Bg2T7TgAqaANQfDYCLQIV8lkoGTU/
   1JD2yuZBRmYV3TtADaTX+mUkLgwcwx/oUjMSPl7w5YyRo2WNZkg3EUoPM
   yDAuCqdf+LwXyMagdxW4CGHoEnEFfMrb/XLwxerk/qJqY+8WOscy+LvV/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742094"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742094"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="901478093"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="901478093"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2023 17:32:24 -0700
Subject: [net-next PATCH v1 4/9] net: Move kernel helpers for queue index
 outside sysfs
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:12 -0700
Message-ID: <169059163270.3736.8406876462323444663.stgit@anambiarhost.jf.intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kernel helpers for retrieving tx/rx queue index
(get_netdev_queue_index and get_netdev_rx_queue_index)
are restricted to sysfs, move this out for more usability.
Also, replace BUG_ON with DEBUG_NET_WARN_ON_ONCE.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 include/linux/netdevice.h |   16 +++++++++++++---
 net/core/net-sysfs.c      |   11 -----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7299872bfdff..7afbf346dfd1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2515,6 +2515,18 @@ struct netdev_queue *netdev_get_tx_queue(const struct net_device *dev,
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
@@ -3856,17 +3868,15 @@ __netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
 	return dev->_rx + rxq;
 }
 
-#ifdef CONFIG_SYSFS
 static inline unsigned int get_netdev_rx_queue_index(
 		struct netdev_rx_queue *queue)
 {
 	struct net_device *dev = queue->dev;
 	int index = queue - dev->_rx;
 
-	BUG_ON(index >= dev->num_rx_queues);
+	DEBUG_NET_WARN_ON_ONCE(index >= dev->num_rx_queues);
 	return index;
 }
-#endif
 
 int netif_get_num_default_rss_queues(void);
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 15e3f4606b5f..9b900d0b6513 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1239,17 +1239,6 @@ static ssize_t tx_timeout_show(struct netdev_queue *queue, char *buf)
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


