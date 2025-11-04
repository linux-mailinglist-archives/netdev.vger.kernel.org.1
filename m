Return-Path: <netdev+bounces-235512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8CC31AD7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D11888DA3
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167AC3328F0;
	Tue,  4 Nov 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNS+SYPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E58330B3A
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268301; cv=none; b=U1NpDpknbefefslaHRxURDw5OiRUuqu0312TBEO3DypnSfn173R0k6XTz2t75BmHgrYZ68mqWIs/VAI/1Axnq1m+1e2DST0c89JesHySt0PSpOO985aWXPPCzqmA5aUTwK3Rd2GnDhIBVEFKJdso9wxac3MQLifqSTTOYizsmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268301; c=relaxed/simple;
	bh=Fy0W9gxzWa5phBf2U5OgVY5Lg4WAKVgwOkuBRbqjIao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSjwHHl8TPDtyEBjtGr2qsMJzzYoDFbs8dyamx25UknVqtZtk9jt6DZtFK01BjkMMAkuZopftdhXfiJAqidu4rVMIbRR44Sr7adH2Z1VM2rTM+LnSJCfPvnDeK/jAq+6njfyoTuhFuNdqW5AbM03tsVeNgCWKlXUv9jub1XEulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNS+SYPM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso1349937166b.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268297; x=1762873097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqNOLZew1B/4/qGT1ZskVp7oVfq0YezN6w+W/pCgZf4=;
        b=bNS+SYPMc1sFdMhsh9O04yArQ10uCkepSyzHetTyHQUXDN6T9bt3/WPuopH38VfpYm
         ZimlaXRBkNKe7QOqOsjKUZJ3LMPYu5pJM/HPlK+3z1LftoeuVnBjMv6ruVRToTNAfUCT
         chql+gNbck4hE6ZLHBiUZLJnqQBwLCPC72cCS4x1z7Rm7OasViqxBWp8Rh6uYuV8ap4P
         iG3GcgOnYs5SOvTp6z06lWmZWd8lBGnpbBcvdnuuZD4vw2abWacycXFWTg35W9SyhGss
         ElaEWaJdsChIpd62mXQ9n4ReworutUGJRZHzLJufaKjz4PqRzOg24S2zGL/weNvGZSrX
         6wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268297; x=1762873097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqNOLZew1B/4/qGT1ZskVp7oVfq0YezN6w+W/pCgZf4=;
        b=SeM/75EjijYKga3s5bIQDcozHPrOPwUydMGTv4UrCvXsTItLqHs+ixsJ5gzjY+O55N
         h9G7WCqi2bdMa6X2QoaKLvJztt1IUNWOshrSqumdHx4XsJBYGPyHfOL/fzH+HkXZfvRv
         h+8YO7e+e9+H2U7uGJrY4aUvapMI+tl/zdNeicCjcbAmvV4K5DL0Z/7tl9bgiOXOGHtI
         F6YeTHwLFBzgZLJ5cIY4z9WadmA1TLtl3SfXObORTQVVrb7KSBQj1V/zQ3D0ObR6jt6E
         V8fmY+6J53OPCXfMt0ql5n0bRITeWx205bXzvikoGY3EaxJ9Hgl2KZyz1OBhj4IUWe/y
         UEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpEPWE33aIWyEzGWSBZV0Jy0Wl2v2vM62OTidxetEhUUwMqEvE7PGNnfVwX7TU3KGhkYjt6b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAy+C+dSHtQc3QWRGcB9+t/dBEIeZMonAyzAO4XjjMHVhgCIU
	upcAEIjZxA/Gx/Au7dW7yLaHCpoNkRE8emauvCNO55kYHaXlxcjVcIHf
X-Gm-Gg: ASbGncsf5gGHZYi1bjdl6LfnPCv8/VN9NyPuxOQ005o+jqUGI2MVMV318eozyjf4b0f
	cwxlQzO9P9xiLlFCnqJYO7R8269mb3Zm54YQng0Nq6IuBQ+nldprGN6TQE84RMtWMhx19hnzO4J
	1jGu7CDmhiEisAORw4y271ygoUZ3E4p+uISG6KFgkqCKq6kgTCdRuJlwPOAmuOCuFgzvy2nI2PV
	T5i7aaZkbpwmS3nfEU6NvPUDQc/BT3Cs7wC9Re6d8dodP2U6+StzcKK7iZpw0BPn7BpnGijRbdU
	5e3KPjArAeHUjubGSyCVIz9sP5uEqmTpHWObbRtK7Wv5JrQqFWz79kk7s87t4+DQ+kv0cMk+/16
	ZURy7rjFJPVADbrcKm05K+jc600Op/1gngB/5SpLJ9mH/a601r1uivCklpoqeFz8gMepx7gjWvm
	nZ/Trh1TAvZdKA2mrCxijIHfSH5UOyfDIwZ+B14yuBZByQDM7zQnEMDX86YWengWthkkrsXPE=
X-Google-Smtp-Source: AGHT+IFVxavNltv6OT0DR+ikoiqQd1j38ojj7cLxan/xShMoKGlMagjyohBNUH/d8xEtKzERUxNvHg==
X-Received: by 2002:a17:907:60c9:b0:b65:7f88:72d5 with SMTP id a640c23a62f3a-b7216e61f39mr377047266b.28.1762268296988;
        Tue, 04 Nov 2025 06:58:16 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm232681666b.46.2025.11.04.06.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:16 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v16 nf-next 3/3] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue,  4 Nov 2025 15:57:28 +0100
Message-ID: <20251104145728.517197-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251104145728.517197-1-ericwouds@gmail.com>
References: <20251104145728.517197-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
and packets encapsulated in single 802.1q or 802.1ad.

When implementing the software bridge-fastpath and testing all possible
encapulations, there can be more encapsulations:

The packet could (also) be encapsulated in PPPoE, or the packet could be
encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
encapsulation.

nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
known from the conntrack-tuplehash. To access the header it uses
nft_thoff(), but for these packets it returns zero.

Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
offsets, without setting pkt->tprot and the corresponding pkt->flags.

This will not change rule processing, but does make these offsets
available for code that is not checking pkt->flags to use the offsets,
like nft_flow_offload_eval().

Existing behaviour for a rule like "tcp dport 22 accept" is not changed
when, for instance, a PPPoE packet is being matched.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 58 ++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd..1f3ae5687917 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -227,16 +227,64 @@ static inline void nft_chain_filter_inet_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV6 */
 
 #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
+				  const struct nf_hook_state *state,
+				  __be16 *proto)
+{
+	nft_set_pktinfo(pkt, skb, state);
+
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			return -1;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			return -1;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		skb_set_network_header(skb, VLAN_HLEN);
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int
 nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
+	__be16 proto;
+	int offset;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	proto = eth_hdr(skb)->h_proto;
 
-	switch (eth_hdr(skb)->h_proto) {
+	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
+	if (offset < 0)
+		return NF_ACCEPT;
+
+	switch (proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,6 +296,12 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
+	if (offset) {
+		skb_reset_network_header(skb);
+		pkt.flags = 0;
+		pkt.tprot = 0;
+	}
+
 	return nft_do_chain(&pkt, priv);
 }
 
-- 
2.50.0


