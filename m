Return-Path: <netdev+bounces-167466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE3A3A5C4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BB93A3B67
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C351EB5DF;
	Tue, 18 Feb 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll7DrvDc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369511EB5DE;
	Tue, 18 Feb 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903814; cv=none; b=HSu9CyzRH4ljXG7bdZbYybNH4IP5fctUnZh62h2PLpTsHBg/Vos3B5NTptu+6PP6DRue/zIdgLXM+i39xGAWhgff4ODETzYzKIgX9nfF/ai0pvmB9yslIW3UVs+IvP+X40LL47GE2lQxlSig3iLF3jZUBJmgG8MTLPVynG7BU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903814; c=relaxed/simple;
	bh=FuEmwmBco4pfgcrOyMQPaOEQ5AMu1vAUJfMUV8FkDtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqClFfjVUZUCIiV3YSbUVshEc+snQau+VjGAF703QqmU5ueM/ZoX6Ymhkjv2RC5dKoaBEYkvsA96G/rer0+NOI7zTcxnQGiYgNGs8Ck0lLDZJyPkLJTRhCe7uMzWYFuuQuRLeI0mpTmZgHPaU1ZTK0f4r5mKoWZSv9ke8s1oHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll7DrvDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF04C4CEE2;
	Tue, 18 Feb 2025 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903812;
	bh=FuEmwmBco4pfgcrOyMQPaOEQ5AMu1vAUJfMUV8FkDtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ll7DrvDc7wZJh0iSzzPZ8RkckswbLFwwQrdHbgPkcdKEBaXI+BZ64U6H7w0Krm/F1
	 80mM843qgQd1/37WYnhH+lL1uRTjVMwFKEVTDnDKxMJ4M3uPeBlqx3X1qU2wWUdXLk
	 o4nF1zqYq6oxcT0szQUc0rmIVoH5YQmQI+GfizpvPA+t1BBF1/4Cx4fv3hCGTZQ5Zp
	 Xa6IwUSZBtYbGozng/IpqcFNZkz4OM/uFRZIw9hsgXUrqGDLV2VBNIjDfLxEE6oUKz
	 29NcBhjv58HKPjOq7gmtVc4eq2TwWqRwKT4FkfBonKsfL/OtUQ2FZuQnWG75AZEXbt
	 07+8qN55+G14Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:18 +0100
Subject: [PATCH net-next 7/7] mptcp: micro-optimize __mptcp_move_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-7-4a47d90d7998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7810; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UUZ2l4CArzUWVM9zGO3re19UeTioW3f1Q/TZ8tu7/is=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMn/JObq6JQyNbP7lEygvD9z7ysS+k4zTqCV
 sJ4zhYrwAaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 cxayEACwPcuobyxN+pAtEAADdCZLdNZpT7IZ+EI/nbBxCQfPNFKpdUgTGWvL+C7WZDFcNP1NSzQ
 zDDrGo2Z1yQz1eVf26tE+tg1LeLe6eEPWzfQqWXP9NKHBQjGk8e/HAI7p2SlB9RuiJpktlgbTTW
 wYdymPLYZLPK0QXPgOmshMk2XWYn9aNl4V1hZTspRsj4DJxmTbRDqSIJR3dvJJ+yrPj3QF893a+
 lU8k6gLZAFVVqb6lEhHNyBwNs3HIckqiaJv3d+HJx76OoCAzH43X95gxWsg2yFB+F7d6Gw6wsml
 OhqxxCSMmB6MS5/QUN5YzJfoNwsCPMipn4esD4yueJf7P5ln8O4UEJpOt5p60UVXcMfNpc/+22q
 Xu9tvzQDlLucEc6TDl7TIXNh8JQiCFnFcVWbLDkdHrgNQgSY6XUT6KCb+iJhUtBO/mCYTwBdtS2
 DDEjhCsavdE4e1D+cBfY0ly/KXBOKV/K+8Ep8hIked6qfdf8s7USRbbULgDegmJ+mRC76xKbDms
 Oh/K+vYc4cPiXylehd4l0410OSA16NJFZkVqaX6X6BlqMqcdsxmmHwC0xNJG6a12Gf4cmgCWHeK
 4tJoc8Yv464IbhQacUABmcBycEkYjBS0gIDJIL46ZNZFk1PDUDLy54oUGfn775WrQGma3V6CwlQ
 rUR+8iHmSslTmtg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the RX path refactor the mentioned function is expected to run
frequently, let's optimize it a bit.

Scan for ready subflow from the last processed one, and stop after
traversing the list once or reaching the msk memory limit - instead of
looking for dubious per-subflow conditions.
Also re-order the memory limit checks, to avoid duplicate tests.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 111 +++++++++++++++++++++++----------------------------
 net/mptcp/protocol.h |   2 +
 2 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c709f654cd5a4944390cf1e160f59cd3b509b66d..6b61b7dee33be10294ae1101f9206144878a3192 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -569,15 +569,13 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
-					   struct sock *ssk,
-					   unsigned int *bytes)
+					   struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
-	unsigned int moved = 0;
 	bool more_data_avail;
 	struct tcp_sock *tp;
-	bool done = false;
+	bool ret = false;
 
 	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
@@ -587,20 +585,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		struct sk_buff *skb;
 		bool fin;
 
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+			break;
+
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
 				mptcp_subflow_get_map_offset(subflow);
 
 		skb = skb_peek(&ssk->sk_receive_queue);
-		if (!skb) {
-			/* With racing move_skbs_to_msk() and __mptcp_move_skbs(),
-			 * a different CPU can have already processed the pending
-			 * data, stop here or we can enter an infinite loop
-			 */
-			if (!moved)
-				done = true;
+		if (unlikely(!skb))
 			break;
-		}
 
 		if (__mptcp_check_fallback(msk)) {
 			/* Under fallback skbs have no MPTCP extension and TCP could
@@ -613,19 +607,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		offset = seq - TCP_SKB_CB(skb)->seq;
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-		if (fin) {
-			done = true;
+		if (fin)
 			seq++;
-		}
 
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			if (tp->urg_data)
-				done = true;
-
-			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
-				moved += len;
+			ret = __mptcp_move_skb(msk, ssk, skb, offset, len) || ret;
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -639,22 +627,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			}
 
 			sk_eat_skb(ssk, skb);
-			done = true;
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf) {
-			done = true;
-			break;
-		}
 	} while (more_data_avail);
 
-	if (moved > 0)
+	if (ret)
 		msk->last_data_recv = tcp_jiffies32;
-	*bytes += moved;
-	return done;
+	return ret;
 }
 
 static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
@@ -748,9 +730,9 @@ void __mptcp_error_report(struct sock *sk)
 static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
-	unsigned int moved = 0;
+	bool moved;
 
-	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err)) {
 		if (!sock_owned_by_user(sk))
@@ -766,7 +748,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	 */
 	if (mptcp_pending_data_fin(sk, NULL))
 		mptcp_schedule_work(sk);
-	return moved > 0;
+	return moved;
 }
 
 static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
@@ -781,10 +763,6 @@ static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	__mptcp_rcvbuf_update(sk, ssk);
 
-	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-		return;
-
 	/* Wake-up the reader only for in-sequence data */
 	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
@@ -884,20 +862,6 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 
-static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-
-	msk_owned_by_me(msk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->data_avail))
-			return mptcp_subflow_tcp_sock(subflow);
-	}
-
-	return NULL;
-}
-
 static bool mptcp_skb_can_collapse_to(u64 write_seq,
 				      const struct sk_buff *skb,
 				      const struct mptcp_ext *mpext)
@@ -2037,37 +2001,62 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
+static struct mptcp_subflow_context *
+__mptcp_first_ready_from(struct mptcp_sock *msk,
+			 struct mptcp_subflow_context *subflow)
+{
+	struct mptcp_subflow_context *start_subflow = subflow;
+
+	while (!READ_ONCE(subflow->data_avail)) {
+		subflow = mptcp_next_subflow(msk, subflow);
+		if (subflow == start_subflow)
+			return NULL;
+	}
+	return subflow;
+}
+
 static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	unsigned int moved = 0;
-	bool ret, done;
+	bool ret = false;
+
+	if (list_empty(&msk->conn_list))
+		return false;
 
 	/* verify we can move any data from the subflow, eventually updating */
 	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		mptcp_for_each_subflow(msk, subflow)
 			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
 
-	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-		return false;
-
-	do {
-		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
+	subflow = list_first_entry(&msk->conn_list,
+				   struct mptcp_subflow_context, node);
+	for (;;) {
+		struct sock *ssk;
 		bool slowpath;
 
-		if (unlikely(!ssk))
+		/*
+		 * As an optimization avoid traversing the subflows list
+		 * and ev. acquiring the subflow socket lock before baling out
+		 */
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 			break;
 
-		slowpath = lock_sock_fast(ssk);
-		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		subflow = __mptcp_first_ready_from(msk, subflow);
+		if (!subflow)
+			break;
 
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		slowpath = lock_sock_fast(ssk);
+		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
-	} while (!done);
 
-	ret = moved > 0 || __mptcp_ofo_queue(msk);
+		subflow = mptcp_next_subflow(msk, subflow);
+	}
+
+	__mptcp_ofo_queue(msk);
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1a077bae7b6ec4fab5b266e2613acb145eb343f..ca65f8bff632ff806fe761f86e9aa065b0657d1e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -354,6 +354,8 @@ struct mptcp_sock {
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
+#define mptcp_next_subflow(__msk, __subflow)				\
+	list_next_entry_circular(__subflow, &((__msk)->conn_list), node)
 
 extern struct genl_family mptcp_genl_family;
 

-- 
2.47.1


