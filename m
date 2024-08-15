Return-Path: <netdev+bounces-119001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F6953CE0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F31F25366
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9D14B092;
	Thu, 15 Aug 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="NL3kCpUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54B15381A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758380; cv=none; b=g9XqjOUuSHvX9XeOKbDh2mEdPPX95i4EgRXLevjRMwzGeCu/vtBjskM5119j9U54woWqbu9PMx3RYVDb/4ajnOYbn4wB59X5hblV5J//Eo/SiqzktSAgX1OafzMiCyhgT5+ve5AMp1IHeJna5EAissKruiudXo1/uJD+z7r8h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758380; c=relaxed/simple;
	bh=IE8vtXqONENH4COQ0PuVZvYVtcuAddeFlS3FJx3SoOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LosLCelArB0+o1L+HwT2ahlXHxTCEaMtkAVeqA7oMIuXab7Iwm9LbTU/C2nMIRRCg50IIzGoBRKzHaUdgIGZFP6MmPspQ3DxeAHas+1uf//8uz88HnVZn8U4kIEnlvSxSFs3URnmTjCDrsirEwCnqsFGpNLy/Anbh6oC1oAA0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=NL3kCpUp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so1020441a91.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758378; x=1724363178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLZrJlXskda2l3oFJRKH6Sq0IZmFsCGWA7iCElqA/4c=;
        b=NL3kCpUpvUmSPhc38ShnmkpVd6jnU/qlTh5VBbDiIYt3Ygip8x4bi0CtuBYFe0VYY/
         D1/tdE5ss4kfJqaBS64psP1R690PZq9J9kbt476vtW8ET3EtDpuOl4eFIq9/xatMcmWE
         K/NUPu1nEFOyaK7I9DfX4qvtFk5qtt0y89aDnd8PUugxJnz85Q+ruWJBZoglS3SYXFGG
         /3kGBZI8fJ71QKcSNOu5wGdB0ORncISA9EzsXcykf9wcyGXnJTwLAtOk6E4EpfvyYQGG
         nyVR9BXoXCLEvx/ND38QqeNnOpzM8PO+ANwhzsE7lG8m2FPfG8zoOpSRsTE4KMFWCD2J
         0sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758378; x=1724363178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLZrJlXskda2l3oFJRKH6Sq0IZmFsCGWA7iCElqA/4c=;
        b=OwPFFaGi6KK9diKqKhFK6Uw/VCrhSECRjrWnbtv9CVz0jzJYMysaKi5j0nH74KilJq
         6DY0Tzq44n8ydCzcZRluLfnBBWCkans/R3iWS9I1xZiRYlhz8P9viO7htl6WiH1eGgNO
         l/1sUuxtQ3EHn6TIvUjPAh6NrXJ6m6puYbvtm5x1tZ206MkLKtmxRRhkAt8N6iy4Dpu1
         kMUEzJhyRb4I8sc02r0cRqMd2qHbNNTEZOUUCvF+7IU13NK+ImnNEdJ3S5J6rBGiFB4z
         rM1fJSaRPeWX3OxPqMCxHIVRvmDFoXyta6xKKv6XxsuAP9OOsxyi1+kcjRQwrM+Ysk+x
         oqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVYKSYP0Xr0dRyh7MfHKO7fNFcbV2IrYt02yMvdzTCE/J5i7/qJpcAbqHNRUREoXdY/77+4TpMb7AIuBg+8JgXgPqF+IMoB
X-Gm-Message-State: AOJu0Yzd0MAODT0Xw6bo56J4TrVYRscCnRh/J9BOF+BKWv3UCp1c1chY
	MkPXEjwxiHxeBZTFnB8lq1AivKFloTTCdx0NxEnentg3wl0IOOEGB5t/QJOO+g==
X-Google-Smtp-Source: AGHT+IFfZHPay4UM2Zgjj7fMaG+8wE7bnXu8gpOS1I2C23NeY2lN/sp8+hFaqIJysCficanria9aag==
X-Received: by 2002:a17:90a:d50a:b0:2c9:69cc:3a6f with SMTP id 98e67ed59e1d1-2d3e00ebf73mr1116758a91.31.1723758377765;
        Thu, 15 Aug 2024 14:46:17 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:17 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 04/12] flow_dissector: UDP encap infrastructure
Date: Thu, 15 Aug 2024 14:45:19 -0700
Message-Id: <20240815214527.2100137-5-tom@herbertland.com>
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

Add infrastructure for parsing into UDP encapsulations

Add function __skb_flow_dissect_udp that is called for IPPROTO_UDP.
The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing of UDP
encapsulations. If the flag is set when parsing a UDP packet then
a socket lookup is performed. The offset of the base network header,
either an IPv4 or IPv6 header, is tracked and passed to
__skb_flow_dissect_udp so that it can perform the socket lookup

If a socket is found and it's for a UDP encapsulation (encap_type is
set in the UDP socket) then a switch is performed on the encap_type
value (cases are UDP_ENCAP_* values)

An encapsulated packet in UDP can either be indicated by an
EtherType or IP protocol. The processing for dissecting a UDP encap
protocol returns a flow dissector return code. If
FLOW_DISSECT_RET_PROTO_AGAIN or FLOW_DISSECT_RET_IPPROTO_AGAIN is
returned then the corresponding  encapsulated protocol is dissected.
The nhoff is set to point to the header to process.  In the case
FLOW_DISSECT_RET_PROTO_AGAIN the EtherType protocol is returned and
the IP protocol is set to zero. In the case of
FLOW_DISSECT_RET_IPPROTO_AGAIN, the IP protocol is returned and
the EtherType protocol is returned unchanged

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/flow_dissector.h |   1 +
 net/core/flow_dissector.c    | 121 +++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e856..8a868a88a6f1 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -384,6 +384,7 @@ enum flow_dissector_key_id {
 #define FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL	BIT(1)
 #define FLOW_DISSECTOR_F_STOP_AT_ENCAP		BIT(2)
 #define FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP	BIT(3)
+#define FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS	BIT(4)
 
 struct flow_dissector_key {
 	enum flow_dissector_key_id key_id;
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 4b116119086a..160801b83d54 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -13,6 +13,7 @@
 #include <net/gre.h>
 #include <net/pptp.h>
 #include <net/tipc.h>
+#include <net/udp.h>
 #include <linux/igmp.h>
 #include <linux/icmp.h>
 #include <linux/sctp.h>
@@ -806,6 +807,117 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
+		       struct flow_dissector *flow_dissector,
+		       void *target_container, const void *data,
+		       int *p_nhoff, int hlen, __be16 *p_proto,
+		       u8 *p_ip_proto, int base_nhoff, unsigned int flags)
+{
+	enum flow_dissect_ret ret;
+	const struct udphdr *udph;
+	struct udphdr _udph;
+	struct sock *sk;
+	__u8 encap_type;
+	int nhoff;
+
+	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	switch (*p_proto) {
+	case htons(ETH_P_IP): {
+		const struct iphdr *iph;
+		struct iphdr _iph;
+
+		iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
+					   hlen, &_iph);
+		if (!iph)
+			return FLOW_DISSECT_RET_OUT_BAD;
+
+		udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
+					    hlen, &_udph);
+		if (!udph)
+			return FLOW_DISSECT_RET_OUT_BAD;
+
+		rcu_read_lock();
+		/* Look up the UDPv4 socket and get the encap_type */
+		sk = __udp4_lib_lookup(net, iph->saddr, udph->source,
+				       iph->daddr, udph->dest,
+				       inet_iif(skb), inet_sdif(skb),
+				       net->ipv4.udp_table, NULL);
+		if (!sk || !udp_sk(sk)->encap_type) {
+			rcu_read_unlock();
+			return FLOW_DISSECT_RET_OUT_GOOD;
+		}
+
+		encap_type = udp_sk(sk)->encap_type;
+		rcu_read_unlock();
+
+		break;
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6): {
+		const struct ipv6hdr *iph;
+		struct ipv6hdr _iph;
+
+		if (!likely(ipv6_bpf_stub))
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
+					   hlen, &_iph);
+		if (!iph)
+			return FLOW_DISSECT_RET_OUT_BAD;
+
+		udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
+					    hlen, &_udph);
+		if (!udph)
+			return FLOW_DISSECT_RET_OUT_BAD;
+
+		rcu_read_lock();
+		/* Look up the UDPv6 socket and get the encap_type */
+		sk = ipv6_bpf_stub->udp6_lib_lookup(net,
+				&iph->saddr, udph->source,
+				&iph->daddr, udph->dest,
+				inet_iif(skb), inet_sdif(skb),
+				net->ipv4.udp_table, NULL);
+
+		if (!sk || !udp_sk(sk)->encap_type) {
+			rcu_read_unlock();
+			return FLOW_DISSECT_RET_OUT_GOOD;
+		}
+
+		encap_type = udp_sk(sk)->encap_type;
+		rcu_read_unlock();
+
+		break;
+	}
+#endif /* CONFIG_IPV6 */
+	default:
+		return FLOW_DISSECT_RET_OUT_GOOD;
+	}
+
+	nhoff = *p_nhoff + sizeof(struct udphdr);
+	ret = FLOW_DISSECT_RET_OUT_GOOD;
+
+	switch (encap_type) {
+	default:
+		break;
+	}
+
+	switch (ret) {
+	case FLOW_DISSECT_RET_PROTO_AGAIN:
+		*p_ip_proto = 0;
+		fallthrough;
+	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
+		*p_nhoff = nhoff;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static void
 __skb_flow_dissect_tcp(const struct sk_buff *skb,
 		       struct flow_dissector *flow_dissector,
@@ -1046,6 +1158,7 @@ bool __skb_flow_dissect(const struct net *net,
 	int mpls_lse = 0;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
+	int base_nhoff;
 	bool ret;
 
 	if (!data) {
@@ -1168,6 +1281,7 @@ bool __skb_flow_dissect(const struct net *net,
 
 proto_again:
 	fdret = FLOW_DISSECT_RET_CONTINUE;
+	base_nhoff = nhoff;
 
 	switch (proto) {
 	case htons(ETH_P_IP): {
@@ -1635,6 +1749,13 @@ bool __skb_flow_dissect(const struct net *net,
 				       data, nhoff, hlen);
 		break;
 
+	case IPPROTO_UDP:
+		fdret = __skb_flow_dissect_udp(skb, net, flow_dissector,
+					       target_container, data, &nhoff,
+					       hlen, &proto, &ip_proto,
+					       base_nhoff, flags);
+		break;
+
 	case IPPROTO_ICMP:
 	case IPPROTO_ICMPV6:
 		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
-- 
2.34.1


