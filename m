Return-Path: <netdev+bounces-217646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32CB39699
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731A13A42C4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27E2D97A6;
	Thu, 28 Aug 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb/ioFAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314F200C2;
	Thu, 28 Aug 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368919; cv=none; b=n2rAC15Uf3c6xX0/iOXbsmPob6TV18uV5a4MPbwOQkBA2fo7uFfbWSZdl7ESu1XlRt6zgXAoP++wKsa96VYaCcUcunEbgCdv6pfvkUV1BS0wEjBmFl5H3FeMsro0+0L0xv31miTqAQEw23Fz+4FqLizqAVVCFGoeBKh80hoQ8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368919; c=relaxed/simple;
	bh=DyguhpqTEoNfELL8h7heq4xt+2JqWBMyIHL/jBZmP+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+JkJPUIuOQ9SNdmUb6ulYzzABSu4/dCJGbgtqerlP4pJqFojuOw0fSXlQnpNF1Uus4eZxdhXVzamxFzGfCWKNferI88aYC73Vb502kqlJ5v+wgeCTBugXJhMJOZDB8AbKhp4PEQUghP7ZG6PqUM9xD3UntZM380kAcZMVDeLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb/ioFAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0743EC4CEF6;
	Thu, 28 Aug 2025 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756368919;
	bh=DyguhpqTEoNfELL8h7heq4xt+2JqWBMyIHL/jBZmP+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Eb/ioFAt+8mELco+M9+DMqlCgzJQZpQMkbNWd+8BDGOmIpqHVLKA6QR93HJ+GkqIO
	 Y772OWJHlNXdDSI6Jt5E048IIb935xfCKVG+bMMaf6TBHNXIELAQ/SxYf7SYf7YkE1
	 T01dWm46Z/7aOep7UCuHrlQQjORFee0LqdrOY19UiadYn70+9upabZ67k2YRIWp/dx
	 tVto7JNhxEuf4Ik2/9PcUJXJZlNhY/3qa+9BnGNMPGim5KD/u0Xo42Jm8cEefn4WRt
	 pCZ2NbyD2a8n4jKJ/N9nBG7Qy+//l43O0jcuO5vKHuqOuLqajLWdsJST3+CaDuv21d
	 7D/FSinWp8xlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C3CA0EED;
	Thu, 28 Aug 2025 08:15:18 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Thu, 28 Aug 2025 09:14:56 +0100
Subject: [PATCH net-next v2 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys without
 RCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-2-653099bea5c1@arista.com>
References: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com>
In-Reply-To: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756368907; l=4256;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=CzsGKUUYtvozrW4B83Kh8LAgvpUKqIeMhEr8KygJN4g=;
 b=231pajobheLxkJ66pa29ldYL5cL7sTYWrLim+4TCrl856XgUbJkyFIPPrwQBT7YNdt2o1mE9o
 S9fiVlYeRzvBHstEtqF6RapAPFfBs1/tt0lQOZLZOxRU+tt9UUtHl0H
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

From: Dmitry Safonov <dima@arista.com>

Now that the destruction of info/keys is delayed until the socket
destructor, it's safe to use kfree() without an RCU callback.
As either socket was yet in TCP_CLOSE state or the socket refcounter is
zero and no one can discover it anymore, it's safe to release memory
straight away.
Similar thing was possible for twsk already.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp.c           | 17 +++--------------
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      |  4 ++--
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 4 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 927233ee7500e0568782ae4a3860af56d1476acd..254ca95d0c3c5c44029be0e84120c5e9fb9d4514 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -413,27 +413,16 @@ static u64 tcp_compute_delivery_rate(const struct tcp_sock *tp)
 }
 
 #ifdef CONFIG_TCP_MD5SIG
-static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
-{
-	struct tcp_md5sig_info *md5sig;
-
-	md5sig = container_of(head, struct tcp_md5sig_info, rcu);
-	kfree(md5sig);
-	static_branch_slow_dec_deferred(&tcp_md5_needed);
-	tcp_md5_release_sigpool();
-}
-
 void tcp_md5_destruct_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (tp->md5sig_info) {
-		struct tcp_md5sig_info *md5sig;
 
-		md5sig = rcu_dereference_protected(tp->md5sig_info, 1);
 		tcp_clear_md5_list(sk);
-		call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
-		rcu_assign_pointer(tp->md5sig_info, NULL);
+		kfree(rcu_replace_pointer(tp->md5sig_info, NULL, 1));
+		static_branch_slow_dec_deferred(&tcp_md5_needed);
+		tcp_md5_release_sigpool();
 	}
 }
 EXPORT_SYMBOL_GPL(tcp_md5_destruct_sock);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bbb8d5f0eae7d3d8887da3fa4d68e248af9060ad..31302be78bc4450b56fa23a390b6d03b2262741d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -268,9 +268,8 @@ static void tcp_ao_key_free_rcu(struct rcu_head *head)
 	kfree_sensitive(key);
 }
 
-static void tcp_ao_info_free_rcu(struct rcu_head *head)
+static void tcp_ao_info_free(struct tcp_ao_info *ao)
 {
-	struct tcp_ao_info *ao = container_of(head, struct tcp_ao_info, rcu);
 	struct tcp_ao_key *key;
 	struct hlist_node *n;
 
@@ -310,7 +309,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 
 	if (!twsk)
 		tcp_ao_sk_omem_free(sk, ao);
-	call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
+	tcp_ao_info_free(ao);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 158b366a55bfd198ffeba13a426d993c3b02528e..ba8b6090df2a1f5c415faa37941292d76346f9b8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1503,9 +1503,9 @@ void tcp_clear_md5_list(struct sock *sk)
 	md5sig = rcu_dereference_protected(tp->md5sig_info, 1);
 
 	hlist_for_each_entry_safe(key, n, &md5sig->head, node) {
-		hlist_del_rcu(&key->node);
+		hlist_del(&key->node);
 		atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
-		kfree_rcu(key, rcu);
+		kfree(key);
 	}
 }
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d1c9e40886463ca308f9f3682c4039f491e7555f..7c2ae07d8d5d2a18d6ce3210cc09ee5d9850ea29 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -377,26 +377,17 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 }
 EXPORT_SYMBOL(tcp_time_wait);
 
-#ifdef CONFIG_TCP_MD5SIG
-static void tcp_md5_twsk_free_rcu(struct rcu_head *head)
-{
-	struct tcp_md5sig_key *key;
-
-	key = container_of(head, struct tcp_md5sig_key, rcu);
-	kfree(key);
-	static_branch_slow_dec_deferred(&tcp_md5_needed);
-	tcp_md5_release_sigpool();
-}
-#endif
-
 void tcp_twsk_destructor(struct sock *sk)
 {
 #ifdef CONFIG_TCP_MD5SIG
 	if (static_branch_unlikely(&tcp_md5_needed.key)) {
 		struct tcp_timewait_sock *twsk = tcp_twsk(sk);
 
-		if (twsk->tw_md5_key)
-			call_rcu(&twsk->tw_md5_key->rcu, tcp_md5_twsk_free_rcu);
+		if (twsk->tw_md5_key) {
+			kfree(twsk->tw_md5_key);
+			static_branch_slow_dec_deferred(&tcp_md5_needed);
+			tcp_md5_release_sigpool();
+		}
 	}
 #endif
 	tcp_ao_destroy_sock(sk, true);

-- 
2.42.2



