Return-Path: <netdev+bounces-43924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830277D5745
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942251C20D38
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99D3A296;
	Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeQ8s1DO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E33A291
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4F6C43395;
	Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163364;
	bh=gmamYON7u11dCPapfiyPDF54PSEi4fKcMZCEziM6pog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeQ8s1DOK+EWlnsrlLfwHK2l/p/73pMHVbvrkAWgpVWnm0rByyWa5ruHpK/Fs7Am0
	 Qp7RgvZwOAqX4p8iz1Ge5851E7w9dDhTvV9FMj1I1WDT8R/fhwdtJc5Rq2vSxRCJKU
	 roa9aX5l1jHdK6qaD5c65DH+VCWX2Ia6EPjF+53uvm+JKm4vrr1dN0BRQv/60pzbcC
	 KyQkQTgHsRQ99/T4iO/d/MJC3w/Gp5ouNBCheKAsf6y3iFL0tdwTT+ucKPhdqcAx3O
	 +pWmKS4V/ozTPe31YviSZOmN1wNoymKqcaUg0LaGpvJ9iDCCNh1RkkBWruMkbxJ5jf
	 dFTLd7SmNdzBg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/15] net: page_pool: implement GET in the netlink API
Date: Tue, 24 Oct 2023 09:02:14 -0700
Message-ID: <20231024160220.3973311-10-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the very basic page pool information via netlink.

Example using ynl-py for a system with 9 queues:

$ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
           --dump page-pool-get
[{'id': 19, 'ifindex': 2, 'napi-id': 147},
 {'id': 18, 'ifindex': 2, 'napi-id': 146},
 {'id': 17, 'ifindex': 2, 'napi-id': 145},
 {'id': 16, 'ifindex': 2, 'napi-id': 144},
 {'id': 15, 'ifindex': 2, 'napi-id': 143},
 {'id': 14, 'ifindex': 2, 'napi-id': 142},
 {'id': 13, 'ifindex': 2, 'napi-id': 141},
 {'id': 12, 'ifindex': 2, 'napi-id': 140},
 {'id': 11, 'ifindex': 2, 'napi-id': 139},
 {'id': 10, 'ifindex': 2, 'napi-id': 138}]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/netdev.h |  10 +++
 net/core/netdev-genl-gen.c  |  23 +++++++
 net/core/netdev-genl-gen.h  |   3 +
 net/core/page_pool_user.c   | 127 ++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2943a151d4f1..176665bcf0da 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -64,11 +64,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PAGE_POOL_ID = 1,
+	NETDEV_A_PAGE_POOL_IFINDEX,
+	NETDEV_A_PAGE_POOL_NAPI_ID,
+
+	__NETDEV_A_PAGE_POOL_MAX,
+	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_PAGE_POOL_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ea9231378aa6..fc5370cf654c 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -10,11 +10,22 @@
 
 #include <uapi/linux/netdev.h>
 
+/* Integer value ranges */
+struct netlink_range_validation netdev_a_page_pool_id_range = {
+	.min	= 1,
+	.max	= 4294967295,
+};
+
 /* NETDEV_CMD_DEV_GET - do */
 static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_PAGE_POOL_GET - do */
+static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL_ID + 1] = {
+	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -29,6 +40,18 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.dumpit	= netdev_nl_dev_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_PAGE_POOL_GET,
+		.doit		= netdev_nl_page_pool_get_doit,
+		.policy		= netdev_page_pool_get_nl_policy,
+		.maxattr	= NETDEV_A_PAGE_POOL_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NETDEV_CMD_PAGE_POOL_GET,
+		.dumpit	= netdev_nl_page_pool_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 7b370c073e7d..a011d12abff4 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,9 @@
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_page_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_page_pool_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 5d8b1bc2474b..3f90a20896c2 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -5,8 +5,10 @@
 #include <linux/xarray.h>
 #include <net/net_debug.h>
 #include <net/page_pool/types.h>
+#include <net/sock.h>
 
 #include "page_pool_priv.h"
+#include "netdev-genl-gen.h"
 
 static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
 /* Protects: page_pools, netdevice->page_pools, pool->slow.netdev, pool->user.
@@ -26,6 +28,131 @@ static DEFINE_MUTEX(page_pools_lock);
  *    - user.list: unhashed, netdev: unknown
  */
 
+typedef int (*pp_nl_fill_cb)(struct sk_buff *rsp, const struct page_pool *pool,
+			     const struct genl_info *info);
+
+static int
+netdev_nl_page_pool_get_do(struct genl_info *info, u32 id, pp_nl_fill_cb fill)
+{
+	struct page_pool *pool;
+	struct sk_buff *rsp;
+	int err;
+
+	mutex_lock(&page_pools_lock);
+	pool = xa_load(&page_pools, id);
+	if (!pool || hlist_unhashed(&pool->user.list) ||
+	    !net_eq(dev_net(pool->slow.netdev), genl_info_net(info))) {
+		err = -ENOENT;
+		goto err_unlock;
+	}
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+
+	err = fill(rsp, pool, info);
+	if (err)
+		goto err_free_msg;
+
+	mutex_unlock(&page_pools_lock);
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+err_unlock:
+	mutex_unlock(&page_pools_lock);
+	return err;
+}
+
+struct page_pool_dump_cb {
+	unsigned long ifindex;
+	u32 pp_id;
+};
+
+static int
+netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			     pp_nl_fill_cb fill)
+{
+	struct page_pool_dump_cb *state = (void *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *netdev;
+	struct page_pool *pool;
+	int err = 0;
+
+	rtnl_lock();
+	mutex_lock(&page_pools_lock);
+	for_each_netdev_dump(net, netdev, state->ifindex) {
+		hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
+			if (state->pp_id && state->pp_id < pool->user.id)
+				continue;
+
+			state->pp_id = pool->user.id;
+			err = fill(skb, pool, info);
+			if (err)
+				break;
+		}
+
+		state->pp_id = 0;
+	}
+	mutex_unlock(&page_pools_lock);
+	rtnl_unlock();
+
+	if (skb->len && err == -EMSGSIZE)
+		return skb->len;
+	return err;
+}
+
+static int
+page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
+		  const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id))
+		goto err_cancel;
+
+	if (pool->slow.netdev->ifindex != 1 &&
+	    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
+			pool->slow.netdev->ifindex))
+		goto err_cancel;
+	if (pool->user.napi_id &&
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi_id))
+		goto err_cancel;
+
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+err_cancel:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+int netdev_nl_page_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	u32 id;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_PAGE_POOL_ID))
+		return -EINVAL;
+
+	id = nla_get_uint(info->attrs[NETDEV_A_PAGE_POOL_ID]);
+
+	return netdev_nl_page_pool_get_do(info, id, page_pool_nl_fill);
+}
+
+int netdev_nl_page_pool_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_fill);
+}
+
 int page_pool_list(struct page_pool *pool)
 {
 	static u32 id_alloc_next;
-- 
2.41.0


