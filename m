Return-Path: <netdev+bounces-201170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E25BAE8538
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAC16F84A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85326563C;
	Wed, 25 Jun 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzjkQwVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17173264A9C
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859541; cv=none; b=leuVaua9PYERKKh1rnymLuiBMMhZ2h+qIw4F20E32H4TZ4VN5u+a1/sr7xR3Jilm79ZITvjkVqH1BBTGIte84ftA97utl7XoY6Wi4yLWNFi/U3pW/4YJrhPM2LgtgNqmkETVymlbTwY3MVzzHppees/zvW5zS9CazeTF1OCMHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859541; c=relaxed/simple;
	bh=+B2d4mBJ3FPXpWmhLb3PD3aZYFi6cwt6IzL342vJXq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvHJgp8lfMjHYwKTHvhSajsmvSPB5F47mSgUYvSk/BZ2blUD3qkz8iJ7RZFB1lHDMJ9ojrtUwC7hdYUtmhuTUgVNxbw7BdTAwnqFocEtuAENN08RAEVLgqUlao/L2NEGV4gj1onIBP3VkfcHDEbJtSo1bplJOXVFknhAizNzhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzjkQwVp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-712be7e034cso60566687b3.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859539; x=1751464339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qySqi/DqJ0LtnRUqE9U9yOnY0H+P2gghWTalUAO6eYk=;
        b=SzjkQwVpSTz5wNab/P7YPzTCw5HYU+MT+h5xt+eA3oiKSy5ygtyzLoIuYdujkx/HVb
         t0xHTjGHHHTZHkyyq2WabT0ejYqs2sTIsJUrj5+i7BgXysqZEKEiNw8doTS2/wmxETh4
         BDr3oBNMvW8ylvcyuOqV8OsLQ6Ny2TK8iqpr0oWkdUOqhI3dfdtOtaxqnoPY9NSfbN1b
         tHz8Jz3VkDXRGGCgVOoqpX547R1KkXxybrvqQIUmwcPgoA9REkwG+c/XEHDZW5GiKxZR
         oh0NW/4grB+G+P2IZYCgB99EMp+QQaVB8HpFHpvSrAyd2Kpq6xfLT6HpR8CfAswuMnND
         4K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859539; x=1751464339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qySqi/DqJ0LtnRUqE9U9yOnY0H+P2gghWTalUAO6eYk=;
        b=ce+wHPVs/1+DOzJnViOkS2MqH9lCv/bGlXXXW6GfY9b1IvywsaEURrMN+SEbuSqQ9f
         VauekoV8TcU2aPx1NXRLDbw+UY/tG11WTdGErHoQlVt+9N0FBsiMH5wUqN6eGWyjJ/pM
         6GKJmzx7ZKwCVaBOEJ7eLgmdih905ccjsho75yp97E+exfYrAxpV5xg2VGZXNXZPB383
         a7FC+IDNw/+iY1B35rQWXZXCi0xSldXFOl7sH9fVL/m2fhy89cB3pJpG0fU+XuK3WcOs
         0CVLkjdqKLqKyce2jPvv6ie3TcLG22c37nRfZXAuiw1BejowtoYdD/46uEW1ENyXMyiH
         Sh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsUoXX1AXKEQyOpoUrLS2Mg5fws3/87oBp+oyKAW5kEtpIaCoc0QEdGHbDq+0pZsME5oOlHJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97p+YReAWASjUaQRMBIkAztrJMUPwHbveGv6Nh64vv/f6Vmdu
	GcrR0AEhYmi6+1mwiBbqaDNIUyqtbRpfrZiUrwM9NHv1s+WOkgUDXNya
X-Gm-Gg: ASbGnctVxSbwpk9UjX4fjIerEnHJ7iWvUEIeSLe8U18MvZDyHyj0sQJF9+4IXtdJuqG
	Dql+Mxkt/v1o4pYia/ujTKV1YZCkAGbU4ZLeSuKM5pElkgUiUKz/FpOHu8v36RSti8neoUplR1u
	ruO04ljrDO0veX7A4Pj3F/AaTg8LPL2O7JRcyF80e+K6IwiWdQRv8PnPYyXa4050SXO8yGg7L+b
	fRoAR5sy3ADN+gotk3T9A2PJHbKnipAFPFCSu89DQR3hoKei0iyvPMd21pDpUmYzFRlVJfPCuue
	wrn5KFg/0Ik8uBJPqbblGOJRwyIJpSzvnJ0T+2mN8aeJxOyOjSRiGF2urkvA
X-Google-Smtp-Source: AGHT+IHK2mlPUeXH/YYOrGjW/UcNRBEmKQFLpIivhQH3Hae0lrX2WkXjJjpXM96Q3otb4+yAoxCGAw==
X-Received: by 2002:a05:690c:380d:b0:70f:8883:ce60 with SMTP id 00721157ae682-71406dd8d2cmr43423937b3.26.1750859538820;
        Wed, 25 Jun 2025 06:52:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4c1a877sm24337217b3.107.2025.06.25.06.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:18 -0700 (PDT)
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
Subject: [PATCH v2 06/17] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 25 Jun 2025 06:51:56 -0700
Message-ID: <20250625135210.2975231-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
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


