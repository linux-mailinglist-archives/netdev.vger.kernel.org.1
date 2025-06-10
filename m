Return-Path: <netdev+bounces-196227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A4AD3F00
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D57AE5C4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9B241CB6;
	Tue, 10 Jun 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7/g6eZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B71A8F97;
	Tue, 10 Jun 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573122; cv=none; b=Ya35C+aLUbeFuRhKXy1/xlkRQJgDOgA99BnnTYMgxJcjw3uPvxYUYJPz0kOcoJYE25u9yXPVn439IFq1Rge6bXuxDBWWuJV6ytjUziTzk1lruUcwaBwlEERdWP2319WGJirDty377jATLbkXyazNcxx7xvG8BxrF+rYf+SXVG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573122; c=relaxed/simple;
	bh=oKuUnJOdyTt5QYsKpDJmDQ0Ynue2bYZJHgtQKoIC8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ql8uxlJIshEz8ySHO+nGq3LytYcuLpD601dQGF6IvBnDAZ9w56VDkJlGDXFaR5F1U0LUkavYK8AlXwZUS2Q8GB4a4hfrtw+fSrggLKfWkPPNUX3XieOqO3JL1Nsbw91eZmL84e6xJoG7obJu4thrrycAzyZHW/zjjdpJWRY9ALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7/g6eZH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45310223677so21306805e9.0;
        Tue, 10 Jun 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573119; x=1750177919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ffzMm8LX4nteEPEkWfILdrn8NvmPzDjtR4ORcwrVM=;
        b=e7/g6eZHMMPo96MBScSdKF96y21vwwKgtVqkon3Ge/30FfhjVza3vhk5VmCl1fK/Vs
         WZBCg3FhgXx5XnXP91OB+BzKjLT3BLA6vkwJqDUKkQrEIUe1DeRUKPJBzzEHk4fF0UYW
         BoTx8uUkq2WeBnfiLlEumBAwyQwYDXzquT7sYWQ6ad6/mHZzCKa9WcwsM7RGe2eqUUoC
         ibVKC85S9TMYgNUws1/2CEyEeCoS13x8Vw6UfsLLjWenVld62i7kLvB1fPifBgprbbwA
         L/m9WxcidIHod39Ovm15e8voI6YXeNB6Jjj7tinaPLt/54GLazk5GoNBu6wRQbKwzx1w
         fj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573119; x=1750177919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5ffzMm8LX4nteEPEkWfILdrn8NvmPzDjtR4ORcwrVM=;
        b=RaljsGKxIFyEJCQYMygw2DdRHqvWjM8rO6g5VqujxfvQUjes0PUuwKaivLUdkkrJl/
         YowZeKxWxd+LoJ7NzHBpObVrIVbB2b9sfWBBm8QiJlljKopBrQsth3+aqdN9EEff7VAY
         e78Dv+z7AJYpa66T5bxkpvhXBU5/try2X2JnzlB8mPxkw+YwL6hvQTRF4NDvYvcuBizA
         sh7efAu36QJSbjtlRPARF+WrG1mGCmIMVm/1Vq1oGBmOY8wze195I5NbbyvI5scf8KSr
         b9g8a7VJ47RAPUWrVuxIXxx2X48rA06qADPRewBJREi8F/m4a8Mhb2A19BQlUqyGDV1x
         LYbg==
X-Forwarded-Encrypted: i=1; AJvYcCVOAmfrAQZGXO/vhrFJ358gLQIScy9Y4718SyidwHWoqqWfPueWKgm5WDQGxbbdTd2vXNenCmuIS4cBnio=@vger.kernel.org, AJvYcCXzsxHIPklRIiDRPKDNZKctJWwZzKp7oyeausvkNcj9FlizHO9UBilAPd1O0ZeDk+3IVvtiRciT@vger.kernel.org
X-Gm-Message-State: AOJu0YyUU78ioSCl8o8Qbw9VoARs2ZfpM69MuI8AgQDfrrM2P25fE290
	uw38EugYO0KQuzu6BRlA83+AjysN3npwmW9M7+7O9fsaMmGRBi2YTCa1
X-Gm-Gg: ASbGnctKoxPdywc4xHvarx+Bsli+M5ZndZOcVY2N/V3l9BK+OVI0f7bjFRsog/6g4eu
	7frHZq249PDUx10ktHccRhfFOH4V0N27+YYR0qORFW9jHgwXx1Zo9ziXWNpG8bi01QIvI6xKKLQ
	C/9Ly5piOfjSrhiNHL9TLv1m5HyZdaLGlWEE+p6v3g+7OOdvhN//2Z1IPxOoWoQqpE1l6xrSNqf
	eLubyOgrxGaIzz4+NiV3ru1zr0eKxOTnprFN5I5QgP7sH9scJdm3RnWrigN0D+v7ujQ6bxUKN+3
	d2OQpJncPo+eE9ZX6YH8fyJaIZrVc/prGq5TxXWHuuxyTattW5luJ8iguGOTmzGR8SjSLOHOlI7
	fU13PKl/KHBdmYgg16o6qox8DkSgItD6ZI7HDjzUAneOZ37rKe38jGiuAsgy4f4urVHTyyQdxmA
	==
X-Google-Smtp-Source: AGHT+IG7RDzEfCGQ0NntVerhKNXz/vrfGnXLmtVGkkM/4pDSXycLY06qXCjC2dsrqoOp7Bm3GiHYvA==
X-Received: by 2002:a05:600c:8b67:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-45201364da5mr151645115e9.6.1749573118477;
        Tue, 10 Jun 2025 09:31:58 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1900-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fa6sm12494857f8f.48.2025.06.10.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:31:57 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v2 1/3] net: dsa: tag_brcm: legacy: reorganize functions
Date: Tue, 10 Jun 2025 18:31:52 +0200
Message-Id: <20250610163154.281454-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610163154.281454-1-noltari@gmail.com>
References: <20250610163154.281454-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move brcm_leg_tag_rcv() definition to top.
This function is going to be shared between two different tags.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 net/dsa/tag_brcm.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

 v2: no changes

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index fe75821623a4f..9f4b0bcd95cde 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -213,6 +213,38 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM, BRCM_NAME);
 #endif
 
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY)
+static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
+					struct net_device *dev)
+{
+	int len = BRCM_LEG_TAG_LEN;
+	int source_port;
+	u8 *brcm_tag;
+
+	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
+		return NULL;
+
+	brcm_tag = dsa_etype_header_pos_rx(skb);
+
+	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
+
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
+	if (!skb->dev)
+		return NULL;
+
+	/* VLAN tag is added by BCM63xx internal switch */
+	if (netdev_uses_dsa(skb->dev))
+		len += VLAN_HLEN;
+
+	/* Remove Broadcom tag and update checksum */
+	skb_pull_rcsum(skb, len);
+
+	dsa_default_offload_fwd_mark(skb);
+
+	dsa_strip_etype_header(skb, len);
+
+	return skb;
+}
+
 static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
@@ -250,38 +282,6 @@ static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 	return skb;
 }
 
-static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
-					struct net_device *dev)
-{
-	int len = BRCM_LEG_TAG_LEN;
-	int source_port;
-	u8 *brcm_tag;
-
-	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
-		return NULL;
-
-	brcm_tag = dsa_etype_header_pos_rx(skb);
-
-	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
-
-	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
-		return NULL;
-
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
-		len += VLAN_HLEN;
-
-	/* Remove Broadcom tag and update checksum */
-	skb_pull_rcsum(skb, len);
-
-	dsa_default_offload_fwd_mark(skb);
-
-	dsa_strip_etype_header(skb, len);
-
-	return skb;
-}
-
 static const struct dsa_device_ops brcm_legacy_netdev_ops = {
 	.name = BRCM_LEGACY_NAME,
 	.proto = DSA_TAG_PROTO_BRCM_LEGACY,
-- 
2.39.5


