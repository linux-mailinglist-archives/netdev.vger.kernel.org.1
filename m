Return-Path: <netdev+bounces-100605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8D8FB4DB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FDA282537
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114418028;
	Tue,  4 Jun 2024 14:11:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405312B143
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510295; cv=none; b=ZQh3YaKr1rc9RfF8025p/d5PEwJZuVxJH0+Mfp3I5dIRUceq+b+/8w1sP53lkhfvLllypUwX8uNhNK+tgJhgvb0yGZWWRgZj3axMONcgHkN53w+FyuV2LMoWFgnQLTgwjKoK917rKtW111efqHVL5lxOwFB2TK0z7VsrcDSzksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510295; c=relaxed/simple;
	bh=CNPac14nS/GkkQ2lFsXwh8XVM7shMfxlq/OnNIaLvhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3FOzY2eh8cGYr/euMr/fmf90pY46SnGYV3DbX9DroBfiLF9pewzX4tbDwnpXbKxw4biKPkFahEgpXQ284OnMW8nkhLWCVC0s8VXPTsY3YOCrtcGFiINn1Y46UuYidqI7Bw2PdIt1wyKhUQCjpTSIMn5hJphsyFeb1ACaxw8eiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sEUst-0002HY-QZ; Tue, 04 Jun 2024 16:11:31 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	vschneid@redhat.com,
	tglozar@redhat.com,
	bigeasy@linutronix.de,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v7 1/3] net: tcp/dccp: prepare for tw_timer un-pinning
Date: Tue,  4 Jun 2024 16:08:47 +0200
Message-ID: <20240604140903.31939-2-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240604140903.31939-1-fw@strlen.de>
References: <20240604140903.31939-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The TCP timewait timer is proving to be problematic for setups where
scheduler CPU isolation is achieved at runtime via cpusets (as opposed to
statically via isolcpus=domains).

What happens there is a CPU goes through tcp_time_wait(), arming the
time_wait timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer
fires, causing interference for the now-isolated CPU. This is conceptually
similar to the issue described in commit e02b93124855 ("workqueue: Unbind
kworkers before sending them to exit()")

Move inet_twsk_schedule() to within inet_twsk_hashdance(), with the ehash
lock held. Expand the lock's critical section from inet_twsk_kill() to
inet_twsk_deschedule_put(), serializing the scheduling vs descheduling of
the timer. IOW, this prevents the following race:

			     tcp_time_wait()
			       inet_twsk_hashdance()
  inet_twsk_deschedule_put()
    del_timer_sync()
			       inet_twsk_schedule()

Thanks to Paolo Abeni for suggesting to leverage the ehash lock.

This also restores a comment from commit ec94c2696f0b ("tcp/dccp: avoid
one atomic operation for timewait hashdance") as inet_twsk_hashdance() had
a "Step 1" and "Step 3" comment, but the "Step 2" had gone missing.

inet_twsk_deschedule_put() now acquires the ehash spinlock to synchronize
with inet_twsk_hashdance_schedule().

To ease possible regression search, actual un-pin is done in next patch.

Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 changes:
 - use timer_shutdown_sync, ehash lock can be released
   beforehand
 - fix 'ddcp' typo in patch subject

 include/net/inet_timewait_sock.h |  6 ++--
 net/dccp/minisocks.c             |  3 +-
 net/ipv4/inet_timewait_sock.c    | 52 +++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c         |  3 +-
 4 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 2a536eea9424..5b43d220243d 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 					   struct inet_timewait_death_row *dr,
 					   const int state);
 
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			 struct inet_hashinfo *hashinfo);
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo);
 
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 251a57cf5822..deb52d7d31b4 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -59,11 +59,10 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e28075f0006e..628d33a41ce5 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -96,9 +96,13 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
  * Enter the time wait state. This is called with locally disabled BH.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
  * from the SK, and mess with hash chains and list linkage.
+ *
+ * The caller must not access @tw anymore after this function returns.
  */
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			   struct inet_hashinfo *hashinfo)
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
@@ -129,26 +133,33 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
+	/* Step 2: Hash TW into tcp ehash chain */
 	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 
-	spin_unlock(lock);
 
+	/* Ensure above writes are committed into memory before updating the
+	 * refcount.
+	 * Provides ordering vs later refcount_inc().
+	 */
+	smp_wmb();
 	/* tw_refcnt is set to 3 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
 	 * - one reference for timer.
-	 * We can use atomic_set() because prior spin_lock()/spin_unlock()
-	 * committed into memory all tw fields.
 	 * Also note that after this point, we lost our implicit reference
 	 * so we are not allowed to use tw anymore.
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
+
+	inet_twsk_schedule(tw, timeo);
+
+	spin_unlock(lock);
 }
-EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
+EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
 
 static void tw_timer_handler(struct timer_list *t)
 {
@@ -217,7 +228,34 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (del_timer_sync(&tw->tw_timer))
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	/* inet_twsk_purge() walks over all sockets, including tw ones,
+	 * and removes them via inet_twsk_deschedule_put() after a
+	 * refcount_inc_not_zero().
+	 *
+	 * inet_twsk_hashdance_schedule() must (re)init the refcount before
+	 * arming the timer, i.e. inet_twsk_purge can obtain a reference to
+	 * a twsk that did not yet schedule the timer.
+	 *
+	 * The ehash lock synchronizes these two:
+	 * After acquiring the lock, the timer is always scheduled (else
+	 * timer_shutdown returns false), because hashdance_schedule releases
+	 * the ehash lock only after completing the timer initialization.
+	 *
+	 * Without grabbing the ehash lock, we get:
+	 * 1) cpu x sets twsk refcount to 3
+	 * 2) cpu y bumps refcount to 4
+	 * 3) cpu y calls inet_twsk_deschedule_put() and shuts timer down
+	 * 4) cpu x tries to start timer, but mod_timer is a noop post-shutdown
+	 * -> timer refcount is never decremented.
+	 */
+	spin_lock(lock);
+	/*  Makes sure hashdance_schedule() has completed */
+	spin_unlock(lock);
+
+	if (timer_shutdown_sync(&tw->tw_timer))
 		inet_twsk_kill(tw);
 	inet_twsk_put(tw);
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 538c06f95918..47de6f3efc85 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -344,11 +344,10 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_row.hashinfo, timeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
-- 
2.44.2


