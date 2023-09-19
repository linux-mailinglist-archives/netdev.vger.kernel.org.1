Return-Path: <netdev+bounces-35092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DD7A6E89
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A082811F7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2713B79F;
	Tue, 19 Sep 2023 22:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747E3B29C
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C556F5
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161732; x=1726697732;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zAtcdRQ//g3iTh3TX1ZLqgb/0pMs3nSTUXGPvK+SNBs=;
  b=Nv54z/MRDFKKIQdMTYFxTxCSTizV1Kb44XngO8/6CpiQw6GVn0HCTHfP
   oHFM5lDFB/rt1JQwbBWmkOCFhGNR0IHRnb0amdBP6ueZltVJkBjOIh7/Q
   synt+IuzkuJeojKIeE46buRJZkn97NiwMvGbEnfwGu3lGCIFQWwDh7pSR
   T7NScVvoSQcd4wVMB3CHKBX4VY6Kwi6KgVhp4uoj2MXXuHSmsaYA0P/Vx
   57FtLUoeYhdkgRGr8PPMKkamjZJa30t6I6FR1WgKb5aswrOLGOvcGqDDs
   RP9KYsh1zbpYebvapABVFQ1GoIvKJc1eM2tIQtxNwQnJwmv7/RF07GjPP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370378475"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370378475"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870118088"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="870118088"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2023 15:12:07 -0700
Subject: [net-next PATCH v3 04/10] netdev-genl: Add netlink framework
 functions for queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:27:36 -0700
Message-ID: <169516245672.7377.15243846195860899954.stgit@anambiarhost.jf.intel.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the netdev netlink framework functions for
exposing queue information.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 net/core/netdev-genl.c |  207 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 336c608e6a6b..ceb7d1722f7c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -6,9 +6,24 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include "netdev-genl-gen.h"
 
+struct netdev_nl_dump_ctx {
+	unsigned long	ifindex;
+	unsigned int	rxq_idx;
+	unsigned int	txq_idx;
+};
+
+static inline struct netdev_nl_dump_ctx *
+netdev_dump_ctx(struct netlink_callback *cb)
+{
+	NL_ASSERT_DUMP_CTX_FITS(struct netdev_nl_dump_ctx);
+
+	return (struct netdev_nl_dump_ctx *)cb->ctx;
+}
+
 static int
 netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		   const struct genl_info *info)
@@ -111,12 +126,13 @@ int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
 	struct net *net = sock_net(skb->sk);
 	struct net_device *netdev;
 	int err = 0;
 
 	rtnl_lock();
-	for_each_netdev_dump(net, netdev, cb->args[0]) {
+	for_each_netdev_dump(net, netdev, ctx->ifindex) {
 		err = netdev_nl_dev_fill(netdev, skb, genl_info_dump(cb));
 		if (err < 0)
 			break;
@@ -129,14 +145,199 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int
+netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
+			 u32 q_idx, u32 q_type, const struct genl_info *info)
+{
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_Q_ID, q_idx))
+		goto nla_put_failure;
+
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_Q_TYPE, q_type))
+		goto nla_put_failure;
+
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
+		goto nla_put_failure;
+
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		rxq = __netif_get_rx_queue(netdev, q_idx);
+		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
+					     rxq->napi->napi_id))
+			goto nla_put_failure;
+		break;
+	case NETDEV_QUEUE_TYPE_TX:
+		txq = netdev_get_tx_queue(netdev, q_idx);
+		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
+					     txq->napi->napi_id))
+			goto nla_put_failure;
+
+		if (nla_put_u32(rsp, NETDEV_A_QUEUE_TX_MAXRATE,
+				txq->tx_maxrate))
+			goto nla_put_failure;
+		break;
+	}
+
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+static int netdev_nl_queue_validate(struct net_device *netdev, u32 q_id, u32 q_type)
+{
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		if (q_id >= netdev->real_num_rx_queues)
+			return -EINVAL;
+		return 0;
+	case NETDEV_QUEUE_TYPE_TX:
+		if (q_id >= netdev->real_num_tx_queues)
+			return -EINVAL;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+netdev_nl_queue_fill(struct sk_buff *rsp, struct net_device *netdev, u32 q_idx,
+		     u32 q_type, const struct genl_info *info)
+{
+	int err;
+
+	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
+	if (err)
+		return err;
+
+	return netdev_nl_queue_fill_one(rsp, netdev, q_idx, q_type, info);
+}
+
 int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	u32 q_id, q_type, ifindex;
+	struct net_device *netdev;
+	struct sk_buff *rsp;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_Q_ID))
+		return -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_Q_TYPE))
+		return -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+		return -EINVAL;
+
+	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_Q_ID]);
+
+	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_Q_TYPE]);
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (netdev)
+		err  = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
+	else
+		err = -ENODEV;
+
+	rtnl_unlock();
+
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
+
+static int
+netdev_nl_queue_dump_one(struct net_device *netdev, struct sk_buff *rsp,
+			 const struct genl_info *info, unsigned int *start_rx,
+			 unsigned int *start_tx)
+{
+	int err = 0;
+	int i;
+
+	for (i = *start_rx; i < netdev->real_num_rx_queues;) {
+		err = netdev_nl_queue_fill_one(rsp, netdev, i,
+					       NETDEV_QUEUE_TYPE_RX, info);
+		if (err)
+			goto out_err;
+		*start_rx = i++;
+	}
+	for (i = *start_tx; i < netdev->real_num_tx_queues;) {
+		err = netdev_nl_queue_fill_one(rsp, netdev, i,
+					       NETDEV_QUEUE_TYPE_TX, info);
+		if (err)
+			goto out_err;
+		*start_tx = i++;
+	}
+out_err:
+	return err;
 }
 
 int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(skb->sk);
+	unsigned int rxq_idx = ctx->rxq_idx;
+	unsigned int txq_idx = ctx->txq_idx;
+	struct net_device *netdev;
+	u32 ifindex = 0;
+	int err = 0;
+
+	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
+		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
+
+	rtnl_lock();
+	if (ifindex) {
+		netdev = __dev_get_by_index(net, ifindex);
+		if (netdev)
+			err = netdev_nl_queue_dump_one(netdev, skb, info,
+						       &rxq_idx, &txq_idx);
+		else
+			err = -ENODEV;
+	} else {
+		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+			err = netdev_nl_queue_dump_one(netdev, skb, info,
+						       &rxq_idx, &txq_idx);
+
+			if (err < 0)
+				break;
+			if (!err) {
+				rxq_idx = 0;
+				txq_idx = 0;
+			}
+		}
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	ctx->rxq_idx = rxq_idx;
+	ctx->txq_idx = txq_idx;
+	return skb->len;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,


