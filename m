Return-Path: <netdev+bounces-116564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8A94AF36
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28FB283777
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3C13DBB3;
	Wed,  7 Aug 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N9AXgb5d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7F13D25E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053325; cv=none; b=F3B+ifVMr1xSFg2qdRVn7/6JwTvopUE20rr1l2W8Zr87n6YyxOnP0RrRqgh0Xu6NTVvgmhCJ6N5Dhz9Q27qKKneVjrBSvoE+6EQq9AZMbCyItN5N5IoThY9NqesJVBLGuQRBSo+GSMNNmLBSSgBlbYS+t7O18bW6iC/UkxdL6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053325; c=relaxed/simple;
	bh=HaEwFXksDi/dpM2Vlw0p5y2x3N5buakJ/EJUfn/tr8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+zYeuQRC328luG9SM+58NDHpsAK5eJ8zdG45nwY0KQQbtGJ7tVtdKCi0XF7QQ7MrbhA2SkCkHoot1axbOGKJn4iAvVrBk4wctRQSkSXOK8ToXstibHIJZiYUjDUsj2+6atQckBfl47GDosaYAz397c8R0WsJPNAUyrAa7vDCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N9AXgb5d; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62570fso82932a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723053322; x=1723658122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79ak/F+8KlAbfdZYEbeWqf86QQ62ng9RoPRjUoCpeD8=;
        b=N9AXgb5dqGKsDbFHvutbliaiTs5yyZV5Kz4f+HOPvL7YYsNw0NCM+yjkdyoiQG8kWK
         kWclvIbBMSZhmwOhcQS2/BRnX2jhU9sWNs4f6xoUtsONWpxlWsWIa3BR1XlOyViPu6X/
         JpbWoxU6Ji38lyZbfy8Jij/eB5DA1hRp/GZLHr7EaiGuVIK9pdvNmIEeOujym9awnzFh
         QzsXV+XcrIyJoYNPjAmrrbbHMZWOKVDUtZF0iV1z3sAGkoD7ucvm8FX1pwbGbC33Np1O
         6eTDgxd4iGCHiGfF9Apu2c3WOObCXRPLtp39oC7c9diL6kxrZ/CFNO8Lu77pbQ5Xrwmg
         9Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053322; x=1723658122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79ak/F+8KlAbfdZYEbeWqf86QQ62ng9RoPRjUoCpeD8=;
        b=V7aS23DDkMW7EF9m2UXT3zs+cL8cK4jtARDsm8D9shuceGZxd+os9Y8dVaj3hOxb7x
         AsDi+GDcEBX1id2lNmdeo3HIOA98ugSZznqdT1SI+gSlPU6fJi1iOKt/tG97miqQKxVX
         Gi74y2lju5EH2DrIlcxLPmLhg8PDHi3sOX+mMGIgGoqrIhDq3cSejRYlHeLWuutFeaUE
         3bzkE2f61F6T45u3QeaDKeWAimkWA/qsAjVR6VY1RkKMb3p9fdGrWCYpAn4KjBuI/aa6
         nrIpeVkfR12xURLUbmAH2ghTsma8ZOpLuVcqGsjlLYE1lR/K9QNztLpGf4AkgJwhTpI3
         feSA==
X-Gm-Message-State: AOJu0YxwXkCFNMNErSKO/Dny9AN0MFEVqf29jU9aShVCvUB1tAM7IiHS
	ku8aiZld8ti1B2MWAIZlfPrHUs3p3Aq0GCQX+tYgLEAARJEiFvkqvHRWUkF0JnQCsASitnB6bS7
	V
X-Google-Smtp-Source: AGHT+IGL/D+Aw/TseYvGsEOgkIJocJ3XTdrutxyaAgKrHflxXvpi9XmTbP+VNCLDqqG+vdykEp7MLA==
X-Received: by 2002:aa7:cd98:0:b0:5a3:8c9:3c1d with SMTP id 4fb4d7f45d1cf-5b7f3bcfc21mr13077844a12.14.1723053322070;
        Wed, 07 Aug 2024 10:55:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3b99dsm7198710a12.91.2024.08.07.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:55:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Aug 2024 19:55:03 +0200
Subject: [PATCH net v3 1/3] net: Make USO depend on CSUM offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-udp-gso-egress-from-tunnel-v3-1-8828d93c5b45@cloudflare.com>
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
In-Reply-To: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.14.1

UDP segmentation offload inherently depends on checksum offload. It should
not be possible to disable checksum offload while leaving USO enabled.
Enforce this dependency in code.

There is a single tx-udp-segmentation feature flag to indicate support for
both IPv4/6, hence the devices wishing to support USO must offer checksum
offload for both IP versions.

Fixes: 83aa025f535f ("udp: add gso support to virtual devices")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..dfb12164b35d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9912,6 +9912,16 @@ static void netdev_sync_lower_features(struct net_device *upper,
 	}
 }
 
+#define IP_CSUM_MASK (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)
+
+static bool has_ip_or_hw_csum(netdev_features_t features)
+{
+	bool ip_csum = (features & IP_CSUM_MASK) == IP_CSUM_MASK;
+	bool hw_csum = features & NETIF_F_HW_CSUM;
+
+	return ip_csum || hw_csum;
+}
+
 static netdev_features_t netdev_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
@@ -9993,15 +10003,9 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_LRO;
 	}
 
-	if (features & NETIF_F_HW_TLS_TX) {
-		bool ip_csum = (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) ==
-			(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-		bool hw_csum = features & NETIF_F_HW_CSUM;
-
-		if (!ip_csum && !hw_csum) {
-			netdev_dbg(dev, "Dropping TLS TX HW offload feature since no CSUM feature.\n");
-			features &= ~NETIF_F_HW_TLS_TX;
-		}
+	if ((features & NETIF_F_HW_TLS_TX) && !has_ip_or_hw_csum(features)) {
+		netdev_dbg(dev, "Dropping TLS TX HW offload feature since no CSUM feature.\n");
+		features &= ~NETIF_F_HW_TLS_TX;
 	}
 
 	if ((features & NETIF_F_HW_TLS_RX) && !(features & NETIF_F_RXCSUM)) {
@@ -10009,6 +10013,11 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_HW_TLS_RX;
 	}
 
+	if ((features & NETIF_F_GSO_UDP_L4) && !has_ip_or_hw_csum(features)) {
+		netdev_dbg(dev, "Dropping USO feature since no CSUM feature.\n");
+		features &= ~NETIF_F_GSO_UDP_L4;
+	}
+
 	return features;
 }
 

-- 
2.40.1


