Return-Path: <netdev+bounces-28275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004C77EDF2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07C91C2125C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2B1ED54;
	Wed, 16 Aug 2023 23:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838981ED32
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D529DC433CC;
	Wed, 16 Aug 2023 23:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229395;
	bh=kj98qhSBL8dKkeBpXyc3bjKFlPCXZulwbffJn0Ljdgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnSFoNPK0eJKpEu8YKkBeBO3jTX1U+sbQKGTR6DljPQUUyIKq/JGS2W5RXR+J5xPj
	 3QR2iRQVCM0eZDMwYrLCSYFpu3R2lnKfBYChZf44HO/TxMpaAQR40wDU6tlwAf/uX0
	 Pu9BLLqN8AQkRnhFl0ybYb3p2U01lRvD6nPsBm/h/171oGEgPJ6OPoD0hsS+5oZdXA
	 OmyWvq0JXKkzAZKzqsa4WLxKyUbdk1sVa7M2ZjMvrwnj4Gzu1G4xmogjNRL20ALiWe
	 KY4NyWHytxpPeqp27J3lMSOQtTcQBBmkNM8nZG4dw6MPwl3aPVXUE4Bi+5C27OzEL0
	 wYYFTQHOPckkw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 10/13] net: page_pool: add netlink notifications for state changes
Date: Wed, 16 Aug 2023 16:42:59 -0700
Message-ID: <20230816234303.3786178-11-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generate netlink notifications about page pool state changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 17 ++++++++++++
 include/uapi/linux/netdev.h             |  4 +++
 net/core/netdev-genl-gen.c              |  1 +
 net/core/netdev-genl-gen.h              |  1 +
 net/core/page_pool_user.c               | 36 +++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index ded77e61df7b..47ae2a45daea 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -142,8 +142,25 @@ name: netdev
             - napi-id
       dump:
         reply: *pp-reply
+    -
+      name: page-pool-add-ntf
+      doc: Notification about page pool appearing.
+      notify: page-pool-get
+      mcgrp: page-pool
+    -
+      name: page-pool-del-ntf
+      doc: Notification about page pool disappearing.
+      notify: page-pool-get
+      mcgrp: page-pool
+    -
+      name: page-pool-change-ntf
+      doc: Notification about page pool configuration being changed.
+      notify: page-pool-get
+      mcgrp: page-pool
 
 mcast-groups:
   list:
     -
       name: mgmt
+    -
+      name: page-pool
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 98999e0650a3..3c9818c1962a 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -64,11 +64,15 @@ enum {
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_GET,
+	NETDEV_CMD_PAGE_POOL_ADD_NTF,
+	NETDEV_CMD_PAGE_POOL_DEL_NTF,
+	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
 };
 
 #define NETDEV_MCGRP_MGMT	"mgmt"
+#define NETDEV_MCGRP_PAGE_POOL	"page-pool"
 
 #endif /* _UAPI_LINUX_NETDEV_H */
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index c74fe69dd241..23d5bd111ddd 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -50,6 +50,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
 	[NETDEV_NLGRP_MGMT] = { "mgmt", },
+	[NETDEV_NLGRP_PAGE_POOL] = { "page-pool", },
 };
 
 struct genl_family netdev_nl_family __ro_after_init = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index a011d12abff4..738097847100 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -19,6 +19,7 @@ int netdev_nl_page_pool_get_dumpit(struct sk_buff *skb,
 
 enum {
 	NETDEV_NLGRP_MGMT,
+	NETDEV_NLGRP_PAGE_POOL,
 };
 
 extern struct genl_family netdev_nl_family;
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 3bc434f7825f..ba2f27f15495 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -135,6 +135,37 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	return -EMSGSIZE;
 }
 
+static void netdev_nl_page_pool_event(const struct page_pool *pool, u32 cmd)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+	struct net *net;
+
+	lockdep_assert_held(&page_pools_lock);
+
+	/* 'invisible' page pools don't matter */
+	if (hlist_unhashed(&pool->user.list))
+		return;
+	net = dev_net(pool->slow.netdev);
+
+	if (!genl_has_listeners(&netdev_nl_family, net, NETDEV_NLGRP_PAGE_POOL))
+		return;
+
+	genl_info_init_ntf(&info, &netdev_nl_family, cmd);
+
+	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	if (page_pool_nl_fill(ntf, pool, &info)) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&netdev_nl_family, net, ntf,
+				0, NETDEV_NLGRP_PAGE_POOL, GFP_KERNEL);
+}
+
 int netdev_nl_page_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	u32 id;
@@ -168,6 +199,8 @@ int page_pool_list(struct page_pool *pool)
 		hlist_add_head(&pool->user.list,
 			       &pool->slow.netdev->page_pools);
 		pool->user.napi_id = pool->p.napi ? pool->p.napi->napi_id : 0;
+
+		netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_ADD_NTF);
 	}
 
 	mutex_unlock(&page_pools_lock);
@@ -181,6 +214,7 @@ int page_pool_list(struct page_pool *pool)
 void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
+	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
 	xa_erase(&page_pools, pool->user.id);
 	hlist_del(&pool->user.list);
 	mutex_unlock(&page_pools_lock);
@@ -212,6 +246,8 @@ static void page_pool_unreg_netdev(struct net_device *netdev)
 	mutex_lock(&page_pools_lock);
 	hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
 		pool->slow.netdev = lo;
+		netdev_nl_page_pool_event(pool,
+					  NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
 		last = pool;
 	}
 
-- 
2.41.0


