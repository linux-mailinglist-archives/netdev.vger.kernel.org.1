Return-Path: <netdev+bounces-275908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yATFGDvE1GmmxAcAu9opvQ
	(envelope-from <netdev+bounces-275908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:45:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E793AB7B6
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75F1130173A9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DFC3976BC;
	Tue,  7 Apr 2026 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb2iJeEd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5B23BD02;
	Tue,  7 Apr 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551536; cv=none; b=DDyRYmWidzH78OdnAB4HKYUZyif+w8HrJNmiuwl58MN7Xf9z7mrwotc+UVWrzWb53wudTJgOUEPvDj4A9LMHFoyFzJSU0JDUljxTXL6xEtagJN8n2GdD37RRok5j2uSP+wq0w9A7pHMrCbqQ/V5Gr+C/DQPqw5SYAOVCjilmu5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551536; c=relaxed/simple;
	bh=jP384dQlBm7+0SCO5ZJJaXjoRU3u3jjXCp1U5aJbLo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfz5cPMy2KFDq8KsyIL3paitNx0OumQLaQZZSgM1HNQSjn8TtUVs/rJjGcNcLZNBfouGUY+ylIuDq/xN131SKGtQD8GgZ0zS0Ab2JxKOnusDgJIFOj6RvjJw6xakz+gb8eeZlDROcNQr06ya1OWY9KVNrhCRoMIGiVdKHensYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb2iJeEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF9BC2BCB0;
	Tue,  7 Apr 2026 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775551535;
	bh=jP384dQlBm7+0SCO5ZJJaXjoRU3u3jjXCp1U5aJbLo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nb2iJeEdChdUoqnpL4dn8Po8wCxct/AC3BXmA2qrr6zCu1g0XF+hiMegDWpkaykLO
	 NHyYeRoAN9tphKjWrpP8SJtkNqcYQXsIT+WDRVtAsC0A8NSDvORu6FBshy+f6Vop0j
	 y+9/9ZvsXq8VU6przpU/QOsjwPe1ZGpLdNSXxduQxYS/jWzFdV+MGklBiszFiTAPah
	 wk2h1nOoSRUIs5xBcaiSXLomM5uacga4tdEx91TKcv005AJneogEzQIH6V7LgWh50d
	 +F0BMP7GeH0KxXFTvyf0vxRzcQLCpR98dXTGcn5mNPXO92A5XBo8E8mt3PHA5LtyDj
	 bx/YrcvmI29lQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Apr 2026 10:45:18 +0200
Subject: [PATCH net-next v2 2/2] mptcp: add receive queue awareness in
 tcp_rcv_space_adjust()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-net-next-mptcp-reduce-rbuf-v2-2-0d1d135bf6f6@kernel.org>
References: <20260407-net-next-mptcp-reduce-rbuf-v2-0-0d1d135bf6f6@kernel.org>
In-Reply-To: <20260407-net-next-mptcp-reduce-rbuf-v2-0-0d1d135bf6f6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eOqSciaPlrzR/1urNztuxAJVnNevqkTWpXp6w0WWmR0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKvHFGPLnBLWsywxHa2C/tBrnq/4zfkjNR2Olr9XLqqZ
 dL50osPO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbCe4+R4Zh3yXvT8sw/U+a3
 npMyXNb4U4t1ZWIfO2/Bsc93m0tqJjIyfFfadcawbNmDtARDWwOX2Uf0lsj5/d5VU1qk0rxH0/I
 XKwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275908-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
X-Rspamd-Queue-Id: F3E793AB7B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 70a090a95299..cf5747595259 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2159,11 +2159,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
@@ -2177,7 +2179,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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


