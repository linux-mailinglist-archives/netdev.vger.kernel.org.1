Return-Path: <netdev+bounces-43647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083EC7D4132
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B221F28175C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9D224E4;
	Mon, 23 Oct 2023 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htCJgBvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A2219E0;
	Mon, 23 Oct 2023 20:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24521C116B1;
	Mon, 23 Oct 2023 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093935;
	bh=4n1Y2BDxRyW/MG048kYjDc3InJ3vd1rXw6LB824uI+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=htCJgBvMjipaNJj8ae+cOFW6SBQs0V8rcU6TpmBzcYQhNPM6wT/adQnHqNDUXHTE2
	 xn8FE2yAC2LIRZkFpmPdA0XvSqguPo651BuSgDzmwf2qcQgnEzC7VcMnMtLPCtnSZw
	 caNB25bXw9y76faty+z4MSxQ0jdqF5ye2oo5UPmMW/ju/W2U5DoXTJAtyWoKXxAZfb
	 S2OuuTvpsCsZn2wmNChjLWwvQi2gTrFmBhGRc+btT7ofNb2ipma+yT+ddq6hPxO0lu
	 B81MBlamNNaFsnia9AhWBQRIWrKBpHs4zuWEDn00MT9J4dtJlSphZSc2nOuuVGETMB
	 RFNwi7qM0qSjA==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:42 -0700
Subject: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol account for the data enqueued on all the subflows
to the main socket send buffer, while the send buffer auto-tuning
algorithm set the main socket send buffer size as the max size among
the subflows.

That causes bad performances when at least one subflow is sndbuf
limited, e.g. due to very high latency, as the MPTCP scheduler can't
even fill such buffer.

Change the send-buffer auto-tuning algorithm to compute the main socket
send buffer size as the sum of all the subflows buffer size.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 net/mptcp/protocol.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++-----
 net/mptcp/sockopt.c  |  5 ++++-
 net/mptcp/subflow.c  |  3 +--
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e44a3da12b96..1dacc072dcca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -890,6 +890,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
+	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
 }
 
@@ -1076,15 +1077,16 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool first = true;
 
-	sk_stream_moderate_sndbuf(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (first)
 			tcp_enter_memory_pressure(ssk);
 		sk_stream_moderate_sndbuf(ssk);
+
 		first = false;
 	}
+	__mptcp_sync_sndbuf(sk);
 }
 
 /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
@@ -2458,6 +2460,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
+	__mptcp_sync_sndbuf(sk);
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 
@@ -3224,7 +3227,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	mptcp_propagate_sndbuf(nsk, ssk);
+	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
@@ -3402,6 +3405,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
+		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
+			__mptcp_sync_sndbuf(sk);
 	}
 
 	__mptcp_update_rmem(sk);
@@ -3446,6 +3451,14 @@ void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
 	}
+	if (status & BIT(MPTCP_DELEGATE_SNDBUF)) {
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			__mptcp_sync_sndbuf(sk);
+		else
+			__set_bit(MPTCP_SYNC_SNDBUF, &mptcp_sk(sk)->cb_flags);
+		mptcp_data_unlock(sk);
+	}
 	if (status & BIT(MPTCP_DELEGATE_ACK))
 		schedule_3rdack_retransmission(ssk);
 }
@@ -3530,6 +3543,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		mptcp_subflow_joined(msk, ssk);
+		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 620a82cd4c10..296d01965943 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,6 +123,7 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
+#define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -443,6 +444,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SCHEDULED	0
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
+#define MPTCP_DELEGATE_SNDBUF		3
 
 #define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
 /* MPTCP subflow context */
@@ -516,6 +518,9 @@ struct mptcp_subflow_context {
 
 	u32	setsockopt_seq;
 	u32	stale_rcv_tstamp;
+	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk sndbuf,
+				     * protected by the msk socket lock
+				     */
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
@@ -778,13 +783,52 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
-static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
-	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= READ_ONCE(sk->sk_sndbuf))
-		return false;
+	struct mptcp_subflow_context *subflow;
+	int ssk_sndbuf, new_sndbuf;
+
+	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		return;
+
+	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
+
+		subflow->cached_sndbuf = ssk_sndbuf;
+		new_sndbuf += ssk_sndbuf;
+	}
+
+	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
+	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
+}
+
+/* The called held both the msk socket and the subflow socket locks,
+ * possibly under BH
+ */
+static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (READ_ONCE(ssk->sk_sndbuf) != subflow->cached_sndbuf)
+		__mptcp_sync_sndbuf(sk);
+}
+
+/* the caller held only the subflow socket lock, either in process or
+ * BH context. Additionally this can be called under the msk data lock,
+ * so we can't acquire such lock here: let the delegate action acquires
+ * the needed locks in suitable order.
+ */
+static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (likely(READ_ONCE(ssk->sk_sndbuf) == subflow->cached_sndbuf))
+		return;
 
-	WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
-	return true;
+	local_bh_disable();
+	mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SNDBUF);
+	local_bh_enable();
 }
 
 static inline void mptcp_write_space(struct sock *sk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 72858d7d8974..574e221bb765 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -95,6 +95,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_SNDBUFFORCE:
 			ssk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 			WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 			break;
 		case SO_RCVBUF:
 		case SO_RCVBUFFORCE:
@@ -1415,8 +1416,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-		if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		if (sk->sk_userlocks & SOCK_SNDBUF_LOCK) {
 			WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
+		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index df208666fd19..2b43577f952e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 
 void __mptcp_set_connected(struct sock *sk)
 {
+	__mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		inet_sk_state_store(sk, TCP_ESTABLISHED);
 		sk->sk_state_change(sk);
@@ -472,7 +473,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		return;
 
 	msk = mptcp_sk(parent);
-	mptcp_propagate_sndbuf(parent, sk);
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
@@ -1736,7 +1736,6 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);

-- 
2.41.0


