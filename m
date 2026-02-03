Return-Path: <netdev+bounces-256428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKERGhhCgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:44:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14903DDC55
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53F3B30DB580
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2536D517;
	Tue,  3 Feb 2026 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GreDFIut"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85836D501;
	Tue,  3 Feb 2026 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144155; cv=none; b=Meut7wKl1N+DFFT2Az7kTcYZYIEVOVw4urFgmVnMtRr12n/G0YxA9ecsz2NFSgd4lsWI0p1bURA74JIV5os7HNO6xRHwuhIwtRbr96DrcVfVAnJWAKaAE0HfhQpTsdPtscR2+7t+OoTfjegc4GiGdEGbw+zbfnEmiAFLmek0EiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144155; c=relaxed/simple;
	bh=9GCOdULj2ekZTSAqQzVSQ73MCJPacE7rysZGB19znTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsKj13Btc58R3t+A9QYTplneubIwlMuSlM624xO/fQxYYj6sn8Ljs0BV+foZoT2jfA3GXLQ8lTurQKX5nWb9CEv+nr0XP18LMccfjTQv9aAWZ2ZN0iubO//rPdiBMbn0HNdHQUiypaeYFIghK5YDbQwEhBhJ8PvX398v/9RQN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GreDFIut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E29C16AAE;
	Tue,  3 Feb 2026 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144155;
	bh=9GCOdULj2ekZTSAqQzVSQ73MCJPacE7rysZGB19znTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GreDFIutuaGGpDnAT2h8Y5cJwclBJHDES9WJSvfCARcF5NxF8eAOf+ymIEoRTdZ8l
	 LN5D6XutdY2OstyTe42ZYlaLxJwLcvX/QZdNUJu8ao807Z9e4EOQCuq1jheuuEm6Mk
	 swRI7k2tXM3AqPLvrVZIB59HDCdz64XZ7zuZoqxOMqKZjkc241ard7EIDj2RK6sfeV
	 046kLccUxVN8xrvAdaz9nt5nlA17DrmFlydZdQEt91QpaIgfoyWMC34KjCDHf9JA03
	 PkhU9YeU5oIFSJR9M+rVkvJ7x2EPNlYrYlZtqpYfSq4Q2OLjJgnSiFOzCU0rKo7MaH
	 2rSklztocEsgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:19 +0100
Subject: [PATCH net-next 03/15] mptcp: consolidate rcv space init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-3-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Xk5/geeGu3geSEzf7Upa9/6/wa1cidS1DafMlsqUAck=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHNs3dK/TXda/3c2IyeKmQkJhgJ/CjzWt27ffqV0u+
 ouz5HZ/RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESuMjH8szVSyNx2QyTW9YeO
 c+WptrrdzIr997L2CQpsE5X8c7J+PiPDVp6ipxVK6zvnerXIr5918EduXPW9M2abshLXZMmeNcn
 hAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256428-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14903DDC55
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

MPTCP uses several calls of the mptcp_rcv_space_init() helper to
initialize the receive space, with a catch-up call in
mptcp_rcv_space_adjust().

Drop all the other strictly not needed invocations and move constant
fields initialization at socket init/reset time.

This removes a bit of complexity from mptcp DRS code. No functional
changes intended.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 30 +++++++++++++++---------------
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  |  2 --
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d16ed00fcb4..514272179714 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2065,6 +2065,21 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	return copied;
 }
 
+static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
+{
+	const struct tcp_sock *tp = tcp_sk(ssk);
+
+	msk->rcvspace_init = 1;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
+
+	/* initial rcv_space offering made to peer */
+	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
+				      TCP_INIT_CWND * tp->advmss);
+	if (msk->rcvq_space.space == 0)
+		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
+}
+
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
  *
  * Only difference: Use highest rtt estimate of the subflows in use.
@@ -3558,21 +3573,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	return nsk;
 }
 
-void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
-{
-	const struct tcp_sock *tp = tcp_sk(ssk);
-
-	msk->rcvspace_init = 1;
-	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
-
-	/* initial rcv_space offering made to peer */
-	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
-				      TCP_INIT_CWND * tp->advmss);
-	if (msk->rcvq_space.space == 0)
-		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
-}
-
 static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39afd44e072f..66a30409f217 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -920,7 +920,6 @@ static inline u64 mptcp_stamp(void)
 	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
 }
 
-void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 96d54cb2cd93..f66129f1e649 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -462,8 +462,6 @@ void __mptcp_sync_state(struct sock *sk, int state)
 
 	subflow = mptcp_subflow_ctx(ssk);
 	__mptcp_propagate_sndbuf(sk, ssk);
-	if (!msk->rcvspace_init)
-		mptcp_rcv_space_init(msk, ssk);
 
 	if (sk->sk_state == TCP_SYN_SENT) {
 		/* subflow->idsn is always available is TCP_SYN_SENT state,

-- 
2.51.0


