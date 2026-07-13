Return-Path: <netdev+bounces-307188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OlSJNQ7xVGqshgAAu9opvQ
	(envelope-from <netdev+bounces-307188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67B74C1EE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307188-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307188-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFB2F300D7AB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D053436355;
	Mon, 13 Jul 2026 13:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384C436371;
	Mon, 13 Jul 2026 13:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950978; cv=none; b=VY438PAEOhoi7ge8rrP9fCsulNTEDR41HHi3PJdqpZCyv08ZTeg/MxeSRgiO+CO2bz2t/HxMOv9w+9uki13xBk9riSxzZotPd1ks8sPULaxxgnpBRJ9IM+6csx+qFUwEZ2zKZ769xWZK44LPpROZ9NONHRZ5ifS0fXn8StfOVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950978; c=relaxed/simple;
	bh=HdQvVWIF0QewG42F53OsFv81ZHZGXJ5c6OLv3z2Skrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B08Z4llSSQDJwTHjcfbNScCH8m/KZQ9wR2mABNYMmJbAZoj6yroby3BKcqpX/yNY2hgxsGTJtUKMrVid+2t/F+b5Eh7XLXRfndIuaR4SyTeOjmEiJQOSIQB4zWNWmKsw3q0xRb0sO8fLq92zfYG8rz93lpt2mylDXDo4xiszoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from [2a07:2ec0:2185:8e:915d:58c9:7d50:aa4] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjH8o-00000001XSL-1GZP;
	Mon, 13 Jul 2026 15:56:14 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjH8k-00000002OQN-1N4f;
	Mon, 13 Jul 2026 15:56:10 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: [PATCH net-next v2] mptcp: sockopt: implement IPV6_TCLASS
Date: Mon, 13 Jul 2026 15:51:51 +0200
Message-ID: <20260713135551.569365-1-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[diac24.net];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:equinox@diac24.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307188-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A67B74C1EE

The IPV6_TCLASS setsockopt just needs to be forwarded to the individual
TCP sockets, like IP_TOS is already handled for IPv4.  The code here is
pretty much identical, except there's no helper for IPv6 like IPv4's
__ip_sock_set_tos().

Coincidentally, ssh uses this sockopt and prints an error in the middle
of your ongoing SSH session when it doesn't work (very annoying when
doing SCP/SFTP on a multiplexed session.)

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
---
[v2: added guard for CONFIG_IPV6=n.  I could also add a stub for
ipv6_setsockopt() in include/net/ipv6.h, that might be prettier?]
---
 net/mptcp/sockopt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..1b83bba0b58e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -394,6 +394,39 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk, int optname,
+					  sockptr_t optval, unsigned int optlen)
+{
+#if !IS_ENABLED(CONFIG_IPV6)
+	return -EOPNOTSUPP;
+#else
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	err = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = READ_ONCE(inet6_sk(sk)->tclass);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		inet6_sk(ssk)->tclass = val;
+		sk_dst_reset(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+
+	return 0;
+#endif
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -436,6 +469,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval, optlen);
 	}
 
 	return ret;
@@ -1485,6 +1520,9 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	struct sock *sk = (void *)msk;
 
 	switch (optname) {
+	case IPV6_TCLASS:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet6_sk(sk)->tclass));
 	case IPV6_V6ONLY:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    sk->sk_ipv6only);
-- 
2.53.0


