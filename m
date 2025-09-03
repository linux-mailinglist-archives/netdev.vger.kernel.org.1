Return-Path: <netdev+bounces-219702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F558B42AEB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CD03A7EBA
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BF3054FC;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx343K4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B172EC08F;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931402; cv=none; b=rQoZ3CQk2jzGqoqUTcF1th/HhAdMWdfljhb3x5+GZ1J4wmnYeZ1L2NepKiBfz1tG6NEVwaqFQ5/z/wwF2MbRgoKYKm0SspA6yVEMOLsNF5vzAlilvYP4vVRzjlRlXH0o56brNoZRbBSaJH5YNkf2YWbdo4bkIwrwQqsfDqSnRMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931402; c=relaxed/simple;
	bh=v1cbHQxcy7PcQtN+MlzfT/FgZAArkPDZMsELc/94JQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ew5e8zAL0BwmWzl2oAVF8kZpPCCeNtLS4UApyyIiwAP/WgTetlFpq4oaTstui5SvP9DSBq5CDVGlSEKnt0UU0jha1R0UhH4Uq7HXKWXhxMNvfQ4EUmjY2d33h7ZBUkHeQI8WL/R0n3HsVdgjJSDEcIo5gpjMBgJRuQTRW6Ej2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx343K4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DD4BC4CEF8;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931402;
	bh=v1cbHQxcy7PcQtN+MlzfT/FgZAArkPDZMsELc/94JQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tx343K4qZunpKhZpOfZ1rUJj2zl07M6ABuyHMrnlfmdkXFKkljLgGYIZ9dI3s6l56
	 rUaW2QJsBsTGS2cpAdK3GkB6HC9ficH2eJtXril5gQsX6puXV0MmVcADR/lMuwW8rd
	 itGlEMbrsYL7xzbT5LJjkZ1F039RROKQZmMZWhrCuid01jgs1IqMXIFpFaMJETsXet
	 C7yo212t7iTtU/LOerKANx/3xgGiWK4y8TgeEsHYVVzw0Fln2zggrW0gAANf+Y6cHC
	 exNws0BXkD5QEGWqemT8jH9/fwbijPpNLRIa+qx85lGNiCFraEbWSvCTaf7q6YK5bW
	 eTxBS3SeA6o6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC73CA1014;
	Wed,  3 Sep 2025 20:30:01 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Wed, 03 Sep 2025 21:29:49 +0100
Subject: [PATCH net-next v4 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys without
 RCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com>
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
In-Reply-To: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756931399; l=4415;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=65z7fQlb2eYUj9y2aIvG1Kqpl8vByndV104GRQRJLno=;
 b=xVlsgOWWeR5SMP9vXoOnB3O9FFp5x8MoOm8lMzw7lvzn4mVHpxevILcJcIO9RhlEFS9I7jwcCrMv
 mRmAFT9LCIgp8JxkXkzr8E01CTFdxiykfWuDYCRO0l+aUO4L+IK2
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
 include/net/tcp_ao.h     |  1 -
 net/ipv4/tcp.c           | 17 +++--------------
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      |  4 ++--
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 5 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index df655ce6987d..1e9e27d6e06b 100644
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
index da8bfa4d2fb8..98ed25cf76ce 100644
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
 EXPORT_SYMBOL_GPL(tcp_md5_destruct_sock);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bbb8d5f0eae7..31302be78bc4 100644
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
index 17176a5d8638..2a0602035729 100644
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
index d1c9e4088646..7c2ae07d8d5d 100644
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



