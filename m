Return-Path: <netdev+bounces-48521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A527EEA87
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1481C20A90
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B7A4F;
	Fri, 17 Nov 2023 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+vVwCNv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3977C5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700182863; x=1731718863;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fXMKyoDPTMXW6B7EVW/NP7OFpaHC7lMls8loqvxfkjA=;
  b=C+vVwCNvlv+ocPmI5LGtbvLHloFD7HV67gi57q5owQThWDHJS8R4sqLY
   wOYe0EW+p+SMW6bt9evzjq/FUbIyjZKNmluuBI/twpWfnacAiVsn8TCPK
   uEQSEjOPIectYeXVpldlBgBdBpZvORV/UPPL7r+Nr8ee7pqu/Qeq8+BqK
   GEy2lkxxTNZBFw5s/glt6czo9oZnjm4/HC/6BTYisbkEqK1jd/koBoskE
   BcdP7LB5MKLimv3I59MpuROn3xcU8I27svuCEUKP1g/bbcxKkYpCoK6KW
   3KjFD+X2fMnq0sJVDyTl9fxHJBnUoCzV7BLAicA8LcLshlKTqf505qx87
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4288587"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="4288587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:01:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="831449288"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="831449288"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2023 17:01:01 -0800
Subject: [net-next PATCH v8 08/10] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Thu, 16 Nov 2023 17:17:19 -0800
Message-ID: <170018383981.3767.17479333253313062987.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
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
index fcbfecdf5e5b..99ca59e18abf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6479,6 +6479,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = 0;
+	netif_napi_set_irq(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fda6d06995e0..d4d418c0e67e 100644
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


