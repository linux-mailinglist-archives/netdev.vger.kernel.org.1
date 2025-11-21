Return-Path: <netdev+bounces-240827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F506C7AFCE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4048235D09E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608234DB5C;
	Fri, 21 Nov 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rypruDlL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DD340293;
	Fri, 21 Nov 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744562; cv=none; b=mYwFBWAvh6rXW4RIttcr4kiTYzKpoYYkhqCTVtbWpPJtTVhpzeJTiN7MoANB1lJ4BsutvC+qHPSWZgBeCGPRhSBBuXbFGO7ulQZ/pyr1kvQpSNsl/Fix59yzxYImdSHMpNdhvtz7iAljcYKtCt7GXHN0fUFBWUuO7QzrXpM1nZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744562; c=relaxed/simple;
	bh=JqiyVRxMHEYtyT/rjFS/LpRedROqGTJ7vuKAa7M89V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSPmIB7s9AapUrGCbPJ92z2lDJ1JdiRQtGlR5DDjC6rV20wFmEaMLW5VLDLZ9GEP46RJEQjrPr5ZRZFBWF2SAQ0ZwLnYbHPQqzaTyMH9cUUTqbUHeZIZZJMTsOrZv/hHpXKqf3Cs1wDWr/mYYSjgy5aKyHFem/s2UHKg5UJC5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rypruDlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D7C116D0;
	Fri, 21 Nov 2025 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744562;
	bh=JqiyVRxMHEYtyT/rjFS/LpRedROqGTJ7vuKAa7M89V0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rypruDlL4gS0xw+0N3B2/mLhGOZTuUqPTGK7eBk+c8rsdGFwKXnGFBYqDcUKqRidt
	 Fccxo38dAP0e3U9THPLjJepQb46j9fKO5hplXBgcxlsnebTPAOQIsiPsitM4FdSwBR
	 0CEZ1RAzTTg+uj3egKYoTahPIarjVPV9y2L4+lB8JPBT0qpUZCWJJENIgVR1wtmmQO
	 3usRl/JCCfpjysLc3/ho9KyijRgdGg7YdZePeo2j+xwC5ozRQUD0rD4VMRU84S4fp9
	 QtUnba0GdLI7fX246n7WbQ/gg3PyRJx03EXQRJI4ye+JtEoNK2sMA5eLCf9rB3CLYG
	 2v6NmUUig9Kqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:03 +0100
Subject: [PATCH net-next 04/14] mptcp: fix memcg accounting for passive
 sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-4-1f34b6c1e0b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TRMQesoJ1teDIYpT9/7kCY3YsKcNcxDZavMqNyv2chc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZotwzwg9YZ3fZ3lO4h77TMG0r4mXGlc+thOa4Rw6p
 VsnY7tTRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwER2PmRkWNR9P6p5T+WX/wWn
 r2nuEr8nvfXUPQ41kSK+43cWr3me1svIsGCtwP845kSDj4nHkrRqwn/ffCltcOWsM09kQ2//GwF
 GZgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The passive sockets never got proper memcg accounting: the msk
socket is associated with the memcg at accept time, but the
passive subflows never got it right.

At accept time, traverse the subflows list and associate each of them
with the msk memcg, and try to do the same at join completion time, if
the msk has been already accepted.

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/298
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/597
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 10 ++++++++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2104ab1eda1d..67732d3c502c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3651,8 +3651,11 @@ static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
 	write_lock_bh(&sk->sk_callback_lock);
 	sock = sk->sk_socket;
 	write_unlock_bh(&sk->sk_callback_lock);
-	if (sock)
+	if (sock) {
 		mptcp_sock_graft(ssk, sock);
+		__mptcp_inherit_cgrp_data(sk, ssk);
+		__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
+	}
 }
 
 bool mptcp_finish_join(struct sock *ssk)
@@ -3970,6 +3973,28 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	return err;
 }
 
+static void mptcp_graft_subflows(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+
+		/* Set ssk->sk_socket of accept()ed flows to mptcp socket.
+		 * This is needed so NOSPACE flag can be set from tcp stack.
+		 */
+		if (!ssk->sk_socket)
+			mptcp_sock_graft(ssk, sk->sk_socket);
+
+		__mptcp_inherit_cgrp_data(sk, ssk);
+		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+		release_sock(ssk);
+	}
+}
+
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       struct proto_accept_arg *arg)
 {
@@ -4017,16 +4042,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
-		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
-		 * This is needed so NOSPACE flag can be set from tcp stack.
-		 */
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-			if (!ssk->sk_socket)
-				mptcp_sock_graft(ssk, newsock);
-		}
-
+		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
 
 		/* Do late cleanup for the first subflow as necessary. Also
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6d9de13c1f9c..8c27f4b1789f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -707,6 +707,7 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp);
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
 
 int mptcp_is_enabled(const struct net *net);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d98d151392d2..72b7efe388db 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1712,6 +1712,16 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	return err;
 }
 
+void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp)
+{
+	/* Only if the msk has been accepted already (and not orphaned).*/
+	if (!mem_cgroup_sockets_enabled || !sk->sk_socket)
+		return;
+
+	mem_cgroup_sk_inherit(sk, ssk);
+	__sk_charge(ssk, gfp);
+}
+
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk)
 {
 #ifdef CONFIG_SOCK_CGROUP_DATA

-- 
2.51.0


