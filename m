Return-Path: <netdev+bounces-24152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889D76EFCA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B042282295
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F425140;
	Thu,  3 Aug 2023 16:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8618B0D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:40:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FC3C2D;
	Thu,  3 Aug 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691080845; x=1722616845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=je7OKaPaRYpavTGKndiuzQRlw06aOtdts65xOwM2AUg=;
  b=lrx7MsYSuOaTOpWpSlHWHFzswRoeR5Vss+XzBmAmUYFkQ9bAv9c6w9Vv
   1r6gMCqxTdmhEE35kfhYhde3znTmgnRZnSkBdw+oKb/Cnh4t1Us5ar1gS
   DOLw3am0OgoGVN9VmVXD0gKQ22b6uzDWCcbpcs4QpzolCbibtdifBKHGd
   020DdYf3UIqeanWOwo7QCvDGX1zpl9aAmu4x86Ufzk0sN2dH9I/d/2Xjj
   PGFuGdlaLeKOQH8yN8udh5snoK4LJ4S6sZZQAcmlXFQE4lVy78vf7wI5p
   fRQuuKPJxxEOKpGQ3JSBSqbUE2aZNfNSkss1oJvtL62HeblOCzKVkbbKu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350229244"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350229244"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723268894"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723268894"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 09:40:42 -0700
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
Subject: [PATCH net-next v2 4/6] net: skbuff: avoid accessing page_pool if !napi_safe when returning page
Date: Thu,  3 Aug 2023 18:40:12 +0200
Message-ID: <20230803164014.993838-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803164014.993838-1-aleksander.lobakin@intel.com>
References: <20230803164014.993838-1-aleksander.lobakin@intel.com>
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

Currently, pp->p.napi is always read, but the actual variable it gets
assigned to is read-only when @napi_safe is true. For the !napi_safe
cases, which yet is still a pack, it's an unneeded operation.
Moreover, it can lead to premature or even redundant page_pool
cacheline access. For example, when page_pool_is_last_frag() returns
false (with the recent frag improvements).
Thus, read it only when @napi_safe is true. This also allows moving
@napi inside the condition block itself. Constify it while we are
here, because why not.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index acc5844a0de1..85f82a6a08dc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -882,9 +882,8 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
-	struct napi_struct *napi;
+	bool allow_direct = false;
 	struct page_pool *pp;
-	bool allow_direct;
 
 	page = compound_head(page);
 
@@ -904,9 +903,12 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
 	 */
-	napi = READ_ONCE(pp->p.napi);
-	allow_direct = napi_safe && napi &&
-		READ_ONCE(napi->list_owner) == smp_processor_id();
+	if (napi_safe) {
+		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
+
+		allow_direct = napi &&
+			READ_ONCE(napi->list_owner) == smp_processor_id();
+	}
 
 	/* Driver set this to memory recycling info. Reset it on recycle.
 	 * This will *not* work for NIC using a split-page memory model.
-- 
2.41.0


