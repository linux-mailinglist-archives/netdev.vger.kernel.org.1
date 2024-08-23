Return-Path: <netdev+bounces-121508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B295D7BA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F08B235C8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94740194AF4;
	Fri, 23 Aug 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="H/iz6p9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4B1940B5
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444176; cv=none; b=PNAcrc7i+eLw8kkX4fjnX/WijG9OgBvoE/yYEy7DJCfg58Y1WmzzESjDfFuBdTKstifgzuXxJ7gys9QNbVhzXaRrqOM1ZtAywJlhoXZ38oOEqTiUHqy+gwHMwpkiRktChV8PXEf3xF4U2/6iMZk7F9AJy00UKZqkR3MvjJCy9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444176; c=relaxed/simple;
	bh=op1twAxSHU3hRk6SpGinbT6uqFzUumefX7loJ2CE2y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHZ4vnsdoYxEbUXydmKqpvB9sHiAbomZHBE5YKNXAwiQGxpdW09LtaLtBG/2LEJRitUHd4AfI2z6VPXYjkoDa7o6n8NN9BPdPMzhbLDuwOHvIYhgCD+uo5EPmQUYUrCDvauGVsPFSbR18oLOkqQTbfC0erzxztjtO4paaem9NLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=H/iz6p9w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714287e4083so2142799b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444174; x=1725048974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv0jy74cDRROYRqyx5fpkhp9fmqxEfPxq11gk0t/z6Q=;
        b=H/iz6p9wlP1gdGbC/3T/4NMMkdhN8THyYdvUyUksf/NNEcwE4gfpCXjTQOBzNu44yx
         Ik4IYVu0gpfBxKJsQyTz7eJ93LyKxPCsmN6JWzeHbj5rbJZRwklQVGq3J1bW4wAhtVyx
         LFVwY9adoWALeUXT2UERm9zQhKFB9HbwbFV2ET492P1ei+/3fRxfqO+IXeeNW+otPWtr
         hPjWOySPOnEsdT5W0JK3KB/Uhc2l73LLx3MZIc36mW3OO6PekIBMwdQuMCf9FvkxDHkf
         612HuA2BUTiQy54YtB5wCeJKKH/+lHgtQt3RhO5mCmwn9TtpvIi4zzqv5LD1cWPPui8u
         sdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444174; x=1725048974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv0jy74cDRROYRqyx5fpkhp9fmqxEfPxq11gk0t/z6Q=;
        b=sY7vDypyFO3F4V1xGCYhVZY8t+0A9A/g5R/qNBhiyC3HO+kmBmN3lbYFxOAhuqPgI4
         57UOxBqV2fH3x1KQGrAS/t8o7DPrl76zyvsmLmXl+jy7FROjyE+0nhRezPXkc+Z+OXtI
         UK7fUkIvea7I/UbN8oJgqcyYk1Eq791fOQBVs7AjQAyXb5jAkNRCiCllhO1aLOe4CV8u
         1m+jRhUHgBWreba4qpPQC6O3AEDcI4cM/H5tzSEVEIQ/VsUbaw4lgHn9HV2RIlbXLzvy
         8yKWxMqI9KtJrpjHtXMzU326E2/YqZ0mhQ38JXBJVusJ0/9DYVDtHiOd9IG4399IW74f
         15xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCNa+Izyvnp6uTlxb2Z5EyK+2FQSZDRF7Jd2dTg2mO8ZDnpdGEn+3qpSbbL6KgAnmIVEO0Jqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnp10eCYtc9IYtjVtf5skfvq3953+Qqh6O1y9XFgNRH/np0atI
	y1ASEfLgMgfn8GDVE6NYEXrb7w4x6UMlHCibo6pjyJ569Tf9AuYaRdrXwGW+xA==
X-Google-Smtp-Source: AGHT+IHOoibAEa0IvBwdYWnlq6KnZD6zWRJfAlagjFiipdD1/ynzgnielHQrvxFCf9vMfEG6mZHhNA==
X-Received: by 2002:a05:6a21:e89:b0:1ca:cccd:4a1c with SMTP id adf61e73a8af0-1cc8b5d898amr3002156637.43.1724444174052;
        Fri, 23 Aug 2024 13:16:14 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 05/13] flow_dissector: UDP encap infrastructure
Date: Fri, 23 Aug 2024 13:15:49 -0700
Message-Id: <20240823201557.1794985-6-tom@herbertland.com>
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
 net/core/flow_dissector.c    | 138 +++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

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
index 5170676a224c..f3134804a1db 100644
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
@@ -806,6 +807,134 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
+		       struct flow_dissector *flow_dissector,
+		       void *target_container, const void *data,
+		       int *p_nhoff, int hlen, __be16 *p_proto,
+		       u8 *p_ip_proto, int base_nhoff, unsigned int flags,
+		       unsigned int num_hdrs)
+{
+	enum flow_dissect_ret ret;
+	struct udphdr _udph;
+	int nhoff;
+
+	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	/* Check that the netns for the skb device is the same as the caller's,
+	 * and only dissect UDP if we haven't yet encountered any encapsulation.
+	 * The goal is to ensure that the socket lookup is being done in the
+	 * right netns. Encapsulations may push packets into different name
+	 * spaces, so this scheme is restricting UDP dissection to cases where
+	 * they are in the same name spaces or at least the original name space.
+	 * This should capture the majority of use cases for UDP encaps, and
+	 * if we do encounter a UDP encapsulation within a different namespace
+	 * then the only effect is we don't attempt UDP dissection
+	 */
+	if (dev_net(skb->dev) != net || num_hdrs > 0)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	switch (*p_proto) {
+#ifdef CONFIG_INET
+	case htons(ETH_P_IP): {
+		const struct udphdr *udph;
+		const struct iphdr *iph;
+		struct iphdr _iph;
+		struct sock *sk;
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
+		const struct udphdr *udph;
+		struct ipv6hdr _iph;
+		struct sock *sk;
+
+		if (!likely(ipv6_stub))
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
+		sk = ipv6_stub->udp6_lib_lookup(net,
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
+#endif /* CONFIG_INET */
+	default:
+		return FLOW_DISSECT_RET_OUT_GOOD;
+	}
+
+	nhoff = *p_nhoff + sizeof(_udph);
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
@@ -1046,6 +1175,7 @@ bool __skb_flow_dissect(const struct net *net,
 	int mpls_lse = 0;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
+	int base_nhoff;
 	bool ret;
 
 	if (!data) {
@@ -1168,6 +1298,7 @@ bool __skb_flow_dissect(const struct net *net,
 
 proto_again:
 	fdret = FLOW_DISSECT_RET_CONTINUE;
+	base_nhoff = nhoff;
 
 	switch (proto) {
 	case htons(ETH_P_IP): {
@@ -1649,6 +1780,13 @@ bool __skb_flow_dissect(const struct net *net,
 				       data, nhoff, hlen);
 		break;
 
+	case IPPROTO_UDP:
+		fdret = __skb_flow_dissect_udp(skb, net, flow_dissector,
+					       target_container, data, &nhoff,
+					       hlen, &proto, &ip_proto,
+					       base_nhoff, flags, num_hdrs);
+		break;
+
 	case IPPROTO_ICMP:
 	case IPPROTO_ICMPV6:
 		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
-- 
2.34.1


