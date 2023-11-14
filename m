Return-Path: <netdev+bounces-47550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259977EA750
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF87280E74
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B23C27;
	Tue, 14 Nov 2023 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvp9sEkJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E53C2A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB2115
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920835; x=1731456835;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ff3MIOG8nZmq5oLxrB+HBp+u3s2CguYskgiKY3LiAbc=;
  b=hvp9sEkJkc3WD8Wq7SHZ23VzqniIADea9/IehrFMXryKi/DYAEIU+5ri
   7E2+EdIhLsnmTMW2IaXrqFSnq5M+ccigmazpqhT8GzbzHij2drMag2BaZ
   CJhMJvNki/S9/0gr1HgQ00IQAA5RijJ3KrEeaeeP4rQhycD91d5GDh2oI
   irpk10etoJTeLUuC3uVVOMK1YZNNINGJUpaaugcSC0t+3NVbEDEoGhrJP
   C5SG9lFVwmfu8ood+Wyqd3pkOPf6kE3gVJQC2axubMN5DJsrug7kqvUOX
   V7nZEbP+s/dg8/Zag3kD2ByM7aeGTPlRyyJYsryhQCNx85oExiypz0+Fj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393397498"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393397498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:13:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011697868"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011697868"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2023 16:13:50 -0800
Subject: [net-next PATCH v7 06/10] netdev-genl: Add netlink framework
 functions for napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:30:03 -0800
Message-ID: <169992180339.3867.14077329020078464724.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
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
 net/core/netdev-genl.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 54ee5139ddd5..3ae5c353b58e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -165,7 +165,6 @@ static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
-static struct napi_struct *napi_by_id(unsigned int napi_id);
 
 /*
  * The @dev_base_head list is protected by @dev_base_lock and the rtnl
@@ -6137,7 +6136,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
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
index 27d7f9dff228..f2441d73a972 100644
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
@@ -144,14 +147,123 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (napi->napi_id >= MIN_NAPI_ID &&
+	    nla_put_u32(rsp, NETDEV_A_NAPI_NAPI_ID, napi->napi_id))
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


