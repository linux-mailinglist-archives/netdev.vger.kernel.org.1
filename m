Return-Path: <netdev+bounces-191267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E186ABA809
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28416A21B18
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956B915A86B;
	Sat, 17 May 2025 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ocYYD84g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD16B665
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453923; cv=none; b=VoLF2fzMmUeXJNoKNgkqQ4TWLNCfXtq14qhMSDqh0Y9qprM0zgbNEPfXCg2GSMEp4E8RadVY518btoXTN0u0peftcIwQ0tnLTLDckdraC6rxf/8Tw9dQI+fu6F23EhGu/8yDZ1AW7bGlJXrWQQJ7rHZL4DnVUqgZzb0uY6d6ggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453923; c=relaxed/simple;
	bh=j1MtWbvWjY+Mu0S+s8rPvxkuKiZ6C2PXXr3O/4lFZL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3JJaxxfq30izzT+c+z6+qNpmKpGeT2DgJ+7Iqkv23FlHGDTA9ANhC5LU8rdwsQ1RB327dWRL1DL5810e7Q34BxKBqJJIPh7kUg8in8V8iRsXdIypsUSQyc6J8YGWWc1kAQToZ2SQGrRl53fduXvrYLJdEgcu6PuOK/5wysAN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ocYYD84g; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747453921; x=1778989921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c5WvJZ1CwIYEvCzUVGQSnD+bN1x2Ev7nPRvcBiv8T44=;
  b=ocYYD84gUuIHZzolI6BaGzdM00tJcEon7+zy1/fuv/0rHsgoOA93jP5O
   sToPd30LOAwOEmrxvFhTDcZY/vL5DPA1yWxEgqxWuZ18RfeNq1XOmsYkt
   uhP4WJCmsDHEuotuwCCqi5z7oFX+LsCQ1lzUyBykyl7t2zty8nenOLB43
   1kqmRoqxRGBcZi/N9Wof2vHoV6RQMdy24sl1NsJ3vA7wH3ZXpxWI1owwV
   HKXmujBqoXHlM26oDRDbKnTURZsuxc1ez1CSF53piwTBBB4DJlpFo3Cjq
   CkKi6bch/3XdiwhY40WXh8rXTfo6Y6OKyihXT6/vikjvkvVioc5as7D7N
   g==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="723747455"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 03:51:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:53621]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id f9e1d321-eeba-468d-b8b3-dd4df656ee67; Sat, 17 May 2025 03:51:56 +0000 (UTC)
X-Farcaster-Flow-ID: f9e1d321-eeba-468d-b8b3-dd4df656ee67
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:51:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:51:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/6] socket: Un-export __sock_create().
Date: Fri, 16 May 2025 20:50:22 -0700
Message-ID: <20250517035120.55560-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
sock_create_kern"), we no longer need to export __sock_create()
and can replace all non-core users with sock_create_kern().

Let's convert them and un-export __sock_create().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/smb/client/connect.c        |  4 ++--
 include/linux/net.h            |  2 --
 net/9p/trans_fd.c              |  9 +++++----
 net/handshake/handshake-test.c | 32 ++++++++++++++------------------
 net/socket.c                   |  3 +--
 net/sunrpc/clnt.c              |  4 ++--
 net/sunrpc/svcsock.c           |  2 +-
 net/sunrpc/xprtsock.c          |  6 +++---
 net/wireless/nl80211.c         |  4 ++--
 9 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 6bf04d9a5491..c251a23a6447 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3350,8 +3350,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
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
index 0ff950eecc6b..26aaaa841f48 100644
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
index 339ec4e54778..842977f309b3 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1006,8 +1006,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 
 	client->trans_opts.tcp.port = opts.port;
 	client->trans_opts.tcp.privport = opts.privport;
-	err = __sock_create(current->nsproxy->net_ns, stor.ss_family,
-			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
+
+	err = sock_create_kern(current->nsproxy->net_ns, stor.ss_family,
+			       SOCK_STREAM, IPPROTO_TCP, &csocket);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
@@ -1057,8 +1058,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
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
index 9a0e720f0859..241d9767ae69 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(sock_wake_async);
  *	This function internally uses GFP_KERNEL.
  */
 
-int __sock_create(struct net *net, int family, int type, int protocol,
+static int __sock_create(struct net *net, int family, int type, int protocol,
 			 struct socket **res, int kern)
 {
 	int err;
@@ -1581,7 +1581,6 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	rcu_read_unlock();
 	goto out_sock_release;
 }
-EXPORT_SYMBOL(__sock_create);
 
 /**
  *	sock_create - creates a socket
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6f75862d9782..f9f340171530 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1455,8 +1455,8 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
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
index 72e5a01df3d3..e2c69ab17ac5 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1516,7 +1516,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = __sock_create(net, family, type, protocol, &sock, 1);
+	error = sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 83cc095846d3..5ffe88145193 100644
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
@@ -1999,8 +1999,8 @@ static int xs_local_setup_socket(struct sock_xprt *transport)
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
index fd5f79266471..98a7298e427d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13750,8 +13750,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
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
2.49.0


