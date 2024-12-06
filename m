Return-Path: <netdev+bounces-149634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D6D9E685F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACEC169D70
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3321DDC0A;
	Fri,  6 Dec 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XxqdmvRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7D1DEFF5
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472009; cv=none; b=MsaKNSDGlqC50QOjrNARBBMjvFi1WUThM2r5jlwYOYzopE9dMmhaZsttnAmnytYWYpGvGTXds8+dUqt6Yoyf/Drxb+2UXhp3+4fT9IXccSf+iFNrgYgkYh1LU0vzJO2urjmvTRFMSom6mikyVj3KJz3eY1Fx0Lj/5CIyrnH411U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472009; c=relaxed/simple;
	bh=cGSt+R/HbiMnXbJxo37ScMaCeUHMKe2ZPX3uPUsjlCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cckBcTprXTH+8aTOz70BPcAMgEKa2YNUgM2dpmhPS6GE2MW8a87iaRbd3/2o9ASSGEXZLse9WQdbgk23UqJOQ10BrUZyEZ1H1ywI4oHEPZlH4LoYRspFi2sjqJLgZjUwLwLKZhQZp9J3DqvVqnckVBwVofvH0xTyXxGjkRfbZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XxqdmvRu; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733472006; x=1765008006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01maTBGdhkqfz8ZbjDG7usW+Q4z08jfz47t3I3KNMt8=;
  b=XxqdmvRud2HP8lYO+XuHzr1l1B0vZpPuF9MSSto2pSvBOF10Sar/ta6Z
   4Hdm67N0kxJgMAhd5h/cJ66yKZh5cvPcCAZNSjU8F9p48TqpEWdWcDCs+
   I2eDUIR3Xu9GFrY/oSVUFnvQIADSAG3IH2fobPTQwx9NafnQyBjNAWYMM
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="47151583"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:00:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:27586]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id 087b9a9f-4698-444f-a30d-4133574c41a6; Fri, 6 Dec 2024 08:00:05 +0000 (UTC)
X-Farcaster-Flow-ID: 087b9a9f-4698-444f-a30d-4133574c41a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 08:00:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 08:00:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 14/15] socket: Rename sock_create() to sock_create_user().
Date: Fri, 6 Dec 2024 16:55:03 +0900
Message-ID: <20241206075504.24153-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206075504.24153-1-kuniyu@amazon.com>
References: <20241206075504.24153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_create() is a bad name, and no one really cares about what it's for.

Let's rename it to sock_create_user() and add fat documentation to catch
future developers' attention.

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
index 03ad6a179c35..1c4810fb4b5d 100644
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


