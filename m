Return-Path: <netdev+bounces-49906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02327F3C90
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC44B21B43
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C1125D7;
	Wed, 22 Nov 2023 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B78yVTrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528DC2C1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35836C433CC;
	Wed, 22 Nov 2023 03:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624671;
	bh=a1Rbvmm6RHsQBnDqqBVFiZ182uT+NxWVLFRwjgIxjoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B78yVTrzZ+O+zu5dueCrFG0rpsZSuK/Jv5+I47hETkY5V4cYKcpRR03SN7y/fQxFU
	 uC2d8elxYsKB6CGw4ullOVSAZJazlh89IB9OYCSk6jxg7mE67Z83P2OYP09pbyPWyt
	 puhTCWSUDraSPt1m12FSmm83QtaTqVExKoocn+d7jW6HCDbGmTrmsKK0BxFyolYnE6
	 q++sbC+Qkk9/S3f7dQCUAIHt9mKL6T5WqPvwEL3UKKst6EjAOV2S8fsCcISBl3GlIw
	 Zh4+RjHVRjVkjTUH2PAtc6vR9CXIw3tmMdDDyx8sy6sQFwNqDG8Vvg/wYvnFrlLYEm
	 f77NsuVfPZjAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 10/13] net: page_pool: report when page pool was destroyed
Date: Tue, 21 Nov 2023 19:44:17 -0800
Message-ID: <20231122034420.1158898-11-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report when page pool was destroyed. Together with the inflight
/ memory use reporting this can serve as a replacement for the
warning about leaked page pools we currently print to dmesg.

Example output for a fake leaked page pool using some hacks
in netdevsim (one "live" pool, and one "leaked" on the same dev):

$ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
           --dump page-pool-get
[{'id': 2, 'ifindex': 3},
 {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]

Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
 include/net/page_pool/types.h           |  1 +
 include/uapi/linux/netdev.h             |  1 +
 net/core/page_pool.c                    |  1 +
 net/core/page_pool_priv.h               |  1 +
 net/core/page_pool_user.c               | 12 ++++++++++++
 6 files changed, 29 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 85209e19dca9..695e0e4e0d8b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -125,6 +125,18 @@ name: netdev
         type: uint
         doc: |
           Amount of memory held by inflight pages.
+      -
+        name: detach-time
+        type: uint
+        doc: |
+          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
+          the driver. Once detached Page Pool can no longer be used to
+          allocate memory.
+          Page Pools wait for all the memory allocated from them to be freed
+          before truly disappearing. "Detached" Page Pools cannot be
+          "re-attached", they are just waiting to disappear.
+          Attribute is absent if Page Pool has not been detached, and
+          can still be used to allocate new memory.
 
 operations:
   list:
@@ -176,6 +188,7 @@ name: netdev
             - napi-id
             - inflight
             - inflight-mem
+            - detach-time
       dump:
         reply: *pp-reply
       config-cond: page-pool
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e47d7bb2c1e..ac286ea8ce2d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -193,6 +193,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u64 detach_time;
 		u32 napi_id;
 		u32 id;
 	} user;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 26ae5bdd3187..756410274120 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -70,6 +70,7 @@ enum {
 	NETDEV_A_PAGE_POOL_NAPI_ID,
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
+	NETDEV_A_PAGE_POOL_DETACH_TIME,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 566390759294..a821fb5fe054 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -953,6 +953,7 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 72fb21ea1ddc..90665d40f1eb 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -6,6 +6,7 @@
 s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 
 int page_pool_list(struct page_pool *pool);
+void page_pool_detached(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
 #endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index d889b347f8f4..f28ad2179f53 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -134,6 +134,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 			 inflight * refsz))
 		goto err_cancel;
+	if (pool->user.detach_time &&
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
+			 pool->user.detach_time))
+		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
 
@@ -219,6 +223,14 @@ int page_pool_list(struct page_pool *pool)
 	return err;
 }
 
+void page_pool_detached(struct page_pool *pool)
+{
+	mutex_lock(&page_pools_lock);
+	pool->user.detach_time = ktime_get_boottime_seconds();
+	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
+	mutex_unlock(&page_pools_lock);
+}
+
 void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
-- 
2.42.0


