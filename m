Return-Path: <netdev+bounces-50915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E587F7835
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788701C210F5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD331751;
	Fri, 24 Nov 2023 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbnSPbXR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FE1BE6;
	Fri, 24 Nov 2023 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700841029; x=1732377029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbdR9gi5ntlQxzvUezUS2MNEgeocQ5hNjBegzQsgPW4=;
  b=YbnSPbXRv7q2XDt96TJLvdQZ8IsMASGFBOJFBlU+jlHLDqIFj6NxLZ2z
   FEAauUehKSlSlsAlxGSUSFEYeP3Qv4wPggC6baEm88qODlTRggza957sg
   5a2JXY/AGJB+Ng0siVXfh/Q20VAZVER4sym4pTnxshL4L5llxn+plp5VV
   Z7VUR37qLWBPfGpCzQ9QGNRf1PiJv0wG/+D7k3LZLrvxI/eFUp69sNrWD
   WJaCY4AlE2aiZOXfB/BzdAwCSzNqmxkDcqrc5XFdWSHE2NoXbHU714JEN
   LUDw6jvfRIrrimyFkd7n+qlkH/HkEJuypowsclD0gBcTuZ4Mj2NkWQmcm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389592541"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389592541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15660032"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 07:50:26 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	David Christensen <drc@linux.vnet.ibm.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 07/14] page_pool: constify some read-only function arguments
Date: Fri, 24 Nov 2023 16:47:25 +0100
Message-ID: <20231124154732.1623518-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several functions taking pointers to data they don't modify.
This includes statistics fetching, page and page_pool parameters, etc.
Constify the pointers, so that call sites will be able to pass const
pointers as well.
No functional changes, no visible changes in functions sizes.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 12 ++++++------
 net/core/page_pool.c            | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 28bec368b8e9..528a76c66270 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -59,14 +59,14 @@
 #ifdef CONFIG_PAGE_POOL_STATS
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);
 
 /*
  * Drivers that wish to harvest page pool stats and report them to users
  * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
  * struct page_pool_stats call page_pool_get_stats to get stats for the specified pool.
  */
-bool page_pool_get_stats(struct page_pool *pool,
+bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats);
 #else
 static inline int page_pool_ethtool_stats_get_count(void)
@@ -79,7 +79,7 @@ static inline u8 *page_pool_ethtool_stats_get_strings(u8 *data)
 	return data;
 }
 
-static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
 	return data;
 }
@@ -210,8 +210,8 @@ static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
  * Get the stored dma direction. A driver might decide to store this locally
  * and avoid the extra cache line from page_pool to determine the direction.
  */
-static
-inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
+static inline enum dma_data_direction
+page_pool_get_dma_dir(const struct page_pool *pool)
 {
 	return pool->p.dma_dir;
 }
@@ -368,7 +368,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  * Fetch the DMA address of the page. The page pool to which the page belongs
  * must had been created with PP_FLAG_DMA_MAP.
  */
-static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
 	dma_addr_t ret = page->dma_addr & ~PAGE_POOL_DMA_ADDR_NEED_SYNC;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 09bdfdfc4788..e5ee49e8799c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -69,7 +69,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
  * is passed to this API which is filled in. The caller can then report
  * those stats to the user (perhaps via ethtool, debugfs, etc.).
  */
-bool page_pool_get_stats(struct page_pool *pool,
+bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats)
 {
 	int cpu = 0;
@@ -119,9 +119,9 @@ int page_pool_ethtool_stats_get_count(void)
 }
 EXPORT_SYMBOL(page_pool_ethtool_stats_get_count);
 
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
-	struct page_pool_stats *pool_stats = stats;
+	const struct page_pool_stats *pool_stats = stats;
 
 	*data++ = pool_stats->alloc_stats.fast;
 	*data++ = pool_stats->alloc_stats.slow;
@@ -338,8 +338,8 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
+static void page_pool_dma_sync_for_device(const struct page_pool *pool,
+					  const struct page *page,
 					  unsigned int dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
@@ -509,7 +509,7 @@ EXPORT_SYMBOL(page_pool_alloc_pages);
  */
 #define _distance(a, b)	(s32)((a) - (b))
 
-static s32 page_pool_inflight(struct page_pool *pool)
+static s32 page_pool_inflight(const struct page_pool *pool)
 {
 	u32 release_cnt = atomic_read(&pool->pages_state_release_cnt);
 	u32 hold_cnt = READ_ONCE(pool->pages_state_hold_cnt);
-- 
2.42.0


