Return-Path: <netdev+bounces-160682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FAA1AD29
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD007A42CC
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE81487ED;
	Thu, 23 Jan 2025 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8i3Nme5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9471E884
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674183; cv=none; b=ax4BQO4kloTca4VrEKMyPJQTCwam3H2kMBG4gVOCl1IcRD2RCwTR9vcHAj8iSV+gd/ti1ff9/bvjcN7Y23N4PuBd9YdNjE9qy2jtn63QSlvZ0Zt0AEOc7uRBRu/9ArzdpQb2xqgB/eZwRujwrCQbVh3aXtNnnYp5iiXRWYhWbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674183; c=relaxed/simple;
	bh=C+HfYRs+lKH91FhdMzOFrti471zxUsAdVtRmhH2DPcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1WLYp6ku6+dyiT2qpghN5Wm+2kKzQYyMeDasxLMO9ozqyLHpkF7l2qJJyHMcc4CA5aahGk4XLbQpGmXLoO2dt2eQhYySc7EQyNgE1cEBTzUtf7YghmI4UV+pGLMps4iwzaJ7T86HI6HHlC4twABfQyeYDaVZkD8aq/1BNlZ6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8i3Nme5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0CC4CED3;
	Thu, 23 Jan 2025 23:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737674182;
	bh=C+HfYRs+lKH91FhdMzOFrti471zxUsAdVtRmhH2DPcc=;
	h=From:To:Cc:Subject:Date:From;
	b=b8i3Nme5y0mhoQqlniLykyT190u7FL6P6FQw2xrkHas9vQLYsuJI2SCoMPBFX7Oxx
	 1MxJO94xqmlUuh+Pd+hozzi2cTy+OmMBTumkpN2B9iV0e4LA8aQVIozgQnj4UIZPOe
	 oVCkXnM8Hz4qcwxfBR1LvucwuqrQIsYsf1FdRXIs4ijAiPBzKP2UEVvpDnIciK5lyw
	 rvRpnLKspkiTK55XdM8DbaaDu0JKypkCNkqp0MimDp5kx/1/nuIzxzYMpje4bDfHhq
	 UvPs05T7gC8PFzyQkz7BdWaKW0wLqAghOsXA8uD9iuUcNmHbJ3T2FH85Fzw/31q7IG
	 tlYiCxHcXCrpw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	asml.silence@gmail.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	willemb@google.com,
	mkarsten@uwaterloo.ca,
	jdamato@fastly.com
Subject: [PATCH net] net: page_pool: don't try to stash the napi id
Date: Thu, 23 Jan 2025 15:16:20 -0800
Message-ID: <20250123231620.1086401-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page ppol tried to cache the NAPI ID in page pool info to avoid
having a dependency on the life cycle of the NAPI instance.
Since commit under Fixes the NAPI ID is not populated until
napi_enable() and there's a good chance that page pool is
created before NAPI gets enabled.

Protect the NAPI pointer with the existing page pool mutex,
the reading path already holds it. napi_id itself we need
to READ_ONCE(), it's protected by netdev_lock() which are
not holding in page pool.

Before this patch napi IDs were missing for mlx5:

 # ./cli.py --spec netlink/specs/netdev.yaml --dump page-pool-get

 [{'id': 144, 'ifindex': 2, 'inflight': 3072, 'inflight-mem': 12582912},
  {'id': 143, 'ifindex': 2, 'inflight': 5568, 'inflight-mem': 22806528},
  {'id': 142, 'ifindex': 2, 'inflight': 5120, 'inflight-mem': 20971520},
  {'id': 141, 'ifindex': 2, 'inflight': 4992, 'inflight-mem': 20447232},
  ...

After:

 [{'id': 144, 'ifindex': 2, 'inflight': 3072, 'inflight-mem': 12582912,
   'napi-id': 565},
  {'id': 143, 'ifindex': 2, 'inflight': 4224, 'inflight-mem': 17301504,
   'napi-id': 525},
  {'id': 142, 'ifindex': 2, 'inflight': 4288, 'inflight-mem': 17563648,
   'napi-id': 524},
  ...

Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: asml.silence@gmail.com
CC: almasrymina@google.com
CC: kaiyuanz@google.com
CC: willemb@google.com
CC: mkarsten@uwaterloo.ca
CC: jdamato@fastly.com
---
 include/net/page_pool/types.h |  1 -
 net/core/page_pool_priv.h     |  2 ++
 net/core/dev.c                |  2 +-
 net/core/page_pool.c          |  2 ++
 net/core/page_pool_user.c     | 15 +++++++++------
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ed4cd114180a..7f405672b089 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -237,7 +237,6 @@ struct page_pool {
 	struct {
 		struct hlist_node list;
 		u64 detach_time;
-		u32 napi_id;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 57439787b9c2..2fb06d5f6d55 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -7,6 +7,8 @@
 
 #include "netmem_priv.h"
 
+extern struct mutex page_pools_lock;
+
 s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 
 int page_pool_list(struct page_pool *pool);
diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..07b2bb1ce64f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6708,7 +6708,7 @@ void napi_resume_irqs(unsigned int napi_id)
 static void __napi_hash_add_with_id(struct napi_struct *napi,
 				    unsigned int napi_id)
 {
-	napi->napi_id = napi_id;
+	WRITE_ONCE(napi->napi_id, napi_id);
 	hlist_add_head_rcu(&napi->napi_hash_node,
 			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
 }
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3de752c5178..ed0f89373259 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1147,7 +1147,9 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
 	WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
 	WARN_ON(READ_ONCE(pool->p.napi->list_owner) != -1);
 
+	mutex_lock(&page_pools_lock);
 	WRITE_ONCE(pool->p.napi, NULL);
+	mutex_unlock(&page_pools_lock);
 }
 EXPORT_SYMBOL(page_pool_disable_direct_recycling);
 
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..6677e0c2e256 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -3,6 +3,7 @@
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/xarray.h>
+#include <net/busy_poll.h>
 #include <net/net_debug.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
@@ -14,10 +15,11 @@
 #include "netdev-genl-gen.h"
 
 static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
-/* Protects: page_pools, netdevice->page_pools, pool->slow.netdev, pool->user.
+/* Protects: page_pools, netdevice->page_pools, pool->p.napi, pool->slow.netdev,
+ *	pool->user.
  * Ordering: inside rtnl_lock
  */
-static DEFINE_MUTEX(page_pools_lock);
+DEFINE_MUTEX(page_pools_lock);
 
 /* Page pools are only reachable from user space (via netlink) if they are
  * linked to a netdev at creation time. Following page pool "visibility"
@@ -216,6 +218,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 {
 	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
+	unsigned int napi_id;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -229,8 +232,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
 			pool->slow.netdev->ifindex))
 		goto err_cancel;
-	if (pool->user.napi_id &&
-	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi_id))
+
+	napi_id = pool->p.napi ? READ_ONCE(pool->p.napi->napi_id) : 0;
+	if (napi_id >= MIN_NAPI_ID &&
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, napi_id))
 		goto err_cancel;
 
 	inflight = page_pool_inflight(pool, false);
@@ -319,8 +324,6 @@ int page_pool_list(struct page_pool *pool)
 	if (pool->slow.netdev) {
 		hlist_add_head(&pool->user.list,
 			       &pool->slow.netdev->page_pools);
-		pool->user.napi_id = pool->p.napi ? pool->p.napi->napi_id : 0;
-
 		netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_ADD_NTF);
 	}
 
-- 
2.48.1


