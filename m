Return-Path: <netdev+bounces-203451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B046BAF5FA0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F2520E85
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F20303DC6;
	Wed,  2 Jul 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIcY25QY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76198301154
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476417; cv=none; b=nY0o0RVztoQ96lExvAJCHq8OmsyHSAHcC0HNCii8JzCNrhwI4tPVwMqchmMRW6c6mAbTNuX7o9tW7pGN5WcsAXwXTwsaromU84RNWbkz770a8VGz9Hf7qt7B+NO0wHMW89l7CAk08Ce1A/eROoXNHBExipxrAPZdUY8oZT3vvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476417; c=relaxed/simple;
	bh=+B2d4mBJ3FPXpWmhLb3PD3aZYFi6cwt6IzL342vJXq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+KXoE8rTbzkV1zAJROIMn2k8A14P8ReF+mdml71sI08WJq7w5hElzpEbrvRvIVQetWANjZ+hh+MxcFj9Rgv0n/2y+svdzUsQPoRQe/YH3xuaUWsdqMeUeFdKYz1uXVfeYpH6WH7LoK7IPtWQz72SPEbAynftkvHIGiS5CRx/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIcY25QY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e81f311a86fso5556063276.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476414; x=1752081214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qySqi/DqJ0LtnRUqE9U9yOnY0H+P2gghWTalUAO6eYk=;
        b=mIcY25QYZM9mT2tO3gD9B3mPTzWRc8hfx5ISWbEeo/SIuJj1VcleWWN1sfsUedT9Gm
         6dWGCyka+bcz2Ri4XVkpKYQWdNiCFXsXINToT8YIH2A0vpn/kH0AZERryYKO+SjT5gss
         ZVh8+eB/F4qUxIiSMSCnc3Ojr/eHG4mnFtdoVa1DJTRlYRy04NkBOkaPscSXjYqezwDF
         N8V890xMRTwTHxTse3sU6bsNb6ZhYQ8bMWV3AjD+enznsm4fauBtZu7ca/NdjdhwJRqV
         hZbRHxkkq1gQXsd0AdZf6YPd4DZ+RihiB31wSR2mzLwtDnUuz4kNhrsyvdqSnr/1ZcE9
         eHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476414; x=1752081214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qySqi/DqJ0LtnRUqE9U9yOnY0H+P2gghWTalUAO6eYk=;
        b=lzuZKWTJoCYXPmS3DTVOzyRwtQx+iyM8bP/kAE82z49tinEKXMEBvNjjEKuOBNhYq1
         E1jQJKijw8AKwDV4QIjkiUB0fEvDM2f1RJY11s46oM/7gZvFYPGW9brGgwrx44fFo2mU
         x1wLti0RNydJTFzvbrEQdy0VFrCNp2q78l61ASOCBvA2YXgJmUc7uBrXF3+rk6JN3CXo
         M3vW92N5fljeghea8IdgwUaqTwXT0QUDEfnvetPekQ7aTtYS4C7QzRxdo0vd8PA05OI8
         gbPIcXqmeDD4EwVe+GgerK213De1ZXXi92FK40YK1VjQMe6mUeGvHfC9ltrKNd9kYJK7
         5PLw==
X-Forwarded-Encrypted: i=1; AJvYcCX+hM0p8lFSF5HQX1x7W7zeippMCjN0tvyEBreXW/bwhEWI7d+3B6gpRX/kq7JHBhTndRrqz0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1s+1EqsYA+f/frpxNzgJBkL6a6X90+mKHxERHuAtzXyJwZ1w
	/3KGSJ/LG4Q/NMXJyPdszSQDP3wOixUG6eQ4u7b/nxI+S8tBivnO9hv+
X-Gm-Gg: ASbGnctT8Pl4i2OuaxV8u9cuXe4jSwxQ+s0FhMk5rqBArcsuOzQ7Fe1XT2msfSWHOrQ
	jntp2uie5OmbP+/3R0iCJRwFcQ23ZVBxyLdUIAy/kPfMa84HvHpPktSxKCcQMrimmclWbAjBb/Q
	wcnfJwrY74qNdvWptuI0cpfnrjgJchg3R6barRXPfRLfJLJwuLIP2rPQ33GNTgvteMeGlj3gunJ
	DyMO+fc+ad77lgwPUOFLnZQfS7mxdXS2srL2Qg2PSpSlowXGOVXwo5NdYAcLLreewRazOnWEFfv
	dAfVZmVaSW+finRebCho/1xaTSbPlUS/wGo1YPDj+AxqIeb5gJzMBz5T4AA=
X-Google-Smtp-Source: AGHT+IEWaJmB/xqgkN8pFmEDsPosE4qOfcD+0he6P6q79Mo4hye1S5+fjZWi23lUujCYg/8sEp2lrA==
X-Received: by 2002:a05:6902:707:b0:e81:88a0:bd0d with SMTP id 3f1490d57ef6-e897e248855mr4838848276.12.1751476414161;
        Wed, 02 Jul 2025 10:13:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6bf1174sm3839059276.52.2025.07.02.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:33 -0700 (PDT)
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
Subject: [PATCH v3 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed,  2 Jul 2025 10:13:11 -0700
Message-ID: <20250702171326.3265825-7-daniel.zahka@gmail.com>
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

Move definition of sk_validate_xmit_skb() from net/core/sock.c to
net/core/dev.c.

This change is in preparation of the next patch, where
sk_validate_xmit_skb() will need to cast sk to a tcp_timewait_sock *,
and access member fields. Including linux/tcp.h from linux/sock.h
creates a circular dependency, and dev.c is the only current call site
of this function.

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


