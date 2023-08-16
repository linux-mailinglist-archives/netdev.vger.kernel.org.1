Return-Path: <netdev+bounces-28266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8577EDE1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495BB1C2125C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4F1C9F3;
	Wed, 16 Aug 2023 23:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BA1BF0F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E533FC43391;
	Wed, 16 Aug 2023 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229390;
	bh=gxnIjcwAhdbt0YKKMP4ncVjw5+aNN5jl+zNlz+nmHN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iB3Rh5cwrSHP1DD3CHlAhyL1IpDJ5j0hgV3OBWp4EiKA5EFHbUlT/os7Sq6GFqGPY
	 QFwvzMA/MwfMKs7/K90Fga2KnrDnAqwUtUDKJPi/Yjjnr494T+vbGAIg/jco5TjFBp
	 EFLFO4phjpmW4mnL8YuxtkJ4iLAXENJU+iOMXZLxnawCBfq5hHCZ2RuPPmWf830pSz
	 X941lDPDcE80x5ftRwLx0GkRIJ5CD2AfbJoYKGgYnfT6pYQp4xREfbrGDk3XotKJTE
	 4t7abA996znauqn9IV1FXSF35FW8CBPTuOTAs4U9mrsROb8XNXs2ED8Ptf1HWNklYV
	 BJxLi2uhw11qw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 02/13] net: page_pool: avoid touching slow on the fastpath
Date: Wed, 16 Aug 2023 16:42:51 -0700
Message-ID: <20230816234303.3786178-3-kuba@kernel.org>
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

To fully benefit from previous commit add one byte of state
in the first cache line recording if we need to look at
the slow part.

The packing isn't all that impressive right now, we create
a 7B hole. I'm expecting Olek's rework will reshuffle this,
anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h | 2 ++
 net/core/page_pool.c          | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1c16b95de62f..1ac7ce25fbd4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -127,6 +127,8 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params_fast p;
 
+	bool has_init_callback;
+
 	long frag_users;
 	struct page *frag_page;
 	unsigned int frag_offset;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ffe7782d7fc0..2c14445a353a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -216,6 +216,8 @@ static int page_pool_init(struct page_pool *pool,
 	    pool->p.flags & PP_FLAG_PAGE_FRAG)
 		return -EINVAL;
 
+	pool->has_init_callback = !!pool->slow.init_callback;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
 	if (!pool->recycle_stats)
@@ -373,7 +375,7 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 {
 	page->pp = pool;
 	page->pp_magic |= PP_SIGNATURE;
-	if (pool->slow.init_callback)
+	if (pool->has_init_callback)
 		pool->slow.init_callback(page, pool->slow.init_arg);
 }
 
-- 
2.41.0


