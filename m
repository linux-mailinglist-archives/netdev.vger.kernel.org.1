Return-Path: <netdev+bounces-259906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNB+IYlgm2kmywMAu9opvQ
	(envelope-from <netdev+bounces-259906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:01:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E624F170419
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BDB303B4E0
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17835C1B4;
	Sun, 22 Feb 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCvGGU9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD535C18D
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790348; cv=none; b=bFLGg/DyrVYLgwFFAnqlWvHFYkr0jBl3JK5G4NpBye/pRKm8jD+Fgdqbg/HlI1TkwHCuWdHAfn2ntUqP0mvT3nvs+m/h8tXaF83lQfHfl5K785SVk4uvm42N46gnkRFzAbOCO7hgML0SYtp+ZN3yayuSORNNJr6gIQAMyDwFtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790348; c=relaxed/simple;
	bh=cZOvplO+acrDIC/bdnPngpv5Yz9c1Kq3wtTg6un4bYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS8oIo77vOAGMKBsxzyuMcX/BhzflILJD4Yt4JFOtEj8ZFZ9pI/WAs72TLFkZsfUnnSU2/HSjAhE/hnkUs5WU+KkwcIV7Px6FZlJ23nFeSP23SAj7uDIuPopyTJKoX0VlA3d+3b/aJd8lm17Kz/oEUX/ziOx9Vbs5zJXk1xcAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCvGGU9l; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so7128248a12.2
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790345; x=1772395145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAePdTgx4rGcv9Ww6vpjOV8zuSULm275AmiWMO10ySE=;
        b=FCvGGU9liqxHw6fvKq7qs0avRTuvxAYGrDvUWJpH1vY4A64kqOS4ZIzki0NAiSNRxW
         5/7AIIauDYk3G4xJ6ZwEltX3PtZJSIuvplh4untM49Nkshn4Nv9PaJDUV3rOx46YVtAP
         abH1TInjeVPsakv/Y9/h0LYEwvNX8c2GR1SiTBvPj30c7j8o5WDi0Ija44bIoa/9vyT8
         Oph62N8LDFiptHYRrHVzLjFt6l8A+2Qj+pjTYB9q3IFVLGVsCCQft0v6tbQD2tLh05ct
         3BUTU/fdrEDaXawblDJImWlDigQlAZL/VJpZxu9zRgvy46G1mUCqLsiBaNqiUKm3ckOp
         KIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790345; x=1772395145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAePdTgx4rGcv9Ww6vpjOV8zuSULm275AmiWMO10ySE=;
        b=W0Zr3d0ZKn0bvDGi97ZsQq/plN/GkX/q+y9mKZSl79VhIoyUqJvITttWElfCqyA5k8
         R0Wj+bucSpV7Bv8JX4lCHCZgKV66E4Ah/rJFPlCg5mdp7USJYtp+GhVhwrQNGMM3CnP4
         p9n9zu29y9SnyL9QWdEdEU4kaCRPYXF7Aguj/p7qkGi50qIHztfNeezDuCs57InEnLLC
         OBez+97MkDDYnL3gf9ydwpKOQmCNt5CP1sNcSkQzdbkf7crBCveOFts8hye+PSSudM/U
         DNLH2cz08RyttNAAjcykQMBf9QDFrOqpThSC6hut003SC36B3NiOK+2kdCaw+dv6E18P
         mIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUQwuu5GaTqNq857ePOqO9XEoGn6bQJM2hY5CCuDP70beFQyZhJIApaOFPTHIBO/JlT5nf1vNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bpoP//puvkzkVDqGB1DzTZzSUZ0A6/5iL7nDtNpDjqaJgZgz
	zcv64Srz05W4p2VeULYodUVGYm1jLF9G3yCSZW7WCQBgvW/u+0S/otLd
X-Gm-Gg: AZuq6aL6+BDRU3S9JHBw5NFyxU1bhvT4vNQWjb7Bz7Kow3HtaWhxM2PHG4qNxdkDG7y
	x5C5WezMpo2SGCr2cjMCpPDKKt42fQpZDRYLTXf8TsVnmgo/NehB9kgS5J5rgSDSkOv+CrGIg7b
	XnHTauGtIBi+goiDp+n76u6zNlMxi3Lj+Yh272UccAazNw7j9rpcXytHbX6hgyK0ClSjN5BXoPw
	VtfeOUPElk/gty9fOmPDijzPtfRjGVm7uSFuO74NXkSVmsIY1o4Ijjs6YlO67D93Af7QIVNEaNX
	SZWLNZ8VWP9rTuMLwjSij9knk8l8UnK+dbXpg7Do0NwlAwKqfAoKXc4ltX6aTzbGicAwSoEuSAZ
	j7BCVb8xkHyRxH/6+TMfLRZ2PhpULFFTpTb4WlkAC47/LUgRh4AjQ3Tbj+NkDeyGiI++REWacED
	RqTEoDdnNbj89SUPpBH4DhU3vkDLDMhu6ijMjVVxTFcssvOFsR/jOwlmX6uRKpxxDT+zBkN5SsV
	PXbPTDX9TpAME0YBZ8uecoNtYznl91lSySXRWy6tj/XtDxVG2eeeKM=
X-Received: by 2002:a17:907:e110:b0:b87:17df:4d65 with SMTP id a640c23a62f3a-b9081b4d8b5mr301491366b.51.1771790345213;
        Sun, 22 Feb 2026 11:59:05 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:04 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v18 nf-next 3/4] netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
Date: Sun, 22 Feb 2026 20:58:42 +0100
Message-ID: <20260222195845.77880-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222195845.77880-1-ericwouds@gmail.com>
References: <20260222195845.77880-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-259906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E624F170419
X-Rspamd-Action: no action

Add specifying an offset when calling nft_set_pktinfo_ipv4/6_validate()
for cases where the ip(v6) header is not located at skb_network_header().

When an offset is specified other then zero, do not set pkt->tprot and
the corresponding pkt->flags to not change rule processing. It does make
the offsets in pktinfo available for code that is not checking pkt->flags
to use the offsets, like nft_flow_offload_eval().

Existing behaviour for a rule like "tcp dport 22 accept" is not changed
when, for instance, a PPPoE packet is being matched inside a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_tables_ipv4.h | 21 +++++++++++++--------
 include/net/netfilter/nf_tables_ipv6.h | 21 +++++++++++++--------
 net/netfilter/nft_chain_filter.c       |  8 ++++----
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
index fcf967286e37..bd354937134f 100644
--- a/include/net/netfilter/nf_tables_ipv4.h
+++ b/include/net/netfilter/nf_tables_ipv4.h
@@ -16,12 +16,12 @@ static inline void nft_set_pktinfo_ipv4(struct nft_pktinfo *pkt)
 	pkt->fragoff = ntohs(ip->frag_off) & IP_OFFSET;
 }
 
-static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
+static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
 	struct iphdr *iph, _iph;
 	u32 len, thoff, skb_len;
 
-	iph = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb),
+	iph = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb) + nhoff,
 				 sizeof(*iph), &_iph);
 	if (!iph)
 		return -1;
@@ -31,7 +31,7 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 
 	len = iph_totlen(pkt->skb, iph);
 	thoff = iph->ihl * 4;
-	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
+	skb_len = pkt->skb->len - skb_network_offset(pkt->skb) - nhoff;
 
 	if (skb_len < len)
 		return -1;
@@ -40,17 +40,22 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 	else if (thoff < sizeof(*iph))
 		return -1;
 
-	pkt->flags = NFT_PKTINFO_L4PROTO;
-	pkt->tprot = iph->protocol;
-	pkt->thoff = skb_network_offset(pkt->skb) + thoff;
+	if (!nhoff) {
+		pkt->flags = NFT_PKTINFO_L4PROTO;
+		pkt->tprot = iph->protocol;
+	} else {
+		pkt->flags = 0;
+		pkt->tprot = 0;
+	}
+	pkt->thoff = skb_network_offset(pkt->skb) + nhoff + thoff;
 	pkt->fragoff = ntohs(iph->frag_off) & IP_OFFSET;
 
 	return 0;
 }
 
-static inline void nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
+static inline void nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
-	if (__nft_set_pktinfo_ipv4_validate(pkt) < 0)
+	if (__nft_set_pktinfo_ipv4_validate(pkt, nhoff) < 0)
 		nft_set_pktinfo_unspec(pkt);
 }
 
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index c53ac00bb974..1e84a891f268 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -24,17 +24,17 @@ static inline void nft_set_pktinfo_ipv6(struct nft_pktinfo *pkt)
 	pkt->fragoff = frag_off;
 }
 
-static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
+static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	unsigned int flags = IP6_FH_F_AUTH;
 	struct ipv6hdr *ip6h, _ip6h;
-	unsigned int thoff = 0;
+	unsigned int thoff = nhoff;
 	unsigned short frag_off;
 	u32 pkt_len, skb_len;
 	int protohdr;
 
-	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb),
+	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb) + nhoff,
 				  sizeof(*ip6h), &_ip6h);
 	if (!ip6h)
 		return -1;
@@ -43,7 +43,7 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 		return -1;
 
 	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
-	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
+	skb_len = pkt->skb->len - skb_network_offset(pkt->skb) - nhoff;
 	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
 
@@ -51,8 +51,13 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	if (protohdr < 0 || thoff > U16_MAX)
 		return -1;
 
-	pkt->flags = NFT_PKTINFO_L4PROTO;
-	pkt->tprot = protohdr;
+	if (!nhoff) {
+		pkt->flags = NFT_PKTINFO_L4PROTO;
+		pkt->tprot = protohdr;
+	} else {
+		pkt->flags = 0;
+		pkt->tprot = 0;
+	}
 	pkt->thoff = thoff;
 	pkt->fragoff = frag_off;
 
@@ -62,9 +67,9 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 #endif
 }
 
-static inline void nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
+static inline void nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
-	if (__nft_set_pktinfo_ipv6_validate(pkt) < 0)
+	if (__nft_set_pktinfo_ipv6_validate(pkt, nhoff) < 0)
 		nft_set_pktinfo_unspec(pkt);
 }
 
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd..d4d5eadaba9c 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -238,10 +238,10 @@ nft_do_chain_bridge(void *priv,
 
 	switch (eth_hdr(skb)->h_proto) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt);
+		nft_set_pktinfo_ipv4_validate(&pkt, 0);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt);
+		nft_set_pktinfo_ipv6_validate(&pkt, 0);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
@@ -293,10 +293,10 @@ static unsigned int nft_do_chain_netdev(void *priv, struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt);
+		nft_set_pktinfo_ipv4_validate(&pkt, 0);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt);
+		nft_set_pktinfo_ipv6_validate(&pkt, 0);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
-- 
2.53.0


