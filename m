Return-Path: <netdev+bounces-189433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F84AB20EB
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6179E450D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9C267721;
	Sat, 10 May 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HT1fOikj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8D26771B
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842354; cv=none; b=QtNmhR+LRL7phNYyn+11rjD51ZM32+/vulNYeeVx7h29H+p4rTdUy+Yw+/hDOwcC6nCCHu0EAAnqROvuywR7EHSjB8EJ6B5Ty4jGD4I25QLd1OFl8Pphg1jTG1gRVvP/PlY9nRmv3iOiW5tF8yIb1Ib9q/FvRfhjm4OO2Cvhego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842354; c=relaxed/simple;
	bh=BpyN2xzOALqESFlYoqy/dO/dQaVhhHElOwJlBlkBbSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=justH+9Jncxt1g1ci4beoKuKOptEfLrZO3M/p2EBpAgHT+vqIXNH6SeGatzClD6WwBUC3L65BZxrto9akK3AORxZ5Kp5g/upMslqETU/S2PK2SYAm9MIZYuZU53oT/W8U+rILmgccNkW4N+L86JyJP2Bys1Us4d1adZiJyTGluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HT1fOikj; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842353; x=1778378353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sdtx4yZwxg+V1EP1QEgII1C5J3R7e1FRdAT5N+4+CpA=;
  b=HT1fOikjapuK4lRdljjO5lLufI3HFt7PN5qMN8ptjn3lynix9CuGGNTn
   AMNM1tueaDlPU70BUAaASJW28fCB3AfLZxFi+q5cepce5xy9e+jbYtuVI
   BMXVyFVakeOeO89V+9HHLJooDC2GU/8v0oJSl1jGdNFkBWfkHxWb0XEu3
   I7aYyPQ+Da+Suw99wS/1+Bpo8wC0aQRQH0NUmUPdPxATh/MBBiWEvuSeC
   pIjXGzTvvId6s9ynshtbtkUxXXm0c4tlDUtKOZ2eLI5A4ociK0kc57TZx
   UipQ44roYW7ASwaP5t2iWD6Rii1/RuUaz2tdZXhexzrRbOl6V4s09JI4B
   w==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="497207393"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:59:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:46396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id 3cb4f0a9-70fc-45c2-abea-1bf6f1529e34; Sat, 10 May 2025 01:59:08 +0000 (UTC)
X-Farcaster-Flow-ID: 3cb4f0a9-70fc-45c2-abea-1bf6f1529e34
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:59:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:59:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
Date: Fri, 9 May 2025 18:56:28 -0700
Message-ID: <20250510015652.9931-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

SCM_CREDENTIALS and SCM_SECURITY can be recv()ed by calling
scm_recv() or scm_recv_unix(), and SCM_PIDFD is only used by
scm_recv_unix().

scm_recv() is called from AF_NETLINK and AF_BLUETOOTH.

scm_recv_unix() is literally called from AF_UNIX.

Let's restrict SO_PASSCRED and SO_PASSSEC to such sockets and
SO_PASSPIDFD to AF_UNIX only.

Later, SOCK_PASS{CRED,PIDFD,SEC} will be moved to struct sock
and united with another field, so we set 0 explicitly in
getsockopt().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/sock.h | 14 +++++++++++++-
 net/core/sock.c    | 24 +++++++++++++++++++++---
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f0fabb9fd28a..af0719ba331f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2772,9 +2772,14 @@ static inline bool sk_is_udp(const struct sock *sk)
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
@@ -2782,6 +2787,13 @@ static inline bool sk_is_vsock(const struct sock *sk)
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
index 5c84a608ddd7..1ab59efbafc5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1221,12 +1221,21 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		}
 		return -EPERM;
 	case SO_PASSSEC:
+		if (!sk_may_scm_recv(sk))
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
@@ -1855,11 +1864,17 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSCRED:
-		v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
+		if (sk_may_scm_recv(sk))
+			v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
+		else
+			v.val = 0;
 		break;
 
 	case SO_PASSPIDFD:
-		v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
+		if (sk_is_unix(sk))
+			v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
+		else
+			v.val = 0;
 		break;
 
 	case SO_PEERCRED:
@@ -1956,7 +1971,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSSEC:
-		v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
+		if (sk_may_scm_recv(sk))
+			v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
+		else
+			v.val = 0;
 		break;
 
 	case SO_PEERSEC:
-- 
2.49.0


