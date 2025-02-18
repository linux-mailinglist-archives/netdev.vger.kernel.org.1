Return-Path: <netdev+bounces-167464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB5A3A5C1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E85D16264E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FD26F45A;
	Tue, 18 Feb 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKs+BKHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB726B2D3;
	Tue, 18 Feb 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903805; cv=none; b=dAaBdk29YyM9KVDqUT+81cfLk3DJ8pL8XU6xjT3+2Zc99ZunfWgx3erh4b4an2cAAbcrhCioc9lwqXh3RcUrI9mWWNojUk99mfv5VFvQvnG4xJMfvvuonyNQeY31kK3UMx/YHE4pL058O07a9V1aBWqXhv6FYW4PTbXiC2QTsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903805; c=relaxed/simple;
	bh=a2n1iRP+j6iFehN5PBuGMpY43pwjb/WhoWJ7Nx56u8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0MD9TSPcQqmkY9caPwCPMEarSUKy2ocL7M7NmItJfvOcyCGUXFNiiARox0N62W2G77n9XZvPb/5/HdIUZQxdEDuRuh7pTEYyk1hblIMUHsVOcKsflygoRuAMR6UtJzB9iXltL3j/9VG+w0b9HCkjKvi9jXAqv9Sj5kamSHv3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKs+BKHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF8C4CEE4;
	Tue, 18 Feb 2025 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903805;
	bh=a2n1iRP+j6iFehN5PBuGMpY43pwjb/WhoWJ7Nx56u8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WKs+BKHbuj7T4KehhFAsemBS9FoQrVFyGcFLIBh6gTLvvt/C7b+h0yc+ivlDX4fK3
	 73ME2Fhv4n8jUEvLzIwgpvKdemviZwsikf1hBA4N44uzEZahOAjjXR5lHllGZfp57b
	 xtml2Rdgbl5tBWPCmJL0+40kkKmWhUQt00BNKhIa9f4r2bju/W38dIrZO4QcjPEdiL
	 ZbY8dV6Ika6wQ4bZ0TYxEo3G+8bsJWbqmDrhPSY9d8FZPqi3r/Idj3TTHO1k2l68I5
	 DHLm/ms9yPrFWngzGl1HxQ5050Re88HJu+qPk7rjQsJgk8TBgNLMmK0Y/bmn5u5O9I
	 HEaNkNAtWpRRQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:16 +0100
Subject: [PATCH net-next 5/7] net: dismiss sk_forward_alloc_get()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-5-4a47d90d7998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4080; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=viiaOyZW64iyCHKnCj0hoDEEHUJ4EIG7vZ9h8lhf3Gk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMnYA3KhIc1NRpfdciZGIALMCW6GMTMW20Z2
 V3Hu/DXVT2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 cw4FD/4ttVC+hSUqJBWuS+exx/4G58u/1diepZ3yK0/xbX2eg6hCflT/KNpzWouEyINnwZph4L0
 4EhKU1109fFZSphu7/aGh2nQwfJ+qQB4PdEZAUZTPL0TOaTxoKRKn9sAch3vzeUHN3+lo+eO/fz
 TLQthg5ZJV/pIBh84aWweCaYSSwEMVjpF7IRFo41exV5UdlctHpMVZX4CxQd5qEdx7+e+ywD2nf
 Ur25vuB2je4eCMXN71sSTccReKW9NVJJxxSua4hAkXJGCXQDgFd8ShlKJdUyZFbSeU0Nnhz1+jp
 pcIsMak4veyWLXw/tDFmWTXACkH0RIpM9ZtsI2XhfQbAMygvXOolh+Ze1jt5mWFzb3NTF2vW0N1
 VeA5VLy7PA1JJw6d/fdxeB45y0uXwf5DkBHBoscZOTeDIQbgbrw9v9Dyb2zCuDlpEpJK1OMq/SW
 YbxJpSOaA0hu7f9jvS94wlyQrgfFUaNlawei8EJ9pQBRbAUBnzJnQk8wJcNUdthERLggW+1lKWV
 wyjpFoIOg5s7XIxYihXrYVtd6NqrHKit8kR3xTTi/CuKtFjeQfLUAmVYtO1bsW+84ZnorwmFG+y
 qQg/ilNkE1EyjHgSd807RQ7IGzF1Gelivm56TRBbk5x6qoFDQizDscz1mydzC1I8wLEGYDE8D87
 nzrJ7Z5XWVHBP0g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the previous patch we can remove the forward_alloc_get
proto callback, basically reverting commit 292e6077b040 ("net: introduce
sk_forward_alloc_get()") and commit 66d58f046c9d ("net: use
sk_forward_alloc_get() in sk_get_meminfo()").

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/sock.h   | 13 -------------
 net/core/sock.c      |  2 +-
 net/ipv4/af_inet.c   |  2 +-
 net/ipv4/inet_diag.c |  2 +-
 net/sched/em_meta.c  |  2 +-
 5 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60ebf3c7b229e257b164e0de1f56543ea69f38f3..ac7fb5bd8ef9af10135a6e703408f2b24bd3d713 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1285,10 +1285,6 @@ struct proto {
 	unsigned int		inuse_idx;
 #endif
 
-#if IS_ENABLED(CONFIG_MPTCP)
-	int			(*forward_alloc_get)(const struct sock *sk);
-#endif
-
 	bool			(*stream_memory_free)(const struct sock *sk, int wake);
 	bool			(*sock_is_readable)(struct sock *sk);
 	/* Memory pressure */
@@ -1349,15 +1345,6 @@ int sock_load_diag_module(int family, int protocol);
 
 INDIRECT_CALLABLE_DECLARE(bool tcp_stream_memory_free(const struct sock *sk, int wake));
 
-static inline int sk_forward_alloc_get(const struct sock *sk)
-{
-#if IS_ENABLED(CONFIG_MPTCP)
-	if (sk->sk_prot->forward_alloc_get)
-		return sk->sk_prot->forward_alloc_get(sk);
-#endif
-	return READ_ONCE(sk->sk_forward_alloc);
-}
-
 static inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
 {
 	if (READ_ONCE(sk->sk_wmem_queued) >= READ_ONCE(sk->sk_sndbuf))
diff --git a/net/core/sock.c b/net/core/sock.c
index 53c7af0038c4fca630e1ac2ebecf55558cb16eef..0d385bf27b38d97458e6a695a559f4f1600773c4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3882,7 +3882,7 @@ void sk_get_meminfo(const struct sock *sk, u32 *mem)
 	mem[SK_MEMINFO_RCVBUF] = READ_ONCE(sk->sk_rcvbuf);
 	mem[SK_MEMINFO_WMEM_ALLOC] = sk_wmem_alloc_get(sk);
 	mem[SK_MEMINFO_SNDBUF] = READ_ONCE(sk->sk_sndbuf);
-	mem[SK_MEMINFO_FWD_ALLOC] = sk_forward_alloc_get(sk);
+	mem[SK_MEMINFO_FWD_ALLOC] = READ_ONCE(sk->sk_forward_alloc);
 	mem[SK_MEMINFO_WMEM_QUEUED] = READ_ONCE(sk->sk_wmem_queued);
 	mem[SK_MEMINFO_OPTMEM] = atomic_read(&sk->sk_omem_alloc);
 	mem[SK_MEMINFO_BACKLOG] = READ_ONCE(sk->sk_backlog.len);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 21f46ee7b6e95329a2f7f0e0429eebf1648e7f9d..5df1f1325259d9b9dbe3be19a81066f85cf306e5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -153,7 +153,7 @@ void inet_sock_destruct(struct sock *sk)
 	WARN_ON_ONCE(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc));
 	WARN_ON_ONCE(sk->sk_wmem_queued);
-	WARN_ON_ONCE(sk_forward_alloc_get(sk));
+	WARN_ON_ONCE(sk->sk_forward_alloc);
 
 	kfree(rcu_dereference_protected(inet->inet_opt, 1));
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 321acc8abf17e8c7d6a4e3326615123fff19deab..efe2a085cf68e90cd1e79b5556e667a0fd044bfd 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -282,7 +282,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		struct inet_diag_meminfo minfo = {
 			.idiag_rmem = sk_rmem_alloc_get(sk),
 			.idiag_wmem = READ_ONCE(sk->sk_wmem_queued),
-			.idiag_fmem = sk_forward_alloc_get(sk),
+			.idiag_fmem = READ_ONCE(sk->sk_forward_alloc),
 			.idiag_tmem = sk_wmem_alloc_get(sk),
 		};
 
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 8996c73c9779b5fa804e6f913834cf1fe4d071e6..3f2e707a11d18922d7d9dd93e8315c1ab26eebc7 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -460,7 +460,7 @@ META_COLLECTOR(int_sk_fwd_alloc)
 		*err = -1;
 		return;
 	}
-	dst->value = sk_forward_alloc_get(sk);
+	dst->value = READ_ONCE(sk->sk_forward_alloc);
 }
 
 META_COLLECTOR(int_sk_sndbuf)

-- 
2.47.1


