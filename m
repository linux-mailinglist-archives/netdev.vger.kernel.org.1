Return-Path: <netdev+bounces-255237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHfUJK4FfWmpPwIAu9opvQ
	(envelope-from <netdev+bounces-255237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:25:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C4BE19A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04AF6304A890
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A938886E;
	Fri, 30 Jan 2026 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra0Kxnn+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417138886C;
	Fri, 30 Jan 2026 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801084; cv=none; b=TZpN7KyApsp90XfckpxeDIJDbfV95xtVOwozoR7qjuMlU5xVkKxlOE3xFwAj8K4SmKMjbp481og6pDf8LLysAw0p8TZrsuJaabEKx2AtT/Tczzzr9mbt/E6C+WNw5JqeqBNlka1tyBs1qL3pbxzhcWoz+Jk9keZ5mEfgby3+8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801084; c=relaxed/simple;
	bh=EAuYMbBxbAMoilMPoZHDPGbeVZ7tT76pM+ENAAXn57s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ajgpf+Oq7TjTpjxIs7NVMSDW4gAPx1Mb6JlrnikXN8Q3V6jFjYvOq8cGiOF27Ih9AVi8uT2wc+kKdJHXLEq7F3m9xrn15NsOlurS6G0gJ0BSq+PBOB8Lk7AWs51v+ZXr3ydyFuoU2AMvlZ2CgjUWV4AczMyH5774KtckAGpW6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra0Kxnn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0FAC16AAE;
	Fri, 30 Jan 2026 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801084;
	bh=EAuYMbBxbAMoilMPoZHDPGbeVZ7tT76pM+ENAAXn57s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ra0Kxnn+NhZ+jCx42HQT+y/3koRF2uQt8nT1jZgTJHkTz39tL7QcQkxfyQCUIK2wt
	 asTSIsXxFrqnDYOMKtGT6mwm4W8hc+Dx84Ffi8UvxW4viomq0Cy4K1856RgLm8ml88
	 /w7kKGeCIMzXaulo1LpPth7cfaOB+ukMMyJqnEtgiKWQC0mptcIUZc9/FMnbTZ097R
	 n4MYIXzVLtw9dZWFYLjk8jO0StJeCelA78JshPPPmlhAPLjHJGdgTCCzcbvyTWeY7u
	 OuF3O/GWUCuuE2bQ8lxtlTA8MWacyr/nx9uk7OO1WY0le8aPVkXwvJvMC3f1zNq9UP
	 +hcXO0XN57j5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 20:24:24 +0100
Subject: [PATCH net-next v2 1/6] mptcp: add eat_recv_skb helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-net-next-mptcp-splice-v2-1-31332ba70d7f@kernel.org>
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/OxdgJ9BuCWlHWdJ6t8N6yU/MrKYs3xo5CWQUzxfqpY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWYuzVx3QNPlQECyR+etWkNq9V5ymh1dW2S+a+v6Yi
 1Rx7wrLjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImE72D4p3ouZUL5BetF65xb
 ZXbeMfz4oTgiebonX337hNiJFo92/2JkmKjwoOXyP5NvGj3N4Wv/N/+d4O3Y6tUmYb/3zr5JR1Y
 s4wMA
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
	TAGGED_FROM(0.00)[bounces-255237-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F3C4BE19A
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts the free skb related code in __mptcp_recvmsg_mskq()
into a new helper mptcp_eat_recv_skb().

This new helper will be used in the next patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d3233667418..5eb2a6182d4b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1995,6 +1995,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
+static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	/* avoid the indirect call, we know the destructor is sock_rfree */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, skb->truesize);
+	__skb_unlink(skb, &sk->sk_receive_queue);
+	skb_attempt_defer_free(skb);
+}
+
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
@@ -2049,13 +2060,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				break;
 			}
 
-			/* avoid the indirect call, we know the destructor is sock_rfree */
-			skb->destructor = NULL;
-			skb->sk = NULL;
-			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
-			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			skb_attempt_defer_free(skb);
+			mptcp_eat_recv_skb(sk, skb);
 		}
 
 		if (copied >= len)

-- 
2.51.0


