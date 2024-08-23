Return-Path: <netdev+bounces-121505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C895D7B7
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BFA282165
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EEC194A4C;
	Fri, 23 Aug 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WYVBuoBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B27194A49
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444173; cv=none; b=Y+GjkmGxO5d9b103s99PJnbQ/CbfqoIYv7g9ObxqS44T1/LO87m72s3/VGUuRG/WlF8yRxC3IPSsG0gVkhGuvEnUP2hf62NZf9upt6TJIUi8w+sHXvhlG6+iMiQGIOXHkudMh0YhqUbeA4oiopwpjY1mB69EhSXppfP0HqZZbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444173; c=relaxed/simple;
	bh=CCZmy3roTcoldWMY3Np2LMkMsQ2dOSmXCqOYrD/u33c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqCIcWUMatMFc3IVNTJrIhVTjX+nLcsa486Y4gaTAOv7NY+0WGsgRmKL0gtjanNxQ5WMPotkEwiLd7fMu5sZkr3Ofm9ejjkOKi8DlLIW5TC8GsUG5BzF5G8/ls3iakHh3wC7NRXsDVzwgD0dnw/7FGtOpQlXUi9DWDvsnIyVXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WYVBuoBb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71439adca73so1824398b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444170; x=1725048970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDdOXUn/9snQ1wK5LCIPPus5mF2WWgGtaZstma1ySpU=;
        b=WYVBuoBbZzSfyOiruH+SQRtGBoOApbraD2F9i1RitSP1N5tIMYng9WptH+KfGppb5J
         +WIB4dOr/X8gExlyfbUmCQAdjKedn6y6pSfB8O+lqId9JapCz/YlMy+PFRJoH5UP8dfG
         A+C3O8Fe5THFrLYKTHIHpLA4Bbd6fnJvuIDSdhpHJTE81UGprx0NKYK3GbPCqdNcQuHO
         e0ByWvpNodEN5ab6/UPbPU99851lF5e+yoj7AbjeK1VS4MM8iKO3FNHfia4VvCSbERNJ
         yj6PhiQ2FTBewxVyWkfgMG4L32uApYTYv4N7kkW9UAxeX3oJVuNuCG9OP02eUssbYYgy
         NxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444170; x=1725048970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDdOXUn/9snQ1wK5LCIPPus5mF2WWgGtaZstma1ySpU=;
        b=eZTZVCzWJS46iBTEolRTkEjn11oRqP1+riGTWyyDZkm6CfEKdF2w71FNDkbe8T3BWx
         m4hAZoKahiOO8fn1ICbC0Mn3b3F3yOlRqBoOQ37GhBxq6Jxa2mCgDGdqt9EtdDal8ANk
         jmV7CiA7/w4wlzb1ev/jxpB8QTPGXSsF5f/bzmTBF1+eVYMl1AVNARMkjfyet7yCr1kh
         PkSA+bR6fgYzsvaDHpSaxo929MUX0uc+v3eMdbEnKuDa2fAnJNYfb0lBPi4COWFElohE
         H+eYKRLR7dsEO+4+LXxsfisvjQEKiFg9apSDqIw0L/+OYMmDJUL7MZXPhTDtVu8Ci58A
         y1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUioYOtjnWw8yJxQ1kDncyQmr5ys7TBsVPppMtO/n+YbjvgrDzKsJiZC0/bqsbukbnB3gXlIek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxq/zT7S0LYgOAJIffesjDRgB+gK49Al5Bd1VTOdFqMq4ht85S
	lgHDbV9LjLzF2vFrL+OyOgE83i5Qdyf1Gan3f5ux1Rqejg/YisG/s5gNwSi3s4+JsZld/Dvd+9w
	=
X-Google-Smtp-Source: AGHT+IEwpSNa8jZ4oZu0FAZzUZAVdglotwRbJWzNRi7TDjGNRdqHyZ8eKNeURjkByM3iNp4+7RqDUQ==
X-Received: by 2002:a05:6a00:944f:b0:714:2198:26b9 with SMTP id d2e1a72fcca58-714457d6995mr3959260b3a.13.1724444169524;
        Fri, 23 Aug 2024 13:16:09 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:09 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 02/13] flow_dissector: Parse ETH_P_TEB and move out of GRE
Date: Fri, 23 Aug 2024 13:15:46 -0700
Message-Id: <20240823201557.1794985-3-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
a plain Etherent frame. Add case in skb_flow_dissect to parse
packets of this type

If the GRE protocol is ETH_P_TEB then just process that as any
another EtherType since it's now supported in the main loop

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 71 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..5170676a224c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -654,7 +654,7 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 		       struct flow_dissector_key_control *key_control,
 		       struct flow_dissector *flow_dissector,
 		       void *target_container, const void *data,
-		       __be16 *p_proto, int *p_nhoff, int *p_hlen,
+		       __be16 *p_proto, int *p_nhoff, int hlen,
 		       unsigned int flags)
 {
 	struct flow_dissector_key_keyid *key_keyid;
@@ -663,7 +663,7 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 	u16 gre_ver;
 
 	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr),
-				   data, *p_hlen, &_hdr);
+				   data, hlen, &_hdr);
 	if (!hdr)
 		return FLOW_DISSECT_RET_OUT_BAD;
 
@@ -695,7 +695,7 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 
 		keyid = __skb_header_pointer(skb, *p_nhoff + offset,
 					     sizeof(_keyid),
-					     data, *p_hlen, &_keyid);
+					     data, hlen, &_keyid);
 		if (!keyid)
 			return FLOW_DISSECT_RET_OUT_BAD;
 
@@ -715,27 +715,11 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 	if (hdr->flags & GRE_SEQ)
 		offset += sizeof_field(struct pptp_gre_header, seq);
 
-	if (gre_ver == 0) {
-		if (*p_proto == htons(ETH_P_TEB)) {
-			const struct ethhdr *eth;
-			struct ethhdr _eth;
-
-			eth = __skb_header_pointer(skb, *p_nhoff + offset,
-						   sizeof(_eth),
-						   data, *p_hlen, &_eth);
-			if (!eth)
-				return FLOW_DISSECT_RET_OUT_BAD;
-			*p_proto = eth->h_proto;
-			offset += sizeof(*eth);
-
-			/* Cap headers that we access via pointers at the
-			 * end of the Ethernet header as our maximum alignment
-			 * at that point is only 2 bytes.
-			 */
-			if (NET_IP_ALIGN)
-				*p_hlen = *p_nhoff + offset;
-		}
-	} else { /* version 1, must be PPTP */
+	/* For GRE version 0 p_proto is already correctly set (including if
+	 * it is ETH_P_TEB)
+	 */
+
+	if (gre_ver == 1) { /* Version 1 is PPP */
 		u8 _ppp_hdr[PPP_HDRLEN];
 		u8 *ppp_hdr;
 
@@ -744,7 +728,7 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 
 		ppp_hdr = __skb_header_pointer(skb, *p_nhoff + offset,
 					       sizeof(_ppp_hdr),
-					       data, *p_hlen, _ppp_hdr);
+					       data, hlen, _ppp_hdr);
 		if (!ppp_hdr)
 			return FLOW_DISSECT_RET_OUT_BAD;
 
@@ -1284,6 +1268,41 @@ bool __skb_flow_dissect(const struct net *net,
 
 		break;
 	}
+	case htons(ETH_P_TEB): {
+		const struct ethhdr *eth;
+		struct ethhdr _eth;
+
+		eth = __skb_header_pointer(skb, nhoff, sizeof(_eth),
+					   data, hlen, &_eth);
+		if (!eth)
+			goto out_bad;
+
+		proto = eth->h_proto;
+		nhoff += sizeof(*eth);
+
+		/* Cap headers that we access via pointers at the end of the
+		 * Ethernet header as our maximum alignment at that point is
+		 * only 2 bytes.
+		 *
+		 * For the real Ethernet header the receive skbuf is offset by
+		 * two so that device places the packet such that the Ethernet
+		 * payload, i.e. IP header, is aligned to four bytes (14+2=16
+		 * which will be offset of IP header). When a packet contains
+		 * an encapsulated Ethernet header, the offset of the header is
+		 * aligned to four bytes which means the payload of that
+		 * Ethernet header, i.e. an encapsulated IP header, is not four
+		 * byte aligned and neither are any subsequent headers (TCP,
+		 * UDP, etc.). On some architectures, performing unaligned
+		 * loads is expensive compared to aligned loads, so hlen is
+		 * being capped here to avoid having flow dissector do unaligned
+		 * loads on unaligned headers after the Ethernet header.
+		 */
+		if (NET_IP_ALIGN)
+			hlen = nhoff;
+
+		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
+		break;
+	}
 	case htons(ETH_P_8021AD):
 	case htons(ETH_P_8021Q): {
 		const struct vlan_hdr *vlan = NULL;
@@ -1531,7 +1550,7 @@ bool __skb_flow_dissect(const struct net *net,
 
 		fdret = __skb_flow_dissect_gre(skb, key_control, flow_dissector,
 					       target_container, data,
-					       &proto, &nhoff, &hlen, flags);
+					       &proto, &nhoff, hlen, flags);
 		break;
 
 	case NEXTHDR_HOP:
-- 
2.34.1


