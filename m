Return-Path: <netdev+bounces-121507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79D95D7B9
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14742281A6C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F83194A4F;
	Fri, 23 Aug 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="SPzXxcn3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D5194A4B
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444175; cv=none; b=PVPD6ukn9VzD9TpSN4GdgvlwKJS/JcXsjmkmuikyOn0vLtqich6hbOLeU8FfDS0lfFs4qYcwZ5rb1iZrpnYEbNxlNDHM1+4Nxt1wWr7sIKFKUXyxFWwv324uGUfLW4wOUaNwgrTtKdOMgM6X7r7+csAnl1W42d2RIAyp8P30j7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444175; c=relaxed/simple;
	bh=nYu8yZ/VN1Dg7+BXBxyOnOybgHomc2LXxWLVKv9ctjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qaPJ3mgPuFc+8bm1TU55sA/eymNzZRfgLl8A5gwJGlU2intH3xP40rSMmJxc5UPdhGHvJwLWJZxoD0JMIJn/pQV05i5lHmJolDKIikDmQz///hje7bdb2yPX1lvcwCYLyvSXzUsIQTpIwHUK82MBCVml0YGP5BjhG7Hnaxv9WRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=SPzXxcn3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so1692083a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444173; x=1725048973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1sb8cWs53jZLxOrCKQjc0PrlsqOnPbedcs+Sjt1xik=;
        b=SPzXxcn3xLnF3ZX1zSZbfz/0nqvpuvBP734pWn/qz++YXDtloPjOpUkAqdBAVDQTIg
         9KuFdmWJ4Buzf4fcsZ3A1sZoHRPzsUSyLoeOgP6dQX/2T857w8ltOyjdNdDRgkjegyur
         TVPaAX2asyL90a/pqUYfZwBnYse3JMBL15pMfCTaopYt+o4pefbz6WoXAxqGc0DGiDTn
         6sODSa1CI5JQG/Sx+Do99vcCNM5zpXBwZ+JbKL++FbiF2ngwD3IHIDAbVNIgKbZZnu0Q
         pwqJuKUEaurTjjl8hqQ/pV9343/N3WODNsnmi2J22zjIdqyVIaYzVRjBHgTeNNamwuUX
         IUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444173; x=1725048973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1sb8cWs53jZLxOrCKQjc0PrlsqOnPbedcs+Sjt1xik=;
        b=aTO5UejOFFwhHf2+oXLSZQfaxW9pvWikVsxsLcdCDfN69Ir/O6i/nW+NHd0yw0DU9l
         vmTz97TDUInvwlpItFy7N6p3qdRbYVTKvU7WkYd4NcH3IJlz88hMX7is+5doteBnwvlM
         tl/0RsbFuG/D27GeHZ4uIPyRfXAFBdOYlPynWlQ9mjGrx5+ydRAwJ3WYQQ2DbMSSxAgN
         QjT28cX9irm7Qi2H6+3DDNYsb6eQcv7owgLeO7ojGhCd4ixSoZKRgEO02JLZrMB7vI1Q
         0PIUiudZ/B4QOgLu3+QG2KAa6sulbuZYv4+nFs6I10+qAPrC8YRjxgyvAz90FG4g6TdB
         hbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz/MNwKKgPKUkPYwZPiXIXmhTNlM/VgqePcvwze5yyVkqU1uNJUn0phf1iBdGeFMS3jABQxZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzleFbnGAagV1yetVd44D2S85rJQ+Q17CEnQnDg7qWPyNclSFLs
	i31mjRWOJKeZYo6ePuRvrK49B+YMV5xbahwbuHHOvzNBrByKxrsXGoE+Jll2Gg==
X-Google-Smtp-Source: AGHT+IGHSkqxYcDFAOOvjm88ZooDqYYtfq407lxNHMIeEh+vrN5XsgnEkmZ6LyfL67baGL3uOVQihw==
X-Received: by 2002:a05:6a20:9d90:b0:1ca:ccfc:eddb with SMTP id adf61e73a8af0-1cc8a2679demr3916513637.49.1724444172566;
        Fri, 23 Aug 2024 13:16:12 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:12 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 04/13] udp_encaps: Set proper UDP_ENCAP types in tunnel setup
Date: Fri, 23 Aug 2024 13:15:48 -0700
Message-Id: <20240823201557.1794985-5-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of just setting UDP tunnel config encap_type to 1,
use the appropriate constat for the tunnel type. This value
can be used to determine the encapsulated protocol in UDP
by looking at the socket

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
 drivers/net/amt.c                   | 2 +-
 drivers/net/bareudp.c               | 2 +-
 drivers/net/geneve.c                | 2 +-
 drivers/net/pfcp.c                  | 2 +-
 drivers/net/vxlan/vxlan_core.c      | 3 ++-
 drivers/net/wireguard/socket.c      | 2 +-
 net/ipv4/fou_core.c                 | 3 ++-
 net/sctp/protocol.c                 | 2 +-
 net/tipc/udp_media.c                | 2 +-
 10 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 75d1407db52d..1c2bb88132c5 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -193,7 +193,7 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	tnl_cfg.encap_type = 1;
+	tnl_cfg.encap_type = UDP_ENCAP_RXE;
 	tnl_cfg.encap_rcv = rxe_udp_encap_recv;
 
 	/* Setup UDP tunnel */
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 6d15ab3bfbbc..fc421cf2c032 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2970,7 +2970,7 @@ static int amt_socket_create(struct amt_dev *amt)
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
 	tunnel_cfg.sk_user_data = amt;
-	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_type = UDP_ENCAP_AMT;
 	tunnel_cfg.encap_rcv = amt_rcv;
 	tunnel_cfg.encap_err_lookup = amt_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d5c56ca91b77..007fb8c5168b 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -248,7 +248,7 @@ static int bareudp_socket_create(struct bareudp_dev *bareudp, __be16 port)
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
 	tunnel_cfg.sk_user_data = bareudp;
-	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_type = UDP_ENCAP_BAREUDP;
 	tunnel_cfg.encap_rcv = bareudp_udp_encap_recv;
 	tunnel_cfg.encap_err_lookup = bareudp_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..923c573b6e5c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -611,7 +611,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
 	tunnel_cfg.sk_user_data = gs;
-	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_type = UDP_ENCAP_GENEVE;
 	tunnel_cfg.gro_receive = geneve_gro_receive;
 	tunnel_cfg.gro_complete = geneve_gro_complete;
 	tunnel_cfg.encap_rcv = geneve_udp_encap_recv;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..c7e4fa606b16 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -170,7 +170,7 @@ static struct socket *pfcp_create_sock(struct pfcp_dev *pfcp)
 
 	tuncfg.sk_user_data = pfcp;
 	tuncfg.encap_rcv = pfcp_encap_recv;
-	tuncfg.encap_type = 1;
+	tuncfg.encap_type = UDP_ENCAP_PFCP;
 
 	setup_udp_tunnel_sock(net, sock, &tuncfg);
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8983e75e9881..e02cbc018b8c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3572,7 +3572,8 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	/* Mark socket as an encapsulation socket. */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
 	tunnel_cfg.sk_user_data = vs;
-	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_type = vs->flags & VXLAN_F_GPE ?
+			UDP_ENCAP_VXLAN_GPE : UDP_ENCAP_VXLAN;
 	tunnel_cfg.encap_rcv = vxlan_rcv;
 	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0414d7a6ce74..f4b5bd14fd56 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -352,7 +352,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	int ret;
 	struct udp_tunnel_sock_cfg cfg = {
 		.sk_user_data = wg,
-		.encap_type = 1,
+		.encap_type = UDP_ENCAP_WIREGUARD,
 		.encap_rcv = wg_receive
 	};
 	struct socket *new4 = NULL, *new6 = NULL;
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0abbc413e0fe..8241f762e45b 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -578,19 +578,20 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	fou->sock = sock;
 
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
-	tunnel_cfg.encap_type = 1;
 	tunnel_cfg.sk_user_data = fou;
 	tunnel_cfg.encap_destroy = NULL;
 
 	/* Initial for fou type */
 	switch (cfg->type) {
 	case FOU_ENCAP_DIRECT:
+		tunnel_cfg.encap_type = UDP_ENCAP_FOU;
 		tunnel_cfg.encap_rcv = fou_udp_recv;
 		tunnel_cfg.gro_receive = fou_gro_receive;
 		tunnel_cfg.gro_complete = fou_gro_complete;
 		fou->protocol = cfg->protocol;
 		break;
 	case FOU_ENCAP_GUE:
+		tunnel_cfg.encap_type = UDP_ENCAP_GUE;
 		tunnel_cfg.encap_rcv = gue_udp_recv;
 		tunnel_cfg.gro_receive = gue_gro_receive;
 		tunnel_cfg.gro_complete = gue_gro_complete;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 5a7436a13b74..290ebcf17a48 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -876,7 +876,7 @@ int sctp_udp_sock_start(struct net *net)
 		return err;
 	}
 
-	tuncfg.encap_type = 1;
+	tuncfg.encap_type = UDP_ENCAP_SCTP;
 	tuncfg.encap_rcv = sctp_udp_rcv;
 	tuncfg.encap_err_lookup = sctp_udp_v4_err;
 	setup_udp_tunnel_sock(net, sock, &tuncfg);
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 439f75539977..3c081b7b9d67 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -771,7 +771,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 	if (err)
 		goto err;
 	tuncfg.sk_user_data = ub;
-	tuncfg.encap_type = 1;
+	tuncfg.encap_type = UDP_ENCAP_TIPC;
 	tuncfg.encap_rcv = tipc_udp_recv;
 	tuncfg.encap_destroy = NULL;
 	setup_udp_tunnel_sock(net, ub->ubsock, &tuncfg);
-- 
2.34.1


