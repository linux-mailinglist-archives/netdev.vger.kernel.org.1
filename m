Return-Path: <netdev+bounces-120726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE095A679
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3981C2266C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60054178CE4;
	Wed, 21 Aug 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="KYpiWJer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB6178372
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275365; cv=none; b=U+zTkxZOmdQG0cmIIoU+EnziXpDtXoVoy7KPGT+VOUZ8H/oUwaekucfi7bf0xEEdih2Vi8GkMd1m8ji/yMfwf3hbc//fuVh4iKUHsJYjYgLMnEEoNdzq93kufSipiczGQ+Ra4jN9lON4tijGc/5OGY5vn9VczeIaxt9ngTeyZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275365; c=relaxed/simple;
	bh=jB9SApiU0tAER5vbQmJHPWj6fZXj0wdImfazAaQNBCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JzbozKHf74YBjvWSAjC3CriyYbqJJx3deSfnVvKO84dZBnVKqjL5AH29y+u026r02Ks6Ov7up5kmj3ofyIAZiUo4MpdyCdXWP5vjPVJZ0TXka5fW5TXUihJlHwy5lICbM0ZtlcHm2G2dTWBw2JbrU25Uu4eMlOrJusSiqe83J3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=KYpiWJer; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20219a0fe4dso1320895ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275363; x=1724880163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ybmEWSVMNWJwoyiaxSSrSx1YuGX6mif+IMJnoCq4og=;
        b=KYpiWJer7aOxJfjgSYzDoiKzp4tf67N1XYHdwXmTWwqSgzWaHzZ4JZ/iSWzMtNoCxz
         GgMsvzacwm0NF877t3jovO+mnyYPxbAyGQ0eKxMvk+gQAeHxa9hXDTe2nH589xClYhSW
         E7Iu+8WS47IzhpT3Sf2o/q2diwnp3zUQD/lkCNx/xYIuCI3RuBDRDeVRuqggh5Z9JoJ3
         AqtRTWQ+klsekMX0frrFBtJIV+Nvx3Khln0Y7pXHesqSewi/FN8nWec+nbfsdbuECmLx
         mTwIDFs8+Qx9X8Yyp9rcDV1LYzn8HU2ifa/cguzuFaxnfuKRk/1m77FACyM6Q1bN1iPB
         VaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275363; x=1724880163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ybmEWSVMNWJwoyiaxSSrSx1YuGX6mif+IMJnoCq4og=;
        b=k7OqYP8U5IBSK0yZ3Q+QvKdShQ7xrYgfQ2Dd09SifYimeWtqn9OXpY8tKeItz0Sxxc
         ZJBLRvJMh5gfdt2hEuVpVWASOlcpKvsADRm70BYH4CflEal5juEUZk+XYCGh+uguXzby
         PxQjZpnvaxrwkuNYc/H/UJDgKVTKZXJXkHnfdRueiAJXqJYOUX+Q37c49jeJMJv54rT7
         zj4qUyds19tZId0xEfaYQS9NLkF7+L0FvxrEF6n+vlSXPJrev0mYAAnoBFOfEk9hEyH9
         i7DfPGDJLClVi9/osYUOjZRIg0ydc2yIqVksB16HqV24GFeYhxmqc/EAsPuk1SeT0//L
         1euw==
X-Forwarded-Encrypted: i=1; AJvYcCUkmeOIAbTpbCtHcEBhDnhRtjWS0riFLNTlwPJ4bHuEkLZ1oUjZCXpkIpKVjQ+Quc9bmalxzaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRAjJtOGYwaMtVNsliumOr2cWEmZGvortD47iCAJyUrPL4m9v
	mo1b2JtI3Q7GWu9fDRvkbyzWCD95gSoa8HQ6ZA0PQuw4QCnmEA5kB+cYmA8WVg==
X-Google-Smtp-Source: AGHT+IG9+X14WEqdtQsvr4xCnkYsw7ZtpxYZS16ZtQutl9BAgR8l1Uqave/nQXRbdwG07BLScKaNOA==
X-Received: by 2002:a17:902:facc:b0:201:fcd1:e430 with SMTP id d9443c01a7336-20367af1ec9mr32615315ad.11.1724275362601;
        Wed, 21 Aug 2024 14:22:42 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:42 -0700 (PDT)
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
Subject: [PATCH net-next v3 05/13] flow_dissector: UDP encap infrastructure
Date: Wed, 21 Aug 2024 14:22:04 -0700
Message-Id: <20240821212212.1795357-6-tom@herbertland.com>
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
 net/core/flow_dissector.c    | 137 +++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

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
index 5170676a224c..a5b1b1badc67 100644
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
@@ -806,6 +807,133 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
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
+	const struct udphdr *udph;
+	struct udphdr _udph;
+	struct sock *sk;
+	__u8 encap_type;
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
@@ -1046,6 +1174,7 @@ bool __skb_flow_dissect(const struct net *net,
 	int mpls_lse = 0;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
+	int base_nhoff;
 	bool ret;
 
 	if (!data) {
@@ -1168,6 +1297,7 @@ bool __skb_flow_dissect(const struct net *net,
 
 proto_again:
 	fdret = FLOW_DISSECT_RET_CONTINUE;
+	base_nhoff = nhoff;
 
 	switch (proto) {
 	case htons(ETH_P_IP): {
@@ -1649,6 +1779,13 @@ bool __skb_flow_dissect(const struct net *net,
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


