Return-Path: <netdev+bounces-49469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2FD7F21DD
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C28B21B37
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A182D3B7BE;
	Tue, 21 Nov 2023 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMmZZXFQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494F3B7BA
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0846C433CA;
	Tue, 21 Nov 2023 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524860;
	bh=pR08Q6FORwYayHs7uhiLfNHKIns5vmXKCyxM52jBe7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMmZZXFQ/tNZORyrfkOnjMyWzDl/wDvvP5YI8VkoSJL52q4dNoKQSMSeqefKI/9Q9
	 BJgxHpm6sgVNE+900Ow6rMmEyZ3Qw9hCnO1O/YIQq99uWwA1vwzWYOT07DrYbzj+rn
	 kyvUHgp3CcQ27I9Guhe/3Yj2pYmoVmnCGqdve6XMQ+tjcXImVuFP56JFr+4JDpA1g7
	 KY1aq1d0vqrcTm3iYlBw55M28zW9hB5mPdfMsl+S5fTzpwMA1duZH3mDfY7V8dSrLN
	 jRv1DfvMkVMeIX+4wkZS1eY4GVt+PKFwKX6Kuz3zZOfAcRIcMxBkcxbLhE/pINPbMU
	 4XavefyjlTUOQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 06/15] net: page_pool: stash the NAPI ID for easier access
Date: Mon, 20 Nov 2023 16:00:39 -0800
Message-ID: <20231121000048.789613-7-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121000048.789613-1-kuba@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
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


