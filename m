Return-Path: <netdev+bounces-120725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5B95A678
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2040B21D14
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24A175D3A;
	Wed, 21 Aug 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="KJsB4Iif"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEA177981
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275363; cv=none; b=VUkq/O9/u7y8JBchLQ7vuyuEdAltmHDMjqIrebUz8Fpwyd+jF7c15QDTvwAM3E8hIXdEgaVWP2RHqqMP38mQfsHhiEsbHaWQqJIJfhB/nMb0w8wVEAxkHy4JJtNupHDTBiZn2Gu0kYGv8JxG5mVpqnRIUcFHiyluk2YZXHNEadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275363; c=relaxed/simple;
	bh=nYu8yZ/VN1Dg7+BXBxyOnOybgHomc2LXxWLVKv9ctjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjXjDuES31e7yBoGpI6x/It153F8VQoYLudjPQS8EZyq5m8P+poXu2p8yVCdupW79mX7dyNeEAXQMeBulP2gYoRNG9ufsrCNtraRZLNvBctviXcsgmDz2L/T8UJ9JytH0jAGKFhFlyqkwKpF39WTfChxIcA+bIERF4dNQfZ1piI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=KJsB4Iif; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20227ba378eso1366165ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275361; x=1724880161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1sb8cWs53jZLxOrCKQjc0PrlsqOnPbedcs+Sjt1xik=;
        b=KJsB4Iifb5Jf5gaW0cTt1P/jOk2lXdwFzmuUkipGv1PsN0H+1BnhJvKvAois+LI6CV
         5PPgDK+oNxrYPLnJQcjJ/SuNPz9JT/ut4oHDRoRUMdQObMQdL/JL5NzOGyF95RVUqoK8
         8WN1WD5+BzY4Re5RzOAjY0XoMOiSPzMNwigYBjh++bJs3dzMiAil3cu1bmUPKB8YtrT2
         XeLNXc6sYuK4DN/l1C6eJvKtW4CbLy6kEYw6gvAlrx0OY79CfJ6FRN72siT+SJOgeX9L
         jmsj2COeTAUUi1h1pRJqJlSOzuOkoaCL+pPb+VEL4hDM0EWJEmFYqBA3c5oQr4957fPU
         aWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275361; x=1724880161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1sb8cWs53jZLxOrCKQjc0PrlsqOnPbedcs+Sjt1xik=;
        b=a2XRUDQhClSaubImuH2mvfcTieTMNUI+tWQognav7E5RmurzUm48UhtfbZq4YzrWSv
         pIDvXEPE5ud4CX45Q5gCa4f6fd95OtKcnGzGW6u1jCcMJ8ApMU7Du90ZIpq/EyPXytVH
         bZ9S0zZX6clvMHoqgb8UmwmuvJu971TDYTo1jzNDIHBqw7wz4q4jyiffUi2BxESl3PQP
         z6ebZ4oHFSEi5maLFxU9oUbwbNd35YB+rQNNJvFdNbwN73BKSONFiOWtDN2T7V8zBtr1
         6Xqw/s9Ai+YxKyWYVDCuo4YYtumBIriwUIyd3mVkHbW+GpALeI/WSmSMxjkrMeGSEHSY
         YxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE4DLjAN4PjleJnusdAgIOdsvA+XX2cmlvoFT1UjLCevGkYYPIdzQ7WGdj9ye69U/7XlbuIMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDtp2YZn792lFGUi/GVLobjShZ5LOiKVUpVPNQLRXikcnao+e
	dCPfUySXuJcK+TBAPO1t1bWPJCvuyJNGMBVGmYc0fVZLvef3HDpe4YW2KR5DwA==
X-Google-Smtp-Source: AGHT+IFXKARSVoeNligjxtsRnyn1JW0zZ/uZYDNRnRpsrSzMqCMhER5LhmYxY9QXrPWHRQNlNocUUg==
X-Received: by 2002:a17:902:e544:b0:202:2b3c:9ace with SMTP id d9443c01a7336-20367d31d30mr42397725ad.30.1724275361162;
        Wed, 21 Aug 2024 14:22:41 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:40 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/13] udp_encaps: Set proper UDP_ENCAP types in tunnel setup
Date: Wed, 21 Aug 2024 14:22:03 -0700
Message-Id: <20240821212212.1795357-5-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
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


