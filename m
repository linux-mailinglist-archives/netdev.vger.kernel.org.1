Return-Path: <netdev+bounces-168609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE9A3F968
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868CD19E25E0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908B213E9C;
	Fri, 21 Feb 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7BO3Q/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF10213E89;
	Fri, 21 Feb 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152675; cv=none; b=rbrx+wLkGwHT8b2MHRn/FPqv4PcFiqTqHHr96k01CGwZy64tOF2XWj+AuLM65lNerTctITCDcuOcIMFVi9c0P8f77TGyfUeEgOC/n7mEKOkff8xEJjijZqvCCUEJ256wL/CSM+byUWjdqWnekoY0mllxntoRGKnEyfR0Fg3Dulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152675; c=relaxed/simple;
	bh=Wom1Z6Yf2iTnch8UEgQeD2janPDVRVMz/fyDLs5de9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXuVpbaHswLJd6e59epX4B/X+S5TFbA0cQL3axOQn9l5foN0n0pYEUxbLTl/P0P9mIlKvkH6BKw+T+0Xa1jZn5LxwMM4MEEI0r9bYEV7MdMEhlypdmpZndXznFLeSCgDsM23O7SO7mpNz8OOSVM1Bn5Qiclq46cBscDMB2OETno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7BO3Q/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E13C4CEE4;
	Fri, 21 Feb 2025 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152675;
	bh=Wom1Z6Yf2iTnch8UEgQeD2janPDVRVMz/fyDLs5de9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S7BO3Q/APfHsjQjaGHhS6sHXal6pvXJL3tKyA9mwHcbqfwMupAlmEGCcnbUR3RaqV
	 8/ER9Rj6bzcQQ8FENb+UhBWF28zoo/RueVMGSo6/W8X4rMUyObRPNPSekg9OfqXgbb
	 1EfxbO/hehgtEi2ydPYS5ny8trrUYpdpaSEZNipj/ikyZ/aI6Gcpp3r9KwuZ5cOAk3
	 zrGfo5mYGmi1z1JSsZcARaD977xmvtYOHte1pIAH9lK0dhfRIGIfP78Uutt/jAyIo7
	 MD7DE7h1po+DcuGLwnfWJRyEa89JeaFhmFTOJ5bdYn0zE5PCNABauuq5IogoKL8Dp4
	 Mpys5VwqVdUCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:44:03 +0100
Subject: [PATCH net-next 10/10] mptcp: blackhole: avoid checking the state
 twice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-10-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Wom1Z6Yf2iTnch8UEgQeD2janPDVRVMz/fyDLs5de9w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HgoWs/Elej6GEIci+QQQIkFOFv8zV3mfAb
 Do2FbfkzCOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c7MhEACYVK1iUWhT53jM4LB417iKAbXrfjFNNb2JFET8a4PSK9fs4TBD+tIOzJbbCG0aDoj/6Th
 xWt3rzxPgiLe/r18Jad51x+gS0y90kmjVD8YV/YzACS3h6c7OsMH0C6UyEzWFBFR9DZ0biFUdSB
 nViI+AlfoJ9t/aCL6cVHvsdUm2r+/B28heR2VHot7m+56CiMadgxmLbmBeRrva+qa7WlEy987we
 49I/C4zd4umS1+93fH9nInTokAsIC3t9GmO/ipT6g6OSYtaoF/XWie9+jSLSQBf2cdsJ0uM0cOV
 7rxPvEfBlxCdX2vniOft69WFpMdmt3CEWOyDlyyKk6nu9jA0TAhx1cSBYI95UxwyS/f4onIvMHw
 yTQ1/WQ7Uw2rxR2WGqnKqriq17B4ZI1TmQnkL4D8CKM0egodgMoGtkGgTORcUsAtIiS7BLxhNCX
 EDeaXDI2EMnUlmTKioeANfDE2hIkPIt+tp2+/ixplrRuIPuXfJOAmSBWQf6sx3HdhEOsmqS/g9T
 Uf6jfyo3Qby7p8AkwcUfOCgugKbHQeUsZSeXir6YVYisQ8tAAsCAOdmso/XLkRa+FdhcFxFWr2A
 0vo6ImkjP9qj43KtE5og7+rjf5SAnnTjWRjQN9/c8uRyzMq7l7Pjr2LVImADND0oH6m8cjjcjjU
 JgRU7GD6zSSEHWA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A small cleanup, reordering the conditions to avoid checking things
twice.

The code here is called in case of timeout on a TCP connection, before
triggering a retransmission. But it only acts on SYN + MPC packets.

So the conditions can be re-order to exit early in case of non-MPTCP
SYN + MPC. This also reduce the indentation levels.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb..be6c0237e10bfd7520edd3c57ec43ce4377b97d5 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -401,26 +401,30 @@ void mptcp_active_enable(struct sock *sk)
 void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 {
 	struct mptcp_subflow_context *subflow;
+	u8 timeouts, to_max;
+	struct net *net;
 
-	if (!sk_is_mptcp(ssk))
+	/* Only check MPTCP SYN ... */
+	if (likely(!sk_is_mptcp(ssk) || ssk->sk_state != TCP_SYN_SENT))
 		return;
 
 	subflow = mptcp_subflow_ctx(ssk);
 
-	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
-		struct net *net = sock_net(ssk);
-		u8 timeouts, to_max;
-
-		timeouts = inet_csk(ssk)->icsk_retransmits;
-		to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
-
-		if (timeouts == to_max || (timeouts < to_max && expired)) {
-			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
-			subflow->mpc_drop = 1;
-			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
-		}
-	} else if (ssk->sk_state == TCP_SYN_SENT) {
+	/* ... + MP_CAPABLE */
+	if (!subflow->request_mptcp) {
+		/* Mark as blackhole iif the 1st non-MPTCP SYN is accepted */
 		subflow->mpc_drop = 0;
+		return;
+	}
+
+	net = sock_net(ssk);
+	timeouts = inet_csk(ssk)->icsk_retransmits;
+	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+
+	if (timeouts == to_max || (timeouts < to_max && expired)) {
+		MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
+		subflow->mpc_drop = 1;
+		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
 	}
 }
 

-- 
2.47.1


