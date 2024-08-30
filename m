Return-Path: <netdev+bounces-123552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDA9654F8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D51F24C53
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F77BB14;
	Fri, 30 Aug 2024 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0B8vbkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65471742;
	Fri, 30 Aug 2024 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983358; cv=none; b=NhzOnmBk4jX8iKlgfQ5OxYuIoccAqTQrNkPoMtKnsyZtZMmzvifm44N0Bm3g+ji46NWHQN6YkeTdVTx75ErC+foftDE8NTxNM5HAMB54UfK8u6Aa7CB6Oh+JELmnkRocJIuIAtiPF6ZuG+vznz3cEUPdzS58a2WTrLv0CBv7m4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983358; c=relaxed/simple;
	bh=3VmzH17Bhak8BEL9MhIovK/bRrLmZlG8N4KAYQwjE10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoJL17cn2wD+hJjnD8rtS9krkhaeQbyqytPfwwf5Awi0ZmQFMOZrCwr2vMG1QnZpQ4dwcZTobZdQpxi+08D5ojmXOWwrzC7lZp2DCmfhE5TtclaKfgxtKmC0ZCiXLVRU6nKJzbDnqsZ01RYy2meaTblKYkQS6YlgKX7SOiwGH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0B8vbkh; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-273cf2dbf7dso739198fac.1;
        Thu, 29 Aug 2024 19:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983356; x=1725588156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9mW2xX98zUSnOtqzxw2x7w49udx/6KrmxEjXJ5Yn7w=;
        b=W0B8vbkh2mbkvfl8T7/Lx9ZksVGA4+BaBgmLARh6zO1iBfCeQpSCGiU7UZGrBaIVNe
         PZj2BiCRSkBO6UqptG0bqpGt+496F/URvugk7NyagfK4e4GQpa1CVdXdRfDuB3DtK0Hh
         nDxu6WYBrbYo7xCXlubn/TDu9d9MQO11IswDnatoVw7Hyta3isVtRQcIrXT3Ou9qzq0Z
         EC0lrWeRPjQRsRqG93BWEUlwBinqDKIpUFYbDbxYe8PSrta258NoAgfgwHUo9jGR43Ih
         spY5vQUU7JtKRdoqZYyqTyT2rMqY33vDyj+mUedQQ0biV28RgC5qkPLaz25Ya2/iDyG/
         X7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983356; x=1725588156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9mW2xX98zUSnOtqzxw2x7w49udx/6KrmxEjXJ5Yn7w=;
        b=f5hiUlO77fwajc/V1bshBsBST+dtHtvZwaTCFtTP7wrerk0q3k8Yuu1VFIkfbygW5x
         +6RpKWBvdkyRVIyiVD0klJbFp1WHcdxXD//4+m9KLCBubxtaHe6snLnWUbHeaT1Owm3c
         LUY4C60xeffqk5myMxZWy7q08b9o8RmzeDgLr55EZq8zZLMFQyqiRvsQhGgMvXn3ZBn/
         TAWFXn6pcA2swesH2Z/fAnvqRHJvtmFEM3wWPsp00vqH0ql/eiAlAeDUkyc31Wi69hvb
         ZrI+QsE6u3j7FLtpaJN7ln/PnuocxqNIx0RyYagQFIe7KZh4YJsNgqYsS4NmARNJSfFc
         ty0w==
X-Forwarded-Encrypted: i=1; AJvYcCV+7ZOh+CGBd59nnBwRAmi/Gxj7ZIPTkvHhnfoBU5uLjLL1MGr7YmWFnuu2JpXpWCkK8tb/LPBf@vger.kernel.org, AJvYcCWNzcV7J6jHEbQR64/qC8SY4wdYQKFtGObvq2TR/my6ppbnZ/dD/rqZi/wPPpB6NnX+hlkcZ6Yhn4KIUGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi65CYbzZa02yIILBFzDUtc23FGwLVjJKejvOUt2VrmacZ2/p0
	8g28Fj+HdjT4PAIvtRC5A4xTdXr9ZfPW8dqkCQN+D8URWE2sX6xm
X-Google-Smtp-Source: AGHT+IEcWxj+Mw5B/xtcrEbcXL+/ABGHL+89DOxNHzAmFTeBBlJ+YQWKaz8nmX24ejZiOH5826aEMA==
X-Received: by 2002:a05:6870:910b:b0:270:2063:f166 with SMTP id 586e51a60fabf-2779012b632mr5049508fac.23.1724983356267;
        Thu, 29 Aug 2024 19:02:36 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:35 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 04/12] net: tunnel: add skb_vlan_inet_prepare_reason() helper
Date: Fri, 30 Aug 2024 09:59:53 +0800
Message-Id: <20240830020001.79377-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function skb_vlan_inet_prepare_reason() and make
skb_vlan_inet_prepare an inline call to it. The drop reasons of it just
come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/ip_tunnels.h | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7fc2f7bf837a..90f8d1510a76 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -465,13 +465,14 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
-/* Variant of pskb_inet_may_pull().
+/* Variant of pskb_inet_may_pull_reason().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -492,11 +493,19 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+	return SKB_NOT_DROPPED_YET;
+}
+
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
+					 bool inner_proto_inherit)
+{
+	return skb_vlan_inet_prepare_reason(skb, inner_proto_inherit) ==
+		SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
-- 
2.39.2


