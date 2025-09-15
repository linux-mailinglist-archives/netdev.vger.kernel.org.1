Return-Path: <netdev+bounces-222935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77556B570D2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E933AD25D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 07:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134902C029C;
	Mon, 15 Sep 2025 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBXlI1mL"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8F2C028B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919887; cv=none; b=u3tVk5aNtfavMeaO/F6ZRRZL9j6f+nndf0Pz70aW8mDJlk8h9CEH0vznWERuaO2XTeeu/1q5U35PJeTZOJdt679KI+AZ/E8+zg+fjgAQhQ6M/0Jf3ZCavg4Tg2zy0ImxnXSmOmi5hO7Tl8Ef3KLmesa3lgsEqo3k+1dpzqsRarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919887; c=relaxed/simple;
	bh=ph9ztm3dZS/QMYfAvMlmE7Rmd+xzQAAxcw/PkLiODCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhDaPlb23IxstydwwOA3u+NKOlI6V418IP5JR4h2jnxm6+Jzag5qCSAGck5U+D/5HidXjeeCAimhdcMyQtZWZa+RHZV1j1hTXgZZ2jxZ3jjY9DfZETlDewfFnfSWnb4XOq5yeDNv3I3R1DzUSC9VEqHS4Z43MVklrivSd/a+aPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBXlI1mL; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757919883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QJqmSnqg3dX5RBNyhWr0qR2RwkmHjNuAPHZ6M3dh/M=;
	b=LBXlI1mLLEDPCLlSCPFeRPUl7mzouxg846bXHmn9DkegXHo0CYXosNsjUVwubvG03JvphK
	LcvxvMID0NgFDZKiJwbBJRTJ/3gMQvS0JacgGNLzFumFOXIbkCzO1MemZZ8Uw0Lt6queF1
	9oSGTCzYpLvOkYh9NAMdQ808fnJxJQQ=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
Date: Mon, 15 Sep 2025 15:03:08 +0800
Message-Id: <20250915070308.111816-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
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
 net/ipv4/inet_timewait_sock.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..4c84a020315d 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -115,8 +115,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	struct inet_ehash_bucket *ehead = inet_ehash_bucket(hashinfo, sk->sk_hash);
 	spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
+	bool ret = false;
 
-	/* Step 1: Put TW into bind hash. Original socket stays there too.
+	/* Put TW into bind hash. Original socket stays there too.
 	   Note, that any socket with inet->num != 0 MUST be bound in
 	   binding cache, even if it is closed.
 	 */
@@ -140,14 +141,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 
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
@@ -162,6 +155,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 
+	if (sk_hashed(sk)) {
+		ret = hlist_nulls_replace_init_rcu(&sk->sk_nulls_node,
+						   &tw->tw_node);
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	}
+
+	if (!ret)
+		inet_twsk_add_node_rcu(tw, &ehead->chain);
+
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
-- 
2.27.0


