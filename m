Return-Path: <netdev+bounces-149621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B139E6846
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5D280F97
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583681DB94F;
	Fri,  6 Dec 2024 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XIhrSRlw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0B2F5E
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471739; cv=none; b=f2t1RGPxwWihub521ssLaHZWW8r4cZQKbz3nhpXWRC/BvDZAhMq9fE3tVtOU+HmvhaJ0FhfcCOavTT0OgY+S4MnHvdraADZbBoHk3sjppU0Z97JsXYGxinowwML+qhQB+VgpmzGM4ogzczb3bT1dV4HBEEgd5z6TOsSM9pWZK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471739; c=relaxed/simple;
	bh=02BEZQ6av58F84QNfSjK/uv8Faq9KSIno88KMvFfsnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rpn0qn2y3IKybWtz4XeFuA8+m5vD9qTV4Gl8tlkg8MhUqPIWwNl68e9y5aA8jEfiNJ59FTGRmMDIvoEggXpzXO7bmoMm0wknfSpQxw/2vEmgY1v809/OtZ4MwgxB1Xoazmb8lJOPNdnnfmj5K2u2/ar6LnZfrvvCP15GiD5mf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XIhrSRlw; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471737; x=1765007737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJhgRo5zVtxpoIKFCJNnf302P/ysAb1ce/vpO+xCBsA=;
  b=XIhrSRlwQOHTDGQy+BZ2vMXEpPpqA0HHijTXQYDBhtHplAgGn483EUXy
   wk23nt6ag/RcE/Mbn3gHbvlGvgRD6H8WwlV94seTtz7Yr88bdu7maZNKa
   S46jB6z0SANM4H8aAN5Gj1RtzxHs7JXEh5RKjCowQtFGdeNRmSU2mc+Q3
   8=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="700866065"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:55:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:51255]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 66f5f705-833e-4928-afc0-745703386a7e; Fri, 6 Dec 2024 07:55:34 +0000 (UTC)
X-Farcaster-Flow-ID: 66f5f705-833e-4928-afc0-745703386a7e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:55:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:55:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/15] socket: Un-export __sock_create().
Date: Fri, 6 Dec 2024 16:54:50 +0900
Message-ID: <20241206075504.24153-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
sock_create_kern"), we no longer need to export __sock_create()
and can replace all non-core users with sock_create_kern().

Let's convert them and un-export __sock_create().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/smb/client/connect.c        |  4 ++--
 include/linux/net.h            |  2 --
 net/9p/trans_fd.c              |  8 ++++----
 net/handshake/handshake-test.c | 32 ++++++++++++++------------------
 net/socket.c                   |  3 +--
 net/sunrpc/clnt.c              |  4 ++--
 net/sunrpc/svcsock.c           |  2 +-
 net/sunrpc/xprtsock.c          |  6 +++---
 net/wireless/nl80211.c         |  4 ++--
 9 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 56b3a9eb9b05..1efef860d20c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3135,8 +3135,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		struct net *net = cifs_net_ns(server);
 		struct sock *sk;
 
-		rc = __sock_create(net, sfamily, SOCK_STREAM,
-				   IPPROTO_TCP, &server->ssocket, 1);
+		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
+				      IPPROTO_TCP, &server->ssocket);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
diff --git a/include/linux/net.h b/include/linux/net.h
index b75bc534c1b3..68ac97e301be 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -251,8 +251,6 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
-int __sock_create(struct net *net, int family, int type, int proto,
-		  struct socket **res, int kern);
 int sock_create(int family, int type, int proto, struct socket **res);
 int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138..83f81da24727 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1011,8 +1011,8 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	sin_server.sin_family = AF_INET;
 	sin_server.sin_addr.s_addr = in_aton(addr);
 	sin_server.sin_port = htons(opts.port);
-	err = __sock_create(current->nsproxy->net_ns, PF_INET,
-			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
+	err = sock_create_kern(current->nsproxy->net_ns, PF_INET,
+			       SOCK_STREAM, IPPROTO_TCP, &csocket);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
@@ -1062,8 +1062,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, addr);
-	err = __sock_create(current->nsproxy->net_ns, PF_UNIX,
-			    SOCK_STREAM, 0, &csocket, 1);
+	err = sock_create_kern(current->nsproxy->net_ns, PF_UNIX,
+			       SOCK_STREAM, 0, &csocket);
 	if (err < 0) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..4f300504f3e5 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -143,14 +143,18 @@ static void handshake_req_alloc_case(struct kunit *test)
 	kfree(result);
 }
 
+static int handshake_sock_create(struct socket **sock)
+{
+	return sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, sock);
+}
+
 static void handshake_req_submit_test1(struct kunit *test)
 {
 	struct socket *sock;
 	int err, result;
 
 	/* Arrange */
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	/* Act */
@@ -190,8 +194,7 @@ static void handshake_req_submit_test3(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	sock->file = NULL;
 
@@ -216,8 +219,7 @@ static void handshake_req_submit_test4(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
@@ -251,8 +253,7 @@ static void handshake_req_submit_test5(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
@@ -289,8 +290,7 @@ static void handshake_req_submit_test6(struct kunit *test)
 	req2 = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req2);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
@@ -321,8 +321,7 @@ static void handshake_req_cancel_test1(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
@@ -357,8 +356,7 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
@@ -399,8 +397,7 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
@@ -457,8 +454,7 @@ static void handshake_req_destroy_test1(struct kunit *test)
 	req = handshake_req_alloc(&handshake_req_alloc_proto_destroy, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, req);
 
-	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			    &sock, 1);
+	err = handshake_sock_create(&sock);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f..433f346ffc64 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1484,7 +1484,7 @@ EXPORT_SYMBOL(sock_wake_async);
  *	This function internally uses GFP_KERNEL.
  */
 
-int __sock_create(struct net *net, int family, int type, int protocol,
+static int __sock_create(struct net *net, int family, int type, int protocol,
 			 struct socket **res, int kern)
 {
 	int err;
@@ -1598,7 +1598,6 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	rcu_read_unlock();
 	goto out_sock_release;
 }
-EXPORT_SYMBOL(__sock_create);
 
 /**
  *	sock_create - creates a socket
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0090162ee8c3..37935082d799 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1450,8 +1450,8 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 	struct socket *sock;
 	int err;
 
-	err = __sock_create(net, sap->sa_family,
-				SOCK_DGRAM, IPPROTO_UDP, &sock, 1);
+	err = sock_create_kern(net, sap->sa_family,
+			       SOCK_DGRAM, IPPROTO_UDP, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create UDP socket (%d)\n", err);
 		goto out;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 95397677673b..9583bad3d150 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1526,7 +1526,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = __sock_create(net, family, type, protocol, &sock, 1);
+	error = sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c60936d8cef7..feb1768e8a57 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1924,7 +1924,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = __sock_create(xprt->xprt_net, family, type, protocol, &sock, 1);
+	err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -2003,8 +2003,8 @@ static int xs_local_setup_socket(struct sock_xprt *transport)
 	struct socket *sock;
 	int status;
 
-	status = __sock_create(xprt->xprt_net, AF_LOCAL,
-					SOCK_STREAM, 0, &sock, 1);
+	status = sock_create_kern(xprt->xprt_net, AF_LOCAL,
+				  SOCK_STREAM, 0, &sock);
 	if (status < 0) {
 		dprintk("RPC:       can't create AF_LOCAL "
 			"transport socket (%d).\n", -status);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9d2edb71f981..6df6eb5d4a74 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13689,8 +13689,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
 	port = nla_get_u16_default(tb[NL80211_WOWLAN_TCP_SRC_PORT], 0);
 #ifdef CONFIG_INET
 	/* allocate a socket and port for it and use it */
-	err = __sock_create(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
-			    IPPROTO_TCP, &cfg->sock, 1);
+	err = sock_create_kern(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
+			       IPPROTO_TCP, &cfg->sock);
 	if (err) {
 		kfree(cfg);
 		return err;
-- 
2.39.5 (Apple Git-154)


