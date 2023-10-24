Return-Path: <netdev+bounces-43920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC997D5740
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C356B20FA6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6871F39949;
	Tue, 24 Oct 2023 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqhab2+B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBE39946
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88C0C43391;
	Tue, 24 Oct 2023 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163363;
	bh=Df/REHX/5ZhI+zjZpr9LVbHX60Be4NbLsvaXlODHYxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqhab2+BDo3WYSWL1kpfIK9F0yw/pAHshziqaU8goTRRKjMWnLj31hj1vy637+16s
	 NXzeRdyAyGWcvmkO+8REULI4Q1HNj21gEom8BdhYgE1BASNs9Gzn9iMjuqjdJG/v4q
	 2E98/KklLomrTZNsAZaUPW0go9r0EYemZ3c5dvsX3QueGDB+0U0kBcCI1CIRNr61Hx
	 +Kug00bYQDuoqlmbkIc6DivB+7FJfJ+1veOZJHeefGxymU9tj/fVFZTltTrUHO2xJa
	 ruptVPMllGg/ds/dMQAxG1iiKER2vW1PlTNalL2JIQO/gfeltGGN4DFIH/ISri1xDw
	 KUmRAQ3ixUTaQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/15] net: page_pool: record pools per netdev
Date: Tue, 24 Oct 2023 09:02:10 -0700
Message-ID: <20231024160220.3973311-6-kuba@kernel.org>
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

Link the page pools with netdevs. This needs to be netns compatible
so we have two options. Either we record the pools per netns and
have to worry about moving them as the netdev gets moved.
Or we record them directly on the netdev so they move with the netdev
without any extra work.

Implement the latter option. Since pools may outlast netdev we need
a place to store orphans. In time honored tradition use loopback
for this purpose.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: fix race between page pool and netdev disappearing (Simon)
---
 include/linux/list.h          | 20 ++++++++
 include/linux/netdevice.h     |  4 ++
 include/linux/poison.h        |  2 +
 include/net/page_pool/types.h |  4 ++
 net/core/page_pool_user.c     | 90 +++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 164b4d0e9d2a..3d8884472164 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -1111,6 +1111,26 @@ static inline void hlist_move_list(struct hlist_head *old,
 	old->first = NULL;
 }
 
+/**
+ * hlist_splice_init() - move all entries from one list to another
+ * @from: hlist_head from which entries will be moved
+ * @last: last entry on the @from list
+ * @to:   hlist_head to which entries will be moved
+ *
+ * @to can be empty, @from must contain at least @last.
+ */
+static inline void hlist_splice_init(struct hlist_head *from,
+				     struct hlist_node *last,
+				     struct hlist_head *to)
+{
+	if (to->first)
+		to->first->pprev = &last->next;
+	last->next = to->first;
+	to->first = from->first;
+	from->first->pprev = &to->first;
+	from->first = NULL;
+}
+
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
 
 #define hlist_for_each(pos, head) \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b8bf669212cc..224ee4680a31 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2431,6 +2431,10 @@ struct net_device {
 #if IS_ENABLED(CONFIG_DPLL)
 	struct dpll_pin		*dpll_pin;
 #endif
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	/** @page_pools: page pools created for this netdevice */
+	struct hlist_head	page_pools;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 851a855d3868..27a7dad17eef 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -83,6 +83,8 @@
 
 /********** net/core/skbuff.c **********/
 #define SKB_LIST_POISON_NEXT	((void *)(0x800 + POISON_POINTER_DELTA))
+/********** net/ **********/
+#define NET_PTR_POISON		((void *)(0x801 + POISON_POINTER_DELTA))
 
 /********** kernel/bpf/ **********/
 #define BPF_PTR_POISON ((void *)(0xeB9FUL + POISON_POINTER_DELTA))
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c19f0df3bf0b..b258a571201e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -5,6 +5,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
+#include <linux/types.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
 					* map/unmap
@@ -48,6 +49,7 @@ struct pp_alloc_cache {
  * @pool_size:	size of the ptr_ring
  * @nid:	NUMA node id to allocate from pages from
  * @dev:	device, for DMA pre-mapping purposes
+ * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
@@ -66,6 +68,7 @@ struct page_pool_params {
 		unsigned int	offset;
 	);
 	struct_group_tagged(page_pool_params_slow, slow,
+		struct net_device *netdev;
 /* private: used by test code only */
 		void (*init_callback)(struct page *page, void *arg);
 		void *init_arg;
@@ -189,6 +192,7 @@ struct page_pool {
 	struct page_pool_params_slow slow;
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
+		struct hlist_node list;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 630d1eeecf2a..7cd6f416b87a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -1,14 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 #include <linux/xarray.h>
+#include <net/net_debug.h>
 #include <net/page_pool/types.h>
 
 #include "page_pool_priv.h"
 
 static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
+/* Protects: page_pools, netdevice->page_pools, pool->slow.netdev, pool->user.
+ * Ordering: inside rtnl_lock
+ */
 static DEFINE_MUTEX(page_pools_lock);
 
+/* Page pools are only reachable from user space (via netlink) if they are
+ * linked to a netdev at creation time. Following page pool "visibility"
+ * states are possible:
+ *  - normal
+ *    - user.list: linked to real netdev, netdev: real netdev
+ *  - orphaned - real netdev has disappeared
+ *    - user.list: linked to lo, netdev: lo
+ *  - invisible - either (a) created without netdev linking, (b) unlisted due
+ *      to error, or (c) the entire namespace which owned this pool disappeared
+ *    - user.list: unhashed, netdev: unknown
+ */
+
 int page_pool_list(struct page_pool *pool)
 {
 	static u32 id_alloc_next;
@@ -20,6 +37,10 @@ int page_pool_list(struct page_pool *pool)
 	if (err < 0)
 		goto err_unlock;
 
+	if (pool->slow.netdev)
+		hlist_add_head(&pool->user.list,
+			       &pool->slow.netdev->page_pools);
+
 	mutex_unlock(&page_pools_lock);
 	return 0;
 
@@ -32,5 +53,74 @@ void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
 	xa_erase(&page_pools, pool->user.id);
+	hlist_del(&pool->user.list);
 	mutex_unlock(&page_pools_lock);
 }
+
+static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
+{
+	struct page_pool *pool;
+	struct hlist_node *n;
+
+	mutex_lock(&page_pools_lock);
+	hlist_for_each_entry_safe(pool, n, &netdev->page_pools, user.list) {
+		hlist_del_init(&pool->user.list);
+		pool->slow.netdev = NET_PTR_POISON;
+	}
+	mutex_unlock(&page_pools_lock);
+}
+
+static void page_pool_unreg_netdev(struct net_device *netdev)
+{
+	struct page_pool *pool, *last;
+	struct net_device *lo;
+
+	lo = __dev_get_by_index(dev_net(netdev), 1);
+	if (!lo) {
+		netdev_err_once(netdev,
+				"can't get lo to store orphan page pools\n");
+		page_pool_unreg_netdev_wipe(netdev);
+		return;
+	}
+
+	mutex_lock(&page_pools_lock);
+	last = NULL;
+	hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
+		pool->slow.netdev = lo;
+		last = pool;
+	}
+	if (last)
+		hlist_splice_init(&netdev->page_pools, &last->user.list,
+				  &lo->page_pools);
+	mutex_unlock(&page_pools_lock);
+}
+
+static int
+page_pool_netdevice_event(struct notifier_block *nb,
+			  unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+
+	if (event != NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
+
+	if (hlist_empty(&netdev->page_pools))
+		return NOTIFY_OK;
+
+	if (netdev->ifindex != 1)
+		page_pool_unreg_netdev(netdev);
+	else
+		page_pool_unreg_netdev_wipe(netdev);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block page_pool_netdevice_nb = {
+	.notifier_call = page_pool_netdevice_event,
+};
+
+static int __init page_pool_user_init(void)
+{
+	return register_netdevice_notifier(&page_pool_netdevice_nb);
+}
+
+subsys_initcall(page_pool_user_init);
-- 
2.41.0


