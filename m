Return-Path: <netdev+bounces-256426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCoQFXpDgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:50:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E723ADDD9A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29A9314DC81
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53B36A00E;
	Tue,  3 Feb 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEGpyeaW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9E369986;
	Tue,  3 Feb 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144150; cv=none; b=YzYSBICbkCsEFox6P/rCKE1dBiZxiMIDMgrBuGrzOXqPMqn3aaUJX2tjdL+BUp0148WaP7E9Vj+DxO1w8n5O5LnfFArSebWnwi3tgXExEA1boZwWUUpUis/WeHSMILn675Hkv6lik34kMOfhAS5KooCdmWHxMORtlYt9WizbFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144150; c=relaxed/simple;
	bh=J/P15HbfuSoE8lt6sijPPvwzT4M23Td6lzf4h2apry0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8U3n99+cvM90oBzIg5AeJiuXDbLbimkHCJMguxrkUOodviz52CYB1S/dRCxHVnfX/123hhANfVKrk8BPFAVc0bMaid3QKfXyIoczPhdAP+S4oRLMHZCBNAyq7Q840XpVt+XKh3mDaDq/B/X2DP0PFLNCeILfss2/zdn/TVIhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEGpyeaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B457C2BCAF;
	Tue,  3 Feb 2026 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144150;
	bh=J/P15HbfuSoE8lt6sijPPvwzT4M23Td6lzf4h2apry0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jEGpyeaWpuyHoVBBoI4lv2F5BJKG9CKn+YtszbSo1voJPgyBZGgRQ+MMHpFQiOLHP
	 f5dXb0CKPD3wU6R0LCdpb7LRt0JaISlEdQMxkmNrtrrHRXNS/77FO9QVkkL4LXcv4L
	 KmicyOeL+dyT+ZeCcmsh00coKGBEHzz8lsKGCD/6otXh8BwpwTOEyjAaCRblQNGDcB
	 hIEIccSqT3MgcPs/bNtn7KTcXm7Udr6dZsMNRqyKPg6N4bEiV1ilxL+iCIg6mUw/q6
	 B4xTnAueWsXnSZsgFsAsDYqeDQzKZHHwNLpqCXS4tHaImbeTu7knsZIZ7gO6oS4jUX
	 sXzcTdvIwZXHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:17 +0100
Subject: [PATCH net-next 01/15] mptcp: do not account for OoO in
 mptcp_rcvbuf_grow()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-1-31ec8bfc56d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CbsfyB67YXLsMtJK7SY+2EgWj6AvCWSjVBq529b3u64=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHNvs362bpzp947zpXK28JWfMLf5wLH114dWn5CsiP
 z0fLuqU7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhITQHD/8S0KSKzrY95yq1c
 93AxP4vYU2+2YAle8U+7/i9ZkHU/5jQjQ7N+P++NlsQ+pwMrU12dOPYL6LglfA/xapGw/F9l9Nq
 SHQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256426-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E723ADDD9A
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

MPTCP-level OoOs are physiological when multiple subflows are active
concurrently and will not cause retransmissions nor are caused by
drops.

Accounting for them in mptcp_rcvbuf_grow() causes the rcvbuf slowly
drifting towards tcp_rmem[2].

Remove such accounting. Note that subflows will still account for TCP-level
OoO when the MPTCP-level rcvbuf is propagated.

This also closes a subtle and very unlikely race condition with rcvspace
init; active sockets with user-space holding the msk-level socket lock,
could complete such initialization in the receive callback, after that the
first OoO data reaches the rcvbuf and potentially triggering a divide by
zero Oops.

Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9b8c51937eb2..758a6dcb1d7b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -224,9 +224,6 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	do_div(grow, oldval);
 	rcvwin += grow << 1;
 
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
-
 	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
 	rcvbuf = min_t(u32, mptcp_space_from_win(sk, rcvwin), cap);
@@ -350,9 +347,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
-	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
-	if (sk->sk_socket)
-		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
 }
 
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,

-- 
2.51.0


