Return-Path: <netdev+bounces-118998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DF953CDD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D9428674B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D9153BED;
	Thu, 15 Aug 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="GsFg44uR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66B14885C
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758375; cv=none; b=qdTyKHkcypO7nA2gZM/BIHAcQrHaTE3IJa9PvoOaSuSpPduNhcepLjQLRKnIMny+2AkIC0lf/sGG9QlPzqeSl0G/VttRcqnT4IKe61wm1x8HbZrR0vZaIrj0wfSrs2S1h311NzSYNrPdw0ZWi1rbp5KU1uXlV0QjHOXDD/gCkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758375; c=relaxed/simple;
	bh=pMxSFLHW8OQQ9MzLo9nOIyQKK3+TRUxatAegI+kLcMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LOIHg9j37OJ1x6R/IMW7dZ1WOhhc7oRaBvUkFT3EppW5cjwUViMxxAc8Y2CLVuR0lYKwa+KlwMwaqM6xUKIvXpuhTaN64Hf0hGiF2q3vHINsg7eTeVoNeHOUoIKD1sZKeLLCB9WNjOofzuBDtBaW+EBXX0UMenHLstZAhx7RuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=GsFg44uR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d1ecfe88d7so1057249a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758374; x=1724363174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhsTJBR9FLQP0AcbJ+2oEI3J4Md6+zJ2qyQOiOouhL0=;
        b=GsFg44uR7VeRF3tHa0TXvuNe1C+9tWpH8KQgkQGSxHkFLy0Q8mj3fdkuYC0umC/fTA
         TuYmQlm5Wd0bZRxZua81cGJOLnbOF9BtTiJy7Ik9qwosFY/JAPTsl/1NIdJWyrroNFUk
         7zrBdKQMllUlQpY3q2RHbn3z5x4LKD3e+MrYUynSvL+FVE8DH3y3IIvq4NvYCxN4wPRX
         WI5zLpaTJhKke5iMnMEHqZWHe4XiUfbC8+Md1icbgfjS1G/0dwW2PbayHWe/JC94H75o
         p66EGHsT8tuK9Rx1RqkrpI2DYFBxcCxjdrBS4DBhKLFFBBtU4qJXcg7BeOAzG9WmutYg
         t2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758374; x=1724363174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhsTJBR9FLQP0AcbJ+2oEI3J4Md6+zJ2qyQOiOouhL0=;
        b=m37JAUVNDoEz5CKplbdoKphtdgeouAfYdjSbYYOhlWsZZBjeiC2K4nm744gqB6yn3+
         JrGylsQ4aTp1oMummFsNnHJ/ZGLGhW7s7gS9XdlqfrEJIXDN2HifGbSuHEEMwBASm87J
         FcsrmcN234zBcYEg3SV0EbjyGY/lCbvykJyi72UwAjhE6fOvuVZ/SeMdjJTW0Tm44aye
         tcGFsDsl2Q2ItY1q0kYDDRVMbzp8iaZCg5lWbHKlVuWZjSXBxD6URZBNEJWGlpUv7Lmx
         PlmFJC4iUBK3ZD7uOFFlFvfcT14PFTy3EX60jfrEX1Zwqq6eIWUxn/W3//WOzchzRPoA
         Q2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpm0/rcap4D8Gi5v34ctb11v6scJGPcBCJRJpqnsWB1em/9OD+JgMUibY69E5dEPHHrW2gIVRr02iyJmnkqqB9WJqKyhPt
X-Gm-Message-State: AOJu0YwkynSeCWmvHqBur6Tv9e043qa4gJ+HBqaTmSs8f+hunEBKfSsd
	GmXWOtXbU0eP011WzmXWBP/aYhBzQPUyfVIJN9Mqs4YOTp8zk1qZNEMixCw1ZQ==
X-Google-Smtp-Source: AGHT+IHVk6B7DKjFnjD+eeR8kPpbfJTfgmjA1RYXRjNxMDhE0aWTPtZDO6q7zSqtzun6tIMYz58tLQ==
X-Received: by 2002:a17:90b:234f:b0:2c9:649c:5e10 with SMTP id 98e67ed59e1d1-2d3dfc48a3bmr1266936a91.10.1723758373425;
        Thu, 15 Aug 2024 14:46:13 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:13 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 01/12] flow_dissector: Parse ETH_P_TEB and move out of GRE
Date: Thu, 15 Aug 2024 14:45:16 -0700
Message-Id: <20240815214527.2100137-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
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

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 57 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..4b116119086a 100644
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
 
@@ -1284,6 +1268,27 @@ bool __skb_flow_dissect(const struct net *net,
 
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
+		/* Cap headers that we access via pointers at the
+		 * end of the Ethernet header as our maximum alignment
+		 * at that point is only 2 bytes.
+		 */
+		if (NET_IP_ALIGN)
+			hlen = nhoff;
+
+		goto proto_again;
+	}
 	case htons(ETH_P_8021AD):
 	case htons(ETH_P_8021Q): {
 		const struct vlan_hdr *vlan = NULL;
@@ -1531,7 +1536,7 @@ bool __skb_flow_dissect(const struct net *net,
 
 		fdret = __skb_flow_dissect_gre(skb, key_control, flow_dissector,
 					       target_container, data,
-					       &proto, &nhoff, &hlen, flags);
+					       &proto, &nhoff, hlen, flags);
 		break;
 
 	case NEXTHDR_HOP:
-- 
2.34.1


