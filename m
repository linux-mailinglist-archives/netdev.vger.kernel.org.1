Return-Path: <netdev+bounces-221027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A94B49E97
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29CB1BC50F2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44718221557;
	Tue,  9 Sep 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfmnoVih"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF019DF5F;
	Tue,  9 Sep 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380737; cv=none; b=BdXMSLin5zHdrcuQFntrn0ogFQNy1JeZkrtRRwu9XT8pBanbmZQvkjHD1gThY8VX+DAq/0t8TkPb2KBTvNsbzw/uHAs1AO5axfHGFOsRHA99FJlihJ8HoFST3oYj73Zd/4QkuUqARnXJPQFvJMz5rRhFvYNzWlyPApcha5ivcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380737; c=relaxed/simple;
	bh=lrJT0WQwb5rZ4L0/yfRIZIXYxwSWYPQSz/wVjJA/umE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XL2f/Fd4up7q0NyBW4w1MdvPwZlf4ggCcvcZAJb624/QSq5vuSw7vwpiqd0v4Xp7WJ2q8cvcdPUWQ0Kv3Sm/apL8T8KwhOuFE785OlgYjucoR1dmz9Z2otKT0Z/x8QXuf3BggFLurKC3W9WE6Y4a7cIN5k7JKy7nHTU2wGk4aEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfmnoVih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A088AC4CEF9;
	Tue,  9 Sep 2025 01:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757380736;
	bh=lrJT0WQwb5rZ4L0/yfRIZIXYxwSWYPQSz/wVjJA/umE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QfmnoVihql2cf5MsUCFuxiUrVzNk4FjpehgsswjMlH3T5sjxDONvFqwYxEqx43teV
	 vmRNzuCAql1qJAi1PmPxRk7BfNdPDeyA3pHDQwZ5N4/31OZykfnMwV3PAXRM42UeyI
	 Yh3IkFfdDfRSUeBMBUIY10HnvND/MVLXDHC6XzACiMFWahVGu0Yvcb53ZnRyN5If67
	 jdXSXflIPpOOhJ57X+LN/GtU1hPwbUTTfGMLxP+XUYckQTbILA9ySKRRgdUz0JMTyS
	 M38zN+8hJttD0glSHH/7c7/2CAf8xJL+h2y9Emx12OdwDMG7hSweDl2ZduB7mvpOaA
	 E9BnAQYA/DtPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B2CAC583;
	Tue,  9 Sep 2025 01:18:56 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 09 Sep 2025 02:18:51 +0100
Subject: [PATCH net-next v5 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys without
 RCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-tcp-ao-md5-rst-finwait2-v5-2-9ffaaaf8b236@arista.com>
References: <20250909-b4-tcp-ao-md5-rst-finwait2-v5-0-9ffaaaf8b236@arista.com>
In-Reply-To: <20250909-b4-tcp-ao-md5-rst-finwait2-v5-0-9ffaaaf8b236@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757380735; l=4800;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=XgkPVwjsxx1mk+Yn117uIJ7i5LCgV/j0VbKH5f9yGYU=;
 b=n/bhKXOj5YPO3hAVX6ifCmjzTw12Zy3KosxZAKz6MUZJhQVPT/pQ8Tz/d4+/c5tg/LW2sQNaG
 Wv3iOEEsdVnCNtYsYsZ5MEDo3Esx1Nt9HBow86DLuAZzKRmm6u7bYQa
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

From: Dmitry Safonov <dima@arista.com>

Now that the destruction of info/keys is delayed until the socket
destructor, it's safe to use kfree() without an RCU callback.
The socket is in TCP_CLOSE state either because it never left it,
or it's already closed and the refcounter is zero. In any way,
no one can discover it anymore, it's safe to release memory
straight away.

Similar thing was possible for twsk already.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h     |  1 -
 net/ipv4/tcp.c           | 17 +++--------------
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      |  4 ++--
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 5 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index df655ce6987d3730fea7a6ef0db09c2e27b34f21..1e9e27d6e06ba1be185910d7618ef6453e72ba38 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -130,7 +130,6 @@ struct tcp_ao_info {
 	u32			snd_sne;
 	u32			rcv_sne;
 	refcount_t		refcnt;		/* Protects twsk destruction */
-	struct rcu_head		rcu;
 };
 
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index adf5e1e8ffef69391318f2af0b3ea221eaa4afab..77eb10273fa824403464a0fd2036abc1a703acb9 100644
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
-		rcu_assign_pointer(tp->md5sig_info, NULL);
-		call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
+		kfree(rcu_replace_pointer(tp->md5sig_info, NULL, 1));
+		static_branch_slow_dec_deferred(&tcp_md5_needed);
+		tcp_md5_release_sigpool();
 	}
 }
 EXPORT_IPV6_MOD_GPL(tcp_md5_destruct_sock);
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
index 17176a5d8638d5850898000db41bb123eff86857..2a06020357297a9c0b2dbd79900be8911a52a17e 100644
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



