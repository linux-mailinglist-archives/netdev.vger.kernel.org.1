Return-Path: <netdev+bounces-191649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D9ABC8CB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A453B2423
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1DD1D5ACE;
	Mon, 19 May 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ijInmRrB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4A27470
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688445; cv=none; b=iZ9ABw7V05udEZyR5lElEJ6yr6s2f9jTHGnbgafVSqUyVGsJeKTDL9gglABi8IbbaHubxuPDrTmuedayxTWi924tmB7m/T0nfZ0JUTYeBmS3p6u1FHH/RNc3z/JE5F/mYkiPoHvH75ZuGRUYhEtLKTB2C90dCqOsTlgDFBRaNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688445; c=relaxed/simple;
	bh=WfOYeIgKhhw1mGs9tugt3QGwIaA5wsi82JPT2dT1Kxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJUY7VXajDM2nVmgVe4zeSuwbOhX6dVu8dIqbSU/bz0FS7JyLRSzuO5BKGEP0lKGnrRHNnG21+umxNDOguCM4l4emTRwZAXdxnMx8NJbLA6YZuWA316i97LvW7qcxUhbo2U1Sku6sSiCOCvk4QBESUAAxDfxg/nzIoypMlk8vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ijInmRrB; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688445; x=1779224445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lX84mVYng7du5C+evun9nBld517z2lM4zi2vzi/i7P8=;
  b=ijInmRrBYoorwNheD/jgwfqN0NyqqiybvysxCwAcu1ehexGcJ+6DC2Nb
   hFCNNESZvVNhKeZOONLTysiSe4q31pzeCub57LsiS02MUONzeVr3qTrx9
   jw0QOM5hUyfbO4SEaTnLvqu3NAG+8iWFhnapXzuNg2vSE47OdTraNKv+y
   WUTjFYnvbH9fwV4U/T4daY7E675CddjKmjBnIPgILQkq9d5rDnSt6XZxj
   iLhLdPlNECELK4ByMxuOcou4moTZTnIhnPlEfwMbCyMDRgVHrLvdk3YAl
   P+TF1v0QeunE+vy17NDv47bU/ri9H5h2CMvTFxrDgYgl2VA8Ir6zxJg+I
   w==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="493941989"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:00:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:28961]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 54a574e2-fb64-4041-acc1-e3ff47bd6666; Mon, 19 May 2025 21:00:39 +0000 (UTC)
X-Farcaster-Flow-ID: 54a574e2-fb64-4041-acc1-e3ff47bd6666
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:00:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:00:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
Date: Mon, 19 May 2025 13:57:56 -0700
Message-ID: <20250519205820.66184-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

SCM_CREDENTIALS and SCM_SECURITY can be recv()ed by calling
scm_recv() or scm_recv_unix(), and SCM_PIDFD is only used by
scm_recv_unix().

scm_recv() is called from AF_NETLINK and AF_BLUETOOTH.

scm_recv_unix() is literally called from AF_UNIX.

Let's restrict SO_PASSCRED and SO_PASSSEC to such sockets and
SO_PASSPIDFD to AF_UNIX only.

Later, SOCK_PASS{CRED,PIDFD,SEC} will be moved to struct sock
and united with another field.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v3:
  * Return -EOPNOTSUPP in getsockopt() too
  * Add CONFIG_SECURITY_NETWORK check for SO_PASSSEC
---
 include/net/sock.h | 14 +++++++++++++-
 net/core/sock.c    | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3e15d7105ad2..56fa558d24c0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2773,9 +2773,14 @@ static inline bool sk_is_udp(const struct sock *sk)
 	       sk->sk_protocol == IPPROTO_UDP;
 }
 
+static inline bool sk_is_unix(const struct sock *sk)
+{
+	return sk->sk_family == AF_UNIX;
+}
+
 static inline bool sk_is_stream_unix(const struct sock *sk)
 {
-	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
+	return sk_is_unix(sk) && sk->sk_type == SOCK_STREAM;
 }
 
 static inline bool sk_is_vsock(const struct sock *sk)
@@ -2783,6 +2788,13 @@ static inline bool sk_is_vsock(const struct sock *sk)
 	return sk->sk_family == AF_VSOCK;
 }
 
+static inline bool sk_may_scm_recv(const struct sock *sk)
+{
+	return (IS_ENABLED(CONFIG_UNIX) && sk->sk_family == AF_UNIX) ||
+		sk->sk_family == AF_NETLINK ||
+		(IS_ENABLED(CONFIG_BT) && sk->sk_family == AF_BLUETOOTH);
+}
+
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
  * @sk: socket to eat this skb from
diff --git a/net/core/sock.c b/net/core/sock.c
index d7d6d3a8efe5..fd5f9d3873c1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1221,12 +1221,21 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		}
 		return -EPERM;
 	case SO_PASSSEC:
+		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) || sk_may_scm_recv(sk))
+			return -EOPNOTSUPP;
+
 		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
 		return 0;
 	case SO_PASSCRED:
+		if (!sk_may_scm_recv(sk))
+			return -EOPNOTSUPP;
+
 		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
 		return 0;
 	case SO_PASSPIDFD:
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
+
 		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
 		return 0;
 	case SO_TYPE:
@@ -1855,10 +1864,16 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSCRED:
+		if (!sk_may_scm_recv(sk))
+			return -EOPNOTSUPP;
+
 		v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
 		break;
 
 	case SO_PASSPIDFD:
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
+
 		v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
 		break;
 
@@ -1956,6 +1971,9 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSSEC:
+		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) || !sk_may_scm_recv(sk))
+			return -EOPNOTSUPP;
+
 		v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
 		break;
 
-- 
2.49.0


