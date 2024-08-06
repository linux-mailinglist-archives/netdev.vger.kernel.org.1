Return-Path: <netdev+bounces-116144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D59949452
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229362891DD
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5631BA20;
	Tue,  6 Aug 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM7DSRGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122A2231C
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957384; cv=none; b=k/+I75LmseZUT8glLECqMIal4JBgfo02Puf0mRlmJ7su1IzwuyLvgx8V1qKtm5E2qwz4/07ebGEaeAPxeiM7BJfWnW9Y7CZDOC5IuiPxOyhJZOPta1Ga8Cmt39/zcrA/uRPDvZA6wKDVomWqtTOuhqNKPI/F+1P5HK3T8b4CBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957384; c=relaxed/simple;
	bh=acS+17K8H37GlJf3zu5LSwNqT0J881kzyUdHPvJAO1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwJt/wqvWqq5jfPfSWK2nn3YJim6qc+f7OIWoJ2wkF4bdGCGVA2pb+vHeU74ovY0a+Lgsnvokam/atKKPX0kvowvZvc+LKGkoIp/GJ4+N3ff/GSIpZSbjnwjJwOlqvxS1iOZA21B280N15aU4CFCCJDQWQE6vd8V3eh0dudN/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM7DSRGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E3C32786;
	Tue,  6 Aug 2024 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957384;
	bh=acS+17K8H37GlJf3zu5LSwNqT0J881kzyUdHPvJAO1g=;
	h=From:To:Cc:Subject:Date:From;
	b=bM7DSRGf283WwToqz1DC9fs177pExgOF7r4uFEa//yOhk9UbNF21XTI7hTXp3C+RT
	 nBFOSgQ1iT/TiY1t//6LPelEyOmh0KUzl9UfYVIb3bHef/nCO2Otw82Y1a93ZIxepg
	 Vegwyu03zhe3pARrDIkI8g/fVkFJb84YBUTvS4BhwLICDWVopxgPwjIl84DIz+wpH3
	 oCWGFPJ0L9OkwtUZr2/RwsNDBUWeRfrqaZSW4Ckqizsauv+VISNsBI6Bm5K/sA8fvx
	 J4Sm3wksvX0oSX8LYrckLdrRHXYqsSJG9U+h+JAJBG8xg5qF2swvvrMCa0lEjuXCcY
	 HrymABpGxqZcg==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: [RFC net] net: make page pool stall netdev unregistration to avoid IOMMU crashes
Date: Tue,  6 Aug 2024 08:16:18 -0700
Message-ID: <20240806151618.1373008-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There appears to be no clean way to hold onto the IOMMU, so page pool
cannot outlast the driver which created it. We have no way to stall
the driver unregister, but we can use netdev unregistration as a proxy.

Note that page pool pages may last forever, we have seen it happen
e.g. when application leaks a socket and page is stuck in its rcv queue.
Hopefully this is fine in this particular case, as we will only stall
unregistering of devices which want the page pool to manage the DMA
mapping for them, i.e. HW backed netdevs. And obviously keeping
the netdev around is preferable to a crash.

More work is needed for weird drivers which share one pool among
multiple netdevs, as they are not allowed to set the pp->netdev
pointer. We probably need to add a bit that says "don't expose
to uAPI for them".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Untested, but I think it would work.. if it's not too controversial.

CC: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Yonglong Liu <liuyonglong@huawei.com>
CC: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/netdevice.h |  4 ++++
 net/core/page_pool_user.c | 44 +++++++++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..c817bde7bacc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2342,6 +2342,8 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	bool			threaded;
+	/** @pp_unreg_pending: page pool code is stalling unregister */
+	bool			pp_unreg_pending;
 
 	struct list_head	net_notifier_list;
 
@@ -2371,6 +2373,8 @@ struct net_device {
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
+	/** @pp_dev_tracker: ref tracker for page pool code stalling unreg */
+	netdevice_tracker	pp_dev_tracker;
 #endif
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 3a3277ba167b..1a4135f01130 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -349,22 +349,36 @@ static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-	mutex_lock(&page_pools_lock);
 	hlist_for_each_entry_safe(pool, n, &netdev->page_pools, user.list) {
 		hlist_del_init(&pool->user.list);
 		pool->slow.netdev = NET_PTR_POISON;
 	}
-	mutex_unlock(&page_pools_lock);
 }
 
-static void page_pool_unreg_netdev(struct net_device *netdev)
+static void page_pool_unreg_netdev_stall(struct net_device *netdev)
+{
+	if (!netdev->pp_unreg_pending) {
+		netdev_hold(netdev, &netdev->pp_dev_tracker, GFP_KERNEL);
+		netdev->pp_unreg_pending = true;
+	} else {
+		netdev_warn(netdev,
+			    "page pool release stalling device unregister");
+	}
+}
+
+static void page_pool_unreg_netdev_unstall(struct net_device *netdev)
+{
+	netdev_put(netdev, &netdev->pp_dev_tracker);
+	netdev->pp_unreg_pending = false;
+}
+
+static void page_pool_unreg_netdev_reparent(struct net_device *netdev)
 {
 	struct page_pool *pool, *last;
 	struct net_device *lo;
 
 	lo = dev_net(netdev)->loopback_dev;
 
-	mutex_lock(&page_pools_lock);
 	last = NULL;
 	hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
 		pool->slow.netdev = lo;
@@ -375,7 +389,6 @@ static void page_pool_unreg_netdev(struct net_device *netdev)
 	if (last)
 		hlist_splice_init(&netdev->page_pools, &last->user.list,
 				  &lo->page_pools);
-	mutex_unlock(&page_pools_lock);
 }
 
 static int
@@ -383,17 +396,30 @@ page_pool_netdevice_event(struct notifier_block *nb,
 			  unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct page_pool *pool;
+	bool has_dma;
 
 	if (event != NETDEV_UNREGISTER)
 		return NOTIFY_DONE;
 
-	if (hlist_empty(&netdev->page_pools))
+	if (hlist_empty(&netdev->page_pools) && !netdev->pp_unreg_pending)
 		return NOTIFY_OK;
 
-	if (netdev->ifindex != LOOPBACK_IFINDEX)
-		page_pool_unreg_netdev(netdev);
-	else
+	mutex_lock(&page_pools_lock);
+	has_dma = false;
+	hlist_for_each_entry(pool, &netdev->page_pools, user.list)
+		has_dma |= pool->slow.flags & PP_FLAG_DMA_MAP;
+
+	if (has_dma)
+		page_pool_unreg_netdev_stall(netdev);
+	else if (netdev->pp_unreg_pending)
+		page_pool_unreg_netdev_unstall(netdev);
+	else if (netdev->ifindex == LOOPBACK_IFINDEX)
 		page_pool_unreg_netdev_wipe(netdev);
+	else /* driver doesn't let page pools manage DMA addrs */
+		page_pool_unreg_netdev_reparent(netdev);
+	mutex_unlock(&page_pools_lock);
+
 	return NOTIFY_OK;
 }
 
-- 
2.45.2


