Return-Path: <netdev+bounces-151663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5019F07D8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284862832C5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DE1B0F04;
	Fri, 13 Dec 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H5j7tcdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AF1AD3F6
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081961; cv=none; b=R+1C7F1sUwHortcipKTe8P276CYpBrSZ/nwX6YDbCtnyDq/PoOynrnoo/Qjbs79Ogjh7YhZ7oUoZtc5hVM5rcLWV66g6lWomu05cBbqxwdT06hMAWZvbJTlxa62tVA8E9itksLcEQrzJ8SVtvSmm7Hc2Aeg+k0+rNBHRxFkRhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081961; c=relaxed/simple;
	bh=Do2pKLFpEvB3f4BLZFkiijQRsFj+VxC+DuC8DqnxYe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxIr+vXZT+H3uWEwXMC5elqUYfs+nX6q+SWkiO1jND0n0fQ8k9W5BTcpOVR2IYT00mRB5QyH1SY6Yvyx9n7TLqRh9j6PgMT3SSbXGOWVgRFV/tClGC0jhDK+m1o+RSic7weq86pHb05/5Pw4A318cGOvYvn77grwFqOqkQ6P6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H5j7tcdI; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081959; x=1765617959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZ2vgw2orZk9KHORph1AJ5PnQMCZ2qzYNZsXKW/zIQM=;
  b=H5j7tcdIEjuVrz2m8tHQp4LlF3Vq1V8oSBBMOvNqi5Mwrj3lj0zvGIc1
   NkNwNXcPdbCqQvbvkgGwyfmZF+7rwJ64GIM2PJjWxbTkjmxGQV7tNAmdX
   j0qlf3VXdi4cCZOD7wfWAvIeZqBIXGP2tqKASLltjlZJ0d7K3XlmuBFhw
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="49085574"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:25:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:42003]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.254:2525] with esmtp (Farcaster)
 id 9a1fdd71-af87-4e41-ae26-d1024f94f801; Fri, 13 Dec 2024 09:25:55 +0000 (UTC)
X-Farcaster-Flow-ID: 9a1fdd71-af87-4e41-ae26-d1024f94f801
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:25:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:25:50 +0000
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
Subject: [PATCH v3 net-next 11/15] socket: Remove kernel socket conversion.
Date: Fri, 13 Dec 2024 18:21:48 +0900
Message-ID: <20241213092152.14057-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
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
v3: Add missing mutex_unlock in rds_tcp_conn_path_connect().
v2: Collect Acked-by from MPTCP and RDS maintainers

Cc: Steve French <sfrench@samba.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/connect.c | 13 ++-----------
 net/mptcp/subflow.c     | 10 +---------
 net/rds/tcp.c           | 14 --------------
 net/rds/tcp_connect.c   | 21 +++++++++++++++------
 net/rds/tcp_listen.c    | 14 ++++++++++++--
 net/smc/af_smc.c        | 21 ++-------------------
 net/sunrpc/svcsock.c    | 12 ++++++------
 net/sunrpc/xprtsock.c   | 12 ++++--------
 8 files changed, 42 insertions(+), 75 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c36c1b4ffe6e..7a67b86c0423 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3130,22 +3130,13 @@ generic_ip_connect(struct TCP_Server_Info *server)
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
-		sock_inuse_add(net, 1);
-
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		socket = server->ssocket;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd021cf8286e..e7e8972bdfca 100644
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
-	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 351ac1747224..4509900476f7 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -494,21 +494,7 @@ bool rds_tcp_tune(struct socket *sock)
 
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
-		sock_inuse_add(net, 1);
-	}
 	rtn = net_generic(net, rds_tcp_netid);
 	if (rtn->sndbuf_size > 0) {
 		sk->sk_sndbuf = rtn->sndbuf_size;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..c9449780f952 100644
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
@@ -107,20 +108,28 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 
 	mutex_lock(&tc->t_conn_path_lock);
 
+	net = rds_conn_net(conn);
+
 	if (rds_conn_path_up(cp)) {
-		mutex_unlock(&tc->t_conn_path_lock);
-		return 0;
+		ret = 0;
+		goto out;
 	}
+
+	if (!maybe_get_net(net)) {
+		ret = -EINVAL;
+		goto out;
+	}
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
index 6e93f188a908..7b0de80b3aca 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3310,25 +3310,8 @@ static const struct proto_ops smc_sock_ops = {
 
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
-	sock_inuse_add(net, 1);
-	return 0;
+	return sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP,
+			       &smc_sk(sk)->clcsock);
 }
 
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 9583bad3d150..cde5765f6f81 100644
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
-		sock_inuse_add(net, 1);
-		if ((error = kernel_listen(sock, 64)) < 0)
+		error = kernel_listen(sock, 64);
+		if (error < 0)
 			goto bummer;
 	}
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index feb1768e8a57..f3e139c30442 100644
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
@@ -1941,13 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(xprt->xprt_net, 1);
-	}
-
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
 		return ERR_CAST(filp);
-- 
2.39.5 (Apple Git-154)


