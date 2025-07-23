Return-Path: <netdev+bounces-209521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51BB0FBA8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FAD1CC315E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC4242D9D;
	Wed, 23 Jul 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5FbNVLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F78242D70
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302928; cv=none; b=qRwcVYVNIAWu69e0Hs3LLeY7Xf69x/CYade1WqJ7fB013A/Ou8iM6g7S9M14P/HXZcD4LC20G5mW0aHKdmnqIudIu/7AY1OkqUDXG5XeyFHNW01AB1zfCz/7gDh+FvLW7+I5yQHd89V73RW12y6LpHMoT9mSC0hHxNi2moOUrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302928; c=relaxed/simple;
	bh=QthgXYQZRXocqOXt5xEqHhW6IaGmVzYa1DVCCon5jVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnAsA48/Iqr5Kf3GwYX+gyOyfYSzzEpH/BSaiq10j1hPef/eS2qVVYE8RoEfoQtiRF0/5A/STy4YMq8dHTloZDMOf67jlhiZ3TquKpsW3SD69WW9LRrESIyO+YwJiaedePWjrQ1V0i8+f6gk4Vn6jXuBHZaQw0HIQ3SF95jMz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5FbNVLz; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8d7122c3a5so207848276.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302926; x=1753907726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOt21C3tkFccBpqLa9kxQtdGM+W+vdqoFxH5fcFsTK8=;
        b=M5FbNVLzvb/MsafWdx1e5+CJksRiP1k6X72QCNq5WYrMwuxPTZ12+Jn/Uq0/bRQr+g
         /oaoITQ3kc8wTPfKMpIgnUZ+dhvy1B+8OHGMmD0LXOYK/j/rFzvBorTlPuk1BBn1qDLi
         JXwW40PxM/3BmCm+uUhu5hhkf9nAqk+k96OOrA9Ai74owJxyxD6M7WlidzT9k2oTVN6M
         881OvSFVcduZvGU+B9x/JVqyUcR6gULDegQNRgIDqHNFya7ajU5laIWEkyfUBnx/7fEV
         GOTY/Qv0lIrcaf/fnnIVqPVdY9uzqoeCJHlpId9+ZjvCR//SjyvZsxAi5a9RC0h22woR
         EBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302926; x=1753907726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOt21C3tkFccBpqLa9kxQtdGM+W+vdqoFxH5fcFsTK8=;
        b=NP/DsExOLp23ZPcqjq6EHvifFTZxWTtLaGsvjHlMgtkR/kXTgkehzgwWW2BJYE03bB
         UNtgDqluH3txGNvBo1KS/Uw9oBgGswVrsIjOcFQkJ6/2d7VU1qPeGak//Zo/iZ08YED1
         PcxE0gp62wKR4eTW0vmCY7x3JfoA8STnzZn1EN37lqzJZ92j6VOP+GDABR3pt3X8MXZg
         QcBkz+fQpFVqsJ+C8tOAlItsB0IoVsuKvSk3l2dbw6CFm/4jE63pg9DQJb0GYfe5xJ8N
         V3FK1zEU7Tf067fnOFqrmyulFlaPuMjyHADnnm2O8ex50u9elKU/tCMYPVn1p9l4aTTY
         sxbw==
X-Forwarded-Encrypted: i=1; AJvYcCVWBdJM/dnPJtPf0KYZEamouKZJW8GMDY3sv5Qqiw+J3X8WusDckkaSLZG0qlSZHanzsD7G7XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbyulfBDRs8ykVl1c4D52cvqjhXrEMz627kW0dEy6s0bmUp1g
	5bf06BuMLxYUZ2PxUdoi+tKZ+bc1v2CZ80IwxpB16dCEGUy7jPwdcqpYnekfiw==
X-Gm-Gg: ASbGncv2BhdBqNTYDH1kxSGKCQ/zKB9xIss+1Rh7T29hJabpxGBgmSPxTSoPETZi9tX
	4uBst60wEzCpyk8igGbC9aFk3xAii+/Z/NaI9UzqCe2cqfLCMCu6YswZZJqdZooLLmqgc4jWUNk
	Ln1Br7ImBtQ7CLMOZnPcRA0UI/LH3nrjdY0uzu0L2qLFlIndbzURl+o5njWzMQpcy4Hx3BrMlf7
	9yUd0tVtVjWMi39x2U6TeFEh3q6omi53GrSk9i7s4K19tVXTuECl57elHfNO7U0Tpmjl7kFvIC2
	W2g3NyHlEBn4j81bHGS4q30P94H6di9zxeoDXxyHB7FS0C5pO0lf7V2F5QPcrwIgOUAUiY/yEHl
	wYqIXT8GK+2M/6ivfMB2I
X-Google-Smtp-Source: AGHT+IGfQBGFeiKphAm3+7UCIBJWy8GlOHQuGIzBDAUQxi2R2lh6VwsJheGzjQUU9h8+3iAIIcTN/w==
X-Received: by 2002:a05:6902:c01:b0:e87:bdbe:103b with SMTP id 3f1490d57ef6-e8dc5872d56mr5716958276.5.1753302925757;
        Wed, 23 Jul 2025 13:35:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8ddd17ac41sm151485276.13.2025.07.23.13.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:25 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 23 Jul 2025 13:34:37 -0700
Message-ID: <20250723203454.519540-27-daniel.zahka@gmail.com>
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
index 94ff9b701051..e028560a6ad2 100644
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
index 354d3453b407..d23a056ab4db 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3895,6 +3895,28 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
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


