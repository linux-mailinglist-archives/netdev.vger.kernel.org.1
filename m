Return-Path: <netdev+bounces-265619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCvmIzvvrmlcKgIAu9opvQ
	(envelope-from <netdev+bounces-265619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:03:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2523C5ED
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6C53083030
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFFC3E3D93;
	Mon,  9 Mar 2026 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsuDH5ey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF243DA7C6;
	Mon,  9 Mar 2026 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071822; cv=none; b=LiA2UdvaLIr82uDQ/t2fGQXRr0fqnleblZR7y732wMCk4AMt7AxLZG6ni9zoHCACEXq3Q1tbLupvE/Iz0/u8RlzvAqCuk/SB0J5/d+OTZtmZ/g5m5OK22K97KXHato+5bNfkciW9A9q83nqlTS1ApEKCoFVgbOBzezl9WEa1K4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071822; c=relaxed/simple;
	bh=fUxq2JBMOXdn7J81G0Oub9GV5O7iGFWrvS7w+kFAiNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5u9vNTxo5rpR0dTu6A5MiDpy+8mBOjYYNPoVjc2VONos9sc2fV0ksfo3sqZb+I1FokZB/ozYBQHbEFi9iDjOVVz0nUbBVVeQo42Q0pf89Aej9/PRmpsCJF/vJtlteBKnGq5lP2W7HZdHrXRoPeJZLJzQjeM1AmKwFYP6WhVNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsuDH5ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D43C2BC86;
	Mon,  9 Mar 2026 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071822;
	bh=fUxq2JBMOXdn7J81G0Oub9GV5O7iGFWrvS7w+kFAiNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qsuDH5eyjjNYETxqlXbZclHxJJPaauBYp7bTq21e22jfCRnR66na3xkBf1o10OMe4
	 qyjYorcgJF4m0c2swBxjFaEBJzCOVhd96x+ehD5GzNNd5yK0zpwfIvegDjUYvWwE3D
	 yjCkjyLorjmNTvLBLtlNU9t4ys6yfZGu0vxO7mzLOuP//1z1aSxKTDpkQse4EsKsrs
	 MPGLS9g74cOehCCRStPINKzApU4oNckWgu69gX7kkluxTU0St0UKaMWjqHB5bZ/Ylf
	 JFOGwlbt6CaSAcTJSqHNCDMtowiJNG1LAbdGaxaLzPmoROK/RoZo7Y+Va3ubzBMnvo
	 sYNbUcPNBJl2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Mar 2026 16:56:45 +0100
Subject: [PATCH net-next 1/2] mptcp: better mptcp-level RTT estimator
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-net-next-mptcp-reduce-rbuf-v1-1-8f471206f9c5@kernel.org>
References: <20260309-net-next-mptcp-reduce-rbuf-v1-0-8f471206f9c5@kernel.org>
In-Reply-To: <20260309-net-next-mptcp-reduce-rbuf-v1-0-8f471206f9c5@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9262; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WVBrrMCUm1p1MA2wZ2EEMG0KtGe2wPXSEGZOXLmCROM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLXvT3uaBqgelV7yYTTSuevPlq+i2+i7fLD2/aukXrTe
 7bJzf+paEcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBE/h1gZPi9/3nG1dj7lhzH
 3ljLTPj4zu2PFcOOnawF/U5KnoIly8MZGbYsWhTL2Kl5c5Kkf+5DreSawunfDj/JiIrhPfRviWd
 +GxMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: E3D2523C5ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265619-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,goodmis.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

The current MPTCP-level RTT estimator has several issues. On high speed
links, the MPTCP-level receive buffer auto-tuning happens with a
frequency well above the TCP-level's one. That in turn can cause
excessive/unneeded receive buffer increase.

On such links, the initial rtt_us value is considerably higher than the
actual delay, and the current mptcp_rcv_space_adjust() updates
msk->rcvq_space.rtt_us with a period equal to the such field previous
value. If the initial rtt_us is 40ms, its first update will happen after
40ms, even if the subflows see actual RTT orders of magnitude lower.

Additionally:
- setting the msk RTT to the maximum among all the subflows RTTs makes
  DRS constantly overshooting the rcvbuf size when a subflow has
  considerable higher latency than the other(s).

- during unidirectional bulk transfers with multiple active subflows,
  the TCP-level RTT estimator occasionally sees considerably higher
  value than the real link delay, i.e. when the packet scheduler reacts
  to an incoming ACK on given subflow pushing data on a different
  subflow.

- currently inactive but still open subflows (i.e. switched to backup
  mode) are always considered when computing the msk-level RTT.

Address the all the issues above with a more accurate RTT estimation
strategy: the MPTCP-level RTT is set to the minimum of all the subflows
actually feeding data into the MPTCP receive buffer, using a small
sliding window.

While at it, also use EWMA to compute the msk-level scaling_ratio, to
that MPTCP can avoid traversing the subflow list is
mptcp_rcv_space_adjust().

Use some care to avoid updating msk and ssk level fields too often.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 63 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h         | 38 +++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 269d949b2025..04521acba483 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -219,7 +219,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__be32 *p32;
 
 		__entry->time = time;
-		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
+		__entry->rtt_us = mptcp_rtt_us_est(msk) >> 3;
 		__entry->copied = msk->rcvq_space.copied;
 		__entry->inq = mptcp_inq_hint(sk);
 		__entry->space = msk->rcvq_space.space;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3da3da2c81b1..1ce6b9f51ea4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -879,6 +879,32 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
+static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
+				 struct mptcp_subflow_context *subflow)
+{
+	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
+	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
+	int id;
+
+	/* Update once per subflow per rcvwnd to avoid touching the msk
+	 * too often.
+	 */
+	if (!rtt_us || tp->rcv_rtt_est.seq == subflow->prev_rtt_seq)
+		return;
+
+	subflow->prev_rtt_seq = tp->rcv_rtt_est.seq;
+
+	/* Pairs with READ_ONCE() in mptcp_rtt_us_est(). */
+	id = msk->rcv_rtt_est.next_sample;
+	WRITE_ONCE(msk->rcv_rtt_est.samples[id], rtt_us);
+	if (++msk->rcv_rtt_est.next_sample == MPTCP_RTT_SAMPLES)
+		msk->rcv_rtt_est.next_sample = 0;
+
+	/* EWMA among the incoming subflows */
+	msk->scaling_ratio = ((msk->scaling_ratio << 3) - msk->scaling_ratio +
+			     tp->scaling_ratio) >> 3;
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -892,6 +918,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	mptcp_data_lock(sk);
+	mptcp_rcv_rtt_update(msk, subflow);
 	if (!sock_owned_by_user(sk)) {
 		/* Wake-up the reader only for in-sequence data */
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
@@ -2074,7 +2101,6 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 
 	msk->rcvspace_init = 1;
 	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
 
 	/* initial rcv_space offering made to peer */
 	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
@@ -2085,15 +2111,15 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
  *
- * Only difference: Use highest rtt estimate of the subflows in use.
+ * Only difference: Use lowest rtt estimate of the subflows in use, see
+ * mptcp_rcv_rtt_update() and mptcp_rtt_us_est().
  */
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u8 scaling_ratio = U8_MAX;
-	u32 time, advmss = 1;
-	u64 rtt_us, mstamp;
+	u32 time, rtt_us;
+	u64 mstamp;
 
 	msk_owned_by_me(msk);
 
@@ -2108,29 +2134,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	mstamp = mptcp_stamp();
 	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
-	rtt_us = msk->rcvq_space.rtt_us;
-	if (rtt_us && time < (rtt_us >> 3))
-		return;
-
-	rtt_us = 0;
-	mptcp_for_each_subflow(msk, subflow) {
-		const struct tcp_sock *tp;
-		u64 sf_rtt_us;
-		u32 sf_advmss;
-
-		tp = tcp_sk(mptcp_subflow_tcp_sock(subflow));
-
-		sf_rtt_us = READ_ONCE(tp->rcv_rtt_est.rtt_us);
-		sf_advmss = READ_ONCE(tp->advmss);
-
-		rtt_us = max(sf_rtt_us, rtt_us);
-		advmss = max(sf_advmss, advmss);
-		scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
-	}
-
-	msk->rcvq_space.rtt_us = rtt_us;
-	msk->scaling_ratio = scaling_ratio;
-	if (time < (rtt_us >> 3) || rtt_us == 0)
+	rtt_us = mptcp_rtt_us_est(msk);
+	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
@@ -2995,6 +3000,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
+	mptcp_init_rtt_est(msk);
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3440,6 +3446,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..6ec65c0ae655 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,6 +268,13 @@ struct mptcp_data_frag {
 	struct page *page;
 };
 
+/* Arbitrary compromise between as low as possible to react timely to subflow
+ * close event and as big as possible to avoid being fouled by biased large
+ * samples due to peer sending data on a different subflow WRT to the incoming
+ * ack.
+ */
+#define MPTCP_RTT_SAMPLES	5
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -340,11 +347,17 @@ struct mptcp_sock {
 				 */
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+
+	/* Most recent rtt_us observed by in use incoming subflows. */
+	struct {
+		u32	samples[MPTCP_RTT_SAMPLES];
+		u32	next_sample;
+	} rcv_rtt_est;
+
 	struct {
 		int	space;	/* bytes copied in last measurement window */
 		int	copied; /* bytes copied in this measurement window */
 		u64	time;	/* start time of measurement window */
-		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
 	bool		allow_subflows;
@@ -422,6 +435,27 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return msk->first_pending;
 }
 
+static inline void mptcp_init_rtt_est(struct mptcp_sock *msk)
+{
+	int i;
+
+	for (i = 0; i < MPTCP_RTT_SAMPLES; ++i)
+		msk->rcv_rtt_est.samples[i] = U32_MAX;
+	msk->rcv_rtt_est.next_sample = 0;
+	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+}
+
+static inline u32 mptcp_rtt_us_est(const struct mptcp_sock *msk)
+{
+	u32 rtt_us = msk->rcv_rtt_est.samples[0];
+	int i;
+
+	/* Lockless access of collected samples. */
+	for (i = 1; i < MPTCP_RTT_SAMPLES; ++i)
+		rtt_us = min(rtt_us, READ_ONCE(msk->rcv_rtt_est.samples[i]));
+	return rtt_us;
+}
+
 static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -523,6 +557,8 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	__wsum	map_data_csum;
 	u32	map_csum_len;
+	u32	prev_rtt_us;
+	u32	prev_rtt_seq;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,

-- 
2.53.0


