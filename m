Return-Path: <netdev+bounces-189436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63827AB20EF
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2947B5629
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BD2676F8;
	Sat, 10 May 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kXlr1R5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AC125DF
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842426; cv=none; b=LefN2uQi4/g7ZAMtVjeTR0SwuNUyNiQ/CBcD8uqm2iiHv6b2L92UGtvJPc2WaTUJMji51Msuz4dExKoo9680DkI+19ngl/wwo0JRFw/12Y67Rwkb36RDqzjI6wsLnS6MEOW3pYg1DCfQZRhclAEgXw2rc2QYBBoDx5ioSjEcRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842426; c=relaxed/simple;
	bh=VaWVADi+OsB2lRQ4EIx7ctj+0GeLADTtNHqrxZwzy8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyMMsCeB+p5bTfdE2YYg5a4dHQsTJ+c2aH7EAnCQ4zVFSWZHVoJVyF3eDucYw6Sm/f3MX4xoTKefOm73ViTWueRc3WbnrdDpwfwVMdNFGO8uqyRCG7OCmU4r2p+su0T913P+sB5aLZWErS/uUDoQ40gjIK5j/b8mlPCSwa8aMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kXlr1R5g; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842424; x=1778378424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gio8EHZI8YgBxyfqfvQoByteyxeZiCRcSVYpce44BDk=;
  b=kXlr1R5gT3jGhQJ8y362G/KmQ9Gr6jnT/R8kVStwvfCL/jlPFogDRZAy
   Fz3VS13w2mMndwuY/1oekrm0h9tsvtU4bVIHaw9B7mBtdf9OFgQHnYEm+
   EhQy63izgv7E8FXcCGrmRrfluDFAgbwOFxpolb1vMYEdFzvnkNilxXZI0
   bSyuGM9CmJ3qaxx0HLBRMqTzxbhsyALgqf6Mipx4COYPOMVb9VoCc/wtA
   zvCxOjhELdFTtpcqsBcmWnnILzuP1aeZjWD00blG6OYIt6uvCFuJdSm8r
   fS0sh/voJNnjfInCLQnjRs/uFoPut0ZpnZjNcTrmFpJxpDm6lh7qWSemE
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="296292825"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 02:00:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:46627]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.105:2525] with esmtp (Farcaster)
 id 9bc5aa4d-67e6-40c0-8ff0-9aa0eeb22dea; Sat, 10 May 2025 02:00:22 +0000 (UTC)
X-Farcaster-Flow-ID: 9bc5aa4d-67e6-40c0-8ff0-9aa0eeb22dea
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 02:00:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 02:00:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 8/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Fri, 9 May 2025 18:56:31 -0700
Message-ID: <20250510015652.9931-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250510015652.9931-1-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
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
---
 arch/alpha/include/uapi/asm/socket.h    |  2 ++
 arch/mips/include/uapi/asm/socket.h     |  2 ++
 arch/parisc/include/uapi/asm/socket.h   |  2 ++
 arch/sparc/include/uapi/asm/socket.h    |  2 ++
 include/net/sock.h                      |  4 +++-
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         | 13 +++++++++++++
 net/unix/af_unix.c                      | 22 ++++++++++++++++++++--
 tools/include/uapi/asm-generic/socket.h |  2 ++
 9 files changed, 48 insertions(+), 3 deletions(-)

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
index 036ed7d394ba..26c7d85df7d3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -341,6 +341,7 @@ struct sk_filter;
   *	@sk_scm_credentials: flagged by SO_PASSCRED to recv SCM_CREDENTIALS
   *	@sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
   *	@sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
+  *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@ns_tracker: tracker for netns reference
   *	@sk_user_frags: xarray of pages the user is holding a reference on.
   *	@sk_owner: reference to the real owner of the socket that calls
@@ -533,7 +534,8 @@ struct sock {
 		u8		sk_scm_credentials : 1,
 				sk_scm_security : 1,
 				sk_scm_pidfd : 1,
-				sk_scm_unused : 5;
+				sk_scm_rights : 1,
+				sk_scm_unused : 4;
 	};
 	u8			sk_clockid;
 	u8			sk_txtime_deadline_mode : 1,
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
index 9540cbe3d83e..c9f81019cb9d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1238,6 +1238,12 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 
 		sk->sk_scm_pidfd = valbool;
 		return 0;
+	case SO_PASSRIGHTS:
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
+
+		sk->sk_scm_rights = valbool;
+		return 0;
 	case SO_TYPE:
 	case SO_PROTOCOL:
 	case SO_DOMAIN:
@@ -1877,6 +1883,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			v.val = 0;
 		break;
 
+	case SO_PASSRIGHTS:
+		if (sk_is_unix(sk))
+			v.val = sk->sk_scm_rights;
+		else
+			v.val = 0;
+		break;
+
 	case SO_PEERCRED:
 	{
 		struct ucred peercred;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ba52fc36f9be..941098b090ef 100644
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


