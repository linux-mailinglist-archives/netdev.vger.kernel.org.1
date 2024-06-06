Return-Path: <netdev+bounces-101479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE18FF09F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BAFB2B6AE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5F196431;
	Thu,  6 Jun 2024 15:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04C160883
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687090; cv=none; b=pePbrUp07Z4WJoqE4Jf1ross3GtliX9Q6pl2J+0rJcMnoFlSMGLvBwSmxbCBO4/mMb44Y9csnDkz1q32tHaUl2WkmHeNBgIebiAlYk6ckECZ1yRSXwj1qfk4jYDG2zXHRWVEnA+nMsqkvXmPC7jDtG10NqzvbXmvZq62TbQNLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687090; c=relaxed/simple;
	bh=PAKbmb9i+DgfWUrhymb0pQQ+aczmjaNQ8QJkIoESKFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwDaQeZyOvEI2rSMYEUay75ay359oECd8c9LRfdLFNJnKPNPvxbZ5v3M/61K+XoCg1Xpmno4yFvg/1nadFWNIW8OswOu752DEtbkE6WrZ40GKY9hXDaQYme00v7bb5O6regN8npRxAfPQuZVh/gMnU6kAdX4SiVBVsyczVXY7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sFEsQ-0004CH-Dc; Thu, 06 Jun 2024 17:18:06 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bigeasy@linutronix.de,
	vschneid@redhat.com
Subject: [PATCH net-next v8 2/3] net: tcp: un-pin the tw_timer
Date: Thu,  6 Jun 2024 17:11:38 +0200
Message-ID: <20240606151332.21384-3-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240606151332.21384-1-fw@strlen.de>
References: <20240606151332.21384-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous patch, even if timer fires immediately on another CPU,
context that schedules the timer now holds the ehash spinlock, so timer
cannot reap tw socket until ehash lock is released.

BH disable is moved into hashdance_schedule.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Changes since last version:
 Move local_bh_enable/disable into inet_twsk_hashdance_schedule
 and remove the comments mentioning timer_pinned in the two callers.

 net/dccp/minisocks.c          | 6 ------
 net/ipv4/inet_timewait_sock.c | 6 ++++--
 net/ipv4/tcp_minisocks.c      | 6 ------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index deb52d7d31b4..fecc8190064f 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -54,16 +54,10 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
 		if (state == DCCP_TIME_WAIT)
 			timeo = DCCP_TIMEWAIT_LEN;
 
-		/* tw_timer is pinned, so we need to make sure BH are disabled
-		 * in following section, otherwise timer handler could run before
-		 * we complete the initialization.
-		 */
-		local_bh_disable();
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
 		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
-		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
 		 * socket up.  We've got bigger problems than
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 628d33a41ce5..b2d97c816c99 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -93,7 +93,7 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 }
 
 /*
- * Enter the time wait state. This is called with locally disabled BH.
+ * Enter the time wait state.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
  * from the SK, and mess with hash chains and list linkage.
  *
@@ -118,6 +118,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 			hashinfo->bhash_size)];
 	bhead2 = inet_bhashfn_portaddr(hashinfo, sk, twsk_net(tw), inet->inet_num);
 
+	local_bh_disable();
 	spin_lock(&bhead->lock);
 	spin_lock(&bhead2->lock);
 
@@ -158,6 +159,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
 
@@ -203,7 +205,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index fc9a850ed9bd..bc67f6b9efae 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -345,16 +345,10 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		if (state == TCP_TIME_WAIT)
 			timeo = TCP_TIMEWAIT_LEN;
 
-		/* tw_timer is pinned, so we need to make sure BH are disabled
-		 * in following section, otherwise timer handler could run before
-		 * we complete the initialization.
-		 */
-		local_bh_disable();
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
 		inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_row.hashinfo, timeo);
-		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
 		 * socket up.  We've got bigger problems than
-- 
2.44.2


