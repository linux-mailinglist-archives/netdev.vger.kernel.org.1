Return-Path: <netdev+bounces-207491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDDB07879
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075F01C2276F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA209288CAF;
	Wed, 16 Jul 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXw3E/uJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16E28A1C8
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677166; cv=none; b=RIobyafZ/LY++RivngDmCzuQOLbZI+dKYLae4xM+88mpcRyFV/FT0RJsBogAoQYh9p11ltXCBn1EWJfSzvjYOAt1JrVoGmhbGtKfPipjMO2kOEeGGAzU3zUALQF1VxZpKrLfHl1Zxn10IV0C8CYA6qI4xUjwgd4sczWvz7ZZOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677166; c=relaxed/simple;
	bh=OGZJYl8kTB/RTRiXRlYXR73CKxNcSjUQDzYkqX9zVAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR1AlE/ARPuWq2/w03l4ivgRS4KfSmTwiIXUScAFk/Mo1fAdRMvACMd3pzbfSP7+IwhrWdEE9v74/AIyJLvrW4D2/LQxD3QPen4Ye+2FuG7npVTfDMAdV80wRWd+wqfdVFMBame7Vf0jt+vW/fjpTm1JZ6VuEpVxzJvS7M5yZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXw3E/uJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8bc13221eeso1114423276.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677164; x=1753281964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTGtALCGp9qFP02HOa6jjhQeJsdzsAU5x6C55KtBS00=;
        b=gXw3E/uJBx85xXgktQZhrgZRb/LK2PaqQl8US9sAEDe8wEkNlPYwBccdm680DaYzUb
         Df6rXkQ6um5ma3Hm5WJ8OJPe6lQpUQ5pSSsns6YvfHFNPvwJ2+AqaLnDWCKnC/uj04BQ
         BrfbDvcR1oZwa/YRzIv0NG52qommHv4PepGM27rylXyJHtuTM2hYjovy/nGSgiWsQjtB
         mgwC66qqnEc+1VvuSYF2vyVcQYuoMM4WBR4Pd9C0V6fFRLgerNtjeVl/wx4U5cQRMVGI
         vxEqynw2htcDyD4H2ln3kQXgflwfK+tyJu67qNbMdu3NjoXQZ0Dx3kjWjiCkT59XIwfY
         xk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677164; x=1753281964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTGtALCGp9qFP02HOa6jjhQeJsdzsAU5x6C55KtBS00=;
        b=rfaMa4zj27Q5XGKzTmL+rQf9I6eWvdXk50q9agc/UGy3L4MmOd2jclLlvVh+cBvTXR
         l7ExRiZmrypUcY9BNtq8OszjM5t1eqvFKxKT9u2xHC7K+58+RKoUR0WMLaPMI8mFkZh4
         vmONHo9BJxLHqJmLgpSRd5KvTHnuZmKx7Ia+lN9u9rgkuosORDvTMUpP1mIakRJR1jL3
         MRqO3alflnyMZSbU8FmB9iwsBoY4wJbFeMshxTAcuXU76kAzKBPqI2zme0/0HjAw7Y3r
         0I1EEl5AQaCt2yOEwdQ6gKSz6etJqtLfzbjonaZs1TViAPFx+D5UrDAaKTlFKLKNz4Oc
         TESw==
X-Forwarded-Encrypted: i=1; AJvYcCXlOxYD0LdRXc8XKDCsAnOKuj/SZP54uFI/1DqU7zAzOwRoGjN83yFFQT8fS2j4AExlw5DvH70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTq9h94mFRAvGaahwcE+DaKmpqR2HsqOh89EYXt7y5yqVyyCD
	OcTBQlmcI1dSsrlrJkWp3lE+gaYloxKZTkNbLLPfAvtXXOWyhsaXM/aR
X-Gm-Gg: ASbGncuX2koAvdaQV2Uh+Q7jm82n+18qRXtU3UdRaUSdyF1mw2qbXRgL2BNJShkSapk
	yIpB8eo4xzAs3TCYyg+Q1rAtDf0lwtBbnLrkJG/Hreo4807iBz+PFgrqDH0t8uz480WYujqY5dd
	KyrmwBPsqC0vQyTtH8PobLJrvF+PO/XlKmmjUu6wpcT8X0Ohc15aLeOs0AlVU+iXUa0OVIvp8Px
	9NMkZ+kcOdVwfr19MToEilsrcZ/xawN2cc2ONQLphWJjaQ48ji2yvXGYivbDXT7Eim6ynusr/I6
	WWkq0eCpeId6ldMho8PJ7TMu4ItkAYzP7YUbP58/ClBoxW2kDSxlvmDr0XiC5VbO7RcZpMElge+
	HqCWxsirdXllCsB2Fr5X2
X-Google-Smtp-Source: AGHT+IGA1hMeosFrNVM9Z9L6nxj5hyHW1ESFl7fhlDDBBodJzHevYpxDB+ikSL9p/8Jfi2GKr3wvhg==
X-Received: by 2002:a05:6902:4504:b0:e84:1dd0:45a2 with SMTP id 3f1490d57ef6-e8bc1d84689mr2753841276.40.1752677163991;
        Wed, 16 Jul 2025 07:46:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8bcc43c00esm283585276.51.2025.07.16.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:03 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 16 Jul 2025 07:45:28 -0700
Message-ID: <20250716144551.3646755-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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
index b825b3f5b7db..4eddea8dcb82 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3904,10 +3904,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
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
index 88b5faa656b4..93c369cdf979 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -210,6 +210,9 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
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
2.47.1


