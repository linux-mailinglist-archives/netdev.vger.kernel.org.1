Return-Path: <netdev+bounces-274995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lx6D+Kkz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-274995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C0393B24
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD5293017311
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58093B892F;
	Fri,  3 Apr 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKwhqtuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B43AF67D;
	Fri,  3 Apr 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215800; cv=none; b=P3YsQPNhgiVBebBrYBkC7r/rjXtrcJpb6OyHasPlS11+NEW58m6Pvefv/xAzk8IYUeSOLHMyRcHtTdA6eQ6FtNvvtUECSY14x2/jBOiuAvm4QWx97pqk+rihqxkB/Bw0M79FoccTha+qUrA4o6bQmNcSEIAhIkPrUuA01dhLqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215800; c=relaxed/simple;
	bh=1OnAPENA2MFXmmi1fleaN8fDNv5hNv73y70P39B3O0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo2C/icXZcb4b1LgZ/j9O6odo/fODrqUZGPMQbCrg8HhKYuMYbzNOaNwfGJIhYKr2oIsbUo/EbYtmXK6v7zRlmlRIksb/TG5Z6Jvyb1v4f7q4HCxDmoiAlndAf+/SIWeBJXxNixA1KT06XJXdVzsRacLr659t2TsjyrPqYRpayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKwhqtuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50873C19424;
	Fri,  3 Apr 2026 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215799;
	bh=1OnAPENA2MFXmmi1fleaN8fDNv5hNv73y70P39B3O0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WKwhqtuCxfDBmUIWyFVeqJg+aWV829JhYhOzsJ/WlyfV3fZrYXY67EqoyaeSrLrat
	 z7ECfxn51FaMirwGQRa75BEtJ2nGab9kwz450unzVdEEj1xfBgzyXVJackvsWMbOe0
	 1p9Lim5pw7PHBXXYxxsyfZ2s3rWsaZMGo5NVR9g1VDfyrdwO9CyHXn9JoUTG9WUB6C
	 UwjbRxn81TbKZbu8Rn5j2A5E0JUQ2/h7UqoxUmt+CgRtvVZYHJfg70iirxvF5/hNef
	 Rb8XismDdsCqLXlGcGYcgeGGqPAPQi/eiST55RHT9qH6WIiQ6hevZqs0ja8wr8b26O
	 +vgF8WYF4oXWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Apr 2026 13:29:29 +0200
Subject: [PATCH net-next 3/5] tcp: add recv_should_stop helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-net-next-mptcp-msg_eor-misc-v1-3-b0b33bea3fed@kernel.org>
References: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
In-Reply-To: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RqCCycHW2v6owPV/xj3gdIsfqbGE+49RDNfHEJrfcLY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL1kd/Suu86QCR83OhBdTauySTm1O7Hq7SzVX9VHkE
 Yab9ZyOHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOR3cjwPzZxm9c24RlH/v1O
 9hRuuNP5/NiZR5vD6qfyeBluUffY9IqRoetbulJAopJsvdDUBoYvUSxhfxinHF5+zdit6W5woXE
 bMwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274995-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 693C0393B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
and tcp_splice_read() to check whether to stop receiving. And use this
helper in mptcp_recvmsg() and mptcp_splice_read() to reduce redundant code.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Neal Cardwell <ncardwell@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h    |  8 ++++++++
 net/ipv4/tcp.c       |  9 ++-------
 net/mptcp/protocol.c | 11 +++--------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 565943c34b7e..6156d1d068e1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3077,4 +3077,12 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline int tcp_recv_should_stop(struct sock *sk)
+{
+	return sk->sk_err ||
+	       sk->sk_state == TCP_CLOSE ||
+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
+	       signal_pending(current);
+}
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bd2c3c4587e1..e57eaffc007a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -888,9 +888,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk))
 			break;
 	}
 
@@ -2755,10 +2753,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 
 		if (copied) {
 			if (!timeo ||
-			    sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    signal_pending(current))
+			    tcp_recv_should_stop(sk))
 				break;
 		} else {
 			if (sock_flag(sk, SOCK_DONE))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e21e416cd19a..2f4776a4f06a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2333,11 +2333,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			break;
 
 		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
+			if (tcp_recv_should_stop(sk) ||
+			    !timeo)
 				break;
 		} else {
 			if (sk->sk_err) {
@@ -4520,9 +4517,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk))
 			break;
 	}
 

-- 
2.53.0


