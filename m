Return-Path: <netdev+bounces-116770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86694BA2D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D30B218DA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDF189BA7;
	Thu,  8 Aug 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XP3Rbl+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8578274
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111001; cv=none; b=Iv5L7n2GircICd+PSOO6/Qu6mIKx1/Eb0jc0vHvfvtorsjyvX27er10JD1gO6zlh5VcWSd+3O8G2NnWVmy+qBFRLtMEu3lhuV0Q8m+9vBOfi6pBeAT7ffczdk0EylYLeDyJoQ2PAei6dFC5pXEeZfF7ZO38iUuEFib/xxc0mcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111001; c=relaxed/simple;
	bh=IesTJSlpzunGzqUhDiLb2/aTmTP8Z/4m62dDm1ScgbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6Uhwi4QMT2Rvrs6eHtiXB/FTlhYRtaTfuQzQbTNOnw/hJXOCW7EcKwVfbgH59h3VC4hzbKtRR7L76BT1tr7veZfHzcqLsVgFiRwc/LSrmAs2hKnx6XBk/wEKdSxLhAdpZw+dW01gxAldBxhi9V3Qs4uYOw9kb8f59mXeAk9fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XP3Rbl+8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so969756a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723110997; x=1723715797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjmg7XmZ9J2NGEjY7Od9fvedwGn3CBQ0UvYKrnNEzGk=;
        b=XP3Rbl+8OBiXYqVsTMRuycvCtUG1yIdP3/NNjE/hW7zLVUBR8+Ba9TSBzmLE6piMRa
         gaiKOD/aZZs1DQOM3Y/8BcHBybD0zLA0PBBUz8uMGHbs2JEIAbr21kj2dtFq4RJG5hqT
         smmNeDs+bpOJ2CPaoNbgrj3Y5ZI1V1LiHYN3KG0Z8rT+d/F6/wSAoToekMzBCP2FRsqT
         2lYL9mstuMkqJANHgw+gSXcxr1HNWixZ7pK9eqOWuc6fLxDds1h/rS/MINpPBpCbtqPA
         5/Y7sEthqt5FOjTaE2HzEmUKLDKka27z8WhqS6haokTer1wLGGm4cHo2ZKOgkFNFquTw
         /8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110997; x=1723715797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjmg7XmZ9J2NGEjY7Od9fvedwGn3CBQ0UvYKrnNEzGk=;
        b=oxzESZQgzSrLuidhHEDJrmmWWzJK3AKgKwDPuKxUlLF578R7QXdWoLx5kE30XZyBCU
         JyHgWVo65/EH7+P2YTgpif0fgEo4u6HFLb0TIOhUWENdphSGhyX94sLJbm0M88t7yXTv
         kiItleF+gCkYUL0WvpEIuNfsfBd7XS5zUQ1XLYXdIYUb9L1p90Ks3SOx4MDh89z/bTU/
         cmU3mkwYTJXXYeM4/OG6+GS1ft7JiIDkBgKTNC08FHq+sUQqVcoUa3o3/jd7TedkXfHm
         VNa8tC+szHP0nwt/gUF44agKvCfymmyau3suJ/23xsmeQRp2I9OYraIjw9gCfW7mDYa5
         /dyA==
X-Gm-Message-State: AOJu0Yxfsdw9jq08dZvkSuR6tay04cwuF+RfunGvG4fBROqkTt9NJ4dK
	iuDaNXpKDNsoa5jyYm70kNGR9jvoqfTZMSrat1tvdqWmroKwpq2Qv3EODbVcBQP01JIpzuiPsP4
	t
X-Google-Smtp-Source: AGHT+IEHpd4x6DntDYbd75DeSaFwzZ2xaP+OtonlPRRk4Sp3fKCzz8y3ShIBABl/tHyV0+9w/GblxQ==
X-Received: by 2002:a17:907:9619:b0:a77:e48d:bc8 with SMTP id a640c23a62f3a-a8090c849afmr121649466b.21.1723110997657;
        Thu, 08 Aug 2024 02:56:37 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9da0sm722834666b.29.2024.08.08.02.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:56:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 08 Aug 2024 11:56:21 +0200
Subject: [PATCH net v4 1/3] net: Make USO depend on CSUM offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-udp-gso-egress-from-tunnel-v4-1-f5c5b4149ab9@cloudflare.com>
References: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
In-Reply-To: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

UDP segmentation offload inherently depends on checksum offload. It should
not be possible to disable checksum offload while leaving USO enabled.
Enforce this dependency in code.

There is a single tx-udp-segmentation feature flag to indicate support for
both IPv4/6, hence the devices wishing to support USO must offer checksum
offload for both IP versions.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..f66e61407883 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9912,6 +9912,15 @@ static void netdev_sync_lower_features(struct net_device *upper,
 	}
 }
 
+static bool netdev_has_ip_or_hw_csum(netdev_features_t features)
+{
+	netdev_features_t ip_csum_mask = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	bool ip_csum = (features & ip_csum_mask) == ip_csum_mask;
+	bool hw_csum = features & NETIF_F_HW_CSUM;
+
+	return ip_csum || hw_csum;
+}
+
 static netdev_features_t netdev_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
@@ -9993,15 +10002,9 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
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
+	if ((features & NETIF_F_HW_TLS_TX) && !netdev_has_ip_or_hw_csum(features)) {
+		netdev_dbg(dev, "Dropping TLS TX HW offload feature since no CSUM feature.\n");
+		features &= ~NETIF_F_HW_TLS_TX;
 	}
 
 	if ((features & NETIF_F_HW_TLS_RX) && !(features & NETIF_F_RXCSUM)) {
@@ -10009,6 +10012,11 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_HW_TLS_RX;
 	}
 
+	if ((features & NETIF_F_GSO_UDP_L4) && !netdev_has_ip_or_hw_csum(features)) {
+		netdev_dbg(dev, "Dropping USO feature since no CSUM feature.\n");
+		features &= ~NETIF_F_GSO_UDP_L4;
+	}
+
 	return features;
 }
 

-- 
2.40.1


