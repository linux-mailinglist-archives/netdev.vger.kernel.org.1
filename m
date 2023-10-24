Return-Path: <netdev+bounces-43917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D77D573D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BEF1C20BA9
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8339929;
	Tue, 24 Oct 2023 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw4jj7wG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8839925
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCA5C433C7;
	Tue, 24 Oct 2023 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163361;
	bh=Bmga8i8XqbSxVDkvyrebpWMT/LXO6SOpTu6pyhAa8c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tw4jj7wG2JhZ3VrjIAgpS8MynQv/h7WY6dzi2jXJub+0x7QDaFhnIQc8tlWfdMvOW
	 AeNPanQ35cXgtNkZgbf56QbENNagcvfOKk6cMH9JP4kD0VAfmNJua35eky1E5st5Oq
	 4yDn022f8dZUBDGF7mbRGPm9dhOCAkq1A6Znm59FCWbpL2U3vQ5XE9ZPuAK7cxKxG9
	 RMEEfS2ALhWMdn+m/c9WrceNzP4zKUO/3Ubysianit/Ko0dJhsimE7XSFyaIziyP8P
	 LzSL4v6/ck4Kbk6CBdGMOMnNwe7Aihyo/mE/aaUmj4GB4+JKeqnp/bggO9BB3okhRQ
	 YrXKDQYC/fvfg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/15] net: page_pool: avoid touching slow on the fastpath
Date: Tue, 24 Oct 2023 09:02:07 -0700
Message-ID: <20231024160220.3973311-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
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

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h | 2 ++
 net/core/page_pool.c          | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 23950fcc4eca..e1bb92c192de 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -125,6 +125,8 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params_fast p;
 
+	bool has_init_callback;
+
 	long frag_users;
 	struct page *frag_page;
 	unsigned int frag_offset;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5cae413de7cc..08af9de8e8eb 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -212,6 +212,8 @@ static int page_pool_init(struct page_pool *pool,
 		 */
 	}
 
+	pool->has_init_callback = !!pool->slow.init_callback;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
 	if (!pool->recycle_stats)
@@ -385,7 +387,7 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 	 * the overhead is negligible.
 	 */
 	page_pool_fragment_page(page, 1);
-	if (pool->slow.init_callback)
+	if (pool->has_init_callback)
 		pool->slow.init_callback(page, pool->slow.init_arg);
 }
 
-- 
2.41.0


