Return-Path: <netdev+bounces-219406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D2B4127B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7793BA1C4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5B3594B;
	Wed,  3 Sep 2025 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpQ1GaYx"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82981E49F
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867555; cv=none; b=m7HxiRFzZLorRX57qFMyEDLSerYXBoKkfq2vi1+jx+twqrJsE+r8v7WF8z6jLO+NjqzeHMm35EmCfgCSTCCZzmc7Ja4PpksHi7E7IpLuOCxncQWkiuYUxrPfyBOqUnrudlr/xzEPwsQrFEQAGnQ3mvgGIOJCGIfYoxdaouom/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867555; c=relaxed/simple;
	bh=mWmSxW49NzhxHqLvpvEE57eZ69aR7os/RZgl/cMZIVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwExGTpR2rvKXJV1w2lKMCD2eHTEE/0vwhkVU797xE4LJhptaAzDPn/R90bcBt4AYPZ6j5qUUufELjcJ7cbARckdQvmecMDa2isulHAdpqt21BlnfzvfR1l0Dc4BqUoEZagVW/eO6igrzyvgHfLAw+QXxXy1HaE4P3iXynVXdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpQ1GaYx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756867550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L1JxLnfXA8pw9Zd+H/FkimGg1gqWzledc3w8tzJI70c=;
	b=jpQ1GaYxmPRbh6S0qUT1tBzWSlbsFOEfS1HZ88oJsKGubXnDze33KHNV4lqSOHebuNKBxU
	HOTpvfABMXDaAa+BxW689qj3WVom5NUFEeke+FYyY7z6eyBz14Awb7dtEvVt/z/5urSpMw
	AmwjDtfDpaXNF45gZ03akgvCNnjMuf8=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: edumazet@google.com,
	kuniyu@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	kernelxing@tencent.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net] inet: Avoid established lookup missing active sk
Date: Wed,  3 Sep 2025 10:44:06 +0800
Message-Id: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Since the lookup of sk in ehash is lockless, when one CPU is performing a
lookup while another CPU is executing delete and insert operations
(deleting reqsk and inserting sk), the lookup CPU may miss either of
them, if sk cannot be found, an RST may be sent.

The call trace map is drawn as follows:
   CPU 0                           CPU 1
   -----                           -----
                                spin_lock()
                                sk_nulls_del_node_init_rcu(osk)
__inet_lookup_established()
                                __sk_nulls_add_node_rcu(sk, list)
                                spin_unlock()

We can try using spin_lock()/spin_unlock() to wait for ehash updates
(ensuring all deletions and insertions are completed) after a failed
lookup in ehash, then lookup sk again after the update. Since the sk
expected to be found is unlikely to encounter the aforementioned scenario
multiple times consecutively, we only need one update.

Similarly, an issue occurs in tw hashdance. Try adjusting the order in
which it operates on ehash: remove sk first, then add tw. If sk is missed
during lookup, it will likewise wait for the update to find tw, without
worrying about the skc_refcnt issue that would arise if tw were found
first.

Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/inet_hashtables.c    | 12 ++++++++++++
 net/ipv4/inet_timewait_sock.c |  9 ++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..4eb3a55b855b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -505,6 +505,7 @@ struct sock *__inet_lookup_established(const struct net *net,
 	unsigned int hash = inet_ehashfn(net, daddr, hnum, saddr, sport);
 	unsigned int slot = hash & hashinfo->ehash_mask;
 	struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	bool try_lock = true;
 
 begin:
 	sk_nulls_for_each_rcu(sk, node, &head->chain) {
@@ -528,6 +529,17 @@ struct sock *__inet_lookup_established(const struct net *net,
 	 */
 	if (get_nulls_value(node) != slot)
 		goto begin;
+
+	if (try_lock) {
+		spinlock_t *lock = inet_ehash_lockp(hashinfo, hash);
+
+		try_lock = false;
+		spin_lock(lock);
+		/* Ensure ehash ops under spinlock complete. */
+		spin_unlock(lock);
+		goto begin;
+	}
+
 out:
 	sk = NULL;
 found:
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 875ff923a8ed..a91e02e19c53 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -139,14 +139,10 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 
 	spin_lock(lock);
 
-	/* Step 2: Hash TW into tcp ehash chain */
-	inet_twsk_add_node_rcu(tw, &ehead->chain);
-
-	/* Step 3: Remove SK from hash chain */
+	/* Step 2: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 
-
 	/* Ensure above writes are committed into memory before updating the
 	 * refcount.
 	 * Provides ordering vs later refcount_inc().
@@ -161,6 +157,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 
+	/* Step 3: Hash TW into tcp ehash chain */
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
+
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
-- 
2.25.1


