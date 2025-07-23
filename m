Return-Path: <netdev+bounces-209501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913BB0FB94
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D678C1C82D0A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214A23A9A0;
	Wed, 23 Jul 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWHKl1iZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244B23958A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302907; cv=none; b=EqfRxIds2QtelR0idY2RX7cED6nY66EknjXlOvRvVLveOK7sDybtkanY1SGS+1avlEn86t4G8PZjDTU09wAcXTmcmk11tJpqyCWZbH6JgEFnWSkSRz9AAyT17FK7ju84alrkuvVVpbUc1zA8hKjIq3FC8VMi7kOU5hkcYw49t+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302907; c=relaxed/simple;
	bh=QthgXYQZRXocqOXt5xEqHhW6IaGmVzYa1DVCCon5jVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOD9VGG6y1v4VTl9hkHeFvV+USiJnuMWYdn3p7wW31g2d9gA2kflx7t4CtgzyFBAZoVgGrvHCJQFsXxQoRtk8pFmPkCuMGXKlCxAXbxp1VHxr86EPCHh0NzgkOGctLcIXAs3PX61YQFc/VOgMhtDdzv7rFb7uyuKpbtSwgCMu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWHKl1iZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e5d953c0bso4647497b3.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302904; x=1753907704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOt21C3tkFccBpqLa9kxQtdGM+W+vdqoFxH5fcFsTK8=;
        b=VWHKl1iZoRdaSC17K+wOouvUFr0+nPvDAaT5cmjInxi1gS45vX+tPRFwdGAt5UdTwg
         iWhU2I8AtA0r+XRhbbhgMrfKQvkzfj79iP2uAPO0uiq6tnrsjw+on0N2aI2EISOjEqem
         Gi78Ku0Y1yxslvBDpJIxiJmedgjnn3RSlZrLt6iNx4FVHmphRXaSq38k72tAR9c3ndel
         tLcWB7hgDANltn1ZnFgct3Uqf1JZxn6aGZUe3sIivjHtnOnDzOOZ+Em7yh8OzoRzPN5l
         Gu7H2n5Y3tBhQl5broz79/AKHcayYriaLDOlK9HvNadmmsSu58l3l50UB1bnib4oMMhj
         9fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302904; x=1753907704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOt21C3tkFccBpqLa9kxQtdGM+W+vdqoFxH5fcFsTK8=;
        b=Q5n+AeBAMupzqL8QXx60ierpnyo5Ih83moynTr1h5CF2y1hZsPkMhyScOCngPUGZpi
         TzQke8E9vTrL/KUEzbh1bLGT2uwVCWooQwAaDfum17Bb7EWgUn5al6NduEZl1bYhzrvM
         p5pY3siddt2tEqifTVsDUBqg3DzeLa+4AuaieIhiFARAhLVGTVtHBHye4FGhJ/Uuc8CW
         +il5M0nFHDWedaZG6yb2gCmQ5//fflML2Wv3xGGns3aJ2F8DyMDrknfmPuxdjd/t5ELz
         zo6b+MeEcx2JpFdfItfFsiOhYPXIUXYj8o2KL21f76NsC90TMhAf3kEvNuA+kPDUu1Fx
         hhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtEvr9ACr6e3oAP0DbTJzgSrTj0ybO/JdoV1AaEsihjEXvuyuP95fAt80sEf7iOTjhXN74u+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqH/ujfxBW4Rc3N2UFMjw6Bx7MMGGxrXYUFgnLzUHcuYKfTyK
	bRO6zhUZU+kVPfiO8LIo+7ylnzTOaU1egkIsgL3wuWSu3m4PQnJks6V0
X-Gm-Gg: ASbGncumqan/W8+6yoAQrKW+8sPn8FF3XYquGIn8xfWMAQ3yxMut5CSPFmF/ONh1KZN
	XfaiFlc8WhoWqHyF4cs08LpHUTIqrY+ezLvPi4guCCmO2zSUFr1GV8zjifNzHs6Ccsg63GuCDaM
	JoGJhvzC0ndw4/qrUefOTAfR075am5+R3BFUQmn8dSl9DN9TiOxdqEwDiYpc+cxbfLa8T2g/rE6
	f8VoUdlMxmMfjUbl1eQHlehFRVtMQoZ7TymRl3Nt/mLKjTzg3exFldkTzxb37hKMb09meOD/wJM
	sQrf9977OGB5tTigXg1wcREqqhgTpo2zMd0HBt2Z7yeeuRHFzFJvbGPd5s1z7VEKDxtQSnwb/j0
	KpsgLVwwy22/DD4K1T8I1W5dyQjkOAaw=
X-Google-Smtp-Source: AGHT+IGHn+4541vfncWcMydxc+LxzSmb8L6Md4FVVUrKFV5cIEWCN2XxpIg2M3sifnpxZY4SvFp0LA==
X-Received: by 2002:a05:690c:4d41:b0:70f:83af:7db1 with SMTP id 00721157ae682-719b42e0484mr55683537b3.19.1753302903706;
        Wed, 23 Jul 2025 13:35:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c79bcsm31863897b3.74.2025.07.23.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:03 -0700 (PDT)
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
Subject: [PATCH net-next v5 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Wed, 23 Jul 2025 13:34:17 -0700
Message-ID: <20250723203454.519540-7-daniel.zahka@gmail.com>
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


