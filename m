Return-Path: <netdev+bounces-49900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8F7F3C8A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FEF1C20EE8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6DC13C;
	Wed, 22 Nov 2023 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQLBD9ep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689AC131
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C2BC433C8;
	Wed, 22 Nov 2023 03:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624667;
	bh=pR08Q6FORwYayHs7uhiLfNHKIns5vmXKCyxM52jBe7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQLBD9epnNTlbAcuwySNihKASbRUEVUu8V+G43ZDsfDWsmi8TBfafeKTQT5sh0y7N
	 KqufGpHbU1cZDEkNfVB79BBQX+qjR59kNzD4quNGEmwdgapa9SMknEI++TBWtIQ3Eg
	 HF73KofW5pMFkePhLW/8zWCzUB9tQhKaa4wgwXVHbtySITq4glVkfqm0LbNXZAEGda
	 u4q/tMi4UvEuof0z+QUsoqQFEEwzqvszqa4HhBNNPZUTBqEyb4hVmqN+IvrBBe+ntq
	 8gl15rG+e05W58qGQrufcmAdDO4n/bgVzrR+NuxKPGHKKBJcMWTQrNVYefwRtKbDr6
	 FCtCrO4lZf5BA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 04/13] net: page_pool: stash the NAPI ID for easier access
Date: Tue, 21 Nov 2023 19:44:11 -0800
Message-ID: <20231122034420.1158898-5-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
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
index 1591dbd66d51..23074d4c75fc 100644
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


