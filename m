Return-Path: <netdev+bounces-225604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED8B9611A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F37440E63
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11921EE7B7;
	Tue, 23 Sep 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMoTGTQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E721F8724
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635274; cv=none; b=dVPO7pOO7PRXovxBgTsGHWvwvSKZlwaQSZ9ZNGPdxe2un7kYAyGuqCJl+bD6myjfKgUrYjc3M/rfcwXUBFB+XmKflvwV0ljtjRxImv8V6WH1J1gsDMLD6uVQL/nMwcC/KBwBcrl7RXodGl9JrxAJQQn0SiOzmDFbXn57aT4hzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635274; c=relaxed/simple;
	bh=QKf7QIrInvLZDc2un/JJKpKLFeHXRuqTInckz8RdOSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIOlIMqYAnLQnRm0ZeWXGPktY1zywZoHnOadPX08aw1Wo+u54CXpv5mp3F96/gu6Xo7O2JSgt9v+PEcmj0CtBX11a0bFD1buMVr5VtaeUChy2J8S4IB2E2kdBqswwAHJeR6M6M+4XI3dofOUPrinMKGDmLKhDmRUa8ywHsK2Ky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMoTGTQm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so2659761f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635271; x=1759240071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq0ZGafAaguoF52xuPyZmylW2O7cMtmnpBcivouTC2k=;
        b=FMoTGTQmQBQsdkssZPIK7wmnxBbsdTfCSnya8ux28FHzSoxlZchwSRhQzPb6H4M3Zg
         jDb+X317W3j1FpQPcqXIYgFeSXM/osR6XEGqKvcjLnTIM98y05mywmAUas54wgUEIdZ6
         NmuwezdFqSCaPI+g/9caSs/8jZ9dwpoo1yP07U9XJ518gG2u/ulJR9M0Bvjc/exr47wu
         H9affWtlEENhbeDp8EzpT3t6mnm4DJcQIrgeLiCoqLuJGO4yYtzF6cMvy8lAqe+vr/WA
         A4efmfduGP9F8IjNuGD9+J8k8hRjYw774830Qc2NpB2adsByVxwUcq4qwivjS/yxeq1J
         PWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635271; x=1759240071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq0ZGafAaguoF52xuPyZmylW2O7cMtmnpBcivouTC2k=;
        b=Scy0aHwoh98JO4nr5tpFLYKqy+uhvZ0zxwLNzopf/6nmbt6o3qdeyL5T8lWW77ldG9
         Y5c7dPM40yKG3FLB11Qi744sXZDorNtK4W8yxOFv1aMFlZFc8R2Oi/zIi/h0AVfH4xtl
         93baMAnbtXyl3pNCrTNDqzQEReRQcbpZ8T2+e+R4hsQChdNN7R7P/trmW3VxpcXwVthU
         /vRB0LvcbYEoykZNha8hPkEUVU/YwBKlX1MxYCHsDw1EphyolFBrkRYmyI2/+EsERHWC
         Ne+yMaeJ0XEp2nDL/JXYon0n/l1WNVJX18fmcuFxU9JMldoGq9fhQ8R0muASZvvQc0QR
         xo6Q==
X-Gm-Message-State: AOJu0Yz/UljLDGrVtS/5GbnQ0Huc82cm8ViLhUAd4rL/xHU7v5xPh9GN
	dZWobK39i+wejJIg2amJgGj7eiQr9yUCDjVDKbzaBBYhUDbqS+ZShKBC
X-Gm-Gg: ASbGncsSYzVQJYV4T9OvLcraVhP5btgcHG6GsCBAIFejN2Kjph02oUSg4WBA5St2X3V
	RawOt4dS1sVat9UK1onCgCJ7ZAEyNlxVI6t/O0+KAo6n3duanME93KskMRZzVQLXoBuFr395B1e
	AnsTNI2dXUTb2bDrJ4GWsv7jRJbEN7iGuprWUej3xyQQ/bh89+LDpMcc8eo/agLujCaIp7Nnvte
	RZ+rTngfAM52kYpbLvOG0V4F15NmGynCNZKAVzXNISFP1bIWdWAjFEOHJjNj5PVnMjNAHmwyjni
	yrKPSQWjOIYUsNuNhO3jyF29pB16hs6Gk1Mn1B64MYzO5K99giHbzVDRDR2oZxR4BytzSNUDkMA
	nmrZOtEGqrRt3IVg+hOyfSEcbzlPDDfi94I8/NIqbbbJTZi294mCl4CQQPxc=
X-Google-Smtp-Source: AGHT+IFaWx2ZCqre4/Kf2pXKPiHB+FXHTOAXEuTeW1VKPBfLKIN10ABHLDDFigZzhu5rFYqp1tBcWg==
X-Received: by 2002:a05:6000:1ace:b0:3ea:dd2b:5ef with SMTP id ffacd0b85a97d-405c57f88edmr2323912f8f.18.1758635270797;
        Tue, 23 Sep 2025 06:47:50 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee1095489asm23214306f8f.24.2025.09.23.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:47:50 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 01/17] net/ipv6: Introduce payload_len helpers
Date: Tue, 23 Sep 2025 16:47:26 +0300
Message-ID: <20250923134742.1399800-2-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

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
index 43b7bb828738..44c4b791eceb 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -126,6 +126,26 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
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
index 168ec07e31cc..2bcb981c91aa 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -262,7 +262,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	skb->transport_header = skb->network_header + sizeof(*hdr);
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 
 	/* pkt_len may be zero if Jumbo payload option is present */
 	if (pkt_len || hdr->nexthdr != NEXTHDR_HOP) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a..6762ce7909c8 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -372,12 +372,11 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
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
index 1c9b283a4132..cba1684a3f30 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -125,12 +125,7 @@ EXPORT_SYMBOL(ip6_dst_hoplimit);
 
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
index 95af252b2939..50501f3764f4 100644
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
index 32bacfc314c2..205f11c298ac 100644
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
2.50.1


