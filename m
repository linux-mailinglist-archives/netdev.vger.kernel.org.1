Return-Path: <netdev+bounces-192091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67554ABE876
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5857A1B6631E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFED528;
	Wed, 21 May 2025 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OTjqUR/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14713259C
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786178; cv=none; b=YvCfhKEQNsyYa6u4B2JWHnBeJJtoKFqIZQeiRn1+HEdlFyS6olMtvk53RyTbdThlWcPpC2dUKUYQoiKVSFDoF9UZe/IkF7acd/8+NHThOVFNheCnvf9lKSXU45zLLz9+fw2jz7dbn/c4QQqcIcCoLy5ojFY5yiJw7KVfvmwT4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786178; c=relaxed/simple;
	bh=DF/bp2EradUNcavmE46ckH1LMzkfKEMKqRtnyb9d0gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb7yS6wZ6elp4e20t4spYajIRkM2u7HYRcZjwy8mEuF66PwFV9HxC6nVTYMOmKchy2ZWHWak5g9rqXp0lzGnCJgankdO24JUxFyNmGoJPVwA9G0BWzj9l3bqPslHZUNSU8YeHYoADWDZowOdM8yePFmGObN18ZK4pBEaTf6UWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OTjqUR/Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441ab63a415so67935675e9.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747786174; x=1748390974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqBlPt+NnugKC5UG44iW96dcZO3Y9+fOvSZxKsKUBS0=;
        b=OTjqUR/QYGiI2YI6dp2OwxDJLmjHhq8onUy1bpeq8nu/hF9nnOpg1z/z1+M7Rkt/P1
         7AcskJ7/n0osAbwaSzMTxhcHXjQ6KfsXxtCrR9gL8T1gJm2+ov3xtntKgYzau5JgHj9T
         xjEUbRM287gU/NIfXfpWkgLvdCvCt0VCwDOTqqVb386SPL6W29/83TOJgLDNXILejyIV
         2dl1L9HP5EC8Et5QoSdV9qbWM82w522sW/wU7iUJMKpc9EHnyT7ZeRZShZchf9d4Uf/8
         i0ogcd93zTpI9Kbk3QCJnbfphLpSHKruTfKeZ93J+kBlgj68InbOLZU18VBhV2hJ+4yJ
         XvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747786174; x=1748390974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqBlPt+NnugKC5UG44iW96dcZO3Y9+fOvSZxKsKUBS0=;
        b=IVtf8gARyhmhO7a2cWR8Mc93GR8UhZXYcOCBIWYHPf8AsgMfYjX5Y2Sl+8sOfjb9vK
         gnagSM9o6+TqKD5VVjeR5XiG4Ex+6lZ1LjUOOSUvexXk0uk0zvKCk3QDgKeUaJ5GKUph
         yDU4qjVKgaXzs3+XdDLiPjh+xbYRLgENPEg9WEcjMJiniqwWRAqbLe+3Fb9l0I706asv
         WngmvIj8sZgE9XHVdYQQ72WylwOmGfDaJfo3iGBsKP6l8BuKiwEmCA0XyqeVZlk7OBIQ
         Z1J1XJpExUu/U+w/+hfzpPGd9iWcAzeUw0gRxKxvtRqaVFu8XExm2tab4RIrFti2yRse
         II8A==
X-Gm-Message-State: AOJu0Ywkit8fq+epnak276fuIIy0l2s/OSFHu1SLOtsAU3eqHZYOTMaU
	jIMeQlXUePWPQXhuE4D3hUOjoBp/JYX0Aa2U1RvBhb8iEeGyZhE7aQd1riy7m8NSxccMFs+uypc
	aq/+44ySidOiiTxrh+DXWFOAIkFm561TdTIVh2pWmlJeBq7AG7bdmRLfPxzVn7qXj
X-Gm-Gg: ASbGncv2EzEiMfe/CkEXLPhddCEY+pFBHZJ13nH+XRMd/Q9zoVkoWa43yxmy7rOPsy9
	HsBWZxD+ADg/+Ha5qFgZKc2DYQPTkvpJobCQY5H3UcSVivwOTeQ3N4lPg+lAJiXmTDoF7GY/b7q
	rZRF4BFmQsQFRWveWy9mbbz364d9VR31pBQthEw9oO4BwNJIaLaOrh9VCeUEzRnspmaxe14FlhY
	sUMxKZ1h++3sdBmgxbPXq23WRzeDZWHWc/8HVFkt8eGp37IkmBogHWEKSE9+Q3hv2Yc22Dd6GeP
	T2hvjdardWWf7iPkLLaaQqPE2nhvDtaeeqSe7YQ1w5RNd9V5CNhf2t2VkVDYkVvCDh1Mc7+2rLU
	DNKJhJ6+0
X-Google-Smtp-Source: AGHT+IH5lFNCYmfyM25g4JlL33MEJfKt6RJZIm4F1davnz96TvWWqbo0JtV5ofgY+GwblKgg8i3XYg==
X-Received: by 2002:adf:e385:0:b0:3a3:6282:693a with SMTP id ffacd0b85a97d-3a362826998mr13134056f8f.44.1747786173675;
        Tue, 20 May 2025 17:09:33 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:95de:7ee6:b663:1a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3620dbc6asm16625042f8f.88.2025.05.20.17.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 17:09:33 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH net-next 1/3] ovpn: properly deconfigure UDP-tunnel
Date: Wed, 21 May 2025 01:39:35 +0200
Message-ID: <20250520233937.5161-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520233937.5161-1-antonio@openvpn.net>
References: <20250520233937.5161-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deconfiguring a UDP-tunnel from a socket, we cannot
call setup_udp_tunnel_sock(), as it is expected to be invoked
only during setup.

Implement a new function named cleanup_udp_tunnel_sock(),
that reverts was what done during setup, and invoke it.

This new function takes care of reverting everything that
was done by setup_udp_tunnel_sock() (i.e. unsetting various
members and cleaning up the encap state in the kernel).

Note that cleanup_udp_tunnel_sock() takes 'struct sock'
as argument in preparation for a follow up patch, where
'struct ovpn' won't hold any reference to any 'struct socket'
any more, but rather to its 'struct sock' member only.

Moreover implement udpv6_encap_disable() in order to
allow udpv6_encap_needed_key to be decreased outside of
ipv6.ko (similarly to udp_encap_disable() for IPv4).

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c     |  5 +----
 include/net/udp.h          |  1 +
 include/net/udp_tunnel.h   |  1 +
 net/ipv4/udp_tunnel_core.c | 28 ++++++++++++++++++++++++++++
 net/ipv6/udp.c             |  6 ++++++
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index aef8c0406ec9..c8a81c4d6489 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -442,8 +442,5 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
-	struct udp_tunnel_sock_cfg cfg = { };
-
-	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
-			      &cfg);
+	cleanup_udp_tunnel_sock(ovpn_sock->sock->sk);
 }
diff --git a/include/net/udp.h b/include/net/udp.h
index a772510b2aa5..e3d7b8622f59 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -580,6 +580,7 @@ void udp_encap_disable(void);
 #if IS_ENABLED(CONFIG_IPV6)
 DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
 void udpv6_encap_enable(void);
+void udpv6_encap_disable(void);
 #endif
 
 static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 2df3b8344eb5..9d904c05ecf1 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -92,6 +92,7 @@ struct udp_tunnel_sock_cfg {
 /* Setup the given (UDP) sock to receive UDP encapsulated packets */
 void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 			   struct udp_tunnel_sock_cfg *sock_cfg);
+void cleanup_udp_tunnel_sock(struct sock *sk);
 
 /* -- List of parsable UDP tunnel types --
  *
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 2326548997d3..cf16b9088e24 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -98,6 +98,34 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
+void cleanup_udp_tunnel_sock(struct sock *sk)
+{
+	/* Re-enable multicast loopback */
+	inet_set_bit(MC_LOOP, sk);
+
+	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
+	inet_dec_convert_csum(sk);
+
+	rcu_assign_sk_user_data(sk, NULL);
+
+	udp_sk(sk)->encap_type = 0;
+	udp_sk(sk)->encap_rcv = NULL;
+	udp_sk(sk)->encap_err_rcv = NULL;
+	udp_sk(sk)->encap_err_lookup = NULL;
+	udp_sk(sk)->encap_destroy = NULL;
+	udp_sk(sk)->gro_receive = NULL;
+	udp_sk(sk)->gro_complete = NULL;
+
+	udp_clear_bit(ENCAP_ENABLED, sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (READ_ONCE(sk->sk_family) == PF_INET6)
+		udpv6_encap_disable();
+#endif
+	udp_encap_disable();
+	udp_tunnel_cleanup_gro(sk);
+}
+EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);
+
 void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
 			     unsigned short type)
 {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7317f8e053f1..2f40aa605c82 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -602,6 +602,12 @@ void udpv6_encap_enable(void)
 }
 EXPORT_SYMBOL(udpv6_encap_enable);
 
+void udpv6_encap_disable(void)
+{
+	static_branch_dec(&udpv6_encap_needed_key);
+}
+EXPORT_SYMBOL(udpv6_encap_disable);
+
 /* Handler for tunnels with arbitrary destination ports: no socket lookup, go
  * through error handlers in encapsulations looking for a match.
  */
-- 
2.49.0


