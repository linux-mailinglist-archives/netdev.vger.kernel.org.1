Return-Path: <netdev+bounces-217911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA0B3A64A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE8C189CE19
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077932A3CA;
	Thu, 28 Aug 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqKdU6f6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D532A3C1
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398605; cv=none; b=nrCYpMS838wk9CAGPSgOLH+1222cyKtvXJ7Sz5GJLJ4xuH6KczofKu59ci/piCX/s0xzo/jBL8z5o0gT1sPJf9o1lUXZtbQNbni8Cg9QnhB0iRDSnJ0GDhjlNkPi6jmn0ejI9TZkldddf5fcbV4iFNqb1/7zEaGGehite87S+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398605; c=relaxed/simple;
	bh=NvY+dT2MGf95niCqUulbPKNVPK08e3ssrV9rRCBMpdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEUpBx39gylsaIwqkblSXagTrHXisg3cV9ju2Py0/oNs4xTvrgBFHHhWh0dKn5Za6MATPx05FjbxtLc6ZeWmUX7F7KX6B2LylwItsySU3YQ0OpPRK9FQHZWcsfmiBvB7iUrUbRhmuWJHV5qvbNzehC6P03wEzcSw6jxE8XswnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqKdU6f6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6059f490so9696047b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398603; x=1757003403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbz8f9ZWzbkdEdCm4i5LXlB7RxvfGAaTEfsZ8w3tgnM=;
        b=gqKdU6f6Dxy0syvaJ39BkdiXEkIO0OGbhXzeGjWgZNWaY9ubadK58YD9afac0vopUi
         WdKwtXmJWLSQY+8KcBuBvMJpvhNzUuD6RUsDF4zFbTgreh8l290RKcLT+PQc4JOJrcEg
         EV3JYfDXrPRcA/P1CNmjTIMMy18l1d0xGhOM1moHlwPHQM537KBl/yB5R2hqZc1lzGUY
         FmADGoV4KbwwpbJrZCN9BCq9tOrU5M5HYyEw+PAyXiLzsYD4X4t8ZKLw0xtusdaxqRfh
         hTrNgyMJuaXVB6812H+yxsk3UoumHqu4GeFbs/8iBBB4+ew8+AlTJexVQU0AwVFNK4iU
         p6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398603; x=1757003403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbz8f9ZWzbkdEdCm4i5LXlB7RxvfGAaTEfsZ8w3tgnM=;
        b=ZdA8xn1rk6hv/2P9MxFAUskqxyV+1MR/LqqNs8jPajHeb9CT+UsPXZn4nK1nnE9Uy7
         jPU0H7pwFz31jYgRdl5M15AS26t4FdGcf3TA+XcX8d4EgR2a2Jdrbj4bqT3JKOYIBCde
         vB1xcNRUy7u/8xRGfnWWATK54Bg4M3EquBGCock1xGX5dMun14KkGp2ZWqbqBcCltqi0
         rr4k3keycYUSKhZta0p7JdIw3CZu74iH0Cc2fZykvtkZKMeJh0L0INKhJlouPwrr1IZG
         jXWmK7awrT3QzhpfJzbdk8Ga5MHDj61mzO75i+b+3okdHYljDR/pwFzE8wYZP3e6mZ0y
         GytQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEbF1USr9ntm97C2Zi9S9HpLfYpEc9d0ffsSB6pRC271Phv+2E2jxWD38p3bcVtq37s+hQYkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHDyj7KjqeVylhUGg9u7XdWAXeLtzBYHEQL5QAsWNBW5FqEru
	l+0FkvZfaPRIp5dRnXNSykdIASbLiKzBKV3OwEBlAaS8PArJ1yrlJhX1
X-Gm-Gg: ASbGncuj+g67N2F0OwTQ7qTtVQ+FSF5IUlCayc8DyQh2VhV/FafTaSi06XFpGQgmPH0
	W0VnC8zklitBufz8vsso8i5ykpRMpt4TLWA3oT2ZePNrchp8p19jlvIctFNpyuup8sDNiLFJ10a
	k9Wbw9czLgUT4BKU+PwvR7PTw2u/51ALBwuBXIBfUCYoHxVpBGAcloUz9Fsn52cUZ2vhbbb4SGf
	ZVBl1crxKJ8KUDIWIffx4Z7P7goCw0UlIO5LsThcgbiBEJUFk5aZoYC9vRLdJHv0XqZLKAnfAgV
	n+8wp2//lcIgxc+Jq3ueiHrghYfWVyWeVhq/6FB5nm1qAOrL7dK3IesX+d+rwC56PugB29AC3aG
	5bLvv2uVq+XT8u5GTNdAdYx6/dzVKMEU=
X-Google-Smtp-Source: AGHT+IFkuVZJUEuNVqzqfwPZr6grEa4qWeRRJfhhpq7H1eBQv4rIAefoBdLyHSxeOsaCYYRq0oK/xQ==
X-Received: by 2002:a05:690c:d0e:b0:721:3bd0:d5b4 with SMTP id 00721157ae682-7213bd0d6bemr112173407b3.33.1756398602519;
        Thu, 28 Aug 2025 09:30:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721ce4947edsm401127b3.44.2025.08.28.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:02 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Thu, 28 Aug 2025 09:29:33 -0700
Message-ID: <20250828162953.2707727-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a callback to validate skb's originating from tcp timewait
socks before passing to the device layer. Full socks have a
sk_validate_xmit_skb member for checking that a device is capable of
performing offloads required for transmitting an skb. With psp, tcp
timewait socks will inherit the crypto state from their corresponding
full socks. Any ACKs or RSTs that originate from a tcp timewait sock
carrying psp state should be psp encapsulated.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - check for sk_is_inet() before casting to inet_twsk()
    v2:
    - patch introduced in v2

 include/net/inet_timewait_sock.h |  5 +++++
 net/core/dev.c                   | 14 ++++++++++++--
 net/ipv4/inet_timewait_sock.c    |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index c1295246216c..3a31c74c9e15 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -84,6 +84,11 @@ struct inet_timewait_sock {
 #if IS_ENABLED(CONFIG_INET_PSP)
 	struct psp_assoc __rcu	  *psp_assoc;
 #endif
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff*		(*tw_validate_xmit_skb)(struct sock *sk,
+							struct net_device *dev,
+							struct sk_buff *skb);
+#endif
 };
 #define tw_tclass tw_tos
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 3be07bc77cca..ee47ad2bf141 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3915,10 +3915,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 					    struct net_device *dev)
 {
 #ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff *(*sk_validate)(struct sock *sk, struct net_device *dev,
+				       struct sk_buff *skb);
 	struct sock *sk = skb->sk;
 
-	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
-		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
+	sk_validate = NULL;
+	if (sk) {
+		if (sk_fullsock(sk))
+			sk_validate = sk->sk_validate_xmit_skb;
+		else if (sk_is_inet(sk) && sk->sk_state == TCP_TIME_WAIT)
+			sk_validate = inet_twsk(sk)->tw_validate_xmit_skb;
+	}
+
+	if (sk_validate) {
+		skb = sk_validate(sk, dev, skb);
 	} else if (unlikely(skb_is_decrypted(skb))) {
 		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
 		kfree_skb(skb);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 1f83f333b8ac..2ca2912f61f4 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -212,6 +212,9 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
 		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+		tw->tw_validate_xmit_skb = NULL;
+#endif
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
-- 
2.47.3


