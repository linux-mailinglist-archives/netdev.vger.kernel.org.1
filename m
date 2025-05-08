Return-Path: <netdev+bounces-188840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50623AAF0A6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05D34C637E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB319C542;
	Thu,  8 May 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QbcOVGwg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA233FD
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667981; cv=none; b=jtvgqK13okOcGmOGdfeiMFRJzVHwi0O42mirnQ+wy9p/IAGpCcF8iK47KZsn6rcw4tKH4CIch0RTuRoMWzGWUwjZq2lxtRfev6nMP0TwxV08BzZlh7b7dF41OietZZlG7fbw/N9oFCSm3EnPFUTwE73HohFqBiIWNple6ArUNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667981; c=relaxed/simple;
	bh=qUezMH6ZTdK61szmnuNuJUkzsv5Q46aOkHEA/7g9Pjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfcANSr3KG9xx6j2FP4AM8BvAefYrxscckzJVB3aB0ncAHJWh4wCd/i1AkHMG6/4oHJrSMoUQNUpXW/09M4/cNR5fHJyCPbCZffRIlQYUyM67jKPy3RHycvnrERdAqdRdW8OV6dk9Fs/znOMr9FxILwO8xjXy9S0qlNUi+/HAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QbcOVGwg; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667980; x=1778203980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vzRdiV8GHezERobdbPI8K86v3DZCLpg7hzuuVUUC7Mo=;
  b=QbcOVGwgzl7y2NWeKV1d0OdoS1/p6YhH8H5idv4d1I4VHW0P0C0G7uja
   /14IUCVXcrRuJi0Hwmmgb7/MfcYHLkD3R/CfB5+Bo7AyS51kLDG8QFEh+
   NYSzj/nK0BYAiU9k1B4H2/13LNUy3VK/RoY7IbqkvFTxBWiWH8znEXOQH
   dYUHO3H28TMNuGHJ4Y8sSxgnU5BKseC+TZoAba1sU7FHf59WLcnxh9arL
   03BRMa/OGAJxGcuVLr10BT42OfAVd8iU+UBcnBkmgHW7nx3ZrFKFY/X1N
   h5IIk4ud2wyrWbOPB4H/wXAIRT+JwcbOT7M+2HaUQcfMfeVj7aQoAnf34
   w==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="17633253"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:32:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:7579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.121:2525] with esmtp (Farcaster)
 id 17329a55-7b41-49d7-b4bd-bfca2b9385b3; Thu, 8 May 2025 01:32:58 +0000 (UTC)
X-Farcaster-Flow-ID: 17329a55-7b41-49d7-b4bd-bfca2b9385b3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:32:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:32:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/7] af_unix: Introduce SO_PASSRIGHTS.
Date: Wed, 7 May 2025 18:29:18 -0700
Message-ID: <20250508013021.79654-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508013021.79654-1-kuniyu@amazon.com>
References: <20250508013021.79654-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
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
 include/net/sock.h                      |  1 +
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         | 13 +++++++++++++
 net/unix/af_unix.c                      | 22 ++++++++++++++++++++--
 tools/include/uapi/asm-generic/socket.h |  2 ++
 9 files changed, 46 insertions(+), 2 deletions(-)

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
index 48b8856e2615..7de988daa4a7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -966,6 +966,7 @@ enum sock_flags {
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
 	SOCK_PASSCRED, /* Receive SCM_CREDENTIALS ancillary data with packet */
 	SOCK_PASSPIDFD, /* Receive SCM_PIDFD ancillary data with packet */
+	SOCK_PASSRIGHTS, /* Receive SCM_RIGHTS ancillary data with packet */
 	SOCK_PASSSEC, /* Receive SCM_SECURITY ancillary data with packet */
 	SOCK_FLAG_MAX,
 };
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
index a1720c7f9789..ab07cbc79d2d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1229,6 +1229,12 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_PASSPIDFD:
 		sock_valbool_flag(sk, SOCK_PASSPIDFD, valbool);
 		return 0;
+	case SO_PASSRIGHTS:
+		if (sk->sk_family != AF_UNIX)
+			return -EINVAL;
+
+		sock_valbool_flag(sk, SOCK_PASSRIGHTS, valbool);
+		return 0;
 	case SO_TYPE:
 	case SO_PROTOCOL:
 	case SO_DOMAIN:
@@ -1860,6 +1866,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sock_flag(sk, SOCK_PASSPIDFD);
 		break;
 
+	case SO_PASSRIGHTS:
+		if (sk->sk_family != AF_UNIX)
+			return -EINVAL;
+
+		v.val = sock_flag(sk, SOCK_PASSRIGHTS);
+		break;
+
 	case SO_PEERCRED:
 	{
 		struct ucred peercred;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index daa7a8ead243..1f0465139066 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1015,6 +1015,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	}
 
 	sock_init_data(sock, sk);
+	sock_set_flag(sk, SOCK_PASSRIGHTS);
 
 	sk->sk_hash		= unix_unbound_hash(sk);
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
@@ -2073,6 +2074,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
+	if (UNIXCB(skb).fp && !sock_flag(other, SOCK_PASSRIGHTS)) {
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
+	if (UNIXCB(skb).fp && !sock_flag(other, SOCK_PASSRIGHTS)) {
+		err = -EPERM;
+		goto out_unlock;
 	}
 
 	maybe_add_creds(skb, sk, other);
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
 
+		if (UNIXCB(skb).fp && !sock_flag(other, SOCK_PASSRIGHTS)) {
+			unix_state_unlock(other);
+			err = -EPERM;
+			goto out_free;
+		}
+
 		maybe_add_creds(skb, sk, other);
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


