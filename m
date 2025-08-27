Return-Path: <netdev+bounces-217353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB23B3870D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD41220880B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1A3093CE;
	Wed, 27 Aug 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISOeqd/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE32FABE9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310031; cv=none; b=EshD7/Wh6hcctSV4msETSN2B+JvxROSmDPwVgd+uDeDepVbwGaLnH6WDjSP8ixwCnNrkwWo32TQ8wXWB0cvyzpI88JcxvvWhSZ3vu/lQ6wkCiWVimUOi1fT3+T3ShIG9DWEn87Hw1ouC/xdh8+iTrgBEcaksHpDgvnfdpPKu5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310031; c=relaxed/simple;
	bh=br8M0RG8+iM7wzQGL1KehMxDjNrgdHOY2rKZVdDDTSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfpLz9RszSbNMqJO5ZEFSfex10YUaHxe2ey5ecmzIbBs68O1YTcChS+34k3Rfhq/6RRxZstDq1itxL6AlEJ4rnpfvcsjw2Lcen6OeY/B9eJX3eb08nabn3KSW2m9aVLH3k/yUfrWmRxH4NiRX3Y9Fsmkty81cM8BiXgHIgoD0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISOeqd/D; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96e5a3b3b3so1410657276.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310029; x=1756914829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l43/vTalGiHGtdwGifZlqUuxeM0lKvHihJgy8y1IcZY=;
        b=ISOeqd/DevxiKbdXUCbsmHZc1onEDMCAZhUoO8gE2iHi4EViwv9nLyiWAzwar2iYRr
         SvKbp6rBCH1xqmy1SmQjvtNM8LEPX78taqrUl39VYC0YefBb4EDnxnGewVztOkO5feZf
         jpCj1NXwJpnSyEtxHqKAePKc9gCezdlDP6TMb+1rGsmGRY2ef7Q6GaFv1hRsNT+XF4Sk
         UYMhGEtEcwuOQ9aScZouXQDz+gKKSxgOuEaRrPLiXNWnPnUBzjk2+107myigaVgaiC2m
         fzBtgUl6Oj18E0nV8LE9NRwJuozQLdeWGf24a/R7aAuJIngIO6oJG9IXjw0C3/xy0u7g
         Es4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310029; x=1756914829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l43/vTalGiHGtdwGifZlqUuxeM0lKvHihJgy8y1IcZY=;
        b=pVOrwdEQpFvO3zdPYWZIX6jn0DalBdnYRBhhGygcT1+M3WonnC5DM3kYgOMON6iUvo
         24ni/vaEqOrjbmAiOJyWHamo3LveQG+IUsuxrJaOo4oKSi5JinV0FsJgo2IpJBXvuoIc
         Vuz7EiEqbshDMI81t1I96sqnlmGAzraZ6dYlZtmx8yAXG5rEMPJMr3CXT2wJzPRKIRId
         R6dK5pd1d0EGHfvQU6fgPZFxZatpev4TbiwyIrYm0rKp7ly15KIubPCQoCyDbUZ/flv5
         W+zieXzyKygfXqV3A8rRA0p0wQXSXk0yj1o5u5DMRWX7YgurYbawGkL4quaofrYNgH5Z
         /Rgw==
X-Forwarded-Encrypted: i=1; AJvYcCWyVVnGnIZ6fjjLCKCdJ0tJknhUBfzKBvoBmc9vZ6MIY++wzbfdicE1Sv+26GToaXBxw1xezbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgAqUoOPfkyEp3ayRYW6pFnYXR0S2unIJB9utbptb3296xUUE
	qZDv/hSLPu3gpyjKpD5oasU+6iz8lP0zOBM4+DhJ733bOoZrvNJgM0k7
X-Gm-Gg: ASbGncv6VQW/2Ete8Od6mRxvRxb/CDbR7agz7rhPdshH3MRi2eEVVm2die2oEUZC4wB
	wjwvQBR9wYXQ4OWazfjQTRuQ5tzeDaNxzM5ibWvxPtdI7wqqZXwUSXdUqIZKAYAgEkaSmIXaVcH
	WraMBRnKNWKBpJNCmc1/xbsC9nvdIYaOMUEFeaBIkMqpi9ogheR6x4RaBQEY58M31BIVxZo5lmJ
	DcsQMM7a3p/5DlPwBq0cyljDXji6ZBww4W5og6tIuinyHrPYpzA2S3gnUNyf4q59WlF9Zo8VZKR
	nYOXUMSdrxrobeD/YGOrPZxiRhgkT/ZQm9tYaVQ5+9nWsgAEILwLZqtqSpVs5HhM7fV7zGVzXqc
	KAzDfLBeNM/sw6Et13VU=
X-Google-Smtp-Source: AGHT+IFOGRMbPz73fV24s8GxI2Px8zL4J3JfoD656kA/XryrobFJ7uGhevj3mVuZMudQJppTFvdUzw==
X-Received: by 2002:a05:690c:6d07:b0:71e:84d6:afc4 with SMTP id 00721157ae682-71fdc2e296emr225109537b3.14.1756310028578;
        Wed, 27 Aug 2025 08:53:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1703280sm32106297b3.13.2025.08.27.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:47 -0700 (PDT)
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
Subject: [PATCH net-next v9 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 27 Aug 2025 08:53:23 -0700
Message-ID: <20250827155340.2738246-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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
index e589eef6ce0f..a997b8af93ad 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2916,28 +2916,6 @@ sk_requests_wifi_status(struct sock *sk)
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
index 93a25d87b86b..979f04da94c9 100644
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


