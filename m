Return-Path: <netdev+bounces-28271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA277EDEA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98141281CD9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF51DA29;
	Wed, 16 Aug 2023 23:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D11DA37
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC96C433A9;
	Wed, 16 Aug 2023 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229392;
	bh=wTyns0rHGMhOrlmVTLl1HKmQaJEpEqkujQ+lVN5W5GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWhp1D4589NoJ5uMSKedDnmMavluQb0vStssZlfDlXot8lU/BZ8jhv9KQaROwxrjr
	 f+f/rl4D/HY9d4aVqMYHyjZXyoR1wtyxngA9HHSNnRlVtfGglF7m4kSYjBMCbe4HQ2
	 fXnke3Ywsrf5I3/uFOnksfhlh/NzsOPmXQxAS0/+Ph0AjGnBVjccUU4riAvospbFyO
	 Rgz0CdKgC86vU4tw0hrrC2MhaX3orsOO3yozWmfMOMdwf/V2WjWYugjWnUeHD73fvI
	 yUVzcJWvlRYvXYYQ9o/18qFmUpnXvtMpIprI1K1rkWYzufklk54Hhlus/Bc3utyKTX
	 Yf6PyAhOeSqQw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 06/13] net: page_pool: stash the NAPI ID for easier access
Date: Wed, 16 Aug 2023 16:42:55 -0700
Message-ID: <20230816234303.3786178-7-kuba@kernel.org>
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
index b9db612708e4..3017557e0c59 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -195,6 +195,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u32 napi_id;
 		u32 id;
 	} user;
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 25977ce18e2b..6632fc19a86f 100644
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
2.41.0


