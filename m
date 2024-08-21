Return-Path: <netdev+bounces-120723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D095A676
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BE9285A3E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62B175D34;
	Wed, 21 Aug 2024 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="SOCWuns0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C6175D4E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275360; cv=none; b=aRG3sHy/2xTQTsiayGvisM6Ep08YOLamTTttRz3H9NYdIlBcM0phJUg9InU12Y5wFE+T3NmteFyfGZnUTOs/VEZ3mSByE5qROd3Krm/vbfgHAhLo2rYG+dLLVTw5Ip4+rquonqtyloLn/k+JQ/GZT/Lb+zvWtG+K7C02C4GKifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275360; c=relaxed/simple;
	bh=CCZmy3roTcoldWMY3Np2LMkMsQ2dOSmXCqOYrD/u33c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JB8OjxsyFuewVRabU4fRZeCtXCC6Z+iFHt91CTpBVtq1gbjoy4NImm335mwLe2drkh6/RhemEwP02JhfjXJkgbyjvU1MJTY0dYJwE9msR6m/hXy1EqFS20n5UFIuvdwvs9vbGSHKJkxDTEL8WOgQZR+z10w/01Wt/Wc8qOmKi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=SOCWuns0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2021c08b95cso10080795ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275358; x=1724880158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDdOXUn/9snQ1wK5LCIPPus5mF2WWgGtaZstma1ySpU=;
        b=SOCWuns0DOFk6Wrq+v8+wSbocVOpnH2zNlZIzHkPR9UodNGr4QU5DeM7ic0fPVkaQl
         oAsLI9j25FQjJj71mnjh1a+8LfWQmuUdNc4I/jdXCIi6sPP12BkP8Fq2uQykYudD9eBY
         lRjevQz06tGLoKv8Q4/iHx4OKh25fq0JWCASaOwL9zj4EVRlnZ3rfacPfMGQAAGRA90r
         V/a9Zo5EFzDrSqlLye/edCNY19hEwWxHNbmPnI+rHB7p9Ra1zVGHsOYUBy0ph47YxJNN
         Y05KQefPmEBAJauzFpHvSGNw8yliRLhlsMhmQN25NZhWrwNjUy8HXDrzLeFN7fSSdGXy
         ujzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275358; x=1724880158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDdOXUn/9snQ1wK5LCIPPus5mF2WWgGtaZstma1ySpU=;
        b=obP339taocvKzDC6e1jgyAKYea/K0PFu7UxcwvWoccqKWFdxuvpn5MGX0EdT/4ouch
         KKS5EKMEJvHh/FsddRs0VoQZOvr3tdj73TRId1PLmx+lFcycy51rAmtGSDbmEsFywKlA
         vdpphATUCoe/VcD4Uae1WvQTWVBk3CAOR3Sx1n5/KsM5UfbdslV/v9pEG3rnKgS/+l2K
         AlqSJ3+/W8+92WXbwjHwAS9/cQa4OGMX5ullFv3EMiC3RweyXsrhwnubYSMsSj2GuMG8
         ZTo3xHiXCzepUuyJ6ah/H/U26PAr4F63iJTugyo85hT8ggH7lhvbVaRAi2FTJpLLwRbn
         AEWA==
X-Forwarded-Encrypted: i=1; AJvYcCWYHC0UrSXOMRPzSS0iK8yiVgozJmKtuutzCxCW2oxg3e1xM7/bpHzyzwHvzadMY2+x89PiVS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYgv93sL1o/Fu8Qx6dBOiTCzhoyD0NH1SEtW+pIE6QgBoA5tf
	/z99+50JXAahB0nDYspZxKxX7QVXeD1LXAlnkyhXjIIIodfjOYERrRpbI8Zfyg==
X-Google-Smtp-Source: AGHT+IGcNAZPUF0W+hbQrxP07GyQ0jaUGEcBHqIKaRxoDDxLk4+aBXMgV7CZOI4oM6X1qeQRCMmI/Q==
X-Received: by 2002:a17:902:e851:b0:1fd:96c7:24f5 with SMTP id d9443c01a7336-2037ee0653amr13333935ad.5.1724275358021;
        Wed, 21 Aug 2024 14:22:38 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 02/13] flow_dissector: Parse ETH_P_TEB and move out of GRE
Date: Wed, 21 Aug 2024 14:22:01 -0700
Message-Id: <20240821212212.1795357-3-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
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


