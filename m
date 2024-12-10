Return-Path: <netdev+bounces-150548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC37F9EA9CC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62882812D8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47F22CBDE;
	Tue, 10 Dec 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="McCnzQW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC881172BD5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816532; cv=none; b=G3o2H4uXOV27N7MQh2eKNfjzKnWEvDW5/YjPsL5ri9OVWkXMugPaGlC0pD3/b6cZnbmBgDeUAEDxmSBKxPc/+682MfKi1tqs9HLgwoB+hwfykf/pjdYFSNNMKDetZDISPFyFbwJq48AKofKDN/gQEiByuDQ7mlKYYXMxSB0C818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816532; c=relaxed/simple;
	bh=ysJaE9EIgNuyaQbc2OaOuQs9kH9i4orDEPebQG0wnd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpQit+3YHACdoVWvP2oiNbxpTTh5ITKOJOL0OCozfMJLT6lqzbCeIxVuy04Y8G04oXDAwnuU8ylW3SFYbmg20tuNLAPA281x7YWXWGcgI0zm1cVM1MnNJMa+/XGYXF3/lZ1sOWKa3ZHWFyiTVdHUy/UtWY1ApuQKmngnEikTr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=McCnzQW2; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816531; x=1765352531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrxBmWYkNp7RkQ+3erzUP+TmC3IWZ6gv5Du7HbbRb/Q=;
  b=McCnzQW2QDEB4lfRhcDJqBs2QTmLwVEZEEjxXgKtA6T0+dif+48pVYXx
   yEY3LOFM/bfN8I0PvceMl/3DhTOz23ssFUrEUhcMITvMPolu9ATpiGkSn
   RG6wCStWf9pYxZ8K5X+G2j1cy1qD+i9I7r8ZNNqoB+4KtXuSvfLACf0aY
   U=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="391851928"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:42:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:52256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.73:2525] with esmtp (Farcaster)
 id a7715969-da7f-4b91-8be9-7f25229094cd; Tue, 10 Dec 2024 07:42:10 +0000 (UTC)
X-Farcaster-Flow-ID: a7715969-da7f-4b91-8be9-7f25229094cd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:42:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:42:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/15] socket: Don't count kernel sockets in /proc/net/sockstat.
Date: Tue, 10 Dec 2024 16:38:24 +0900
Message-ID: <20241210073829.62520-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The first line in /proc/net/sockstat shows the number of
sockets counted by sock_inuse_add().

  $ cat /proc/net/sockstat
  sockets: used 169

The count initially showed the number of userspace sockets,
but now it includes some kernel sockets, which is confusing.

This is because __sk_free() decrements the count based on
sk->sk_net_refcnt, which should be sk->sk_kern_sock.

Let's call sock_inuse_add() based on sk->sk_kern_sock.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/smb/client/connect.c |  1 -
 net/core/sock.c         | 17 ++++++++++-------
 net/mptcp/subflow.c     |  2 +-
 net/rds/tcp.c           |  1 -
 net/smc/af_smc.c        |  1 -
 net/sunrpc/svcsock.c    |  2 +-
 net/sunrpc/xprtsock.c   |  1 -
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 1efef860d20c..9f6daa32c083 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3146,7 +3146,6 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		__netns_tracker_free(net, &sk->ns_tracker, false);
 		sk->sk_net_refcnt = 1;
 		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
 
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
diff --git a/net/core/sock.c b/net/core/sock.c
index 11aa6d8c0cdd..4041152c7024 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2227,16 +2227,17 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 
 		DEBUG_NET_WARN_ON_ONCE(!kern && !hold_net);
 		sk->sk_kern_sock = kern;
+		if (likely(!kern))
+			sock_inuse_add(net, 1);
+
 		sock_lock_init(sk);
 
 		sk->sk_net_refcnt = hold_net;
-		if (likely(sk->sk_net_refcnt)) {
+		if (likely(sk->sk_net_refcnt))
 			get_net_track(net, &sk->ns_tracker, priority);
-			sock_inuse_add(net, 1);
-		} else {
+		else
 			__netns_tracker_alloc(net, &sk->ns_tracker,
 					      false, priority);
-		}
 
 		sock_net_set(sk, net);
 		refcount_set(&sk->sk_wmem_alloc, 1);
@@ -2314,7 +2315,7 @@ void sk_destruct(struct sock *sk)
 
 static void __sk_free(struct sock *sk)
 {
-	if (likely(sk->sk_net_refcnt))
+	if (likely(!sk->sk_kern_sock))
 		sock_inuse_add(sock_net(sk), -1);
 
 	if (unlikely(sk->sk_net_refcnt && sock_diag_has_destroy_listeners(sk)))
@@ -2383,10 +2384,11 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	newsk->sk_prot_creator = prot;
 
-	/* SANITY */
+	if (likely(!sk->sk_kern_sock))
+		sock_inuse_add(sock_net(newsk), 1);
+
 	if (likely(newsk->sk_net_refcnt)) {
 		get_net_track(sock_net(newsk), &newsk->ns_tracker, priority);
-		sock_inuse_add(sock_net(newsk), 1);
 	} else {
 		/* Kernel sockets are not elevating the struct net refcount.
 		 * Instead, use a tracker to more easily detect if a layer
@@ -2396,6 +2398,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		__netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker,
 				      false, priority);
 	}
+
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
 	bh_lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd021cf8286e..fc534290f119 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1775,7 +1775,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
 	sf->sk->sk_net_refcnt = 1;
 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
-	sock_inuse_add(net, 1);
+
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 351ac1747224..f7e8a309f678 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -507,7 +507,6 @@ bool rds_tcp_tune(struct socket *sock)
 
 		sk->sk_net_refcnt = 1;
 		netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
 	}
 	rtn = net_generic(net, rds_tcp_netid);
 	if (rtn->sndbuf_size > 0) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9b5738a55dde..10f9968f87b1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3324,7 +3324,6 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 	__netns_tracker_free(net, &sk->ns_tracker, false);
 	sk->sk_net_refcnt = 1;
 	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-	sock_inuse_add(net, 1);
 	return 0;
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 9583bad3d150..bdea406308a8 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1554,7 +1554,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
 		sock->sk->sk_net_refcnt = 1;
 		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
+
 		if ((error = kernel_listen(sock, 64)) < 0)
 			goto bummer;
 	}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index feb1768e8a57..1bc3a480d919 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1945,7 +1945,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
 		sock->sk->sk_net_refcnt = 1;
 		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(xprt->xprt_net, 1);
 	}
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
-- 
2.39.5 (Apple Git-154)


