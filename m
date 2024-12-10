Return-Path: <netdev+bounces-150550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6569EA9DB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD62228592E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94058230D1D;
	Tue, 10 Dec 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ihdq8HrR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDF230D19
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816575; cv=none; b=M3gcQ3VP3F/YOqcc4ZGqrcdMUoC4GzdIyysyqwePks9yulxcff1tX3VtdwgpqRSzq1gMDPtKR7wcai4SZcT0kzRkx0Ji77rT023Nd7OmnFu6xwFD5yBC6q9s7GT2fTteoVsho69OpMMDvtz9Tx9nBGEM4Z2YYBVdoOBVI2a+hEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816575; c=relaxed/simple;
	bh=QbBq4GutTxTCgJFE6KDOhqG8K5mzugIiyXQRW01bNA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEnVl5RXjgn76GlCjoxMGvuAIUiACRI3v0iPA2inYOD+aoNp2G6rj0ElfplDvUDhbF8eaDdxL1xNRXiOeQUzfCv9L657z/tPRI0ayz/yiFGD6G04lLoCuIv2/3ZGWoMCjJ1jnD7MwfRHwWPabpt1QKVsoH177dPCCZ6pBMsTn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ihdq8HrR; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816573; x=1765352573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rdeQ9TDRQv6K/DgBViYvacYBb4lh9VDpBpY4CLpeYgE=;
  b=Ihdq8HrR0n75mzxwY2srDIyHiW5vGcp7WHJViooLU/eTP25wz4bDB9j+
   FCQL4GI5iVcjatGWyLJkBaY/ImkQpyir2t0adRn3caTd24G2EysoGNvai
   ebwCrs4/1715RZp0nckZZSyxnuOaABUc+BejJ00hYj5nsscQ4PJAuCuyw
   U=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="151688456"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:42:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:3781]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.73:2525] with esmtp (Farcaster)
 id cff0fb36-f5d0-4bb1-bfe7-702f31c86445; Tue, 10 Dec 2024 07:42:53 +0000 (UTC)
X-Farcaster-Flow-ID: cff0fb36-f5d0-4bb1-bfe7-702f31c86445
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:42:52 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:42:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Matthieu Baerts
	<matttbe@kernel.org>, Allison Henderson <allison.henderson@oracle.com>,
	"Steve French" <sfrench@samba.org>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan
 Karcher <jaka@linux.ibm.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>
Subject: [PATCH v2 net-next 12/15] socket: Remove kernel socket conversion.
Date: Tue, 10 Dec 2024 16:38:26 +0900
Message-ID: <20241210073829.62520-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210073829.62520-1-kuniyu@amazon.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference count
the netns of kernel sockets."), TCP kernel socket has caused many UAF.

We have converted such sockets to hold netns refcnt, and we have the
same pattern in cifs, mptcp, rds, smc, and sunrpc.

Let's drop the conversion and use sock_create_net() instead.

The changes for cifs, mptcp, and smc are straightforward.

For rds, we need to move maybe_get_net() before sock_create_net() and
sock->ops->accept().

For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
call sock_create_kern() for others.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Acked-by: Allison Henderson <allison.henderson@oracle.com>
---
v2: Collect Acked-by from MPTCP and RDS maintainers

Cc: Steve French <sfrench@samba.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/connect.c | 12 ++----------
 net/mptcp/subflow.c     | 10 +---------
 net/rds/tcp.c           | 13 -------------
 net/rds/tcp_connect.c   | 15 +++++++++++----
 net/rds/tcp_listen.c    | 14 ++++++++++++--
 net/smc/af_smc.c        | 20 ++------------------
 net/sunrpc/svcsock.c    | 12 ++++++------
 net/sunrpc/xprtsock.c   | 11 ++++-------
 8 files changed, 38 insertions(+), 69 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9f6daa32c083..adac00cad15a 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3132,21 +3132,13 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	if (server->ssocket) {
 		socket = server->ssocket;
 	} else {
-		struct net *net = cifs_net_ns(server);
-		struct sock *sk;
-
-		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
-				      IPPROTO_TCP, &server->ssocket);
+		rc = sock_create_net(cifs_net_ns(server), sfamily, SOCK_STREAM,
+				     IPPROTO_TCP, &server->ssocket);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
 		}
 
-		sk = server->ssocket->sk;
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-		sk->sk_net_refcnt = 1;
-		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		socket = server->ssocket;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fc534290f119..e7e8972bdfca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1755,7 +1755,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err = sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
@@ -1768,14 +1768,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
-	sf->sk->sk_net_refcnt = 1;
-	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
-
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index f7e8a309f678..4509900476f7 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -494,20 +494,7 @@ bool rds_tcp_tune(struct socket *sock)
 
 	tcp_sock_set_nodelay(sock->sk);
 	lock_sock(sk);
-	/* TCP timer functions might access net namespace even after
-	 * a process which created this net namespace terminated.
-	 */
-	if (!sk->sk_net_refcnt) {
-		if (!maybe_get_net(net)) {
-			release_sock(sk);
-			return false;
-		}
-		/* Update ns_tracker to current stack trace and refcounted tracker */
-		__netns_tracker_free(net, &sk->ns_tracker, false);
 
-		sk->sk_net_refcnt = 1;
-		netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
-	}
 	rtn = net_generic(net, rds_tcp_netid);
 	if (rtn->sndbuf_size > 0) {
 		sk->sk_sndbuf = rtn->sndbuf_size;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..19d7e6f7323d 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -93,6 +93,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct sockaddr *addr;
+	struct net *net;
 	int addrlen;
 	bool isv6;
 	int ret;
@@ -107,20 +108,26 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 
 	mutex_lock(&tc->t_conn_path_lock);
 
+	net = rds_conn_net(conn);
+
 	if (rds_conn_path_up(cp)) {
 		mutex_unlock(&tc->t_conn_path_lock);
 		return 0;
 	}
+
+	if (!maybe_get_net(net))
+		return -EINVAL;
+
 	if (ipv6_addr_v4mapped(&conn->c_laddr)) {
-		ret = sock_create_kern(rds_conn_net(conn), PF_INET,
-				       SOCK_STREAM, IPPROTO_TCP, &sock);
+		ret = sock_create_net(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 		isv6 = false;
 	} else {
-		ret = sock_create_kern(rds_conn_net(conn), PF_INET6,
-				       SOCK_STREAM, IPPROTO_TCP, &sock);
+		ret = sock_create_net(net, PF_INET6, SOCK_STREAM, IPPROTO_TCP, &sock);
 		isv6 = true;
 	}
 
+	put_net(net);
+
 	if (ret < 0)
 		goto out;
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 69aaf03ab93e..440ac9057148 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -101,6 +101,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	struct rds_connection *conn;
 	int ret;
 	struct inet_sock *inet;
+	struct net *net;
 	struct rds_tcp_connection *rs_tcp = NULL;
 	int conn_state;
 	struct rds_conn_path *cp;
@@ -108,7 +109,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	struct proto_accept_arg arg = {
 		.flags = O_NONBLOCK,
 		.kern = true,
-		.hold_net = false,
+		.hold_net = true,
 	};
 #if !IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr saddr, daddr;
@@ -118,13 +119,22 @@ int rds_tcp_accept_one(struct socket *sock)
 	if (!sock) /* module unload or netns delete in progress */
 		return -ENETUNREACH;
 
+	net = sock_net(sock->sk);
+
+	if (!maybe_get_net(net))
+		return -EINVAL;
+
 	ret = sock_create_lite(sock->sk->sk_family,
 			       sock->sk->sk_type, sock->sk->sk_protocol,
 			       &new_sock);
-	if (ret)
+	if (ret) {
+		put_net(net);
 		goto out;
+	}
 
 	ret = sock->ops->accept(sock, new_sock, &arg);
+	put_net(net);
+
 	if (ret < 0)
 		goto out;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 10f9968f87b1..d53d4e14173d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3307,24 +3307,8 @@ static const struct proto_ops smc_sock_ops = {
 
 int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 {
-	struct smc_sock *smc = smc_sk(sk);
-	int rc;
-
-	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-			      &smc->clcsock);
-	if (rc)
-		return rc;
-
-	/* smc_clcsock_release() does not wait smc->clcsock->sk's
-	 * destruction;  its sk_state might not be TCP_CLOSE after
-	 * smc->sk is close()d, and TCP timers can be fired later,
-	 * which need net ref.
-	 */
-	sk = smc->clcsock->sk;
-	__netns_tracker_free(net, &sk->ns_tracker, false);
-	sk->sk_net_refcnt = 1;
-	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-	return 0;
+	return sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP,
+			       &smc_sk(sk)->clcsock);
 }
 
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index bdea406308a8..cde5765f6f81 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1526,7 +1526,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = sock_create_kern(net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		error = sock_create_net(net, family, type, protocol, &sock);
+	else
+		error = sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
@@ -1551,11 +1554,8 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	newlen = error;
 
 	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
-
-		if ((error = kernel_listen(sock, 64)) < 0)
+		error = kernel_listen(sock, 64);
+		if (error < 0)
 			goto bummer;
 	}
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 1bc3a480d919..f3e139c30442 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1924,7 +1924,10 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		err = sock_create_net(xprt->xprt_net, family, type, protocol, &sock);
+	else
+		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -1941,12 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
-	}
-
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
 		return ERR_CAST(filp);
-- 
2.39.5 (Apple Git-154)


