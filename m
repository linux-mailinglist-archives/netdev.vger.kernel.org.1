Return-Path: <netdev+bounces-240839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF2EC7AFD1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39153A3F14
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983C357A40;
	Fri, 21 Nov 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SADS0S9j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F863357A37;
	Fri, 21 Nov 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744593; cv=none; b=YRJIxrDXQ9v4xmVu6AywqiV0WScMYfV947fVW19C9P1ENEP3Vgd9NktQ8ek4bqf0f62UF43kSlDfN6kp/9xrJHja5Qct0Stl7owKHY9qq37WkiNHNefaeKebnGEIIUcnXb1Uu18FUhZxv9OiLVxFy/aCbWBo194aC5gMC4C4E5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744593; c=relaxed/simple;
	bh=4lc9o5hypIw06c+bc58A+FpLlk7rv5SCZaysugtGJHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GE9eNF7IsDNf/OQCdjpySdUXykafGjqN7tzokEVGoK55oFjt5+KVMldROMs8qItLCfYpLKqPfPXvl8COJsZ4skuyMHkbot4+4RR1SggnzqsLX97CSt3XbF4qdfnSgcTjhhaPG1UPuXzvKunY23L5xahp1McnHrvbQlP2rNftjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SADS0S9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4D1C116D0;
	Fri, 21 Nov 2025 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744592;
	bh=4lc9o5hypIw06c+bc58A+FpLlk7rv5SCZaysugtGJHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SADS0S9jwOeC0CaeONHZeZbmPg9Qy1MbHSZi+z9l0zW6JKKQuRPOotkJNu1X5YoWE
	 dAEhT8I7JmV6VJjrf1eyovXD3x9Jx8Qwj0dbF9c+AuftSoIQePFnTBkJ8hqRVydXbr
	 KgTHpfECWYDXd7qGostOX99zhAvrbArP8NyuKUz4BMRI6VzS5JUFLkR3FliFiaqrWr
	 zKSlu3klvvGwLxYWze34ZhAEfXn4jh6U6a053lNfmCGiUTh/ErF0cPY4eqD0bBesOZ
	 AJ8I18TrO0WRN7B9bJY0M3Yrg9pYdfhm5UxYJvpO9c89xgsLUF/Oy7OK16lfTKWotF
	 pHyZ7MhP2qjwQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:12 +0100
Subject: [PATCH net-next 13/14] mptcp: introduce mptcp-level backlog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-13-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8346; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ms4xwAkncS62P20+iLp6vtlwxgVmggWBcGXR1o8kOlY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZsu7c7QedZ0WGL0r2CuY46+W+dW/k0u/7r91L4nhZ
 aom48fajlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInYKjP8jxG+vNPzkdWGZQ8Z
 9Z4rrVUX4koWZVrKcvz9B9MPLbU6Rxn+KZ5bl3sj0bT69qsga68pfyIPt3+6HD3t1YwKvxWzZ88
 6zA0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

We are soon using it for incoming data processing.
MPTCP can't leverage the sk_backlog, as the latter is processed
before the release callback, and such callback for MPTCP releases
and re-acquire the socket spinlock, breaking the sk_backlog processing
assumption.

Add a skb backlog list inside the mptcp sock struct, and implement
basic helper to transfer packet to and purge such list.

Packets in the backlog are memory accounted and still use the incoming
subflow receive memory, to allow back-pressure. The backlog size is
implicitly bounded to the sum of subflows rcvbuf.

When a subflow is closed, references from the backlog to such sock
are removed.

No packet is currently added to the backlog, so no functional changes
intended here.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mptcp_diag.c |  3 +-
 net/mptcp/protocol.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h   | 25 ++++++++++++----
 3 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index ac974299de71..136c2d05c0ee 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -195,7 +195,8 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_info *info = _info;
 
-	r->idiag_rqueue = sk_rmem_alloc_get(sk);
+	r->idiag_rqueue = sk_rmem_alloc_get(sk) +
+			  READ_ONCE(mptcp_sk(sk)->backlog_len);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
 
 	if (inet_sk_state_load(sk) == TCP_LISTEN) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f5526855a2e5..dfed036e0591 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -659,6 +659,39 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
+static void __mptcp_add_backlog(struct sock *sk,
+				struct mptcp_subflow_context *subflow,
+				struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tail = NULL;
+	bool fragstolen;
+	int delta;
+
+	if (unlikely(sk->sk_state == TCP_CLOSE)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
+		return;
+	}
+
+	/* Try to coalesce with the last skb in our backlog */
+	if (!list_empty(&msk->backlog_list))
+		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
+
+	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
+	    skb->sk == tail->sk &&
+	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
+		skb->truesize -= delta;
+		kfree_skb_partial(skb, fragstolen);
+		__mptcp_subflow_lend_fwdmem(subflow, delta);
+		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
+		return;
+	}
+
+	list_add_tail(&skb->list, &msk->backlog_list);
+	mptcp_subflow_lend_fwdmem(subflow, skb);
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk)
 {
@@ -705,8 +738,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			size_t len = skb->len - offset;
 
 			mptcp_init_skb(ssk, skb, offset, len);
-			mptcp_subflow_lend_fwdmem(subflow, skb);
-			ret = __mptcp_move_skb(sk, skb) || ret;
+
+			if (true) {
+				mptcp_subflow_lend_fwdmem(subflow, skb);
+				ret |= __mptcp_move_skb(sk, skb);
+			} else {
+				__mptcp_add_backlog(sk, subflow, skb);
+			}
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -2531,6 +2569,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
 	/* The first subflow can already be closed and still in the list */
 	if (subflow->close_event_done)
 		return;
@@ -2540,6 +2581,17 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
+	/* Remove any reference from the backlog to this ssk; backlog skbs consume
+	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
+	 */
+	list_for_each_entry(skb, &msk->backlog_list, list) {
+		if (skb->sk != ssk)
+			continue;
+
+		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+		skb->sk = NULL;
+	}
+
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
@@ -2769,12 +2821,31 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	unlock_sock_fast(ssk, slow);
 }
 
+static void mptcp_backlog_purge(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tmp, *skb;
+	LIST_HEAD(backlog);
+
+	mptcp_data_lock(sk);
+	list_splice_init(&msk->backlog_list, &backlog);
+	msk->backlog_len = 0;
+	mptcp_data_unlock(sk);
+
+	list_for_each_entry_safe(skb, tmp, &backlog, list) {
+		mptcp_borrow_fwdmem(sk, skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
+	}
+	sk_mem_reclaim(sk);
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
+	mptcp_backlog_purge(sk);
 
 	/* Explicitly send the fastclose reset as need */
 	if (__mptcp_check_fallback(msk))
@@ -2853,11 +2924,13 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	INIT_LIST_HEAD(&msk->backlog_list);
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	msk->backlog_len = 0;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3234,6 +3307,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 
 	__mptcp_clear_xmit(sk);
+	mptcp_backlog_purge(sk);
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5e2749d92a49..fe0dca4122f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -357,6 +357,9 @@ struct mptcp_sock {
 					 * allow_infinite_fallback and
 					 * allow_join
 					 */
+
+	struct list_head backlog_list;	/* protected by the data lock */
+	u32		backlog_len;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -407,6 +410,7 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 static inline int __mptcp_space(const struct sock *sk)
 {
 	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
+				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
 				    sk_rmem_alloc_get(sk));
 }
 
@@ -655,23 +659,32 @@ static inline void mptcp_borrow_fwdmem(struct sock *sk, struct sk_buff *skb)
 {
 	struct sock *ssk = skb->sk;
 
-	/* The subflow just lend the skb fwd memory, and we know that the skb
-	 * is only accounted on the incoming subflow rcvbuf.
+	/* The subflow just lend the skb fwd memory; if the subflow meanwhile
+	 * closed, mptcp_close_ssk() already released the ssk rcv memory.
 	 */
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
-	skb->sk = NULL;
 	sk_forward_alloc_add(sk, skb->truesize);
+	if (!ssk)
+		return;
+
 	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+	skb->sk = NULL;
+}
+
+static inline void
+__mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow, int size)
+{
+	int frag = (subflow->lent_mem_frag + size) & (PAGE_SIZE - 1);
+
+	subflow->lent_mem_frag = frag;
 }
 
 static inline void
 mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow,
 			  struct sk_buff *skb)
 {
-	int frag = (subflow->lent_mem_frag + skb->truesize) & (PAGE_SIZE - 1);
-
+	__mptcp_subflow_lend_fwdmem(subflow, skb->truesize);
 	skb->destructor = NULL;
-	subflow->lent_mem_frag = frag;
 }
 
 static inline u64

-- 
2.51.0


