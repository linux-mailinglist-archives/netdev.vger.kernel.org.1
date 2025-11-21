Return-Path: <netdev+bounces-240824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C126DC7AF88
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C993A33FF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51333A6E9;
	Fri, 21 Nov 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjrsNAMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4312EF673;
	Fri, 21 Nov 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744552; cv=none; b=ESPryXhelyC2BdPmpbSI43qk/em50tFl7Pr5aQAirKdxUjDDk7g5D4mjyG0NmFpG7JpGSkbjeCfk92YwI8UWSuZhXokXyDixiGftSZhWNXfO0etpe5RgfGm6x3te4OrwFk1qWlrg5Rx2he3EixbEIKBRICBfyteS3Clgyhcn3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744552; c=relaxed/simple;
	bh=E5wcI+z/Iyhniomwivx/9qPvXu9SKA6nPNoFpiR5cmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jowCLOzn/fZ5ruHuDBYCeoCMpkCN5LfBWxUjUDqXyD7PEthZES69AaiBcsoF68D8SVlG3XbsVA4PyFmCiv1fkPVK6ioZ4RD75x8//HGtgc6dacJ5fo1XFynWadujPngbv+/v8T6skLhU3Nc3SGa51UL7UcLHNVq6OOlodTitEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjrsNAMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1246C4CEF1;
	Fri, 21 Nov 2025 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744551;
	bh=E5wcI+z/Iyhniomwivx/9qPvXu9SKA6nPNoFpiR5cmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LjrsNAMk7EqdJ1rDyrSyFSMyqEcHyuhF3RGHfQMRWC97UPZA1jRUCce9HF9zwL6V+
	 hUipubhu/Y6aKi2tanvmAzNIFk3j2vFJQUzNJhGMHpBmLsR4nFQQ5Dte9rulCycedt
	 NO/5hiJ1dmZsEL6o50i+74MSw+6cK6nW6sFeGgG+1FdDj8FIhfSoemILQaXQof/6Lr
	 EI+64s/qCmE+VzXBW3dzL/J/HAEgFlU8hbz+gaj+BWdaTNCWNypyqhSoIZ57IjtZE6
	 0HFg46rXYzCrkp6j+WW4y2G0tDncymJduI73rTjStQu5Mr9L6IKE9M98D9o5/TBpOD
	 7c8SrE7IvKZGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:00 +0100
Subject: [PATCH net-next 01/14] net: factor-out _sk_charge() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-1-1f34b6c1e0b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hK0a1iO/ogfUyqYhDGeAlo+Zr9nsYO9S3nxWufSEKio=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZgswZf5axP6QzecYl1HAWjGR2x4zj/BcOSbKtfTbw
 3BzN97kjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImkHWZk2BCU5tAQzybe7Ryb
 Y73ki4yvJ0OnAftP3lJeeY/NPzLeMvzTzNjg+PP6Nl/d3kWCrE8/Se9Nc8/YtoxvHtc/rlCmpAg
 WAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Move out of __inet_accept() the code dealing charging newly
accepted socket to memcg. MPTCP will soon use it to on a per
subflow basis, in different contexts.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Geliang Tang <geliang@kernel.org>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 18 ++++++++++++++++++
 net/ipv4/af_inet.c | 17 +----------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a5f36ea9d46f..38d48cfe0741 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1631,6 +1631,8 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	sk_mem_reclaim(sk);
 }
 
+void __sk_charge(struct sock *sk, gfp_t gfp);
+
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 static inline void sk_owner_set(struct sock *sk, struct module *owner)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 3b74fc71f51c..b26a6cdc9bcd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3448,6 +3448,24 @@ void __sk_mem_reclaim(struct sock *sk, int amount)
 }
 EXPORT_SYMBOL(__sk_mem_reclaim);
 
+void __sk_charge(struct sock *sk, gfp_t gfp)
+{
+	int amt;
+
+	gfp |= __GFP_NOFAIL;
+	if (mem_cgroup_from_sk(sk)) {
+		/* The socket has not been accepted yet, no need
+		 * to look at newsk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(sk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		if (amt)
+			mem_cgroup_sk_charge(sk, amt, gfp);
+	}
+
+	kmem_cache_charge(sk, gfp);
+}
+
 int sk_set_peek_off(struct sock *sk, int val)
 {
 	WRITE_ONCE(sk->sk_peek_off, val);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a31b94ce8968..08d811f11896 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
 	if (mem_cgroup_sockets_enabled) {
-		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-
 		mem_cgroup_sk_alloc(newsk);
-
-		if (mem_cgroup_from_sk(newsk)) {
-			int amt;
-
-			/* The socket has not been accepted yet, no need
-			 * to look at newsk->sk_wmem_queued.
-			 */
-			amt = sk_mem_pages(newsk->sk_forward_alloc +
-					   atomic_read(&newsk->sk_rmem_alloc));
-			if (amt)
-				mem_cgroup_sk_charge(newsk, amt, gfp);
-		}
-
-		kmem_cache_charge(newsk, gfp);
+		__sk_charge(newsk, GFP_KERNEL);
 	}
 
 	sock_rps_record_flow(newsk);

-- 
2.51.0


