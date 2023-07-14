Return-Path: <netdev+bounces-17993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076A75402D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9116A1C2153D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD63156DC;
	Fri, 14 Jul 2023 17:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B4156D9
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:10:28 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EF0212B;
	Fri, 14 Jul 2023 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354627; x=1720890627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7p8mJB+ijeu7RaDZDF4ve84o/baC+2XSnWBRqZcf5LE=;
  b=kYDRqYPk6eMCWSeS7o4NMxIxqG8G2WyGCYYtEWj/Fu9Hq1C9k0z/VFqe
   JeQz4G95014EMVsp++8gWcwrvum9sAdd5quMBsJVURJrFmkf5VfBaOTtS
   6ngwWTna8kcaYKSJPnzDl8yRcLQm8MhicXM+mQseB6ufNNXxyHmubm2OO
   9N8LqPYPE8ssWbbR5aRbPaCE4/bMtK3oOXOQmdPu/Pf2KalHP2Vb7lFmB
   m9ozelMGKfl+ll/EnB12mtmWPuiZYcJgE5CU0Ul7vLvwyTytntZlAAHJM
   wJPv+Isz6pGv6qwEmBtMU1GY72yt01zizbb1fQye0sWiyAqWIU47YmKeT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891846"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787907004"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787907004"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:24 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields in one cacheline
Date: Fri, 14 Jul 2023 19:08:45 +0200
Message-ID: <20230714170853.866018-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714170853.866018-1-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On x86_64, frag_* fields of struct page_pool are scattered across two
cachelines despite the summary size of 24 bytes. The last field,
::frag_users, is pushed out to the next one, sharing it with
::alloc_stats.
All three fields are used in pretty much the same places. There are some
holes and cold members to move around. Move frag_* one block up, placing
them right after &page_pool_params perfectly at the beginning of CL2.
This doesn't do any meaningful to the second block, as those are some
destroy-path cold structures, and doesn't do anything to ::alloc_stats,
which still starts at 200-byte offset, 8 bytes after CL3 (still fitting
into 1 cacheline).
On my setup, this yields 1-2% of Mpps when using PP frags actively.
When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
CL, so there should be at least no regressions from the actual change.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 829dc1f8ba6b..212d72b5cfec 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -130,16 +130,16 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 struct page_pool {
 	struct page_pool_params p;
 
+	long frag_users;
+	struct page *frag_page;
+	unsigned int frag_offset;
+	u32 pages_state_hold_cnt;
+
 	struct delayed_work release_dw;
 	void (*disconnect)(void *);
 	unsigned long defer_start;
 	unsigned long defer_warn;
 
-	u32 pages_state_hold_cnt;
-	unsigned int frag_offset;
-	struct page *frag_page;
-	long frag_users;
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* these stats are incremented while in softirq context */
 	struct page_pool_alloc_stats alloc_stats;
-- 
2.41.0


