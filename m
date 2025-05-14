Return-Path: <netdev+bounces-190506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6384AB71FD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695D4860D88
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FA27E1C3;
	Wed, 14 May 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nevkYkZ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFA2749EA
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241684; cv=none; b=BoViqXHuoKf/bOf35MsuxjfwIBk/mOkmnqcwMlrn7pOoKcACj0DRoWUGsOImDS3QGdSOlS/UobnGlHKPPj0sPgc6/m8aS5WcIKedNbrgNe2rQJ9CJTDuP8os5MOB07LofAUUiI65+I4aOOaZbrb3Bwf/E8pds5zOcV2IzAzdF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241684; c=relaxed/simple;
	bh=SdU9Zyl17RKUi4YcNe+U8ZeDqPh0/hNG7N6z0nrxrRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3LkoW6bnzvEN0MNeWEO6qTczEnKTp0WLW6johj5zxj+/Zv2b9R0mTltDfpa7sVODy/zVVCcSGvM/OklZ+XidQbvCnMIzT8iLJc+PLgRtGxPnvCM3ovBUNfWR5AarHYceIdFfOqdnP6PtwTSqN1jNM8Xb/KQVn1CrX5Fd+hWCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nevkYkZ3; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747241684; x=1778777684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yMlqBq9flPjPT5dcvfQn8K9IDjkIhuHx3g5NPJEVAIA=;
  b=nevkYkZ3FwbOQK7FctjActJp233ClgyRgnWvsLUmZrcnB02ZW6PqPE1s
   +85DubNCwRbD0SmENOZnIS1MXPwXr9R5WZojyqRPQ5AuIE1tveXMP38OU
   xdCGWldviISDs/fDXS6Y5c4jmVOcogfG3dz0dvcmt1drEb1HdjakLnhNr
   WIfHYy9fUoJs8l9X15dmmhD9rlgHuDmI0fLeSaAwuul0Vwp/WApmkgmGe
   vLDFwDUqssIkVv5AjfvcMrbAkqE7MFlxqKW/8yN/U7jh+0hYObYfRzn8c
   wp1MkgSLkRQKwiL0nKS4CLMpO3c3d9nHSHrD/QuGimTrlad8c2c+jpt8E
   g==;
X-IronPort-AV: E=Sophos;i="6.15,288,1739836800"; 
   d="scan'208";a="49960109"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:54:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:43760]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.11:2525] with esmtp (Farcaster)
 id 0333ee2e-58f3-409b-acac-5f6f734465fc; Wed, 14 May 2025 16:54:40 +0000 (UTC)
X-Farcaster-Flow-ID: 0333ee2e-58f3-409b-acac-5f6f734465fc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:54:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:54:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
Date: Wed, 14 May 2025 09:51:48 -0700
Message-ID: <20250514165226.40410-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514165226.40410-1-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
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
and united with another field.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


