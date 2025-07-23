Return-Path: <netdev+bounces-209522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945FB0FBAB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75481CC30BC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9517244662;
	Wed, 23 Jul 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmdPDNcw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE6242D8C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302929; cv=none; b=ptZrwgVA7Kwm5TQB8JUsBfwXVmRFg2/uAmdyRrujgLW8q3Yf4gdumc2J6Z3hpqZfS2E8cQhaB5SMbUX0uXBT97bfyxrGFjObTI2xSxvC9Dy1OfvuXeENpaRsi232XObew54bo5+vChYpT386/n2YTDo4ts/OZq0Ji9PejuGuRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302929; c=relaxed/simple;
	bh=C3KXPVpCmTKkg0QY9a4HGG/s0ZM1liOjNpkToh07igg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv3N8CfdGPtdGVAG4kyOgPPTcBwOwAmURwBvFkMGUSu7zNML5tisW8Er8QcFi/MdOgIgPwJZaavzs9hg00BNmyk6o1AqzxZ7PdJdGhYFAee+3JIynyg2fyZrU6NX0DmdwY1z8V1cJ5hQVycXuzo33YV21MNwHGbEeqx4Hak9+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmdPDNcw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-719a4206caeso3926097b3.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302927; x=1753907727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFrBYPD883IeocrjGKXkGixenHYheS6d41C+tGTnyw=;
        b=MmdPDNcwmey6AsYbHMAvyiSwcGPjaAAOyDWu61wOmrsJ8IyHvEluzoO7uohMzu38QC
         a3jM9Rg8ru+FLqEyejMIGnG8yFHBRxCDyZQh/8LzGfAcdZlpVl1Ily+MOZn1taWytjJ7
         3uN1xdTOV6278t+RZm7NOD+tStk4Hi4zJOXOrjMBBTomc2nGSfjlaW/9VZVLpSzSJ8bF
         5wXiGoUGUg5DhRNtyiTylXhCjhQ/KZgdIFFCRzHaW1wGri1b3SHwuqblA8Z2dLeVsfQO
         +Bl24QekDlWzRtNEPgE1/Nmm2Ntii8p5trP0PKtWIv+jFzF/Lgoc5/B4VyrbOYYOwclJ
         1Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302927; x=1753907727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePFrBYPD883IeocrjGKXkGixenHYheS6d41C+tGTnyw=;
        b=X8JT6RstvQ66s9UxGoJsyDm5/U+k/5fGjvWQqmf3Q2i0ds7kIVhlZoOFd9GGxHhMy1
         6Scd2V3JccdyJAe2J4MxVz2XpEJQGblUnLx8WhzWU6kusTZT0fNblwTC6bR0nPJS3LKK
         rw6fNiI7IOrBwAN98GgOSkiU953g8+ijb4DZB5v0tvvn5xcds1FSK6Ewjh9E7SrgW+fy
         +0z62Ch3fxakiw4pkPMbx7N1x9qiBWysWqcgZaqqWzZnHU/mRJ5HVQ1mxYNSq6Xk3bOn
         VYRWZdOVCvgKODKCVihIHFcNrBtJmUWKzLddhM4cpUl4mCxSQ+1M+DMrYyke8PZjd5l0
         96GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc6qj3VwXA260vO4yrkjUrRYsCzaeycKJc678GyfyUbanXDGGxS5btDvVfxkUfqOXa+a/YfZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89lmsN1t6q5zIdYoyaZ3+UuBKkeDMalM/f+J9w4eTZD724tLv
	DVX4rdyurlyi2F+6yb1Dp7edpfX/kEzDNu+UVcK4mIJ7o2AwtPxZQ9Pz
X-Gm-Gg: ASbGnct7JP+D5az45kUse9AQkQLLCDh43rAoSz31zyk87EUQHyFN2VvNhBa7MQMJ0xi
	OEkSraVIk3+HUZbNVC762nUrnS49ADiMqO0t145sEcNLp1rErP4R/edymzX/yM5/E1iedJQxfyS
	OGGhTAomMBJruIVPuu9ywp0UUjBRHC4+/SJ8QFWJ0PYtdrAbfw89m8RxhyN+hssJTtGKBzY27ZU
	JKN/8FV2zls0BDWDN5KJ+9d66Iew8lwJePd09fT2U5UncKEQcBNGydtPkNbvYj0Lp9RbRsLM1/L
	h/1kaO7USUhR0xOM+0Uei3KhV589hMaFJTONVlQgLb5egqV1PQy4Q5z60e3ajBVrHeQjpORWmam
	R9yXg5SEQyHc5ghAxUvvn
X-Google-Smtp-Source: AGHT+IH1G45fa5YCQK+kxE855mZomiycdKbfTkGF0m2Y0EHZv1H+CmZJ7wc0J0YyEKXivF3alE1Y/Q==
X-Received: by 2002:a05:690c:7305:b0:70e:2cba:868c with SMTP id 00721157ae682-719b4155018mr50034277b3.11.1753302927075;
        Wed, 23 Jul 2025 13:35:27 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195335e708sm31081287b3.100.2025.07.23.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:26 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 23 Jul 2025 13:34:38 -0700
Message-ID: <20250723203454.519540-28-daniel.zahka@gmail.com>
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


