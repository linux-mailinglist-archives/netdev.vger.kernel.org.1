Return-Path: <netdev+bounces-114641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAAA9434EF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F121C22372
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142811BD002;
	Wed, 31 Jul 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WLqMsX3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1E1BE228
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446642; cv=none; b=iAkrIr+b+wiOo23APF62Qjo2L2Q0ZyMwh9Mf5R5bf5gpmNrWqRAC+DhJRv/wl/7Vd3L0USIMZhwcImRjOFE/zRD2GQqkFfiBcqnaULkv7ECphj3++Sdgrr0DxxjjN8K+kCqxd4/gJj567jSoDv94SFu81aQ7DXkEcWSaPEnC9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446642; c=relaxed/simple;
	bh=H1iQKMvlgsc1lvyQRC947XpooBlR1eb8C6Ifq/YKLM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDWUoisyI72AURHNNZV8xp1cMT2ohK31HAhw+qvmKbX5LMLy3MoxBk7FxcaZHAlDieFWuN2I0o+zjCDXtf2uQC/JOIxj7pKSiipWTpIOp5LPugrnfBf4GXNKp/CwR7h2+3R9QPu0pyAhKLozdUsdpH10dVlcItyhvnkpeVlXSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WLqMsX3p; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7104f939aaaso734704b3a.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446639; x=1723051439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imZmMFLAIJG5OavDJqtWshHLP2CLhvH70mtX5RPUROs=;
        b=WLqMsX3pOJjdG4NVyB/5h1+8cuxJMk/nlgQygHeJ3R1Sr4wJjPrJQlKNAZ75Nk8Bg4
         ICcet83SMIb0LYYuB77HI0amwK1ylTFtHeCm1sYRvN5hlbzYDRIIhWZe1KXivaRDA3ml
         QYC0vEQ+F9tx6bA2/wat5aP+ybiLIE1Z3rzNhB1Bx5FlnoJotThLWQMRgUaKOYQ8yNpX
         y6bnYc6OrKn++z7CEiNfDUdkbRmpSFLKBuFCrDNV0qYEenp1eae2MnCNZE9ZWBLKQx3O
         AgM2JididyzXGuizXIBc6oTLzGZwXuE4RBge9T2a7xitRWypCACT0bQVqa9ULYKzmKsV
         3I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446639; x=1723051439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imZmMFLAIJG5OavDJqtWshHLP2CLhvH70mtX5RPUROs=;
        b=rUFVTVyZTnexecFUxjUWJtgzU2BLZz1hB+siOCQqNX1VpnHW5DiTm8hYJnD/ODjg8f
         MzNZS4OgwRsDiDA1DbDDb+pq1wEPNEChSkXlZxF8ZsYgNnHY/fKYJzhFgHrg6FDXrFq0
         g7eIkg1/p446J/Vw5x5mP0JWazNLdWD2kg/kKVZh8GROk6qjUNpg/qU2GiBOQxscnKnU
         PvKb5PIn1yy7ew0bdJIBGO+ls1dvEf4IZ85KJU8L6zsgIdjZmspssNb36FBOi4DTdqJf
         HZCyDf2RsmDCqr3Lhq5ctFcci3IOcx+c6MiYGhjOlEQDKBjcZ3sae+XAfFcIhgVv22IM
         3vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEYSRPklOUMRbA24KjsWtaRJ6DyZzK2NAamkKgdjaTTQlynKf6BE+a8f6dIXLhvupXvMyTJmr/nB+X6ScHMINeylikIDWZ
X-Gm-Message-State: AOJu0Yxe1ToDdxxR6xa7K6jaUbcVC+PDb4l3eR0L6DGLNb6Jfmk+VGAI
	MDfZJBJvyYIStcGKs+Xmzh9PUNBdCspFG7H8D7XvX5eH9G7QYctyFMjlmgxUPA==
X-Google-Smtp-Source: AGHT+IEIWdXCuSRPBBXj5FEbh5Nct8SxXIXTuwJsPaPagjbFC2qFU+PTgeietc+QnjKy/y+DPrSK4g==
X-Received: by 2002:a05:6a00:1910:b0:70d:2af7:849d with SMTP id d2e1a72fcca58-70eceda313bmr12644931b3a.23.1722446639425;
        Wed, 31 Jul 2024 10:23:59 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:58 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 06/12] flow_dissector: UDP encap infrastructure
Date: Wed, 31 Jul 2024 10:23:26 -0700
Message-Id: <20240731172332.683815-7-tom@herbertland.com>
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
 net/core/flow_dissector.c    | 114 +++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

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
index 416f889c623c..006db3b893d0 100644
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
@@ -806,6 +807,110 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
+		       struct flow_dissector *flow_dissector,
+		       void *target_container, const void *data,
+		       int *p_nhoff, int hlen, __be16 *p_proto,
+		       u8 *p_ip_proto, int bpoff, unsigned int flags)
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
+		iph = __skb_header_pointer(skb, bpoff, sizeof(_iph), data,
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
+	case htons(ETH_P_IPV6): {
+		const struct ipv6hdr *iph;
+		struct ipv6hdr _iph;
+
+		iph = __skb_header_pointer(skb, bpoff, sizeof(_iph), data,
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
+		sk = __udp6_lib_lookup(net, &iph->saddr, udph->source,
+				       &iph->daddr, udph->dest,
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
@@ -1046,6 +1151,7 @@ bool __skb_flow_dissect(struct net *net,
 	int mpls_lse = 0;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
+	int bpoff;
 	bool ret;
 
 	if (!data) {
@@ -1168,6 +1274,7 @@ bool __skb_flow_dissect(struct net *net,
 
 proto_again:
 	fdret = FLOW_DISSECT_RET_CONTINUE;
+	bpoff = nhoff;
 
 	switch (proto) {
 	case htons(ETH_P_IP): {
@@ -1635,6 +1742,13 @@ bool __skb_flow_dissect(struct net *net,
 				       data, nhoff, hlen);
 		break;
 
+	case IPPROTO_UDP:
+		fdret = __skb_flow_dissect_udp(skb, net, flow_dissector,
+					       target_container, data, &nhoff,
+					       hlen, &proto, &ip_proto,
+					       bpoff, flags);
+		break;
+
 	case IPPROTO_ICMP:
 	case IPPROTO_ICMPV6:
 		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
-- 
2.34.1


