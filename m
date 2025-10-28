Return-Path: <netdev+bounces-233502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC2C147EC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4326620F96
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30031A059;
	Tue, 28 Oct 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAoXuQRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481031A055;
	Tue, 28 Oct 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652702; cv=none; b=uaf7aGYd/wK0JxKGhsL+iHbVEelrFbXj3781p9qtSkUYn+5MF38hogq9RhjZd3KXbeCfMUgtKGYDs0W7T0tvm6hwn500K84MgN351TVGqu3IUaV370fEbU2iOaaMZHczwrVUxNa0v1WBe3PI3d2IUYQk44ZmwWWI+SOmG3fOqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652702; c=relaxed/simple;
	bh=yH7KKdEncOuWCw0Rid4HIJ22FlA/XySvA55XieJCyrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8ZBE32jaCLQ8Yczmm7HJh68JKMNlR77XOIecEYQs7wwwZS32jPqTCD04s9S7+GIpZ65FBK67u7N1z3J7zsvKxMiONaGlPny82Mrwh6R4JwnwJGWV4AaMEq7j6SkwH2/lztLukJFSaQ3Q7Ga1T5vdcNiDB4k1mOozE42IBXn1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAoXuQRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B633CC4CEF7;
	Tue, 28 Oct 2025 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652702;
	bh=yH7KKdEncOuWCw0Rid4HIJ22FlA/XySvA55XieJCyrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iAoXuQRDsLaiKRZ97y/llHd1GOecjuUjwJfPebP/aM3BZxCUuV5QqeDF5Y3adjmPw
	 +6V8wC0WBYc5fnFT21A8P93jVSKZN9f7D7TY4BcnXDK6eRWq0dn2KSHb9+NMW2PW/t
	 7fslb4ZMoFwQXJE4fj2UwQKpgsvwm+d+tD+d3ce3V9KDyhJK/sG6jLWkirhHiVfajS
	 1k2aqnQXUOfFGx1Ul81hpyqRJpYd5MImZhd5ZFpHekIFamXReYp7DuhpznGEGyLTdr
	 18zAVNbX6WfwxzObH5N+J7yzIr0hBqbqr87SV2Annkla0kmZlQbbhv9MJ0I8W4SXQ7
	 N3StzOLo1NMMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 12:58:01 +0100
Subject: [PATCH net v3 3/4] tcp: add newval parameter to tcp_rcvbuf_grow()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5164; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CEgLJN/G2utHiPRzDgGJA0SRmsiXroTRCizCIPg4FdY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZ1l841RPr7rjv+Pqpm1adMdx+0uvf5JpVP037GfJ8r
 6e5ffVJ6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI/G9Ghq6fyRtdtGJ402/0
 L88yOn3eeZ9Bktf0Z/2blvw3YOor4WFk6DArO237Z4LPhWPP/lzT01i1aP7LK/WpVxcvurpZzG/
 iMzYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Eric Dumazet <edumazet@google.com>

This patch has no functional change, and prepares the following one.

tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
old and new values.

Change mptcp_rcvbuf_grow() in a similar way.

Signed-off-by: Eric Dumazet <edumazet@google.com>
[ Moved 'oldval' declaration to the next patch to avoid warnings at
 build time. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 14 +++++++-------
 net/mptcp/protocol.c | 20 ++++++++------------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5ca230ed526a..ab20f549b8f9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -370,7 +370,7 @@ void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
-void tcp_rcvbuf_grow(struct sock *sk);
+void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 31ea5af49f2d..cb4e07f84ae2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -891,18 +891,20 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 	}
 }
 
-void tcp_rcvbuf_grow(struct sock *sk)
+void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	int rcvwin, rcvbuf, cap;
+	u32 rcvwin, rcvbuf, cap;
+
+	tp->rcvq_space.space = newval;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
 	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		return;
 
 	/* slow start: allow the sender to double its rate. */
-	rcvwin = tp->rcvq_space.space << 1;
+	rcvwin = newval << 1;
 
 	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
@@ -943,9 +945,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	trace_tcp_rcvbuf_grow(sk, time);
 
-	tp->rcvq_space.space = copied;
-
-	tcp_rcvbuf_grow(sk);
+	tcp_rcvbuf_grow(sk, copied);
 
 new_measure:
 	tp->rcvq_space.seq = tp->copied_seq;
@@ -5270,7 +5270,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	}
 	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
 	if (sk->sk_socket)
-		tcp_rcvbuf_grow(sk);
+		tcp_rcvbuf_grow(sk, tp->rcvq_space.space);
 }
 
 static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8a3bdf95543..052a0c62023f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -194,17 +194,18 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
  * - mptcp does not maintain a msk-level window clamp
  * - returns true when  the receive buffer is actually updated
  */
-static bool mptcp_rcvbuf_grow(struct sock *sk)
+static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct net *net = sock_net(sk);
-	int rcvwin, rcvbuf, cap;
+	u32 rcvwin, rcvbuf, cap;
 
+	msk->rcvq_space.space = newval;
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
 	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		return false;
 
-	rcvwin = msk->rcvq_space.space << 1;
+	rcvwin = newval << 1;
 
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
@@ -334,7 +335,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
 	if (sk->sk_socket)
-		mptcp_rcvbuf_grow(sk);
+		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
 }
 
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
@@ -2049,10 +2050,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
-	msk->rcvq_space.space = msk->rcvq_space.copied;
-	if (mptcp_rcvbuf_grow(sk)) {
-		int copied = msk->rcvq_space.copied;
-
+	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
 		 * the mptcp rx queue fast enough (announced rcv_win can
@@ -2065,10 +2063,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			slow = lock_sock_fast(ssk);
 			/* subflows can be added before tcp_init_transfer() */
-			if (tcp_sk(ssk)->rcvq_space.space) {
-				tcp_sk(ssk)->rcvq_space.space = copied;
-				tcp_rcvbuf_grow(ssk);
-			}
+			if (tcp_sk(ssk)->rcvq_space.space)
+				tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}

-- 
2.51.0


