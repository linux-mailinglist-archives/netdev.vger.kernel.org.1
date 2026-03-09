Return-Path: <netdev+bounces-265620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI2OFv/wrmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151E23C7DD
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54CB43024400
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654C3E51E2;
	Mon,  9 Mar 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aODDw/ei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724031B83B;
	Mon,  9 Mar 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071824; cv=none; b=clu7H1MX/xtltq6z/xXftyNb0F275Uy8zkQpzo3Q0CULOmiO7jc2F9yNVV34+9zIceHaxAC2tfJKOgHMYB/cA2QjYGnGTnCchpTzqKQ+lbcdi7XUx1naKKV1yrnStsoHf4h4JqLCe/7HqFyYG2RmLc19++Hi1QFUtJbaoEAUgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071824; c=relaxed/simple;
	bh=QcizqaPDX56iZ2udPtRGKDZ8CnFeyrIcP65rubKpgg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6fGDBJqvZLNwNuDT4bz1j0ZDUTgXchvpeeHp0HCe+3okWo83jalalZtF3yK2Uy1hRq5J1PphbcGVh+AljYHhKCRjYkU4nFC3Kh12YK3t0kFzepB9D0/O4TQ1XWltvUL5SjcYtuajPtXsU+8yQaM2zC7FsBWqdMBaisP2X/9/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aODDw/ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8964CC2BC9E;
	Mon,  9 Mar 2026 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071824;
	bh=QcizqaPDX56iZ2udPtRGKDZ8CnFeyrIcP65rubKpgg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aODDw/eiWkBT5PHQsVikxun/8LXefBYuw1UwWEthro6a+nu6r5S9Y0cleNLomAbq/
	 xc9sbNp9p/F6yGJ6IqBsdWOKpAF+usXSpkQXhB77DOV0X52Zq1JgaF3TNjX/z6OYae
	 o+lEZbvrPP+ygYImtHH4glJJwmGooFs/H5q5L5X1w/2kyubHmG8hK0rhquTtYnKBYj
	 eutClLEc5PqT56JyT6wPcH73cGNV0yLPumBm+OErgEKODxxGrrQceSL8mx1G0Vx57T
	 x/YVjqWKbM4H2gnI/s8L8ivWC8+CvY76CDfnCn3Bb+U2hUvqcvwgCu4xyAHwh2z0MI
	 Ea4fUAlCVRxLA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Mar 2026 16:56:46 +0100
Subject: [PATCH net-next 2/2] mptcp: add receive queue awareness in
 tcp_rcv_space_adjust()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-net-next-mptcp-reduce-rbuf-v1-2-8f471206f9c5@kernel.org>
References: <20260309-net-next-mptcp-reduce-rbuf-v1-0-8f471206f9c5@kernel.org>
In-Reply-To: <20260309-net-next-mptcp-reduce-rbuf-v1-0-8f471206f9c5@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JVrga8j7mqpvJMieK/tkZeFj1MEfF7/MpEtmOeP552A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLXvT1h6vEnp1uDQXt6j2J46o87J48uNJD20FR6ntS0R
 TroXCN/RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERWf2VkOJfx/YS5nKjmXsmV
 U9KrT6Y2l8TG/n7C+zo9VOThsUYjNYZ/pnrfXVRUD6fH8AWK725036Zw+e1vkZXu5z9+Vr4nkez
 JBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 5151E23C7DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265620-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.917];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

This is the MPTCP counter-part of commit ea33537d8292 ("tcp: add receive
queue awareness in tcp_rcv_space_adjust()").

Prior to this commit:

  ESTAB 33165568 0      192.168.255.2:5201 192.168.255.1:53380 \
        skmem:(r33076416,rb33554432,t0,tb91136,f448,w0,o0,bl0,d0)

After:

  ESTAB 3279168 0      192.168.255.2:5201 192.168.255.1]:53042 \
        skmem:(r3190912,rb3719956,t0,tb91136,f1536,w0,o0,bl0,d0)

Same throughput.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ce6b9f51ea4..5f39eafc6e87 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2138,11 +2138,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
-	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
+	copied = msk->rcvq_space.copied;
+	copied -= mptcp_inq_hint(sk);
+	if (copied <= msk->rcvq_space.space)
 		goto new_measure;
 
 	trace_mptcp_rcvbuf_grow(sk, time);
-	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
+	if (mptcp_rcvbuf_grow(sk, copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
 		 * the mptcp rx queue fast enough (announced rcv_win can
@@ -2156,7 +2158,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 			slow = lock_sock_fast(ssk);
 			/* subflows can be added before tcp_init_transfer() */
 			if (tcp_sk(ssk)->rcvq_space.space)
-				tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
+				tcp_rcvbuf_grow(ssk, copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}

-- 
2.53.0


