Return-Path: <netdev+bounces-43712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0A7D44D3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72A31C20B86
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06124C92;
	Tue, 24 Oct 2023 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2xKkHIJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA453AC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:18:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD37E8
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110302; x=1729646302;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+KcOBDTK4rHYWMAz2vQJFUNrOZmjHZ07yuvduJ/FdTs=;
  b=L2xKkHIJo0EygnUjB7QUWRtCA4KiYHyfhOVLeAPeAwF0isDypttzVW7m
   eSQslusYaSnt7NzhfaXJIdR+S/O9eIEkeaF/bC69JlgwwjCTJIzV9NvOl
   r/V+PqIKvtXQY/8yuH/30cFPJ9MoCI+6eoV9ws2lZvyZKpYc4htQAIYs0
   sWp9Td6OETkC4nInHFnhFVrQ3yU0WLUJdQ0/EFEaSyMZLXowzmcy89SoC
   xg0DxZqi5NNuPBIMwj8H6kje9P3JFIHPuUhPoTIJNeiiP0kg4vHkh7n/Q
   X0nzlc0+YkEp2HXqSjpzkCMFtBtLpqspL0Md0RSWTNLdkgt8DDFy0sFxT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366305785"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="366305785"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="761938444"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="761938444"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2023 18:18:22 -0700
Subject: [net-next PATCH v6 08/10] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 23 Oct 2023 18:34:01 -0700
Message-ID: <169811124126.59034.7955140077923696489.stgit@anambiarhost.jf.intel.com>
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
index f1e0d23a5465..361e814542ec 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -382,6 +382,7 @@ struct napi_struct {
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
+	int			irq;
 };
 
 enum {
@@ -2646,6 +2647,11 @@ void __netif_queue_set_napi(unsigned int queue_index,
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
index d02c7a0ce4bc..adf20fa02b93 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6507,6 +6507,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
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


