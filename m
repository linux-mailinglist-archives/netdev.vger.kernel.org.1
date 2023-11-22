Return-Path: <netdev+bounces-49908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB17F3C92
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986FF1C20E3F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63905156CE;
	Wed, 22 Nov 2023 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw0GS3IG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC07154AD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E95BC433C9;
	Wed, 22 Nov 2023 03:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624673;
	bh=k6BCwT3mMlwBdbDzwICVicjvlT2vUYZ5On66Y2xJ0vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rw0GS3IG2X1yQ5yeEO3GngxzTB2AifJ4gkFLv9Tso9lu836nmGx1kb07xYWT3a/j6
	 8IFOd4nxG4k3YabNJRN7tuY/STgIiDaI6cYx3Qql87QMcj12fY/1cr9Xh+MPep989H
	 c6AorMCztSaRGTLPSDlRfcFtV6IXI+ePyw8L3ocO3xodmmz6/SsTXKAU01InS+1Fxf
	 ghtKmv/BzjLgAOBugNXidK5P9pOt4IpewL6y3YX/PIRtkbspooHSJ/loy4HBzPuD0y
	 lfIRVGUiumOcTVfHVgzFsI5O1lv4kPGtZEFf70FgbMlYYoKNMCqHdVRXo08FKq5P/b
	 yNfx75gRw3UwQ==
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
Subject: [PATCH net-next v3 12/13] net: page_pool: mute the periodic warning for visible page pools
Date: Tue, 21 Nov 2023 19:44:19 -0800
Message-ID: <20231122034420.1158898-13-kuba@kernel.org>
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


