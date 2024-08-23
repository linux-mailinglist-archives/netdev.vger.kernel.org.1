Return-Path: <netdev+bounces-121509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84095D7BB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ECE1F24A1E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934C194C6E;
	Fri, 23 Aug 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Nrk1wkZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B1194A75
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444178; cv=none; b=ftqEl4tlQK7NmrzaEqbiadfTMDgALYgvnavaeSMDsv397wZyyBL0Qg6Sw16aft8HK7ZeVfZSK64Sl2xycudI3r3wKu+nbMp6X4/VHQ1BMfBMs0RFtsZCa6JuXIETB6ac+3n5IAF8HYgDDNlqie1e9jlio8bo38526+DAEG4kBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444178; c=relaxed/simple;
	bh=3zXqjd6T7OAkkVyPtynFctJzHiviWc01ugeuIPQDJlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3yaHXlUowfTMPL5Sfh7d8T7P6ajbz/F4WtD+899jdki2BRU4RmbiiHoUQr3UAnZlo968DidUUiEFcuIFEXWabVuOMzSgowA5LZokruMbaMdB3Y2GfjB7gCvKznUHQ2kT5OTMIr/m411JkNZWs1Xg7Ia+s84DrwpCy9wyGDU1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Nrk1wkZI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so1513663b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444176; x=1725048976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmN31OVcMhNWNVNEtEZ2hIEFQuF/DCs+aqdarr054Cw=;
        b=Nrk1wkZIQ4qcuk4UzFJ+AVHJkhTl3CXzESQtANlscHN1k72glqpOyiK5q5G76AB+Rd
         cnEcxzR5Tq5IcCTCayxLu17Nu8Kq1aJZsySiArglhT2bMoAO0qFlnapnxY4MMOro70bg
         oXMvGFOJ/ZX4hrThqZwzZEDPPy0VKYB3S4oInTP+JsrkN/RkykW8dRk7foMSNNSsDpPB
         Tj+k3R34UkXi+JuWi8Il8Ztqds7vCevl0G+vzhS+pROMyiE3lzP52yk8J9b8GbDycyEz
         6dWhBk5o/OANsDEZMWQLevBP+NgUABdP2ps3XrBlBzejbA35RPAlTaF48BnqHHFZVPC6
         dIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444176; x=1725048976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmN31OVcMhNWNVNEtEZ2hIEFQuF/DCs+aqdarr054Cw=;
        b=sX+7kx8EbnQ1Ja7ChwMapa8wXPu+IbAfz0j96VA/CCYNYWJ8g4+/MLa4pLk73WBe8h
         F/2u5IiYkG+WQXNAoUnPpeUhSQxcEPQtUZwhqCQm//WJ9Nr5UyC4iG00cNkPdxyQ8i0K
         nPtuUGt42nRRbVX0w66uxa+LYSeGR+sefTKWfM4hkUh48YWiJC/qCQi4ux69tbRg8kXy
         BJwWJwE7JJUhrK8/r7BqCdO9slZCOZYLE4d6P77c9R4DG/KaFeHGXewRKZ3+G0dvV4yH
         gGvEpTTAy7/tAn7v9+KwrqNuwGbiOVSopF9NZ97lPMbTqkky88JECMrfYM5n+Lvej4wG
         NVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPgRqbHWKPpg/U1TROatnarQn1MAAFpvtj1JvafxSe50ZL6nbRIk2Z+h3X55+d2EC2OWx8s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUolIvFMt2L9BC1qFUPym2cyGb2fredTnTf6sQ2fOGavnfGss2
	xq9AMJBy5my6JSPz6smlDjf/43fUsZMkK+U5HCzelS+lAs2AVTrVbi8BLEd+Bn5saDb2DDfl9Mk
	=
X-Google-Smtp-Source: AGHT+IGOEWssWAXO+yM7Zxlb93fs4cQ4LccBhzcvbs5Q7JEljk2cc0twnRKmmSXUwzYwwMXppZxcGQ==
X-Received: by 2002:a05:6a00:847:b0:706:6b29:9cf0 with SMTP id d2e1a72fcca58-714458e02f5mr3685026b3a.30.1724444175777;
        Fri, 23 Aug 2024 13:16:15 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:15 -0700 (PDT)
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
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 06/13] flow_dissector: Parse vxlan in UDP
Date: Fri, 23 Aug 2024 13:15:50 -0700
Message-Id: <20240823201557.1794985-7-tom@herbertland.com>
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

Parse vxlan in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index f3134804a1db..49feea3fec56 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -13,7 +13,9 @@
 #include <net/gre.h>
 #include <net/pptp.h>
 #include <net/tipc.h>
+#include <net/tun_proto.h>
 #include <net/udp.h>
+#include <net/vxlan.h>
 #include <linux/igmp.h>
 #include <linux/icmp.h>
 #include <linux/sctp.h>
@@ -756,6 +758,44 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_vxlan(const struct sk_buff *skb,
+			 struct flow_dissector *flow_dissector,
+			 void *target_container, const void *data,
+			 __be16 *p_proto, int *p_nhoff, int hlen,
+			 unsigned int flags, bool is_gpe)
+{
+	struct vxlanhdr *hdr, _hdr;
+	__be16 protocol;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	/* VNI flag always required to be set */
+	if (!(hdr->vx_flags & VXLAN_HF_VNI))
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (is_gpe) {
+		struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+		if (!gpe->np_applied || gpe->version != 0 || gpe->oam_flag)
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		protocol = tun_p_to_eth_p(gpe->next_protocol);
+		if (!protocol)
+			return FLOW_DISSECT_RET_OUT_GOOD;
+	} else {
+		protocol = htons(ETH_P_TEB);
+	}
+
+	*p_nhoff += sizeof(struct vxlanhdr);
+	*p_proto = protocol;
+
+	return FLOW_DISSECT_RET_PROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -917,6 +957,13 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_VXLAN:
+	case UDP_ENCAP_VXLAN_GPE:
+		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
+					       target_container, data,
+					       p_proto, &nhoff, hlen, flags,
+					       encap_type == UDP_ENCAP_VXLAN_GPE);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


