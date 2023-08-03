Return-Path: <netdev+bounces-24184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1276F1C3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE01C215C9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF727263AB;
	Thu,  3 Aug 2023 18:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CE25909
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:21:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE9110;
	Thu,  3 Aug 2023 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691086864; x=1722622864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yC3uIe0tSBLBI12LM3uJtXCP5bvqTWQRcMrArt23Bjc=;
  b=PNPYR+DQmVZKWpJdkAvLF0Bc/Qjqrniu+rWyah8+2trhOHu7eQCglCt7
   H1n+naRuJ+9y1gZty1Lyf1SBBdoJm7CR6JzdGNd3/8SvvLGm9da81Xdmc
   OFlkg2Z2CF9fStuYor31QfXLhp3kAIhAiz1cKQZGqB9pI/askc3PME1L4
   PTOHeA3QDVI6iZXuerW83ibNcRt9DQ5TCrQR/+hsJfSC89XfoLc0QvDZ1
   vQLGwmlfzbDXoAO7J/egM/OxzFVK7DUrVPOxGinPwFTGH7XV7F4lao8Jt
   oOg3Fw87kWtSeQDIfwLjqYJAfVIrLfevW6tvc+eIP/2hdh/CAOiDf3C7b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433812032"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="433812032"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 11:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764784643"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="764784643"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 11:21:00 -0700
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
Subject: [PATCH net-next v3 6/6] net: skbuff: always try to recycle PP pages directly when in softirq
Date: Thu,  3 Aug 2023 20:20:38 +0200
Message-ID: <20230803182038.2646541-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
References: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
NAPI") allowed direct recycling of skb pages to their PP for some cases,
but unfortunately missed a couple of other majors.
For example, %XDP_DROP in skb mode. The netstack just calls kfree_skb(),
which unconditionally passes `false` as @napi_safe. Thus, all pages go
through ptr_ring and locks, although most of time we're actually inside
the NAPI polling this PP is linked with, so that it would be perfectly
safe to recycle pages directly.
Let's address such. If @napi_safe is true, we're fine, don't change
anything for this path. But if it's false, check whether we are in the
softirq context. It will most likely be so and then if ->list_owner
is our current CPU, we're good to use direct recycling, even though
@napi_safe is false -- concurrent access is excluded. in_softirq()
protection is needed mostly due to we can hit this place in the
process context (not the hardirq though).
For the mentioned xdp-drop-skb-mode case, the improvement I got is
3-4% in Mpps. As for page_pool stats, recycle_ring is now 0 and
alloc_slow counter doesn't change most of time, which means the
MM layer is not even called to allocate any new pages.

Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85f82a6a08dc..33fdf04d4334 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -902,8 +902,10 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	/* Allow direct recycle if we have reasons to believe that we are
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
+	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * and interrupts are enabled prior to accessing the cache.
 	 */
-	if (napi_safe) {
+	if (napi_safe || in_softirq()) {
 		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
 
 		allow_direct = napi &&
-- 
2.41.0


