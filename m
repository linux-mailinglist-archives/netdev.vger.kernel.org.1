Return-Path: <netdev+bounces-119008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB89953CE8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916041C252E2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE607156665;
	Thu, 15 Aug 2024 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="P3amZS7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52724155CB2
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758390; cv=none; b=ZPSF++GYBCY9BWXIjGCprNGtjEg44+T5qDt4FDZp8khZQdC8e41j58OFYIodvfymrWsBG8rsRmJ2v6t1lSbhplNk19zevaEw++kCunMEo+JzZhcSdciCh+OBvamWJJHJ01b3UvnDD1sq5keqgrfkFwQ/I/aii1lPtuo2MesCuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758390; c=relaxed/simple;
	bh=gAPJdokW9OyPh5V23AKwk+6cbUxGPq6x1pSC5j+Kow0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6QcaIGsP/pcuq/gwn3rsfS1YVakMDmbw5DnzzoAQWNOJTmlQ9/6m7FVQ+pLvaybYcLJ9FdJN4lIV/oOE1Heuw/D3t39e3DGW+c2LYBmMJI5wSdv2yMiKE7OpcLFOc0AkxwQosoYFbWrI92K5pCjFX/1xoqM8OBfUxgGqfsBW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=P3amZS7i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc587361b6so14041055ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758388; x=1724363188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8MFOXRjdH8fksJJ/YKbkpwMOZGHQVEaj1LKadg7RDU=;
        b=P3amZS7ieSvBD5cloYpZZ5lmDzrhiiU0hTNiwuzETEMGrbf06XaiW6b3Hqgg6GgCzI
         t0ZiVzlCrfAH3OS3zbN6LkZn9pOu3Xp5T5v7Z/8RF89V3iPmtHCFWekqeEjL0AjRco5M
         +GaM/Sad/w/n+vfOpTxVG4Hn7pxTRDmwOSqz7adl7z6mu/fpzTJ5qH7MU98CVXaW1jVc
         xT6xJbTeAK7mihVP6lc1/buNM1dCcFpu6W2ubafHNLK+NmscrtaRttL+BrjtDBlCCE2k
         ckIYtSwBtaapt7i8IKQvkmLinoTkXsETKI+lr+VdIWAteZhD9PI/L2LxSUyTPnSX36uZ
         A1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758388; x=1724363188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8MFOXRjdH8fksJJ/YKbkpwMOZGHQVEaj1LKadg7RDU=;
        b=R2jSUWqJuZcsQUuLeHavF4HL+8xrxlxdNLgL8CzkU/nS5ldJy3HjbmiJpCxqSkDOT+
         aiqVFvXiD1WMKpgnlZbtvcKr543zlO/CncNjjeyBc3fK3FUIleyAf3yWm1Ynbu4Aj0GA
         33+xaVYsdQVPfl806R0s9//qPcZcdVBhRu2bdE0l2x3JVMwBYoe5uX50rSc+dKAVHz9h
         0mmO+sQBFqHYFlPizzWUQ5GiUpbFA7pk2bVO73IP1TLpOWUhxhkqMJdqKJJ6CICpOzQv
         ChVLhcyKlC+qbrWUjvmk6FS9QmJYhAYdTsU7JGv9Q9LX5S8dP7XKhmGeM1kSPV9bcoeq
         qMjw==
X-Forwarded-Encrypted: i=1; AJvYcCV5XG8oN0EHr24MKMVDUDVl47YPu4ac3uDzvakQStSz6axP7FM3MTsGXKzH2CEMkNKrpEJRDLVu/9wXvs99TQveFX/AyX4s
X-Gm-Message-State: AOJu0YyC4pHlM6wb8D7LoLIGbTIy9HxL7rLN1FSUdcjb77OdrEqNr3UR
	aRX0IWn6xsxpsgzpKmK8B77kQ1H1VlVZtz0ZeFUpuXq4/lRxTdB7IWNRr3OhoQ==
X-Google-Smtp-Source: AGHT+IHon11uMMueAdIsyFmm238Pt2RRMnNEsnHc83Qm8BFK6LOlmMax447H5tUxesit/kOZprXTSA==
X-Received: by 2002:a17:90a:bc97:b0:2d3:c863:cf16 with SMTP id 98e67ed59e1d1-2d3dfff5d4bmr1083016a91.33.1723758388345;
        Thu, 15 Aug 2024 14:46:28 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:26 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 11/12] flow_dissector: Parse gtp in UDP
Date: Thu, 15 Aug 2024 14:45:26 -0700
Message-Id: <20240815214527.2100137-12-tom@herbertland.com>
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

Parse both version 0 and 1. Call __skb_direct_ip_dissect to determine
IP version of the encapsulated packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index fb8c0d97384e..b2abccf8aac2 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -9,6 +9,7 @@
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 #include <net/fou.h>
+#include <net/gtp.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/geneve.h>
@@ -35,6 +36,7 @@
 #include <net/pkt_cls.h>
 #include <scsi/fc/fc_fcoe.h>
 #include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/gtp.h>
 #include <linux/bpf.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <net/netfilter/nf_conntrack_core.h>
@@ -887,6 +889,91 @@ __skb_flow_dissect_gue(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_gtp0(const struct sk_buff *skb,
+			struct flow_dissector *flow_dissector,
+			void *target_container, const void *data,
+			__u8 *p_ip_proto, int *p_nhoff, int hlen,
+			unsigned int flags)
+{
+	__u8 *ip_version, _ip_version, proto;
+	struct gtp0_header *hdr, _hdr;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if ((hdr->flags >> 5) != GTP_V0)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	ip_version = skb_header_pointer(skb, *p_nhoff + sizeof(_hdr),
+					sizeof(*ip_version),
+					&_ip_version);
+	if (!ip_version)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	proto = __skb_direct_ip_dissect(ip_version);
+	if (!proto)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_ip_proto = proto;
+	*p_nhoff += sizeof(struct gtp0_header);
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
+static enum flow_dissect_ret
+__skb_flow_dissect_gtp1u(const struct sk_buff *skb,
+			 struct flow_dissector *flow_dissector,
+			 void *target_container, const void *data,
+			 __u8 *p_ip_proto, int *p_nhoff, int hlen,
+			 unsigned int flags)
+{
+	__u8 *ip_version, _ip_version, proto;
+	struct gtp1_header *hdr, _hdr;
+	int hdrlen = sizeof(_hdr);
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if ((hdr->flags >> 5) != GTP_V1)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	if (hdr->type != GTP_TPDU)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	if (hdr->flags & GTP1_F_MASK)
+		hdrlen += 4;
+
+	/* Skip over GTP extension headers if they are present */
+	if (hdr->flags & GTP1_F_EXTHDR &&
+	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	/* Exit if either NPDU or SEQ glags are set */
+	if (hdr->flags & GTP1_F_NPDU ||
+	    hdr->flags & GTP1_F_SEQ)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	ip_version = skb_header_pointer(skb, *p_nhoff + hdrlen,
+					sizeof(*ip_version),
+					&_ip_version);
+	if (!ip_version)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	proto = __skb_direct_ip_dissect(ip_version);
+	if (!proto)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_ip_proto = proto;
+	*p_nhoff += hdrlen;
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -1046,6 +1133,16 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		*p_ip_proto = IPPROTO_L2TP;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_GTP0:
+		ret = __skb_flow_dissect_gtp0(skb, flow_dissector,
+					      target_container, data,
+					      p_ip_proto, &nhoff, hlen, flags);
+		break;
+	case UDP_ENCAP_GTP1U:
+		ret = __skb_flow_dissect_gtp1u(skb, flow_dissector,
+					       target_container, data,
+					       p_ip_proto, &nhoff, hlen, flags);
+		break;
 	case UDP_ENCAP_FOU:
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
-- 
2.34.1


