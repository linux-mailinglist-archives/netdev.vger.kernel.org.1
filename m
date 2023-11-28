Return-Path: <netdev+bounces-51547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A207FB072
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884291C20BDB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E41D525;
	Tue, 28 Nov 2023 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTswalsj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FAC9
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 19:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701142412; x=1732678412;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zwOHvqCIP+NTKEkk9k1RXvXWk1XOKTCtk8IUtyYREz8=;
  b=aTswalsj+1nDQHI64F2iduUDz/BcyDn6J1LxhIQed+yEiUrbX/+Aam+d
   x8IMWlBIkgPuKCwcrfurNg3qyOVRx41NP9syIaE1mcsJM+F0GY32uXKKU
   tknoditoJ4+tKHueYlb6fwtpj+2jrZwyj9hycVNFlj+q7tsL4pgCoOp8T
   bYvDt4hwiRLK5FOzUW9pBaUA4GmNlSkqPTv3i71e/GJR8EsQwg4pV/58h
   yIuwao30dHFysRUCJePH5G53tUhROZ3yaFC7sL6c0bF0BWEmug1OFGsf9
   I89BB7hKADYB0iu1GB17YtQgwbvbcI+mtsHNxBn/7GwRkoCb+b0/v16mG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373013041"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="373013041"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834524760"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="834524760"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2023 19:33:32 -0800
Subject: [net-next PATCH v9 06/11] netdev-genl: Add netlink framework
 functions for napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 27 Nov 2023 19:49:58 -0800
Message-ID: <170114339855.10303.4688562331003527207.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
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
napi support. The netdev structure tracks all the napi
instances and napi fields. The napi instances and associated
parameters can be retrieved this way.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 net/core/dev.c         |    3 -
 net/core/dev.h         |    2 +
 net/core/netdev-genl.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0a2eecbeef38..13c9d1580e62 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -165,7 +165,6 @@ static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
-static struct napi_struct *napi_by_id(unsigned int napi_id);
 
 /*
  * The @dev_base_head list is protected by @dev_base_lock and the rtnl
@@ -6139,7 +6138,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 EXPORT_SYMBOL(napi_complete_done);
 
 /* must be called under rcu_read_lock(), as we dont take a reference */
-static struct napi_struct *napi_by_id(unsigned int napi_id)
+struct napi_struct *napi_by_id(unsigned int napi_id)
 {
 	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
 	struct napi_struct *napi;
diff --git a/net/core/dev.h b/net/core/dev.h
index 5aa45f0fd4ae..7795b8ad841d 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -145,4 +145,6 @@ void xdp_do_check_flushed(struct napi_struct *napi);
 #else
 static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 #endif
+
+struct napi_struct *napi_by_id(unsigned int napi_id);
 #endif
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index f69b092b8fee..851c8ebca267 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -7,13 +7,16 @@
 #include <net/sock.h>
 #include <net/xdp.h>
 #include <net/netdev_rx_queue.h>
+#include <net/busy_poll.h>
 
 #include "netdev-genl-gen.h"
+#include "dev.h"
 
 struct netdev_nl_dump_ctx {
 	unsigned long	ifindex;
 	unsigned int	rxq_idx;
 	unsigned int	txq_idx;
+	unsigned int	napi_id;
 };
 
 static struct netdev_nl_dump_ctx *netdev_dump_ctx(struct netlink_callback *cb)
@@ -144,14 +147,128 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int
+netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
+			const struct genl_info *info)
+{
+	void *hdr;
+
+	if (WARN_ON_ONCE(!napi->dev))
+		return -EINVAL;
+	if (!(napi->dev->flags & IFF_UP))
+		return 0;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (napi->napi_id >= MIN_NAPI_ID &&
+	    nla_put_u32(rsp, NETDEV_A_NAPI_ID, napi->napi_id))
+		goto nla_put_failure;
+
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
+		goto nla_put_failure;
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct napi_struct *napi;
+	struct sk_buff *rsp;
+	u32 napi_id;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
+		return -EINVAL;
+
+	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	rtnl_lock();
+
+	napi = napi_by_id(napi_id);
+	if (napi)
+		err = netdev_nl_napi_fill_one(rsp, napi, info);
+	else
+		err = -EINVAL;
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
+			const struct genl_info *info,
+			struct netdev_nl_dump_ctx *ctx)
+{
+	struct napi_struct *napi;
+	int err = 0;
+
+	if (!(netdev->flags & IFF_UP))
+		return err;
+
+	list_for_each_entry(napi, &netdev->napi_list, dev_list) {
+		if (ctx->napi_id && napi->napi_id >= ctx->napi_id)
+			continue;
+
+		err = netdev_nl_napi_fill_one(rsp, napi, info);
+		if (err)
+			return err;
+		ctx->napi_id = napi->napi_id;
+	}
+	return err;
 }
 
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *netdev;
+	u32 ifindex = 0;
+	int err = 0;
+
+	if (info->attrs[NETDEV_A_NAPI_IFINDEX])
+		ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
+
+	rtnl_lock();
+	if (ifindex) {
+		netdev = __dev_get_by_index(net, ifindex);
+		if (netdev)
+			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
+		else
+			err = -ENODEV;
+	} else {
+		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
+			if (err < 0)
+				break;
+			ctx->napi_id = 0;
+		}
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	return skb->len;
 }
 
 static int


