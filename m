Return-Path: <netdev+bounces-203544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9594AF655B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A0D1C440F4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B442F7D0A;
	Wed,  2 Jul 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REsTt5WO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571724BD03
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495779; cv=none; b=mmBy9aQM9lR2HQ+M9bVTBwTO+p9GOsVpvuxRkuEkD66Cxo2uUk2jnUosikiAK5q7B27kTmwoGBkb4o1ALjocJAxPlJCK7bbao0k+y/R8AyqVI7fAWkz50jDbYWs92fzAP7YPQlyKdj4CGXEoh4FaoEK8W9M6yezgymEcuZ0/wTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495779; c=relaxed/simple;
	bh=kygL4/Op9+c5xhdB1qnVrRvScTwJl+lI3dr/BjrVxqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8oXih8lKzWisgifIo5sxBFB6MxK/KeW8HQ2/yCWVSIN5RUig7DXvawsH5c9CDVwKIvc1+E7eik6GolR56MSLq1ZVDnzcdjv3VxsQJ//IP5C220mA2jWrTv0pKOLO+rjjFgzwyvVs8hewRS+n0MKI/rLX/fWTslYSAi5Ly3gJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REsTt5WO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0f807421c9so5172564a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495777; x=1752100577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihjxd7RoivFgQhxhdMbwT8MQJCp1086moPOT+6ZkRNQ=;
        b=REsTt5WOPSNPCotMdlxKFt3+jv0kpg7aeV7rSX1zlI6lvh16GeAHns4M/IDurvMHSz
         O3FyUXhByWwRnajJwmM21dMiMMRUY1Zi9Sd7AXsOYeZppeXcv2ZK/6jO51Lfjugv0fYQ
         GoVdjJ2Q8iP+FKsYDgP82ZFF76b9DztFUin9F1n9gt+LhEQ4hSjH1PwzrQi9vSTFPyzu
         v88y5xRyBNekt4zNCS0p9EXBPNug3pK7LBQAaFqWqCYi3Gcpnv3B9gvESQ3/fRcV0PhV
         hg+YVt4AmZVsr7/bAcr91vOp3ntXF8HtgU1Y0y+HAjoct5OhKlNcbOrnJ009JS8BccOV
         h7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495777; x=1752100577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihjxd7RoivFgQhxhdMbwT8MQJCp1086moPOT+6ZkRNQ=;
        b=XZN3nFPzWmBqAksuBoHfHlJr8uJzvLZ8QE4aJYnUydgBMTAOUGaF+ap919ImOod4Ik
         2bkDLAYYWwwLEU+FCn0xw21e0WTWyIqSaEp+5VT61AmlXt5Mdrq0ZbfZPjDAUo10bwYH
         hfULyXKkXiNAc1Q53IWeUHQsPSs9+JGlDhnv3sfbhXqB2L8Iyr4XgTwVNe86yFuAfg63
         rtZR1XYUg8I4PeRMqxg4tmC/9LAfzkG2FEadpRDsAmpP+ljcov2O92MrrNHrX4buCfki
         P3YLDFS8YsfJfUud7pWFzh9gwkrVFuDd02HZL97d3hEbzzShqVlPVnslTODe1ebED6cc
         PIeA==
X-Forwarded-Encrypted: i=1; AJvYcCWHbhzkTbr/Wetq+c0DJZNHJCwO7J5LPjyPt4VyMaa51vdAtRh+4cVWsvF79TUTMswM5TPHP0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAPwN1Pdel85TEi7scdtS00GQu/mTClXMNHELHHHPh8v1i1qQ
	XPLU7bR94Rxl4KWk56QUtx2Lk0Ub7dVF0I5lEP2+z22mH8az3xY8ex40/WKag+kwcJMwowEmbf4
	msuDT6g==
X-Google-Smtp-Source: AGHT+IFzyz9JhHNuPFwj3DQzHmedNFK/m5KD+pp5XNK2kbiYmAGF+UijgsYl6HPEvjWKL2YPwhZY3RosREc=
X-Received: from pjtd3.prod.google.com ([2002:a17:90b:43:b0:312:dd5:aa09])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2252:b0:312:e90b:419e
 with SMTP id 98e67ed59e1d1-31a9deae432mr1070513a91.12.1751495777371; Wed, 02
 Jul 2025 15:36:17 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:18 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/7] af_unix: Introduce SO_INQ.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have an application that uses almost the same code for TCP and
AF_UNIX (SOCK_STREAM).

TCP can use TCP_INQ, but AF_UNIX doesn't have it and requires an
extra syscall, ioctl(SIOCINQ) or getsockopt(SO_MEMINFO) as an
alternative.

Let's introduce the generic version of TCP_INQ.

If SO_INQ is enabled, recvmsg() will put a cmsg of SCM_INQ that
contains the exact value of ioctl(SIOCINQ).  The cmsg is also
included when msg->msg_get_inq is non-zero to make sockets
io_uring-friendly.

Note that SOCK_CUSTOM_SOCKOPT is flagged only for SOCK_STREAM to
override setsockopt() for SOL_SOCKET.

By having the flag in struct unix_sock, instead of struct sock, we
can later add SO_INQ support for TCP and reuse tcp_sk(sk)->recvmsg_inq.

Note also that supporting custom getsockopt() for SOL_SOCKET will need
preparation for other SOCK_CUSTOM_SOCKOPT users (UDP, vsock, MPTCP).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  3 ++
 arch/mips/include/uapi/asm/socket.h   |  3 ++
 arch/parisc/include/uapi/asm/socket.h |  3 ++
 arch/sparc/include/uapi/asm/socket.h  |  3 ++
 include/net/af_unix.h                 |  1 +
 include/uapi/asm-generic/socket.h     |  3 ++
 net/unix/af_unix.c                    | 62 ++++++++++++++++++++++++++-
 7 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 8f1f18adcdb5..5ef57f88df6b 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -152,6 +152,9 @@
 
 #define SO_PASSRIGHTS		83
 
+#define SO_INQ			84
+#define SCM_INQ			SO_INQ
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 31ac655b7837..72fb1b006da9 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -163,6 +163,9 @@
 
 #define SO_PASSRIGHTS		83
 
+#define SO_INQ			84
+#define SCM_INQ			SO_INQ
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 1f2d5b7a7f5d..c16ec36dfee6 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -144,6 +144,9 @@
 
 #define SO_PASSRIGHTS		0x4051
 
+#define SO_INQ			0x4052
+#define SCM_INQ			SO_INQ
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index adcba7329386..71befa109e1c 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -145,6 +145,9 @@
 
 #define SO_PASSRIGHTS            0x005c
 
+#define SO_INQ                   0x005d
+#define SCM_INQ                  SO_INQ
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 603f8cd026e5..34f53dde65ce 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -48,6 +48,7 @@ struct unix_sock {
 	wait_queue_entry_t	peer_wake;
 	struct scm_stat		scm_stat;
 	int			inq_len;
+	bool			recvmsg_inq;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	struct sk_buff		*oob_skb;
 #endif
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index f333a0ac4ee4..53b5a8c002b1 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -147,6 +147,9 @@
 
 #define SO_PASSRIGHTS		83
 
+#define SO_INQ			84
+#define SCM_INQ			SO_INQ
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 074edbbfb315..81ef1b7764f7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -934,6 +934,52 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 #define unix_show_fdinfo NULL
 #endif
 
+static bool unix_custom_sockopt(int optname)
+{
+	switch (optname) {
+	case SO_INQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int unix_setsockopt(struct socket *sock, int level, int optname,
+			   sockptr_t optval, unsigned int optlen)
+{
+	struct unix_sock *u = unix_sk(sock->sk);
+	struct sock *sk = sock->sk;
+	int val;
+
+	if (level != SOL_SOCKET)
+		return -EOPNOTSUPP;
+
+	if (!unix_custom_sockopt(optname))
+		return sock_setsockopt(sock, level, optname, optval, optlen);
+
+	if (optlen != sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	switch (optname) {
+	case SO_INQ:
+		if (sk->sk_type != SOCK_STREAM)
+			return -EINVAL;
+
+		if (val > 1 || val < 0)
+			return -EINVAL;
+
+		WRITE_ONCE(u->recvmsg_inq, val);
+		break;
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	return 0;
+}
+
 static const struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
 	.owner =	THIS_MODULE,
@@ -950,6 +996,7 @@ static const struct proto_ops unix_stream_ops = {
 #endif
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_stream_sendmsg,
 	.recvmsg =	unix_stream_recvmsg,
 	.read_skb =	unix_stream_read_skb,
@@ -1116,6 +1163,7 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
 
 	switch (sock->type) {
 	case SOCK_STREAM:
+		set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 		sock->ops = &unix_stream_ops;
 		break;
 		/*
@@ -1847,6 +1895,9 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
+	if (tsk->sk_type == SOCK_STREAM)
+		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
@@ -3035,10 +3086,17 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	} while (size);
 
 	mutex_unlock(&u->iolock);
-	if (msg)
+	if (msg) {
 		scm_recv_unix(sock, msg, &scm, flags);
-	else
+
+		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
+			msg->msg_inq = READ_ONCE(u->inq_len);
+			put_cmsg(msg, SOL_SOCKET, SCM_INQ,
+				 sizeof(msg->msg_inq), &msg->msg_inq);
+		}
+	} else {
 		scm_destroy(&scm);
+	}
 out:
 	return copied ? : err;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


