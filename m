Return-Path: <netdev+bounces-43708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471317D44CF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F751C20B5A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FAE4A35;
	Tue, 24 Oct 2023 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtFeG5yd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14782523E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:18:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576DBDE
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110281; x=1729646281;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEEiQY22miWK49YL7IjSeuHSSeBp41OwN3lN04g95I0=;
  b=XtFeG5ydHlnDaK6HkGjkJ0XvkzedNSRRwYTfiZlVivIofwrwcTDF38Yp
   FRWnuPm7NGTphRYdhmAlddgkHv/KLscgN66l8/HFKn7m3XteQ+uV1FznC
   Mbz4VeYNkbu/8d+GryjmqpNg4w+0kIbM9ZZuUZ32r0iGPaWrXM51STQTD
   G8Uy6oYA0LB2ZaYn8KeAOKDohPn+u2Zz01nbk4wEQ60C/bIwDaCU/xzHW
   5Kvt6OYOE+mTTH1zO3v3Ryqz8nezPqf81oDt8dxKFDt1AR9aWLosSpK3b
   DT+ekd5HrspCu4dQK4KbOS20TC7g8tSOdRXgGKhcAUnRBIy8AnbnBLs8e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389810605"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="389810605"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758309130"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="758309130"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2023 18:18:00 -0700
Subject: [net-next PATCH v6 04/10] netdev-genl: Add netlink framework
 functions for queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 23 Oct 2023 18:33:39 -0700
Message-ID: <169811121973.59034.5173870598509775544.stgit@anambiarhost.jf.intel.com>
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

Implement the netdev netlink framework functions for
exposing queue information.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 net/core/netdev-genl.c |  181 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 336c608e6a6b..a3e308bf74d5 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -6,9 +6,23 @@
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
+static struct netdev_nl_dump_ctx *netdev_dump_ctx(struct netlink_callback *cb)
+{
+	NL_ASSERT_DUMP_CTX_FITS(struct netdev_nl_dump_ctx);
+
+	return (struct netdev_nl_dump_ctx *)cb->ctx;
+}
+
 static int
 netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		   const struct genl_info *info)
@@ -111,12 +125,13 @@ int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -129,14 +144,174 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_QUEUE_ID, q_idx) ||
+	    nla_put_u32(rsp, NETDEV_A_QUEUE_QUEUE_TYPE, q_type) ||
+	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
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
+static int netdev_nl_queue_validate(struct net_device *netdev, u32 q_id,
+				    u32 q_type)
+{
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		if (q_id >= netdev->real_num_rx_queues)
+			return -EINVAL;
+		return 0;
+	case NETDEV_QUEUE_TYPE_TX:
+		if (q_id >= netdev->real_num_tx_queues)
+			return -EINVAL;
+	}
+	return 0;
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
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+		return -EINVAL;
+
+	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_QUEUE_ID]);
+	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_QUEUE_TYPE]);
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
+		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
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
+			 const struct genl_info *info,
+			 struct netdev_nl_dump_ctx *ctx)
+{
+	int err = 0;
+	int i;
+
+	for (i = ctx->rxq_idx; i < netdev->real_num_rx_queues;) {
+		err = netdev_nl_queue_fill_one(rsp, netdev, i,
+					       NETDEV_QUEUE_TYPE_RX, info);
+		if (err)
+			return err;
+		ctx->rxq_idx = i++;
+	}
+	for (i = ctx->txq_idx; i < netdev->real_num_tx_queues;) {
+		err = netdev_nl_queue_fill_one(rsp, netdev, i,
+					       NETDEV_QUEUE_TYPE_TX, info);
+		if (err)
+			return err;
+		ctx->txq_idx = i++;
+	}
+
+	return err;
 }
 
 int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(skb->sk);
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
+			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
+		else
+			err = -ENODEV;
+	} else {
+		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
+			if (err < 0)
+				break;
+			ctx->rxq_idx = 0;
+			ctx->txq_idx = 0;
+		}
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	return skb->len;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,


