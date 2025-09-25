Return-Path: <netdev+bounces-226163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A54B9D201
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 04:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84ED1B27FA8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC31DDA24;
	Thu, 25 Sep 2025 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IzlaKAvq"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CA2BE65C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766723; cv=none; b=immLVnJYR0g00UkoUbfY4x6fqO0UsT98tQ+tCAuOfTSKL/MPjSbQfsHJdPPqv60QsjkwmI1VsaXEv101ZlrTUYcyvbr89yoYeAwNqm+gdW1QwzGOLwnw95QCDOsqEGsONScnyMc4UmU6L1PgzZverL7EBe6dWyChiDpIidxHS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766723; c=relaxed/simple;
	bh=yC67Qz9BVu3o6C+Ya9QG9VXaKvV9fnOT6h+H/YueVaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkQ5p/c95/OdpKN5us++pE4dkND28EofqMsz+B73rMdyW7nM8KLY03LoVoG5rwc39nZd5S/nCPy56jBecM4aqcK5KKqAxozCWy3kG7QBc11otGagsKAiUO2XHNiYoHwkkfn+mqdjgvIcMhHANddX+oLoKm3oh0/t7X4OscLXFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IzlaKAvq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758766719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+vTEd+KFkT42Qu2DnhVqkNvVyE6XX+4/zzfi9ZJMUM=;
	b=IzlaKAvq9IjcmOZB/UnG2GwUXKW4i74uP910qU/ZqIyMPGdBWzR9m63BUA1RjFb7fMkAfx
	FbHhJwBSgEdKBwaZ9UVEirbcD3wnI6jHEFrZ7BVdvq8NMTYZMMOhmomQST3gveACcUbnmC
	FHy7Tzs56w2N/8ZjqfYd8S0iVQmKNeE=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v6 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
Date: Thu, 25 Sep 2025 10:16:28 +0800
Message-Id: <20250925021628.886203-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
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

It's worth noting that we held lock_sock() before the replacement, so
there's no need to check if sk is hashed. Thanks to Kuniyuki Iwashima!

Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/inet_timewait_sock.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..89dc0a5d7248 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -87,12 +87,6 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
-				   struct hlist_nulls_head *list)
-{
-	hlist_nulls_add_head_rcu(&tw->tw_node, list);
-}
-
 static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, false);
@@ -112,11 +106,10 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 {
 	const struct inet_sock *inet = inet_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	struct inet_ehash_bucket *ehead = inet_ehash_bucket(hashinfo, sk->sk_hash);
 	spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
-	/* Step 1: Put TW into bind hash. Original socket stays there too.
+	/* Put TW into bind hash. Original socket stays there too.
 	   Note, that any socket with inet->num != 0 MUST be bound in
 	   binding cache, even if it is closed.
 	 */
@@ -140,19 +133,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 
 	spin_lock(lock);
 
-	/* Step 2: Hash TW into tcp ehash chain */
-	inet_twsk_add_node_rcu(tw, &ehead->chain);
-
-	/* Step 3: Remove SK from hash chain */
-	if (__sk_nulls_del_node_init_rcu(sk))
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-
-
-	/* Ensure above writes are committed into memory before updating the
-	 * refcount.
-	 * Provides ordering vs later refcount_inc().
-	 */
-	smp_wmb();
 	/* tw_refcnt is set to 3 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
@@ -162,6 +142,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 
+	/* Ensure tw_refcnt has been set before tw is published.
+	 * smp_wmb() provides the necessary memory barrier to enforce this
+	 * ordering.
+	 */
+	smp_wmb();
+
+	hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
-- 
2.25.1


