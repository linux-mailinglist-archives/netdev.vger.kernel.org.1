Return-Path: <netdev+bounces-137540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB529A6DD2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D836B21A9E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA61FAC54;
	Mon, 21 Oct 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVIj5Nas"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DA1F9410;
	Mon, 21 Oct 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523675; cv=none; b=r6pjtziY42uTkpUTVhxb+Urbbu4twSC1KDsIfkRonvmkzcDELCQxHJgQZMnE1pT7geQXLpbUHt0rIrtbpCpIzlQhQDrXZJT4IiGcCQXWsgggNmWUYgx83ZoSwy+yLoam5vXmcaoYZr6xVLd36A/52tVlEckGJLtTjobop+XJYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523675; c=relaxed/simple;
	bh=vWvfcGb12DAvG2TbXrEaAfKBZiWX/4a2tEa1csyld2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvC7xfvtbXrTQ/Z54YzKTXorle90ncM3ZDz3l9xVLXFhudXh295kSomSSDeCZLvEiLyOJSBe83Cqzc8wfFZbVX4iiEJx2c9klF5LmSWUHa4i97bbm1F4bvUkUFHF7eOGXfQyC76/LbLUQ7TiilBOoUwET0/dAup0CdVCRZdPAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVIj5Nas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E231C4CEE9;
	Mon, 21 Oct 2024 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523675;
	bh=vWvfcGb12DAvG2TbXrEaAfKBZiWX/4a2tEa1csyld2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVIj5Nas6qg2VuGaA6lYMSp4x7AKP7uCXodmDOLIqWeorU7a9uAEWRuLfpoyzQdyI
	 AtvRwqgfQMmo2swkv0EN/Eh6onC6b3GzPV12lMQV8N3u5LelYgDcDxnFCNvzRfT+u/
	 fJAQ6AhecnEmgzXA5HOABTxF2EjQfiq2KhDZ5Bb5L28HMHQsHzQVqwOyQlqUqvzFe5
	 ivHI8aKaHfgHr2fljyFd4rv7nF/Vvmupjl0JR9S69aLhBHakuASwNrFvOfPeoilD7E
	 /Eg3ewf2CfI5Ah9vJ/6n4Gbl625gb4Ss0FG1UYP3iQ/hXVYpuHD8GkBwT9uRKvoMyq
	 nozhB2V+ZR6Ww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 17:14:04 +0200
Subject: [PATCH net-next 2/4] mptcp: annotate data-races around
 subflow->fully_established
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5751; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vNuVsHRC0SorCnDtGnHFJS65pDzO9H/fv+K3NOkTUQ8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFm/Sd0aZnbkx11rc+2lc/1xp6j6LPLwKct9KL
 YC+zEHLE9CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxZv0gAKCRD2t4JPQmmg
 c+N0D/9NpROylZw9WFV8780QF5og6BYKr816P4j+R9/UYOEcwLUCnVrRQkp4NRT0ojQdroqAYuf
 dGrNepr4/WY/1HOQezTFEDdb7TlUk7/4xAX//YdHPJb4yD80E9IaYFhNTU0Qqzokw5K1ChKhQLY
 WksOm0O23jEXQjIywIojAZ4j1gPxuO7m674YzHBcMauIjeks72YwyriWRdOFfTvz7tAIu7N8Hzq
 ZmsevHIJnjp5gX0Zh3icItCnDC5WY3rFoInLX/MUwTpVK08FnTwTiJJCs5yn7ojHcsrGFFc5gGc
 qsxXJyHPITL7fKO3NXD07rHVy0hnPBgI7DK/7bcbakMpm96w4SrVSwkn6IbLFKdTmWNDrMSjd+P
 8akZ+jx3S1kko/AtKhiYU8IIquqJWMfR3BcUB0Gt18KC3/ubFJfM16LXZm/8uklXRE3sCZXb553
 zJfGcrtTOD2fApJlddjBg1q0DXZ753Tq6uHFE5h5Zw9WpuaiI7dFLeRf9lkVgqivLV6t1tJQyrH
 EDDauSWdxdtXNUN14hMutyCLwyCf1aNYm5vsb1hdO646IGgvvHA6FJrQ9yAOkpoG60LyGvCtS5H
 Y0URh/Kw4ZvlOWiycIykB3bQK8ZJ5SGJW4iRRIdk39R/Y1HfYhFDH2alEqNhi0uRXUYaBEG1Yms
 YrJbgH3QGq40Jng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

We introduce the same handling for potential data races with the
'fully_established' flag in subflow as previously done for
msk->fully_established.

Additionally, we make a crucial change: convert the subflow's
'fully_established' from 'bit_field' to 'bool' type. This is
necessary because methods for avoiding data races don't work well
with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
the size of the variable being accessed, which is not supported in
'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/diag.c     | 2 +-
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 6 +++---
 net/mptcp/subflow.c  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 2d3efb405437d85c0bca70d7a92ca3a7363365e1..02205f7994d752cc505991efdf7aa0bbbfd830db 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -47,7 +47,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_REM;
 	if (sf->request_bkup)
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_LOC;
-	if (sf->fully_established)
+	if (READ_ONCE(sf->fully_established))
 		flags |= MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
 	if (sf->conn_finished)
 		flags |= MPTCP_SUBFLOW_FLAG_CONNECTED;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 370c3836b7712f4ca97c99d35a20e88e85a33d70..1603b3702e2207f191fdeef2b29ea2f05fd2b910 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -461,7 +461,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (subflow->fully_established || snd_data_fin_enable ||
+	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -930,7 +930,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(subflow->fully_established)) {
+	if (likely(READ_ONCE(subflow->fully_established))) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f5c63eb21f0db92341ec941cfe2aec919cdd3de..a6c9661a4c45a00e982d0f68f21621c3cf33469b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3511,7 +3511,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (mptcp_subflow_ctx(ssk)->fully_established)
+	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 568a72702b080d7610425ce5c3a409c7b88da13a..a93e661ef5c435155066ce9cc109092661f0711c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -513,7 +513,6 @@ struct mptcp_subflow_context {
 		request_bkup : 1,
 		mp_capable : 1,	    /* remote is MPTCP capable */
 		mp_join : 1,	    /* remote is JOINing */
-		fully_established : 1,	    /* path validated */
 		pm_notified : 1,    /* PM hook called for established status */
 		conn_finished : 1,
 		map_valid : 1,
@@ -532,10 +531,11 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
+	bool	fully_established;  /* path validated */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -780,7 +780,7 @@ static inline bool __tcp_can_send(const struct sock *ssk)
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
-	if (subflow->request_join && !subflow->fully_established)
+	if (subflow->request_join && !READ_ONCE(subflow->fully_established))
 		return false;
 
 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6170f2fff71e4f9d64837f2ebf4d81bba224fafb..860903e0642255cf9efb39da9e24c39f6547481f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -800,7 +800,7 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       const struct mptcp_options_received *mp_opt)
 {
 	subflow_set_remote_key(msk, subflow, mp_opt);
-	subflow->fully_established = 1;
+	WRITE_ONCE(subflow->fully_established, true);
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
@@ -2062,7 +2062,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
-		new_ctx->fully_established = 1;
+		WRITE_ONCE(new_ctx->fully_established, true);
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
 		new_ctx->request_bkup = subflow_req->request_bkup;

-- 
2.45.2


