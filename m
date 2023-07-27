Return-Path: <netdev+bounces-21948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085C76564C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D412823D9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED271775B;
	Thu, 27 Jul 2023 14:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5917AB0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:45:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40530D2;
	Thu, 27 Jul 2023 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469142; x=1722005142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31u+MUzH6+dKE9DPXFl5YBb0OxGcml0B6f7mnB7yaio=;
  b=WlpcAYbYb2itepcebcCzJdE+7Xr1o+J7p5mmk+RsDk2OoGdVqIdgWKP7
   Gu0EhIDNa3AVXk3VlG8Ibl+0ArAiR25cMz52Oc+bsDBxrtjVTAf1DExYp
   YginGj2IVwqLAKKldByUxSy2FFLDFoEN9dKzrdrAZJcZv/Q4rGiw8XYYq
   8zlzextyfBj97FKeTeCQu6epq0M85d0Q0jycG2kCvCCc3ewRTAauw3ZP9
   G0P7PUHe/wI5G0RhX5xHFIuGCk+xenkmeECSEZgBpILEScsOm3K2e0vUO
   aWQJMzOyUbjnFRqaE6VMdmKvauyGxuQI7quEyvQ8fYxDAWFSQoE5D79Ne
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139720"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119899"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119899"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:38 -0700
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
	Simon Horman <simon.horman@corigine.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/9] page_pool: place frag_* fields in one cacheline
Date: Thu, 27 Jul 2023 16:43:30 +0200
Message-ID: <20230727144336.1646454-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On x86_64, frag_* fields of struct page_pool are scattered across two
cachelines despite the summary size of 24 bytes. All three fields are
used in pretty much the same places, but the last field, ::frag_users,
is pushed out to the next CL, provoking unwanted false-sharing on
hotpath (frags allocation code).
There are some holes and cold members to move around. Move frag_* one
block up, placing them right after &page_pool_params perfectly at the
beginning of CL2. This doesn't do any meaningful to the second block, as
those are some destroy-path cold structures, and doesn't do anything to
::alloc_stats, which still starts at 200-byte offset, 8 bytes after CL3
(still fitting into 1 cacheline).
On my setup, this yields 1-2% of Mpps when using PP frags actively.
When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
CL, so there should be at least no regressions from the actual change.
::pages_state_hold_cnt is not related directly to that triple, but is
paired currently with ::frags_offset and decoupling them would mean
either two 4-byte holes or more invasive layout changes.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c7aef6c75935..664a787948e1 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -94,16 +94,16 @@ struct page_pool_stats {
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


