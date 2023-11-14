Return-Path: <netdev+bounces-47552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E87EA752
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542D61F23668
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611E763E;
	Tue, 14 Nov 2023 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXg1IGO8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0A1382
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:14:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907201A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920842; x=1731456842;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gej+ZdcTtDOYftpNmzLvRzwfwTzN9GJu4blbvokrUjc=;
  b=iXg1IGO8Oj6gn/FG98vk2CCMMUXlZjZ4vdWpfdQQL+1/jpp0T4xrlrS1
   5Tgz3i9G8nJHPoqy8iv1fPKJE/lov2l7YYq9BNJRqEWO8ra942PQF72Ko
   vBOFfGrbH2pC6uH/GcoaSADg3LZg1GkU+xSGio5uS66lrsAl++09uYFkA
   tkd7Kaw2NggL974bqnk/f/Xs19EpTKzzNDCY3mSkFkG+QjOhE84xY1NLL
   T9N8HGgSgua30+TGkMP8zv+pUZbXwPXf2psxc9sGTnX96ey/rYZ6eCTnS
   eaBDg4So/4I74jjd8cwGqI/7SPD8yjs7jOyz9d06voxvoNcVoOFPtfRyQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393397577"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393397577"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011697898"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011697898"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2023 16:14:01 -0800
Subject: [net-next PATCH v7 08/10] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:30:17 -0800
Message-ID: <169992181700.3867.10355452259461924823.stgit@anambiarhost.jf.intel.com>
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

Add support to associate the interrupt vector number for a
NAPI instance.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c |    2 ++
 include/linux/netdevice.h                |    6 ++++++
 net/core/dev.c                           |    1 +
 net/core/netdev-genl.c                   |    4 ++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e2c24853376f..9662fbfef366 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2968,6 +2968,8 @@ void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
 	ice_for_each_tx_ring(tx_ring, q_vector->tx)
 		ice_queue_set_napi(tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
 				   &q_vector->napi, locked);
+	/* Also set the interrupt number for the NAPI */
+	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
 }
 
 /**
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8c8010e78240..c347ef0ebb54 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -382,6 +382,7 @@ struct napi_struct {
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
+	int			irq;
 };
 
 enum {
@@ -2650,6 +2651,11 @@ void __netif_queue_set_napi(unsigned int queue_index,
 			    enum netdev_queue_type type,
 			    struct napi_struct *napi);
 
+static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
+{
+	napi->irq = irq;
+}
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ae5c353b58e..8b9187f5f706 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6477,6 +6477,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = 0;
+	netif_napi_set_irq(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index f2441d73a972..6ea0a1f441f0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -167,7 +167,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
 		goto nla_put_failure;
 
+	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
+
 	return 0;
 
 nla_put_failure:


