Return-Path: <netdev+bounces-191652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D02ABC8D2
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133D51883568
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827120D51E;
	Mon, 19 May 2025 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hvImydOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762C2116F5
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688516; cv=none; b=qiU79JhE3+0IeEUFv0MpSRQQaXU68K1VWxeFHPhDeLrE3QsT673xDibUh8SAYCNE2E+9QTrf0+2pFcwAuSisJH6wna/br5/a4n1QRf/4bWov0DDdgj0TVF/tC8/O+NjUnY2vl0kD5hMPXIsKWL4yNUC2qVx+WaI7LTwEvKfmJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688516; c=relaxed/simple;
	bh=9tyg1H0WsiHdtFM9jaaRbq94AWGfVWfPammN1QN2iYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1Xc6HkTl/ua4ZML/z3JBrWglQRPqMcOVDz4OzRcm1brpHOSJyc2lz+MgD8sDYfWPXjHLa1yysbCa49kQrb91TjbEAeHh2159wuHRgIYHCjCwFxvPndPFHeyu8+/nad6X8NAUDuHm1qDcjzIJaS4hEyvv7aT+oUaI2iccCigY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hvImydOj; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688515; x=1779224515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFQl4tA7BZLvubccNOucy32yFzkZBBSGhxBOwaNXPlk=;
  b=hvImydOjkp5fCj8/aXWl/JPVi50NFx3ugZFIBdNYAFujEvmKX6b1FyL/
   6zEY2Eytcj6Q6DpxBwZpCzHGbU3zwN10nhTV3Y1gGYouG7+OF/9EdeJT4
   Uaew3riNM9n8qaVzTTl3SUvSX9dNjvSdlvTfTt8RRvMsQuoZQXEl9pBlF
   nq88cxSInJkFTPIrFhx9IDFmBaf5gKlxgZdQ1Em8TsYLlFRT7PFi8QpiW
   opGDRt0tphOCGZFWycbaTgUW3ppJLOpmivmflTFuYao2ZzmZVtfKOq7d+
   X7HbWHHKeVxDfnJRdV1j6gYREfLnrx/c3rm5GUwsgFYedIc/59cDmWZt5
   A==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="198577624"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:01:52 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:62210]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.20:2525] with esmtp (Farcaster)
 id 80354f5b-2f67-473d-b2c2-54c07e832d9e; Mon, 19 May 2025 21:01:52 +0000 (UTC)
X-Farcaster-Flow-ID: 80354f5b-2f67-473d-b2c2-54c07e832d9e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:01:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:01:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 8/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Mon, 19 May 2025 13:57:59 -0700
Message-ID: <20250519205820.66184-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519205820.66184-1-kuniyu@amazon.com>
References: <20250519205820.66184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As long as recvmsg() or recvmmsg() is used with cmsg, it is not
possible to avoid receiving file descriptors via SCM_RIGHTS.

This behaviour has occasionally been flagged as problematic, as
it can be (ab)used to trigger DoS during close(), for example, by
passing a FUSE-controlled fd or a hung NFS fd.

For instance, as noted on the uAPI Group page [0], an untrusted peer
could send a file descriptor pointing to a hung NFS mount and then
close it.  Once the receiver calls recvmsg() with msg_control, the
descriptor is automatically installed, and then the responsibility
for the final close() now falls on the receiver, which may result
in blocking the process for a long time.

Regarding this, systemd calls cmsg_close_all() [1] after each
recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.

However, this cannot work around the issue at all, because the final
fput() may still occur on the receiver's side once sendmsg() with
SCM_RIGHTS succeeds.  Also, even filtering by LSM at recvmsg() does
not work for the same reason.

Thus, we need a better way to refuse SCM_RIGHTS at sendmsg().

Let's introduce SO_PASSRIGHTS to disable SCM_RIGHTS.

Note that this option is enabled by default for backward
compatibility.

Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v3: Return -EOPNOTSUPP for getsockopt()
---
 arch/alpha/include/uapi/asm/socket.h    |  2 ++
 arch/mips/include/uapi/asm/socket.h     |  2 ++
 arch/parisc/include/uapi/asm/socket.h   |  2 ++
 arch/sparc/include/uapi/asm/socket.h    |  2 ++
 include/net/sock.h                      |  4 +++-
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         | 14 ++++++++++++++
 net/unix/af_unix.c                      | 22 ++++++++++++++++++++--
 tools/include/uapi/asm-generic/socket.h |  2 ++
 9 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 3df5f2dd4c0f..8f1f18adcdb5 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -150,6 +150,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PASSRIGHTS		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 22fa8f19924a..31ac655b7837 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -161,6 +161,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PASSRIGHTS		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 96831c988606..1f2d5b7a7f5d 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -142,6 +142,8 @@
 #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
 #define SO_DEVMEM_DONTNEED	0x4050
 
+#define SO_PASSRIGHTS		0x4051
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 5b464a568664..adcba7329386 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -143,6 +143,8 @@
 
 #define SO_RCVPRIORITY           0x005b
 
+#define SO_PASSRIGHTS            0x005c
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index d14d7d960d44..1db4f40f2ecf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -341,6 +341,7 @@ struct sk_filter;
   *	@sk_scm_credentials: flagged by SO_PASSCRED to recv SCM_CREDENTIALS
   *	@sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
   *	@sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
+  *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
   *	@sk_user_frags: xarray of pages the user is holding a reference on.
@@ -535,7 +536,8 @@ struct sock {
 			u8	sk_scm_credentials : 1,
 				sk_scm_security : 1,
 				sk_scm_pidfd : 1,
-				sk_scm_unused : 5;
+				sk_scm_rights : 1,
+				sk_scm_unused : 4;
 		};
 	};
 	u8			sk_clockid;
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index aa5016ff3d91..f333a0ac4ee4 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -145,6 +145,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PASSRIGHTS		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index 381abf8f25b7..0cb52e590094 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1571,6 +1571,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EOPNOTSUPP;
 		break;
 
+	case SO_PASSRIGHTS:
+		if (sk_is_unix(sk))
+			sk->sk_scm_rights = valbool;
+		else
+			ret = -EOPNOTSUPP;
+		break;
+
 	case SO_INCOMING_CPU:
 		reuseport_update_incoming_cpu(sk, val);
 		break;
@@ -1879,6 +1886,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sk->sk_scm_pidfd;
 		break;
 
+	case SO_PASSRIGHTS:
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
+
+		v.val = sk->sk_scm_rights;
+		break;
+
 	case SO_PEERCRED:
 	{
 		struct ucred peercred;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 900bad88fbd2..bd507f74e35e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1015,6 +1015,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 
 	sock_init_data(sock, sk);
 
+	sk->sk_scm_rights	= 1;
 	sk->sk_hash		= unix_unbound_hash(sk);
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
 	sk->sk_write_space	= unix_write_space;
@@ -2073,6 +2074,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
+	if (UNIXCB(skb).fp && !other->sk_scm_rights) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+
 	if (sk->sk_type != SOCK_SEQPACKET) {
 		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
 		if (err)
@@ -2174,9 +2180,13 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 
 	if (sock_flag(other, SOCK_DEAD) ||
 	    (other->sk_shutdown & RCV_SHUTDOWN)) {
-		unix_state_unlock(other);
 		err = -EPIPE;
-		goto out;
+		goto out_unlock;
+	}
+
+	if (UNIXCB(skb).fp && !other->sk_scm_rights) {
+		err = -EPERM;
+		goto out_unlock;
 	}
 
 	unix_maybe_add_creds(skb, sk, other);
@@ -2192,6 +2202,8 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 	other->sk_data_ready(other);
 
 	return 0;
+out_unlock:
+	unix_state_unlock(other);
 out:
 	consume_skb(skb);
 	return err;
@@ -2295,6 +2307,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		    (other->sk_shutdown & RCV_SHUTDOWN))
 			goto out_pipe_unlock;
 
+		if (UNIXCB(skb).fp && !other->sk_scm_rights) {
+			unix_state_unlock(other);
+			err = -EPERM;
+			goto out_free;
+		}
+
 		unix_maybe_add_creds(skb, sk, other);
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index aa5016ff3d91..f333a0ac4ee4 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -145,6 +145,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PASSRIGHTS		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.49.0


