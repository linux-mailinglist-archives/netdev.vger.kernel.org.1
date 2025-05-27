Return-Path: <netdev+bounces-193662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEE4AC503F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A4F17680B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4137327602A;
	Tue, 27 May 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZTKYjRTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC9275106
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353977; cv=none; b=sD8tuuoe4szCplKXEsjL31JrE/hadmiWu/s8puCCZBnSSa12r8jl5QmDF/+iVZE5UGVfRxF6jCWjBAHKjY/G1etSnCp1cs8wrf91AXD1NpLl+3TsavsYpdBpnTXoxmbyJ4CAD4npKAQ2A9Y+YvOXigX5L4DI//y5lhTCGMk9tGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353977; c=relaxed/simple;
	bh=3s9jJ6rZbBTpWkmQiAH0AnE8NKwypkhI+HpNdyKCqf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqEvcc/za8LYl/HHDhf80X2Cx4GgHdbBuNdI4GVLj4+uWXV5mjN+79SkSmH3/yFaqQ2Lwdn1lKKv4tm7pSbS9Oz3RNK32lw3rDw5gFNDaiVV0I/o5w36J6mOz0AkZ+OxXetm8s7K7E2dMM+dYYy4+Tycy/hI38GP6kuBrSPBJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZTKYjRTW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0ac853894so3600522f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748353972; x=1748958772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxDfQlBY8t6apo8SZCb8XpPq/cBb8IZ0TgtYfjEXSxc=;
        b=ZTKYjRTWKy0dZzXGpS/WYxnFE4u/52vADlC9/Jk7y5L0MMN5Wej9n/IPqNovvb1cAL
         z//dqWJ85qh2fx9d9WyYkaf/0QoxKSARxSB/mCK4KESfQzzHtEZqTejXZR8SMzdnv7bv
         KvZ546/9oNEkjEYgr3Cvqd4aDj58WZcwWryI4VdW76kBvMWqBbiR4I754LNabz3O0agF
         Ib49SC2YMu6h0h6di4P4zOQfdsj9PE+gQky9XleECYwjpNzpZ8YBhnrs6pEkRSdrH7hL
         Y11+Wr/lrLvW4FzWSVp5z0rMPsxL6LfckRgdefInkYrWASiY5RfCiFmpxsRrWWuuH/Lv
         r53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353972; x=1748958772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxDfQlBY8t6apo8SZCb8XpPq/cBb8IZ0TgtYfjEXSxc=;
        b=nwuYJVhi4JbguZDK6cYxhlk3mKTw3k4GLrHuxuqnmSnoCD1A1zeNRVXWs7CffV1zYA
         Vs6i2xPsFtkxdMI7ag4Rmj3NDyOlKa8VKAPSsjLKI5qCr7jTxW9H0DEPFKneCgHEJJgd
         pZvbQkv13hal+Znm33JEt9J3IYn1aKwyW+ShODmajHCQ0VYxAURC8GB2CbH1lZFWP7bJ
         Yidk6DzdjldrevG1b67UbEJTRdBV/Ox62hsXkW1aJRec4LuSMO0YJDTPCW2cN5VRFlEf
         NJTGo7GTOqzqXo8kH+bsb4B7dYP2VH1acaPr2zWLGmpeXBEzwaD6Mb6LffiHBY2XGOg4
         VaUg==
X-Gm-Message-State: AOJu0Yyequ11K5FhB7FgC1qqsQa3DH13OTSe14GZfbXZb4TcGm691YzZ
	PDm+vHRi7dt/z0DOvKCyYRyfcfb0I2+sz3pZOvFqR2fKqsBKSZJeVE2O8TGjiwu+IyP5HScFcPT
	j/nCYA7nGTuuYz6j5mlX6dX9kQKYXSVOK8+rHBjOTP2PEjRIySM1Y3VIQiQIREe5I
X-Gm-Gg: ASbGncvWW0vmQqDSaaztTUh54Zc4X/aG3A3DVYMmZ7HygIuO6z6QROstvsPJma3T8wy
	W1usJN786NC+tIi2L3g4rTFxfAdh2Y9Ey9JLbD2P4e6Yw/ZoU0TjwOde9lmPIlvDf9dipXGKAVg
	wlgf77fUj4auqkeFFDoDnBnxjquOmR5aEQ2qDT38vRNLlsRkZ5JVeO+vC/YqzQwdXkocUy62xM7
	pVeBQKOZOMxeC2lHBLlg9lAx3NpESZTn3hEaxi9iTI4ssPgqEiv4WExzv8BMlZ0Oi7fSesWuUJ6
	EeNjxhGiU4RXX5iWwya/HvhWFj4okRfgbRC1g/jXITicrptSNAyMgbQpFJoS9x7ozcUK2K3F76I
	=
X-Google-Smtp-Source: AGHT+IFAsZqMbJLD++vyy7RuU0q/s7XFQVaeI3i+6Dn+eeiu/GyH+WFsBDnNfeRPLuSlF8iJ7I+gBg==
X-Received: by 2002:a5d:588f:0:b0:3a4:e001:e24f with SMTP id ffacd0b85a97d-3a4e001e2ffmr3263623f8f.28.1748353972490;
        Tue, 27 May 2025 06:52:52 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5803:da07:1aab:70cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db284261sm5387719f8f.67.2025.05.27.06.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:52:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH net-next 1/4] ovpn: properly deconfigure UDP-tunnel
Date: Tue, 27 May 2025 15:46:17 +0200
Message-ID: <20250527134625.15216-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527134625.15216-1-antonio@openvpn.net>
References: <20250527134625.15216-1-antonio@openvpn.net>
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

To properly implement cleanup_udp_tunnel_sock(), two extra
items were required:

1) implement udpv6_encap_disable() in order to
allow udpv6_encap_needed_key to be decreased outside of
ipv6.ko (similarly to udp_encap_disable() for IPv4).

2) avoid race conditions with udp_destroy_socket() by
atomically testing-and-clearing the ENCAP_ENABLED bit
on the socket before decreasing udp_encap_needed_key.
This way we prevent accidental double decreses.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c     |  5 +----
 include/linux/udp.h        |  2 ++
 include/net/ipv6_stubs.h   |  1 +
 include/net/udp.h          |  1 +
 include/net/udp_tunnel.h   | 13 +++++++++++++
 net/ipv4/udp.c             |  2 +-
 net/ipv4/udp_tunnel_core.c | 22 ++++++++++++++++++++++
 net/ipv6/af_inet6.c        |  1 +
 net/ipv6/udp.c             |  8 +++++++-
 9 files changed, 49 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 4e1a672af4c5..97151f25953d 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -116,6 +116,8 @@ struct udp_sock {
 	set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_test_and_set_bit(nr, sk)		\
 	test_and_set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_test_and_clear_bit(nr, sk)		\
+	test_and_clear_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_clear_bit(nr, sk)			\
 	clear_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_assign_bit(nr, sk, val)		\
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 8a3465c8c2c5..2a57df87d11b 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -55,6 +55,7 @@ struct ipv6_stub {
 			       struct nl_info *info);
 
 	void (*udpv6_encap_enable)(void);
+	void (*udpv6_encap_disable)(void);
 	void (*ndisc_send_na)(struct net_device *dev, const struct in6_addr *daddr,
 			      const struct in6_addr *solicited_addr,
 			      bool router, bool solicited, bool override, bool inc_opt);
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
index 2df3b8344eb5..a14b171e7dd5 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -92,6 +92,7 @@ struct udp_tunnel_sock_cfg {
 /* Setup the given (UDP) sock to receive UDP encapsulated packets */
 void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 			   struct udp_tunnel_sock_cfg *sock_cfg);
+void cleanup_udp_tunnel_sock(struct sock *sk);
 
 /* -- List of parsable UDP tunnel types --
  *
@@ -218,6 +219,18 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 	udp_encap_enable();
 }
 
+static inline void udp_tunnel_encap_disable(struct sock *sk)
+{
+	if (!udp_test_and_clear_bit(ENCAP_ENABLED, sk))
+		return;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (READ_ONCE(sk->sk_family) == PF_INET6)
+		ipv6_stub->udpv6_encap_disable();
+#endif
+	udp_encap_disable();
+}
+
 #define UDP_TUNNEL_NIC_MAX_TABLES	4
 
 enum udp_tunnel_nic_info_flags {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dde52b8050b8..9ffc4e0b1644 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2900,7 +2900,7 @@ void udp_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (udp_test_bit(ENCAP_ENABLED, sk)) {
+		if (udp_test_and_clear_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udp_encap_needed_key);
 			udp_tunnel_cleanup_gro(sk);
 		}
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 2326548997d3..624b6afcf812 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -98,6 +98,28 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
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
+	udp_sk(sk)->encap_type = 0;
+	udp_sk(sk)->encap_rcv = NULL;
+	udp_sk(sk)->encap_err_rcv = NULL;
+	udp_sk(sk)->encap_err_lookup = NULL;
+	udp_sk(sk)->encap_destroy = NULL;
+	udp_sk(sk)->gro_receive = NULL;
+	udp_sk(sk)->gro_complete = NULL;
+
+	rcu_assign_sk_user_data(sk, NULL);
+	udp_tunnel_encap_disable(sk);
+	udp_tunnel_cleanup_gro(sk);
+}
+EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);
+
 void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
 			     unsigned short type)
 {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index acaff1296783..f3745705a811 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1049,6 +1049,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.fib6_rt_update	   = fib6_rt_update,
 	.ip6_del_rt	   = ip6_del_rt,
 	.udpv6_encap_enable = udpv6_encap_enable,
+	.udpv6_encap_disable = udpv6_encap_disable,
 	.ndisc_send_na = ndisc_send_na,
 #if IS_ENABLED(CONFIG_XFRM)
 	.xfrm6_local_rxpmtu = xfrm6_local_rxpmtu,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7317f8e053f1..a919458772d6 100644
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
@@ -1823,7 +1829,7 @@ void udpv6_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (udp_test_bit(ENCAP_ENABLED, sk)) {
+		if (udp_test_and_clear_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udpv6_encap_needed_key);
 			udp_encap_disable();
 			udp_tunnel_cleanup_gro(sk);
-- 
2.49.0


