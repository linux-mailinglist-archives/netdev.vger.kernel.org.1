Return-Path: <netdev+bounces-100134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4088D7F13
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AC1B21643
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FC84D02;
	Mon,  3 Jun 2024 09:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8B84D07
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407448; cv=none; b=MMEyjL5AColvI54dCFJw7otSGQsyiEBc0BBHMFe9N9gPdbVF672/zoVrwwyAv/H+0myRqIKC27CZ0yFm+ccXjiXLPG1j0gzJpuLu+SFB5+NHPJXVg7iQbd5q+1ZdBIklI2rGaPib3ZZGNNm4x/ruNgHKXAwtmvY2NqLQEBecb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407448; c=relaxed/simple;
	bh=6GcccNigZzjdLCCGiMHbJKP948UMmztVlyE237IRoCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5CLiGKj7qiVDrdjS8euuprNnFJvnN9QF6PeW4C0fYNPGQ9OU8+pKHJwpWDks/ZmezZ9WnDSNrXbKg9tX5vdcEVp1gmnfI62W+ZuOAcLR8UsyATUCBWdi6pzo73IixlIFZgwiF3uNhrbJo+EgeEKuD1hOBA3VirPSbyzEosXKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sE484-00012l-8w; Mon, 03 Jun 2024 11:37:24 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mleitner@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	tglozar@redhat.com,
	dsahern@kernel.org,
	bigeasy@linutronix.de,
	tglx@linutronix.de
Subject: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer un-pinning
Date: Mon,  3 Jun 2024 11:36:10 +0200
Message-ID: <20240603093625.4055-2-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240603093625.4055-1-fw@strlen.de>
References: <20240603093625.4055-1-fw@strlen.de>
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
vs. reschedule and timer firing: timer_del_sync() is replaced with
timer_shutdown().

This means that tw_timer may still be running on another CPU.  However, as
the timer owns a reference on tw sk that is only put at the end this
should be fine.

To ease possible regression search, actual un-pin is done in next patch.

Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/inet_timewait_sock.h |  6 ++-
 net/dccp/minisocks.c             |  3 +-
 net/ipv4/inet_timewait_sock.c    | 74 ++++++++++++++++++++++++++------
 net/ipv4/tcp_minisocks.c         |  3 +-
 4 files changed, 68 insertions(+), 18 deletions(-)

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
index e28075f0006e..2b1d836df64e 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -44,14 +44,14 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	__sock_put((struct sock *)tw);
 }
 
-/* Must be called with locally disabled BHs. */
-static void inet_twsk_kill(struct inet_timewait_sock *tw)
+static void __inet_twsk_kill(struct inet_timewait_sock *tw, spinlock_t *lock)
+__releases(lock)
 {
 	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
-	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
-	spin_lock(lock);
+	lockdep_assert_held(lock);
+
 	sk_nulls_del_node_init_rcu((struct sock *)tw);
 	spin_unlock(lock);
 
@@ -71,6 +71,16 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 	inet_twsk_put(tw);
 }
 
+/* Must be called with locally disabled BHs. */
+static void inet_twsk_kill(struct inet_timewait_sock *tw)
+{
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	spin_lock(lock);
+	__inet_twsk_kill(tw, lock);
+}
+
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
 	struct module *owner = tw->tw_prot->owner;
@@ -96,9 +106,13 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
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
@@ -129,26 +143,33 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
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
@@ -217,8 +238,37 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (del_timer_sync(&tw->tw_timer))
-		inet_twsk_kill(tw);
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
+	 * timer_shutdown returns false).
+	 *
+	 * With plain timer_shutdown_sync() and without grabbing the ehash
+	 * lock, we can get:
+	 * 1) cpu x sets twsk refcount to 3
+	 * 2) cpu y bumps refcount to 4
+	 * 3) cpu y calls inet_twsk_deschedule_put() and shuts timer down
+	 * 4) cpu x tries to start timer, but mod_timer is a noop post-shutdown
+	 * -> timer refcount is never decremented.
+	 */
+	spin_lock(lock);
+	if (timer_shutdown(&tw->tw_timer)) {
+		/* releases @lock */
+		__inet_twsk_kill(tw, lock);
+	} else {
+		spin_unlock(lock);
+	}
+
 	inet_twsk_put(tw);
 }
 EXPORT_SYMBOL(inet_twsk_deschedule_put);
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


