Return-Path: <netdev+bounces-151655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D19F07EB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2482281A77
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1EC1AF0D6;
	Fri, 13 Dec 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TSnn4EJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADE1AF4C1
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081816; cv=none; b=k1kAyRwANMv50LsY/A2TgjZWO/Y44FeVWubE8Bnu8OdLGOBJyuA8OaakYVQ1qsi3rQM5eK8A3SIvNwC2qb472qsJsOHoPOK+esBqPiPamlgX0RQIz72fuRruZiOeXhyjRNXib/A6b8+KijE3heLJ0JrpUYoZnZ/u9morVceHfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081816; c=relaxed/simple;
	bh=/wWLMtu5TmaFZtlNjsBC3S5uHKLbaaD/nNmYCrFnzhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzEoWazlpC8T5ZQt5OkENIkUYxzRm1ihXpH2qZBxvJAoNAOEQ17MaqcLKxI18BIOckKy1qnNmI2DN+DeU1c1omOER0DMJIUpF+FUyzKiS8NOKN5znrlzML1SjkfQb1LCHjfgK8is75C4iUsLK6w+bsJhzpNT0qAL3jcFNEv5WaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TSnn4EJK; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081814; x=1765617814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoAEPdfamebWtORq4dIC8EE4yDkA1APgvKLi6u8y8fE=;
  b=TSnn4EJKTz1MD/9k9Jq6RiJn6zqw/3LbccXbctJZejV4XLvDDSReGqKa
   1bf25aUZ9qZHtvYE4Yl6eUGw+4pVohfWDD+eyCKyv2ykvUv2mcCKkl34w
   LFzTAGX7kmwOckV65ymuSd2i7j5JDJrJfMz/K60FAmMtxcdcBHA03gysJ
   w=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="783117451"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:23:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:16005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.254:2525] with esmtp (Farcaster)
 id 95ce0aa9-223e-44e6-9eec-39148b2b4920; Fri, 13 Dec 2024 09:23:26 +0000 (UTC)
X-Farcaster-Flow-ID: 95ce0aa9-223e-44e6-9eec-39148b2b4920
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:23:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:23:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 04/15] socket: Pass hold_net to struct net_proto_family.create().
Date: Fri, 13 Dec 2024 18:21:41 +0900
Message-ID: <20241213092152.14057-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns refcnt
held.  Then, sk_alloc() needs the hold_net flag passed to __sock_create().

Let's pass it down to net_proto_family.create() and functions that call
sk_alloc().

While at it, we convert the kern flag to boolean.

Note that we still need to pass hold_net to struct pppox_proto.create()
and struct nfc_protocol.create() before passing hold_net to sk_alloc().

Also, we use !kern as hold_net in the accept() paths.  We will add the
hold_net flag to struct proto_accept_arg later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 crypto/af_alg.c                   |  2 +-
 drivers/isdn/mISDN/socket.c       | 13 ++++++++-----
 drivers/net/ppp/pppox.c           |  2 +-
 include/linux/net.h               |  2 +-
 include/net/bluetooth/bluetooth.h |  3 ++-
 include/net/llc_conn.h            |  2 +-
 net/appletalk/ddp.c               |  2 +-
 net/atm/common.c                  |  3 ++-
 net/atm/common.h                  |  3 ++-
 net/atm/pvc.c                     |  4 ++--
 net/atm/svc.c                     |  8 ++++----
 net/ax25/af_ax25.c                |  2 +-
 net/bluetooth/af_bluetooth.c      |  7 ++++---
 net/bluetooth/bnep/sock.c         |  5 +++--
 net/bluetooth/cmtp/sock.c         |  2 +-
 net/bluetooth/hci_sock.c          |  4 ++--
 net/bluetooth/hidp/sock.c         |  5 +++--
 net/bluetooth/iso.c               | 11 ++++++-----
 net/bluetooth/l2cap_sock.c        | 14 ++++++++------
 net/bluetooth/rfcomm/sock.c       | 12 +++++++-----
 net/bluetooth/sco.c               | 11 ++++++-----
 net/caif/caif_socket.c            |  2 +-
 net/can/af_can.c                  |  2 +-
 net/ieee802154/socket.c           |  2 +-
 net/ipv4/af_inet.c                |  2 +-
 net/ipv6/af_inet6.c               |  2 +-
 net/iucv/af_iucv.c                | 11 ++++++-----
 net/kcm/kcmsock.c                 |  2 +-
 net/key/af_key.c                  |  2 +-
 net/llc/af_llc.c                  |  6 ++++--
 net/llc/llc_conn.c                |  9 ++++++---
 net/mctp/af_mctp.c                |  2 +-
 net/netlink/af_netlink.c          |  8 ++++----
 net/netrom/af_netrom.c            |  2 +-
 net/nfc/af_nfc.c                  |  2 +-
 net/packet/af_packet.c            |  2 +-
 net/phonet/af_phonet.c            |  2 +-
 net/qrtr/af_qrtr.c                |  2 +-
 net/rds/af_rds.c                  |  2 +-
 net/rose/af_rose.c                |  2 +-
 net/rxrpc/af_rxrpc.c              |  2 +-
 net/smc/af_smc.c                  | 15 ++++++++-------
 net/socket.c                      |  2 +-
 net/tipc/socket.c                 |  6 ++++--
 net/unix/af_unix.c                |  9 +++++----
 net/vmw_vsock/af_vsock.c          |  8 ++++----
 net/x25/af_x25.c                  | 13 ++++++++-----
 net/xdp/xsk.c                     |  2 +-
 48 files changed, 133 insertions(+), 105 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 0da7c1ac778a..e60032b94d97 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -503,7 +503,7 @@ static void alg_sock_destruct(struct sock *sk)
 }
 
 static int alg_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	struct sock *sk;
 	int err;
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index b215b28cad7b..54157c24ccb9 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -590,7 +590,8 @@ static const struct proto_ops data_sock_ops = {
 };
 
 static int
-data_sock_create(struct net *net, struct socket *sock, int protocol, int kern)
+data_sock_create(struct net *net, struct socket *sock, int protocol,
+		 bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -746,7 +747,8 @@ static const struct proto_ops base_sock_ops = {
 
 
 static int
-base_sock_create(struct net *net, struct socket *sock, int protocol, int kern)
+base_sock_create(struct net *net, struct socket *sock, int protocol,
+		 bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -771,13 +773,14 @@ base_sock_create(struct net *net, struct socket *sock, int protocol, int kern)
 }
 
 static int
-mISDN_sock_create(struct net *net, struct socket *sock, int proto, int kern)
+mISDN_sock_create(struct net *net, struct socket *sock, int proto,
+		  bool kern, bool hold_net)
 {
 	int err = -EPROTONOSUPPORT;
 
 	switch (proto) {
 	case ISDN_P_BASE:
-		err = base_sock_create(net, sock, proto, kern);
+		err = base_sock_create(net, sock, proto, kern, hold_net);
 		break;
 	case ISDN_P_TE_S0:
 	case ISDN_P_NT_S0:
@@ -791,7 +794,7 @@ mISDN_sock_create(struct net *net, struct socket *sock, int proto, int kern)
 	case ISDN_P_B_L2DTMF:
 	case ISDN_P_B_L2DSP:
 	case ISDN_P_B_L2DSPHDLC:
-		err = data_sock_create(net, sock, proto, kern);
+		err = data_sock_create(net, sock, proto, kern, hold_net);
 		break;
 	default:
 		return err;
diff --git a/drivers/net/ppp/pppox.c b/drivers/net/ppp/pppox.c
index 08364f10a43f..53b3f790d1f5 100644
--- a/drivers/net/ppp/pppox.c
+++ b/drivers/net/ppp/pppox.c
@@ -112,7 +112,7 @@ EXPORT_SYMBOL(pppox_compat_ioctl);
 #endif
 
 static int pppox_create(struct net *net, struct socket *sock, int protocol,
-			int kern)
+			bool kern, bool hold_net)
 {
 	int rc = -EPROTOTYPE;
 
diff --git a/include/linux/net.h b/include/linux/net.h
index 68ac97e301be..c2a35a102ee2 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -233,7 +233,7 @@ struct proto_ops {
 struct net_proto_family {
 	int		family;
 	int		(*create)(struct net *net, struct socket *sock,
-				  int protocol, int kern);
+				  int protocol, bool kern, bool hold_net);
 	struct module	*owner;
 };
 
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 435250c72d56..58afa3fd08af 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -406,7 +406,8 @@ void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
-			   struct proto *prot, int proto, gfp_t prio, int kern);
+			   struct proto *prot, int proto, gfp_t prio,
+			   bool kern, bool hold_net);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index 374411b3066c..7d8b928a5ff6 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -97,7 +97,7 @@ static __inline__ char llc_backlog_type(struct sk_buff *skb)
 }
 
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
-			  struct proto *prot, int kern);
+			  struct proto *prot, bool kern, bool hold_net);
 void llc_sk_stop_all_timers(struct sock *sk, bool sync);
 void llc_sk_free(struct sock *sk);
 
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index b068651984fe..9bd361ccf5f4 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1030,7 +1030,7 @@ static struct proto ddp_proto = {
  * set the state.
  */
 static int atalk_create(struct net *net, struct socket *sock, int protocol,
-			int kern)
+			bool kern, bool hold_net)
 {
 	struct sock *sk;
 	int rc = -ESOCKTNOSUPPORT;
diff --git a/net/atm/common.c b/net/atm/common.c
index 9b75699992ff..c1e05b0c0b4b 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -137,7 +137,8 @@ static struct proto vcc_proto = {
 	.release_cb = vcc_release_cb,
 };
 
-int vcc_create(struct net *net, struct socket *sock, int protocol, int family, int kern)
+int vcc_create(struct net *net, struct socket *sock, int protocol, int family,
+	       bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct atm_vcc *vcc;
diff --git a/net/atm/common.h b/net/atm/common.h
index a1e56e8de698..410419873eb6 100644
--- a/net/atm/common.h
+++ b/net/atm/common.h
@@ -11,7 +11,8 @@
 #include <linux/poll.h> /* for poll_table */
 
 
-int vcc_create(struct net *net, struct socket *sock, int protocol, int family, int kern);
+int vcc_create(struct net *net, struct socket *sock, int protocol, int family,
+	       bool kern, bool hold_net);
 int vcc_release(struct socket *sock);
 int vcc_connect(struct socket *sock, int itf, short vpi, int vci);
 int vcc_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 66d9a9bd5896..6238c1809481 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -130,13 +130,13 @@ static const struct proto_ops pvc_proto_ops = {
 
 
 static int pvc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	if (net != &init_net)
 		return -EAFNOSUPPORT;
 
 	sock->ops = &pvc_proto_ops;
-	return vcc_create(net, sock, protocol, PF_ATMPVC, kern);
+	return vcc_create(net, sock, protocol, PF_ATMPVC, kern, hold_net);
 }
 
 static const struct net_proto_family pvc_family_ops = {
diff --git a/net/atm/svc.c b/net/atm/svc.c
index f8137ae693b0..9795294f4c1e 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -34,7 +34,7 @@
 #endif
 
 static int svc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern);
+		      bool kern, bool hold_net);
 
 /*
  * Note: since all this is still nicely synchronized with the signaling demon,
@@ -336,7 +336,7 @@ static int svc_accept(struct socket *sock, struct socket *newsock,
 
 	lock_sock(sk);
 
-	error = svc_create(sock_net(sk), newsock, 0, arg->kern);
+	error = svc_create(sock_net(sk), newsock, 0, arg->kern, !arg->kern);
 	if (error)
 		goto out;
 
@@ -658,7 +658,7 @@ static const struct proto_ops svc_proto_ops = {
 
 
 static int svc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	int error;
 
@@ -666,7 +666,7 @@ static int svc_create(struct net *net, struct socket *sock, int protocol,
 		return -EAFNOSUPPORT;
 
 	sock->ops = &svc_proto_ops;
-	error = vcc_create(net, sock, protocol, AF_ATMSVC, kern);
+	error = vcc_create(net, sock, protocol, AF_ATMSVC, kern, hold_net);
 	if (error)
 		return error;
 	ATM_SD(sock)->local.sas_family = AF_ATMSVC;
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d6f9fae06a9d..6c68b5e5b11c 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -830,7 +830,7 @@ static struct proto ax25_proto = {
 };
 
 static int ax25_create(struct net *net, struct socket *sock, int protocol,
-		       int kern)
+		       bool kern, bool hold_net)
 {
 	struct sock *sk;
 	ax25_cb *ax25;
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0b4d0a8bd361..7c24a6f87281 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -111,7 +111,7 @@ void bt_sock_unregister(int proto)
 EXPORT_SYMBOL(bt_sock_unregister);
 
 static int bt_sock_create(struct net *net, struct socket *sock, int proto,
-			  int kern)
+			  bool kern, bool hold_net)
 {
 	int err;
 
@@ -129,7 +129,7 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 	read_lock(&bt_proto_lock);
 
 	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
-		err = bt_proto[proto]->create(net, sock, proto, kern);
+		err = bt_proto[proto]->create(net, sock, proto, kern, hold_net);
 		if (!err)
 			bt_sock_reclassify_lock(sock->sk, proto);
 		module_put(bt_proto[proto]->owner);
@@ -141,7 +141,8 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 }
 
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
-			   struct proto *prot, int proto, gfp_t prio, int kern)
+			   struct proto *prot, int proto, gfp_t prio,
+			   bool kern, bool hold_net)
 {
 	struct sock *sk;
 
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 00d47bcf4d7d..d845cdb0e48b 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -196,7 +196,7 @@ static struct proto bnep_proto = {
 };
 
 static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
-			    int kern)
+			    bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -205,7 +205,8 @@ static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = bt_sock_alloc(net, sock, &bnep_proto, protocol, GFP_ATOMIC, kern);
+	sk = bt_sock_alloc(net, sock, &bnep_proto, protocol, GFP_ATOMIC,
+			   kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index 96d49d9fae96..2ea9da9fe1d5 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -198,7 +198,7 @@ static struct proto cmtp_proto = {
 };
 
 static int cmtp_sock_create(struct net *net, struct socket *sock, int protocol,
-			    int kern)
+			    bool kern, bool hold_net)
 {
 	struct sock *sk;
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 022b86797acd..4c51d7ee8a3e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2188,7 +2188,7 @@ static struct proto hci_sk_proto = {
 };
 
 static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
-			   int kern)
+			   bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -2200,7 +2200,7 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 	sock->ops = &hci_sock_ops;
 
 	sk = bt_sock_alloc(net, sock, &hci_sk_proto, protocol, GFP_ATOMIC,
-			   kern);
+			   kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index c93aaeb3a3fa..0ebe94f39906 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -247,7 +247,7 @@ static struct proto hidp_proto = {
 };
 
 static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
-			    int kern)
+			    bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -256,7 +256,8 @@ static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = bt_sock_alloc(net, sock, &hidp_proto, protocol, GFP_ATOMIC, kern);
+	sk = bt_sock_alloc(net, sock, &hidp_proto, protocol, GFP_ATOMIC,
+			   kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 43d0ebe11100..9f3529fbadf4 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -874,11 +874,12 @@ static struct bt_iso_qos default_qos = {
 };
 
 static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
-				   int proto, gfp_t prio, int kern)
+				   int proto, gfp_t prio,
+				   bool kern, bool hold_net)
 {
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &iso_proto, proto, prio, kern);
+	sk = bt_sock_alloc(net, sock, &iso_proto, proto, prio, kern, hold_net);
 	if (!sk)
 		return NULL;
 
@@ -896,7 +897,7 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 }
 
 static int iso_sock_create(struct net *net, struct socket *sock, int protocol,
-			   int kern)
+			   bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -909,7 +910,7 @@ static int iso_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &iso_sock_ops;
 
-	sk = iso_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
+	sk = iso_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
@@ -1911,7 +1912,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		lock_sock(parent);
 
 		sk = iso_sock_alloc(sock_net(parent), NULL,
-				    BTPROTO_ISO, GFP_ATOMIC, 0);
+				    BTPROTO_ISO, GFP_ATOMIC, false, true);
 		if (!sk) {
 			release_sock(parent);
 			return;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3d2553dcdb1b..04fe3c622210 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -45,7 +45,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio,
+				     bool kern, bool hold_net);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1468,7 +1469,7 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 	}
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
-			      GFP_ATOMIC, 0);
+			      GFP_ATOMIC, false, true);
 	if (!sk) {
 		release_sock(parent);
 		return NULL;
@@ -1871,12 +1872,13 @@ static struct proto l2cap_proto = {
 };
 
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern)
+				     int proto, gfp_t prio,
+				     bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct l2cap_chan *chan;
 
-	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
+	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern, hold_net);
 	if (!sk)
 		return NULL;
 
@@ -1900,7 +1902,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 }
 
 static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
-			     int kern)
+			     bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -1917,7 +1919,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &l2cap_sock_ops;
 
-	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
+	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 913402806fa0..b96046914a63 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -269,7 +269,8 @@ static struct proto rfcomm_proto = {
 };
 
 static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
-				      int proto, gfp_t prio, int kern)
+				      int proto, gfp_t prio,
+				      bool kern, bool hold_net)
 {
 	struct rfcomm_dlc *d;
 	struct sock *sk;
@@ -278,7 +279,7 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 	if (!d)
 		return NULL;
 
-	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern, hold_net);
 	if (!sk) {
 		rfcomm_dlc_free(d);
 		return NULL;
@@ -303,7 +304,7 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 }
 
 static int rfcomm_sock_create(struct net *net, struct socket *sock,
-			      int protocol, int kern)
+			      int protocol, bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -316,7 +317,7 @@ static int rfcomm_sock_create(struct net *net, struct socket *sock,
 
 	sock->ops = &rfcomm_sock_ops;
 
-	sk = rfcomm_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
+	sk = rfcomm_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
@@ -952,7 +953,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 		goto done;
 	}
 
-	sk = rfcomm_sock_alloc(sock_net(parent), NULL, BTPROTO_RFCOMM, GFP_ATOMIC, 0);
+	sk = rfcomm_sock_alloc(sock_net(parent), NULL, BTPROTO_RFCOMM, GFP_ATOMIC,
+			       false, true);
 	if (!sk)
 		goto done;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index aa7bfe26cb40..a1865df18d59 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -545,11 +545,12 @@ static struct proto sco_proto = {
 };
 
 static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
-				   int proto, gfp_t prio, int kern)
+				   int proto, gfp_t prio,
+				   bool kern, bool hold_net)
 {
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &sco_proto, proto, prio, kern);
+	sk = bt_sock_alloc(net, sock, &sco_proto, proto, prio, kern, hold_net);
 	if (!sk)
 		return NULL;
 
@@ -567,7 +568,7 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 }
 
 static int sco_sock_create(struct net *net, struct socket *sock, int protocol,
-			   int kern)
+			   bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -580,7 +581,7 @@ static int sco_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &sco_sock_ops;
 
-	sk = sco_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
+	sk = sco_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
@@ -1341,7 +1342,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		lock_sock(parent);
 
 		sk = sco_sock_alloc(sock_net(parent), NULL,
-				    BTPROTO_SCO, GFP_ATOMIC, 0);
+				    BTPROTO_SCO, GFP_ATOMIC, false, true);
 		if (!sk) {
 			release_sock(parent);
 			sco_conn_unlock(conn);
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 039dfbd367c9..6eef0e83f442 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -1015,7 +1015,7 @@ static void caif_sock_destructor(struct sock *sk)
 }
 
 static int caif_create(struct net *net, struct socket *sock, int protocol,
-		       int kern)
+		       bool kern, bool hold_net)
 {
 	struct sock *sk = NULL;
 	struct caifsock *cf_sk = NULL;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 01f3fbb3b67d..c4094ccc9978 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -112,7 +112,7 @@ static inline void can_put_proto(const struct can_proto *cp)
 }
 
 static int can_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	struct sock *sk;
 	const struct can_proto *cp;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 18d267921bb5..0dd1a8829c42 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -999,7 +999,7 @@ static void ieee802154_sock_destruct(struct sock *sk)
  * set the state.
  */
 static int ieee802154_create(struct net *net, struct socket *sock,
-			     int protocol, int kern)
+			     int protocol, bool kern, bool hold_net)
 {
 	struct sock *sk;
 	int rc;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8095e82de808..7313ec410fb5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL(inet_listen);
  */
 
 static int inet_create(struct net *net, struct socket *sock, int protocol,
-		       int kern)
+		       bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct inet_protosw *answer;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f60ec8b0f8ea..8f951e5e58ab 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -118,7 +118,7 @@ void inet6_sock_destruct(struct sock *sk)
 EXPORT_SYMBOL_GPL(inet6_sock_destruct);
 
 static int inet6_create(struct net *net, struct socket *sock, int protocol,
-			int kern)
+			bool kern, bool hold_net)
 {
 	struct inet_sock *inet;
 	struct ipv6_pinfo *np;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 7929df08d4e0..b7bbd4947855 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -446,7 +446,8 @@ static void iucv_sock_init(struct sock *sk, struct sock *parent)
 	}
 }
 
-static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio, int kern)
+static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
+				    bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct iucv_sock *iucv;
@@ -1632,7 +1633,7 @@ static int iucv_callback_connreq(struct iucv_path *path,
 	}
 
 	/* Create the new socket */
-	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
+	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, false, true);
 	if (!nsk) {
 		err = pr_iucv->path_sever(path, user_data);
 		iucv_path_free(path);
@@ -1854,7 +1855,7 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		goto out;
 	}
 
-	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
+	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, false, true);
 	bh_lock_sock(sk);
 	if ((sk->sk_state != IUCV_LISTEN) ||
 	    sk_acceptq_is_full(sk) ||
@@ -2229,7 +2230,7 @@ static const struct proto_ops iucv_sock_ops = {
 };
 
 static int iucv_sock_create(struct net *net, struct socket *sock, int protocol,
-			    int kern)
+			    bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -2248,7 +2249,7 @@ static int iucv_sock_create(struct net *net, struct socket *sock, int protocol,
 		return -ESOCKTNOSUPPORT;
 	}
 
-	sk = iucv_sock_alloc(sock, protocol, GFP_KERNEL, kern);
+	sk = iucv_sock_alloc(sock, protocol, GFP_KERNEL, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 24aec295a51c..50925046a392 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1778,7 +1778,7 @@ static const struct proto_ops kcm_seqpacket_ops = {
 
 /* Create proto operation for kcm sockets */
 static int kcm_create(struct net *net, struct socket *sock,
-		      int protocol, int kern)
+		      int protocol, bool kern, bool hold_net)
 {
 	struct kcm_net *knet = net_generic(net, kcm_net_id);
 	struct sock *sk;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c56bb4f451e6..1c35b1cfb1c5 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -136,7 +136,7 @@ static struct proto key_proto = {
 };
 
 static int pfkey_create(struct net *net, struct socket *sock, int protocol,
-			int kern)
+			bool kern, bool hold_net)
 {
 	struct netns_pfkey *net_pfkey = net_generic(net, pfkey_net_id);
 	struct sock *sk;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 0259cde394ba..5d865f4a5cb4 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -163,13 +163,14 @@ static struct proto llc_proto = {
  *	@sock: Socket to initialize and attach allocated sk to.
  *	@protocol: Unused.
  *	@kern: on behalf of kernel or userspace
+ *	@hold_net: hold netns refcnt or not
  *
  *	Allocate and initialize a new llc_ui socket, validate the user wants a
  *	socket type we have available.
  *	Returns 0 upon success, negative upon failure.
  */
 static int llc_ui_create(struct net *net, struct socket *sock, int protocol,
-			 int kern)
+			 bool kern, bool hold_net)
 {
 	struct sock *sk;
 	int rc = -ESOCKTNOSUPPORT;
@@ -182,7 +183,8 @@ static int llc_ui_create(struct net *net, struct socket *sock, int protocol,
 
 	if (likely(sock->type == SOCK_DGRAM || sock->type == SOCK_STREAM)) {
 		rc = -ENOMEM;
-		sk = llc_sk_alloc(net, PF_LLC, GFP_KERNEL, &llc_proto, kern);
+		sk = llc_sk_alloc(net, PF_LLC, GFP_KERNEL, &llc_proto,
+				  kern, hold_net);
 		if (sk) {
 			rc = 0;
 			llc_ui_sk_init(sock, sk);
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index afc6974eafda..75b2e21bfd2b 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -761,10 +761,11 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 					     struct llc_addr *saddr,
 					     struct llc_addr *daddr)
 {
-	struct sock *newsk = llc_sk_alloc(sock_net(sk), sk->sk_family, GFP_ATOMIC,
-					  sk->sk_prot, 0);
 	struct llc_sock *newllc, *llc = llc_sk(sk);
+	struct sock *newsk;
 
+	newsk = llc_sk_alloc(sock_net(sk), sk->sk_family, GFP_ATOMIC,
+			     sk->sk_prot, false, true);
 	if (!newsk)
 		goto out;
 	newllc = llc_sk(newsk);
@@ -923,11 +924,13 @@ static void llc_sk_init(struct sock *sk)
  *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
  *	@prot: struct proto associated with this new sock instance
  *	@kern: is this to be a kernel socket?
+ *	@hold_net: hold netns refcnt or not
  *
  *	Allocates a LLC sock and initializes it. Returns the new LLC sock
  *	or %NULL if there's no memory available for one
  */
-struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority, struct proto *prot, int kern)
+struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
+			  struct proto *prot, bool kern, bool hold_net)
 {
 	struct sock *sk = sk_alloc(net, family, priority, prot, kern);
 
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index f6de136008f6..17821c976213 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -682,7 +682,7 @@ static struct proto mctp_proto = {
 };
 
 static int mctp_pf_create(struct net *net, struct socket *sock,
-			  int protocol, int kern)
+			  int protocol, bool kern, bool hold_net)
 {
 	const struct proto_ops *ops;
 	struct proto *proto;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index f4e7b5e4bb59..ddc51cb89c5b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -619,7 +619,7 @@ static struct proto netlink_proto = {
 };
 
 static int __netlink_create(struct net *net, struct socket *sock,
-			    int protocol, int kern)
+			    int protocol, bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct netlink_sock *nlk;
@@ -645,7 +645,7 @@ static int __netlink_create(struct net *net, struct socket *sock,
 }
 
 static int netlink_create(struct net *net, struct socket *sock, int protocol,
-			  int kern)
+			  bool kern, bool hold_net)
 {
 	struct module *module = NULL;
 	struct netlink_sock *nlk;
@@ -684,7 +684,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	if (err < 0)
 		goto out;
 
-	err = __netlink_create(net, sock, protocol, kern);
+	err = __netlink_create(net, sock, protocol, kern, hold_net);
 	if (err < 0)
 		goto out_module;
 
@@ -2012,7 +2012,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
 		return NULL;
 
-	if (__netlink_create(net, sock, unit, 1) < 0)
+	if (__netlink_create(net, sock, unit, true, false) < 0)
 		goto out_sock_release_nosk;
 
 	sk = sock->sk;
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 6ee148f0e6d0..483f78951a19 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -424,7 +424,7 @@ static struct proto nr_proto = {
 };
 
 static int nr_create(struct net *net, struct socket *sock, int protocol,
-		     int kern)
+		     bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct nr_sock *nr;
diff --git a/net/nfc/af_nfc.c b/net/nfc/af_nfc.c
index dda323e0a473..4fb1c86fcc81 100644
--- a/net/nfc/af_nfc.c
+++ b/net/nfc/af_nfc.c
@@ -16,7 +16,7 @@ static DEFINE_RWLOCK(proto_tab_lock);
 static const struct nfc_protocol *proto_tab[NFC_SOCKPROTO_MAX];
 
 static int nfc_sock_create(struct net *net, struct socket *sock, int proto,
-			   int kern)
+			   bool kern, bool hold_net)
 {
 	int rc = -EPROTONOSUPPORT;
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 886c0dd47b66..5a25dac333b0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3398,7 +3398,7 @@ static struct proto packet_proto = {
  */
 
 static int packet_create(struct net *net, struct socket *sock, int protocol,
-			 int kern)
+			 bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct packet_sock *po;
diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index a27efa4faa4e..4bdbc93c74fb 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -48,7 +48,7 @@ static inline void phonet_proto_put(const struct phonet_protocol *pp)
 /* protocol family functions */
 
 static int pn_socket_create(struct net *net, struct socket *sock, int protocol,
-			    int kern)
+			    bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct pn_sock *pn;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 00c51cf693f3..c05711f79a37 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1258,7 +1258,7 @@ static struct proto qrtr_proto = {
 };
 
 static int qrtr_create(struct net *net, struct socket *sock,
-		       int protocol, int kern)
+		       int protocol, bool kern, bool hold_net)
 {
 	struct qrtr_sock *ipc;
 	struct sock *sk;
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..3e1bb40485ad 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -695,7 +695,7 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
 }
 
 static int rds_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	struct sock *sk;
 
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 59050caab65c..1c175c92aa42 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -544,7 +544,7 @@ static struct proto rose_proto = {
 };
 
 static int rose_create(struct net *net, struct socket *sock, int protocol,
-		       int kern)
+		       bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct rose_sock *rose;
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 86873399f7d5..f2374f65b1c0 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -811,7 +811,7 @@ static __poll_t rxrpc_poll(struct file *file, struct socket *sock,
  * create an RxRPC socket
  */
 static int rxrpc_create(struct net *net, struct socket *sock, int protocol,
-			int kern)
+			bool kern, bool hold_net)
 {
 	struct rxrpc_net *rxnet;
 	struct rxrpc_sock *rx;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b52bee98a3eb..2535b922f760 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -387,7 +387,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 }
 
 static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
-				   int protocol, int kern)
+				   int protocol, bool kern, bool hold_net)
 {
 	struct proto *prot;
 	struct sock *sk;
@@ -1715,7 +1715,8 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	int rc = -EINVAL;
 
 	release_sock(lsk);
-	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol, 0);
+	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol,
+				false, true);
 	if (!new_sk) {
 		rc = -ENOMEM;
 		lsk->sk_err = ENOMEM;
@@ -3331,7 +3332,7 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 }
 
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
-			int kern, struct socket *clcsock)
+			bool kern, bool hold_net, struct socket *clcsock)
 {
 	int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
 	struct smc_sock *smc;
@@ -3349,7 +3350,7 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 	rc = -ENOBUFS;
 	sock->ops = &smc_sock_ops;
 	sock->state = SS_UNCONNECTED;
-	sk = smc_sock_alloc(net, sock, protocol, kern);
+	sk = smc_sock_alloc(net, sock, protocol, kern, hold_net);
 	if (!sk)
 		goto out;
 
@@ -3371,9 +3372,9 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 }
 
 static int smc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
-	return __smc_create(net, sock, protocol, kern, NULL);
+	return __smc_create(net, sock, protocol, kern, hold_net, NULL);
 }
 
 static const struct net_proto_family smc_sock_family_ops = {
@@ -3408,7 +3409,7 @@ static int smc_ulp_init(struct sock *sk)
 
 	smcsock->type = SOCK_STREAM;
 	__module_get(THIS_MODULE); /* tried in __tcp_ulp_find_autoload */
-	ret = __smc_create(net, smcsock, protocol, 0, tcp);
+	ret = __smc_create(net, smcsock, protocol, false, true, tcp);
 	if (ret) {
 		sock_release(smcsock); /* module_put() which ops won't be NULL */
 		return ret;
diff --git a/net/socket.c b/net/socket.c
index e5b4e0d34132..d1b4dadd67e4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1561,7 +1561,7 @@ static int __sock_create(struct net *net, int family, int type, int protocol,
 	/* Now protected by module ref count */
 	rcu_read_unlock();
 
-	err = pf->create(net, sock, protocol, kern);
+	err = pf->create(net, sock, protocol, kern, hold_net);
 	if (err < 0) {
 		/* ->create should release the allocated sock->sk object on error
 		 * and make sure sock->sk is set to NULL to avoid use-after-free
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 65dcbb54f55d..4ee0bd1043e1 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -449,6 +449,7 @@ static int tipc_sk_sock_err(struct socket *sock, long *timeout)
  * @sock: pre-allocated socket structure
  * @protocol: protocol indicator (must be 0)
  * @kern: caused by kernel or by userspace?
+ * @hold_net: hold netns refcnt or not
  *
  * This routine creates additional data structures used by the TIPC socket,
  * initializes them, and links them together.
@@ -456,7 +457,7 @@ static int tipc_sk_sock_err(struct socket *sock, long *timeout)
  * Return: 0 on success, errno otherwise
  */
 static int tipc_sk_create(struct net *net, struct socket *sock,
-			  int protocol, int kern)
+			  int protocol, bool kern, bool hold_net)
 {
 	const struct proto_ops *ops;
 	struct sock *sk;
@@ -2735,7 +2736,8 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock,
 
 	buf = skb_peek(&sk->sk_receive_queue);
 
-	res = tipc_sk_create(sock_net(sock->sk), new_sock, 0, arg->kern);
+	res = tipc_sk_create(sock_net(sock->sk), new_sock, 0,
+			     arg->kern, !arg->kern);
 	if (res)
 		goto exit;
 	security_sk_clone(sock->sk, new_sock->sk);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6b1762300443..393be726004c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1006,7 +1006,8 @@ struct proto unix_stream_proto = {
 #endif
 };
 
-static struct sock *unix_create1(struct net *net, struct socket *sock, int kern, int type)
+static struct sock *unix_create1(struct net *net, struct socket *sock, int type,
+				 bool kern, bool hold_net)
 {
 	struct unix_sock *u;
 	struct sock *sk;
@@ -1061,7 +1062,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 }
 
 static int unix_create(struct net *net, struct socket *sock, int protocol,
-		       int kern)
+		       bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -1091,7 +1092,7 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
 		return -ESOCKTNOSUPPORT;
 	}
 
-	sk = unix_create1(net, sock, kern, sock->type);
+	sk = unix_create1(net, sock, sock->type, kern, hold_net);
 	if (IS_ERR(sk))
 		return PTR_ERR(sk);
 
@@ -1568,7 +1569,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	 */
 
 	/* create new sock for complete connection */
-	newsk = unix_create1(net, NULL, 0, sock->type);
+	newsk = unix_create1(net, NULL, sock->type, false, true);
 	if (IS_ERR(newsk)) {
 		err = PTR_ERR(newsk);
 		newsk = NULL;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..f2ce92cd57c4 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -732,7 +732,7 @@ static struct sock *__vsock_create(struct net *net,
 				   struct sock *parent,
 				   gfp_t priority,
 				   unsigned short type,
-				   int kern)
+				   bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct vsock_sock *psk;
@@ -864,7 +864,7 @@ static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 struct sock *vsock_create_connected(struct sock *parent)
 {
 	return __vsock_create(sock_net(parent), NULL, parent, GFP_KERNEL,
-			      parent->sk_type, 0);
+			      parent->sk_type, false, true);
 }
 EXPORT_SYMBOL_GPL(vsock_create_connected);
 
@@ -2399,7 +2399,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
 };
 
 static int vsock_create(struct net *net, struct socket *sock,
-			int protocol, int kern)
+			int protocol, bool kern, bool hold_net)
 {
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -2427,7 +2427,7 @@ static int vsock_create(struct net *net, struct socket *sock,
 
 	sock->state = SS_UNCONNECTED;
 
-	sk = __vsock_create(net, sock, NULL, GFP_KERNEL, 0, kern);
+	sk = __vsock_create(net, sock, NULL, GFP_KERNEL, 0, kern, hold_net);
 	if (!sk)
 		return -ENOMEM;
 
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 8dda4178497c..0b6c22b979e7 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -505,11 +505,12 @@ static struct proto x25_proto = {
 	.obj_size = sizeof(struct x25_sock),
 };
 
-static struct sock *x25_alloc_socket(struct net *net, int kern)
+static struct sock *x25_alloc_socket(struct net *net, bool kern, bool hold_net)
 {
 	struct x25_sock *x25;
-	struct sock *sk = sk_alloc(net, AF_X25, GFP_ATOMIC, &x25_proto, kern);
+	struct sock *sk;
 
+	sk = sk_alloc(net, AF_X25, GFP_ATOMIC, &x25_proto, kern);
 	if (!sk)
 		goto out;
 
@@ -525,7 +526,7 @@ static struct sock *x25_alloc_socket(struct net *net, int kern)
 }
 
 static int x25_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct x25_sock *x25;
@@ -543,7 +544,8 @@ static int x25_create(struct net *net, struct socket *sock, int protocol,
 		goto out;
 
 	rc = -ENOMEM;
-	if ((sk = x25_alloc_socket(net, kern)) == NULL)
+	sk = x25_alloc_socket(net, kern, hold_net);
+	if (!sk)
 		goto out;
 
 	x25 = x25_sk(sk);
@@ -592,7 +594,8 @@ static struct sock *x25_make_new(struct sock *osk)
 	if (osk->sk_type != SOCK_SEQPACKET)
 		goto out;
 
-	if ((sk = x25_alloc_socket(sock_net(osk), 0)) == NULL)
+	sk = x25_alloc_socket(sock_net(osk), false, true);
+	if (!sk)
 		goto out;
 
 	x25 = x25_sk(sk);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3fa70286c846..5763ef355c73 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1688,7 +1688,7 @@ static void xsk_destruct(struct sock *sk)
 }
 
 static int xsk_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+		      bool kern, bool hold_net)
 {
 	struct xdp_sock *xs;
 	struct sock *sk;
-- 
2.39.5 (Apple Git-154)


