Return-Path: <netdev+bounces-42454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17AF7CEC54
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462CCB21245
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E746668;
	Wed, 18 Oct 2023 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2OrD/sw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AEE46661
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:50:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E2B6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697673051; x=1729209051;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8yFd5fb8RL8u4u+6P21yFe0rX+38DvKkE1NkECi+/c=;
  b=Y2OrD/sww3wuPYwdhxf0Xy4rFRU1U/TWL36d57kEtkrozhiSvAPtT067
   MdQl6iho9yUFqAegxV/t5R4pM/TVpKVRNGzRqQaRMduysL9PaD40bUbRb
   XgQwU3fXNeAWZIjJhYKbGkSs7dAQgmZRJ6/UsmllCuxYk98rxfbKSSqS3
   BAWrf3UMWN3Afb0aO05yupe3ASmKCWdI6ZezfgohviCSgH4utT7SQxwdz
   riFlYi4DSANZpm/CrXmoCI97I+H2xfgzTuq62VBf6uXgY/HLHHVgPKX6i
   Q20rXVzKbfS16ibLn/0VkQ6Tq5TMp74zoEUSP1ei2Qei5nXgDWR9kHKNg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365490319"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="365490319"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088163391"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1088163391"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2023 16:50:51 -0700
Subject: [net-next PATCH v5 08/10] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Wed, 18 Oct 2023 17:06:44 -0700
Message-ID: <169767400457.6692.15838564106849160162.stgit@anambiarhost.jf.intel.com>
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
index 97ca8f9f77a2..752d1616c894 100644
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
index 875933f86f41..4adf5d6e3558 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -382,6 +382,7 @@ struct napi_struct {
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
+	int			irq;
 };
 
 enum {
@@ -2623,6 +2624,11 @@ void __netif_queue_set_napi(unsigned int queue_index,
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
index 1b0f40921efc..242a7cde577b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6482,6 +6482,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = 0;
+	napi->irq = -1;
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index d6ef7fc093d0..ad4b1ee0a2d1 100644
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


