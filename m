Return-Path: <netdev+bounces-164071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30564A2C8A9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493DD18870E3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D618DB07;
	Fri,  7 Feb 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6TtZf/D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03418BC20
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945447; cv=none; b=j2f4q2N8oSjOl6MEwKMX1gye2s57ekar5HkZ6ApQxbN/62Sps2zruCFIxzwm+cgeZ1BGrULwPNge/aNOAhb8RZVxNvNO2XamGdl09cVNgmeUGANuCbRt48FAO1nWr4TcG0AageSVQiLGlf7ett2w4lJHVYcgPlNRzSPi8MsW4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945447; c=relaxed/simple;
	bh=4BBsHN86e7caVuXXG+SXOQkMdF/C/esQ9nG3dDIWJh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qcb49T0qdqCNH42MRjDhZtdBPpVNkumn5auF4uT9+ShiAm6eilfAT1o0U0OmwlwIaaYBo01Nky9/hY90HJZpGGPdySDsZetfX8t7KHdm4oo0SUvjb7hI+sKE9IKJNEY88KW3rYMCTH6fur5uGciq2YtFyZnMjroeby6uJTqBYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6TtZf/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738945444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwcdIpwsY0FdPhy1B1xVJVgRARPV0IRS459R+JPj1gQ=;
	b=Z6TtZf/DtzcAA5YzKbVQCaiNYO6PG82ayMxpX6F13bGgNNrMu2MSJUUxkT6OhrHKnGrnUH
	R2EOa5PZ8q6QVBlodPsLChKeAsI2O5BkG//m19QNMVYTbnRYzZ9FDmYPKkp+go9prrxzT2
	vKz6i3Zj+RuERxuKY+iQMjCywjvuWDE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-C39TiQrzPDK2kmPRoStrZA-1; Fri,
 07 Feb 2025 11:24:02 -0500
X-MC-Unique: C39TiQrzPDK2kmPRoStrZA-1
X-Mimecast-MFC-AGG-ID: C39TiQrzPDK2kmPRoStrZA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE956180087A;
	Fri,  7 Feb 2025 16:24:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.205])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 956C63001D11;
	Fri,  7 Feb 2025 16:23:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 1/2] sock: introduce set_tsflags operation
Date: Fri,  7 Feb 2025 17:23:44 +0100
Message-ID: <2abfa2ceefa2b472382a57b9d5d4c420a68de952.1738940816.git.pabeni@redhat.com>
In-Reply-To: <cover.1738940816.git.pabeni@redhat.com>
References: <cover.1738940816.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The generic socket code for SO_TIMESTAMPING_* carries some TCP
specific bits. Add a new protocol operation hooked on such socket
option and move the TCP implementation into the relevant callback.

Place the new hook after all the core checks, to allow the protocol
to take "conclusive" actions.

The next patch will add a tsflags implementation for the UDP protocol.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h  |  1 +
 include/net/tcp.h   |  1 +
 net/core/sock.c     | 24 +++++++++---------------
 net/ipv4/tcp.c      | 16 ++++++++++++++++
 net/ipv4/tcp_ipv4.c |  1 +
 net/ipv6/tcp_ipv6.c |  1 +
 6 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..282dd23b90dc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1246,6 +1246,7 @@ struct proto {
 					int optname, char __user *optval,
 					int __user *option);
 	void			(*keepalive)(struct sock *sk, int valbool);
+	int			(*tsflags)(struct sock *sk, int val);
 #ifdef CONFIG_COMPAT
 	int			(*compat_ioctl)(struct sock *sk,
 					unsigned int cmd, unsigned long arg);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688..962500d0c4a9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -416,6 +416,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		   unsigned int optlen);
 void tcp_set_keepalive(struct sock *sk, int val);
+int tcp_set_tsflags(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags, int *addr_len);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..aafba8e30080 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -911,21 +911,6 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
 
-	if (val & SOF_TIMESTAMPING_OPT_ID &&
-	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
-		if (sk_is_tcp(sk)) {
-			if ((1 << sk->sk_state) &
-			    (TCPF_CLOSE | TCPF_LISTEN))
-				return -EINVAL;
-			if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
-				atomic_set(&sk->sk_tskey, tcp_sk(sk)->write_seq);
-			else
-				atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd_una);
-		} else {
-			atomic_set(&sk->sk_tskey, 0);
-		}
-	}
-
 	if (val & SOF_TIMESTAMPING_OPT_STATS &&
 	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
 		return -EINVAL;
@@ -936,6 +921,15 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			return ret;
 	}
 
+	if (sk->sk_prot->tsflags) {
+		if (sk->sk_prot->tsflags(sk, val))
+			return -EINVAL;
+	} else {
+		if (val & SOF_TIMESTAMPING_OPT_ID &&
+		    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID))
+			atomic_set(&sk->sk_tskey, 0);
+	}
+
 	WRITE_ONCE(sk->sk_tsflags, val);
 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7f43d31c9400..4bd795d311d2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1741,6 +1741,22 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_set_rcvlowat);
 
+int tcp_set_tsflags(struct sock *sk, int val)
+{
+	if (val & SOF_TIMESTAMPING_OPT_ID &&
+	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+		if ((1 << sk->sk_state) &
+		    (TCPF_CLOSE | TCPF_LISTEN))
+			return -EINVAL;
+		if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
+			atomic_set(&sk->sk_tskey, tcp_sk(sk)->write_seq);
+		else
+			atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd_una);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(tcp_set_tsflags);
+
 void tcp_update_recv_tstamps(struct sk_buff *skb,
 			     struct scm_timestamping_internal *tss)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc2b5194a18d..d37ff97508d2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3361,6 +3361,7 @@ struct proto tcp_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.bpf_bypass_getsockopt	= tcp_bpf_bypass_getsockopt,
 	.keepalive		= tcp_set_keepalive,
+	.tsflags		= tcp_set_tsflags,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.splice_eof		= tcp_splice_eof,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2debdf085a3b..99092c9c1856 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2334,6 +2334,7 @@ struct proto tcpv6_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.bpf_bypass_getsockopt	= tcp_bpf_bypass_getsockopt,
 	.keepalive		= tcp_set_keepalive,
+	.tsflags		= tcp_set_tsflags,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.splice_eof		= tcp_splice_eof,
-- 
2.48.1


