Return-Path: <netdev+bounces-198669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE48ADD033
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DFC16677C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0723B633;
	Tue, 17 Jun 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR8v6SDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0C21C16D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171353; cv=none; b=jd/FI6sJOz3HDvK7f/RC63H7nmlaYps0uUVufsU947zIg7qTOu22usiCeTEbLCLjNtpNVRTNKJMl1t+CqVTqgmlWMIDe133GwsdSI+jmYX94JDG07Q8rgg4VKeW4pAY1wN6TR9kes7YjVJOtFgeDDy3HOy223bOFHT8JQj+e0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171353; c=relaxed/simple;
	bh=rCElYUuK749j0ej1ici717TvObssQT6j1/oiioR/czg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZf1dZnTuntoOKJuTdBCOqlaBFmOkQrlJDps3Gk2ixG1D3h76+Sb8ZNdSU/hcpCAN7PB9mztbXcAyWhRVPIo9tg/+yemWanGOU8GTyRozLFcZLG6KyFQeSEWgK842aNaei82qJDRuKu9WozRiQofeVzh8OBQSyThYuyjZKIdDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR8v6SDn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so9937720a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171350; x=1750776150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gN+NotgYC+wd4e9Rh6XiVZX3rCwODmfxrqZ0KtnULU=;
        b=GR8v6SDnehgZT/7BfLxEHAhXwHObnast7O3w9JdCWVdUbXDIFRBs/c+1rbh6Pv1aIH
         S9h0hiRxCZk9i4pAqX/VhhPygL9SSl9Wtq1tfWR6adr7tLVVeItJ1hrhfVDzbiVkta8a
         c2eq/ACKmucnF+XpYPeiOEi77arMx2TPk8vKKxGWzb6v+SmGYXTmzQTQnl+N502ORUGt
         ebDjyQJRyDEm1wNFxQ9+rjKr0gh/3eQOBY/a9zj+6O9cZBMZlB9FnxvD2VJ66CmdBa4o
         aR53S3gKh2P3fE4K6fElB6DAuVHkKKSV8kbwpXlmw0SB37hJ6LmVEBnnyV0tmTGP2elR
         VABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171350; x=1750776150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gN+NotgYC+wd4e9Rh6XiVZX3rCwODmfxrqZ0KtnULU=;
        b=X8CUL0UN5iaur03wVV1kc53JZZorf7NxfefjIgTtLPR7SgvIjTgQXaz/3ObF2aNuoP
         72Y2fnlmO6WegwU4+4jvcoiTP7qyKvfW1cwjG5hqBRXrCjuNHrF9KUa9WFW22movP0+t
         auTrdTYvU+JZ6UVELF0Y9hiQ4bEiPTvgZGs8bvB8c9OCSlb1PbDY7T97um20uxD3hIYo
         62C0HWXU0cq2Adj0UaLDx4ma98fIGg6EBRoMO+b+qAAXQXIwX2cZu6707bhsumnqtOFI
         sSY3wNPAHxPjkeyZzGOeTp43PidcwtVUwK790S5KfRj8IZQw2RLqP6rss8nnQHK5ib2h
         7S+g==
X-Gm-Message-State: AOJu0YxyMuJHlgSqd+YZXkVqaQGJTEu7fy3YeR4hxPRLi0CYaOiPSRfN
	3C/GR46l1EHEh5fDe/R5XgF06TSfA0dMRlPIVLLOYuadwPAEPoV9NH1a
X-Gm-Gg: ASbGncteP6/7oBJ0/gmJITXIYfPQyapS7/HZ8+sHHpEpDgmNT97OpVs40w91I8Ne9e+
	xMaTGIrSNDeJiVqty1dYzRkXuCAs0bXqyLjpPIu8O6cwv4V5QuAu6RDnyckOABNofBaT5dKdlLY
	479qVjZ7deoJS1L0s6pBvsk2+zbkN8VDj3g+UNYJOj1NW+B0vEpkNiVoA/4evftQ2ieXJo0Vfbu
	t4QhdJ6DgoGNNDxzUzOhExg9f6q+OL2LlsEQ8zdgbhmiM5LUwXcXfG4vkbEPrG8j8//UzAMdcRW
	raT624BYxK1EmyXuPBhcm03+yAdl8oN9lUeIwtdD9b7TL9/kiVW2YrUKjT1p9XpEGzPaxsIiLfu
	NcXBYmmb4zh2U
X-Google-Smtp-Source: AGHT+IG3alCrtTaIZa+QcB/No6ECGeOdIKHkRa5o0Ovs6XOjTELkDFi6hZYy8eyQOk9x0nYxFTOG0Q==
X-Received: by 2002:a05:6402:34d3:b0:607:e83a:d698 with SMTP id 4fb4d7f45d1cf-608d0834080mr11454372a12.2.1750171349889;
        Tue, 17 Jun 2025 07:42:29 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-608b4a93a01sm8078508a12.65.2025.06.17.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:29 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 01/17] net/ipv6: Introduce payload_len helpers
Date: Tue, 17 Jun 2025 16:40:00 +0200
Message-ID: <20250617144017.82931-2-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

The next commits will transition away from using the hop-by-hop
extension header to encode packet length for BIG TCP. Add wrappers
around ip6->payload_len that return the actual value if it's non-zero,
and calculate it from skb->len if payload_len is set to zero (and a
symmetrical setter).

The new helpers are used wherever the surrounding code supports the
hop-by-hop jumbo header for BIG TCP IPv6, or the corresponding IPv4 code
uses skb_ip_totlen (e.g., in include/net/netfilter/nf_tables_ipv6.h).

No behavioral change in this commit.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 include/linux/ipv6.h                       | 20 ++++++++++++++++++++
 include/net/ipv6.h                         |  2 --
 include/net/netfilter/nf_tables_ipv6.h     |  4 ++--
 net/bridge/br_netfilter_ipv6.c             |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c |  4 ++--
 net/ipv6/ip6_input.c                       |  2 +-
 net/ipv6/ip6_offload.c                     |  7 +++----
 net/ipv6/output_core.c                     |  7 +------
 net/netfilter/ipvs/ip_vs_xmit.c            |  2 +-
 net/netfilter/nf_conntrack_ovs.c           |  2 +-
 net/netfilter/nf_log_syslog.c              |  2 +-
 net/sched/sch_cake.c                       |  2 +-
 12 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5aeeed22f35b..bb53eca1f218 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -125,6 +125,26 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
 	       skb_network_header_len(skb);
 }
 
+static inline unsigned int ipv6_payload_len(const struct sk_buff *skb, const struct ipv6hdr *ip6)
+{
+	u32 len = ntohs(ip6->payload_len);
+
+	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
+	       len : skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr);
+}
+
+static inline unsigned int skb_ipv6_payload_len(const struct sk_buff *skb)
+{
+	return ipv6_payload_len(skb, ipv6_hdr(skb));
+}
+
+#define IPV6_MAXPLEN		65535
+
+static inline void ipv6_set_payload_len(struct ipv6hdr *ip6, unsigned int len)
+{
+	ip6->payload_len = len <= IPV6_MAXPLEN ? htons(len) : 0;
+}
+
 /* 
    This structure contains results of exthdrs parsing
    as offsets from skb->nh.
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 2ccdf85f34f1..38b332f3028e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -25,8 +25,6 @@ struct ip_tunnel_info;
 
 #define SIN6_LEN_RFC2133	24
 
-#define IPV6_MAXPLEN		65535
-
 /*
  *	NextHeader field of IPv6 header
  */
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index a0633eeaec97..c53ac00bb974 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -42,7 +42,7 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		return -1;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
 	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
@@ -86,7 +86,7 @@ static inline int nft_set_pktinfo_ipv6_ingress(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	if (pkt_len + sizeof(*ip6h) > pkt->skb->len) {
 		idev = __in6_dev_get(nft_in(pkt));
 		__IP6_INC_STATS(nft_net(pkt), idev, IPSTATS_MIB_INTRUNCATEDPKTS);
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index e0421eaa3abc..76ce70b4e7f3 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -58,7 +58,7 @@ int br_validate_ipv6(struct net *net, struct sk_buff *skb)
 	if (hdr->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 	if (hdr->nexthdr == NEXTHDR_HOP && nf_ip6_check_hbh_len(skb, &pkt_len))
 		goto drop;
 
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..e3fd414906a0 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -230,7 +230,7 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	if (hdr->version != 6)
 		return -1;
 
-	len = ntohs(hdr->payload_len) + sizeof(struct ipv6hdr) + nhoff;
+	len = ipv6_payload_len(skb, hdr) + sizeof(struct ipv6hdr) + nhoff;
 	if (skb->len < len)
 		return -1;
 
@@ -270,7 +270,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return NF_ACCEPT;
 
-		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
 		if (pskb_trim_rcsum(skb, len))
 			return NF_ACCEPT;
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 39da6a7ce5f1..60ff00ac27c1 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -260,7 +260,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	skb->transport_header = skb->network_header + sizeof(*hdr);
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 
 	/* pkt_len may be zero if Jumbo payload option is present */
 	if (pkt_len || hdr->nexthdr != NEXTHDR_HOP) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 9822163428b0..f9ceab9da23b 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -370,12 +370,11 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
 
 		iph->nexthdr = NEXTHDR_HOP;
-		iph->payload_len = 0;
-	} else {
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		iph->payload_len = htons(payload_len);
 	}
 
+	iph = (struct ipv6hdr *)(skb->data + nhoff);
+	ipv6_set_payload_len(iph, payload_len);
+
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 806d4b5dd1e6..cc7ca649eac1 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -123,12 +123,7 @@ EXPORT_SYMBOL(ip6_dst_hoplimit);
 
 int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	int len;
-
-	len = skb->len - sizeof(struct ipv6hdr);
-	if (len > IPV6_MAXPLEN)
-		len = 0;
-	ipv6_hdr(skb)->payload_len = htons(len);
+	ipv6_set_payload_len(ipv6_hdr(skb), skb->len - sizeof(struct ipv6hdr));
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
 	/* if egress device is enslaved to an L3 master device pass the
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 014f07740369..75c7e9b373c6 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -947,7 +947,7 @@ ip_vs_prepare_tunneled_skb(struct sk_buff *skb, int skb_af,
 		*next_protocol = IPPROTO_IPV6;
 		if (payload_len)
 			*payload_len =
-				ntohs(old_ipv6h->payload_len) +
+				ipv6_payload_len(skb, old_ipv6h) +
 				sizeof(*old_ipv6h);
 		old_dsfield = ipv6_get_dsfield(old_ipv6h);
 		*ttl = old_ipv6h->hop_limit;
diff --git a/net/netfilter/nf_conntrack_ovs.c b/net/netfilter/nf_conntrack_ovs.c
index 068e9489e1c2..a6988eeb1579 100644
--- a/net/netfilter/nf_conntrack_ovs.c
+++ b/net/netfilter/nf_conntrack_ovs.c
@@ -121,7 +121,7 @@ int nf_ct_skb_network_trim(struct sk_buff *skb, int family)
 		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
-		len = ntohs(ipv6_hdr(skb)->payload_len);
+		len = skb_ipv6_payload_len(skb);
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP) {
 			int err = nf_ip6_check_hbh_len(skb, &len);
 
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 86d5fc5d28e3..41503847d9d7 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -561,7 +561,7 @@ dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
 	nf_log_buf_add(m, "LEN=%zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
-		       ntohs(ih->payload_len) + sizeof(struct ipv6hdr),
+		       ipv6_payload_len(skb, ih) + sizeof(struct ipv6hdr),
 		       (ntohl(*(__be32 *)ih) & 0x0ff00000) >> 20,
 		       ih->hop_limit,
 		       (ntohl(*(__be32 *)ih) & 0x000fffff));
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 48dd8c88903f..e17dafbc4cb3 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1266,7 +1266,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    ipv6_addr_cmp(&ipv6h_check->daddr, &ipv6h->daddr))
 				continue;
 
-			seglen = ntohs(ipv6h_check->payload_len);
+			seglen = ipv6_payload_len(skb, ipv6h_check);
 		} else {
 			WARN_ON(1);  /* shouldn't happen */
 			continue;
-- 
2.49.0


