Return-Path: <netdev+bounces-283349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDVxCCds9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 775DA4B0C1C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66274302204C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445142C11E6;
	Sat,  2 May 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWylJZmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24872C21C4
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691651; cv=none; b=CBoXftv9E3GAgOLF/qZjNdlOX7YrWplbqgCfrcg0aBAj9dugNzIVwvhEjkakI+ZdfONga9bB5lIbPvgAO338UCqsuR/6UhwPSiW58uu1HjpTXfjkqVKZfbrchY/kqS2OU4oap/jpqq36wI/yiTgY2GFA3cB77UILqqo0tL+FEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691651; c=relaxed/simple;
	bh=133yG3tjr711QIq5Ag3aVURMO5PlgCyHCDPLOTM70VE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dKlvN5Zgkt2x3yU5qiknz+eDCLQVYc6q4eWsWnsA0nmnJ71oWCrWzDza5NcKNJ1JifSSU/+yS2YSTjDv8Yc8efV9FHMf9oj8s3UkDNVaSpEWO+i5kOG2Pts8fvHnxF2ukdchhUH6MV7MuO+2VJVFn9i0+OGXhiK9Rj/BF/otaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWylJZmB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so2303777b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691649; x=1778296449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4knP9OCtjVSV8O1hl4zOxzZJWx3N0YXNwhIwFnvGxs=;
        b=lWylJZmBV7SZ2yVvMUMrWvcHS+Hd5KHISLV7kzT7i98Gid9nq5CJHCtakdwuSzWD8e
         uL1bBEirLKMJhP3cFK6sUir2oPSArQXNe/RAZ6Mi0iJ8PQb+S9+q7/A3PjYJ1FsyukAo
         yIDtEnsClAHriqbe7WWQ7IkD/jtpZSIHwVvnGkuPYhtqLvcOWglWxK2EdvNmRDDNRnnE
         6LY92lA5ovUpT5LkS96kS/LoucQJyHU8d0o/ZoskeTCl0s6c0aWE3o6OolG1xaM1zfz4
         9pgdAPfivJiaPy8xanq3Nol0jC/soS6K4peYp0mfRHNRVgzBGGDn6As/QZsp/IUyoZOD
         cVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691649; x=1778296449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4knP9OCtjVSV8O1hl4zOxzZJWx3N0YXNwhIwFnvGxs=;
        b=hlRslEZdIb3TZ95MjNtZUArG7FFjuM+2bxHQrWyZCA8gFMBD8kynEVf3RmuGVr0bOW
         CuNOaCFJPy4eE4icyxS/os+1/2o8drXbyZ4EEVK59Jos+DkDGFe5JaE9trRTH0pXHGXM
         CX9LAyX3X6O6v5oyAkTewIEv2405VTcFRYIkdzkgF2DRDiwQYqJdyOKyRLWMAI1Uolpk
         EW2ur2dRnuFkB1umq6EDlywXU2qNWFIRAex2aZcTQUDFgS8N5pShyJfaevgm0fujU8ua
         wEvBDDsrB2DQeg3B56M3tQDxKL9jOFrWXY3SWjQLmpSOaYBc/X5wR4o+9rYd3CucHJJI
         Bkuw==
X-Forwarded-Encrypted: i=1; AFNElJ8pkzHBsEXFIVcKU1unJqT5b+NxVTLMtoZwuL3OG2iIv3YrX89gR52ZLYNDudsUQiZPL0Ty10s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPv2bT79SlmXBvwIA5Y4j1O2kCCpWUJyA2tXSLrKxTGDdOvM13
	r77WHXd/rT262lTq2099Nmu0gIKkkhlyFzRbUy4NHq2GSpSdhxa38SRV0O+LO8jE7WAvbfBSNnU
	Lr/1mYw==
X-Received: from pfbfb27.prod.google.com ([2002:a05:6a00:2d9b:b0:82f:b45c:d628])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3386:b0:82a:15a1:14d
 with SMTP id d2e1a72fcca58-8352c49fe18mr1342620b3a.14.1777691648564; Fri, 01
 May 2026 20:14:08 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:55 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/15] udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 775DA4B0C1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283349-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

None of the udp_tunnel users need struct socket in their
fast paths; it is only used for tunnel setup / teardown.

Even setup_udp_tunnel_sock() does not need struct socket.

Let's change setup_udp_tunnel_sock() to take struct sock
instead of struct socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
 drivers/net/amt.c                   | 2 +-
 drivers/net/bareudp.c               | 2 +-
 drivers/net/geneve.c                | 2 +-
 drivers/net/gtp.c                   | 4 ++--
 drivers/net/ovpn/udp.c              | 2 +-
 drivers/net/pfcp.c                  | 2 +-
 drivers/net/vxlan/vxlan_core.c      | 2 +-
 drivers/net/wireguard/socket.c      | 4 ++--
 include/net/udp_tunnel.h            | 2 +-
 net/ipv4/fou_core.c                 | 2 +-
 net/ipv4/udp_tunnel_core.c          | 4 +---
 net/l2tp/l2tp_core.c                | 2 +-
 net/rxrpc/local_object.c            | 2 +-
 net/sctp/protocol.c                 | 4 ++--
 net/tipc/udp_media.c                | 2 +-
 16 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index b454e4a17997..082ff387d081 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -283,7 +283,7 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
 	tnl_cfg.encap_rcv = rxe_udp_encap_recv;
 
 	/* Setup UDP tunnel */
-	setup_udp_tunnel_sock(net, sock, &tnl_cfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tnl_cfg);
 
 	return sock;
 }
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index fc415072864b..c03aa7c207e6 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2979,7 +2979,7 @@ static int amt_socket_create(struct amt_dev *amt)
 	tunnel_cfg.encap_rcv = amt_rcv;
 	tunnel_cfg.encap_err_lookup = amt_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(amt->net, sock, &tunnel_cfg);
+	setup_udp_tunnel_sock(amt->net, sock->sk, &tunnel_cfg);
 
 	rcu_assign_pointer(amt->sock, sock);
 	return 0;
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index f3025a5c5261..169ab90393cc 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -268,7 +268,7 @@ static int bareudp_socket_create(struct bareudp_dev *bareudp, __be16 port)
 	tunnel_cfg.encap_rcv = bareudp_udp_encap_recv;
 	tunnel_cfg.encap_err_lookup = bareudp_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(bareudp->net, sock, &tunnel_cfg);
+	setup_udp_tunnel_sock(bareudp->net, sock->sk, &tunnel_cfg);
 
 	rcu_assign_pointer(bareudp->sock, sock);
 	return 0;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 8d55160305ee..c3a7736cd6fc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1006,7 +1006,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	tunnel_cfg.encap_rcv = geneve_udp_encap_recv;
 	tunnel_cfg.encap_err_lookup = geneve_udp_encap_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tunnel_cfg);
 	list_add(&gs->list, &gn->sock_list);
 	return gs;
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 064ce1029d33..a60ef32b35b8 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1434,7 +1434,7 @@ static struct sock *gtp_create_sock(int type, struct gtp_dev *gtp,
 	tuncfg.encap_rcv = gtp_encap_recv;
 	tuncfg.encap_destroy = NULL;
 
-	setup_udp_tunnel_sock(net, sock, &tuncfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
 
 	return sock->sk;
 }
@@ -1689,7 +1689,7 @@ static struct sock *gtp_encap_enable_socket(int fd, int type,
 	tuncfg.encap_rcv = gtp_encap_recv;
 	tuncfg.encap_destroy = gtp_encap_destroy;
 
-	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &tuncfg);
+	setup_udp_tunnel_sock(sock_net(sock->sk), sk, &tuncfg);
 
 out_rel_sock:
 	release_sock(sock->sk);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 059e896b4a2f..493a5a0744af 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -399,7 +399,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
-		setup_udp_tunnel_sock(sock_net(ovpn_sock->sk), sock, &cfg);
+		setup_udp_tunnel_sock(sock_net(ovpn_sock->sk), sock->sk, &cfg);
 		return 0;
 	}
 
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index ce58038cfccb..870137695e8a 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -172,7 +172,7 @@ static struct socket *pfcp_create_sock(struct pfcp_dev *pfcp)
 	tuncfg.encap_rcv = pfcp_encap_recv;
 	tuncfg.encap_type = 1;
 
-	setup_udp_tunnel_sock(net, sock, &tuncfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
 
 	return sock;
 }
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1d1aba1c7cfc..394801c068b3 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3620,7 +3620,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 		tunnel_cfg.gro_complete = vxlan_gro_complete;
 	}
 
-	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tunnel_cfg);
 
 	return vs;
 }
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 4a4c177af170..0028ef17dc71 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -389,7 +389,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 		goto out;
 	}
 	set_sock_opts(new4);
-	setup_udp_tunnel_sock(net, new4, &cfg);
+	setup_udp_tunnel_sock(net, new4->sk, &cfg);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6_mod_enabled()) {
@@ -404,7 +404,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 			goto out;
 		}
 		set_sock_opts(new6);
-		setup_udp_tunnel_sock(net, new6, &cfg);
+		setup_udp_tunnel_sock(net, new6->sk, &cfg);
 	}
 #endif
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index dbbd56280f50..49324e28ec27 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -94,7 +94,7 @@ struct udp_tunnel_sock_cfg {
 };
 
 /* Setup the given (UDP) sock to receive UDP encapsulated packets */
-void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
+void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 			   struct udp_tunnel_sock_cfg *sock_cfg);
 
 /* -- List of parsable UDP tunnel types --
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 422f86291b42..6bed0e1dbe0e 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -615,7 +615,7 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 		goto error;
 	}
 
-	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
+	setup_udp_tunnel_sock(net, sk, &tunnel_cfg);
 
 	sk->sk_allocation = GFP_ATOMIC;
 
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 1159a6a6fbb2..3090b4745d47 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -68,11 +68,9 @@ static bool sk_saddr_any(struct sock *sk)
 #endif
 }
 
-void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
+void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 			   struct udp_tunnel_sock_cfg *cfg)
 {
-	struct sock *sk = sock->sk;
-
 	/* Disable multicast loopback */
 	inet_clear_bit(MC_LOOP, sk);
 
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 157fc23ce4e1..cbc5a3e57b33 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1683,7 +1683,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 			.encap_destroy = l2tp_udp_encap_destroy,
 		};
 
-		setup_udp_tunnel_sock(net, sock, &udp_cfg);
+		setup_udp_tunnel_sock(net, sock->sk, &udp_cfg);
 	}
 
 	sk->sk_allocation = GFP_ATOMIC;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 111f574fe667..169f9dfdaa77 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -194,7 +194,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	tuncfg.encap_rcv = rxrpc_encap_rcv;
 	tuncfg.encap_err_rcv = rxrpc_encap_err_rcv;
 	tuncfg.sk_user_data = local;
-	setup_udp_tunnel_sock(net, local->socket, &tuncfg);
+	setup_udp_tunnel_sock(net, local->socket->sk, &tuncfg);
 
 	/* set the socket up */
 	usk = local->socket->sk;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ffe594ad4414..5c6fa8e8d34d 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -864,7 +864,7 @@ int sctp_udp_sock_start(struct net *net)
 	tuncfg.encap_type = 1;
 	tuncfg.encap_rcv = sctp_udp_rcv;
 	tuncfg.encap_err_lookup = sctp_udp_v4_err;
-	setup_udp_tunnel_sock(net, sock, &tuncfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
 	net->sctp.udp4_sock = sock->sk;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -886,7 +886,7 @@ int sctp_udp_sock_start(struct net *net)
 	tuncfg.encap_type = 1;
 	tuncfg.encap_rcv = sctp_udp_rcv;
 	tuncfg.encap_err_lookup = sctp_udp_v6_err;
-	setup_udp_tunnel_sock(net, sock, &tuncfg);
+	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
 	net->sctp.udp6_sock = sock->sk;
 #endif
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index d7c050ff5804..0db172f1a41a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -771,7 +771,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 	tuncfg.encap_type = 1;
 	tuncfg.encap_rcv = tipc_udp_recv;
 	tuncfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(net, ub->ubsock, &tuncfg);
+	setup_udp_tunnel_sock(net, ub->ubsock->sk, &tuncfg);
 
 	err = dst_cache_init(&ub->rcast.dst_cache, GFP_ATOMIC);
 	if (err)
-- 
2.54.0.545.g6539524ca2-goog


