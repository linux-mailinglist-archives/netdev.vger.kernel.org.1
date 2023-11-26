Return-Path: <netdev+bounces-51165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4207F9646
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B48280D6F
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20CA171B1;
	Sun, 26 Nov 2023 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUgI69BV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3015EAB
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2068C433C8;
	Sun, 26 Nov 2023 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040099;
	bh=Q9MrTHFPaMnGEqibPpYqOm4CL7uSxXRP1zWoF04RNZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUgI69BVDxYokQKdUmV0p5DYcrwILniGIDse3+Au9798B1EIS+KXm20T2+HlWv/b+
	 GkkqZtBdVBkK/8zozkkUeX3SnfldHeHId2jEyU79VG5kbjBP8VOEBd6iyW23UpEDf3
	 33CgxKa2QkLh2MrEne5hwLuAqSRb/msO2+XD5UvP1GedCWIiEFhdqK/Shxrome3uh9
	 iFaS8Q1x/u21hDyRoNFG+qujXnWcjAijWKKp+EAx4dlH5rrL+lXs+Yg5W42+4MoGXd
	 dWTg070T+QASZzNZVLg7gfnlxn/7E2fDsWJyx6NykkYwhNmhlC5TCBGo1T1NsYdSY7
	 Rm1mJ0seOtqAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	almasrymina@google.com,
	shakeelb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 04/13] net: page_pool: stash the NAPI ID for easier access
Date: Sun, 26 Nov 2023 15:07:31 -0800
Message-ID: <20231126230740.2148636-5-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126230740.2148636-1-kuba@kernel.org>
References: <20231126230740.2148636-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid any issues with race conditions on accessing napi
and having to think about the lifetime of NAPI objects
in netlink GET - stash the napi_id to which page pool
was linked at creation time.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h | 1 +
 net/core/page_pool_user.c     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index b258a571201e..7e47d7bb2c1e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -193,6 +193,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u32 napi_id;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index e5c7f078fbd4..2888aa8dd3e4 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -37,9 +37,11 @@ int page_pool_list(struct page_pool *pool)
 	if (err < 0)
 		goto err_unlock;
 
-	if (pool->slow.netdev)
+	if (pool->slow.netdev) {
 		hlist_add_head(&pool->user.list,
 			       &pool->slow.netdev->page_pools);
+		pool->user.napi_id = pool->p.napi ? pool->p.napi->napi_id : 0;
+	}
 
 	mutex_unlock(&page_pools_lock);
 	return 0;
-- 
2.42.0


