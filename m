Return-Path: <netdev+bounces-151667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFA9F07DF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0846188065E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D91AF0CE;
	Fri, 13 Dec 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bi01gzcx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007961AF0B8
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082046; cv=none; b=OPVaQyV03UcYcGmJsPEsMIoqKsO7sKTEqM3auAguLvejO87LBTB2snV3pFnTjHKttEvRtldGT72g15gy4dnJodauvjzqaQN2zxsrj8SuLZbXaQ2k7Mdobt7EkCDHVaZyIf4ewf/wXfeq0v9chr2fHWY3qqklsvOUip7DCEgkU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082046; c=relaxed/simple;
	bh=qEBuDBy7HgUnD/S08mSJLPhyfg3lEIGe683ko/A/b+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLtMmyI15HrQcJmliKiDgE43NdcHYmEHZGZQWBCVLI2t50rubsjQVu+/TxOWmiziZr6do3ERuTGsBRnOLxacBjmu3pfWLhKwf96h5fR37WN0fQ5Lmv4wgubmNQoacuJuWDWXJVEiNoEhc4yeqzS87Ym5yNSEFRN0Q7VWz7dfE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bi01gzcx; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734082045; x=1765618045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5WCDsCV+mS+mqF+OlcLs7L1C9ji+El4sI/e6Q5pXhQ=;
  b=Bi01gzcxJTiQZ/u9YCLyFfirrU50uW8WkwD2Uu+HTa70JysXYmZ51D2H
   iOLS5ZEZo0TBSDwW++KUYzad7uwx+Xm3pVZUQxktLNDI7PNfR/DMrqcDM
   jAtzMqeYfNm1zdQMrZYTr57rQzJ8i5OaO9FGHDFXaVHbgZaQNV3VdU907
   A=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="455767331"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:27:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:10246]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.119:2525] with esmtp (Farcaster)
 id 84d56290-8b9c-4e68-9ad2-1ec429b67c59; Fri, 13 Dec 2024 09:27:19 +0000 (UTC)
X-Farcaster-Flow-ID: 84d56290-8b9c-4e68-9ad2-1ec429b67c59
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:27:19 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:27:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 15/15] socket: Rename sock_create_kern() to sock_create_net_noref().
Date: Fri, 13 Dec 2024 18:21:52 +0900
Message-ID: <20241213092152.14057-16-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_create_kern() is quite a bad name, and the non-netdev folks tend
to use it without taking care of the netns lifetime.

Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference count
the netns of kernel sockets."), TCP sockets created by sock_create_kern()
have caused many use-after-free.

Let's rename sock_create_kern() to sock_create_net_noref() and add fat
documentation so that we no longer introduce the same issue in the future.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/block/drbd/drbd_receiver.c            | 12 +++----
 drivers/infiniband/sw/rxe/rxe_qp.c            |  2 +-
 drivers/soc/qcom/qmi_interface.c              |  4 +--
 fs/afs/rxrpc.c                                |  3 +-
 fs/dlm/lowcomms.c                             |  8 ++---
 include/linux/net.h                           |  3 +-
 net/9p/trans_fd.c                             |  8 ++---
 net/bluetooth/rfcomm/core.c                   |  3 +-
 net/ceph/messenger.c                          |  6 ++--
 net/handshake/handshake-test.c                |  3 +-
 net/ipv4/af_inet.c                            |  3 +-
 net/ipv4/udp_tunnel_core.c                    |  2 +-
 net/ipv6/ip6_udp_tunnel.c                     |  4 +--
 net/l2tp/l2tp_core.c                          |  8 ++---
 net/mctp/test/route-test.c                    |  6 ++--
 net/mptcp/pm_netlink.c                        |  4 +--
 net/mptcp/subflow.c                           |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c               |  8 ++---
 net/qrtr/ns.c                                 |  6 ++--
 net/rds/tcp_listen.c                          |  4 +--
 net/rxrpc/rxperf.c                            |  4 +--
 net/sctp/socket.c                             |  2 +-
 net/smc/smc_inet.c                            |  2 +-
 net/socket.c                                  | 35 +++++++++++++------
 net/sunrpc/clnt.c                             |  4 +--
 net/sunrpc/svcsock.c                          |  2 +-
 net/sunrpc/xprtsock.c                         |  6 ++--
 net/tipc/topsrv.c                             |  4 +--
 net/wireless/nl80211.c                        |  4 +--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  4 +--
 30 files changed, 92 insertions(+), 74 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f54197768..39be44e5db8a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -618,9 +618,9 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	peer_addr_len = min_t(int, connection->peer_addr_len, sizeof(src_in6));
 	memcpy(&peer_in6, &connection->peer_addr, peer_addr_len);
 
-	what = "sock_create_kern";
-	err = sock_create_kern(&init_net, ((struct sockaddr *)&src_in6)->sa_family,
-			       SOCK_STREAM, IPPROTO_TCP, &sock);
+	what = "sock_create_net_noref";
+	err = sock_create_net_noref(&init_net, ((struct sockaddr *)&src_in6)->sa_family,
+				    SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (err < 0) {
 		sock = NULL;
 		goto out;
@@ -713,9 +713,9 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 	my_addr_len = min_t(int, connection->my_addr_len, sizeof(struct sockaddr_in6));
 	memcpy(&my_addr, &connection->my_addr, my_addr_len);
 
-	what = "sock_create_kern";
-	err = sock_create_kern(&init_net, ((struct sockaddr *)&my_addr)->sa_family,
-			       SOCK_STREAM, IPPROTO_TCP, &s_listen);
+	what = "sock_create_net_noref";
+	err = sock_create_net_noref(&init_net, ((struct sockaddr *)&my_addr)->sa_family,
+				    SOCK_STREAM, IPPROTO_TCP, &s_listen);
 	if (err) {
 		s_listen = NULL;
 		goto out;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 91d329e90308..250673cf6cbf 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -241,7 +241,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	/* if we don't finish qp create make sure queue is valid */
 	skb_queue_head_init(&qp->req_pkts);
 
-	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
+	err = sock_create_net_noref(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
 	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index bc6d6379d8b1..eb5a64f6fd6f 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -588,8 +588,8 @@ static struct socket *qmi_sock_create(struct qmi_handle *qmi,
 	struct socket *sock;
 	int ret;
 
-	ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
-			       PF_QIPCRTR, &sock);
+	ret = sock_create_net_noref(&init_net, AF_QIPCRTR, SOCK_DGRAM,
+				    PF_QIPCRTR, &sock);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 9f2a3bb56ec6..7443fe801894 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -44,7 +44,8 @@ int afs_open_socket(struct afs_net *net)
 
 	_enter("");
 
-	ret = sock_create_kern(net->net, AF_RXRPC, SOCK_DGRAM, PF_INET6, &socket);
+	ret = sock_create_net_noref(net->net, AF_RXRPC, SOCK_DGRAM, PF_INET6,
+				    &socket);
 	if (ret < 0)
 		goto error_1;
 
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index df40c3fd1070..b0450aff4cd4 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1579,8 +1579,8 @@ static int dlm_connect(struct connection *con)
 	}
 
 	/* Create a socket to communicate with */
-	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
-				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
+	result = sock_create_net_noref(&init_net, dlm_local_addr[0].ss_family,
+				       SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0)
 		return result;
 
@@ -1760,8 +1760,8 @@ static int dlm_listen_for_all(void)
 	if (result < 0)
 		return result;
 
-	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
-				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
+	result = sock_create_net_noref(&init_net, dlm_local_addr[0].ss_family,
+				       SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0) {
 		log_print("Can't create comms socket: %d", result);
 		return result;
diff --git a/include/linux/net.h b/include/linux/net.h
index 1ba4abb18863..582faf2fdd08 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -254,7 +254,8 @@ bool sock_is_registered(int family);
 int sock_create_user(int family, int type, int proto, struct socket **res);
 int sock_create_net(struct net *net, int family, int type, int proto,
 		    struct socket **res);
-int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
+int sock_create_net_noref(struct net *net, int family, int type, int proto,
+			  struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 83f81da24727..ae014999040f 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1011,8 +1011,8 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	sin_server.sin_family = AF_INET;
 	sin_server.sin_addr.s_addr = in_aton(addr);
 	sin_server.sin_port = htons(opts.port);
-	err = sock_create_kern(current->nsproxy->net_ns, PF_INET,
-			       SOCK_STREAM, IPPROTO_TCP, &csocket);
+	err = sock_create_net_noref(current->nsproxy->net_ns, PF_INET,
+				    SOCK_STREAM, IPPROTO_TCP, &csocket);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
@@ -1062,8 +1062,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, addr);
-	err = sock_create_kern(current->nsproxy->net_ns, PF_UNIX,
-			       SOCK_STREAM, 0, &csocket);
+	err = sock_create_net_noref(current->nsproxy->net_ns, PF_UNIX,
+				    SOCK_STREAM, 0, &csocket);
 	if (err < 0) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4c56ca5a216c..6204514667b6 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -200,7 +200,8 @@ static int rfcomm_l2sock_create(struct socket **sock)
 
 	BT_DBG("");
 
-	err = sock_create_kern(&init_net, PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP, sock);
+	err = sock_create_net_noref(&init_net, PF_BLUETOOTH, SOCK_SEQPACKET,
+				    BTPROTO_L2CAP, sock);
 	if (!err) {
 		struct sock *sk = (*sock)->sk;
 		sk->sk_data_ready   = rfcomm_l2data_ready;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..cb6a1532ff9f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -442,10 +442,10 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	     ceph_pr_addr(&con->peer_addr));
 	BUG_ON(con->sock);
 
-	/* sock_create_kern() allocates with GFP_KERNEL */
+	/* sock_create_net_noref() allocates with GFP_KERNEL */
 	noio_flag = memalloc_noio_save();
-	ret = sock_create_kern(read_pnet(&con->msgr->net), ss.ss_family,
-			       SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_net_noref(read_pnet(&con->msgr->net), ss.ss_family,
+				    SOCK_STREAM, IPPROTO_TCP, &sock);
 	memalloc_noio_restore(noio_flag);
 	if (ret)
 		return ret;
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 4f300504f3e5..54793f9e4d30 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -145,7 +145,8 @@ static void handshake_req_alloc_case(struct kunit *test)
 
 static int handshake_sock_create(struct socket **sock)
 {
-	return sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, sock);
+	return sock_create_net_noref(&init_net, PF_INET, SOCK_STREAM,
+				     IPPROTO_TCP, sock);
 }
 
 static void handshake_req_submit_test1(struct kunit *test)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d22bb0d3ddc1..03c3854f382a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1644,8 +1644,9 @@ int inet_ctl_sock_create(struct sock **sk, unsigned short family,
 			 struct net *net)
 {
 	struct socket *sock;
-	int rc = sock_create_kern(net, family, type, protocol, &sock);
+	int rc;
 
+	rc = sock_create_net_noref(net, family, type, protocol, &sock);
 	if (rc == 0) {
 		*sk = sock->sk;
 		(*sk)->sk_allocation = GFP_ATOMIC;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 619a53eb672d..e8e079ebca36 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -15,7 +15,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 	struct socket *sock = NULL;
 	struct sockaddr_in udp_addr;
 
-	err = sock_create_kern(net, AF_INET, SOCK_DGRAM, 0, &sock);
+	err = sock_create_net_noref(net, AF_INET, SOCK_DGRAM, 0, &sock);
 	if (err < 0)
 		goto error;
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..65d859c7d9c4 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -18,10 +18,10 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 		     struct socket **sockp)
 {
 	struct sockaddr_in6 udp6_addr = {};
-	int err;
 	struct socket *sock = NULL;
+	int err;
 
-	err = sock_create_kern(net, AF_INET6, SOCK_DGRAM, 0, &sock);
+	err = sock_create_net_noref(net, AF_INET6, SOCK_DGRAM, 0, &sock);
 	if (err < 0)
 		goto error;
 
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 369a2f2e459c..e43534185f45 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1494,8 +1494,8 @@ static int l2tp_tunnel_sock_create(struct net *net,
 		if (cfg->local_ip6 && cfg->peer_ip6) {
 			struct sockaddr_l2tpip6 ip6_addr = {0};
 
-			err = sock_create_kern(net, AF_INET6, SOCK_DGRAM,
-					       IPPROTO_L2TP, &sock);
+			err = sock_create_net_noref(net, AF_INET6, SOCK_DGRAM,
+						    IPPROTO_L2TP, &sock);
 			if (err < 0)
 				goto out;
 
@@ -1522,8 +1522,8 @@ static int l2tp_tunnel_sock_create(struct net *net,
 		{
 			struct sockaddr_l2tpip ip_addr = {0};
 
-			err = sock_create_kern(net, AF_INET, SOCK_DGRAM,
-					       IPPROTO_L2TP, &sock);
+			err = sock_create_net_noref(net, AF_INET, SOCK_DGRAM,
+						    IPPROTO_L2TP, &sock);
 			if (err < 0)
 				goto out;
 
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 8551dab1d1e6..f1b2cf0c8b48 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -310,7 +310,7 @@ static void __mctp_route_test_init(struct kunit *test,
 	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
-	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	rc = sock_create_net_noref(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	addr.smctp_family = AF_MCTP;
@@ -568,7 +568,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
-	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	rc = sock_create_net_noref(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	msk = container_of(sock->sk, struct mctp_sock, sk);
@@ -994,7 +994,7 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	rt = mctp_test_create_route(&init_net, dev->mdev, dst, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
-	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	rc = sock_create_net_noref(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7a0f7998376a..3dc40a364fb2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1083,8 +1083,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int backlog = 1024;
 	int err;
 
-	err = sock_create_kern(sock_net(sk), entry->addr.family,
-			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
+	err = sock_create_net_noref(sock_net(sk), entry->addr.family,
+				    SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
 	if (err)
 		return err;
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e7e8972bdfca..7162873a232a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1953,7 +1953,7 @@ static int subflow_ulp_init(struct sock *sk)
 	int err = 0;
 
 	/* disallow attaching ULP to a socket unless it has been
-	 * created with sock_create_kern()
+	 * created with sock_create_net()
 	 */
 	if (!sk->sk_kern_sock) {
 		err = -EOPNOTSUPP;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3402675bf521..e97cd30f196a 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1470,8 +1470,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	int result, salen;
 
 	/* First create a socket */
-	result = sock_create_kern(ipvs->net, ipvs->mcfg.mcast_af, SOCK_DGRAM,
-				  IPPROTO_UDP, &sock);
+	result = sock_create_net_noref(ipvs->net, ipvs->mcfg.mcast_af, SOCK_DGRAM,
+				       IPPROTO_UDP, &sock);
 	if (result < 0) {
 		pr_err("Error during creation of socket; terminating\n");
 		goto error;
@@ -1527,8 +1527,8 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 	int result, salen;
 
 	/* First create a socket */
-	result = sock_create_kern(ipvs->net, ipvs->bcfg.mcast_af, SOCK_DGRAM,
-				  IPPROTO_UDP, &sock);
+	result = sock_create_net_noref(ipvs->net, ipvs->bcfg.mcast_af, SOCK_DGRAM,
+				       IPPROTO_UDP, &sock);
 	if (result < 0) {
 		pr_err("Error during creation of socket; terminating\n");
 		goto error;
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3de9350cbf30..2f8f347150c0 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -692,8 +692,8 @@ int qrtr_ns_init(void)
 	INIT_LIST_HEAD(&qrtr_ns.lookups);
 	INIT_WORK(&qrtr_ns.work, qrtr_ns_worker);
 
-	ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
-			       PF_QIPCRTR, &qrtr_ns.sock);
+	ret = sock_create_net_noref(&init_net, AF_QIPCRTR, SOCK_DGRAM,
+				    PF_QIPCRTR, &qrtr_ns.sock);
 	if (ret < 0)
 		return ret;
 
@@ -735,7 +735,7 @@ int qrtr_ns_init(void)
 	 *  qrtr module is inserted successfully.
 	 *
 	 * However, the reference count is increased twice in
-	 * sock_create_kern(): one is to increase the reference count of owner
+	 * sock_create_net_noref(): one is to increase the reference count of owner
 	 * of qrtr socket's proto_ops struct; another is to increment the
 	 * reference count of owner of qrtr proto struct. Therefore, we must
 	 * decrement the module reference count twice to ensure that it keeps
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 440ac9057148..202afd77b532 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -289,8 +289,8 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 	int addr_len;
 	int ret;
 
-	ret = sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
-			       IPPROTO_TCP, &sock);
+	ret = sock_create_net_noref(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
+				    IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		rdsdebug("could not create %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 7ef93407be83..1c784d449a6b 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -182,8 +182,8 @@ static int rxperf_open_socket(void)
 	struct socket *socket;
 	int ret;
 
-	ret = sock_create_kern(&init_net, AF_RXRPC, SOCK_DGRAM, PF_INET6,
-			       &socket);
+	ret = sock_create_net_noref(&init_net, AF_RXRPC, SOCK_DGRAM, PF_INET6,
+				    &socket);
 	if (ret < 0)
 		goto error_1;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e49904f08559..fb8ed0290a4a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1328,7 +1328,7 @@ static int __sctp_setsockopt_connectx(struct sock *sk, struct sockaddr *kaddrs,
 		return err;
 
 	/* in-kernel sockets don't generally have a file allocated to them
-	 * if all they do is call sock_create_kern().
+	 * if all they do is call sock_create_net_noref().
 	 */
 	if (sk->sk_socket->file)
 		flags = sk->sk_socket->file->f_flags;
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a944e7dcb8b9..dbd76070e05e 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -111,7 +111,7 @@ static struct inet_protosw smc_inet6_protosw = {
 static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
 {
 	/* No need pass it through to clcsock, mss can always be set by
-	 * sock_create_kern or smc_setsockopt.
+	 * sock_create_net or smc_setsockopt.
 	 */
 	return 0;
 }
diff --git a/net/socket.c b/net/socket.c
index 992de3dd94b8..8f45d17e52c3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1665,23 +1665,36 @@ int sock_create_net(struct net *net, int family, int type, int protocol,
 EXPORT_SYMBOL(sock_create_net);
 
 /**
- *	sock_create_kern - creates a socket (kernel space)
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create_net_noref - creates a socket for kernel space
+ *
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
  *
- *	A wrapper around __sock_create().
- *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The socket is for kernel space and should not be exposed to
+ * userspace via a file descriptor nor BPF hooks except for LSM
+ * (see inet_create(), inet_release(), etc).
+ *
+ * The socket DOES NOT hold a reference count of @net to allow it to
+ * be removed; the caller MUST ensure that the socket is always freed
+ * before @net.
+ *
+ * @net MUST be alive as of calling sock_create_net_noref().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
  */
 
-int sock_create_kern(struct net *net, int family, int type, int protocol,
-		     struct socket **res)
+int sock_create_net_noref(struct net *net, int family, int type, int protocol,
+			  struct socket **res)
 {
 	return __sock_create(net, family, type, protocol, res, true, false);
 }
-EXPORT_SYMBOL(sock_create_kern);
+EXPORT_SYMBOL(sock_create_net_noref);
 
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 37935082d799..4e8723403e07 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1450,8 +1450,8 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 	struct socket *sock;
 	int err;
 
-	err = sock_create_kern(net, sap->sa_family,
-			       SOCK_DGRAM, IPPROTO_UDP, &sock);
+	err = sock_create_net_noref(net, sap->sa_family,
+				    SOCK_DGRAM, IPPROTO_UDP, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create UDP socket (%d)\n", err);
 		goto out;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index cde5765f6f81..e20465c20b16 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1529,7 +1529,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	if (protocol == IPPROTO_TCP)
 		error = sock_create_net(net, family, type, protocol, &sock);
 	else
-		error = sock_create_kern(net, family, type, protocol, &sock);
+		error = sock_create_net_noref(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index f3e139c30442..e793914d48f6 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1927,7 +1927,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	if (protocol == IPPROTO_TCP)
 		err = sock_create_net(xprt->xprt_net, family, type, protocol, &sock);
 	else
-		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+		err = sock_create_net_noref(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -1999,8 +1999,8 @@ static int xs_local_setup_socket(struct sock_xprt *transport)
 	struct socket *sock;
 	int status;
 
-	status = sock_create_kern(xprt->xprt_net, AF_LOCAL,
-				  SOCK_STREAM, 0, &sock);
+	status = sock_create_net_noref(xprt->xprt_net, AF_LOCAL,
+				       SOCK_STREAM, 0, &sock);
 	if (status < 0) {
 		dprintk("RPC:       can't create AF_LOCAL "
 			"transport socket (%d).\n", -status);
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 8ee0c07d00e9..2e03391c1bd1 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -515,7 +515,7 @@ static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 	struct sock *sk;
 	int rc;
 
-	rc = sock_create_kern(srv->net, AF_TIPC, SOCK_SEQPACKET, 0, &lsock);
+	rc = sock_create_net_noref(srv->net, AF_TIPC, SOCK_SEQPACKET, 0, &lsock);
 	if (rc < 0)
 		return rc;
 
@@ -553,7 +553,7 @@ static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 	 * after TIPC module is inserted successfully.
 	 *
 	 * However, the reference count is ever increased twice in
-	 * sock_create_kern(): one is to increase the reference count of owner
+	 * sock_create_net_noref(): one is to increase the reference count of owner
 	 * of TIPC socket's proto_ops struct; another is to increment the
 	 * reference count of owner of TIPC proto struct. Therefore, we must
 	 * decrement the module reference count twice to ensure that it keeps
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 27c58fd260e0..fef671d39d5e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13689,8 +13689,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
 	port = nla_get_u16_default(tb[NL80211_WOWLAN_TCP_SRC_PORT], 0);
 #ifdef CONFIG_INET
 	/* allocate a socket and port for it and use it */
-	err = sock_create_kern(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
-			       IPPROTO_TCP, &cfg->sock);
+	err = sock_create_net_noref(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
+				    IPPROTO_TCP, &cfg->sock);
 	if (err) {
 		kfree(cfg);
 		return err;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cc9dde507aba..b6e78e9d3280 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -804,8 +804,8 @@ __bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
 		goto out;
 	}
 
-	err = sock_create_kern(current->nsproxy->net_ns, args->af, args->type,
-			       proto, &sock);
+	err = sock_create_net_noref(current->nsproxy->net_ns, args->af, args->type,
+				    proto, &sock);
 
 	if (!err)
 		/* Set timeout for call to kernel_connect() to prevent it from hanging,
-- 
2.39.5 (Apple Git-154)


