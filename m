Return-Path: <netdev+bounces-276211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAanCRKe1Wks8AcAu9opvQ
	(envelope-from <netdev+bounces-276211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:15:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C13B5A62
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D09FF303CEA3
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D2824A3;
	Wed,  8 Apr 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXkLPgkI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BC72622
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607287; cv=none; b=SC1wO2eG3xU7IT70CVVeCFRqGjV6MBmp3XMo+PIdHhzn/rIedni9HbW3UFGbP50Y+aOZbSH/J8tIF+r420c/dpvkr8PAsVDylQIsl530lWs/njzmZ8ir07h5OOEwnbfEscdx927z/h++13tJJj+lQt5zgSqke07dVfMt+4Rm/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607287; c=relaxed/simple;
	bh=RlcBW6btoneoDWJyHfe5EPeMBgqYFr08yWwXe64+V3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrAR6VHV7rsDkOC/WCJcJE+WkVrUNa9nX/ryOoEan9m8xh56Z1ULPZBWtHTsy/bFonLV/TbcVbhnT/dw8QssHsoX0hYe+BtgFnSKvIgVqV6yY20mQGfBMseZHzR9sbUFSEvNqcnZpb8G8lQ+UZgOHQQ6VT2u1WjA+sqdh20UlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXkLPgkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2666EC2BC9E;
	Wed,  8 Apr 2026 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775607286;
	bh=RlcBW6btoneoDWJyHfe5EPeMBgqYFr08yWwXe64+V3g=;
	h=From:To:Cc:Subject:Date:From;
	b=jXkLPgkITwIavfJmFuOKo15RYUOTbKv9arjeBo/BEoQXZ8LRWFjldhjoBUI4uZz7h
	 po4C+A0VbJgJXaNqYgDyxPufv1H8lfg3FIcs6vsKW8MgXcb12u+wz3yfv4hggRXZ1o
	 12Pl/0XARtrpNqSdGhalTuPHlv0+xW0w9YJiwfvDfv+UFTqFq/Fd1XdiktoJWMgnWj
	 FTRp/ohQ/bT18XH/hfXRioVPNOybB8Bi7Q7WdZZfnPA+N6+ZlvqvyBPbAjTnF8iSha
	 WdXbHMBCL+d8SmTXD0gqeKeDeR2A87CKWsMoYYusk7x5uPsH4KYoD00/t0Zje27yWx
	 z0PXbcA8EMCig==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ncardwell@google.com,
	kuniyu@google.com,
	willemb@google.com,
	dsahern@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com
Subject: [PATCH net] tcp: update window_clamp when SO_RCVBUF is set
Date: Tue,  7 Apr 2026 17:14:38 -0700
Message-ID: <20260408001438.129165-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-276211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A13C13B5A62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit under Fixes moved recomputing the window clamp to
tcp_measure_rcv_mss() (when scaling_ratio changes).
I suspect it missed the fact that we don't recompute the clamp
when rcvbuf is set. Until scaling_ratio changes we are
stuck with the old window clamp which may be based on
the small initial buffer. scaling_ratio may never change.

Inspired by Eric's recent commit d1361840f8c5 ("tcp: fix
SO_RCVLOWAT and RCVBUF autotuning") plumb the user action
thru to TCP and have it update the clamp.

A smaller fix would be to just have tcp_rcvbuf_grow()
adjust the clamp even if SOCK_RCVBUF_LOCK is set.
But IIUC this is what we were trying to get away from
in the first place.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ncardwell@google.com
CC: kuniyu@google.com
CC: willemb@google.com
CC: dsahern@kernel.org
CC: quic_subashab@quicinc.com
CC: quic_stranche@quicinc.com
---
 include/linux/net.h | 1 +
 include/net/tcp.h   | 1 +
 net/core/sock.c     | 9 +++++++++
 net/ipv4/af_inet.c  | 1 +
 net/ipv4/tcp.c      | 5 +++++
 net/ipv6/af_inet6.c | 1 +
 6 files changed, 18 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index a8e818de95b3..ca6a7bc5c9ae 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -223,6 +223,7 @@ struct proto_ops {
 	int		(*sendmsg_locked)(struct sock *sk, struct msghdr *msg,
 					  size_t size);
 	int		(*set_rcvlowat)(struct sock *sk, int val);
+	void		(*set_rcvbuf)(struct sock *sk, int val);
 };
 
 #define DECLARE_SOCKADDR(type, dst, src)	\
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6156d1d068e1..b9db447892dd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -516,6 +516,7 @@ void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
 int tcp_set_rcvlowat(struct sock *sk, int val);
+void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
 
 static inline void
diff --git a/net/core/sock.c b/net/core/sock.c
index fdaf66e6dc18..f3a186376bc5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -973,6 +973,8 @@ EXPORT_SYMBOL(sock_set_keepalive);
 
 static void __sock_set_rcvbuf(struct sock *sk, int val)
 {
+	struct socket *sock = sk->sk_socket;
+
 	/* Ensure val * 2 fits into an int, to prevent max_t() from treating it
 	 * as a negative value.
 	 */
@@ -990,6 +992,13 @@ static void __sock_set_rcvbuf(struct sock *sk, int val)
 	 * we actually used in getsockopt is the most desirable behavior.
 	 */
 	WRITE_ONCE(sk->sk_rcvbuf, max_t(int, val * 2, SOCK_MIN_RCVBUF));
+
+	if (sock) {
+		const struct proto_ops *ops = READ_ONCE(sock->ops);
+
+		if (ops->set_rcvbuf)
+			ops->set_rcvbuf(sk, sk->sk_rcvbuf);
+	}
 }
 
 void sock_set_rcvbuf(struct sock *sk, int val)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index f98e46ae3e30..0e62032e76b1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1091,6 +1091,7 @@ const struct proto_ops inet_stream_ops = {
 	.compat_ioctl	   = inet_compat_ioctl,
 #endif
 	.set_rcvlowat	   = tcp_set_rcvlowat,
+	.set_rcvbuf	   = tcp_set_rcvbuf,
 };
 EXPORT_SYMBOL(inet_stream_ops);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e57eaffc007a..1a494d18c5fd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1858,6 +1858,11 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	return 0;
 }
 
+void tcp_set_rcvbuf(struct sock *sk, int val)
+{
+	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
+}
+
 #ifdef CONFIG_MMU
 static const struct vm_operations_struct tcp_vm_ops = {
 };
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ee341a8254bf..0a88b376141d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -690,6 +690,7 @@ const struct proto_ops inet6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = tcp_set_rcvlowat,
+	.set_rcvbuf	   = tcp_set_rcvbuf,
 };
 EXPORT_SYMBOL_GPL(inet6_stream_ops);
 
-- 
2.53.0


