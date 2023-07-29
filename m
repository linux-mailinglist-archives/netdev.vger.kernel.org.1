Return-Path: <netdev+bounces-22484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A740B76799E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603FF2828C4
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54231642;
	Sat, 29 Jul 2023 00:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6D1FC9
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:41 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C51E48
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590760; x=1722126760;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qLP6bTGRaY6Hat5ponHRxDF0S86ONNymnH4iDGEz8oU=;
  b=J7mCbcZ7r7107jqVUO9FsP0FSN3t3D2f4RuQ/Q2YEpZh7tnVkFHrYYuJ
   O+9dhZIYQAsvf5Dg11Btgcb+tjpBSFq/c5fZmtJP+Kjfjk58Ng92gkeYz
   DwOVEDYdkf3PlXrV3g7M7yaogGx3grBzoeiyU+YQ7qIBZF74BJISEJGE3
   aMW95kRVHzd7L2ebAVMiqhzffPEXJRvQ9gcAbed8onEnZKJK6m4UVPG2v
   EYcrIRhOz7ieJZlRxDjWyOG580cg9xuUFLfcCprUhLv87fM4g0YoJPTpZ
   NDRGGNhZDSIgtAzM9ysoo1JdBKauzkq5PqDBPRq23JG9Sa5XgesPW45hb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742184"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742184"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851403966"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851403966"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 17:32:40 -0700
Subject: [net-next PATCH v1 7/9] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:28 -0700
Message-ID: <169059164799.3736.4793522919350631917.stgit@anambiarhost.jf.intel.com>
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

Add support to associate the interrupt vector number for a
NAPI instance.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c |    3 +++
 include/linux/netdevice.h                |    6 ++++++
 net/core/dev.c                           |    1 +
 net/core/netdev-genl.c                   |    4 ++++
 4 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 171177db8fb4..1ebd293ca7de 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2975,6 +2975,9 @@ int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
 			return ret;
 	}
 
+	/* Also set the interrupt number for the NAPI */
+	napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+
 	return ret;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7afbf346dfd1..a0ae6de1a4aa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -386,6 +386,7 @@ struct napi_struct {
 	struct hlist_node	napi_hash_node;
 	struct list_head	napi_rxq_list;
 	struct list_head	napi_txq_list;
+	int			irq;
 };
 
 enum {
@@ -2646,6 +2647,11 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+static inline void napi_set_irq(struct napi_struct *napi, int irq)
+{
+	napi->irq = irq;
+}
+
 int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
 			 enum queue_type type);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 875023ab614c..118f0b957b6e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6463,6 +6463,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 
 	INIT_LIST_HEAD(&napi->napi_rxq_list);
 	INIT_LIST_HEAD(&napi->napi_txq_list);
+	napi->irq = -1;
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index ca3ed6eb457b..8401f646a10b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,10 @@ netdev_nl_napi_fill_one(struct sk_buff *msg, struct napi_struct *napi)
 			goto nla_put_failure;
 	}
 
+	if (napi->irq >= 0)
+		if (nla_put_u32(msg, NETDEV_A_NAPI_INFO_ENTRY_IRQ, napi->irq))
+			goto nla_put_failure;
+
 	nla_nest_end(msg, napi_info);
 	return 0;
 nla_put_failure:


