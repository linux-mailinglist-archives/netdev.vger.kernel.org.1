Return-Path: <netdev+bounces-215224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1DB2DB0A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365637BC9CA
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BB3043BE;
	Wed, 20 Aug 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoqABCAq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1B2F549F
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689491; cv=none; b=ImDmRltyhwo0uhwya0O4bNJLF7B0R7F5enJ05vGO0LqNN+Hu8PVyNLgkz/Axu2EBHp+/RzBtUzjlVmuqZ+mRXBPr8jTE5cdpE+SnWFsLKr7OXRshnIV1DWekLk5B1ButcV2Xjv9IuK4X4jvtSEhFaCUFr3GUxsqLd90g+E6b3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689491; c=relaxed/simple;
	bh=8P4l3wOhAfHGeIhFZ19iNHZQ/aTWQTPTq2fVf+QkyqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFdtLd4HI043DrWwLClHKFHQh+/DXyApwCR6+UPXQBkstdLyTDmywfgeUZq90i3r2qbXBQ9gx8wcEvwFsvYvssDmsfphROOF/TFDoUAv5tidsSCeka2hSE2X9YuunaKpg2jSImgIDzLIgHy6Ay1GNT8sZUD7AWKNqN0LeNa7Qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoqABCAq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e94f5dbf726so776396276.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689489; x=1756294289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdySrbkq4Xjgtfe5WdBAzzgzlXOo79j+f0AEkq30O4A=;
        b=OoqABCAqnuD23uN7yglSGwO0gFXHLDMySBhGyuKtE+BRLZyeBQaH9gCI2fr/6cJuXL
         3pTMwY3iDmj2Bhnmsi2dwU11+/X+Au/WScVFT2OADbLJBnpwktW84OwNjPYda5rw+Bx7
         opZOh9UY3lER3JE+UHGImGPC/r/wiAffAslMpqHbgfXoY0x8RPYgpavHSKaKUTR8sR/O
         LlBA7AHz8q8WwkkieDcNY8mfAHjQVUu5d/1bmvo7gAla+Eq0jvTqxazSUB32/CrT0qvi
         uNN/WzjakyOi6hlLc1yIJjvHY/NNEG91DIOLzpPD2dPZf959/FiT/PU7URxbAYxi7ltI
         ZKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689489; x=1756294289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdySrbkq4Xjgtfe5WdBAzzgzlXOo79j+f0AEkq30O4A=;
        b=O7MumfW8+WUqVOvBA9aWHN1vcMaWFHvEQt9CEYQcEFvkhZzfZBW6i5x77x0qqD763Q
         MDLr7wf1YC0Xh6lEJN9vpOy5GmWGG7672y7DnSxt1Ka8G6YeJFnsVr1SAhgkAMarvL/9
         69MxZK7H9SnlDRvlSK547t429+PaUOrg6X+/12Ne3FKESAGZM38pfu12+gEqpqb7/O8k
         gLKUoasCnDRBI4BmBbsGHjkpBZ0NrhFc++1ode2AzQ7SoifnIBSm6x2T7+ZgJs8z0jF7
         JQ6xW22YGV2XqbUsOJuGy0GfT/5lL09HHT9L//GiOq75UnXelAWYWz+XsSmLeWv38PNa
         wlcg==
X-Forwarded-Encrypted: i=1; AJvYcCXi1EZg9K/TJ1I5cVLDVH9ez1sIHCSy/4YjlfnpzxFlH83LALZjeBQm21W4jjEoyy6P6zrKd9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzy2Fcv+ofJP7TIbik+BbEwJIGtu6rTlilMCQIqsN0igbvUjeH
	eFdt6wMyIFl9V1/VCY7CS9fwGNhB8ejc1EImlQma3cJWme7N/FExcdgLxTLw2g==
X-Gm-Gg: ASbGncso0JIvhcyHhqHCaWvXYTg1xnt3MY0roPznUykw3tSFtDdJC5i+bmzrpmhwyRs
	g2sm4Dwlm0Qn3gtxdvdk+5y3EVnfHxmmigO0g1AIfWvw7Ii/aPWYHrVv9s/kDucy4wpIb5qk9zF
	GKH8/BuIkkhOh/9S8lhJIQ/wKd9Ym2jDFQcGJxJlnt70NHnNcL5zO9Q5pXv2yT854LExiP9OKRP
	I4iQEG3Ytkw0lmjUK7rnZ1IOhNslLB38+1VtJ/MCQebJoG7Gzqp06JGfLYBC0NMGWU3RRtOW7Cx
	/vbmdeqcPt/HlfVgoe9KeesHW2APVw40kt0jlONw+E0utLgNhKzl9QbLGeGjKklv51jKcLTydmo
	mCTLPejq8kXFK0EZV4EFe
X-Google-Smtp-Source: AGHT+IFtOo+D8Pa/5hWm1HkRAPwYLgI/qwIkwa5at+ZILvnjKMirvIVd1XcJ3QY6fUxjyT9Lp9F/LA==
X-Received: by 2002:a05:690c:b86:b0:71c:1592:6ef3 with SMTP id 00721157ae682-71fb30f44aamr32337497b3.12.1755689488498;
        Wed, 20 Aug 2025 04:31:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e068a37sm35747697b3.41.2025.08.20.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:27 -0700 (PDT)
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
Subject: [PATCH net-next v7 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 20 Aug 2025 04:31:04 -0700
Message-ID: <20250820113120.992829-7-daniel.zahka@gmail.com>
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
index 5a3c0f40a93f..6a15ba76f558 100644
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
2.47.3


