Return-Path: <netdev+bounces-151666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAD9F07DC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2112848C7
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E31B0F1B;
	Fri, 13 Dec 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lssxaRhA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF21AF0CE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082026; cv=none; b=DycWB6JxjQgwWjx5EsC2I0B1jHyS2gY+nEUnbDi2mW2D7YKDo/xTUd9fjV9cdKfSiLBvgR52dFyJdt1ZvYeMR6iSYZAkPgOXD+YyvPtAZJgHmLIpTzPIW+9gsMdrPnHrq6TVrJilXCoxTqRnVEOQK+aAP4Lb3xCkGgaSb2Nh94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082026; c=relaxed/simple;
	bh=pViRYtmfib7v3i0UlgtWMHG9xiQIM7wpimpr4zgQquU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nErTHd8mAoL0+M5ipjCyvim9wObvzTT0SsBIXU+kUMHzWBRQNiqqfaFFHBi3xtyrgLRwRr14EvMmg2c9n89F/5wHgKAgPXE42rkrT0mmHaazOf6/7egLCLnyTPXRDcXkMRhZ3gh811HRhtDwa/Akw0eCPL8hMpS5I+JdzunAswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lssxaRhA; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081947; x=1765617947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8t0VUUwAy68dqoQOkLN2MI3OvdvHTPrkFHsUvezuFZ8=;
  b=lssxaRhAlZ7vzS/5m/rvMuzVWu01dQEep4r2o3uyw4gnfD/4OPlCtOV0
   IWon3iMOOAf8h5uqAH0c0JvbYILicqHiZ0rQYFOVfFhnIb2ZiGvXhJ3ta
   ofWTtoz1Dd6FHAMXVJpwirtDDNq96NqNygLGUL9WD9d90W0ONWyNIgE56
   0=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="5678982"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:25:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:57650]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.231:2525] with esmtp (Farcaster)
 id 096b8d9b-cb4a-4d24-bc5e-8d3e71d4e275; Fri, 13 Dec 2024 09:26:58 +0000 (UTC)
X-Farcaster-Flow-ID: 096b8d9b-cb4a-4d24-bc5e-8d3e71d4e275
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:26:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:26:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 14/15] socket: Rename sock_create() to sock_create_user().
Date: Fri, 13 Dec 2024 18:21:51 +0900
Message-ID: <20241213092152.14057-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213092152.14057-1-kuniyu@amazon.com>
References: <20241213092152.14057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_create() is a bad name and was used in incorrect places.

Let's rename it to sock_create_user() and add fat documentation
to catch future developers' attention.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/net.h |  2 +-
 net/sctp/socket.c   |  2 +-
 net/socket.c        | 33 +++++++++++++++++++++------------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 758c99af6cf4..1ba4abb18863 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -251,7 +251,7 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
-int sock_create(int family, int type, int proto, struct socket **res);
+int sock_create_user(int family, int type, int proto, struct socket **res);
 int sock_create_net(struct net *net, int family, int type, int proto,
 		    struct socket **res);
 int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index a1add0b7fd9f..e49904f08559 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5647,7 +5647,7 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
 		return -EINVAL;
 
 	/* Create a new socket.  */
-	err = sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
+	err = sock_create_user(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
 	if (err < 0)
 		return err;
 
diff --git a/net/socket.c b/net/socket.c
index 00ece8401b17..992de3dd94b8 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1606,22 +1606,31 @@ static int __sock_create(struct net *net, int family, int type, int protocol,
 }
 
 /**
- *	sock_create - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create_user - creates a socket for userspace
  *
- *	A wrapper around __sock_create().
- *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The socket is for userspace and should be exposed via a file
+ * descriptor and BPF hooks (see inet_create(), inet_release(), etc).
+ *
+ * The number of sockets is available in the first line of
+ * /proc/net/sockstat.
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
  */
 
-int sock_create(int family, int type, int protocol, struct socket **res)
+int sock_create_user(int family, int type, int protocol, struct socket **res)
 {
 	return __sock_create(current->nsproxy->net_ns, family, type, protocol,
 			     res, false, true);
 }
-EXPORT_SYMBOL(sock_create);
+EXPORT_SYMBOL(sock_create_user);
 
 /**
  * sock_create_net - creates a socket for kernel space
@@ -1689,7 +1698,7 @@ static struct socket *__sys_socket_create(int family, int type, int protocol)
 		return ERR_PTR(-EINVAL);
 	type &= SOCK_TYPE_MASK;
 
-	retval = sock_create(family, type, protocol, &sock);
+	retval = sock_create_user(family, type, protocol, &sock);
 	if (retval < 0)
 		return ERR_PTR(retval);
 
@@ -1799,11 +1808,11 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 	 * supports the socketpair call.
 	 */
 
-	err = sock_create(family, type, protocol, &sock1);
+	err = sock_create_user(family, type, protocol, &sock1);
 	if (unlikely(err < 0))
 		goto out;
 
-	err = sock_create(family, type, protocol, &sock2);
+	err = sock_create_user(family, type, protocol, &sock2);
 	if (unlikely(err < 0)) {
 		sock_release(sock1);
 		goto out;
-- 
2.39.5 (Apple Git-154)


