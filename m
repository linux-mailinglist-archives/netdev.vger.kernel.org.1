Return-Path: <netdev+bounces-121515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD995D7C1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9128282219
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07C197558;
	Fri, 23 Aug 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="OUayUzd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8996196D8F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444188; cv=none; b=LaET3p/IoViL6sVa3wfs1haTwtPSeY4f23SSBdNtku0ZAycu6PKaFH3dOX+bZ6MMSnv4ctu5ZNqNZgecGsLESYE2BXCmIQT2AxEuPDXMD6uWy4dFyoUCHVWzDKWQNYL9XLs3xhao6RjYnTkmUMpnsnVrS9Fd0gxL5GkbUsRMZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444188; c=relaxed/simple;
	bh=ZMxygvhK4ELf54fKgyLBVpoBZdpq7p5KbBS864OliTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4z3ILINhKB8ddAcSfJtwDD+5SP9pUh/jHWt0eUp4+wtoXqJftg2VLXgqPD6tnRMqkC91gSYRBUAv8GFn7/QS8i1CfV3D1/LBx2hOuZ++cBn64BVK/vqenv+msOYnpJHhRY3n53w4bn8GMxfUDsDaHp8HTd1EiBY46927ryJGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=OUayUzd0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714114be925so2027622b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444186; x=1725048986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/LrkTUGrE5MSnxbjizbz/XGEysura3Y8RvHHfJnANk=;
        b=OUayUzd0eIJYBs2Bwiza5M0+R7j9Pp27aIcdm6CIQGvcXikitU2SUWAzaGfXRVXSLt
         MTLfEKL/eYH14lJVw9mpraw99h5mRWtYKWb4GGgWeMOpu4BCOxUzTCdnUKoklxGcjpAY
         O6qJDsuktPffs01oaAAolbnBlJK/0CMvwVNOIgmjsWWz/OJmBYvwkK73O/27AHjvA4Q0
         2PkgKXRFEJ+1I4bXNSXka9AykkfQgRls8MaPuW8QeudzsLqDqGxWcI9OyF6mcm44L4nS
         Gxl3v/TLTje1/gtoQq7HsIHnVr41+IiBTm1ob0+SoK6q0DzymQeff3TZTxyCkAI55Dea
         +dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444186; x=1725048986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/LrkTUGrE5MSnxbjizbz/XGEysura3Y8RvHHfJnANk=;
        b=CBaGzn7OMaA4SdDL0yorUISvNytvK1ni6a3XwRwMXttVGfBtiQuhCzqwhgzXFx9Fci
         U9t0BaGl12+nsdGGyFxAfZRZpHYgbuJ4LaAho7D+IDNxiEcxkpMS5N/nrml8TjZz7Am7
         Fnm4Qxmp4VkVyZNyA942iSGHlOlL1imD9AUGwOdDpMVuv4Ufu+7HtF6VeDbbsAPmAbAp
         bFPhpQcgmOBcVxGcO4pIfTrsuDiO5DDggBcKvdSX5gsO0yhB6gd3kcLiEZWHw+5kO63+
         RR3taUOakBqrbxvUdhHC5jzuLXcy8ZyFzUXgN0yaTI/dAA0610hYO94NPT7R436Yn1g6
         D09Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2AEVjodCgC1O5VSaqJZKWZ9IBG2nDw59PXbY2CZrECZhAQgYAVi0hBOu25C4etBSPSH9BBso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MvpdWpeXD4fHkxg+2LfQOg7/EZNYNS1IWvKQEM9W0w2ekhJ4
	JF5RXk5sW6T2MaPIgtfqivOx82TUHIaLFPIwX1iW9Io7AQafrdRnHhfbHIKcHg==
X-Google-Smtp-Source: AGHT+IEweX7RHzWH2YrKfVWv7U7Qfqzc1wScEKeqHiNeMlyUW9PUIJqNjo75Fh0AMS8q2knrvKHZFQ==
X-Received: by 2002:a05:6a21:3417:b0:1c6:9e5e:2ec4 with SMTP id adf61e73a8af0-1cc8a0846c5mr4319323637.50.1724444186172;
        Fri, 23 Aug 2024 13:16:26 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:25 -0700 (PDT)
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
Subject: [PATCH net-next v4 12/13] flow_dissector: Parse gtp in UDP
Date: Fri, 23 Aug 2024 13:15:56 -0700
Message-Id: <20240823201557.1794985-13-tom@herbertland.com>
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

Parse both version 0 and 1. Call __skb_direct_ip_dissect to determine
IP version of the encapsulated packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index b59a9e896a31..ae56de7d420a 100644
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
@@ -876,6 +878,91 @@ __skb_flow_dissect_gue(const struct sk_buff *skb,
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
@@ -1053,6 +1140,16 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
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


