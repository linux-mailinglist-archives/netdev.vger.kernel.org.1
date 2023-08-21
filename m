Return-Path: <netdev+bounces-29477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95B783627
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36984280F96
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403671ADEF;
	Mon, 21 Aug 2023 23:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E91BF12
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A1130
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659441; x=1724195441;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4uM3VZfIVpqGLb7VGl7h2R0xjblH0vYFBp/EDmbGpg=;
  b=PNb3baTCdaxTQAofgOvk0BuD8qp1C5NlujEvbgXeqZIjxXWxfRdS3ENa
   tmxc/amcB/4O52VcT1A3rtzr3q1Unyl1ULrCYHFLmQMz/R9XRO/m/U6nR
   +IdO7W/BDt0WE8CdKgnb+nhe8Z3sGD3rnkeM1mKXyNw/FuW0Xqr9yOm+l
   ozw03EEm74MxlgQw806558p+ZCBUf8mQWCKlERdxiBv8m4AcvV7/0rHJ5
   aFRJmpW1jafhAu1Ril+xlTM/6w6JWSn3FyobcYzmCHeVv2TNSKZ9YzVOF
   1ke7pBi6TDE527G4ehRJhomEgsNEAhlKC7fHqF5oSscot2DQAsysGaIlY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373698717"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="373698717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982647679"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="982647679"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 16:10:40 -0700
Subject: [net-next PATCH v2 7/9] net: Add NAPI IRQ support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:46 -0700
Message-ID: <169266034688.10199.12117427969821291880.stgit@anambiarhost.jf.intel.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index c2b9a25db139..6c86e6ac9dfe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2972,6 +2972,9 @@ int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
 			return ret;
 	}
 
+	/* Also set the interrupt number for the NAPI */
+	napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+
 	return ret;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4ec86d9aceb2..60f06bac6d24 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -390,6 +390,7 @@ struct napi_struct {
 	struct hlist_node	napi_hash_node;
 	struct list_head	napi_rxq_list;
 	struct list_head	napi_txq_list;
+	int			irq;
 };
 
 enum {
@@ -2634,6 +2635,11 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+static inline void napi_set_irq(struct napi_struct *napi, int irq)
+{
+	napi->irq = irq;
+}
+
 int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
 			 enum q_type type);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index ec4c469c9e1d..10d1f0a07ba2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6465,6 +6465,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 
 	INIT_LIST_HEAD(&napi->napi_rxq_list);
 	INIT_LIST_HEAD(&napi->napi_txq_list);
+	napi->irq = -1;
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 4bc6aa756001..63b8690d8ba3 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -168,7 +168,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			goto nla_put_failure;
 	}
 
+	if (napi->irq >= 0 && (nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq)))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
+
 	return 0;
 
 nla_put_failure:


