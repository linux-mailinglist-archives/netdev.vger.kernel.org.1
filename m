Return-Path: <netdev+bounces-35089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61DF7A6E85
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E78628150D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40D53B299;
	Tue, 19 Sep 2023 22:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8393B2A9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A218B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161711; x=1726697711;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLx8fVuZh15akXWCp9UcvFpOWOlINaD8DcuqUqy1/fM=;
  b=AP2pD9Ae0vrxNKhz0DRlb40MDr9KzjA2Cuk6ONO0Dt5O+DvVWHWrPjdT
   vzFgQLQ3KuVmnNbAyv1K65iO6R6KnHaOv3ZCZoUGM8bNIdSQPtkEtQXKa
   sp1PGi14FBFIRy7nqeVE7V9ZcF3q0/dr35L2YJ56k5GiNHH90HdyKS5Z9
   WI2vR76uvUARFL9ABcGl6+TfEsL8kiCM2pmDqUVo1Bq4fIswk58v73l4B
   qGJDw8aMpH8XMd+DfBFEjwXSJf2g7kolhjMphu/lFSq3X9taiJ0yI5E+g
   BTw/vPIFcUo9mwcWFhbE8GDRLVESL4XRNCpB2m/OHB7rLXrDSCWQ8B5og
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383904077"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="383904077"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="696067142"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="696067142"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2023 15:12:28 -0700
Subject: [net-next PATCH v3 08/10] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:27:57 -0700
Message-ID: <169516247719.7377.5168979973638439905.stgit@anambiarhost.jf.intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to associate the interrupt vector number for a
NAPI instance.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c |    3 +++
 include/linux/netdevice.h                |    6 ++++++
 net/core/dev.c                           |    1 +
 net/core/netdev-genl.c                   |    4 ++++
 4 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index df1906566185..ede246720898 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2972,6 +2972,9 @@ int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
 			return ret;
 	}
 
+	/* Also set the interrupt number for the NAPI */
+	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+
 	return ret;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e7321178dc1a..8be6b3aa70a9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -382,6 +382,7 @@ struct napi_struct {
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
+	int			irq;
 };
 
 enum {
@@ -2625,6 +2626,11 @@ static inline void *netdev_priv(const struct net_device *dev)
 int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
 			 enum netdev_queue_type type);
 
+static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
+{
+	napi->irq = irq;
+}
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index ea6b3115ee8b..5087b0e92a59 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6463,6 +6463,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = 0;
+	napi->irq = -1;
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6f4ed21ebd15..2b3818615e1b 100644
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


