Return-Path: <netdev+bounces-149632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580039E6859
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DE41690F1
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6011DE4E4;
	Fri,  6 Dec 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SwThySv0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7011DE4C7
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471966; cv=none; b=cU1vWy6pmNZbQOq1vthoYjuoSrq+M83KG0G2TU178ffQRMQLyJHYqYG9o2rtiRqNQV2qvRZOnTHoCVEuXt3bIJ687A7k9H0Cr0cQlLPbktmcrkDbX1eRRrORAJNKYy2h2HYWeuyDZd51ocECiSxwzT7ohyFwWvmzYkkcfzLdc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471966; c=relaxed/simple;
	bh=MIEraivyiJsurq1Ari7Q1CeXBMMBUqS+j18hyxdqeg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqaWZo+wRxfnxXKbFKXt4XH6iQe/68jKRsLC2P9SMik271pl0bgfpTtWFDQidl6+LFDRtMsnrgTxPg2OGgcE73jWjx6DCE+lgCnIaQKvv9WDnPMGPoGz4lDl3j853FSjeGPwjWDMdJh3diZ5wPbTfQ6Mq8SFzNXnMvy+d/9f9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SwThySv0; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471965; x=1765007965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aSvbt1Hy/A4djsiM4T75rpxvWy+RPhdu1+u3tNcN/o=;
  b=SwThySv0BkR0ZavrQDRLlD8p3UX96hPHSQsJNWT2QUsZNmZa+rKtd1kS
   NbKeLV8RwEqlzQixfHYiH5pj+m1u0H608iHatoCNCe6xSEjDmwdp5/G8F
   acoxt88koZ93s5jsz5BVCnQmOU87ZjTZ3u1JxFXZjLQ9PVRQ++2RPDerD
   o=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="358576514"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:59:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:41911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id 01931793-4cc7-4a5e-b6dc-d850b5a41139; Fri, 6 Dec 2024 07:59:22 +0000 (UTC)
X-Farcaster-Flow-ID: 01931793-4cc7-4a5e-b6dc-d850b5a41139
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:59:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:59:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Steve French
	<sfrench@samba.org>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Allison Henderson <allison.henderson@oracle.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "Chuck
 Lever" <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 net-next 12/15] socket: Remove kernel socket conversion.
Date: Fri, 6 Dec 2024 16:55:01 +0900
Message-ID: <20241206075504.24153-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
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
---
Cc: Steve French <sfrench@samba.org>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Allison Henderson <allison.henderson@oracle.com>
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


