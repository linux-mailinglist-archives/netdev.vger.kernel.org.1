Return-Path: <netdev+bounces-51173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D969C7F964E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3203B20AF8
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA018C05;
	Sun, 26 Nov 2023 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkJ/1ncl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2218B1D
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEE4C433CA;
	Sun, 26 Nov 2023 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040104;
	bh=ILw8AfH9LJ2gbqAr0v5KWt1pG0yL2gs9d+MYpxK3r1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkJ/1ncldjXyCXWUTDZyWKnSxyfk3J4Krcvq02ECx0hs66BdZMwH4eByjI6/THar3
	 cd+lJu8A/5Idq5MImmVdPMmhZbIVWzaktJ7MYcspjuFh27KDdn1FxGjYtWas+ptPdG
	 M5sF09Aarq49uvw01xXlcA3NovD2SupbOPd3Do9t9grmJ/jp0bdlTeNSQ8MquL15lu
	 nSRY5RbvLXsPKg9/EpLlj6pwpwNvqyVcecahXFXdXNclOnVRwegJVMemXdbCJVQcpk
	 eeheltfw7Drt6m6WW+X8bGkWFV3J3jvP4qe++uxXaAPBtudu3fq5vMs2uqbJuaBrXM
	 lIumzb5RJQvTQ==
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
Subject: [PATCH net-next v4 12/13] net: page_pool: mute the periodic warning for visible page pools
Date: Sun, 26 Nov 2023 15:07:39 -0800
Message-ID: <20231126230740.2148636-13-kuba@kernel.org>
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

Mute the periodic "stalled pool shutdown" warning if the page pool
is visible to user space. Rolling out a driver using page pools
to just a few hundred hosts at Meta surfaces applications which
fail to reap their broken sockets. Obviously it's best if the
applications are fixed, but we don't generally print warnings
for application resource leaks. Admins can now depend on the
netlink interface for getting page pool info to detect buggy
apps.

While at it throw in the ID of the pool into the message,
in rare cases (pools from destroyed netns) this will make
finding the pool with a debugger easier.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/page_pool.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3d0938a60646..c2e7c9a6efbe 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -897,18 +897,21 @@ static void page_pool_release_retry(struct work_struct *wq)
 {
 	struct delayed_work *dwq = to_delayed_work(wq);
 	struct page_pool *pool = container_of(dwq, typeof(*pool), release_dw);
+	void *netdev;
 	int inflight;
 
 	inflight = page_pool_release(pool);
 	if (!inflight)
 		return;
 
-	/* Periodic warning */
-	if (time_after_eq(jiffies, pool->defer_warn)) {
+	/* Periodic warning for page pools the user can't see */
+	netdev = READ_ONCE(pool->slow.netdev);
+	if (time_after_eq(jiffies, pool->defer_warn) &&
+	    (!netdev || netdev == NET_PTR_POISON)) {
 		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
 
-		pr_warn("%s() stalled pool shutdown %d inflight %d sec\n",
-			__func__, inflight, sec);
+		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
+			__func__, pool->user.id, inflight, sec);
 		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
 	}
 
-- 
2.42.0


