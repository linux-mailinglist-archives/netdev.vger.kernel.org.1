Return-Path: <netdev+bounces-225606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60DB96123
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4384919C3F6C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D61F2C34;
	Tue, 23 Sep 2025 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4h5pn31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE71FECB0
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635279; cv=none; b=GtJETfCPwxqGkTchRdfKavfxmMYTVemyyY1z9JEHfI5pN5sNL4ouQGrjj5h6XDi5bDefZ4RUuJa1BEcLtn29/zGHgiy2m5JrQPrpBgDE+4eUGD9jHAj1jmxxDSBY+lGXAPDXpUsT7gOM9chtFUNmmuRiOUaHjktLh4IcKRWd820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635279; c=relaxed/simple;
	bh=Fgh6vcTQHiGjMzywi4u/CrjnmlucXopxVkU3UXGBw5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd/rosIOJN5NG1w7QMpOc2Yh6cTP5J9V6aRYNBIIHpwVYZ4C6sVsSspEzYzuoAnPdon+4vvpLH5dg2+XLFwXuh0NMDx6e/YZ5AKT1InHzcwwVMTQtgSjFzmblhCAcXxmLO0RNXsdFNBOwWWBdQqp3Tsv4+0DwXGaa2knW21e1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4h5pn31; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso39971045e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635276; x=1759240076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGyCMRDy9c1gTqOLiYHeRr6Mdk5oqJ9qvpfcgGTat/w=;
        b=E4h5pn31PxcQM/8+1GBtnQ+arCHIsjUyeoUi3RJL1IJQaOKNgizVcJzq9CCEC7qt5a
         K9EtdXw794XNvjUvkeJO8F3dtuetUfqP8o1ryD4R4ah5ofeSQZAAtbDfdLj0dKA5bKdK
         cc1oaYI3frgD0QwWvDzsWIim7F6UiASm5uo9OwXqFw4P7vAFLXnRlJ9vtoGv+OtJuHOu
         qcYnb026r5PsjwvjPJ3cGCDJyFAE9jAOr5KKPMC28kDBC09ypC2Hr25dKXjNBbI0P/rJ
         IFft5BuUeoP2m7WB3NmKBUhKgEeVVqzhZhhBtU/T5nKZER6vOFS3MAWgTRiUBfD7T7n8
         Q+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635276; x=1759240076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGyCMRDy9c1gTqOLiYHeRr6Mdk5oqJ9qvpfcgGTat/w=;
        b=aQiR15RD3qR8isyR1r5N09lkYkCfpb0z/4gu0Ndz/27ACI7L6y/h/ZVDfXFByX7FOu
         WxT0pJaXEx8G12Ar/gZyoi/WWwmI5BM+ZjNlR3i/L/d427UYu/l8CRK6XbiILFblnVEI
         smiQP33Ix9gb3KHbCZAPskiWRaxce4Z2GyXI8ZXndgoiMDXDX5/wwNUaVfomrkgW7V1b
         NhUMrwreyYPu34aYgo1UfGPIZJ1C7knUltjvKwE/Zkkrs7iXMDJlNO7WpzetKbTGqFQ/
         +xZGR2qIql1KG0yD9l/Oj3kY93Ts/wLutR1yZHieWV3kmDMsn5EPZyblt0YKffysjVNC
         NIXA==
X-Gm-Message-State: AOJu0YyUBXqYJgw51TdoBdhAexnPLDjeNjHS+Er78/ltISkju4sZ+Xhw
	Gap9gufbYfsbFGilasb37Hfo0XJpEDL5/rfC6HjfYvQhNj547D++eZnU
X-Gm-Gg: ASbGnct/RwFvcwDf/V5oRpX8WZhvQ9Scq8/nHG3QAH7eWvqeMclgRfQWZlCH3l0Kjdd
	Uq8CTChgsQhi8/fWl/YivgdUrTuTENpu49u3ADgEnECmNgsCYVgezs+WxoedDu0NV2LvHU8ADU6
	vAsptf8ypR2qI+sWD6mr9IZwd8sv/mPT4jyvajlsu5bVvhhpOlMrooPM9cmpGS6ClyJM1gY3PJW
	e7ZsH3z030i+W73lnI9Vzm3I27K5mpH/hBgRE6WzFrSSXMd/yPxfTDxapyrdzFJr7YBJ5l37yY+
	m7ilUmtI2RA6fjEW/6F8Ms4r0xYPbQ1B8+Q/GxrsuH6kgbHgDbmvVKZglXSJj3lFpPEQshbDyII
	G4vjbYj5Q1Ecjotk4jnOxZNb9h4FkewLwmbz/8GKsHzwLzr23ROQYtIOPgZs=
X-Google-Smtp-Source: AGHT+IGibEEiNTPPY2197bOlU9rZbgJ9iHGCU04uhx+6G6cWQ85JqbxtoP9eZxWJbWYsWvwknglGgg==
X-Received: by 2002:a05:600c:3b0a:b0:46d:5846:df18 with SMTP id 5b1f17b1804b1-46e1d98cf06mr24593715e9.15.1758635275467;
        Tue, 23 Sep 2025 06:47:55 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc7460sm24390050f8f.31.2025.09.23.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:47:55 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 03/17] net/ipv6: Drop HBH for BIG TCP on RX side
Date: Tue, 23 Sep 2025 16:47:28 +0300
Message-ID: <20250923134742.1399800-4-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

Complementary to the previous commit, stop inserting HBH when building
BIG TCP GRO SKBs.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/core/gro.c         |  2 --
 net/ipv6/ip6_offload.c | 28 +---------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 5ba4504cfd28..3ca3855bedec 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -115,8 +115,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
 		if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
-		    (p->protocol == htons(ETH_P_IPV6) &&
-		     skb_headroom(p) < sizeof(struct hop_jumbo_hdr)) ||
 		    p->encapsulation)
 			return -E2BIG;
 	}
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 6762ce7909c8..e5861089cc80 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -342,40 +342,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	const struct net_offload *ops;
 	struct ipv6hdr *iph;
 	int err = -ENOSYS;
-	u32 payload_len;
 
 	if (skb->encapsulation) {
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
 		skb_set_inner_network_header(skb, nhoff);
 	}
 
-	payload_len = skb->len - nhoff - sizeof(*iph);
-	if (unlikely(payload_len > IPV6_MAXPLEN)) {
-		struct hop_jumbo_hdr *hop_jumbo;
-		int hoplen = sizeof(*hop_jumbo);
-
-		/* Move network header left */
-		memmove(skb_mac_header(skb) - hoplen, skb_mac_header(skb),
-			skb->transport_header - skb->mac_header);
-		skb->data -= hoplen;
-		skb->len += hoplen;
-		skb->mac_header -= hoplen;
-		skb->network_header -= hoplen;
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		hop_jumbo = (struct hop_jumbo_hdr *)(iph + 1);
-
-		/* Build hop-by-hop options */
-		hop_jumbo->nexthdr = iph->nexthdr;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
-
-		iph->nexthdr = NEXTHDR_HOP;
-	}
-
 	iph = (struct ipv6hdr *)(skb->data + nhoff);
-	ipv6_set_payload_len(iph, payload_len);
+	ipv6_set_payload_len(iph, skb->len - nhoff - sizeof(*iph));
 
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-- 
2.50.1


