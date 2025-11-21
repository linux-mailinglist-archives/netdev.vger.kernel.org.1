Return-Path: <netdev+bounces-240826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E7BC7AFBF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B14B0365861
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFD346E43;
	Fri, 21 Nov 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilEO6GAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8913451A3;
	Fri, 21 Nov 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744559; cv=none; b=D+dyM4f4420+ozdtjPaK8aZG4A0LUtSg3Pa4HJrIXtCg1mj97tGrSz+CtWlxqaze3bDxOJvybqnto4z+5a5gqKjiwW6NsmPJCRXHAT/hB5/PtlLv7gxRtpyp0UCmyJnMcUL9vEbM+PJNQNds4TGftEKGYQJrTt5T61/AmsAdOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744559; c=relaxed/simple;
	bh=jQ0UDB4U29x/KlnOx2L558m9xp5Y4bGvMVx4QgXsvAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3PGst/2kjkSZ8KzeyN0a5i70U0VQiJtzX9Rnja/EtTNOay9UbI/j8ufr6RCSg7LxQl0abuBCAvXX1Op4uc/GufKu9ZIXja8LHbbdu2jEnQfBFGHMFbw1lLVW+PvyCqlEPXC99W861TkzLIGCnNsrK8+SyS71S52l4LTjdvjMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilEO6GAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895B0C4CEF1;
	Fri, 21 Nov 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744558;
	bh=jQ0UDB4U29x/KlnOx2L558m9xp5Y4bGvMVx4QgXsvAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ilEO6GAIQEmvi73CO+PkIZFQJQVe0bSLd+kKfmOnlWX2iZL87CqdFE+GZVWihWM8d
	 gXnDXPKmJKj5bLUvMJsneqO52HhCRT9E/+XM0BzdW1qJIiznpcshFrE0KKkcPi8tye
	 2Qpymrjrfg34+SIwF1b3ZNkysGT0TDdQmDPRWiJoc8TSec4QmNmlmVap419R8tKw4V
	 GfP1ubAx9A7sFa2kCcl3RciRw47kxo0y2zQ0FkM77nE3A7kZKcPZXAuiAI7zOrFM+1
	 yK9kaJVddyIyw4LTzqp17Og5b5TT040P88fGIPEmOCTYFmOmyM/+vrsBD6KR52Py+a
	 1D+un71sEVX1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:02 +0100
Subject: [PATCH net-next 03/14] mptcp: grafting MPJ subflow earlier
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-3-1f34b6c1e0b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TzG7leIFSjvo22mwXd7Xqen2NE60+AKXWYBJRpqRFhM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZgsnx991bsrfwRHTa9TEnH1z7h9DpjkBfY8286umR
 nQcM9vYUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFTkxkZLkY0c/LkvL721P3S
 p0+P10nz5tfkrdo/my1+FcOWI+K32Bn+Gf7iTGx767X9cc5NvYzjb7c8rLmqruO+eP+sDQpWjxd
 YcQIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Later patches need to ensure that all MPJ subflows are grafted to the
msk socket before accept() completion.

Currently the grafting happens under the msk socket lock: potentially
at msk release_cb time which make satisfying the above condition a bit
tricky.

Move the MPJ subflow grafting earlier, under the msk data lock, so that
we can use such lock as a synchronization point.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 75bb1199bed9..2104ab1eda1d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -895,12 +895,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_joined(msk, ssk);
 	spin_unlock_bh(&msk->fallback_lock);
 
-	/* attach to msk socket only after we are sure we will deal with it
-	 * at close time
-	 */
-	if (sk->sk_socket && !ssk->sk_socket)
-		mptcp_sock_graft(ssk, sk->sk_socket);
-
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
@@ -3647,6 +3641,20 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
+/* Can be called without holding the msk socket lock; use the callback lock
+ * to avoid {READ_,WRITE_}ONCE annotations on sk_socket.
+ */
+static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
+{
+	struct socket *sock;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	sock = sk->sk_socket;
+	write_unlock_bh(&sk->sk_callback_lock);
+	if (sock)
+		mptcp_sock_graft(ssk, sock);
+}
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -3662,7 +3670,9 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	/* active subflow, already present inside the conn_list */
+	/* Active subflow, already present inside the conn_list; is grafted
+	 * either by __mptcp_subflow_connect() or accept.
+	 */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
 		if (!msk->allow_subflows) {
@@ -3689,11 +3699,17 @@ bool mptcp_finish_join(struct sock *ssk)
 		if (ret) {
 			sock_hold(ssk);
 			list_add_tail(&subflow->node, &msk->conn_list);
+			mptcp_sock_check_graft(parent, ssk);
 		}
 	} else {
 		sock_hold(ssk);
 		list_add_tail(&subflow->node, &msk->join_list);
 		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
+
+		/* In case of later failures, __mptcp_flush_join_list() will
+		 * properly orphan the ssk via mptcp_close_ssk().
+		 */
+		mptcp_sock_check_graft(parent, ssk);
 	}
 	mptcp_data_unlock(parent);
 

-- 
2.51.0


