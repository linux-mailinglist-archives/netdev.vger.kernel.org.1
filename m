Return-Path: <netdev+bounces-215225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB385B2DB0B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C835C4349
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3F3043D7;
	Wed, 20 Aug 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le7l0YsF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9C3043A5
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689492; cv=none; b=ieVmCWEjSklOoiD6QaQO+06/gUj/bcsWlpL5GKIt9nSmz/8uoyt3TXaD0SdBS14GsP5czAb2QEdrhP59rF0xb/3pUpELCFeUx/qVNffSd06oSKuoR0eCHXobOIlLMm9RWlYPfwzZzdNiMjZGwZcbjqpffJPYUTblXqjevl7AKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689492; c=relaxed/simple;
	bh=hACXXKBHMxU0/R2biBFnMZby12ksVG8UImhds11uMZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfC5405ZWLINoPckT3o/mhDR8Rd5AHCYuQUW43HFIZ6TTlcgUDGpyctHQHZv4vgh0rgkY95uPEImiX3W6jv+CcRUjLx6T0VX+LblsydjV1rKfjsVp9usao390RJTjacquhoLsX3QmdazFliDUN6H5drusPaFWKSR0LMlk8xTtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le7l0YsF; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e933a69651dso3937990276.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689490; x=1756294290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=madtT6z8JsEzyJTmrkduHTrskJTCZlSYIMg3WflLZuw=;
        b=le7l0YsFDMA1TCv/GGZx3TycBZ7xgSy9ZNd6QxaWP4PXKn8Jf1dT9J9TbI4A6tSylR
         jrnaOQfqVTqe6n76dJo84BDxfDs/0HdSq/1Xgu7Ifs5eDDlPfDmDqmunj0jL6yA1B93c
         ptg8Rtxvhzb6WKItq9okctc/7EWcvXlS2slTZQMK9YTslMxB4JXLOiDJ+XOuIQAVd8HF
         lE3m/U6OptM2pOgHKU9SB6lPlUW7LXleHGhHhSylgKsfzndc1s1FrMfTXBXHFsGHohVx
         lo2ZFZpN5fKxJWYevfNACO/muQnXJOlJQ/RXvKy+7L/NLrJzS9Smqcde4mQRjIWnc24S
         1xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689490; x=1756294290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=madtT6z8JsEzyJTmrkduHTrskJTCZlSYIMg3WflLZuw=;
        b=j9JVk016BqyOZrjIpS/9C5QUdLQmAyxS7y5t5io+uk0gl/qnI7l/DG1vs68pEHP0KT
         T+WzQKaQyEmbaJK/KDlqRZi78o32bw/M8Tv1+yr8ojM6JHeZQt6JXiusGkNJTmUcXR9w
         JPsfzgcvA/hSy2CkxJa0+yOK1iXSxNDCeRqYnoAeqr3J5YuirkPxdTnYs+K7TZTSzWJM
         FxwpL/b0OBEKRqJKCGK0b/xYZOvhlsVbZWoq5moxFiyC5Nhf7Wa7f9Snri49PMtknsHS
         cfg+oZ2NDuKxg6QP/EdctzVntd7dgV1YbXqE48mOgG216yh7yyXUfVR/Dflh/1QSGmDW
         Zvxw==
X-Forwarded-Encrypted: i=1; AJvYcCW1XeO0ASQ7lqhShK7qL/Smy2jo6TAEPcshSEX569K1Wmxb2Lltzkluw/BKHCGobYenbvFq11Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2eZwc6TaYxY5AGLFDkmmrn1npPFOMpCvzn60SUe89Xi5kxxq
	3HbOj7Q5ahL1MrkStsxZ26ExwLxFC6JgNW1MzuY/oFbx6Yhy4Wu8d7bk
X-Gm-Gg: ASbGncv4xF6IlAchc7WYqbX5pLcXA3OdTVDOBbK0nR48khAlJxYvwDfW4aWfwEZ0/jm
	nSXHVpE+JvV6b6BEcSD/6DZIyNmDei/qbV90vmd6OfJaOcf3RY/a2IFyi55QS+DL+BDder9dU0U
	FSmadRuYQuCbywsRc3mZBmesYuYpaQekIlXimR+J8xe6koovEUk2/HN6jGXIuQgNVTKHqnba0kc
	se2Q46DYaYC9IDpLL/AVCtDGuuyg5xBApjL4mXTjMdkAg6NnqFQmfpf4m/U6BMwZ+VA03ojJE+I
	JITl1iJp6YSqjcaAfxCjgoVbCfhZU/rSkLYjSXwceGGiCCsdsPvgeV/xnXy0AQXQ4qaWMFvX/lv
	bB8lPTjqiAzuuRgfWcWhZ
X-Google-Smtp-Source: AGHT+IEoEiW+c6xtRnYFE6h5Rxs03wXs1rTeg6e4tWKQiReIA+f8GJmvV1+8bdONjn+ZzyqSoHdAsg==
X-Received: by 2002:a05:690c:3802:b0:71f:b944:1018 with SMTP id 00721157ae682-71fb9444bacmr15503217b3.51.1755689489626;
        Wed, 20 Aug 2025 04:31:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e11d302sm35941727b3.77.2025.08.20.04.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:29 -0700 (PDT)
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
Subject: [PATCH net-next v7 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 20 Aug 2025 04:31:05 -0700
Message-ID: <20250820113120.992829-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
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
index 6a15ba76f558..8d3e6ab8db67 100644
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
2.47.3


