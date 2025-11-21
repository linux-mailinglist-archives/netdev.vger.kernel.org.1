Return-Path: <netdev+bounces-240840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A0AC7B02B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02CC2383143
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B693358D06;
	Fri, 21 Nov 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8yJKG12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422F3587D5;
	Fri, 21 Nov 2025 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744596; cv=none; b=qOWto9tr3nHditSfeitgzsEUUl1Q+F6GU5+MqfGIfFbbKR/cj1H7RUAE+iDFox+lPmcZvrgLd4xtoPD4XrdjYyRoesnUz8354ceVKPzLTqp9PdINvfHJzpo8Ucztp6AR6EAvjWngAdr9VQyoIyRXh/L7brfz2q6C6ZmTJktTf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744596; c=relaxed/simple;
	bh=yxIE8l3JZQR5JCywo+A5MPHo33+yYPDBOugaYFYC8vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfbEUnZTP2FbfZ5kZA5tf+7FK+hGxRpLbAuAhCiQRPHUEsjpXKzoYtGFUf2pGyELcZcV5Peg9JE2Y9XOKtBbfLXqZPSEuAdpnBnWnvKeYVxRNRNJiNTYwpx/s6TJKqj4SjDnwdsAppujj6L9Eaf+Baw5r6nLCpbXkUz1hi/ntCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8yJKG12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53308C116C6;
	Fri, 21 Nov 2025 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744596;
	bh=yxIE8l3JZQR5JCywo+A5MPHo33+yYPDBOugaYFYC8vU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h8yJKG12y7OUoUeypsziIg8Yxrgmvno2Uej5G5zLX/qleVWx/HMzRgfVzbciFYj1t
	 tVUWpbRuZCQThIc983/MGYsMaUTeU+H2ud2iiHceBks09RNhZbEMlYdKsZT25mH+2Z
	 a579Hsdu22e3RkynJB31u5Tzn0VrxbxC7YT7OZ8RRjZKJbBnrFxFnJiGhRGlWlLf3j
	 UWht0gpn3pEbTAAHMYiCfeUs0npfO8TGze7ZyYEoPQl28XH/APWjzeatdPuf7KaIVY
	 5Y6S3uThBr2SiAUs8aSearEUZg9e5Rxj08T4TOiIKMcpaurRU/k5ORZyr201RHXRV/
	 qsal4Y8KXw09w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:13 +0100
Subject: [PATCH net-next 14/14] mptcp: leverage the backlog for RX packet
 processing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-14-1f34b6c1e0b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11951; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EO6UaLraU7c+G3zNJSh1ZDma+EoTxHJngur0al91bNo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZiuseFX30OCNwvfLTRUXYjbzSXS/b6i5ekPicN+hg
 jq9W9sfdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEqY2R4cIqbwPDCRUslaev
 LaouUT8h8Nf9y4WqR2zLVObqPatME2f4w5/00P76tGKb+/0eYt/8omwXuZw5bbt4ptJs+6fb0+X
 UuQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

When the msk socket is owned or the msk receive buffer is full,
move the incoming skbs in a msk level backlog list. This avoid
traversing the joined subflows and acquiring the subflow level
socket lock at reception time, improving the RX performances.

When processing the backlog, use the fwd alloc memory borrowed from
the incoming subflow. skbs exceeding the msk receive space are
not dropped; instead they are kept into the backlog until the receive
buffer is freed. Dropping packets already acked at the TCP level is
explicitly discouraged by the RFC and would corrupt the data stream
for fallback sockets.

Special care is needed to avoid adding skbs to the backlog of a closed
msk and to avoid leaving dangling references into the backlog
at subflow closing time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 191 +++++++++++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h |   2 +-
 2 files changed, 132 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dfed036e0591..e4ccc57b6f57 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -665,6 +665,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail = NULL;
+	struct sock *ssk = skb->sk;
 	bool fragstolen;
 	int delta;
 
@@ -678,22 +679,30 @@ static void __mptcp_add_backlog(struct sock *sk,
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
 
 	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
-	    skb->sk == tail->sk &&
+	    ssk == tail->sk &&
 	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
 		skb->truesize -= delta;
 		kfree_skb_partial(skb, fragstolen);
 		__mptcp_subflow_lend_fwdmem(subflow, delta);
-		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
-		return;
+		goto account;
 	}
 
 	list_add_tail(&skb->list, &msk->backlog_list);
 	mptcp_subflow_lend_fwdmem(subflow, skb);
-	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
+	delta = skb->truesize;
+
+account:
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
+
+	/* Possibly not accept()ed yet, keep track of memory not CG
+	 * accounted, mptcp_graft_subflows() will handle it.
+	 */
+	if (!mem_cgroup_from_sk(ssk))
+		msk->backlog_unaccounted += delta;
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk)
+					   struct sock *ssk, bool own_msk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -709,9 +718,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		struct sk_buff *skb;
 		bool fin;
 
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
 				mptcp_subflow_get_map_offset(subflow);
@@ -739,7 +745,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (true) {
+			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -863,7 +869,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	bool moved;
 
-	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err))
 		__mptcp_subflow_error_report(sk, ssk);
@@ -896,7 +902,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 			sk->sk_data_ready(sk);
 	} else {
-		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
+		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
 	mptcp_data_unlock(sk);
 }
@@ -2136,60 +2142,80 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static struct mptcp_subflow_context *
-__mptcp_first_ready_from(struct mptcp_sock *msk,
-			 struct mptcp_subflow_context *subflow)
+static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
 {
-	struct mptcp_subflow_context *start_subflow = subflow;
-
-	while (!READ_ONCE(subflow->data_avail)) {
-		subflow = mptcp_next_subflow(msk, subflow);
-		if (subflow == start_subflow)
-			return NULL;
-	}
-	return subflow;
-}
-
-static bool __mptcp_move_skbs(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
+	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool ret = false;
+	bool moved = false;
 
-	if (list_empty(&msk->conn_list))
-		return false;
-
-	subflow = list_first_entry(&msk->conn_list,
-				   struct mptcp_subflow_context, node);
-	for (;;) {
-		struct sock *ssk;
-		bool slowpath;
-
-		/*
-		 * As an optimization avoid traversing the subflows list
-		 * and ev. acquiring the subflow socket lock before baling out
-		 */
+	*delta = 0;
+	while (1) {
+		/* If the msk recvbuf is full stop, don't drop */
 		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 			break;
 
-		subflow = __mptcp_first_ready_from(msk, subflow);
-		if (!subflow)
+		prefetch(skb->next);
+		list_del(&skb->list);
+		*delta += skb->truesize;
+
+		moved |= __mptcp_move_skb(sk, skb);
+		if (list_empty(skbs))
 			break;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
-		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
-		if (unlikely(ssk->sk_err))
-			__mptcp_error_report(sk);
-		unlock_sock_fast(ssk, slowpath);
-
-		subflow = mptcp_next_subflow(msk, subflow);
+		skb = list_first_entry(skbs, struct sk_buff, list);
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (ret)
+	if (moved)
 		mptcp_check_data_fin((struct sock *)msk);
-	return ret;
+	return moved;
+}
+
+static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	/* After CG initialization, subflows should never add skb before
+	 * gaining the CG themself.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
+			       mem_cgroup_from_sk(sk));
+
+	/* Don't spool the backlog if the rcvbuf is full. */
+	if (list_empty(&msk->backlog_list) ||
+	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+		return false;
+
+	INIT_LIST_HEAD(skbs);
+	list_splice_init(&msk->backlog_list, skbs);
+	return true;
+}
+
+static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
+				  struct list_head *skbs)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
+	list_splice(skbs, &msk->backlog_list);
+}
+
+static bool mptcp_move_skbs(struct sock *sk)
+{
+	struct list_head skbs;
+	bool enqueued = false;
+	u32 moved;
+
+	mptcp_data_lock(sk);
+	while (mptcp_can_spool_backlog(sk, &skbs)) {
+		mptcp_data_unlock(sk);
+		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
+
+		mptcp_data_lock(sk);
+		mptcp_backlog_spooled(sk, moved, &skbs);
+	}
+	mptcp_data_unlock(sk);
+	return enqueued;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2255,7 +2281,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
+		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -3556,8 +3582,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
-				      BIT(MPTCP_DEQUEUE))
+				      BIT(MPTCP_FLUSH_JOIN_LIST))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3567,9 +3592,12 @@ static void mptcp_release_cb(struct sock *sk)
 
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
-		struct list_head join_list;
+		struct list_head join_list, skbs;
+		bool spool_bl;
+		u32 moved;
 
-		if (!flags)
+		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
+		if (!flags && !spool_bl)
 			break;
 
 		INIT_LIST_HEAD(&join_list);
@@ -3591,7 +3619,7 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
-		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
+		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
 			/* notify ack seq update */
 			mptcp_cleanup_rbuf(msk, 0);
 			sk->sk_data_ready(sk);
@@ -3599,6 +3627,8 @@ static void mptcp_release_cb(struct sock *sk)
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
+		if (spool_bl)
+			mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
@@ -3856,7 +3886,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		if (__mptcp_move_skbs(sk))
+		if (mptcp_move_skbs(sk))
 			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
@@ -4061,6 +4091,22 @@ static void mptcp_graft_subflows(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	if (mem_cgroup_sockets_enabled) {
+		LIST_HEAD(join_list);
+
+		/* Subflows joining after __inet_accept() will get the
+		 * mem CG properly initialized at mptcp_finish_join() time,
+		 * but subflows pending in join_list need explicit
+		 * initialization before flushing `backlog_unaccounted`
+		 * or MPTCP can later unexpectedly observe unaccounted memory.
+		 */
+		mptcp_data_lock(sk);
+		list_splice_init(&msk->join_list, &join_list);
+		mptcp_data_unlock(sk);
+
+		__mptcp_flush_join_list(sk, &join_list);
+	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -4072,10 +4118,35 @@ static void mptcp_graft_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
+		if (!mem_cgroup_sk_enabled(sk))
+			goto unlock;
+
 		__mptcp_inherit_cgrp_data(sk, ssk);
 		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+
+unlock:
 		release_sock(ssk);
 	}
+
+	if (mem_cgroup_sk_enabled(sk)) {
+		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+		int amt;
+
+		/* Account the backlog memory; prior accept() is aware of
+		 * fwd and rmem only.
+		 */
+		mptcp_data_lock(sk);
+		amt = sk_mem_pages(sk->sk_forward_alloc +
+				   msk->backlog_unaccounted +
+				   atomic_read(&sk->sk_rmem_alloc)) -
+		      sk_mem_pages(sk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		msk->backlog_unaccounted = 0;
+		mptcp_data_unlock(sk);
+
+		if (amt)
+			mem_cgroup_sk_charge(sk, amt, gfp);
+	}
 }
 
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fe0dca4122f2..313da78e2b75 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
-#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -360,6 +359,7 @@ struct mptcp_sock {
 
 	struct list_head backlog_list;	/* protected by the data lock */
 	u32		backlog_len;
+	u32		backlog_unaccounted;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)

-- 
2.51.0


