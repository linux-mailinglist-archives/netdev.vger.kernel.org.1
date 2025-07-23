Return-Path: <netdev+bounces-209355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9CB0F558
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004387B43C2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658932F49EB;
	Wed, 23 Jul 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+3Fcfa1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354212F4335;
	Wed, 23 Jul 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281163; cv=none; b=OyK529Izlb9zxpbXdM1vPdO1FKi6QMF7e/AuzBlk4cYI6eri0vQCLFblUkBBYSawZ2cKuEueX9V40IXypWSB0XLMk+QJMO8WWQjmlsod/J30rvS/N8HUhWdCImE/ibTFcYmj9muqkTKOXHZwPibnO5xVVr0A76m/Q+4JnvtduVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281163; c=relaxed/simple;
	bh=ILU1u+ppwprdTJTRxq61jCnaO31qDDs6Lc1SvEHJgiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcJDRIcAxlpP8xsr9Wy84Jj0uSI+ivO67Zb6FxnoXiQ8pUd8zgzVQBrTJzKP11B7OgIXEyYUQGt9XZ+DG6cRj6K+77PDJsX1wjfktlXUu24ywvUXvuwulkidf3Ev0WfmeTWthAqgPDfHctIu8EWxSi5lDL8fhAyzwCKrHv2G7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+3Fcfa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE957C4CEEF;
	Wed, 23 Jul 2025 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281162;
	bh=ILU1u+ppwprdTJTRxq61jCnaO31qDDs6Lc1SvEHJgiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H+3Fcfa165O8Pn7Sp6mtg8Tm6ZvbL6ysHL6GJP3jsYIxj+3a7yJ644EUpHe6nOm/U
	 K65QOkq5TbNB7eBcsKSmFP5UOwVq15fbXIt9UT2/WVkQgcsCrCXetWmDPP+/tLO9cg
	 gXuMawkJPYDkt6jni79hnKJozzBtVsfPYDqquQ8A0hzrsV08n2zXd7uKdsoOZfJTOt
	 3mi2r6laiZ/Y0b7h8HDozUp2f9tN0n5TTFIkkVwTzMfbfav9wcw6Guk5Igy0+C2KdJ
	 I+E0VJZO0Uht3y0imMVzm+4LZ22jeVlb42hZLL+SoJzIBTV5gARH6ZlcBX3tzBckgr
	 k7Ebi/wY/aUQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 23 Jul 2025 16:32:23 +0200
Subject: [PATCH net-next 1/2] mptcp: track fallbacks accurately via mibs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-net-next-mptcp-track-fallbacks-v1-1-a83cce08f2d5@kernel.org>
References: <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
In-Reply-To: <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10627; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kTkyp6I8LXqfTsNJYsvJTqtX41QqDm+TA17QyR22cu8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIaPrVsDG2sTG3b2rtxWYd0YMrCaSrx08PmhvMKf1jMM
 VnGqGpHRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET65zP8T6rfO5P5rvbWN+cl
 q7VFA2c0HP5juog9XWGCifD1qg6tNIb/iSL6IlMn5/3ZJ8an/bgnwXx96ZxLTKHFWQzaJtKTGvp
 ZAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Add the mibs required to cover the few possible fallback causes still
lacking suck info.

Move the relevant mib increment into the fallback helper, so that no
eventual future fallback operation will miss a paired mib increment.

Additionally track failed fallback via its own mib, such mib is
incremented only when a fallback mandated by the protocol fails - due to
racing subflow creation.

While at the above, rename an existing helper to reduce long lines
problems all along.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c     |  4 ++--
 net/mptcp/mib.c      |  5 +++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/options.c  |  4 +++-
 net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h | 31 ++++++++-----------------------
 net/mptcp/subflow.c  | 12 +++++++-----
 7 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d9290c5bb6c7956ca98319259f92b812680f74f7..fed40dae5583a35914da2cb1c52f37830d72705e 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -533,9 +533,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
 
 	if (timeouts == to_max || (timeouts < to_max && expired)) {
-		MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
 		subflow->mpc_drop = 1;
-		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+		mptcp_early_fallback(mptcp_sk(subflow->conn), subflow,
+				     MPTCP_MIB_MPCAPABLEACTIVEDROP);
 	}
 }
 
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 0c24545f0e8df95b3475bfccc7a2f2ce440f7ad2..cf879c188ca26033ff2bde458fdb8f8fb0d87769 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
+	SNMP_MIB_ITEM("MPCapableDataFallback", MPTCP_MIB_MPCAPABLEDATAFALLBACK),
+	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
+	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
+	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
+	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 250c6b77977e8f846b5741304f7841a922f51967..309bac6fea3252ae395bcfb159917cdccc35277a 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -81,6 +81,13 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
+	MPTCP_MIB_MPCAPABLEDATAFALLBACK,	/* Missing DSS/MPC+data on first
+					 * established packet
+					 */
+	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
+	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
+	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
+	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1f898888b22357be395a2fd3e585df2375c8b2d2..6cf02344249a65d00b5832ebb69dd39d6e5fe98e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -978,8 +978,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
-		if (!mptcp_try_fallback(ssk))
+		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 			goto reset;
+		}
 		pr_fallback(msk);
 		return false;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6c448a0be9495b22ced4a2b51da2f80831040aba..88bf092f230abbecddc965b4242f711a5ba9d6b6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -68,6 +68,26 @@ static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 	return &inet_stream_ops;
 }
 
+bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
+{
+	struct net *net = sock_net((struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return true;
+
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+
+	msk->allow_subflows = false;
+	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	__MPTCP_INC_STATS(net, fb_mib);
+	spin_unlock_bh(&msk->fallback_lock);
+	return true;
+}
+
 static int __mptcp_socket_create(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -561,10 +581,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (mptcp_try_fallback(ssk)) {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-	} else {
+	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
 	}
@@ -1143,12 +1160,12 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
-	if (!mptcp_try_fallback(ssk)) {
+	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 		mptcp_subflow_reset(ssk);
 		return;
 	}
 
-	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 }
@@ -3689,16 +3706,15 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
-		mptcp_subflow_early_fallback(msk, subflow);
+		mptcp_early_fallback(msk, subflow, MPTCP_MIB_MD5SIGFALLBACK);
 #endif
 	if (subflow->request_mptcp) {
-		if (mptcp_active_should_disable(sk)) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
-			mptcp_subflow_early_fallback(msk, subflow);
-		} else if (mptcp_token_new_connect(ssk) < 0) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
-			mptcp_subflow_early_fallback(msk, subflow);
-		}
+		if (mptcp_active_should_disable(sk))
+			mptcp_early_fallback(msk, subflow,
+					     MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
+		else if (mptcp_token_new_connect(ssk) < 0)
+			mptcp_early_fallback(msk, subflow,
+					     MPTCP_MIB_TOKENFALLBACKINIT);
 	}
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1a32edf6f34364eedd5d077eae7a82a7db8c3a9e..912f048994a196304a80cde90747d4a512fb3d3d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1223,24 +1223,6 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
-{
-	if (__mptcp_check_fallback(msk)) {
-		pr_debug("TCP fallback already done (msk=%p)\n", msk);
-		return true;
-	}
-	spin_lock_bh(&msk->fallback_lock);
-	if (!msk->allow_infinite_fallback) {
-		spin_unlock_bh(&msk->fallback_lock);
-		return false;
-	}
-
-	msk->allow_subflows = false;
-	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
-	spin_unlock_bh(&msk->fallback_lock);
-	return true;
-}
-
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
@@ -1250,14 +1232,16 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 			TCPF_SYN_RECV | TCPF_LISTEN));
 }
 
-static inline bool mptcp_try_fallback(struct sock *ssk)
+bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib);
+
+static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	if (!__mptcp_try_fallback(msk))
+	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
@@ -1275,12 +1259,13 @@ static inline bool mptcp_try_fallback(struct sock *ssk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
-static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
-						struct mptcp_subflow_context *subflow)
+static inline void mptcp_early_fallback(struct mptcp_sock *msk,
+					struct mptcp_subflow_context *subflow,
+					int fb_mib)
 {
 	pr_fallback(msk);
 	subflow->request_mptcp = 0;
-	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
+	WARN_ON_ONCE(!__mptcp_try_fallback(msk, fb_mib));
 }
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1802bc5435a1aaabc81e28152b0bac5656e3b828..600e59bba363f9b3350d9d65ca729cba4badb304 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -544,11 +544,13 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
-			if (!mptcp_try_fallback(sk))
+			if (!mptcp_try_fallback(sk,
+						MPTCP_MIB_MPCAPABLEACTIVEFALLBACK)) {
+				MPTCP_INC_STATS(sock_net(sk),
+						MPTCP_MIB_FALLBACKFAILED);
 				goto do_reset;
+			}
 
-			MPTCP_INC_STATS(sock_net(sk),
-					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 			pr_fallback(msk);
 			goto fallback;
 		}
@@ -1406,7 +1408,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!mptcp_try_fallback(ssk)) {
+		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1859,7 +1861,7 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		WARN_ON_ONCE(!mptcp_try_fallback(sk));
+		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);

-- 
2.50.0


