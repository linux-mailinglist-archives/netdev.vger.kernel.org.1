Return-Path: <netdev+bounces-167462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBEA3A5BD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91202189517E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF811F5841;
	Tue, 18 Feb 2025 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr0p1No5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9391F583C;
	Tue, 18 Feb 2025 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903798; cv=none; b=Keoqd5qSi4zOg85e3PNHi917NQEG3Yz5Ldg/ByWy6R71r+Wa0lSYlPKpEEH14cGiG6unyibWK+GSYA1mVHuu2xnw3IXM95SAOAh9o+wvnBAuQb2F+1Lm16hiyNEHDTO/OH4uDJqbeYEMKoyOh1BZCRZl2EEA3YW4z58t1yvFFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903798; c=relaxed/simple;
	bh=DyE6gQiuZ9Ci0OJxwDN8nNLr2u0AIT9fOHiDhwzebgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxC2K5+31vV/HoDcKsGCqg6vn9o6POkcakEfuuScqAzhOajk5q0SmoGQfezx3UsAYYVwJ5IQytE+Ycke/n+TAlnKSoKLRS+8DYCtooW70MvH8cOrj/e2GLtJjHXTbptCkgwX9czu0NLvN13oql7FAd+jCdQLD6iFJIlueU/hdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr0p1No5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF8FC4CEE4;
	Tue, 18 Feb 2025 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903798;
	bh=DyE6gQiuZ9Ci0OJxwDN8nNLr2u0AIT9fOHiDhwzebgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qr0p1No55a0JyGpnCunEIBqgL/NGu19xt+B6z7yptBJTsdm2CYWLf0psRDuihprAB
	 2mWV8n5Ux3Y+/lpnVPiWAQ9tu3pkgJ8WaZQ+ATVReE1qQCRpS/DQzHMPkrucFdg+p2
	 tx7nbbrC1zNhvDCx4IQxqKQtrBzeQpSNXcY9T5N4beMPpGfJLofC/QB0JU+3n/7GKP
	 YiDg2iYtXtmiQojrdAvt2+puhYxTuLaGyP6AvJ9pUmA4XyXmzQ39XWXqOandc/VgE+
	 ZXGpxS8L9sgqm1451m46McMnhdTwYlp+cXqgLRbTAkSwi1aTgzklyF2Ymq4y7FVgXt
	 TdCKRTzU820uQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:14 +0100
Subject: [PATCH net-next 3/7] mptcp: move the whole rx path under msk
 socket lock protection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-3-4a47d90d7998@kernel.org>
References: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
In-Reply-To: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12219; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O0n9mGfL/jxpDRwQYQi1erBk5pU+KUYXehVHyztmRzM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMnEDdLb1X+h3v/kBFaoU6s4/tWXLSV8Xg4d
 yEQBj02vxmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 c2t/EADGl0VjWzDRF47ez0O+LtwGEpLHyU9uMq7Z8bDHYCzYqO9CnoYdjnWOGgKlxtBRPmt2srZ
 poIG5Ab5FNYzxSVlCfWzdIbOxjWFTwB+Z5ZBYIl3SQ1NTt4vJ1rnjnlvKd4MzmBbuPanlI1HuLd
 J1PuYHTUWzGhFOBjAQplWzl3dCfbe1wEu6N519QfZSp22o1Er4igqD/FUPdFi6sw4saQe3QydZX
 hOqL/sdLV0Ygn1wFsHu76U25gxkXTtv+ABR5LOvP5KDQEhlQww023Mxtm8AWAYr5Z1vJVmfKH+f
 5L0Z2pJlfvyIH3NSRKVFwqOF9YM1p3Kh5JTHm7+BWzDmvJIlhAs1g0QKCCL+n6o+M1/w7L+nQOe
 a6FqGtARa6o25wBb36OXO6k5BNAD6hv/gj86gl8KeH8NBAU9ZvZHPC0H1cuug/t0wiQevL/WSIl
 sr5Ka1YbJ4qwInkteTgwBQg6A49BOHz0ylH2MT/d4T0k0nHszGnEgt5JX6rrIDKMgfmKsLuk0d/
 Q5Z6243RTPMxsSt1OA2yx+V/QgyKu7Cbl7VAMtIfBnBeZxE6xx0ESHzF0qyZ2bkTYrNgjjfg9Yb
 xTjszJKhHvT4+sIUzlpB7+FDWC15bAFBHGXJZcCCU/+yO2owvPesPcCQnUD5SnfSvEyeTriMEvW
 lcNvdLd0z53BGWg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After commit c2e6048fa1cf ("mptcp: fix race in release_cb") we can
move the whole MPTCP rx path under the socket lock leveraging the
release_cb.

We can drop a bunch of spin_lock pairs in the receive functions, use
a single receive queue and invoke __mptcp_move_skbs only when subflows
ask for it.

This will allow more cleanup in the next patch.

Some changes are worth specific mention:

The msk rcvbuf update now always happens under both the msk and the
subflow socket lock: we can drop a bunch of ONCE annotation and
consolidate the checks.

When the skbs move is delayed at msk release callback time, even the
msk rcvbuf update is delayed; additionally take care of such action in
__mptcp_move_skbs().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c |   1 +
 net/mptcp/protocol.c | 123 ++++++++++++++++++++++++---------------------------
 net/mptcp/protocol.h |   2 +-
 3 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 7777f5a2d14379853fcd13c4b57c5569be05a2e4..f85ad19f3dd6c4bcbf31228054ccfd30755db5bc 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -48,6 +48,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
+	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
 	mptcp_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55f9698f3c22f1dc423a7605c7b00bfda162b54c..8bdc7a7a58f31ac74d6a2156b2297af9cd90c635 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -645,18 +645,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 	bool more_data_avail;
 	struct tcp_sock *tp;
 	bool done = false;
-	int sk_rbuf;
-
-	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
-
-	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
-
-		if (unlikely(ssk_rbuf > sk_rbuf)) {
-			WRITE_ONCE(sk->sk_rcvbuf, ssk_rbuf);
-			sk_rbuf = ssk_rbuf;
-		}
-	}
 
 	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
@@ -724,7 +712,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
-		if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf) {
 			done = true;
 			break;
 		}
@@ -848,11 +836,30 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved > 0;
 }
 
+static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
+{
+	if (unlikely(ssk->sk_rcvbuf > sk->sk_rcvbuf))
+		WRITE_ONCE(sk->sk_rcvbuf, ssk->sk_rcvbuf);
+}
+
+static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	__mptcp_rcvbuf_update(sk, ssk);
+
+	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
+	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+		return;
+
+	/* Wake-up the reader only for in-sequence data */
+	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int sk_rbuf, ssk_rbuf;
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -861,19 +868,11 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	if (unlikely(subflow->disposable))
 		return;
 
-	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
-	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
-	if (unlikely(ssk_rbuf > sk_rbuf))
-		sk_rbuf = ssk_rbuf;
-
-	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf)
-		return;
-
-	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
-		sk->sk_data_ready(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_data_ready(sk, ssk);
+	else
+		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
 	mptcp_data_unlock(sk);
 }
 
@@ -1946,16 +1945,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
-static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
+static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct msghdr *msg,
 				size_t len, int flags,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
 	int copied = 0;
 
-	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
+	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
 		u32 offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
 		u32 count = min_t(size_t, len - copied, data_len);
@@ -1990,7 +1990,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			/* we will bulk release the skb memory later */
 			skb->destructor = NULL;
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
-			__skb_unlink(skb, &msk->receive_queue);
+			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 			msk->bytes_consumed += count;
 		}
@@ -2115,54 +2115,46 @@ static void __mptcp_update_rmem(struct sock *sk)
 	WRITE_ONCE(msk->rmem_released, 0);
 }
 
-static void __mptcp_splice_receive_queue(struct sock *sk)
+static bool __mptcp_move_skbs(struct sock *sk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
-}
-
-static bool __mptcp_move_skbs(struct mptcp_sock *msk)
-{
-	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
 	bool ret, done;
 
+	/* verify we can move any data from the subflow, eventually updating */
+	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		mptcp_for_each_subflow(msk, subflow)
+			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
+
+	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+		return false;
+
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
 
-		/* we can have data pending in the subflows only if the msk
-		 * receive buffer was full at subflow_data_ready() time,
-		 * that is an unlikely slow path.
-		 */
-		if (likely(!ssk))
+		if (unlikely(!ssk))
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		mptcp_data_lock(sk);
 		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-		mptcp_data_unlock(sk);
 
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 
-	/* acquire the data lock only if some input data is pending */
 	ret = moved > 0;
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
-		mptcp_data_lock(sk);
+	    !skb_queue_empty(&sk->sk_receive_queue)) {
 		__mptcp_update_rmem(sk);
 		ret |= __mptcp_ofo_queue(msk);
-		__mptcp_splice_receive_queue(sk);
-		mptcp_data_unlock(sk);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+	return ret;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2170,7 +2162,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
 
-	skb = skb_peek(&msk->receive_queue);
+	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
 		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
 
@@ -2216,7 +2208,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2225,7 +2217,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
+		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -2251,7 +2243,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
-				if (__mptcp_move_skbs(msk))
+				if (__mptcp_move_skbs(sk))
 					continue;
 				break;
 			}
@@ -2295,9 +2287,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
-		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
-		 skb_queue_empty(&msk->receive_queue), copied);
+	pr_debug("msk=%p rx queue empty=%d copied=%d\n",
+		 msk, skb_queue_empty(&sk->sk_receive_queue), copied);
 
 	release_sock(sk);
 	return copied;
@@ -2824,7 +2815,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
-	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
@@ -3407,12 +3397,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
 
-	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
-	mptcp_data_lock(sk);
-	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
-	mptcp_data_unlock(sk);
 
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
@@ -3455,7 +3441,8 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST))
+				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
+				      BIT(MPTCP_DEQUEUE))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3489,6 +3476,11 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
+		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
+			/* notify ack seq update */
+			mptcp_cleanup_rbuf(msk, 0);
+			sk->sk_data_ready(sk);
+		}
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
@@ -3726,7 +3718,8 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		__mptcp_move_skbs(msk);
+		if (__mptcp_move_skbs(sk))
+			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
 		break;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c3e9b185ae35d92b5a2daae994a4a9e76f9cc84..753456b73f90879126a36964924d2b6e08e2a1cc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
+#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -325,7 +326,6 @@ struct mptcp_sock {
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-	struct sk_buff_head receive_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;

-- 
2.47.1


