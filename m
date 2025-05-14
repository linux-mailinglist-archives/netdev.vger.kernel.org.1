Return-Path: <netdev+bounces-190369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A2AB6840
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD3C1729C2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA425DCF9;
	Wed, 14 May 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="USBFc40B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B03221281
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216732; cv=none; b=gpjfDnHDBKqWsIMa8juIzzJ8MdUPq/aBOVTcjNd1ccmJTl0BBvPHUVGk2JcMtcy2hqEjONaoFc1Gup2cRXk7/bUtOGzl6q7jE5hABk4wxIStp3wGzJqs7s0epX2diKfPcjda0lqfrCiqGLNDoM+OdtqHOXygVMIag8M5cUS5x9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216732; c=relaxed/simple;
	bh=8qiT8jy78abjl8rj3hxK+czQk2/LUs1GwndPye3+riU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0FhNEu336L/o3cEeHR2R6jJklGx7Id+Kt1Awkl5IqJphNqqtVB40OxPtd05xQPRkdQ/vRDF/G7GVvQv++7up1z05KcXql83rbCbnN0r7YDQV4fraP4OtJ8BbivjuROR4iHGZZU8D1o27uDhH2DnHi+2kuJQXh+NYHPcqX3TdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=USBFc40B; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso67450195e9.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747216727; x=1747821527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQT844XJMbJ4xzoOQTTzjtoLc5LUDk5H23w4/waIHGw=;
        b=USBFc40BQAxFWCqmvdE9yN8ZnWfqA6RqtHDb103S8tmfwSuahWXdCi9ENU2t+X0EV0
         k6DWv9qYPbKBoiwwlQeucGx98oEyM/BcKC1eO/OkkL2lfCZIu4u5B6SKvyG1EcfFDsVY
         gKK8bf0PVZMybETX1EgTQI6NHld0Oozv5q4HAP3xj1UI0+6baCT0DQPh26Un2uV6t9gx
         tETTJND7hDYKDpoIS3ngPAHPIf5Ga7+qFWHK8VrpOP7cKwbSYI6Tc/dGObyiTlQXl1Cp
         A/Ev+a2zKWck0v4y7QCXd0M88JkfFq7xR8n55zjT+ag2NenHK8VbWCCuMKTjnxcqcffP
         dZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747216727; x=1747821527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQT844XJMbJ4xzoOQTTzjtoLc5LUDk5H23w4/waIHGw=;
        b=wGnpGMc16EIBRbpIqKOUuWFgnMj4huMca1nhIX+q/u9OO70IzYUa2di6zkA1niuOgy
         WZa2CYlRx+yTR0Q7klyOSMnejQocqaVT5sy+5TZVLs35go/xy9XaQ29CgRJbUNgiUw4n
         yyMQ9bIVAhP9lAErxNKo6YL4Ufk3suk6ONmy4zlxiAeZYALtzuF+FNNj+Vf6ESd0LNxJ
         giNsd0f9yTHkhYS8lCY0vR/8f8fgjpojrtNdwG8TiYxeOUVLWJkkXmxD6kkYWUx5HQaL
         GYGIGXRE9WqPJm5B/K/IbA4wmUj3jTddyaqZnvVuW46ejw4vWJOe8Dk1rZ8qplSNE8bu
         YfDQ==
X-Gm-Message-State: AOJu0YytGxjQfgvnNZqUCDpbqOzJX5VIBXVQq2WyNLsKD65p+tle1LGo
	M2ZLotwttYHCI6Ff8ReaPyYdpms5bKKeU5TWTEL78u+b+T+kovfjXFO/cFW0YCowCwaLARJRTJq
	c+fek1sMVskl7wAT+zBdQQbwvnz+Yuqb1AdQYBR6xk+JiOnqHCWDTLMn2E1PO
X-Gm-Gg: ASbGnctLQnvV1MLUzRlNJpNpZNSsQ0HFutwFjnYFA7VF2EtUNCiKwU87dXpGN1aJUfp
	ftX60xRjTzh3pUIHBE019X/Xjq69K9YwE7jzgXVEGYKSvfpeZYhfm/8IqKyNdSs2GnNVwF9AWWd
	0dTMpCfpKEQ16lwmpJ0yCdRdI9gEJ+dn1M7GuBmxnGSQGkh2n+a+eo8WqOcTMt9SdZLg2FWBpw5
	LZ4tkjXZOmU6bNMNSRNOF8yNwrm6uRUDMH6xUOCgOUZvvN3EUyfrZSTX6pns8xDs0aUbK+tqLnC
	mTri69V2i7m+uMSObCRS4hUhXyqUF+KI4Jdkex/9pyOnG0EWUWYHU7+dE/B3aV7ccFaVzUZXl5k
	=
X-Google-Smtp-Source: AGHT+IHT8q2UcFqLrUlDv5Ku9EB+5ht3ejnxV9TN7rJBKGVbgWzhwyrB/70h8B5kXsp0nkMb+Vh8Bw==
X-Received: by 2002:a05:600c:3b85:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-442f2178431mr21029255e9.27.1747216727339;
        Wed, 14 May 2025 02:58:47 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:885b:396d:f436:2d38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db24sm22323045e9.15.2025.05.14.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 02:58:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
Date: Wed, 14 May 2025 11:58:42 +0200
Message-ID: <20250514095842.12067-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
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
sk members and cleaning up the encap state in the kernel).

Cc: David Ahern <dsahern@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

@Jakub: I am sending this directly to net-next as it'd be better reviewed
by the broader audience on netdev right away.

@Paolo: I think this is the best way to handle the UDP tunnel cleanup.
Doing nothing is not truly an option because we leave all the encap
state enabled and this may lead to other issues.
cleanup_udp_tunnel_sock() will just undo anything that
setup_udp_tunnel_sock() had done during setup.

 drivers/net/ovpn/udp.c     |  5 +----
 include/net/udp_tunnel.h   |  1 +
 net/ipv4/udp_tunnel_core.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index aef8c0406ec9..137b58d49569 100644
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
+	cleanup_udp_tunnel_sock(ovpn_sock->sock);
 }
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 2df3b8344eb5..387445133eb7 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -92,6 +92,7 @@ struct udp_tunnel_sock_cfg {
 /* Setup the given (UDP) sock to receive UDP encapsulated packets */
 void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 			   struct udp_tunnel_sock_cfg *sock_cfg);
+void cleanup_udp_tunnel_sock(struct socket *sock);
 
 /* -- List of parsable UDP tunnel types --
  *
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 2326548997d3..83e9fd2d499e 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -98,6 +98,36 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
+void cleanup_udp_tunnel_sock(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
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
+		static_branch_dec(&udpv6_encap_needed_key);
+#endif
+	udp_encap_disable();
+	udp_tunnel_cleanup_gro(sk);
+}
+EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);
+
 void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
 			     unsigned short type)
 {
-- 
2.49.0


