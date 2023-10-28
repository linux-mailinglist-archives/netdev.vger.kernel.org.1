Return-Path: <netdev+bounces-44979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9132A7DA5E6
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19E11C21077
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C858B65C;
	Sat, 28 Oct 2023 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA68F69
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:43:38 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C3128
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:43:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1C0BC205E5;
	Sat, 28 Oct 2023 10:43:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5n3frFx-wLz; Sat, 28 Oct 2023 10:43:34 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DB39A2084E;
	Sat, 28 Oct 2023 10:43:32 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id CFDF280004A;
	Sat, 28 Oct 2023 10:43:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:43:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:43:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6498E3183D18; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/10] xfrm: policy: replace session decode with flow dissector
Date: Sat, 28 Oct 2023 10:43:26 +0200
Message-ID: <20231028084328.3119236-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028084328.3119236-1-steffen.klassert@secunet.com>
References: <20231028084328.3119236-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

xfrm needs to populate ipv4/v6 flow struct for route lookup.
In the past there were several bugs in this code:

1. callers that forget to reload header pointers after
   xfrm_decode_session() (it may pull headers).
2. bugs in decoding where accesses past skb->data occurred.

Meanwhile network core gained a packet dissector as well.
This switches xfrm to the flow dissector.

Changes since RFC:
Drop ipv6 mobiliy header support, AFAIU noone uses this.

Drop extraction of flowlabel, replaced code doesn't set it either.

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/netdev/20230908120628.26164-3-fw@strlen.de/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 253 ++++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 158 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index da29be0b002f..6aea8b2f45e0 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -149,6 +149,21 @@ struct xfrm_pol_inexact_candidates {
 	struct hlist_head *res[XFRM_POL_CAND_MAX];
 };
 
+struct xfrm_flow_keys {
+	struct flow_dissector_key_basic basic;
+	struct flow_dissector_key_control control;
+	union {
+		struct flow_dissector_key_ipv4_addrs ipv4;
+		struct flow_dissector_key_ipv6_addrs ipv6;
+	} addrs;
+	struct flow_dissector_key_ip ip;
+	struct flow_dissector_key_icmp icmp;
+	struct flow_dissector_key_ports ports;
+	struct flow_dissector_key_keyid gre;
+};
+
+static struct flow_dissector xfrm_session_dissector __ro_after_init;
+
 static DEFINE_SPINLOCK(xfrm_if_cb_lock);
 static struct xfrm_if_cb const __rcu *xfrm_if_cb __read_mostly;
 
@@ -3367,191 +3382,74 @@ xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int star
 }
 
 static void
-decode_session4(struct sk_buff *skb, struct flowi *fl, bool reverse)
+decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reverse)
 {
-	const struct iphdr *iph = ip_hdr(skb);
-	int ihl = iph->ihl;
-	u8 *xprth = skb_network_header(skb) + ihl * 4;
 	struct flowi4 *fl4 = &fl->u.ip4;
 
 	memset(fl4, 0, sizeof(struct flowi4));
 
-	fl4->flowi4_proto = iph->protocol;
-	fl4->daddr = reverse ? iph->saddr : iph->daddr;
-	fl4->saddr = reverse ? iph->daddr : iph->saddr;
-	fl4->flowi4_tos = iph->tos & ~INET_ECN_MASK;
-
-	if (!ip_is_fragment(iph)) {
-		switch (iph->protocol) {
-		case IPPROTO_UDP:
-		case IPPROTO_UDPLITE:
-		case IPPROTO_TCP:
-		case IPPROTO_SCTP:
-		case IPPROTO_DCCP:
-			if (xprth + 4 < skb->data ||
-			    pskb_may_pull(skb, xprth + 4 - skb->data)) {
-				__be16 *ports;
-
-				xprth = skb_network_header(skb) + ihl * 4;
-				ports = (__be16 *)xprth;
-
-				fl4->fl4_sport = ports[!!reverse];
-				fl4->fl4_dport = ports[!reverse];
-			}
-			break;
-		case IPPROTO_ICMP:
-			if (xprth + 2 < skb->data ||
-			    pskb_may_pull(skb, xprth + 2 - skb->data)) {
-				u8 *icmp;
-
-				xprth = skb_network_header(skb) + ihl * 4;
-				icmp = xprth;
-
-				fl4->fl4_icmp_type = icmp[0];
-				fl4->fl4_icmp_code = icmp[1];
-			}
-			break;
-		case IPPROTO_GRE:
-			if (xprth + 12 < skb->data ||
-			    pskb_may_pull(skb, xprth + 12 - skb->data)) {
-				__be16 *greflags;
-				__be32 *gre_hdr;
-
-				xprth = skb_network_header(skb) + ihl * 4;
-				greflags = (__be16 *)xprth;
-				gre_hdr = (__be32 *)xprth;
-
-				if (greflags[0] & GRE_KEY) {
-					if (greflags[0] & GRE_CSUM)
-						gre_hdr++;
-					fl4->fl4_gre_key = gre_hdr[1];
-				}
-			}
-			break;
-		default:
-			break;
-		}
+	if (reverse) {
+		fl4->saddr = flkeys->addrs.ipv4.dst;
+		fl4->daddr = flkeys->addrs.ipv4.src;
+		fl4->fl4_sport = flkeys->ports.dst;
+		fl4->fl4_dport = flkeys->ports.src;
+	} else {
+		fl4->saddr = flkeys->addrs.ipv4.src;
+		fl4->daddr = flkeys->addrs.ipv4.dst;
+		fl4->fl4_sport = flkeys->ports.src;
+		fl4->fl4_dport = flkeys->ports.dst;
 	}
+
+	fl4->flowi4_proto = flkeys->basic.ip_proto;
+	fl4->flowi4_tos = flkeys->ip.tos;
+	fl4->fl4_icmp_type = flkeys->icmp.type;
+	fl4->fl4_icmp_type = flkeys->icmp.code;
+	fl4->fl4_gre_key = flkeys->gre.keyid;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
 static void
-decode_session6(struct sk_buff *skb, struct flowi *fl, bool reverse)
+decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reverse)
 {
 	struct flowi6 *fl6 = &fl->u.ip6;
-	int onlyproto = 0;
-	const struct ipv6hdr *hdr = ipv6_hdr(skb);
-	u32 offset = sizeof(*hdr);
-	struct ipv6_opt_hdr *exthdr;
-	const unsigned char *nh = skb_network_header(skb);
-	u16 nhoff = IP6CB(skb)->nhoff;
-	u8 nexthdr;
-
-	if (!nhoff)
-		nhoff = offsetof(struct ipv6hdr, nexthdr);
-
-	nexthdr = nh[nhoff];
 
 	memset(fl6, 0, sizeof(struct flowi6));
 
-	fl6->daddr = reverse ? hdr->saddr : hdr->daddr;
-	fl6->saddr = reverse ? hdr->daddr : hdr->saddr;
-
-	while (nh + offset + sizeof(*exthdr) < skb->data ||
-	       pskb_may_pull(skb, nh + offset + sizeof(*exthdr) - skb->data)) {
-		nh = skb_network_header(skb);
-		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
-
-		switch (nexthdr) {
-		case NEXTHDR_FRAGMENT:
-			onlyproto = 1;
-			fallthrough;
-		case NEXTHDR_ROUTING:
-		case NEXTHDR_HOP:
-		case NEXTHDR_DEST:
-			offset += ipv6_optlen(exthdr);
-			nexthdr = exthdr->nexthdr;
-			break;
-		case IPPROTO_UDP:
-		case IPPROTO_UDPLITE:
-		case IPPROTO_TCP:
-		case IPPROTO_SCTP:
-		case IPPROTO_DCCP:
-			if (!onlyproto && (nh + offset + 4 < skb->data ||
-			     pskb_may_pull(skb, nh + offset + 4 - skb->data))) {
-				__be16 *ports;
-
-				nh = skb_network_header(skb);
-				ports = (__be16 *)(nh + offset);
-				fl6->fl6_sport = ports[!!reverse];
-				fl6->fl6_dport = ports[!reverse];
-			}
-			fl6->flowi6_proto = nexthdr;
-			return;
-		case IPPROTO_ICMPV6:
-			if (!onlyproto && (nh + offset + 2 < skb->data ||
-			    pskb_may_pull(skb, nh + offset + 2 - skb->data))) {
-				u8 *icmp;
-
-				nh = skb_network_header(skb);
-				icmp = (u8 *)(nh + offset);
-				fl6->fl6_icmp_type = icmp[0];
-				fl6->fl6_icmp_code = icmp[1];
-			}
-			fl6->flowi6_proto = nexthdr;
-			return;
-		case IPPROTO_GRE:
-			if (!onlyproto &&
-			    (nh + offset + 12 < skb->data ||
-			     pskb_may_pull(skb, nh + offset + 12 - skb->data))) {
-				struct gre_base_hdr *gre_hdr;
-				__be32 *gre_key;
-
-				nh = skb_network_header(skb);
-				gre_hdr = (struct gre_base_hdr *)(nh + offset);
-				gre_key = (__be32 *)(gre_hdr + 1);
-
-				if (gre_hdr->flags & GRE_KEY) {
-					if (gre_hdr->flags & GRE_CSUM)
-						gre_key++;
-					fl6->fl6_gre_key = *gre_key;
-				}
-			}
-			fl6->flowi6_proto = nexthdr;
-			return;
-
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		case IPPROTO_MH:
-			offset += ipv6_optlen(exthdr);
-			if (!onlyproto && (nh + offset + 3 < skb->data ||
-			    pskb_may_pull(skb, nh + offset + 3 - skb->data))) {
-				struct ip6_mh *mh;
-
-				nh = skb_network_header(skb);
-				mh = (struct ip6_mh *)(nh + offset);
-				fl6->fl6_mh_type = mh->ip6mh_type;
-			}
-			fl6->flowi6_proto = nexthdr;
-			return;
-#endif
-		default:
-			fl6->flowi6_proto = nexthdr;
-			return;
-		}
+	if (reverse) {
+		fl6->saddr = flkeys->addrs.ipv6.dst;
+		fl6->daddr = flkeys->addrs.ipv6.src;
+		fl6->fl6_sport = flkeys->ports.dst;
+		fl6->fl6_dport = flkeys->ports.src;
+	} else {
+		fl6->saddr = flkeys->addrs.ipv6.src;
+		fl6->daddr = flkeys->addrs.ipv6.dst;
+		fl6->fl6_sport = flkeys->ports.src;
+		fl6->fl6_dport = flkeys->ports.dst;
 	}
+
+	fl6->flowi6_proto = flkeys->basic.ip_proto;
+	fl6->fl6_icmp_type = flkeys->icmp.type;
+	fl6->fl6_icmp_type = flkeys->icmp.code;
+	fl6->fl6_gre_key = flkeys->gre.keyid;
 }
 #endif
 
 int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl,
 			  unsigned int family, int reverse)
 {
+	struct xfrm_flow_keys flkeys;
+
+	memset(&flkeys, 0, sizeof(flkeys));
+	__skb_flow_dissect(net, skb, &xfrm_session_dissector, &flkeys,
+			   NULL, 0, 0, 0, FLOW_DISSECTOR_F_STOP_AT_ENCAP);
+
 	switch (family) {
 	case AF_INET:
-		decode_session4(skb, fl, reverse);
+		decode_session4(&flkeys, fl, reverse);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		decode_session6(skb, fl, reverse);
+		decode_session6(&flkeys, fl, reverse);
 		break;
 #endif
 	default:
@@ -4253,8 +4151,47 @@ static struct pernet_operations __net_initdata xfrm_net_ops = {
 	.exit = xfrm_net_exit,
 };
 
+static const struct flow_dissector_key xfrm_flow_dissector_keys[] = {
+	{
+		.key_id = FLOW_DISSECTOR_KEY_CONTROL,
+		.offset = offsetof(struct xfrm_flow_keys, control),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_BASIC,
+		.offset = offsetof(struct xfrm_flow_keys, basic),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_IPV4_ADDRS,
+		.offset = offsetof(struct xfrm_flow_keys, addrs.ipv4),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_IPV6_ADDRS,
+		.offset = offsetof(struct xfrm_flow_keys, addrs.ipv6),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_PORTS,
+		.offset = offsetof(struct xfrm_flow_keys, ports),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_GRE_KEYID,
+		.offset = offsetof(struct xfrm_flow_keys, gre),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_IP,
+		.offset = offsetof(struct xfrm_flow_keys, ip),
+	},
+	{
+		.key_id = FLOW_DISSECTOR_KEY_ICMP,
+		.offset = offsetof(struct xfrm_flow_keys, icmp),
+	},
+};
+
 void __init xfrm_init(void)
 {
+	skb_flow_dissector_init(&xfrm_session_dissector,
+				xfrm_flow_dissector_keys,
+				ARRAY_SIZE(xfrm_flow_dissector_keys));
+
 	register_pernet_subsys(&xfrm_net_ops);
 	xfrm_dev_init();
 	xfrm_input_init();
-- 
2.34.1


