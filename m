Return-Path: <netdev+bounces-256427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHpLJ/tBgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:44:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531BDDDC3F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2667830D00FD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600AE36BCCB;
	Tue,  3 Feb 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWZYxDcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53336829F;
	Tue,  3 Feb 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144153; cv=none; b=JVCvha6P9vbn9CX98oqVv/AQ8eeJWOZe1yaXy36LFYRBKilZlIKK1AZgkgB+sfOzIpof8fz6hKjZ7YRDJocWA+NP+WpMp81dLOtozoTknZSbXdqU2kboXwXRTUrUhh/4YfWivrD1n9sw/ji5EirBNPn8qx+ujmbcPdYCJx+DY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144153; c=relaxed/simple;
	bh=+OCkWfu8cY9xgCMRuuu0qAvWIMVAGoRQDIBuHiynijM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgfG5tAAcIaFUhJ5zPWZ3KTU2m+r3C6C8RIFfQwrG+Lio/fbCj3vDqGOa8pXI9kLfcaj/sXxG0GjFU9pYs6IrozOz4o1MmpRsqIUaXdG76vYsnM6xN/22dJ2IZzJg25Rzv9/WN2UzsgNdxUUUaNu48vIzNIrfqMUVb/6+mmqiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWZYxDcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87E6C116D0;
	Tue,  3 Feb 2026 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144152;
	bh=+OCkWfu8cY9xgCMRuuu0qAvWIMVAGoRQDIBuHiynijM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kWZYxDccbcggBQpTYproM/aWIYnGhYZZ4aGFdMw8dVBzPnBlTotS5+tjmm2tfxhiN
	 o3gYlAPEYj6vFGaMIcao9UKDg+bk+Tm2wdBNkAapRpcxqWtIIgY7CkBB6I4Lo/GV8B
	 dNylxVo2wzCiIjqK06dD/9nqDl/kDBtJ9I9Rp2KBcqykOPjnjM2c4R69/ItNzPES3d
	 ppl4kRovfCBLzMAofFVDfhMvHOXDnO4rwESQW1S6HZiANL3n7S5mKznPY9DyDUMztO
	 Iys8L1MkcgfMixmgv8/QDqLv8hSEkNSF8jg6tvcgpcDYkEPPgbIPaM9w9RByW5TXgM
	 iKJC24UIns0uw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:18 +0100
Subject: [PATCH net-next 02/15] mptcp: fix receive space timestamp
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-2-31ec8bfc56d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3025; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MoP5SLOF792HbloL0vdyS1vH6Vo+rh5KyTOSAhPcS2c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHNvrF92+aBn/7tAb+azNDmHsvAt/KxT0Lexd/4Ol6
 WBT5qGPHSUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP5XcTwzfyObP3cE+2v/rd2
 /f13QGdtp5rC0u/Z21LnOpsx1zXtZPin3OzfJ5iR3is+6+wppiPux7X4itZevGPtfJzz3aOjnYy
 MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256427-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 531BDDDC3F
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

MPTCP initialize the receive buffer stamp in mptcp_rcv_space_init(),
using the provided subflow stamp. Such helper is invoked in several
places; for passive sockets, space init happened at clone time.

In such scenario, MPTCP ends-up accesses the subflow stamp before
its initialization, leading to quite randomic timing for the first
receive buffer auto-tune event, as the timestamp for newly created
subflow is not refreshed there.

Fix the issue moving the stamp initialization out of the mentioned helper,
at the data transfer start, and always using a fresh timestamp.

Fixes: 013e3179dbd2 ("mptcp: fix rcv space initialization")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 758a6dcb1d7b..8d16ed00fcb4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2087,8 +2087,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.copied += copied;
 
-	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
-	time = tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
+	mstamp = mptcp_stamp();
+	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
 	rtt_us = msk->rcvq_space.rtt_us;
 	if (rtt_us && time < (rtt_us >> 3))
@@ -3548,6 +3548,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3565,8 +3566,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.rtt_us = 0;
 
-	msk->rcvq_space.time = tp->tcp_mstamp;
-
 	/* initial rcv_space offering made to peer */
 	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
 				      TCP_INIT_CWND * tp->advmss);
@@ -3762,6 +3761,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
+	WRITE_ONCE(msk->rcvq_space.time, mptcp_stamp());
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 66e973500791..39afd44e072f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -915,6 +915,11 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	       READ_ONCE(mptcp_sk(sk)->fully_established);
 }
 
+static inline u64 mptcp_stamp(void)
+{
+	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
+}
+
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);

-- 
2.51.0


