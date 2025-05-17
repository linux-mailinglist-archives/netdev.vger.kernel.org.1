Return-Path: <netdev+bounces-191271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E50ABA80D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE94F1BA42FB
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066218CC15;
	Sat, 17 May 2025 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bXBkl6wv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBD16EB7C
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453993; cv=none; b=KOvVQ8aLouXDwZ1m9HinCAhIccC+uWe/WH7k+x3dpNjveVN410LJ2fnnHSOe+Jjgtp1P1pXNSC9VYvUua1T4EVxko+ZXpDdGGv3DzHbq8a+HBGgq3oxYHgB+mBrZmIunWrkS0UzxSr5Q2cN0oU9uLz/9WcbsauhuAwohJq6JNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453993; c=relaxed/simple;
	bh=2ULAm+CKYAW6lHequ0zSvBtumcaIHkJv7UFkaijpQRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLiFoyzdqhORVpycQgkp5tNow/In3H+Vz39sklTy9Yg4x3yQdTp1rLEfXVg7mc1wlkRIoZdjaaqnRvrfZzglSK42Ir6jbAifTFJCtDyPG/Q/yJ1K369Uyrk7vx6BKgp0OegSiT2XLta6ga3gVUhXN94MWFu3ZnCGd3B2V+RRP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bXBkl6wv; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747453992; x=1778989992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1uwNbJuu5BD/ziokoVF8xmqw2tTFwKV0IGhzBVoLL0I=;
  b=bXBkl6wvxO8GX1NR0dQLruVYVkB6QENEGg+su7GlF4V++SuZYlZ2EDNu
   WKr+UvgU+cLYlibMGXNKnIOBiUnR1kA8uaA4UUvaMkTLa8gzbx2LqU4eJ
   uWStYSNEuxBhmF5DjzR3UROPqfrD5U9yIDhudbtH+w/mlZqmyQsJFDOLS
   RmdAFe2CVEWXywyW0gl5ogL63UpBdWYXX/bw0AP9ZVLkPkl888nzxgKN2
   7ZlP8MEkqLgCyQNJOflxji3V7mfuEee4U53YPwfoDaNtTnStVIzXfBPPV
   1uJ4mL5++vvl0HkqU+Eos82xztqy4e3JQsmK/ZRFajw3DvwWfHUxDh398
   w==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="406255471"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 03:53:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:52317]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.20:2525] with esmtp (Farcaster)
 id 2bf287ff-627d-418e-9f07-e8f8aa04c85f; Sat, 17 May 2025 03:53:09 +0000 (UTC)
X-Farcaster-Flow-ID: 2bf287ff-627d-418e-9f07-e8f8aa04c85f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:53:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:53:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion except for net/rds/.
Date: Fri, 16 May 2025 20:50:25 -0700
Message-ID: <20250517035120.55560-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517035120.55560-1-kuniyu@amazon.com>
References: <20250517035120.55560-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets."), TCP kernel socket has caused
many UAF.

We have converted such sockets to hold netns refcnt, and we have
the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.

  __sock_create_kern(..., &sock);
  sk_net_refcnt_upgrade(sock->sk);

Let's drop the conversion and use sock_create_kern() instead.

The changes for cifs, mptcp, nvme, and smc are straightforward.

For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
call __sock_create_kern() for others.

For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
sockets.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/nvme/host/tcp.c |  7 +++----
 fs/smb/client/connect.c | 11 ++---------
 net/mptcp/subflow.c     |  7 +------
 net/smc/af_smc.c        | 18 ++----------------
 net/sunrpc/svcsock.c    |  9 ++++++---
 net/sunrpc/xprtsock.c   |  8 ++++----
 6 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e187ae73f541..1f4b487358b9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1789,9 +1789,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = __sock_create_kern(current->nsproxy->net_ns,
-				 ctrl->addr.ss_family, SOCK_STREAM,
-				 IPPROTO_TCP, &queue->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       ctrl->addr.ss_family, SOCK_STREAM,
+			       IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1804,7 +1804,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		goto err_destroy_mutex;
 	}
 
-	sk_net_refcnt_upgrade(queue->sock->sk);
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 37a2ba38f10e..c7b4f5a7cca1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		socket = server->ssocket;
 	} else {
 		struct net *net = cifs_net_ns(server);
-		struct sock *sk;
 
-		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
-					IPPROTO_TCP, &server->ssocket);
+		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
+				      IPPROTO_TCP, &server->ssocket);
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
index 602e689e991f..00e5cecb7683 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1757,7 +1757,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
@@ -1770,11 +1770,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d998ffed1712..6140a9e386d0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3328,22 +3328,8 @@ static const struct proto_ops smc_sock_ops = {
 
 int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 {
-	struct smc_sock *smc = smc_sk(sk);
-	int rc;
-
-	rc = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-				&smc->clcsock);
-	if (rc)
-		return rc;
-
-	/* smc_clcsock_release() does not wait smc->clcsock->sk's
-	 * destruction;  its sk_state might not be TCP_CLOSE after
-	 * smc->sk is close()d, and TCP timers can be fired later,
-	 * which need net ref.
-	 */
-	sk = smc->clcsock->sk;
-	sk_net_refcnt_upgrade(sk);
-	return 0;
+	return sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+				&smc_sk(sk)->clcsock);
 }
 
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index adacfd03153a..94abb7514ece 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1516,7 +1516,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = __sock_create_kern(net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		error = sock_create_kern(net, family, type, protocol, &sock);
+	else
+		error = __sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
@@ -1541,8 +1544,8 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	newlen = error;
 
 	if (protocol == IPPROTO_TCP) {
-		sk_net_refcnt_upgrade(sock->sk);
-		if ((error = kernel_listen(sock, 64)) < 0)
+		error = kernel_listen(sock, 64);
+		if (error < 0)
 			goto bummer;
 	}
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 6fb921ce6cf2..f9576bd8f9c5 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1924,7 +1924,10 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	else
+		err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -1941,9 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP)
-		sk_net_refcnt_upgrade(sock->sk);
-
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
 		return ERR_CAST(filp);
-- 
2.49.0


