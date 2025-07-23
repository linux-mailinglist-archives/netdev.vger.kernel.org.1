Return-Path: <netdev+bounces-209502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDDB0FB9D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAD97BA505
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0223A9BE;
	Wed, 23 Jul 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQgnI6Jr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AA231836
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302907; cv=none; b=D2QamUjb7F/kLMSBHiaXuNn8SHA8QB33FaVrjYhWjyMZWe4g2n/m5ySK6I6WPhidjUWynIrDxQnYK0rqiSoRTMvs+f0Csb/gopOejhSSgFC0VGF4wON2gL7tSLmnjHuOE1Ce3PKL53MJvr2G3oP4SzJ3/OOIIR/1JwPi5U+sIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302907; c=relaxed/simple;
	bh=C3KXPVpCmTKkg0QY9a4HGG/s0ZM1liOjNpkToh07igg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acWPkaQ8JJaSMcAiFP6WSNIl7gO8EJZ5+WJTpRXgByhSd1i+gVx+Ky8EX9W9VUoWwy4rMlyO8hzFGUX7Rg8NGw6u1iS2VCOc36mmykvbWCMLlQOwnUqG/aWsc+7vsD3xXT1jgi7spyIs5busoRAEvJxr9QHg+UhedUejOwbLLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQgnI6Jr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e1d8c2dc2so3160257b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302905; x=1753907705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFrBYPD883IeocrjGKXkGixenHYheS6d41C+tGTnyw=;
        b=hQgnI6JrxQFKjfrkz7FNLvzDesxP9ip5VkeRg29aXRIBmuI/rPjADn3SiYCPjyeywq
         pK9ZWlhJ0xG5MpSPDlMHX+l4ZTFQ/eqbxVZmW/ot24nsexRaYEpN8c80vwq9Dy6Uqddj
         7Yp+7dUY1M6+FnkCODa4jRfuc/dMBW1LbQ/NoPI532eQuwryXG9ccXnQ0zuhBx++aWvv
         tz4hrZ/mwKjXgaX2N51gpM2q1IUbam8EsOD/yvFCFKsJ+V5Z7wpz5s2QOl2JPWW37UL2
         g7I8opLvbeqU/wYQrl1HdEY8bRzKBL1GdSb3Etifv30gzSO1y6j0e1kSBcosVNpcCbYZ
         UqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302905; x=1753907705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePFrBYPD883IeocrjGKXkGixenHYheS6d41C+tGTnyw=;
        b=KALiBlL8V3TLudO+IFGh/3h0q1bqNZoGvbLQHs7M/klV7kMrvZfTEP6CBLoriGxg02
         F8m78DGubHd4WisixTFjbjXaO/KyuxgnChWvpQPvHmBhO63LJEJj7gCfcVPRT4vKon6w
         Xex5ygZpacsQKqmQJLu6HlmOji5FXZ+o0qUaU+Dq8kRoaj/7iLzgHMmBmF+FLSZgocB1
         FXSiU+2F/v0ACJIm7BYtgqxYTg4RyONBWUl1kwjl0Gh06flNTF9fCTyy+CQYsuH4y+3X
         P0jE7ilUAcz5OTW/7QZynba8tTqzz1024d6GAGxn3bKy8RUGcV4t5p6D+N8bSzXLOW+8
         mH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtpslwV9vtOFNVgK6J/6dwLCRt5ovsioTQNoAfTQDiPWorxbowr2Az5n4W4Co8BCwPkIeVO3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKcOQRbEunI6rKPcLI3ORvoSLeiVwVVIWVgbIb+1wVgrZ8Ts2
	wpw7+XnoT/PNnK2buRMfLPPd8U0tYEi7Hk7k+oQXpZVZjOtSdH2E7QmF
X-Gm-Gg: ASbGncss4K4rq3yhvzwXMwbp/vMHSt9ucm+x7A7Xjcix6Eu1Dq5YILtrgf+RCRKbwDc
	sM+a3mBgK0P+aL4JUHwMEqNuOCuvCmeUc8od2PmqfQljDTC2vtz2Mvnab4Ue6SME9KgacdsBdOq
	sZcQpTIUsMId6Gg/5MDaMX7Yf8pmW2Fb40XhA/zGb/jlOHF9St8/MkeddC51U6CocgRYfuWT2Bs
	iGWKjnU3UvTYYX4zAG6Xr2bPrjnviAuP9PdZJrHnIOciXq4T4mEjr5TK5i5MFQMhYv+nejMydWW
	yDXrV8W9q8BCUHtJGyhbUbWbf6NZPwSF2YXK7NGNEsB+InQ8N7JGCiGLYCphFa9FU3VrZR2kMQd
	5U3kU4vHpJ5wxR/A6/Nk=
X-Google-Smtp-Source: AGHT+IEW7POiwYPAtow68RDx0JdejKC+wFyrxG6hpkAhITqws7YIgkjpVP3SyAKCOcR/BfH5YotLTA==
X-Received: by 2002:a05:690c:3685:b0:719:5ab6:83c2 with SMTP id 00721157ae682-719b4149711mr58623827b3.7.1753302904694;
        Wed, 23 Jul 2025 13:35:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7197516817fsm24007467b3.59.2025.07.23.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:04 -0700 (PDT)
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
Subject: [PATCH net-next v5 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 23 Jul 2025 13:34:18 -0700
Message-ID: <20250723203454.519540-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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
index d23a056ab4db..442b9f7db704 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3903,10 +3903,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
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


