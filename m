Return-Path: <netdev+bounces-54913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7F808E93
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108341C20A84
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1D495E1;
	Thu,  7 Dec 2023 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQCTuJ8g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F459171E;
	Thu,  7 Dec 2023 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701969749; x=1733505749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mm/jnD5a3nD/eU5fD39yjfwmZu/H3YrYKJa0Yek6DpA=;
  b=BQCTuJ8gDWRjyEcB8yXNrOidExWRuTTA8yHUswk3d+HWw/UurM8Xd/Yg
   a7iYviIMsp4755pzs/BsHXZ+g+NFYQwWbjCNQaqZGtBUWU3O6iSI5kv4U
   t2LxRSkkme6Jh2kIuUexWhYosclTyJyl5+t2cVexY5ZZOLAYKevLu12ln
   PwDoraWlL1akt6PZflsA9ScRTQd+RBiOsUScNoxNz107CDNY8u1B0T4Nj
   rldNE1KrVjbizHpwLuQH7pdUjfj4CXOWP+8xBR25nyPmz4OFLjvdd6OB6
   kwrKRPpvyVNJaigpYaa9vBwakL6U6QPbxJusNnfsvM4IzgCBiUDHJt8tA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374434921"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="374434921"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 09:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721548593"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721548593"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 09:22:24 -0800
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
Subject: [PATCH net-next v6 07/12] page_pool: add DMA-sync-for-CPU inline helper
Date: Thu,  7 Dec 2023 18:20:05 +0100
Message-ID: <20231207172010.1441468-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each driver is responsible for syncing buffers written by HW for CPU
before accessing them. Almost each PP-enabled driver uses the same
pattern, which could be shorthanded into a static inline to make driver
code a little bit more compact.
Introduce a simple helper which performs DMA synchronization for the
size passed from the driver. It can be used even when the pool doesn't
manage DMA-syncs-for-device, just make sure the page has a correct DMA
address set via page_pool_set_dma_addr().

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index c860fad50d00..73ef4d1e12d4 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -52,6 +52,8 @@
 #ifndef _NET_PAGE_POOL_HELPERS_H
 #define _NET_PAGE_POOL_HELPERS_H
 
+#include <linux/dma-mapping.h>
+
 #include <net/page_pool/types.h>
 
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -382,6 +384,28 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 	return false;
 }
 
+/**
+ * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
+ * @pool: &page_pool the @page belongs to
+ * @page: page to sync
+ * @offset: offset from page start to "hard" start if using PP frags
+ * @dma_sync_size: size of the data written to the page
+ *
+ * Can be used as a shorthand to sync Rx pages before accessing them in the
+ * driver. Caller must ensure the pool was created with ``PP_FLAG_DMA_MAP``.
+ * Note that this version performs DMA sync unconditionally, even if the
+ * associated PP doesn't perform sync-for-device.
+ */
+static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+					      const struct page *page,
+					      u32 offset, u32 dma_sync_size)
+{
+	dma_sync_single_range_for_cpu(pool->p.dev,
+				      page_pool_get_dma_addr(page),
+				      offset + pool->p.offset, dma_sync_size,
+				      page_pool_get_dma_dir(pool));
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
-- 
2.43.0


