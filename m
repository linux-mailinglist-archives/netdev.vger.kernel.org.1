Return-Path: <netdev+bounces-198671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C91ADD043
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436A416CAFE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7882E6D38;
	Tue, 17 Jun 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Qt44u5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A72DF3F7
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171360; cv=none; b=dveG8S8jYKantDXckQ7DcMUJLgIMwwHFn5Es2m/zk0u/Un+wjVl0HkXuFwm1greNuMCQuGy0zl5YaO2JcefQmOzAySiutIw7mgMqkrsQVoL+wCNCLn08ekQOYrKhV2ZdfZtT97mUkjSfoKeqQbPTZJlS/3OaaeaBgEU/TB+8xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171360; c=relaxed/simple;
	bh=Ky37k8rLbSxyRGx6586e5YT3Ux5Id3Q/t6mn54eaOBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzeIshBGfXalEVWKrtatkWQ+XcJEFS3fDsoCWmE8z9Z8dvnATbQRW+/Je3W9OTeEDvmD49uV0x5DIvi9D5jrweyg+S2fUzd/8hOe6oMiYSNQc7hZCPtPjNwewUsEE1NBpaj3XMY4lxQaxXBMQfLbLE1iAsRal8PWgkcIqPkXYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Qt44u5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso10692293a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171356; x=1750776156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT1GJOgOaAVfw+eDwzE42lZB83neWTsqm+FQ7K7TUI8=;
        b=N8Qt44u5Ix7/ZRCTDm/qcAbhkEYbPSMFWTU8+RAuwl/JkTYzXyAY/9pTJpS7Q3CzpC
         jrBd3ysT1yGj4n3ooLGfVxhjUq2hLncAQv2NakX7x3vY05otXSuMI+QLeWbVZBJGX3ph
         d65LuH/bIxabxEFIximw3VitRlZbBCDp4JLnF8ylXdCe4Ow+Q/QQVTOt/szOOMEgVXYk
         2m0+c1G0TVOpDMbEQNe83yiMQhacSIw8JjQZUR+YcKDIqeSYuX+SZXA3yRtpF6C+0MMY
         0Q27f6goC1SOzr+bm3qrvtU2913SEuj3y3wi/Ud8OmXqdcQATPD0kwr0ItGLayiJdj7i
         bjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171356; x=1750776156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT1GJOgOaAVfw+eDwzE42lZB83neWTsqm+FQ7K7TUI8=;
        b=n+sBZZWxdOD5E89sCUeDe1LpauSNyrAQXZO0vmPhZa6wHD8qe6uN+GudWMRHPCq62J
         LOuHSekfkAxFUN7bpAa4aD47RDTj2F1LuBqjukEb6m7s6C7Fds1DV1hl772c5NHUBaI8
         0WBsR3J3rHYXsMg8te7NIyWL+C/HRv3Pysy31iNMXpivkHDERz+kQz36iyx4I0Qsodm9
         TMdufAePEv/vwCaovN18v8Rhyuqe0zwOilu8cefqdLePYPSWGo1fkfmMz+03okV8YvPe
         XZkCscyDbTE+RmZX0O3stfqoZAqyNFSXz2mkY4xW9UPstjvaZm1CwOaF3DLbbBStggDG
         ZmVA==
X-Gm-Message-State: AOJu0YxnHIom3bLfPhSnIjK07ezD525aOERZoADK2bcy4etlPAssrES8
	B2vXqRxBSYRzvu2Sw2K+9KDwN/H5HMyIrxHnexJOVIhiR06D3NIDFHsy
X-Gm-Gg: ASbGncvL+XPkhp9NEKuSpi/SEc5+riuWq/phh5U82KVzlMo5vTIuL/NYNLzQdCW48WW
	iWZYRCPYimVoEL3AGdTwnZvoRU3ICc8GY7ZJEO3UVqtdI4badFHOH7Wv31siDrykTVvx2PcUJbA
	aQr8QlW6zqAYiuSx0yipPBuw4aL2XdbSVekWGmMSTg9M/2+PFY6c4mUS8nK0ON9Dte85NLvOHci
	Z4t9iGXutzkFFILvUbnOh0rJO2whq4QN0UTX0dE1D3h3Qdlhi4tE+sCWXoIgV1AQXQI+uRJGSPa
	vli6dp3ryNleVaPlvSZCNIk8CXMOObihHlCBbPw7usuwXRH7HdxwE3NVbo/1Qwde4RpOz97CnpW
	nJxO/G11W94Ic
X-Google-Smtp-Source: AGHT+IEceypRpc4JHd2smqn26tC6AJp8Mf1QychOfQumQLOYlrXm1WEmsA8UqqRS88ho62mv5HgkHg==
X-Received: by 2002:a05:6402:2549:b0:608:3a2d:686b with SMTP id 4fb4d7f45d1cf-608d00ca64fmr13047702a12.0.1750171355692;
        Tue, 17 Jun 2025 07:42:35 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-608b4a5b6a5sm8364639a12.40.2025.06.17.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:35 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 03/17] net/ipv6: Drop HBH for BIG TCP on RX side
Date: Tue, 17 Jun 2025 16:40:02 +0200
Message-ID: <20250617144017.82931-4-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Complementary to the previous commit, stop inserting HBH when building
BIG TCP GRO SKBs.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/core/gro.c         |  2 --
 net/ipv6/ip6_offload.c | 28 +---------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index b350e5b69549..8ed9cbbc1114 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -114,8 +114,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
 		if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
-		    (p->protocol == htons(ETH_P_IPV6) &&
-		     skb_headroom(p) < sizeof(struct hop_jumbo_hdr)) ||
 		    p->encapsulation)
 			return -E2BIG;
 	}
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index f9ceab9da23b..2b1f49192820 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -340,40 +340,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
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
2.49.0


