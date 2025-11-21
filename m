Return-Path: <netdev+bounces-240838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC51AC7B037
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A14F382D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31E735773B;
	Fri, 21 Nov 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvH5CwQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2635770E;
	Fri, 21 Nov 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744589; cv=none; b=MVR+2Bv/oLzyx7lPnwe+m1sdPpQfpLyMax6fJFhyHXk/byIdr5Qh2lrQfxBTVehZIH923IODMEc8f9QC7CRDjvunDE7R5TrhJCNVVc13tNEs2osCvUs4hpIXsAIxdjphNEI0yDgCCScF4FOYSXSVeDU/R5aON2rDxfl6mWOQg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744589; c=relaxed/simple;
	bh=exipAAAG44c1ya/2FIftGqLb+lrF8/NOW6yQn4gOd8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQBcIae+wRVXbs0zMjrxAa1MDYpSfU+bHLb6xGYf5k+BsLrrH0nui0mMjkKcUgGKFbwGENuu9SgerqmTwr1HcxgBTYtgcVUFRwCTTE8DARwOxjFPNUDzM+olT0Ff8Mowz7+FyzIMIhgSTG/KrbpGBx9Hz9ejl77/0arnCqfOiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvH5CwQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B47C4CEF1;
	Fri, 21 Nov 2025 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744589;
	bh=exipAAAG44c1ya/2FIftGqLb+lrF8/NOW6yQn4gOd8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvH5CwQwNHgt31gWGOdn8L7LEbE2/j7HMBgaRyLtIXqHCltYLIMiDFAOPGDGaYP2T
	 aSHM43cz+5wCme1FJLgxn6MnmiNcSKROR4lC4UjGAdzzbv7QQj3cYQh7FAde6RFhIx
	 T7uBoD2dcPEDFJiH+K9pAgOiH7WE2aRFGenbk9c1XkYCoM0rYLaCJmOh9TavTP4D+P
	 m1O0seT5504F/xFzj1BWR+b05YSoUi8x/EqBOaf1u8XSyBaVOfwk8cQ22b4O21us9P
	 pBaCE+yAUQNMDPvbVmK0d3K1DVn9mMYgT+ugJPQyDBINSqBtVXEPgw2XH21fx2aJNd
	 8i5BedE4dyqBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:11 +0100
Subject: [PATCH net-next 12/14] mptcp: borrow forward memory from subflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-12-1f34b6c1e0b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7831; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hY44Oq6q0TXEmmxU5JFPD8A8RXoTf8Ee1IhPcJGt60c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZssdYv+yYuKcTN3UxWfPnlrLwWc693Zlx3wBFdFcw
 9zWtTzCHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOx6mBk2Lclbnvue0FzrqS2
 0LNHHE/8f3Xi6JZm5WtrbuTdnHnC/TjDPyWZPsvLniXTJfSblB/FTqn/KMYfYaBm8PY9z+cHl2o
 kOAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In the MPTCP receive path, we release the subflow allocated fwd
memory just to allocate it again shortly after for the msk.

That could increases the failures chances, especially when we will
add backlog processing, with other actions could consume the just
released memory before the msk socket has a chance to do the
rcv allocation.

Replace the skb_orphan() call with an open-coded variant that
explicitly borrows, the fwd memory from the subflow socket instead
of releasing it.

The borrowed memory does not have PAGE_SIZE granularity; rounding to
the page size will make the fwd allocated memory higher than what is
strictly required and could make the incoming subflow fwd mem
consistently negative. Instead, keep track of the accumulated frag and
borrow the full page at subflow close time.

This allow removing the last drop in the TCP to MPTCP transition and
the associated, now unused, MIB.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c |  4 +++-
 net/mptcp/mib.c      |  1 -
 net/mptcp/mib.h      |  1 -
 net/mptcp/protocol.c | 23 +++++++++++++++--------
 net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index b9e451197902..82ec15bcfd7f 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -32,7 +32,8 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);
-	skb_orphan(skb);
+
+	mptcp_subflow_lend_fwdmem(subflow, skb);
 
 	/* We copy the fastopen data, but that don't belong to the mptcp sequence
 	 * space, need to offset it in the subflow sequence, see mptcp_subflow_get_map_offset()
@@ -50,6 +51,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	mptcp_sk(sk)->bytes_received += skb->len;
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 171643815076..f23fda0c55a7 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -71,7 +71,6 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
 	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
-	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index a1d3e9369fbb..812218b5ed2b 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -70,7 +70,6 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
 	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
-	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d22f792f4760..f5526855a2e5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -358,7 +358,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 			   int copy_len)
 {
-	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
@@ -383,11 +383,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
-	/* try to fetch required memory from subflow */
-	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
+	mptcp_borrow_fwdmem(sk, skb);
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
@@ -409,7 +405,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will retransmit as needed, if needed.
 	 */
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
@@ -710,7 +705,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			size_t len = skb->len - offset;
 
 			mptcp_init_skb(ssk, skb, offset, len);
-			skb_orphan(skb);
+			mptcp_subflow_lend_fwdmem(subflow, skb);
 			ret = __mptcp_move_skb(sk, skb) || ret;
 			seq += len;
 
@@ -2436,6 +2431,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
+	int fwd_remaining;
 
 	/* Do not pass RX data to the msk, even if the subflow socket is not
 	 * going to be freed (i.e. even for the first subflow on graceful
@@ -2444,6 +2440,17 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
+	 * could be negative at this point, but will be reach zero soon - when
+	 * the data allocated using such fragment will be freed.
+	 */
+	if (subflow->lent_mem_frag) {
+		fwd_remaining = PAGE_SIZE - subflow->lent_mem_frag;
+		sk_forward_alloc_add(sk, fwd_remaining);
+		sk_forward_alloc_add(ssk, -fwd_remaining);
+		subflow->lent_mem_frag = 0;
+	}
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d30806b287d2..5e2749d92a49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -547,6 +547,7 @@ struct mptcp_subflow_context {
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -646,6 +647,33 @@ mptcp_send_active_reset_reason(struct sock *sk)
 	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
 }
 
+/* Made the fwd mem carried by the given skb available to the msk,
+ * To be paired with a previous mptcp_subflow_lend_fwdmem() before freeing
+ * the skb or setting the skb ownership.
+ */
+static inline void mptcp_borrow_fwdmem(struct sock *sk, struct sk_buff *skb)
+{
+	struct sock *ssk = skb->sk;
+
+	/* The subflow just lend the skb fwd memory, and we know that the skb
+	 * is only accounted on the incoming subflow rcvbuf.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+	skb->sk = NULL;
+	sk_forward_alloc_add(sk, skb->truesize);
+	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+}
+
+static inline void
+mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow,
+			  struct sk_buff *skb)
+{
+	int frag = (subflow->lent_mem_frag + skb->truesize) & (PAGE_SIZE - 1);
+
+	skb->destructor = NULL;
+	subflow->lent_mem_frag = frag;
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {

-- 
2.51.0


