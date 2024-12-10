Return-Path: <netdev+bounces-150539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B351C9EA9BD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB05284E10
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5B22B8D1;
	Tue, 10 Dec 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u34Myink"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2E192D66
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816345; cv=none; b=Ep/gXJ2E6Etnq241b9Fp8RXnOAhEVHOywlBrQNsHH+IEZTTbQ2mxXlKYjVLuuMGuqytUDNUZuihBCgkdVIZPCE17NXDNqNuxZGetErdzsbSrLdofTp/NOoijdu2j8vaSVhMF3hYI1WAqOja2HCA2KDsIoEIsrVbc9VNT5TkMHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816345; c=relaxed/simple;
	bh=02BEZQ6av58F84QNfSjK/uv8Faq9KSIno88KMvFfsnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5e/d0SS1v3Lkn0BMDt9+XgeH6dgIWeazh+PncbPEfeRHVwprE0YnPtQAp8yBOpE4tTs4DY9kdP2q7R6Z9LilS7EidWZ3xZ1dJ4Q+Wm0ldO1yXBe83WcUHUI7hMz6y7FUidLYXSIIknJqj15yG3CBhSC0dZoihKbTRVWVSHulEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u34Myink; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816344; x=1765352344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJhgRo5zVtxpoIKFCJNnf302P/ysAb1ce/vpO+xCBsA=;
  b=u34MyinkakvN8bnKvGngY6WH6RitThw0t5ZejTH0TIZsy0A+cijg79Pn
   5gVthO9MD7eNLEGU7q8VVzD49VLYWAf5CYIu6wsYq2cT7FtdNm22qgbBu
   AC2QjSZaOeN+acmHLUAFjmeY2hnK2LT42KsRiBbignkA0ZxxEJ0BJN/VI
   k=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="151687886"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:39:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:56647]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.92:2525] with esmtp (Farcaster)
 id 4b21a65f-3937-4cd7-b2b8-b0444c57ed8b; Tue, 10 Dec 2024 07:39:02 +0000 (UTC)
X-Farcaster-Flow-ID: 4b21a65f-3937-4cd7-b2b8-b0444c57ed8b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:39:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:38:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/15] socket: Un-export __sock_create().
Date: Tue, 10 Dec 2024 16:38:15 +0900
Message-ID: <20241210073829.62520-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
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


