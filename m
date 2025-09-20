Return-Path: <netdev+bounces-224978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36046B8C664
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280A11B27A0B
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782A2FBDF7;
	Sat, 20 Sep 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lHeFpJNp"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7CC2FB632
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366042; cv=none; b=lQeyvuTnzVtFLAkgyBTGQadVBEP8VjMveKZPCTX4nA4Th/tpgFj1xHig40kKIiW2ANoAucUG9UAHRCv0d3vJ4mYSOKI1JFy+5I5IrUVe+B5V+jlUrhV9xAh/A4hk+1Rk120F0h4wEulLaTmXWo74ZyJ33F6W9YWyxTD1nOtzMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366042; c=relaxed/simple;
	bh=F4B/fmz5pAi8yhrFAC/dTM+Chnrnp+ZwLdcj4Uw+s8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRXo5i5p/tYMwZIpp5OqDqvhlKfrHkGz56sUYcnfLdcMPIa7xfyahtP3aUawdZKy2Xvh3eqgs7T1kDmFncSsqgIJ8BbbnhoYDJZQJ6PSfoalVAs6sdOSSShjXCGW0LczLuaOLtTX+jZKXR0xcXxRMnZQLsNeaaesYNtXj3SWSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lHeFpJNp; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758366038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTadG7tRVSRC4eZ6MXNGan5qZuO9d9HWPQWAXzUU+/4=;
	b=lHeFpJNp/5yYCucNRBu4cttEOSeGX+MsjnONeMxawpbK2WoBrI3S98OZam3rMVW+GGi3HB
	xZV8ar9EjSBAuANhLJBEQvjybpLkqpRWhG9NkPWTbIYmGFGlCVXIAWFhKnpFfWdQ5+2nKG
	8xT3uLtIf+mWoGfQgmRZR2A5XdYkDvE=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v4 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
Date: Sat, 20 Sep 2025 18:59:45 +0800
Message-Id: <20250920105945.538042-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
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

It's worth noting that we replace under lock_sock(), so no need to check if sk
is hashed. Thanks to Kuniyuki Iwashima!

Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/inet_timewait_sock.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..bb98888584a8 100644
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
@@ -162,6 +154,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 
+	hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
-- 
2.25.1


