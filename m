Return-Path: <netdev+bounces-38497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45027BB3A9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AAF282297
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB779D9;
	Fri,  6 Oct 2023 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keIavnFB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100F11732
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:59:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306E95
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696582768; x=1728118768;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nilis8yhp4IF7HAJ4tsqaR74WkcqXuq6jwdcV1nHJrk=;
  b=keIavnFBiWjHJzUqsjKPdTTHRp9Y8gY2IGXuEDEDTy8wnpk8BCnblZwc
   ojQkNgwvpWKfBMU+SOIZTPrTwLoLupDKWgi8L8UU9oASKeJOSeOKwUFbL
   7yTDOqYJp696VO8aau30hNZEQvwmNo+qvYWl5Y3AIk3wFnq82wxU4NJTT
   a4LRwnydf7kkrp/tCRbnMqWHKJO+DI3HRRFYQhCZUKx4ijmeTekYgcj3k
   y5SvhCMovOWnMKKOHHjRL7G79lvMTHli5wAW7/4Ovmm/NL5/CDS2UaWs/
   sLh5a+Xua610RfiCBtUi2BP1ZFLJzUJGBCFWseXLVRb/MCIquKufp9Nt8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447897922"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447897922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895813262"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895813262"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 01:57:56 -0700
Subject: [net-next PATCH v4 06/10] netdev-genl: Add netlink framework
 functions for napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 06 Oct 2023 02:15:10 -0700
Message-ID: <169658371009.3683.2263972635869263084.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
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
parameters can be retrieved this way.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/linux/netdevice.h |    2 +
 net/core/dev.c            |    4 +-
 net/core/netdev-genl.c    |  117 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 264ae0bdabe8..da211f4d81db 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -536,6 +536,8 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
+struct napi_struct *napi_by_id(unsigned int napi_id);
+
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 9b63a7b76c01..85448451b9fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -165,7 +165,6 @@ static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
-static struct napi_struct *napi_by_id(unsigned int napi_id);
 
 /*
  * The @dev_base_head list is protected by @dev_base_lock and the rtnl
@@ -6133,7 +6132,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 EXPORT_SYMBOL(napi_complete_done);
 
 /* must be called under rcu_read_lock(), as we dont take a reference */
-static struct napi_struct *napi_by_id(unsigned int napi_id)
+struct napi_struct *napi_by_id(unsigned int napi_id)
 {
 	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
 	struct napi_struct *napi;
@@ -6144,6 +6143,7 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
 
 	return NULL;
 }
+EXPORT_SYMBOL(napi_by_id);
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fdd67c67e9aa..530d6f474bd5 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -7,6 +7,7 @@
 #include <net/sock.h>
 #include <net/xdp.h>
 #include <net/netdev_rx_queue.h>
+#include <net/busy_poll.h>
 
 #include "netdev-genl-gen.h"
 
@@ -14,6 +15,7 @@ struct netdev_nl_dump_ctx {
 	unsigned long	ifindex;
 	unsigned int	rxq_idx;
 	unsigned int	txq_idx;
+	unsigned int	napi_id;
 };
 
 static struct netdev_nl_dump_ctx *netdev_dump_ctx(struct netlink_callback *cb)
@@ -144,14 +146,125 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
+	rcu_read_lock();
+
+	napi = napi_by_id(napi_id);
+	if (napi)
+		err  = netdev_nl_napi_fill_one(rsp, napi, info);
+	else
+		err = -EINVAL;
+
+	rcu_read_unlock();
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
+			const struct genl_info *info, unsigned int *start)
+{
+	struct napi_struct *napi;
+	int err = 0;
+
+	list_for_each_entry(napi, &netdev->napi_list, dev_list) {
+		if (*start && napi->napi_id >= *start)
+			continue;
+
+		err = netdev_nl_napi_fill_one(rsp, napi, info);
+		if (err)
+			break;
+		*start = napi->napi_id;
+	}
+	return err;
 }
 
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(skb->sk);
+	unsigned int n_id = ctx->napi_id;
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
+			err = netdev_nl_napi_dump_one(netdev, skb, info, &n_id);
+		else
+			err = -ENODEV;
+	} else {
+		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+			err = netdev_nl_napi_dump_one(netdev, skb, info, &n_id);
+			if (err < 0)
+				break;
+			if (!err)
+				n_id = 0;
+		}
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	ctx->napi_id = n_id;
+	return skb->len;
 }
 
 static int


