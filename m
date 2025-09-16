Return-Path: <netdev+bounces-223459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3311B593DA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2003E18839FD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B595930648B;
	Tue, 16 Sep 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HFvIe2eH"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAE305E32
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018684; cv=none; b=fiQbcX5r2bJWDmrxOxPEJmX1tK8/1czOj8ygXhuy/XEgGjm/JIssQGVm784zfvQZTQBj1qERUwuxujw24FEZaVLc4dbOlKpX2nRLDC2iuMvfcoNZ6oup15K0InmM/DctLCV3GlkDUZWFJNkQLvoYjsqg4RZHjxdlK34BUphFhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018684; c=relaxed/simple;
	bh=ps8U25sao5CXG0tpqB93fhXdpxfVN3zjkKs2BTxHOsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9DzWUIKlbP534uIF+CME+Vi2WbLYNaL33YnWPsgWlZ6SXo1W2PwXxZR9+UxsQJZRkSpaLBlyLuZtQtCRHiuID8ro2QgZu+wr6VBlRTmL2ufs6Ev1RmkO6AAD+QPBmHZKKnvxgM/VanY+4XAxGGNGrZCwRSmOmWAS09VO4WqV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HFvIe2eH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758018680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD7fKg3IFj16bfftiC1LbdPu+LDhhXsLvJU8rsm5XSk=;
	b=HFvIe2eH7dn4ulK2XBHoG0YTXXm5fzbnJ5ojnAGKlFCAADIchvBRssEG3hzr0UWn7jurzZ
	APZEg96RzIil/GbzBXDdnpOJTZwhYRzPm+v4QhruRw4+p/QkwoJs0RtFsxMFhOHQ7PxpZ0
	t2OZj4BG7l80ZFjR7W76KnWTqSrTpeM=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v3 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
Date: Tue, 16 Sep 2025 18:30:54 +0800
Message-Id: <20250916103054.719584-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Since ehash lookups are lockless, if another CPU is converting sk to tw
concurrently, fetching the newly inserted tw with tw->tw_refcnt == 0 cause
lookup failure.

The call trace map is drawn as follows:
   CPU 0                                CPU 1
   -----                                -----
				     inet_twsk_hashdance_schedule()
				     spin_lock()
				     inet_twsk_add_node_rcu(tw, ...)
__inet_lookup_established()
(find tw, failure due to tw_refcnt = 0)
				     __sk_nulls_del_node_init_rcu(sk)
				     refcount_set(&tw->tw_refcnt, 3)
				     spin_unlock()

By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() after
setting tw_refcnt, we ensure that tw is either fully initialized or not
visible to other CPUs, eliminating the race.

Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/inet_timewait_sock.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..1ba20c4cb73b 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -116,7 +116,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
-	/* Step 1: Put TW into bind hash. Original socket stays there too.
+	/* Put TW into bind hash. Original socket stays there too.
 	   Note, that any socket with inet->num != 0 MUST be bound in
 	   binding cache, even if it is closed.
 	 */
@@ -140,14 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 
 	spin_lock(lock);
 
-	/* Step 2: Hash TW into tcp ehash chain */
-	inet_twsk_add_node_rcu(tw, &ehead->chain);
-
-	/* Step 3: Remove SK from hash chain */
-	if (__sk_nulls_del_node_init_rcu(sk))
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-
-
 	/* Ensure above writes are committed into memory before updating the
 	 * refcount.
 	 * Provides ordering vs later refcount_inc().
@@ -162,6 +154,11 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 
+	if (hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	else
+		inet_twsk_add_node_rcu(tw, &ehead->chain);
+
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
-- 
2.25.1


