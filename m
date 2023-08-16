Return-Path: <netdev+bounces-28270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A908677EDE8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D889F281451
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB161DA59;
	Wed, 16 Aug 2023 23:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FA1DA29
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E51AC433CB;
	Wed, 16 Aug 2023 23:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229391;
	bh=MgbxZjurcVO+X35SjktS/Y8q8tIUv39RE0Blpm+/4zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoOIRqC/i7vq1z86EQUfV2GbKA3uvZdzvobYB52V9en15vVoZJ4CakYERC67wJqnn
	 bYgV1Vh5sFrZaYnWgAQloKXmR+ZtsrYKT6nTqXfG1zv+U3i2KAO/ExhmeBsc0hfJ7/
	 I544lTtvH3vFHo2QBnsCLvqAK+ScMMhaigvYrvmtSsRNTpH4KF4APjBm5dj2xzN5SD
	 b/Gk0XKcV1xm6D/esR0cA1QUBk6S91UljyIn83M9bR5GBGp3OE9S/CZFhPey7fVR8s
	 KMm2A+xef1U6FkDYQgFZtd8NAEoarmCC2sgpIy1bdpkXsFWFhYPEIFPKpzN7mwLGKa
	 1l1SUuX3eq0eA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 05/13] net: page_pool: record pools per netdev
Date: Wed, 16 Aug 2023 16:42:54 -0700
Message-ID: <20230816234303.3786178-6-kuba@kernel.org>
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
 include/linux/list.h          | 20 ++++++++
 include/linux/netdevice.h     |  4 ++
 include/net/page_pool/types.h |  4 ++
 net/core/page_pool_user.c     | 86 +++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..a65e3017a39b 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -1030,6 +1030,26 @@ static inline void hlist_move_list(struct hlist_head *old,
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
index 0896aaa91dd7..7576cd43b49e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2405,6 +2405,10 @@ struct net_device {
 	struct rtnl_hw_stats64	*offload_xstats_l3;
 
 	struct devlink_port	*devlink_port;
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	/** @page_pools: page pools created for this netdevice */
+	struct hlist_head	page_pools;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 9fadf15dadfa..b9db612708e4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -5,6 +5,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
+#include <linux/types.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
 					* map/unmap
@@ -50,6 +51,7 @@ struct pp_alloc_cache {
  * @pool_size:	size of the ptr_ring
  * @nid:	NUMA node id to allocate from pages from
  * @dev:	device, for DMA pre-mapping purposes
+ * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
@@ -68,6 +70,7 @@ struct page_pool_params {
 		unsigned int	offset;
 	);
 	struct_group_tagged(page_pool_params_slow, slow,
+		struct net_device *netdev;
 /* private: used by test code only */
 		void (*init_callback)(struct page *page, void *arg);
 		void *init_arg;
@@ -191,6 +194,7 @@ struct page_pool {
 	struct page_pool_params_slow slow;
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
+		struct hlist_node list;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index af4ac38a2de1..25977ce18e2b 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -1,14 +1,31 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
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
 
@@ -32,5 +53,70 @@ void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
 	xa_erase(&page_pools, pool->user.id);
+	hlist_del(&pool->user.list);
 	mutex_unlock(&page_pools_lock);
 }
+
+static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
+{
+	struct hlist_node *c, *n;
+
+	mutex_lock(&page_pools_lock);
+	hlist_for_each_safe(c, n, &netdev->page_pools)
+		hlist_del_init(c);
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
+	hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
+		pool->slow.netdev = lo;
+		last = pool;
+	}
+
+	hlist_splice_init(&netdev->page_pools, &last->user.list,
+			  &lo->page_pools);
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


