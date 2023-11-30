Return-Path: <netdev+bounces-52325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14267FE49B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E38B21045
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C2197;
	Thu, 30 Nov 2023 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWdhnfD3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9810C8
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701303079; x=1732839079;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RxSrrRJBlosqSAyhy468tPZ3cbX2EU1+55o/8DfM5j0=;
  b=dWdhnfD3aZtjsOY/V2GIl7rXzsvTjjxIr4BUe6tO5TgRgLA4AnfUwTAI
   Tle+AWrNV1hm+eo8vS7ciPioylOmnVCiQ6TChgXYTYkChjoKAj1myMSNm
   Nn9uvAQT3RII8vUUIQR1xz8LL2x0kOKJD1011M3qaZVUO2WWOXBgHR4Ow
   NjtbhF1uxAb6vlDWv8cmEZXPSGbxu63cvTu1DD0OYsyE5OU8K8deIXh2C
   NHI463XEGkkrqsTeuA8wDPysRXqsi0PFKYsGzVDl7NrK++SAHmQqGbTiD
   MXW2qc3kfLO5yaHrL1NqKEKyaxS0mJd4poPdz5M3nGrlL+WqnexMdEbNp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6516749"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6516749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 16:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="860004595"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="860004595"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Nov 2023 16:11:16 -0800
Subject: [net-next PATCH v10 04/11] netdev-genl: Add netlink framework
 functions for queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com
Date: Wed, 29 Nov 2023 16:27:45 -0800
Message-ID: <170130406501.5198.15915107697972654557.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
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
 net/core/netdev-genl.c |  187 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 184 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 336c608e6a6b..9bf7c2930db4 100644
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
@@ -129,14 +144,180 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
+	    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
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
+	int err = 0;
+
+	if (!(netdev->flags & IFF_UP))
+		return err;
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
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+		return -EINVAL;
+
+	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
+	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
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
+	if (!(netdev->flags & IFF_UP))
+		return err;
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


