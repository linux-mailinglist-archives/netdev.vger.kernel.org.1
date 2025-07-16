Return-Path: <netdev+bounces-207490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDDFB07878
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDD83A64A4
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67726FD8F;
	Wed, 16 Jul 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5QY5a4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEC2701D2
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677164; cv=none; b=H913pWgOmywy6WJr1bU8TTxH9cTli4x+bAyGLThjQ3xwatBcyaBbcfW2rg1DrLC2c8aztDzm2cumsRA97SyxLhp+q4LpCqU8mFDh81PrV61ARFwmmCyKR13AGmPcPPJRA26potkwky65GSX/Qv4ad7lZXJSJdsyew2mi4PZHkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677164; c=relaxed/simple;
	bh=GoNa5g41lC90uNvZtxnaiVWrPilJS4Itw+t72VnJXcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1zmiR9RZ60LBNszg7Iy/wMDa6JY6Lax97BC1SlnEXNJ6DthCoPRI0KnCi/nYu0tkLnQaeGS5aaRJQUbfgIkOHa3P3fij1G9pJKpJjFAnMIEFvrBigbIKaVRscFqRxCXBrW/w5d2nDlhcEuzjtJbJtvaFbrYXqB744jlYcXKzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5QY5a4y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71840959355so4587637b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677162; x=1753281962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWNv2KPw5bJvwrqHIE8AuXdFAqWsbL4kGCSc3vlklfM=;
        b=h5QY5a4yjDu9xR0IEcuSwjxbeBvQye7U1qQdZzUYA8l0cnj/SrlleNEoggLnN5zKsU
         HzvLF/SKnxfyeLm74yamJJdZqb+86vWpAoyHmutAeiq79+xEbBh7bV10Cc5MVgGOoKbd
         xu7B1WHLbzXNo69b8gZbNdT+/En3H43qKRDzpX1NcWR0xxXHCphbpA2a8RcX++F1ogYR
         eNxzB+5Q8iq1Z9iBJY80UsRuu00Jzk02c109xIDhqB7LWb4er0ukYCBUam5rVrN1jgMD
         4CjWmwTVYuZqt9ho0/WTug0PSiaf9hk8d8rn17Hda48mxrT40c8GZfRI4GL+YZREq5wv
         kS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677162; x=1753281962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWNv2KPw5bJvwrqHIE8AuXdFAqWsbL4kGCSc3vlklfM=;
        b=jdIUuFO6EkKDig+nQ2c6GwvC00fCpTPoM9pEa3gERnP51JdMd96nsZX0fkUv7xqGu7
         MO6dGn3yHRXP6gg4l41wA5eDMIkGD+Bl4meyztyJYmnVBlU8F0ygKgTNIMzmqSNdDno/
         33q0cC1yJhtCLE+3ukIisyyHCud6BqhiE/wOR3vhK2K1Ry/JibdQ9TYhWQpdXrtnuWIF
         zo36whp7DSC9I9QHVJqLg6JoF9tF67DpDPbG9HZ90mt0nJ+R3MNFqDct5EiNtf1QFOPj
         ifvv//gUht5B/NuW5wFKijy5S/SQhWhOkKmxXXomTyXlls538J6vpbVAnWv0Auq7SgOg
         voIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvRO8tS4IX/cNzZitLG//MHxaDHn3/ylJ/qb1KLD02CAMh72ml/zHtZpHdjIYvB2Zj1xpTEKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnKZdBOBaTnqYO5gwP6vkhT46fDAXXu3K40wb/o8YhsExQT1f
	3Pijsjte9qBzmr+dNbro1K5fgseSpS3Tg9de2i7IV38/ofQqcE8GBjnE
X-Gm-Gg: ASbGncvJ89GHyL91RU5iJQ+oW8/zae62r6wXUCkH04SpSeRLzC7Mt6zel5TU29tg23E
	7ijV5wSmLKNqpcEH6TS1x0giDVsVcH887QsbNwpksw0piDXKaKMPMuXQVGENSRsg5+0FxlAB60c
	4WZ2GHoaL4ugLe0r9nzcdJuvmBBC0a+X6mWZTSJUCBjFKPQw17cJpL+x4mmqKpYJEEiIFMkUzG/
	LcbUo222vqfY5d4DQPp2jH7yZ72/ZBHO0UKIyMJyn+xeptNoTZvK5C9LhJFP/JhzE/uHgoXli0h
	y+bp8AvbNPRyn7Uj4rdR7KOYs7zKsuizYva6hmCbP5763jRzO1BM1pmK7TgWI6yy9frdVr2H1PL
	/H34L1e8dlvWXG49vW3zb
X-Google-Smtp-Source: AGHT+IF+8a6pM7GKU/CDX2KZYEyg7V145DCP5DYpPIL3ZQpA7jIaAu3BZiWFJc4atiOv323Jv8bueQ==
X-Received: by 2002:a05:690c:6410:b0:713:ff19:d046 with SMTP id 00721157ae682-71822ab985bmr117173547b3.6.1752677162217;
        Wed, 16 Jul 2025 07:46:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d72fa6sm29439647b3.40.2025.07.16.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:01 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 16 Jul 2025 07:45:27 -0700
Message-ID: <20250716144551.3646755-7-daniel.zahka@gmail.com>
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

Move definition of sk_validate_xmit_skb() from net/core/sock.c to
net/core/dev.c.

This change is in preparation of the next patch, where
sk_validate_xmit_skb() will need to cast sk to a tcp_timewait_sock *,
and access member fields. Including linux/tcp.h from linux/sock.h
creates a circular dependency, and dev.c is the only current call site
of this function.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - patch introduced in v2

 include/net/sock.h | 22 ----------------------
 net/core/dev.c     | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 19a898846b08..0ae9a6d8b53e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2870,28 +2870,6 @@ sk_requests_wifi_status(struct sock *sk)
 	return sk && sk_fullsock(sk) && sock_flag(sk, SOCK_WIFI_STATUS);
 }
 
-/* Checks if this SKB belongs to an HW offloaded socket
- * and whether any SW fallbacks are required based on dev.
- * Check decrypted mark in case skb_orphan() cleared socket.
- */
-static inline struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
-						   struct net_device *dev)
-{
-#ifdef CONFIG_SOCK_VALIDATE_XMIT
-	struct sock *sk = skb->sk;
-
-	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
-		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
-	} else if (unlikely(skb_is_decrypted(skb))) {
-		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
-		kfree_skb(skb);
-		skb = NULL;
-	}
-#endif
-
-	return skb;
-}
-
 /* This helper checks if a socket is a LISTEN or NEW_SYN_RECV
  * SYNACK messages can be attached to either ones (depending on SYNCOOKIE)
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 7ee808eb068e..b825b3f5b7db 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3896,6 +3896,28 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
+/* Checks if this SKB belongs to an HW offloaded socket
+ * and whether any SW fallbacks are required based on dev.
+ * Check decrypted mark in case skb_orphan() cleared socket.
+ */
+static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sock *sk = skb->sk;
+
+	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
+		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
+	} else if (unlikely(skb_is_decrypted(skb))) {
+		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
+		kfree_skb(skb);
+		skb = NULL;
+	}
+#endif
+
+	return skb;
+}
+
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
-- 
2.47.1


