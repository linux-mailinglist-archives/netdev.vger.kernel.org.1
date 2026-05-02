Return-Path: <netdev+bounces-283348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNuXDQNs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C71504B0C13
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB84130089A3
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698329AB02;
	Sat,  2 May 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="raSvF+C0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE322C15A9
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691649; cv=none; b=XsQSf9x/Y+1SNL5/Apy6Y89jmVJOj8xG/X++l6i4tzccqCGzYbO7FF3bEuuv1KAlIVtRqNX8ehkPoyRkLJmmRm6F5t+N6NwNrTkODx9wYyARBN0MngxFPcouQpLai7M64/lNrmncStWPBjGfmUHevsPPYK3T1JoyEswEqYLJAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691649; c=relaxed/simple;
	bh=UgRGr+WKxRWNf7eLNHdLblTifuqZuSid3imMHFEpzKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gn7AhikkfDFk0eeAmfF/nLDwd8m/zTW0s1I13OnKjn184CYzbztMKnWORxhgnsW1cnU0Vf+H7dQEWfffMDZ4FIswDAay3aRawjnUvdaX9rUhr9p8Kk5kEaST+KIzuSU9EMZNZTtYjbx8CONr7DmFOaicX6nZ2vsCvC8yqU26r40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=raSvF+C0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36512c65928so269143a91.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691647; x=1778296447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzSZrQeG4f4nP07qHFLajU5wfv/F2NWySsay3SjAE44=;
        b=raSvF+C0emh0zZNrF1kED2uV5u+1BP9DxlD2AL3fhEgD7OIz4Hc1MCTKLKig/Phjal
         Y7EkpEpmNDvPZsg+6yMo1cOcFdikJAuROpL29zqOmSELG9fYE6srEPi8KQ16iKQ2+xML
         p1ogyP7mMaxvNqAxsXyTq8K0BcPU/IWwCJUJtBHMIG+IRv085u9RrRa+A1xqMNEpAkDa
         xD9/33H+SfNfMNDXiisDQOWiDzqUnVzykutDSJhahwK7jeuyzuA3SaZp7W8iMdaCCdQk
         o5GRI+BVfFe0cwRXoksMsH5EQMma5jpi5KjBqGJiZT6jXGynzc1DKvLOa462m86Z6gCQ
         l+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691647; x=1778296447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzSZrQeG4f4nP07qHFLajU5wfv/F2NWySsay3SjAE44=;
        b=FBqoHLMAbfuhShRocvKWVbINbr2f64VxzAC60qNp+SSgySPyc8A/cRVvPZ3tG1doid
         5oqpYlP2UBGjimVLu321RdyXwc9Q6X1E3uLyxGi67qEgEO9x/GlXcYgKwk5giooU9cqw
         +EnoQZXBxcG6tX6FtNgfdbjdCHU7LjhGeOqfpkW3Y2j0dBnvehWiHALijK1NdDVH73an
         KscnPtPk9Zk3HLw11XEEs5h/o39fXinCUw8hKsGNJPURNMFXyx/1hxIQgJhCu1MTxlYD
         DlRukO1sUWCfgW7+oDuB6x6Y0a+53mXGLImAZWMEcTfWv5VR2DFY7sEl95b3g4aF36mB
         1+ww==
X-Forwarded-Encrypted: i=1; AFNElJ9G2Qjv/KLshRo6lQsQLV/+a/wzbfKgEt7rigzk15QicgfPD73HLUmECb/4YSuwLmCvdexw9z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ld4/yNsCyb6QlWAiqVn0aYW1LGXAGuWJgW3P6+zkMc2WrCia
	uIdazoUAIduS/OAJIGkfGDyrvTEQ/czdvPVuE2g4pRh5xKmmJ8azrO71covmOZe15NnqaSUja4o
	iAmdkxQ==
X-Received: from pfib3.prod.google.com ([2002:aa7:8103:0:b0:82f:bd60:74cb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a7:b0:398:71f2:59b7
 with SMTP id adf61e73a8af0-3a7f1c6cba8mr1575674637.33.1777691646838; Fri, 01
 May 2026 20:14:06 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:54 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/15] udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C71504B0C13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283348-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

None of the udp_tunnel users need struct socket in their
fast paths; it is only used for tunnel setup / teardown.

While the UDP tunnel interface accepts struct socket, this
encourages users to store the pointer unnecessarily.  This
leads to extra dereferences when accessing struct sock fields
(e.g., sk->sk_user_data instead of sock->sk->sk_user_data).

Furthermore, these dereferences necessitate synchronize_rcu()
in udp_tunnel_sock_release() to protect the fast paths from
sock_orphan() setting sk->sk_socket to NULL.

This overhead can be avoided if users store the struct sock
pointer directly in their private structures.

As a prep, let's change udp_tunnel_sock_release() to take
struct sock instead of struct socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 4 ++--
 drivers/infiniband/sw/rxe/rxe_ns.c  | 4 ++--
 drivers/net/amt.c                   | 2 +-
 drivers/net/bareudp.c               | 2 +-
 drivers/net/geneve.c                | 2 +-
 drivers/net/gtp.c                   | 6 +++---
 drivers/net/pfcp.c                  | 2 +-
 drivers/net/vxlan/vxlan_core.c      | 4 ++--
 drivers/net/wireguard/socket.c      | 4 ++--
 include/net/udp_tunnel.h            | 2 +-
 net/ipv4/fou_core.c                 | 7 ++-----
 net/ipv4/udp_tunnel_core.c          | 6 ++++--
 net/sctp/protocol.c                 | 6 +++---
 net/tipc/udp_media.c                | 4 ++--
 14 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..b454e4a17997 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -288,7 +288,7 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
 	return sock;
 }
 
-static void rxe_release_udp_tunnel(struct socket *sk)
+static void rxe_release_udp_tunnel(struct sock *sk)
 {
 	if (sk)
 		udp_tunnel_sock_release(sk);
@@ -636,7 +636,7 @@ static void rxe_sock_put(struct sock *sk,
 	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
 		__sock_put(sk);
 	} else {
-		rxe_release_udp_tunnel(sk->sk_socket);
+		rxe_release_udp_tunnel(sk);
 		sk = NULL;
 		set_sk(net, sk);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 8b9d734229b2..64621c89f8bf 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -47,7 +47,7 @@ static void rxe_ns_exit(struct net *net)
 	rcu_read_unlock();
 	if (sk) {
 		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
-		udp_tunnel_sock_release(sk->sk_socket);
+		udp_tunnel_sock_release(sk);
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -56,7 +56,7 @@ static void rxe_ns_exit(struct net *net)
 	rcu_read_unlock();
 	if (sk) {
 		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
-		udp_tunnel_sock_release(sk->sk_socket);
+		udp_tunnel_sock_release(sk);
 	}
 #endif
 }
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139e38a5..fc415072864b 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3032,7 +3032,7 @@ static int amt_dev_stop(struct net_device *dev)
 	RCU_INIT_POINTER(amt->sock, NULL);
 	synchronize_net();
 	if (sock)
-		udp_tunnel_sock_release(sock);
+		udp_tunnel_sock_release(sock->sk);
 
 	cancel_work_sync(&amt->event_wq);
 	for (i = 0; i < AMT_MAX_EVENTS; i++) {
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index da5866ba0699..f3025a5c5261 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -290,7 +290,7 @@ static void bareudp_sock_release(struct bareudp_dev *bareudp)
 	sock = bareudp->sock;
 	rcu_assign_pointer(bareudp->sock, NULL);
 	synchronize_net();
-	udp_tunnel_sock_release(sock);
+	udp_tunnel_sock_release(sock->sk);
 }
 
 static int bareudp_stop(struct net_device *dev)
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c6563367d382..8d55160305ee 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1018,7 +1018,7 @@ static void __geneve_sock_release(struct geneve_sock *gs)
 
 	list_del(&gs->list);
 	udp_tunnel_notify_del_rx_port(gs->sock, UDP_TUNNEL_TYPE_GENEVE);
-	udp_tunnel_sock_release(gs->sock);
+	udp_tunnel_sock_release(gs->sock->sk);
 	kfree_rcu(gs, rcu);
 }
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5150f2e4f66b..064ce1029d33 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -885,8 +885,8 @@ static void gtp_encap_disable_sock(struct sock *sk)
 static void gtp_encap_disable(struct gtp_dev *gtp)
 {
 	if (gtp->sk_created) {
-		udp_tunnel_sock_release(gtp->sk0->sk_socket);
-		udp_tunnel_sock_release(gtp->sk1u->sk_socket);
+		udp_tunnel_sock_release(gtp->sk0);
+		udp_tunnel_sock_release(gtp->sk1u);
 		gtp->sk_created = false;
 		gtp->sk0 = NULL;
 		gtp->sk1u = NULL;
@@ -1451,7 +1451,7 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
 
 	sk1u = gtp_create_sock(UDP_ENCAP_GTP1U, gtp, nla, family);
 	if (IS_ERR(sk1u)) {
-		udp_tunnel_sock_release(sk0->sk_socket);
+		udp_tunnel_sock_release(sk0);
 		return PTR_ERR(sk1u);
 	}
 
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 28e6bc4a1f14..ce58038cfccb 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -104,7 +104,7 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 static void pfcp_del_sock(struct pfcp_dev *pfcp)
 {
-	udp_tunnel_sock_release(pfcp->sock);
+	udp_tunnel_sock_release(pfcp->sock->sk);
 	pfcp->sock = NULL;
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e88798497503..1d1aba1c7cfc 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1519,13 +1519,13 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 		vxlan_vs_del_dev(vxlan);
 
 	if (__vxlan_sock_release_prep(sock4)) {
-		udp_tunnel_sock_release(sock4->sock);
+		udp_tunnel_sock_release(sock4->sock->sk);
 		kfree(sock4);
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (__vxlan_sock_release_prep(sock6)) {
-		udp_tunnel_sock_release(sock6->sock);
+		udp_tunnel_sock_release(sock6->sock->sk);
 		kfree(sock6);
 	}
 #endif
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index c362c78d908e..4a4c177af170 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -335,7 +335,7 @@ static void sock_free(struct sock *sock)
 	if (unlikely(!sock))
 		return;
 	sk_clear_memalloc(sock);
-	udp_tunnel_sock_release(sock->sk_socket);
+	udp_tunnel_sock_release(sock);
 }
 
 static void set_sock_opts(struct socket *sock)
@@ -396,7 +396,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 		port6.local_udp_port = inet_sk(new4->sk)->inet_sport;
 		ret = udp_sock_create(net, &port6, &new6);
 		if (ret < 0) {
-			udp_tunnel_sock_release(new4);
+			udp_tunnel_sock_release(new4->sk);
 			if (ret == -EADDRINUSE && !port && retries++ < 100)
 				goto retry;
 			pr_err("%s: Could not create IPv6 socket\n",
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 47c23d4a1740..dbbd56280f50 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -176,7 +176,7 @@ static inline void udp_tunnel_set_inner_protocol(struct sk_buff *skb,
 		skb_set_inner_protocol(skb, inner_proto);
 }
 
-void udp_tunnel_sock_release(struct socket *sock);
+void udp_tunnel_sock_release(struct sock *sk);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 5bae3cf7fe76..422f86291b42 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -558,11 +558,8 @@ static int fou_add_to_port_list(struct net *net, struct fou *fou,
 
 static void fou_release(struct fou *fou)
 {
-	struct socket *sock = fou->sock;
-
 	list_del(&fou->list);
-	udp_tunnel_sock_release(sock);
-
+	udp_tunnel_sock_release(fou->sock->sk);
 	kfree_rcu(fou, rcu);
 }
 
@@ -634,7 +631,7 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 error:
 	kfree(fou);
 	if (sock)
-		udp_tunnel_sock_release(sock);
+		udp_tunnel_sock_release(sock->sk);
 
 	return err;
 }
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..1159a6a6fbb2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -195,9 +195,11 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
-void udp_tunnel_sock_release(struct socket *sock)
+void udp_tunnel_sock_release(struct sock *sk)
 {
-	rcu_assign_sk_user_data(sock->sk, NULL);
+	struct socket *sock = sk->sk_socket;
+
+	rcu_assign_sk_user_data(sk, NULL);
 	synchronize_rcu();
 	kernel_sock_shutdown(sock, SHUT_RDWR);
 	sock_release(sock);
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 5800e7ee7ea0..ffe594ad4414 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -878,7 +878,7 @@ int sctp_udp_sock_start(struct net *net)
 	err = udp_sock_create(net, &udp_conf, &sock);
 	if (err) {
 		pr_err("Failed to create the SCTP UDP tunneling v6 sock\n");
-		udp_tunnel_sock_release(net->sctp.udp4_sock->sk_socket);
+		udp_tunnel_sock_release(net->sctp.udp4_sock);
 		net->sctp.udp4_sock = NULL;
 		return err;
 	}
@@ -896,11 +896,11 @@ int sctp_udp_sock_start(struct net *net)
 void sctp_udp_sock_stop(struct net *net)
 {
 	if (net->sctp.udp4_sock) {
-		udp_tunnel_sock_release(net->sctp.udp4_sock->sk_socket);
+		udp_tunnel_sock_release(net->sctp.udp4_sock);
 		net->sctp.udp4_sock = NULL;
 	}
 	if (net->sctp.udp6_sock) {
-		udp_tunnel_sock_release(net->sctp.udp6_sock->sk_socket);
+		udp_tunnel_sock_release(net->sctp.udp6_sock);
 		net->sctp.udp6_sock = NULL;
 	}
 }
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 2c66b356025a..d7c050ff5804 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -793,7 +793,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 
 free:
 	dst_cache_destroy(&ub->rcast.dst_cache);
-	udp_tunnel_sock_release(ub->ubsock);
+	udp_tunnel_sock_release(ub->ubsock->sk);
 err:
 	kfree(ub);
 	return err;
@@ -815,7 +815,7 @@ static void cleanup_bearer(struct work_struct *work)
 	tn = tipc_net(sock_net(ub->ubsock->sk));
 
 	dst_cache_destroy(&ub->rcast.dst_cache);
-	udp_tunnel_sock_release(ub->ubsock);
+	udp_tunnel_sock_release(ub->ubsock->sk);
 
 	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
-- 
2.54.0.545.g6539524ca2-goog


