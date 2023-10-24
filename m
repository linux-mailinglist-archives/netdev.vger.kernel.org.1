Return-Path: <netdev+bounces-43925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D27D5746
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA607B21056
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5063AC13;
	Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnHpJG15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E063A29D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09D1C433C8;
	Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163365;
	bh=0UrVdlVIlr2AvrAtBmWtzjEonp/loucXxabyWc6NFzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnHpJG15zGDitUv/YmHx+4ajePO7Vr3Jn4iRKzMWRThsdpEojsqjtRrmmNFA6jI+m
	 g2pQ1FtFwStwnhvSptoU9YAzhGVqtbzUhhvEBQl0O9+DSSbCTqVYDfTRbOj6k5jtro
	 t6s9nqmcVAHNT2TduyTd1T8p+mv7VsXbgFkWuW8CNruJZ7HGC6t6RZkmZ0s/iPch3G
	 mdcApHjyxXGJrrE1M86DkHpnO4hJh9JNi233kCauKZVLeD5IiXiLWUG+pUBdq7WOhm
	 A3MbJEGX8M3JWuQ1Pr8MkTkvBYX3Z/mXqJVeIhnXPNvYURC1wIXBdSKmPIkx9le71D
	 2QVOwTFmj8nfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/15] net: page_pool: add netlink notifications for state changes
Date: Tue, 24 Oct 2023 09:02:15 -0700
Message-ID: <20231024160220.3973311-11-kuba@kernel.org>
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
index cc9e87dc36e9..2963ff853dd6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -165,8 +165,25 @@ name: netdev
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
index 176665bcf0da..beb158872226 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -79,11 +79,15 @@ enum {
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
index fc5370cf654c..30b99eeb2cd5 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -56,6 +56,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 
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
index 3f90a20896c2..0c7f065907d9 100644
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
@@ -216,6 +250,8 @@ static void page_pool_unreg_netdev(struct net_device *netdev)
 	last = NULL;
 	hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
 		pool->slow.netdev = lo;
+		netdev_nl_page_pool_event(pool,
+					  NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
 		last = pool;
 	}
 	if (last)
-- 
2.41.0


