Return-Path: <netdev+bounces-218456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA412B3C7E7
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 06:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE4F7B257F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58142275B12;
	Sat, 30 Aug 2025 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYXdSlZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9442049;
	Sat, 30 Aug 2025 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528325; cv=none; b=pT1hkEJEcfyTQHJjxzRiLfJCjuzgEMMdbb1nvgLwvs37RcBJAsAkNYExCkMtsX3w59fhhEN1MSfT0W+bWzuzNP3eYIhv1iTUiU2g31MiPdLFjisCeI7RBK3f+DiZPde9omGDAzdO0hCvfKeWi8uPxytZOZK8s+8kYTr8EFdSZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528325; c=relaxed/simple;
	bh=/m9qjhVFmxWX9LFYgkaUXe4e3QlluqJzCAUEzdyXVz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKzTRWkjgI0ckTj5kREoWfuDag8QuAUhrvcwdIjWo7dlwj5lXocSkqBVZyV2PxOUgloNjf7X7TzzzI0+7x6JmfhveKCqZefl6y96HmKPklQPL4SNMHNODUaKWF6ANKBvbywTGbDf1uxAUihXxyKzb8k5DDP81rHtge/hcF2XoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYXdSlZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6699C4CEF7;
	Sat, 30 Aug 2025 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756528324;
	bh=/m9qjhVFmxWX9LFYgkaUXe4e3QlluqJzCAUEzdyXVz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OYXdSlZroLp95bzTnwT86vTPF3uubCV96eoWrKpzoPF2o396w4vDrg5FQ8xejtbmx
	 5UywhcZvx7nGZHxU8Q0xZGR4CrV7Mc0yjiW/3MmmKYRIWLn2ZqV/tul28nYw/pf5dy
	 8F7PyWXl4ztC1KDFhO3lzrULJ6/wpccQOU4DyJjwYje2N446+4ABqJ6ZaRfKEb0JFE
	 Bt0CeuCeXTME9Ub/vuUJFpB1estoP6TfJzaiA2L9ht9xiN6LtrfQBwu5PognHSU+mC
	 1y6mP17EW2REoHEsU9iPPCaFSfcwWC3A4wfQgfTJWMaUtOhadSX4d5mZLTONol0c3V
	 ztnKkD3uCpEuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702DCA1000;
	Sat, 30 Aug 2025 04:32:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Sat, 30 Aug 2025 05:31:47 +0100
Subject: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys without
 RCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
In-Reply-To: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756528313; l=4256;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=P64RHNAbzWoxqf+XTtQCld5UZ9RLOa3lgy1PDQwJoH4=;
 b=6ZJTPwTyoWZ2UO2BjROhGlxUBaYN/EKB+w6UlcoVXBIzi7poz4freVfZQo7IOf8OVRtbY62PZ
 tniskatGh21ADZxDVmoDnuPLubgXt5T+TnLLfDBSDMDUuiUs45EQjWC
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
index e2ec4ee0ff4a640e9e5501a0d93fc0ed312d488d..254ca95d0c3c5c44029be0e84120c5e9fb9d4514 100644
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
index 68bb75bd419cdbfce17048252919996d764ddc1a..f914bda25d8f5170395157b707d3bd2ef04267a1 100644
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



