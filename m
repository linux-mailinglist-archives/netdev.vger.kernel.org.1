Return-Path: <netdev+bounces-221930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8CB525FA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40037A005A5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBA19DF5F;
	Thu, 11 Sep 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqL5Ro14"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8C21D5AA
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555269; cv=none; b=lTNyBUBoIWElj0+8xV8D3drPu6626IuDM+/LZOD1cWrtA1MnPRzdBmPMNAGbO+FvEsTzOz5KkT/YHdIej3njrWboarE0YcGoMX75I/VE8faZgh29toVtM5xrddQ1OUjLIv8wYaOE2+P8t9ObLMWZLGlAdT2aZPqN6nrrYfs3bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555269; c=relaxed/simple;
	bh=3PVn9HP3G0KkDLYVw5tCL93QzTE0jRO3ZYxz6vdZdOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZYxRURXdN5B4IAlC0maQQHEyzNmiYtTU56r/0zpJwBoFyPsSSvVjr0ypw7TyaksbbG0uuzyE+YRj/iphqMY7lNljCxJbwXilXnxwMQ7MvX8aOGuS44yJ9tjeO0+XqhLxdZdJmV8deXV058L2ZsuvoQ0ouw9Q7pEn9gzEo693+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqL5Ro14; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96f401c478so95409276.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555267; x=1758160067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDBRQyax5ZX33/axv0zJYoWvzdjsC2AclvlUZciSnlg=;
        b=BqL5Ro14VYuK7uKFJVVbFNUTvPfFT7/2Lukpr4cmQyIEImr/yBE2N6+ov5OGV/p1Nd
         iG1oahXNvpYPZ+Cu4XKdlpLiNWvS12A9txZtnpUgs/s2K0e0USJbedPRkkILOrAKrwCq
         0jrPfq3OUL++kdlPMEhsM/ovS7v42FStDZa5G1LubrC58aqUkZ+/8A7tRxgd9Gus+R9d
         kzyURX6OnzZ3fxbmHQlXsegcYytq8AGbKwPTVae9R968ZYTu6khuR2WuqdQ+ivUgUQkd
         c70I4aZ0tBE2sr3fWTM70LUgxnKdJzTSc1OfXS6n0bTFLvwuT8rFPigInttRpO66fLjV
         yoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555267; x=1758160067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDBRQyax5ZX33/axv0zJYoWvzdjsC2AclvlUZciSnlg=;
        b=bXp0FJcHe/mqC0nhYjyQ6hmRX7fgeSBJXYHjKYjDuD+ObMcfbfDgDCLiqViDKEqwBc
         8PzKqj4WuYiUqJWxPkQkEYqMz6LNQ+fE5buiNvSmNMXaj4R5P9Wx8npv1JPaZKirWadK
         J/BrJ+3guKVE+EP8eXxHaST4qo99ZnPPEJ6lBm5W8piVcoRYz4GMGeul7IJZUqgENMgp
         XPAEKf50jGMS24s021mD58aLWwOjwxv1YV6tvBaN6mDdiHbtaOBUpSOqs+jJrCy3X9Dl
         43NFQvW6XWsVhM9tqM6gWGVW18nIK8nV3vhzulojAm880x7J852y83Jlwt5cuRbDHo5p
         rvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW49vROWgVjGPwa9Z/Vp9SvNXhpZ9xZT+A7MimYZNznlBfhu0FIwHynewNDauLB+s6DCHsS5/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cpN3sz2F81q0E1iIcU3K4vIvVhBT3j4IJAWh59Zqsq5Op/o7
	1mpR9a9e5rnJRJ7byXL5Z9kXYWdNcU18BRw0Buj3Qri4qzkg+faQ40RG
X-Gm-Gg: ASbGnctBQ1TbBaK4Eive/RhscZe4nj1lS4BlSBLY6NIwMCbwYLt131RFD8A5d7KuvSD
	/rSskrUW+X1kZS4ZrI5VFCYUgdHfJqUVhqJKaQODPlJGIGeAaaHCBXKrdIuGqqQsNNiWCtJ460s
	LDyTGestA/bKHJ2eZMkeKsJNpHPBhQtEZrCk4oIpL5oM5XpPZPWP/i03JxyAkTGoAadoRruM8Xr
	yQCNOewf58LO9XvKrHfaoYpLztKiJvCNIGHHLvlYIBWck3kN0i8kr6C0gFOfXTFqCS8Mt8UmFa0
	6l7HTQbM2lN9ahyCz4Zy8dk4DMzEnL8+GaBlJ4U3cgw+21+Jwd+LRsLaLPMI6mS6T4P1dC9dEmx
	iLcYNA1v8EneC1o5Fkonehx+G+hzOvfn7ffvLIveC
X-Google-Smtp-Source: AGHT+IG4CU6PIGTRWVZ/exmiFxaCIHcMCynGKkTou1LrcGseTlybIrqBrx6wU87ZXTth0SWqk9/TPw==
X-Received: by 2002:a53:ad49:0:b0:600:f59f:781c with SMTP id 956f58d0204a3-6102967e7e6mr12437876d50.35.1757555267204;
        Wed, 10 Sep 2025 18:47:47 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6247cbed5bdsm99334d50.1.2025.09.10.18.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:46 -0700 (PDT)
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
Subject: [PATCH net-next v11 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 10 Sep 2025 18:47:14 -0700
Message-ID: <20250911014735.118695-7-daniel.zahka@gmail.com>
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
index ca06430d5145..1c3e1f404dc7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2973,28 +2973,6 @@ sk_requests_wifi_status(struct sock *sk)
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
index 1d1650d9ecff..3be07bc77cca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3907,6 +3907,28 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
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
2.47.3


