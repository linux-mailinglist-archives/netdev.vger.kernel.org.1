Return-Path: <netdev+bounces-119006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E54953CE5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66361C25296
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54E155732;
	Thu, 15 Aug 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="GdqGHA1i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39870155353
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758386; cv=none; b=Eb4Cm40vhU9R8C17iq6LSiFCqHW0HNAUHAsmHOv3PdjEyKECX7TlAnvYiFJfR2bGD4ULAP4eASTLseGY0R04Vl4C3Bmr1PJRPK5JhE7x7BZfC0rratKYDXMZrnWfdg2/eFy5l8HAonnemoJcasfYccJ490ECjg6532OqPdOwBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758386; c=relaxed/simple;
	bh=AKZTwTOl/6402WHfcJqVRq+TsbkjKlN8zLi+0jDoEds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8quDLFOaFf0RzkPGMZQZKG1fsL0YKdyvtmWo0luhCJXXIRKeEZtr74BUk70npz+LgPibdnkVzIY/ERFdeAqnr2B3SHaqf1kyCUivWqdKjThAlqpYGsZCbJxDWJ6SlhtCNbvY+0llnU2iGPvKXjROh07o7VfTVaupKbX2Gfnrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=GdqGHA1i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3e44b4613so174014a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758384; x=1724363184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KLZ8lvNd3VBHtbxfeJSmBIFPoMINjfQPWX7ldcRSDA=;
        b=GdqGHA1ilIHDP7eP4BSQuYahjkX4HbmZy0UU0lVKEVanpzQDpCXwzrDfx32819UrQz
         7+Ix7CATCEg6bXCnkYh2oJh5mx73ExkyWOi+drIjRfTgZ5FPCMY7XpLa47/d287sMEa4
         l0fOZECERvtzL/lK+DlVsWv9ZB8zC/NEnwntX2uU/E3scEJ41xC7dD86jU01AS1wir/X
         1mb25GauGFxHIhvxl0a68CtoCCCayMA7ek248Psc/V0tlHe++adXLGqH+l28Syr6AG7u
         k9pEJFiuU5u7MkN7c/gNmnbxsJzmoL/bUM7XjcW3tigyowiV6zBAl706b1ZAs4wvHMCx
         Q9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758384; x=1724363184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KLZ8lvNd3VBHtbxfeJSmBIFPoMINjfQPWX7ldcRSDA=;
        b=PCSHK1QT2IxU+ewbk0Umx+qnj71uzSgSlhvuRo9YBkfWgIjOkWXTbpGf4JcoWHWBDp
         uTqt943cbS6AAFabZpcM5SH/AjjolLKVsMN1Rb5NtcDgUjYP4o1I9Wow1VcYUJETBjxO
         Ur7Wzw90db25cnORk3S3SOq33EAvD2qc2sLyjhPJuhLAUjAMHXQOPXY1XPYpbnQb2MoU
         AFYAtZWbUFMVh0eajzvdhAaRkMg+gHvbbiZ8pzb/CYO7ptm7dBmdqR4TWu1S08+UaqB5
         u0T+8fjm/Saq9yoxFs4hCS6BSeeIoCaovH97TB1//77fzUf5W2nnUWUO4+WyCVxjvofn
         +/zw==
X-Forwarded-Encrypted: i=1; AJvYcCVhZAZpqWpn1WDMKbrJJ1SI7A1Oa5LIBSlulhc5FjpSQ1cn50NmWAR1SMp4HxBDyhnFowVmLJFmKy+Y1CzmE4iRGdO2voIl
X-Gm-Message-State: AOJu0Yz2pnfi4LyBIZCeOKB/Lc5dl6Ej2O+Ud3O1n4wJK2E+P7lkTJRB
	fSjKYjv5LpJ4pzfljnCqqzB+9HjrLC2eUNFRoavBK37PB8ez8tX7+GtunSq+OQ==
X-Google-Smtp-Source: AGHT+IF48AOdOPZrsNIWrKiHI9u535TaG3hKjZUbJlHm3BNsZaYMcA8pCXkUNogGa39/TnFW5mXH6w==
X-Received: by 2002:a17:90a:e548:b0:2c9:8b33:3197 with SMTP id 98e67ed59e1d1-2d3dfc6862bmr1223257a91.10.1723758384405;
        Thu, 15 Aug 2024 14:46:24 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:24 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 09/12] flow_dissector: Parse GUE in UDP
Date: Thu, 15 Aug 2024 14:45:24 -0700
Message-Id: <20240815214527.2100137-10-tom@herbertland.com>
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

Parse both version 0 and 1 of GUE encapsulated in UDP. Add helper
function __skb_direct_ip_dissect to convert an IP header to
IPPROTO_IPIP or IPPROTO_IPV6 (by looking just at the version
number)

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index e2a0d67b2753..fb8c0d97384e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -832,6 +832,61 @@ __skb_flow_dissect_geneve(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static __u8
+__skb_direct_ip_dissect(void *hdr)
+{
+	/* Direct encapsulation of IPv4 or IPv6 */
+
+	switch (((struct iphdr *)hdr)->version) {
+	case 4:
+		return IPPROTO_IPIP;
+	case 6:
+		return IPPROTO_IPV6;
+	default:
+		return 0;
+	}
+}
+
+static enum flow_dissect_ret
+__skb_flow_dissect_gue(const struct sk_buff *skb,
+		       struct flow_dissector *flow_dissector,
+		       void *target_container, const void *data,
+		       __u8 *p_ip_proto, int *p_nhoff,
+		       int hlen, unsigned int flags)
+{
+	struct guehdr *hdr, _hdr;
+	__u8 proto;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	switch (hdr->version) {
+	case 0:
+		if (unlikely(hdr->control))
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		*p_nhoff += sizeof(struct guehdr) + (hdr->hlen << 2);
+		*p_ip_proto = hdr->proto_ctype;
+
+		break;
+	case 1:
+		/* Direct encapsulation of IPv4 or IPv6 */
+
+		proto = __skb_direct_ip_dissect(hdr);
+		if (proto) {
+			*p_ip_proto = proto;
+			break;
+		}
+		fallthrough;
+	default:
+		return FLOW_DISSECT_RET_OUT_GOOD;
+	}
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -995,6 +1050,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_GUE:
+		ret = __skb_flow_dissect_gue(skb, flow_dissector,
+					     target_container, data,
+					     p_ip_proto, p_nhoff, hlen, flags);
+		break;
 	case UDP_ENCAP_SCTP:
 		*p_ip_proto = IPPROTO_SCTP;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
-- 
2.34.1


