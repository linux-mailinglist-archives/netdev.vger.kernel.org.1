Return-Path: <netdev+bounces-192699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB935AC0D9F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6AB17882A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE8828D8D0;
	Thu, 22 May 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="S4TMiY+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3028C2B9
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922821; cv=none; b=hPOjiMlPDQKedP7OKRtA98s+E/9W/S2hrn+CqeAzKrZKy1RxulJAcrh6XbWyw7988dgPsGKdZDIEHRP5v6Jpl7109CgOaXDW66IqAO8LnAxIjZTD+5sV1mAuk71t1KTFk/UYIN8n0Lq9FNlnv6KuPLxsL4618DZ5bZKrFGrwftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922821; c=relaxed/simple;
	bh=hVi7YrhitZZEw4GT+M5SougYX/G7OjYPwjLH874lYTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/Nl72cmgy6QUAwauOrL15elftIQOnThzhXWhUOPf4SWMx2r5LdfhPn5S01svigwih9aKlyDitEpZK9XMMrTByiRmrE5+HtPDVYncQLdkhy2EeOO2YIO9S2UbW6CweaVJzAnWyQn8/Rfu5IjbIwAfvz4EdAOWelxEO8nHVrfZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=S4TMiY+P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so100858285e9.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747922817; x=1748527617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXcOQ+47YJcITYlowTQN2pCemY8N7dWJC6eQojGrsk8=;
        b=S4TMiY+PiwGICYcTUy/euiAIikutDxO/iI1LbgucVax1CjF4n9KhR2bcxb/LplzBia
         FUIJcpaw8uCnjSl196BnOqUKRgZegllHI8bYBQaFExu2r2FN9Gvfw7nVXlwuqEENEp+Q
         Uxj1oOIeOsExoDOIsXIOaiqBIkojVbFqNnqwqKGrTWgkR2oInTD811UYFsUfsKQkIHYk
         Lyt2Nu4AP3zUHQY8uN2RWAA7c5YgyBJpg2f2EMTc4zmntPrqRR5ef7XMBqdKpXy9774D
         R0EHMe6PT6mVMiVyNCnk82N5RmbGTBxk7c+VI0Szr0fGwkQyu4QTV+U7Xg0SAs5oJIEW
         wa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922817; x=1748527617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXcOQ+47YJcITYlowTQN2pCemY8N7dWJC6eQojGrsk8=;
        b=ZygRGbx1TdJq+5JMTHYdSF/wRK2gxBvp/slJSLWKP4ar2RM7hsFpY0QyMy/e8lTCjB
         IEeEndh3UJeWFn2Fh0+/Qp4umCbQqcfq7M4HgPclRvfAgLqFexlny7NaUuxdreKooj4G
         I8d61UVARXvfObbkczRu4Ctfqhdm+fqmCX2l0U1kjs5dJxq9Vkudyy2h9fyGbz3qMfOZ
         vZASBvcVWzzivOl70tFYmCQTErhouLwDkt0oSe+UVjUJS4MYWljKg2l0UBNH7P20MbJH
         feLOPMcpnbqE3PEMHNI9etopUdIckpzDhnwIYP86DRczbnnksX0r2YkSBqA5wLc0/ium
         23rQ==
X-Gm-Message-State: AOJu0Yz5kFFXeuwsm0KCz/+Wsjwde9xjL99dkhWHyVbDacL31MewRRhQ
	L3PnP6PeaJ+PLGrFBv917pm1wmmwMacQ3avi8KH2YQ9+ut8HtR84Kuw03L016h9hdiijHGPC6k6
	DNTW3wUc1K/AS6acbEF59vBCM76/L0l2GTY4odeeCVUmVUz278CEp6oB+sscGWx7T
X-Gm-Gg: ASbGncuqoFf2S5RIBufl+IebDLRMuDaMjAOXO5h42J599PRn/2XmflzMp5pnBVQEYx9
	8rRb3gTBL+LeXbsjph2/n8JciqvW3CcA+QU8dB5f8MeOrmnbFkh9Dl8QPx9qMCzL2CmqGRKmVPk
	RBXnERjgEXcRmGMn9FprBniTt29FX4MN9d7GNmfQc5ty7q6Z3Vp6clg8thoBzQVr+JKiltiStxF
	JhK1v51hjeHCqdE340KjKVergmwKH7fo36vYWsuGl4mjgrnk0PY4lg7MsN1Z4Rd2AeVgLbxkGkF
	zh4ms5HgfP7Lg2u52texCWGphOxfBqCfKRCqKxBNOEdaq5+GyIEKaJv2xUalTfZRupsW1rcfzvE
	=
X-Google-Smtp-Source: AGHT+IE4jJN4Damb8trDRL2IfskXSviiGGQlWaXPkD+LHowI0DgBjF4vfmtpcsZZpSS6vIPGF9qcPA==
X-Received: by 2002:a05:600c:348f:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-442fd672537mr248642295e9.30.1747922816531;
        Thu, 22 May 2025 07:06:56 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:3ef2:f0df:bea2:574b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b1bsm23671269f8f.53.2025.05.22.07.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:06:56 -0700 (PDT)
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
Subject: [PATCH net-next 1/4] ovpn: properly deconfigure UDP-tunnel
Date: Thu, 22 May 2025 16:06:10 +0200
Message-ID: <20250522140613.877-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522140613.877-1-antonio@openvpn.net>
References: <20250522140613.877-1-antonio@openvpn.net>
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
 include/net/ipv6_stubs.h   |  1 +
 include/net/udp.h          |  1 +
 include/net/udp_tunnel.h   | 13 +++++++++++++
 net/ipv4/udp_tunnel_core.c | 22 ++++++++++++++++++++++
 net/ipv6/af_inet6.c        |  1 +
 net/ipv6/udp.c             |  6 ++++++
 7 files changed, 45 insertions(+), 4 deletions(-)

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
index 2df3b8344eb5..843e7c11e5ee 100644
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
+	if (udp_test_and_set_bit(ENCAP_ENABLED, sk))
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


