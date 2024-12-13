Return-Path: <netdev+bounces-151658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B09F07CE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE8C1682D4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA021AF0B8;
	Fri, 13 Dec 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D7Usqk/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BE1AF0C5
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081875; cv=none; b=st1k+kxim//dkm6GWtv0h0ILo6zDxDTyLoeOm/0GPpemcYxdlDeu9TRGeKAuCbAYhOzQQwyk7FjY8Ks0zr6yU16hCJLf6QPXDM14ok1Z3hDRXM34rnG1a917w/zn8KpSYmpRj8kzJD1EkQFJ6g4GzPEBnxk/6RomUsbWMur2MK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081875; c=relaxed/simple;
	bh=893t96dR2G58PxY9f2/ZZrnL2JlPxyzBMVxhF+xxdcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdkKEhNZfpV4keL4XDYEZsJwgP5E3Oumd9BjfV/cralMp5wb3I38091iyCzaVhWZhTQ38FeU5vIeeG9d7qKRMiY1jhBkbP/3RU5zSHLuaYj9ZZmGY3bYtpj/b4+WxFyVykIOBgEm9jyKlOZkmWHzDT160Hyie8+GjKFphY09NAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D7Usqk/M; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081872; x=1765617872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSfih7pxLbbWsDFFTIVFqhVI2ByEEBDFlF9bZtlNAM8=;
  b=D7Usqk/MQSoXJ/QAgxZuVxWxLurABBi4t1tmymVico/ZS0R/waiOmWsy
   1p1CCeqw6bY5kCI6t1XVALHXXEPSdk+w2+kEsMS7z0j1Qc7RDAk9OFpW6
   bBKpuxVlGpcTq7qusZFR2Ot0tzavyL0/n/j61R36ohLv8KNUBmc0rbKiO
   g=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="254688100"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:24:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:2197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id 2d891b05-ef54-4591-ac48-e22fb5545286; Fri, 13 Dec 2024 09:24:30 +0000 (UTC)
X-Farcaster-Flow-ID: 2d891b05-ef54-4591-ac48-e22fb5545286
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:24:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:24:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 07/15] socket: Add hold_net flag to struct proto_accept_arg.
Date: Fri, 13 Dec 2024 18:21:44 +0900
Message-ID: <20241213092152.14057-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns refcnt
held.  Then, sk_alloc() need the hold_net flag passed from the accept()
paths.

Let's add a new hold_net flag to struct proto_accept_arg and pass it
down before sk_alloc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/xen/pvcalls-back.c | 1 +
 fs/ocfs2/cluster/tcp.c     | 2 ++
 include/net/sctp/structs.h | 2 +-
 include/net/sock.h         | 1 +
 io_uring/net.c             | 2 ++
 net/atm/svc.c              | 2 +-
 net/rds/tcp_listen.c       | 1 +
 net/sctp/ipv6.c            | 7 ++++---
 net/sctp/protocol.c        | 7 ++++---
 net/sctp/socket.c          | 2 +-
 net/socket.c               | 6 +++++-
 net/tipc/socket.c          | 2 +-
 12 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index fd7ed65e0197..f0f8b4862983 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -520,6 +520,7 @@ static void __pvcalls_back_accept(struct work_struct *work)
 	struct proto_accept_arg arg = {
 		.flags = O_NONBLOCK,
 		.kern = true,
+		.hold_net = false,
 	};
 	struct sock_mapping *map;
 	struct pvcalls_ioworker *iow;
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 2b8fa3e782fb..6ef03a02d19b 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1786,6 +1786,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
 	struct o2net_sock_container *sc = NULL;
 	struct proto_accept_arg arg = {
 		.flags = O_NONBLOCK,
+		.kern = false,
+		.hold_net = true,
 	};
 	struct o2net_node *nn;
 	unsigned int nofs_flag;
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 31248cfdfb23..ae2729ab2040 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -502,7 +502,7 @@ struct sctp_pf {
 	int  (*supported_addrs)(const struct sctp_sock *, __be16 *);
 	struct sock *(*create_accept_sk) (struct sock *sk,
 					  struct sctp_association *asoc,
-					  bool kern);
+					  struct proto_accept_arg *arg);
 	int (*addr_to_user)(struct sctp_sock *sk, union sctp_addr *addr);
 	void (*to_sk_saddr)(union sctp_addr *, struct sock *sk);
 	void (*to_sk_daddr)(union sctp_addr *, struct sock *sk);
diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..9963dccec2f8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1214,6 +1214,7 @@ struct proto_accept_arg {
 	int err;
 	int is_empty;
 	bool kern;
+	bool hold_net;
 };
 
 /* Networking protocol blocks we attach to sockets.
diff --git a/io_uring/net.c b/io_uring/net.c
index df1f7dc6f1c8..93418208b37d 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1559,6 +1559,8 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	bool fixed = !!accept->file_slot;
 	struct proto_accept_arg arg = {
 		.flags = force_nonblock ? O_NONBLOCK : 0,
+		.kern = false,
+		.hold_net = true,
 	};
 	struct file *file;
 	unsigned cflags;
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 9795294f4c1e..a23699acb3fd 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -336,7 +336,7 @@ static int svc_accept(struct socket *sock, struct socket *newsock,
 
 	lock_sock(sk);
 
-	error = svc_create(sock_net(sk), newsock, 0, arg->kern, !arg->kern);
+	error = svc_create(sock_net(sk), newsock, 0, arg->kern, arg->hold_net);
 	if (error)
 		goto out;
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..69aaf03ab93e 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -108,6 +108,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	struct proto_accept_arg arg = {
 		.flags = O_NONBLOCK,
 		.kern = true,
+		.hold_net = false,
 	};
 #if !IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr saddr, daddr;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index a9ed2ccab1bd..2c4e4dd79246 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -777,13 +777,14 @@ static enum sctp_scope sctp_v6_scope(union sctp_addr *addr)
 /* Create and initialize a new sk for the socket to be returned by accept(). */
 static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 					     struct sctp_association *asoc,
-					     bool kern)
+					     struct proto_accept_arg *arg)
 {
-	struct sock *newsk;
 	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
 	struct sctp6_sock *newsctp6sk;
+	struct sock *newsk;
 
-	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
+	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot,
+			 arg->kern);
 	if (!newsk)
 		goto out;
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 8b9a1b96695e..7b2ae3df171a 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -581,12 +581,13 @@ static int sctp_v4_is_ce(const struct sk_buff *skb)
 /* Create and initialize a new sk for the socket returned by accept(). */
 static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 					     struct sctp_association *asoc,
-					     bool kern)
+					     struct proto_accept_arg *arg)
 {
-	struct sock *newsk = sk_alloc(sock_net(sk), PF_INET, GFP_KERNEL,
-			sk->sk_prot, kern);
 	struct inet_sock *newinet;
+	struct sock *newsk;
 
+	newsk = sk_alloc(sock_net(sk), PF_INET, GFP_KERNEL, sk->sk_prot,
+			 arg->kern);
 	if (!newsk)
 		goto out;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 36ee34f483d7..a1add0b7fd9f 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4887,7 +4887,7 @@ static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 	 */
 	asoc = list_entry(ep->asocs.next, struct sctp_association, asocs);
 
-	newsk = sp->pf->create_accept_sk(sk, asoc, arg->kern);
+	newsk = sp->pf->create_accept_sk(sk, asoc, arg);
 	if (!newsk) {
 		error = -ENOMEM;
 		goto out;
diff --git a/net/socket.c b/net/socket.c
index d1b4dadd67e4..a8796d7f06be 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1971,7 +1971,10 @@ struct file *do_accept(struct file *file, struct proto_accept_arg *arg,
 static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_sockaddr,
 			      int __user *upeer_addrlen, int flags)
 {
-	struct proto_accept_arg arg = { };
+	struct proto_accept_arg arg = {
+		.kern = false,
+		.hold_net = true,
+	};
 	struct file *newfile;
 	int newfd;
 
@@ -3586,6 +3589,7 @@ int kernel_accept(struct socket *sock, struct socket **newsock, int flags)
 	struct proto_accept_arg arg = {
 		.flags = flags,
 		.kern = true,
+		.hold_net = false,
 	};
 	int err;
 
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4ee0bd1043e1..26566ff1d4c7 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2737,7 +2737,7 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock,
 	buf = skb_peek(&sk->sk_receive_queue);
 
 	res = tipc_sk_create(sock_net(sock->sk), new_sock, 0,
-			     arg->kern, !arg->kern);
+			     arg->kern, arg->hold_net);
 	if (res)
 		goto exit;
 	security_sk_clone(sock->sk, new_sock->sk);
-- 
2.39.5 (Apple Git-154)


