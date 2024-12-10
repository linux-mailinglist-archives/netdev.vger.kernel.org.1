Return-Path: <netdev+bounces-150546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243249EA9CA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D77816266D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9D822CBD2;
	Tue, 10 Dec 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t0VYW2ia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB0172BD5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816492; cv=none; b=Bu7v8O39K27vDFcTMExV8uyk+4DmUtHEQ/J9xbXDFxMMPMmOi060hoWyAgpBmdlYzXu+WT/C/DCTj9KvN3RwtFWxKGvnMHxApd8jR4P3bFmK+UtUXdgJETCwItQYOGPOVHonasYGr2VsRUMQuoVinsNGf3r3w5z5fR0qDNw9VKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816492; c=relaxed/simple;
	bh=d5IIDXJ/YK+j0AuN9exXpveK64sWUwtQSaC1p7SAUSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N46CeYLNFWziIhJ3K6NXq7YB8c9M792EsOGdq2plKfuRNVMF5JXFyxvXt2ezQkmnWg1WlgFs5amOg93ct9ztLuM1CQA+1JVpUXZFNtuJgOVBzGSikiM3ow3RzUnpaEZIEiOdRQ+tQcno6NDsdNduJzmbhykCO84sZURSBzN+emE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t0VYW2ia; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816490; x=1765352490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2FZNbgOVGXgyYEOFTUOT7HOxsDl4i4ZisG92n9ORrE=;
  b=t0VYW2iaTvQxIeCxU63kXUo6QVGiW5vxyw8jJgiad9gG0iWZyjU2B4qq
   hEPDw73OR5V42RLE7tpFgWedyd/BBeVAbh1BuVqVLABVt+VaSb3bQ4vou
   6ENB1Sp4xsz4jsiMu0+76zG0/2arHnMnNs9ydIiVQvRntphzizgM6tgPR
   E=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="449471596"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:41:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:5373]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.92:2525] with esmtp (Farcaster)
 id cb6a1c6e-e2c2-4471-a31e-c6ad635e8839; Tue, 10 Dec 2024 07:41:28 +0000 (UTC)
X-Farcaster-Flow-ID: cb6a1c6e-e2c2-4471-a31e-c6ad635e8839
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:41:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:41:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/15] socket: Pass hold_net to sk_alloc().
Date: Tue, 10 Dec 2024 16:38:22 +0900
Message-ID: <20241210073829.62520-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns refcnt
held.  Then, sk_alloc() need the hold_net flag passed to __sock_create().

Let's pass it to sk_alloc().

The actual use of hold_net will be in the next patch to make its review
easy.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Fix build error in iucv_sock_alloc()
---
 crypto/af_alg.c              | 5 +++--
 drivers/isdn/mISDN/socket.c  | 4 ++--
 drivers/net/ppp/pppoe.c      | 2 +-
 drivers/net/ppp/pptp.c       | 2 +-
 drivers/net/tap.c            | 2 +-
 drivers/net/tun.c            | 2 +-
 drivers/xen/pvcalls-front.c  | 3 ++-
 include/net/sock.h           | 2 +-
 net/appletalk/ddp.c          | 2 +-
 net/atm/common.c             | 2 +-
 net/ax25/af_ax25.c           | 5 +++--
 net/bluetooth/af_bluetooth.c | 2 +-
 net/bluetooth/cmtp/sock.c    | 2 +-
 net/bpf/test_run.c           | 2 +-
 net/caif/caif_socket.c       | 2 +-
 net/can/af_can.c             | 2 +-
 net/core/sock.c              | 3 ++-
 net/ieee802154/socket.c      | 2 +-
 net/ipv4/af_inet.c           | 2 +-
 net/ipv6/af_inet6.c          | 2 +-
 net/iucv/af_iucv.c           | 2 +-
 net/kcm/kcmsock.c            | 4 ++--
 net/key/af_key.c             | 2 +-
 net/l2tp/l2tp_ppp.c          | 3 ++-
 net/llc/llc_conn.c           | 2 +-
 net/mctp/af_mctp.c           | 2 +-
 net/netlink/af_netlink.c     | 3 ++-
 net/netrom/af_netrom.c       | 5 +++--
 net/nfc/llcp_sock.c          | 2 +-
 net/nfc/rawsock.c            | 2 +-
 net/packet/af_packet.c       | 2 +-
 net/phonet/af_phonet.c       | 2 +-
 net/phonet/pep.c             | 2 +-
 net/qrtr/af_qrtr.c           | 2 +-
 net/rds/af_rds.c             | 2 +-
 net/rose/af_rose.c           | 9 +++++----
 net/rxrpc/af_rxrpc.c         | 2 +-
 net/sctp/ipv6.c              | 2 +-
 net/sctp/protocol.c          | 2 +-
 net/smc/af_smc.c             | 2 +-
 net/tipc/socket.c            | 2 +-
 net/unix/af_unix.c           | 8 +++++---
 net/vmw_vsock/af_vsock.c     | 2 +-
 net/x25/af_x25.c             | 2 +-
 net/xdp/xsk.c                | 2 +-
 45 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index e60032b94d97..bef4f0c8dac8 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -423,7 +423,8 @@ int af_alg_accept(struct sock *sk, struct socket *newsock,
 	if (!type)
 		goto unlock;
 
-	sk2 = sk_alloc(sock_net(sk), PF_ALG, GFP_KERNEL, &alg_proto, arg->kern);
+	sk2 = sk_alloc(sock_net(sk), PF_ALG, GFP_KERNEL, &alg_proto,
+		       arg->kern, arg->hold_net);
 	err = -ENOMEM;
 	if (!sk2)
 		goto unlock;
@@ -514,7 +515,7 @@ static int alg_create(struct net *net, struct socket *sock, int protocol,
 		return -EPROTONOSUPPORT;
 
 	err = -ENOMEM;
-	sk = sk_alloc(net, PF_ALG, GFP_KERNEL, &alg_proto, kern);
+	sk = sk_alloc(net, PF_ALG, GFP_KERNEL, &alg_proto, kern, hold_net);
 	if (!sk)
 		goto out;
 
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 54157c24ccb9..2d2404cf5649 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -598,7 +598,7 @@ data_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_DGRAM)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_ISDN, GFP_KERNEL, &mISDN_proto, kern);
+	sk = sk_alloc(net, PF_ISDN, GFP_KERNEL, &mISDN_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
@@ -757,7 +757,7 @@ base_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (!capable(CAP_NET_RAW))
 		return -EPERM;
 
-	sk = sk_alloc(net, PF_ISDN, GFP_KERNEL, &mISDN_proto, kern);
+	sk = sk_alloc(net, PF_ISDN, GFP_KERNEL, &mISDN_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 90995f8a08a3..6606aa4374e9 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -538,7 +538,7 @@ static int pppoe_create(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_PPPOX, GFP_KERNEL, &pppoe_sk_proto, kern);
+	sk = sk_alloc(net, PF_PPPOX, GFP_KERNEL, &pppoe_sk_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 7bfb5c227c40..4c41e07ec497 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -546,7 +546,7 @@ static int pptp_create(struct net *net, struct socket *sock,
 	struct pppox_sock *po;
 	struct pptp_opt *opt;
 
-	sk = sk_alloc(net, PF_PPPOX, GFP_KERNEL, &pptp_sk_proto, kern);
+	sk = sk_alloc(net, PF_PPPOX, GFP_KERNEL, &pptp_sk_proto, kern, hold_net);
 	if (!sk)
 		goto out;
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765..7bce097e96a5 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -522,7 +522,7 @@ static int tap_open(struct inode *inode, struct file *file)
 
 	err = -ENOMEM;
 	q = (struct tap_queue *)sk_alloc(net, AF_UNSPEC, GFP_KERNEL,
-					     &tap_proto, 0);
+					 &tap_proto, false, true);
 	if (!q)
 		goto err;
 	if (ptr_ring_init(&q->ring, tap->dev->tx_queue_len, GFP_KERNEL)) {
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8e94df88392c..13bbee8d0a4b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3481,7 +3481,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	struct tun_file *tfile;
 
 	tfile = (struct tun_file *)sk_alloc(net, AF_UNSPEC, GFP_KERNEL,
-					    &tun_proto, 0);
+					    &tun_proto, false, true);
 	if (!tfile)
 		return -ENOMEM;
 	if (ptr_ring_init(&tfile->tx_ring, 0, GFP_KERNEL)) {
diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index b72ee9379d77..a2308d24e67d 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -882,7 +882,8 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 
 received:
 	map2->sock = newsock;
-	newsock->sk = sk_alloc(sock_net(sock->sk), PF_INET, GFP_KERNEL, &pvcalls_proto, false);
+	newsock->sk = sk_alloc(sock_net(sock->sk), PF_INET, GFP_KERNEL, &pvcalls_proto,
+			       false, true);
 	if (!newsock->sk) {
 		bedata->rsp[req_id].req_id = PVCALLS_INVALID_ID;
 		map->passive.inflight_req_id = PVCALLS_INVALID_ID;
diff --git a/include/net/sock.h b/include/net/sock.h
index 9963dccec2f8..8de415fefe3b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1743,7 +1743,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 }
 
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
-		      struct proto *prot, int kern);
+		      struct proto *prot, bool kern, bool hold_net);
 void sk_free(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 9bd361ccf5f4..3eab462100e0 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1050,7 +1050,7 @@ static int atalk_create(struct net *net, struct socket *sock, int protocol,
 		goto out;
 
 	rc = -ENOMEM;
-	sk = sk_alloc(net, PF_APPLETALK, GFP_KERNEL, &ddp_proto, kern);
+	sk = sk_alloc(net, PF_APPLETALK, GFP_KERNEL, &ddp_proto, kern, hold_net);
 	if (!sk)
 		goto out;
 	rc = 0;
diff --git a/net/atm/common.c b/net/atm/common.c
index c1e05b0c0b4b..2cf074c3e8a5 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -146,7 +146,7 @@ int vcc_create(struct net *net, struct socket *sock, int protocol, int family,
 	sock->sk = NULL;
 	if (sock->type == SOCK_STREAM)
 		return -EINVAL;
-	sk = sk_alloc(net, family, GFP_KERNEL, &vcc_proto, kern);
+	sk = sk_alloc(net, family, GFP_KERNEL, &vcc_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 	sock_init_data(sock, sk);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 6c68b5e5b11c..6f572c0b3f59 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -890,7 +890,7 @@ static int ax25_create(struct net *net, struct socket *sock, int protocol,
 		return -ESOCKTNOSUPPORT;
 	}
 
-	sk = sk_alloc(net, PF_AX25, GFP_ATOMIC, &ax25_proto, kern);
+	sk = sk_alloc(net, PF_AX25, GFP_ATOMIC, &ax25_proto, kern, hold_net);
 	if (sk == NULL)
 		return -ENOMEM;
 
@@ -916,7 +916,8 @@ struct sock *ax25_make_new(struct sock *osk, struct ax25_dev *ax25_dev)
 	struct sock *sk;
 	ax25_cb *ax25, *oax25;
 
-	sk = sk_alloc(sock_net(osk), PF_AX25, GFP_ATOMIC, osk->sk_prot, 0);
+	sk = sk_alloc(sock_net(osk), PF_AX25, GFP_ATOMIC, osk->sk_prot,
+		      false, true);
 	if (sk == NULL)
 		return NULL;
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 7c24a6f87281..6c89fa2d9ccd 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -146,7 +146,7 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, prot, kern);
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, prot, kern, hold_net);
 	if (!sk)
 		return NULL;
 
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index 2ea9da9fe1d5..6e9138748317 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -207,7 +207,7 @@ static int cmtp_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &cmtp_proto, kern);
+	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &cmtp_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249fed..e3e369a3605d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1024,7 +1024,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		break;
 	}
 
-	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
+	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, true, false);
 	if (!sk) {
 		kfree(data);
 		kfree(ctx);
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 6eef0e83f442..60fa870cfe97 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -1048,7 +1048,7 @@ static int caif_create(struct net *net, struct socket *sock, int protocol,
 	 * is really not used at all in the net/core or socket.c but the
 	 * initialization makes sure that sock->state is not uninitialized.
 	 */
-	sk = sk_alloc(net, PF_CAIF, GFP_KERNEL, &prot, kern);
+	sk = sk_alloc(net, PF_CAIF, GFP_KERNEL, &prot, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/can/af_can.c b/net/can/af_can.c
index c4094ccc9978..cecdc8b7420c 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -155,7 +155,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = cp->ops;
 
-	sk = sk_alloc(net, PF_CAN, GFP_KERNEL, cp->prot, kern);
+	sk = sk_alloc(net, PF_CAN, GFP_KERNEL, cp->prot, kern, hold_net);
 	if (!sk) {
 		err = -ENOMEM;
 		goto errout;
diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..8546d97cc6ec 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2209,9 +2209,10 @@ static void sk_prot_free(struct proto *prot, struct sock *sk)
  *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
  *	@prot: struct proto associated with this new sock instance
  *	@kern: is this to be a kernel socket?
+ *	@hold_net: hold netns refcnt or not
  */
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
-		      struct proto *prot, int kern)
+		      struct proto *prot, bool kern, bool hold_net)
 {
 	struct sock *sk;
 
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 0dd1a8829c42..6144338c420d 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1027,7 +1027,7 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 	}
 
 	rc = -ENOMEM;
-	sk = sk_alloc(net, PF_IEEE802154, GFP_KERNEL, proto, kern);
+	sk = sk_alloc(net, PF_IEEE802154, GFP_KERNEL, proto, kern, hold_net);
 	if (!sk)
 		goto out;
 	rc = 0;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7313ec410fb5..d22bb0d3ddc1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -323,7 +323,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	WARN_ON(!answer_prot->slab);
 
 	err = -ENOMEM;
-	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
+	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern, hold_net);
 	if (!sk)
 		goto out;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8f951e5e58ab..c30fa8de7451 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -190,7 +190,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	WARN_ON(!answer_prot->slab);
 
 	err = -ENOBUFS;
-	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
+	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern, hold_net);
 	if (!sk)
 		goto out;
 
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index b7bbd4947855..76ecc64ec60c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -452,7 +452,7 @@ static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
 	struct sock *sk;
 	struct iucv_sock *iucv;
 
-	sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
+	sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern, hold_net);
 	if (!sk)
 		return NULL;
 	iucv = iucv_sk(sk);
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 50925046a392..8c791d1272cc 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1517,7 +1517,7 @@ static struct file *kcm_clone(struct socket *osock)
 	__module_get(newsock->ops->owner);
 
 	newsk = sk_alloc(sock_net(osock->sk), PF_KCM, GFP_KERNEL,
-			 &kcm_proto, false);
+			 &kcm_proto, false, true);
 	if (!newsk) {
 		sock_release(newsock);
 		return ERR_PTR(-ENOMEM);
@@ -1798,7 +1798,7 @@ static int kcm_create(struct net *net, struct socket *sock,
 	if (protocol != KCMPROTO_CONNECTED)
 		return -EPROTONOSUPPORT;
 
-	sk = sk_alloc(net, PF_KCM, GFP_KERNEL, &kcm_proto, kern);
+	sk = sk_alloc(net, PF_KCM, GFP_KERNEL, &kcm_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 1c35b1cfb1c5..765cc86d7923 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -149,7 +149,7 @@ static int pfkey_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol != PF_KEY_V2)
 		return -EPROTONOSUPPORT;
 
-	sk = sk_alloc(net, PF_KEY, GFP_KERNEL, &key_proto, kern);
+	sk = sk_alloc(net, PF_KEY, GFP_KERNEL, &key_proto, kern, hold_net);
 	if (sk == NULL)
 		return -ENOMEM;
 
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index bab3c7b943db..5bd99d5ca128 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -483,7 +483,8 @@ static int pppol2tp_create(struct net *net, struct socket *sock,
 	int error = -ENOMEM;
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_PPPOX, GFP_KERNEL, &pppol2tp_sk_proto, kern);
+	sk = sk_alloc(net, PF_PPPOX, GFP_KERNEL, &pppol2tp_sk_proto,
+		      kern, hold_net);
 	if (!sk)
 		goto out;
 
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 75b2e21bfd2b..ba0ed49b3085 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -932,7 +932,7 @@ static void llc_sk_init(struct sock *sk)
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, bool kern, bool hold_net)
 {
-	struct sock *sk = sk_alloc(net, family, priority, prot, kern);
+	struct sock *sk = sk_alloc(net, family, priority, prot, kern, hold_net);
 
 	if (!sk)
 		goto out;
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 17821c976213..5de6bc967271 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -702,7 +702,7 @@ static int mctp_pf_create(struct net *net, struct socket *sock,
 	sock->state = SS_UNCONNECTED;
 	sock->ops = ops;
 
-	sk = sk_alloc(net, PF_MCTP, GFP_KERNEL, proto, kern);
+	sk = sk_alloc(net, PF_MCTP, GFP_KERNEL, proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index ddc51cb89c5b..273f3e43938a 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -626,7 +626,8 @@ static int __netlink_create(struct net *net, struct socket *sock,
 
 	sock->ops = &netlink_ops;
 
-	sk = sk_alloc(net, PF_NETLINK, GFP_KERNEL, &netlink_proto, kern);
+	sk = sk_alloc(net, PF_NETLINK, GFP_KERNEL, &netlink_proto,
+		      kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 483f78951a19..0803ca64385d 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -435,7 +435,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_SEQPACKET || protocol != 0)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_NETROM, GFP_ATOMIC, &nr_proto, kern);
+	sk = sk_alloc(net, PF_NETROM, GFP_ATOMIC, &nr_proto, kern, hold_net);
 	if (sk  == NULL)
 		return -ENOMEM;
 
@@ -478,7 +478,8 @@ static struct sock *nr_make_new(struct sock *osk)
 	if (osk->sk_type != SOCK_SEQPACKET)
 		return NULL;
 
-	sk = sk_alloc(sock_net(osk), PF_NETROM, GFP_ATOMIC, osk->sk_prot, 0);
+	sk = sk_alloc(sock_net(osk), PF_NETROM, GFP_ATOMIC, osk->sk_prot,
+		      false, true);
 	if (sk == NULL)
 		return NULL;
 
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 14f592becce0..80c427c32a91 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -977,7 +977,7 @@ struct sock *nfc_llcp_sock_alloc(struct socket *sock, int type, gfp_t gfp,
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock;
 
-	sk = sk_alloc(&init_net, PF_NFC, gfp, &llcp_sock_proto, kern);
+	sk = sk_alloc(&init_net, PF_NFC, gfp, &llcp_sock_proto, kern, hold_net);
 	if (!sk)
 		return NULL;
 
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index 4485b1ccb1c7..f2443d274065 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -339,7 +339,7 @@ static int rawsock_create(struct net *net, struct socket *sock,
 		sock->ops = &rawsock_ops;
 	}
 
-	sk = sk_alloc(net, PF_NFC, GFP_ATOMIC, nfc_proto->proto, kern);
+	sk = sk_alloc(net, PF_NFC, GFP_ATOMIC, nfc_proto->proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 5a25dac333b0..2d1cab4839cd 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3414,7 +3414,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	sock->state = SS_UNCONNECTED;
 
 	err = -ENOBUFS;
-	sk = sk_alloc(net, PF_PACKET, GFP_KERNEL, &packet_proto, kern);
+	sk = sk_alloc(net, PF_PACKET, GFP_KERNEL, &packet_proto, kern, hold_net);
 	if (sk == NULL)
 		goto out;
 
diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index 4bdbc93c74fb..dc2e03edd65d 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -84,7 +84,7 @@ static int pn_socket_create(struct net *net, struct socket *sock, int protocol,
 		goto out;
 	}
 
-	sk = sk_alloc(net, PF_PHONET, GFP_KERNEL, pnp->prot, kern);
+	sk = sk_alloc(net, PF_PHONET, GFP_KERNEL, pnp->prot, kern, hold_net);
 	if (sk == NULL) {
 		err = -ENOMEM;
 		goto out;
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 53a858478e22..9b6e83b92f6f 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -836,7 +836,7 @@ static struct sock *pep_sock_accept(struct sock *sk,
 
 	/* Create a new to-be-accepted sock */
 	newsk = sk_alloc(sock_net(sk), PF_PHONET, GFP_KERNEL, sk->sk_prot,
-			 arg->kern);
+			 arg->kern, arg->hold_net);
 	if (!newsk) {
 		pep_reject_conn(sk, skb, PN_PIPE_ERR_OVERLOAD, GFP_KERNEL);
 		err = -ENOBUFS;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index c05711f79a37..05a3b00fddf8 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1266,7 +1266,7 @@ static int qrtr_create(struct net *net, struct socket *sock,
 	if (sock->type != SOCK_DGRAM)
 		return -EPROTOTYPE;
 
-	sk = sk_alloc(net, AF_QIPCRTR, GFP_KERNEL, &qrtr_proto, kern);
+	sk = sk_alloc(net, AF_QIPCRTR, GFP_KERNEL, &qrtr_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 3e1bb40485ad..a0999d9ee5ae 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -702,7 +702,7 @@ static int rds_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_SEQPACKET || protocol)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, AF_RDS, GFP_KERNEL, &rds_proto, kern);
+	sk = sk_alloc(net, AF_RDS, GFP_KERNEL, &rds_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 1c175c92aa42..6aeaa526382a 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -555,8 +555,8 @@ static int rose_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_SEQPACKET || protocol != 0)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_ROSE, GFP_ATOMIC, &rose_proto, kern);
-	if (sk == NULL)
+	sk = sk_alloc(net, PF_ROSE, GFP_ATOMIC, &rose_proto, kern, hold_net);
+	if (!sk)
 		return -ENOMEM;
 
 	rose = rose_sk(sk);
@@ -594,8 +594,9 @@ static struct sock *rose_make_new(struct sock *osk)
 	if (osk->sk_type != SOCK_SEQPACKET)
 		return NULL;
 
-	sk = sk_alloc(sock_net(osk), PF_ROSE, GFP_ATOMIC, &rose_proto, 0);
-	if (sk == NULL)
+	sk = sk_alloc(sock_net(osk), PF_ROSE, GFP_ATOMIC, &rose_proto,
+		      false, true);
+	if (!sk)
 		return NULL;
 
 	rose = rose_sk(sk);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index f2374f65b1c0..7e7e1163c476 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -830,7 +830,7 @@ static int rxrpc_create(struct net *net, struct socket *sock, int protocol,
 	sock->ops = &rxrpc_rpc_ops;
 	sock->state = SS_UNCONNECTED;
 
-	sk = sk_alloc(net, PF_RXRPC, GFP_KERNEL, &rxrpc_proto, kern);
+	sk = sk_alloc(net, PF_RXRPC, GFP_KERNEL, &rxrpc_proto, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 2c4e4dd79246..5e62c77a6f47 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -784,7 +784,7 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	struct sock *newsk;
 
 	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot,
-			 arg->kern);
+			 arg->kern, arg->hold_net);
 	if (!newsk)
 		goto out;
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 7b2ae3df171a..73ee2ca9ff31 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -587,7 +587,7 @@ static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 	struct sock *newsk;
 
 	newsk = sk_alloc(sock_net(sk), PF_INET, GFP_KERNEL, sk->sk_prot,
-			 arg->kern);
+			 arg->kern, arg->hold_net);
 	if (!newsk)
 		goto out;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 34cfe0be0daf..9b5738a55dde 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -393,7 +393,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	struct sock *sk;
 
 	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
-	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, kern);
+	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, kern, hold_net);
 	if (!sk)
 		return NULL;
 
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 26566ff1d4c7..aba5b139c7d9 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -484,7 +484,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	}
 
 	/* Allocate socket's protocol area */
-	sk = sk_alloc(net, AF_TIPC, GFP_KERNEL, &tipc_proto, kern);
+	sk = sk_alloc(net, AF_TIPC, GFP_KERNEL, &tipc_proto, kern, hold_net);
 	if (sk == NULL)
 		return -ENOMEM;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b1d7d68a2511..b675a63cb889 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1020,9 +1020,11 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int type,
 	}
 
 	if (type == SOCK_STREAM)
-		sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_stream_proto, kern);
-	else /*dgram and  seqpacket */
-		sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_dgram_proto, kern);
+		sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_stream_proto,
+			      kern, hold_net);
+	else /* dgram and seqpacket */
+		sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_dgram_proto,
+			      kern, hold_net);
 
 	if (!sk) {
 		err = -ENOMEM;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index b348cd2ff792..f397a259162f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -736,7 +736,7 @@ static struct sock *__vsock_create(struct net *net,
 	struct vsock_sock *psk;
 	struct vsock_sock *vsk;
 
-	sk = sk_alloc(net, AF_VSOCK, priority, &vsock_proto, kern);
+	sk = sk_alloc(net, AF_VSOCK, priority, &vsock_proto, kern, hold_net);
 	if (!sk)
 		return NULL;
 
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 0b6c22b979e7..3619982cbb32 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -510,7 +510,7 @@ static struct sock *x25_alloc_socket(struct net *net, bool kern, bool hold_net)
 	struct x25_sock *x25;
 	struct sock *sk;
 
-	sk = sk_alloc(net, AF_X25, GFP_ATOMIC, &x25_proto, kern);
+	sk = sk_alloc(net, AF_X25, GFP_ATOMIC, &x25_proto, kern, hold_net);
 	if (!sk)
 		goto out;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5763ef355c73..a93b600c6583 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1703,7 +1703,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->state = SS_UNCONNECTED;
 
-	sk = sk_alloc(net, PF_XDP, GFP_KERNEL, &xsk_proto, kern);
+	sk = sk_alloc(net, PF_XDP, GFP_KERNEL, &xsk_proto, kern, hold_net);
 	if (!sk)
 		return -ENOBUFS;
 
-- 
2.39.5 (Apple Git-154)


