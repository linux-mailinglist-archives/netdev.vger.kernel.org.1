Return-Path: <netdev+bounces-167461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F505A3A5BB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C95D3A49A6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F9C1F5826;
	Tue, 18 Feb 2025 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrTWpMq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0A1F5822;
	Tue, 18 Feb 2025 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903796; cv=none; b=rYrq0ACskQ/uLI35l+0i1FMIbvSWPgE2UR6oH0BA6ARDypFZFHePT6mw+6aWNEv8T909edkX3Ld54ECfhS+gJSuSrw2Qf86eu98j+yKcp5Nqw12ZyCxDBlUcntvC6KoRXeMvgrzmeNFoclICrm+O+xTnVTxq1lwbjJNUls7yPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903796; c=relaxed/simple;
	bh=wuahuA5ylgrgljO5VDYDx96x4R3nL275ICd3P5Wv79o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtNsDniIQaOpFkZv9O88qOzW5Q0BIV3KapOTFGL+Y2sW2ZRQkPTEZQIK4TlWigbNZseNYBkpdsIxgEA3MoPDfYWUPD30GOHcFQY4o1dqcrUQwN0YsItiLj4mDdCb/CU6HRL377KPaGtFgxI0KNppzhWqpn37odex4Ab99m91oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrTWpMq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508F6C4CEE2;
	Tue, 18 Feb 2025 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903794;
	bh=wuahuA5ylgrgljO5VDYDx96x4R3nL275ICd3P5Wv79o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qrTWpMq+FcCb2iAeqN9Nq26JmItHNfZqGiDWr+YEEJp9IqvQ2B3LGgL68Qy47hmcK
	 QlicUzF2TgSiexpQzZQy/Tb/NK2Vd5/kXyy0YiZnZr3S8qcZkAyFi3gEeTF3eIDuRB
	 R8St2XEoqmi/7u+XqKwjbcgL8KirdWZkN7N+OBhohktze4jXeuI6CRlh49i0Wkg9Ao
	 9JyPg0z6YPWH0Zj+IvJwxxalosNdCeGX7DSMjZbpISXyWgJ7oPWzCNAgjdj9/dacUh
	 XTLeOZRWdCRNk2SX58a7QbwoDa2EZAN+ogn8S58VtGOw3LTT8DX1TIqo52Vx/JqViD
	 1ErvGwC+vg8GA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:13 +0100
Subject: [PATCH net-next 2/7] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-2-4a47d90d7998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5353; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OPeer42AvAhJ9v5YycxG/rFJZR0B5WxAYUWtDju/5ys=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMn3S2M7io/paYz65v9IzpjAlduxP+x+sXi3
 +67ZLFaKGGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 c1qiD/9Zaj2zIeXq2gAh0aMD6rCOjJgPQcBxj/5qVOI5uyr/JXenv+4s0lzx4Cpa0smO/res+S1
 9oyGQrMidxzvJW8jbXokJexrxGWGoSpntqSyW4zUUsPDoWbOE9xuTrUfCX6dIKIYBEbW7rxWytf
 TjsdydbgruOnU3R+GQE0u/rCG2BqVI09iXKfiDpmw10fSeNyfj7BvE1nkPCVu45q6rHmJjsNJcY
 78FDdJizs2DJmB1KbNIQ8jkJVm9fZvNeGgTnAOrZ1MeZJHa4KqlX36H1ZcyCwu1kQ71VD9bHCHD
 4lspgXMsrGTkzzQotiixK3F1858G5AeD478CGfrxBsKfpLbN4EW9NNMN6J/i9zGElLASBFxxg4Y
 WjLIMPly5Z0Hpvfr/1oJISlmALx+7U404WyQ/CJyHdurWc022zeEsbgGj72nUBP9pf0bgU3JGcL
 kEUpocLF3imR8Ca8CH0+8p5tMqkQ5S0hHnxnAg3+MzvVvWvaP5/hgHtByEhLsM2mX+50EqyqlAW
 7+brGZiwNSm4YFXz6pQR2I24iCMaQY6zV3RVaGa+IQAi49EaFDDVfTaC+NW4obA3fWCLVQVe13R
 0OnLamFeTQ/W5CuVEW2//nqoA464GTR4f5CGbCF/2N3hWY3HjWS4YzTMqhwne7p+4eWvzmGgm2C
 zsFIUBgZHuo+RKw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

When we will move the whole RX path under the msk socket lock, updating
the already queued skb for passive fastopen socket at 3rd ack time will
be extremely painful and race prone

The map_seq for already enqueued skbs is used only to allow correct
coalescing with later data; preventing collapsing to the first skb of
a fastopen connect we can completely remove the
__mptcp_fastopen_gen_msk_ackseq() helper.

Before dropping this helper, a new item had to be added to the
mptcp_skb_cb structure. Because this item will be frequently tested in
the fast path -- almost on every packet -- and because there is free
space there, a single byte is used instead of a bitfield. This micro
optimisation slightly reduces the number of CPU operations to do the
associated check.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c | 24 ++----------------------
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/protocol.h |  5 ++---
 net/mptcp/subflow.c  |  3 ---
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index a29ff901df7588dec24e330ddd77a4aeb1462b68..7777f5a2d14379853fcd13c4b57c5569be05a2e4 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -40,13 +40,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
 
-	/* initialize a dummy sequence number, we will update it at MPC
-	 * completion, if needed
-	 */
+	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 
@@ -58,22 +57,3 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	mptcp_data_unlock(sk);
 }
-
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *skb;
-
-	skb = skb_peek_tail(&sk->sk_receive_queue);
-	if (skb) {
-		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
-		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx\n", sk,
-			 MPTCP_SKB_CB(skb)->map_seq, MPTCP_SKB_CB(skb)->map_seq + msk->ack_seq,
-			 MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq;
-		MPTCP_SKB_CB(skb)->end_seq += msk->ack_seq;
-	}
-
-	pr_debug("msk=%p ack_seq=%llx\n", msk, msk->ack_seq);
-}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bd81904747066d8f2c1043dd81b372925f18cbb..55f9698f3c22f1dc423a7605c7b00bfda162b54c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -135,7 +135,8 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	bool fragstolen;
 	int delta;
 
-	if (MPTCP_SKB_CB(from)->offset ||
+	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
+	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
@@ -366,6 +367,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 37226cdd9e3717c4f8cf0d4c879a0feaaa91d459..3c3e9b185ae35d92b5a2daae994a4a9e76f9cc84 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -129,7 +129,8 @@ struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
 	u32 offset;
-	u8  has_rxtstamp:1;
+	u8  has_rxtstamp;
+	u8  cant_coalesce;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
@@ -1059,8 +1060,6 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_nl_fill_addr(struct sk_buff *skb,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2926bdf88e42c5f2db6875b00b4eca2dbf49dba2..d2caffa56bdd98f5fd9ef07fdcb3610ea186b848 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -802,9 +802,6 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	WRITE_ONCE(subflow->fully_established, true);
 	WRITE_ONCE(msk->fully_established, true);
-
-	if (subflow->is_mptfo)
-		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,

-- 
2.47.1


