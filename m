Return-Path: <netdev+bounces-221932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF7B525FD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05C1178491
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89103241667;
	Thu, 11 Sep 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTa/RGWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF66221F15
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555271; cv=none; b=K5k/wRRzLlbO/UMgWbnF7a/a84BPUChwTnMjc5ZdKOfd7gEtCWzm7vbvi0ORDHxqKmbn9YFmSLb0jbgBNOd2lvTcRmwLZiGwo8+cZcBbMPUSOPBuPZys72JhCuWAXrNu0p6kSIUANPyasLM0NALWg0Kkqpzg0Ue/GJWt+sjGepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555271; c=relaxed/simple;
	bh=NvY+dT2MGf95niCqUulbPKNVPK08e3ssrV9rRCBMpdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVUqVAAQcF0Wy6u9v4B5gCzQ6Dt35mD85ufZVmjuVz8xLcoNXvpKQW3j8ArWoWPtBoO4eFEB8HAnXyYb07jd1bz4oAJFfrcPGV9NDWYbtxKKFMtCgaO1zSF2vpOXfDBV2pxxa4loZc7/OQskJSqs3OLqe1ke2dLGVSXweYy3T30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTa/RGWU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60528734so1836217b3.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555269; x=1758160069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbz8f9ZWzbkdEdCm4i5LXlB7RxvfGAaTEfsZ8w3tgnM=;
        b=VTa/RGWUYJUQ/ie2H73AXtko46hTdwujXIhPlc0xrC4IgTFnBx7Ocvf83EuRdStZqR
         XvnB/YRc/28QCckx9FcUKmNU/f3Letag2n1HRb8ZZpMBbkXGZenURIGthSBs7SZ47XFY
         EtWy/nq3wyzDp+UUin5ImHsYvEBM0D0ESZP14t46SnNY626aZXvEej8qg9oiEGFIWdt/
         e1Doz9olqdw18Dqp+U5Ir9tBaAurnKY4pZDSBF0X1Ynawj5r+0Z9llbjYbO9nJ+ZKdOf
         RN1SbVCTIO3WkVMWvLG9FRWqL1QAdjSXK31HJ/P5fcWAFxyBxik7s5Kbw+wQku64vE6H
         0Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555269; x=1758160069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbz8f9ZWzbkdEdCm4i5LXlB7RxvfGAaTEfsZ8w3tgnM=;
        b=PoR7kmivYDopF8ECxft+5FX1OomUqO9VEazyWQRQjm1zCAWiNGe5Bx8eZonT06wJTw
         yZqL02FS6eE4ydT3KBJuIrCSoz/+fz+HB69x6o8P8/Px8RQGDjcefJh+8LptpzDbWSZ8
         xvJJmYLtMBdugeIZ1fA5yhcd8z2qnIZBJ3Gq1ojdV8MtVcTa1y0klIJ+xLYOl7/CZ5FH
         yAvaNdO4NxgZp4ORlXTijaPkdqxtkKcbp7wnfYW+2h4eTBs6ugdfxOKTvjk7ID6wkFvg
         /OwLeAZ5tId8DmmCA0b5NkTgIlhU7bCxAYYNfBm4rlyiRkIhOjuNWQR2GqpnZkfjTbAy
         CcHg==
X-Forwarded-Encrypted: i=1; AJvYcCUx4s8vplh+oxUjjFa9rPlfH4VKUs/DHCG+4TUOqHIWXvkAPVhkEJnd6hBruMe9yOny5lqsd9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSwtfeP1fAKeTZatcMPHh2cpbP4Y30r46SXXgb0qYO898dnOn
	nypxFw1225hNl781bB7fVUQQaihzfyQQXAD4EV5ZpaRBPBswZ6SF7YB0i5kJGA==
X-Gm-Gg: ASbGncuO+PuMVzPzERnBrwPR6yt5ypWIHP0QqlBFFoy0ZLU8KNMV7/pCA7fmTs+cGxE
	UectyUUacAA/gIuNqjySquzFGSHeH3P2Qpu6ioi4BX00M9QuUF6JkigXCz73NsiVfiPuhSPWmlG
	zeKIrIy6uUUVVIiTen13UB2hfpHZ8p5N2GH9iMncee7RAef6+cj+5eMLo+x7D6bfug1NTj4yEKy
	GOu/KJnYFTvNvck8hUpPwWYits8fGSeqSCkpVbPc60mgJwD7oeubE+D1WVZmk94cIAdhKZadGW2
	wxCQ39jpxS5EndrghjhqZ9niMMkoGxTN0ACJ97JqDN40q2dw/mNsM4GNIkbwTDJen1cZf1JiZ8d
	wR4UZj9reayTHu/wyOOEkGyXEiDhzKRs=
X-Google-Smtp-Source: AGHT+IFyuzXspE6EUSTBoukcqJpMfuxJUsysvjl+3nmjhmk4W5r7SZAF4F8G0WrLS35ZUFNxIRHExg==
X-Received: by 2002:a05:690c:60c5:b0:722:6ab7:f657 with SMTP id 00721157ae682-727f553f4f0mr156310327b3.38.1757555268701;
        Wed, 10 Sep 2025 18:47:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76e166fcsm357527b3.32.2025.09.10.18.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:48 -0700 (PDT)
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
Subject: [PATCH net-next v11 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 10 Sep 2025 18:47:15 -0700
Message-ID: <20250911014735.118695-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
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


