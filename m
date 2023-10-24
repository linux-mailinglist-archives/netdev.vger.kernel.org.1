Return-Path: <netdev+bounces-43927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ECC7D5749
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF2CB2111D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AE3B2A8;
	Tue, 24 Oct 2023 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvdMQvLz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38A3B2A4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7EFC433CC;
	Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163366;
	bh=WXUfXIMmGfQ+tYPU2ODZNUryA5fPwX9aYOyDJkRFBdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvdMQvLz2CgZ60Os62IxJzV/aMa5NbmiZIVPhnqeQJ6cMX3R9SIQQmBwj3hoD6d+P
	 b2a8TEu97fpbMkssaaPRCI1E3AuQtqwEq+yqH6vVKg/n/oycpAK3mVyKFE6NrrbZTR
	 i+0F9O5dNfAAc8/Mr3dLh/H05kxk2xr7hYyR7kWThyz2R1KtuEQUTVZEgluTRfvUkD
	 w21CRo9T0/71iGEUQAHkxWRq5rXQfmbarmSC/mJNHUXK4O/kmLpgFd/P/DmTDbRkrT
	 1S8IPPA4Ih/K9IEVBzg1SJ55nt3e6n1Al/nTRPqR40MfgZ91CMO9NHdVlR5VFOGYIK
	 wI6T9Q6/E5/EQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 12/15] net: page_pool: report when page pool was destroyed
Date: Tue, 24 Oct 2023 09:02:17 -0700
Message-ID: <20231024160220.3973311-13-kuba@kernel.org>
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

Report when page pool was destroyed. Together with the inflight
/ memory use reporting this can serve as a replacement for the
warning about leaked page pools we currently print to dmesg.

Example output for a fake leaked page pool using some hacks
in netdevsim (one "live" pool, and one "leaked" on the same dev):

$ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
           --dump page-pool-get
[{'id': 2, 'ifindex': 3},
 {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml |  9 +++++++++
 include/net/page_pool/types.h           |  1 +
 include/uapi/linux/netdev.h             |  1 +
 net/core/page_pool.c                    |  1 +
 net/core/page_pool_priv.h               |  1 +
 net/core/page_pool_user.c               | 12 ++++++++++++
 6 files changed, 25 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 8d995760a14a..8be8f249bed3 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -125,6 +125,14 @@ name: netdev
         type: uint
         doc: |
           Amount of memory held by inflight pages.
+      -
+        name: destroyed
+        type: uint
+        doc: |
+          Seconds in CLOCK_BOOTTIME of when Page Pool was destroyed.
+          Page Pools wait for all the memory allocated from them to be freed
+          before truly disappearing.
+          Absent if Page Pool hasn't been destroyed.
 
 operations:
   list:
@@ -176,6 +184,7 @@ name: netdev
             - napi-id
             - inflight
             - inflight-mem
+            - destroyed
       dump:
         reply: *pp-reply
     -
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e47d7bb2c1e..f0c51ef5e345 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -193,6 +193,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u64 destroyed;
 		u32 napi_id;
 		u32 id;
 	} user;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 26ae5bdd3187..e5bf66d2aa31 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -70,6 +70,7 @@ enum {
 	NETDEV_A_PAGE_POOL_NAPI_ID,
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
+	NETDEV_A_PAGE_POOL_DESTROYED,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 30c8fc91fa66..57847fbb76a0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -949,6 +949,7 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	page_pool_destroyed(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 72fb21ea1ddc..7fe6f842a270 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -6,6 +6,7 @@
 s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 
 int page_pool_list(struct page_pool *pool);
+void page_pool_destroyed(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
 #endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index c971fe9eeb01..1fb5c3cbe412 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -134,6 +134,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 			 inflight * refsz))
 		goto err_cancel;
+	if (pool->user.destroyed &&
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DESTROYED,
+			 pool->user.destroyed))
+		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
 
@@ -219,6 +223,14 @@ int page_pool_list(struct page_pool *pool)
 	return err;
 }
 
+void page_pool_destroyed(struct page_pool *pool)
+{
+	mutex_lock(&page_pools_lock);
+	pool->user.destroyed = ktime_get_boottime_seconds();
+	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
+	mutex_unlock(&page_pools_lock);
+}
+
 void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
-- 
2.41.0


