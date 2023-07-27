Return-Path: <netdev+bounces-21952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1223765658
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9741C21671
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED48171AB;
	Thu, 27 Jul 2023 14:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DA18024
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:46:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396BE35B6;
	Thu, 27 Jul 2023 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469155; x=1722005155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5UQmg0hLv8TkdVz/X6+MyXQQIYyvi5xDXayA3nnMuec=;
  b=c74bP8y341PVLLh37xGgpNzZG+c1qCCKvaZ+BaipaxeL4e8wohqMWPQR
   o0GrclNJvoQGQSiaBEmVjXFyKRTwpAeY+pBUnRXpGfPAz2kItOBiX5Ns+
   ayR9dxyAahTw9iYHUm5kYm3v/oGiHp5XcqhuMI0dRSLlY8VtRrQPTFKiS
   BzetrKHdI+YRCW8aNTsbR1GZMJmW9Yt/iLnl1Ok4KQdGumgYzauXz45fL
   ojTl7S44EGxnzAVWJsg8S6emAaPW9LpBvldZpsPPytJ7ZAjk/dEiD7gFD
   P7hCFE7/oe/Km54nTqJHsE5UAVcAJAEA4ZQUDLxysT94uWXzNd4mwPEwM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139821"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139821"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119944"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119944"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:51 -0700
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
Subject: [PATCH net-next 7/9] net: skbuff: avoid accessing page_pool if !napi_safe when returning page
Date: Thu, 27 Jul 2023 16:43:34 +0200
Message-ID: <20230727144336.1646454-8-aleksander.lobakin@intel.com>
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
index 3084ef59400b..e701401092d7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -881,9 +881,8 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 
 bool page_pool_return_skb_page(struct page *page, bool napi_safe)
 {
-	struct napi_struct *napi;
+	bool allow_direct = false;
 	struct page_pool *pp;
-	bool allow_direct;
 
 	page = compound_head(page);
 
@@ -903,9 +902,12 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
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


