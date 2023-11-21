Return-Path: <netdev+bounces-49477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427577F21E5
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7354B21AE8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A383C6AD;
	Tue, 21 Nov 2023 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwyHX7e0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBEA955
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA10C43391;
	Tue, 21 Nov 2023 00:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524865;
	bh=0Q/ZGpLG4jJgBI+lMi9B0aOZ/dtz8R50hQbqD6SbpQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwyHX7e07TgXRyUADQ7p3/mLE6u4eaK3b3u7n2xZw8dZ9HPZod3nax05+vrhgj2D+
	 +a/7A/JEmrAkdc5NlryhBvN194M+QTPzP6t8yvRK23Cw+K45hdgMN8BlFB4PMpZ6MA
	 FUJgE8ebihjcR6YSk0XuLelQz/PJR9yyCv8/XqdrYCZLAKXanLM7yKqpRIIKbrcBQx
	 3lHz6uMUuc+bCVaQSt5tsbrY22EsPETPpaDx3aAtHArS+BJeIyZl1K/O0QrQmQt+im
	 TmKhuV0d5qGU629bSUzFYlVAn+TWfNF3skGpFlPq9HafkYcfg2uADm9BO8tk4K7VZs
	 uV0bHmnagiHTg==
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
Subject: [PATCH net-next v2 14/15] net: page_pool: mute the periodic warning for visible page pools
Date: Mon, 20 Nov 2023 16:00:47 -0800
Message-ID: <20231121000048.789613-15-kuba@kernel.org>
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
index af30c115769b..29cfd5d955ac 100644
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


