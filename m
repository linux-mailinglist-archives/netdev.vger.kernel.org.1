Return-Path: <netdev+bounces-114638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92C9434EC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2891F23579
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67B1BD50A;
	Wed, 31 Jul 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="KAxrMta1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376B1BD4E4
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446636; cv=none; b=eI7SoF/xqMo3iXVtFSf3wUGbF7eakikzLh653Ej6CSjSoBjViGR3hzw+OkY7rSMJDyI8r1hm5ExNbY7GxdJZTgpNQfMfa2t39JOn90ZnRQx/Sjb5xTYhiOXmYEyE93kmryJJ4Cq9OeyICPwtWvC1O8K9BAltvfkmYr3hA9fHRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446636; c=relaxed/simple;
	bh=a4ri8INzPBz1jyyv/MtslRAqOROZxxSvtl1l+/lq2k4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBwZP4YfJT9ecFldRg3A2hSKrwd5iBdLYb9XA45r9jgjxvu7qXmjqqz+iUeO8FLSc7r6x33NT7cNE2iI7qHFBsVwDO3i5yhtsLD8rMKId4iEN0pAMM7k4BHqhnUMvtoAqayg+IkgOo5wz+F7PSf+KIwt2dSHC2zdZUlWiNOBx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=KAxrMta1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d18112b60so981313b3a.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446634; x=1723051434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1trD5mstAM6ko/ALjqsiVF8KtF9GGGc+lYxrqdY4URE=;
        b=KAxrMta1OSquvFabP3rG8WufTFA7wIlRAjr3GnQqnacgekAVqRwAdiXKqgS1yDVFw+
         tD8bnYyGxruUGCsy4MN6c1T7C38xEJCGYfONu71nSNzg3Fhq49Zs28EpIUfmNlOOnf9Y
         PhVrek4WP2Wy4D/gqHQhoArN1xff/TQlMINIlzHBlhCORTCDD75R2gpfpMciePA8KMqm
         m3B1Y5iNiz/r34QxHhWXU+G7FNVKa+MtuFAP69e7Nzr20gF/xe4ZkefOB13e1KgxyQLg
         culXwlYxwvVVYwkP7CQ08jEb2V96ThSp9rD6pEU/7KlWejcbTlNx3ay/9AFp8FlIx5yq
         ppdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446634; x=1723051434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1trD5mstAM6ko/ALjqsiVF8KtF9GGGc+lYxrqdY4URE=;
        b=caO0B/GQADQywxp8As20/wDnKnb+4EXDrEhPsvyhsC+FHzOUGTET+gbWjzGNBw3TXN
         P4RkVuhBhMMEuZ7PWWNtutubx3RjAKV4TmzSApdgTis3F3Qe2QT3+1ChpFls/M2gANIZ
         bSjDEnbek6lby+To6yl0XTR10BVdAlgYsApX9Z0qeYz3gTuGIT+QfNZ/pkDAGWZiogvj
         0OpFJnDwF36bG8MA+vRJ3WYBNxQLpc6RD2I/n8ul6+d68tKdXXoq3nndspTajG9Mpz2w
         K8pV3RPI8hnP9mKDIfeLiXPLKgasO+CMnSwRYROw2lhoJGUyAJeJVR+BNVBPkFme4gEY
         /6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSovvT/TCzi74sOuHuSjcI29oj/fzvL4xUPSUDa3ui+rS5h8EuLL0shJYyab+cJiAee5IOOkhpvnbIsMHyv1RtlX+fEz5s
X-Gm-Message-State: AOJu0YxwOzRRkO5HTDI2TwZOcWx6uzQuSIkJT7XR7RcGfTq8WRki4PhU
	19lPxyd3KCD8ajEutEHM4tgjKod+ylDscjWo7h47199AaC2ANHzfm7Psqd6R9g==
X-Google-Smtp-Source: AGHT+IFU+olFYWB5AcQ3eeA+UzxIphxkBQTmbjoGYQAqYgQJWHR5lPitJWbOyAoBTOkK+cdd3NjZCw==
X-Received: by 2002:a05:6a21:39a:b0:1c3:f4b6:f83c with SMTP id adf61e73a8af0-1c4e4848649mr6704011637.26.1722446634242;
        Wed, 31 Jul 2024 10:23:54 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:53 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 03/12] flow_dissector: Move ETH_P_TEB out of GRE
Date: Wed, 31 Jul 2024 10:23:23 -0700
Message-Id: <20240731172332.683815-4-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the GRE protocol is ETH_P_TEB then just process that as any
another EtherType since it's now supported in the main loop

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index d9abb4ae021b..416f889c623c 100644
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
 
@@ -1552,7 +1536,7 @@ bool __skb_flow_dissect(struct net *net,
 
 		fdret = __skb_flow_dissect_gre(skb, key_control, flow_dissector,
 					       target_container, data,
-					       &proto, &nhoff, &hlen, flags);
+					       &proto, &nhoff, hlen, flags);
 		break;
 
 	case NEXTHDR_HOP:
-- 
2.34.1


