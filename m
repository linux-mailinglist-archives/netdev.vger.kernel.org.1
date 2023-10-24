Return-Path: <netdev+bounces-43929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4C7D574A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CED81C20C4D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D68E3B780;
	Tue, 24 Oct 2023 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDpujFcs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305823B2BD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDF1C43395;
	Tue, 24 Oct 2023 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163367;
	bh=d5KGIwZMPqHzn1YtEXZDwmt0bhtJttLrgmGvaZ2Sbsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDpujFcs6vWHGXPGk7cVsfNhSHVuYQV1wTJf4TXXYPTrwOSpwIpw0fdTThQpjAGre
	 +4a1liSqF+hAIwNl2OcJxgT2FIhI7UMXuCtcIKO/fIoZDGbzmsky6LRL5UVQjVm9ge
	 XGMUVyb7KHksUBKDogM1XN7+hN/aWRVOE4pqLrP2B4UYQwK0wR1YOTS6BRaTsA5UxO
	 /hE4ZmzmWxalZG62YjVHSLBoVpxdyjx29nHYsV6OTt5xZ4zbzQiICvab9DrdXDR1ve
	 UaBj2LUk0TsBkuZus4CMRt7t9uyYFbX1X+NIwyKJxNpyUo9xIfbIbQexCquVzqljYJ
	 AOpil9bsYxcpg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 14/15] net: page_pool: mute the periodic warning for visible page pools
Date: Tue, 24 Oct 2023 09:02:19 -0700
Message-ID: <20231024160220.3973311-15-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/page_pool.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 366ddb00778f..0a9f0f762ec8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -893,18 +893,21 @@ static void page_pool_release_retry(struct work_struct *wq)
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
2.41.0


