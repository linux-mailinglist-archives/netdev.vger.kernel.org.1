Return-Path: <netdev+bounces-203452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D1AF5FA1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD54A3948
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA4303DD2;
	Wed,  2 Jul 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9JvacNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58639301158
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476417; cv=none; b=qyYaMZJT/lC66CxldTDRUUkD3BeTykYl9ppPxri7b52ffJYZrkC6O0KeEQqH+7M5lEcqdqqZ/NLihggFQaartYmZ6JpuQlhzSYmchmah0heHakHtUIrKXK6CKM7Uy6WJQN8NMmVopF/v/KXFT9FMINBIKzOsJCMYmqD4rJe37d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476417; c=relaxed/simple;
	bh=Ll0pmPryRwhd2yZORwWyiB1P8koFqBKKI4jt+F6N3Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8jG2O+XVqw6px3WaKnWHcCQjePzaZoXF84VrZ6rkTIjM5XPSBxYivEs7IzVvhBTZvThDg4PpzVONAimS+YFci+5BX2z0akhXDlFfX++sg1sECIcexINhO1iXzLA9ZVJoZPFtvv9pnYs/TTbKcDVrU5aSIuOmuCNNDnAuJLDup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9JvacNX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e740a09eae0so6645833276.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476415; x=1752081215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUPRyCsxZ6o//7B4rROjf6/FgxvK+C4InB2HwJe/8tM=;
        b=Z9JvacNXxLDmAMZQr81mwi3ZsV8tfmw5ZNsZkioT9twFpQuFtSgfcH/rNSJjOfATPb
         nd/y7LgFTCI/on+K6pnBL43S7Jf2oMS6zDj3hnKDt4/GYaZPRprDJkjaurX3RCM5Qmht
         JnoUktFiRwb5qsqaK2zMrXudsIZEbQG0LxtiCOjpbJ/+HMR5zi+4cb3YBXTotRylxilp
         0IctqHkHH1VVaO9DOjGvt+ZyNRnmHbeNDWolPrn/n0MXIyc3nx7ut5IBvvb1LyGdiOnk
         7h5vco/9N2calhp1sv5CgQwKWq6rFOtsb635nc7g+D9tp8Q+F3plbHFx/jHUAYtxhVwO
         Q9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476415; x=1752081215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUPRyCsxZ6o//7B4rROjf6/FgxvK+C4InB2HwJe/8tM=;
        b=u1bcxOlI7U16zr4i++e1CCBqhKBD7WQ2JE233kNnJXQA8aOtR4TnhRio03d0/A/lfe
         caeKrvqnAhnlrLR/px/HIkJz3QCDSebnSeg163hxmaxMqK1GYVZzkjOUN9RXlDmeh4yx
         T+Ge+xWNB+A3EoxixncstejD2Ct6FMThBuzSHWwXCRj0o0iDshRw0sZ1hBTwqXE4XhCB
         7BW76HCvTAgH4Se1cPKOkvP8TCvIQsuQHrtFlhovoFPJRt/yDfeziixiV0yh3SeoIezC
         o0CFaf320jUvGA9By7fW5DUg+APk5GzZ3XicfUjP2ULuwko3sO/bEVekOSAZ8xRcLQO7
         vwhg==
X-Forwarded-Encrypted: i=1; AJvYcCVhpnxLWSqROYlYctVSKwvSdwjjF/DiQzXwMwsQJS6diyKCObZUKdODwAlB62FKfzP5g4eHAn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWx/hPlwZyiMD8e/CKFeG8q3SNWSrKhLkTH8CUi+/bdzpkTI45
	+mS4H8N8nr5N6w61QHdv04st1wSt0XDhTIhKV1xvPz8gFmGMMZDIVosn
X-Gm-Gg: ASbGnctu/K15Jeyj6UPj8hb+faVS3Eb1TzhE6cnh8lTdEn0Gud7kA2Z5b9ZDhtJ7ovZ
	agOF6thkaazNwBD3Wn+3Mp3NVv74klYGYtI8Y+Rri4I9TknIvtCrBszfmQHLh+Pbcm+2/hKE8eg
	p2+NPQ9HUxh/W4h58dQx4F1F3LSyCKs37qXM29fuKS5jFLdnHDH2afNJ6fWcxd3Lk/Df70CGOnp
	yf8Mv6c9cmDbFs8kXRetdfjjzvqyagW8w8JEnwyIa90tG4UylqzOk8GmsbE4T7GlSdVs+wFVpYG
	xz0o+jpfUsGVgRezk6qOjnMsoi8vyuwJdradZKIjQNNHjQOcrsyB6amybbiDaeDT2G4vM68=
X-Google-Smtp-Source: AGHT+IEn/WcOebKJ5nu7IZjPTCwCIMdJF6u56kQjSZIA3Tibuyvnqv2hMb9J07vIcdj8E0Y85kMFhA==
X-Received: by 2002:a05:6902:1027:b0:e85:eb80:3cd3 with SMTP id 3f1490d57ef6-e897e3c9555mr4528016276.23.1751476415349;
        Wed, 02 Jul 2025 10:13:35 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e898cc284b2sm175593276.9.2025.07.02.10.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:34 -0700 (PDT)
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
Subject: [PATCH v3 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed,  2 Jul 2025 10:13:12 -0700
Message-ID: <20250702171326.3265825-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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
index dfde7895d8f2..859c03e07466 100644
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


