Return-Path: <netdev+bounces-42452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C57CEC52
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2148B20EAD
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53D4666B;
	Wed, 18 Oct 2023 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkxKadjx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5F46661
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:50:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FEB6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697673041; x=1729209041;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcFEoSEw4LqoUWDUAycT3G0tX0v5dyFIpgJtRDmYUIY=;
  b=JkxKadjxt+nDzAQiAAdww3Z6Pog/ZhopLeIsYDv80B37Wl4tIbDVq5GJ
   yg0AGumKOqImvBfYj32pwHqXM//NxGgoXbXMtOedpwYibVRZeOurDX+Hr
   M6TvOCTq8DJAJhC1aVHuraWtk58sVWO7mDD/jDk31GavkyLJjYI+Y4Uwy
   jMYFm6Os0pPHwAUkdCbLeoOQ44yHPfr1oeh87AZ7GaMx5nm1QbMRNqTmh
   1jzYiiz7onZYv5kZpmxA+B3dSqoCGqI6aifQsxm9wI19r/IXoo3GFtm4f
   Lsh/mzG/PTw8+0Jhy/zEJucr9uBoYCmJ0Hyx0z+lnUteERNb9LlXodWmr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452610942"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452610942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004009080"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1004009080"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 16:50:40 -0700
Subject: [net-next PATCH v5 06/10] netdev-genl: Add netlink framework
 functions for napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Wed, 18 Oct 2023 17:06:33 -0700
Message-ID: <169767399377.6692.11524888793155992979.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
References: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
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
index e8add4fcf53f..1b0f40921efc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -165,7 +165,6 @@ static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
-static struct napi_struct *napi_by_id(unsigned int napi_id);
 
 /*
  * The @dev_base_head list is protected by @dev_base_lock and the rtnl
@@ -6142,7 +6141,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 EXPORT_SYMBOL(napi_complete_done);
 
 /* must be called under rcu_read_lock(), as we dont take a reference */
-static struct napi_struct *napi_by_id(unsigned int napi_id)
+struct napi_struct *napi_by_id(unsigned int napi_id)
 {
 	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
 	struct napi_struct *napi;
diff --git a/net/core/dev.h b/net/core/dev.h
index e075e198092c..20ca1e74a60c 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -136,4 +136,6 @@ static inline void netif_set_gro_ipv4_max_size(struct net_device *dev,
 }
 
 int rps_cpumask_housekeeping(struct cpumask *mask);
+
+struct napi_struct *napi_by_id(unsigned int napi_id);
 #endif
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 27d7f9dff228..d6ef7fc093d0 100644
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
+	rcu_read_lock();
+
+	napi = napi_by_id(napi_id);
+	if (napi)
+		err = netdev_nl_napi_fill_one(rsp, napi, info);
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


