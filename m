Return-Path: <netdev+bounces-29475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E904783625
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7082280FA6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324E1ADE8;
	Mon, 21 Aug 2023 23:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA41BB3F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517B0131
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659432; x=1724195432;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psWUQDmleIM3iPULg/dHdOvV3gk3LN+in+Fv6kWZ8v8=;
  b=N24s9vjBW8qjSfp8YnpuCw34FtLfGBntjhZiQiKfNEr+qcbYEw2rFaJe
   xSoSTSL5Ozfinj8O/XomsGXMZupBZJT3H42ZVeSM3lDvIkmeYculld4b6
   yyW+gUoivCZ9VTmRE9i8BiK4rm5gosGsiRD2HBclofxph5Z32DKO/8NDw
   /euZhzD8GqGtrfD8Yh39bs6V0A0B+DfXHotRv4E9Khdc1Am932SXT1IsH
   ommbZYYE3zE4xREgCvm9UK3FLzrTtUfVCR225xJz9rqNhftu2zRQVCKli
   9aRRcnUeVij2OLWyavIBIVkrqBzlIzXaWcgcWfWsaaCvG7EYL5t7rFKPq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437645828"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="437645828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685829226"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="685829226"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 16:10:29 -0700
Subject: [net-next PATCH v2 5/9] netdev-genl: Add netlink framework
 functions for napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:36 -0700
Message-ID: <169266033666.10199.3744908214828788701.stgit@anambiarhost.jf.intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the netdev netlink framework functions for
napi support. The netdev structure tracks all the napi
instances and napi fields. The napi instances and associated
queue[s] can be retrieved this way.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 net/core/netdev-genl.c |  165 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b146679d6112..4bc6aa756001 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -5,9 +5,23 @@
 #include <linux/rtnetlink.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
+#include <net/netdev_rx_queue.h>
 
 #include "netdev-genl-gen.h"
 
+struct netdev_nl_dump_ctx {
+	unsigned long	ifindex;
+	int		napi_idx;
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
@@ -101,12 +115,13 @@ int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -119,14 +134,158 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int
+netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
+			const struct genl_info *info)
+{
+	struct netdev_rx_queue *rx_queue, *rxq;
+	struct netdev_queue *tx_queue, *txq;
+	unsigned int rx_qid, tx_qid;
+	void *hdr;
+
+	if (!napi->dev)
+		return -EINVAL;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_NAPI_ID, napi->napi_id))
+		goto nla_put_failure;
+
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
+		goto nla_put_failure;
+
+	list_for_each_entry_safe(rx_queue, rxq, &napi->napi_rxq_list, q_list) {
+		rx_qid = get_netdev_rx_queue_index(rx_queue);
+		if (nla_put_u32(rsp, NETDEV_A_NAPI_RX_QUEUES, rx_qid))
+			goto nla_put_failure;
+	}
+
+	list_for_each_entry_safe(tx_queue, txq, &napi->napi_txq_list, q_list) {
+		tx_qid = get_netdev_queue_index(tx_queue);
+		if (nla_put_u32(rsp, NETDEV_A_NAPI_TX_QUEUES, tx_qid))
+			goto nla_put_failure;
+	}
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+static int
+netdev_nl_napi_fill(struct net_device *netdev, struct sk_buff *rsp,
+		    const struct genl_info *info, u32 napi_id)
+{
+	struct napi_struct *napi, *n;
+
+	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list) {
+		if (napi->napi_id == napi_id)
+			return netdev_nl_napi_fill_one(rsp, napi, info);
+	}
+	return -EINVAL;
+}
+
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *netdev;
+	struct sk_buff *rsp;
+	u32 napi_id;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_NAPI_ID))
+		return -EINVAL;
+
+	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_NAPI_ID]);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	rtnl_lock();
+
+	netdev = dev_get_by_napi_id(napi_id);
+	if (netdev)
+		err  = netdev_nl_napi_fill(netdev, rsp, info, napi_id);
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
+netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
+			const struct genl_info *info, int *start)
+{
+	struct napi_struct *napi, *n;
+	int err = 0;
+	int i = 0;
+
+	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list) {
+		if (i < *start) {
+			i++;
+			continue;
+		}
+		err = netdev_nl_napi_fill_one(rsp, napi, info);
+		if (err)
+			break;
+		*start = ++i;
+	}
+	return err;
 }
 
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *netdev;
+	int n_idx = ctx->napi_idx;
+	u32 ifindex = 0;
+	int err = 0;
+
+	if (info->info.attrs[NETDEV_A_NAPI_IFINDEX])
+		ifindex = nla_get_u32(info->info.attrs[NETDEV_A_NAPI_IFINDEX]);
+
+	rtnl_lock();
+	if (ifindex) {
+		netdev = __dev_get_by_index(net, ifindex);
+		if (netdev)
+			err = netdev_nl_napi_dump_one(netdev, skb,
+						      genl_info_dump(cb),
+						      &n_idx);
+		else
+			err = -ENODEV;
+	} else {
+		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+			err = netdev_nl_napi_dump_one(netdev, skb,
+						      genl_info_dump(cb),
+						      &n_idx);
+			if (!err)
+				n_idx = 0;
+			if (err < 0)
+				break;
+		}
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	ctx->napi_idx = n_idx;
+	return skb->len;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,


