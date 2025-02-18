Return-Path: <netdev+bounces-167465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E6A3A5C9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0C91645DC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433B17A31F;
	Tue, 18 Feb 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0EnWWX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963ED270EC3;
	Tue, 18 Feb 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903809; cv=none; b=JehsqM5h1oUSZCq3V81DbeevHfbUGw2H9r/SHT2Bi8oK7hKwI9jJZZ6dfKsHQW3ExoXdWfd4xhF3/nFTNJ3FaHguD3zIRnkCXDHMDUj0pxVZOc6YzSwOPUdcTzL0x86rLgf3S8o6W8yj1EwqvwzM8Erd8w17aa1xgPyPcVCPeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903809; c=relaxed/simple;
	bh=JHX0AHDU9Z3wO5E/PzOjf/tEoouvJ5ogW4zW/Wl9gQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtbN/HmYpH5dIEEzxWO5HKKLPjLm6mnQBGCz3WuvnsGsNBGlFPN05CbHetpLBeNPK12PZaL+MwuepbzaXTyzLHbWJmBSJzfnSsp4TuoeP4LqXOJUOkUW399yV6dQ8GcBDWKYNorfKljsam1YelacN3mhA+JMmRBa9xRd5K7plqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0EnWWX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96AC4CEEB;
	Tue, 18 Feb 2025 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903809;
	bh=JHX0AHDU9Z3wO5E/PzOjf/tEoouvJ5ogW4zW/Wl9gQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d0EnWWX7njrWBA1vyWmv3LhqNoqBkpquxupxyPYu3V5LV7mO+p+r2kXXwRRbxzNrK
	 oRueJZ5JGZfYM3sRciHZCcvaDXztP48oST8amvk/H4S+yhT59dK0qfb59fvAoVAiHC
	 EjBSAzzECG0h8LeYH7e1TNEQIw574QZqHylT60VAkHXEXIcpHqDPz5xra/6FbKjqIN
	 qMRlDpM6aHXtZDK0akxi05KPG2fKGzS0PGsZ/Kez207cwzop0jEFxjZYPmJlhlHzIb
	 06iqlcVRGIy8tA8Q7AWnyv8toMtZ0K1+k5qNemFiErwZ3KFI87rdNserehdAeekQZh
	 s/JV7LQq4fxxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:17 +0100
Subject: [PATCH net-next 6/7] mptcp: dismiss __mptcp_rmem()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-6-4a47d90d7998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3152; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eXI8QUSL7/rXzK6E2jx6P6T/20wyQGDw98FRoytZKY8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMnBYnWH2koruYhyBP2MYhxM5254T/PsjBAo
 CYYDUvWX++JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 c9VqEACMNiqYIb7EJmojhr3S0niZ+WGvzsXVYeE2zjbLAkS4hWaTkr9RL/HxRXXRz1xGXA3CuRj
 j2SDDsM9H8fgm9JCZbiu2GUWM7VKQEvC399NjvMQoNJZSAjNrOH0WuHl/F045z8cjKdJJ3gPKS/
 wGiBSsdivbSslbwU0ihBNDx1IiaUNGpBqRo6kX92gtV4ScDOZbPrhQRq3bgBhTimj2uuM3PlPPk
 B6fMpHT/Wco66ayBOAV51VUAbopML4OWdTrR8xP0Pa2ro3ak+cqXX+m3M8OJYrN22V0ZoZ6iwKL
 8NjBmkbo09W7KHHXqoOGnjp6uyFXoGaHZf6bSvFkvSAE0VcOhsxF8cdi1/rY/vguFsuVh0Fikiz
 KoKSJLbRxS3LH7wdLZmKdL5Ha7tHIks1NIsPVWYIVopFrilUPlvgT2VgZ/hVzYB/kHclu5pCQ4B
 F8P4gCT9fBNB7qu+1qwcd3dAGA8oV1+nHXjbi9DvvTto1WF+1MBz/ew1hMPWcXVwcW547c4yuKd
 65Y5BpQxi2DvYxrI6Newh3aMmwNQ51TiFJ+kWfaZsIooEr4/tjbWi53Rjz6iRAoZb27kS+irFSP
 HU8Y/N2rXmc0mF6UAMNqTMGbW1RXRsUtO3OclwhZICrI0Tm8jUIBN13K/TMv5cDmjSm690/Fo5i
 L8pn2rpcjcHhcLw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the RX path refactor, it become a wrapper for sk_rmem_alloc
access, with a slightly misleading name. Just drop it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  8 ++++----
 net/mptcp/protocol.h | 11 ++---------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 080877f8daf7e3ff36531f3e11079d2163676f2d..c709f654cd5a4944390cf1e160f59cd3b509b66d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -496,7 +496,7 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 	bool cleanup, rx_empty;
 
 	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
-	rx_empty = !__mptcp_rmem(sk) && copied;
+	rx_empty = !sk_rmem_alloc_get(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -645,7 +645,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
-		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf) {
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf) {
 			done = true;
 			break;
 		}
@@ -782,7 +782,7 @@ static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	__mptcp_rcvbuf_update(sk, ssk);
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 		return;
 
 	/* Wake-up the reader only for in-sequence data */
@@ -2049,7 +2049,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 		mptcp_for_each_subflow(msk, subflow)
 			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
 
-	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+	if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 		return false;
 
 	do {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 613d556ed938a99a2800b4384ee4c6cda9483381..a1a077bae7b6ec4fab5b266e2613acb145eb343f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -380,14 +380,6 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
 #endif
 
-/* the msk socket don't use the backlog, also account for the bulk
- * free memory
- */
-static inline int __mptcp_rmem(const struct sock *sk)
-{
-	return atomic_read(&sk->sk_rmem_alloc);
-}
-
 static inline int mptcp_win_from_space(const struct sock *sk, int space)
 {
 	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
@@ -400,7 +392,8 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
+	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
+				    sk_rmem_alloc_get(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)

-- 
2.47.1


