Return-Path: <netdev+bounces-223805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D5B7C427
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5242A05E1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51A2940B;
	Wed, 17 Sep 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mef/dvvX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BC146A72
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067808; cv=none; b=gIKvVqQ4pgGgTlz3Xd4gmcDzRHCoesLQ3lSzuFKJ1oFtfJz5gUhXFWXb7V+elofYyja31+JULfXaWWmVy1GMNDdEby1nL82qgwLcfSGApX6ScJyDe0FYZaJzkRz4u72dmfINCxDn/jjZNETVLRuBplVBEMDpMpqFkw1SR9jzBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067808; c=relaxed/simple;
	bh=ktchnLJ8Hv5vANcA1GrHar5qQKDEUdmaYAins06ywbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlvinYZh0445DHvLMncT4AMgOIvKyEFWM6ekFsCxAjjYWJ9JG/77PN04EOxUMOAdoNMWGTJAnvVXSK0G4+uKavLCEgh16Rlesj0VtCu3decTydQYhiHJdLpS6J88Wn6kLLFsJsgVDGiE4KXoe2LlQPoW+s3iO9IR64N12vq97cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mef/dvvX; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-632e9c6b411so1599020d50.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067804; x=1758672604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VzgsRUmJ4fGBrHoaVEtmeZ5eBUSsEyU96EuvMCBRgk=;
        b=Mef/dvvXB6E8QfhnRRRZo8XOfAyJMTDIjT0O87lAFVDY+wADhsMWVklaxhyVuytY09
         /zUn8dxh40Ugaj0FjY3wqk0w3UzojlOq23nUSSwUEzEHndTUhvHOAIqa5W271SGoz9uH
         AqYEtaFmOdPGTMjXtcrcI5VUjwMczlft2aj9thbBJ8aQRJYeP91ccNb6VlQuGQDIlUFf
         LqRLA0gNW3TpsYrrQgCOrrI9J8SHx/FJOWeZSc3Z1jVcXgJEMV2fTMxyySj9HP0qkDub
         GCDp1FVPkB7l6CWchkyQ0h0971DSjloVtl2LNxwZRACpNGN+JJd38wjO2lxsBlZsPSVF
         jVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067804; x=1758672604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VzgsRUmJ4fGBrHoaVEtmeZ5eBUSsEyU96EuvMCBRgk=;
        b=N4hjLajseTeirP8N7sfKtnqSsWFPGeBiFA0Pn+bI01WJCa3o/KfofwUW7pHASKsqsG
         5/GYir6ehsHNCn4OK+pUm9Gv9YYohYMOFHhoCaohumpoer0hfQwYRz6RUvUle/MHfV3X
         2WaxZGAbB03INtz677873HXGGEX4gF1kTE+bXNaL6ZlCrP+B0xrSJRPiELBAOe9NZJt0
         P3Y36Sd12FINztc8PZ0fbpM3VM8fcZIqle+8JXOLovepaW0wfHFlSSz72+LbuwkdYTcg
         yMxoRobw1X5H1pShbPonunQbziXtY1gBdmeb/wbmwPum3PngA0f1YDAR2+XZ0S3j0a0r
         B+8w==
X-Forwarded-Encrypted: i=1; AJvYcCVrH3NJUWm58SS7FhiCQrecBG881oQXDaRKLIR9pzdOkPj4gvrHx0I614MIixTG4aJ25AZ8j24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwQa5VgvlU3hOBEGtiA+qQhapJ8uwIEB6L0//8ulmNkLrO8Cj
	9tS7/gOl8bSlTym7iH8j0HOrq3wiTjgE8gUqG7BTNiJ9Axe8ITasUcU4
X-Gm-Gg: ASbGncucGEcgc8fdWwvjdyOieg4IGhBIgFFjqJC2uUl62nYycTSJFjSqlw+bztzFynH
	to+gB0rc1+LAdhdPDsQPY4jLuRVEfdLcXcr/l2B1UqlrHeF1oKCKqQ4CvDZug1lU/zdd9yiuPvn
	8h7GJ9GN25sm/rAQj+IcOUgeNzreHjuyh+2EHHt+PsJnHWaMeH+xqnChxZDcZR85lqmUxs3HeFV
	isECqpOwndtOpkAPodvP5fY0lCD6/6raY+WTCKuUIEB1Zv2otCFVJn5jDyUPeK8JER+4Vnk293q
	+uf98+tplkY2X4nlHqhAb8Gi1ZS/KL/b87xVk+5ODHz6+r2ABOyzcP81LxpxxFusqG0Efi39JYL
	Alc/qTPzgmX8A9dNXO/bP
X-Google-Smtp-Source: AGHT+IFrKOpiL7lhYMlascMAUfLZLcH2loygm6WlZmc496nJQZA8ig1kIA5pfdE7/WNygaDh7j55Cw==
X-Received: by 2002:a53:d00a:0:b0:5fc:2821:3956 with SMTP id 956f58d0204a3-633b073eb01mr260859d50.37.1758067804411;
        Tue, 16 Sep 2025 17:10:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7335af1ea69sm23770237b3.34.2025.09.16.17.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:03 -0700 (PDT)
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
Subject: [PATCH net-next v13 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Tue, 16 Sep 2025 17:09:34 -0700
Message-ID: <20250917000954.859376-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
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
index 384e59d7e715..5e22d062bac5 100644
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


