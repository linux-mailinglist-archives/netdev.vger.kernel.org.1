Return-Path: <netdev+bounces-41310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F727CA8B8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2577281616
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844232770D;
	Mon, 16 Oct 2023 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmWKo7Is"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3732770A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:00:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2338F3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697461201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9sDjD0PnFUNgV0X5f9SsRv9HtvY4pPJgeF96t1o0gDk=;
	b=bmWKo7Ise4DztepQCpPNXRK8dl404TeAQy0KKceeki5R0RjcH/aPEG7pQ/4/5I7p70LGl9
	KG2xvKhiviqzNikgqSm5n51sS942TNWvfO239uk5taDZ/qr3VRdC3tK8X984s8uxmjsyQc
	G+JFui3+TVJiVr/M/Jzl9pFiaItEg/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-c3kl-JliNt2P5acWWO9h5g-1; Mon, 16 Oct 2023 08:59:48 -0400
X-MC-Unique: c3kl-JliNt2P5acWWO9h5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA9083C1CC26;
	Mon, 16 Oct 2023 12:59:47 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.194.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 89E191102E14;
	Mon, 16 Oct 2023 12:59:45 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: dccp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
Date: Mon, 16 Oct 2023 14:59:34 +0200
Message-Id: <20231016125934.1970789-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The TCP timewait timer is proving to be problematic for setups where scheduler
CPU isolation is achieved at runtime via cpusets (as opposed to statically via
isolcpus=domains).

What happens there is a CPU goes through tcp_time_wait(), arming the time_wait
timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causing
interference for the now-isolated CPU. This is conceptually similar to the issue
described in
  e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()")

Making the timer un-pinned would resolve this, as it would be queued onto
HK_FLAG_TIMER CPUs. It would Unfortunately go against
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
as we'd need to arm the timer after the *hashdance() to not have it fire before
we've finished setting up the timewait_socket.

However, looking into this, I cannot grok what race is fixed by having the timer
*armed* before the hashdance.

[this next segment is brought to you by Cunningham's Law]

Using [1] as an example, inet_twsk_schedule() only arms the timer and increments
the deathrow refcount, which by itself does not affect
__inet_lookup_established(). AFAICT it only comes in handy if:
1) A CPU ends up livelocking in __inet_lookup_established() (cf. [1], though per
   inet_twsk_alloc() I don't see how a timewait socket can hit the
   forever-looping conditions with how the sk_hash and addr/port pairs are copied)
2) the initialization context can be interrupted by NET_RX (it can, cf.
   cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer"))

In this scenario, we need the timer to fire to go through
  inet_twsk_kill()
    sk_nulls_del_node_init_rcu()
and break out of the loop.

Keep softirqs disabled, but make the timer un-pinned and arm it after the
hashdance. Remote CPUs may start using the timewait socket before the timer is
armed, but their execution of __inet_lookup_established() won't prevent the
arming of the timer.

This partially reverts
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
and
  ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")

Link: [1] https://lore.kernel.org/lkml/56941035.9040000@fastly.com/
Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 net/dccp/minisocks.c          | 18 ++++++++++--------
 net/ipv4/inet_timewait_sock.c |  9 ++++-----
 net/ipv4/tcp_minisocks.c      | 18 ++++++++++--------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27adde..188a29a1aef49 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -53,16 +53,18 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
 		if (state == DCCP_TIME_WAIT)
 			timeo = DCCP_TIMEWAIT_LEN;
 
-		/* tw_timer is pinned, so we need to make sure BH are disabled
-		 * in following section, otherwise timer handler could run before
-		 * we complete the initialization.
-		 */
-		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
-		/* Linkage updates.
-		 * Note that access to tw after this point is illegal.
+		/* tw_timer is armed after the hashdance and recount update, so
+		 * we need to make sure BH are disabled in following section to
+		 * ensure the timer is armed before we handle any further skb's.
 		 */
+	       local_bh_disable();
+
+		// Linkage updates
 		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
+		inet_twsk_schedule(tw, timeo);
+		// Access to tw after this point is illegal.
+		inet_twsk_put(tw);
+
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index dd37a5bf68811..ba59c2c6ef4a2 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -152,16 +152,15 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_unlock(lock);
 
-	/* tw_refcnt is set to 3 because we have :
+	/* tw_refcnt is set to 4 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
 	 * - one reference for timer.
+	 * - One reference for ourself (our caller will release it).
 	 * We can use atomic_set() because prior spin_lock()/spin_unlock()
 	 * committed into memory all tw fields.
-	 * Also note that after this point, we lost our implicit reference
-	 * so we are not allowed to use tw anymore.
 	 */
-	refcount_set(&tw->tw_refcnt, 3);
+	refcount_set(&tw->tw_refcnt, 4);
 }
 EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
 
@@ -207,7 +206,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b98d476f1594b..269d4aa14a49e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -324,16 +324,18 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		if (state == TCP_TIME_WAIT)
 			timeo = TCP_TIMEWAIT_LEN;
 
-		/* tw_timer is pinned, so we need to make sure BH are disabled
-		 * in following section, otherwise timer handler could run before
-		 * we complete the initialization.
-		 */
-		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
-		/* Linkage updates.
-		 * Note that access to tw after this point is illegal.
+		/* tw_timer is armed after the hashdance and recount update, so
+		 * we need to make sure BH are disabled in following section to
+		 * ensure the timer is armed before we handle any further skb's.
 		 */
+	       local_bh_disable();
+
+		// Linkage updates.
 		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		inet_twsk_schedule(tw, timeo);
+		// Access to tw after this point is illegal.
+		inet_twsk_put(tw);
+
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
-- 
2.39.3


