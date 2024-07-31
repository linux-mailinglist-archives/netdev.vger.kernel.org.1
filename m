Return-Path: <netdev+bounces-114640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5E9434EE
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521EC1F232BC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D991BE227;
	Wed, 31 Jul 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="DmlD6Ov8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A01BD512
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446639; cv=none; b=mTSjsgkESGMARei6qfMCVERXCaNJwYP6t0RJ1Bzu3VwPOpZOVNF4pNmthBro4E6Nu2TQKmbcnmd1Yt5aZu/8AkTcRcFTbHYNqPB1B8JsIc3yyTreAgaTzU49FhfAtfkoib5EMUGXhLKsbRNXY5QzOq85G9bYYhjtEELoMEyxfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446639; c=relaxed/simple;
	bh=Q5ncU6hUSIyMrne9XD2fwUyOxTXcwg4oUbu/75rT4dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p64Q94Fx0YnLk6CatfX7o2sXfuXajZPD7RTVDTJxldSKpOxV+OsOYbRkxoflzpQC50N3C9OtYxFKu9lyYhSzkp++Ai8V2fVzPnxAI48q4MHaIvle7xAk1F6mx6muugYxQv67xmV4fk8tRHOK8S/LL51gDnOv7zRzNZF7eUb8BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=DmlD6Ov8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1c655141so4472114b3a.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446637; x=1723051437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vvijrc2anlLTYbTObgYbhL3tX3ZzyqYSkVQtZLVf5Sc=;
        b=DmlD6Ov8moEUdftCL/KyAnLEjSZLI+MHFAmoFOE/VZY4tMWFDjOuSNz91ZwvaotR7X
         0GL7guvdH3VdEWfxyuBqtpiV4UGRgW2dTGUtxKrKlYVoOtMNvG725ZxOcVcpNjbL+v6s
         +VvOCiSyApG2Xr7FgX1DlcSo3L/WEkj7n0r1+qnOPkYeCn68C/Pj6V4AYuPBeDmOGlXm
         oWcOjI6Hk4BlAVAECkXYcSabe4J8NcmosBYinuZLUSeObqy2Lx/NdA60ItyXS6tXV1HM
         FCGjAQ/CgDotqgRhn6cmSnR53antDPBTKfDlYNRhsDy7A7YDVjmCp+U22fhLNC1oprBz
         0khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446637; x=1723051437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvijrc2anlLTYbTObgYbhL3tX3ZzyqYSkVQtZLVf5Sc=;
        b=N6v41+fSRRmshdH7RtUfOE6krCMPn937wnVpvsEsVE+j7/ScdM1oagvUC99Mr9aZ9H
         gFXwrzc5ov9U3QIwXXih3pOuW7z08gBkSgO5Rtlqbw7UrweY50E/D6Y8hxuOCWcuE5g0
         DZKAq2PQITWFKFDXzgQYxTHF+/ZXTz6kk1Ca9m2FECiR65yEwzy7FnIQx7Gc2gY9lu+0
         E4rLlB/sEZkNnJOqPPRzWgoSYSWa9O+7Jtr0Y6RJMM65gm4YnTUAW0R9y6WzC3HdAXRO
         gdF5Veaf3rVe372VDhcYNnxfX9e1C0jingiPVaIzY9aE8SKmx3I2ByMImbe0gnWgw4JL
         06BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg+EfeiKbP/+8Q4u7ebThfpiaLcwjE11RR1flXUMXtvlu7KHWzL3r7YEw6e8cs2h7ardgdYxuXzSYjyNElVDBDv6Bngp2w
X-Gm-Message-State: AOJu0Yx4/A+ysP2gdohj48S0Wd2BdjPA5+D8VG4n8IfvAwaFVDWNVODV
	0mBws5oPEWNYQQixHN6S7lYkIP98pX5LL0S7X4seZVZHGN0j8iD4kzvYjOCBUg==
X-Google-Smtp-Source: AGHT+IFDMhY+KljIj829Sikt3jtl0TmFPDmgiz8ZEtNhjz5Vs9Lv6h1m1XlcvuMuv+D8Bdni0f8KQA==
X-Received: by 2002:a05:6a00:845:b0:70d:3777:da8e with SMTP id d2e1a72fcca58-70ecea3f2bdmr13342488b3a.18.1722446637103;
        Wed, 31 Jul 2024 10:23:57 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:56 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 05/12] udp_encaps: Set proper UDP_ENCAP types in tunnel setup
Date: Wed, 31 Jul 2024 10:23:25 -0700
Message-Id: <20240731172332.683815-6-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
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
index ba59e92ab941..38715186aac4 100644
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


