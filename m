Return-Path: <netdev+bounces-44981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EAF7DA5E8
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB221C211F1
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5A58F5D;
	Sat, 28 Oct 2023 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B039477
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:43:40 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F5126
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:43:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 507DD20520;
	Sat, 28 Oct 2023 10:43:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dM84b9TB3EIX; Sat, 28 Oct 2023 10:43:36 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5F2CC2085A;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5469B80004A;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:43:33 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:43:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5EFAA3183DB7; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/10] xfrm: move mark and oif flowi decode into common code
Date: Sat, 28 Oct 2023 10:43:25 +0200
Message-ID: <20231028084328.3119236-8-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

flowi4_oif/flowi6_oif and mark are aliased to flowi_common field, i.e.
all can be used interchangeably.

Instead of duplicating place this in common code.
No functional changes intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 064d1744fa36..da29be0b002f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3373,14 +3373,8 @@ decode_session4(struct sk_buff *skb, struct flowi *fl, bool reverse)
 	int ihl = iph->ihl;
 	u8 *xprth = skb_network_header(skb) + ihl * 4;
 	struct flowi4 *fl4 = &fl->u.ip4;
-	int oif = 0;
-
-	if (skb_dst(skb) && skb_dst(skb)->dev)
-		oif = skb_dst(skb)->dev->ifindex;
 
 	memset(fl4, 0, sizeof(struct flowi4));
-	fl4->flowi4_mark = skb->mark;
-	fl4->flowi4_oif = reverse ? skb->skb_iif : oif;
 
 	fl4->flowi4_proto = iph->protocol;
 	fl4->daddr = reverse ? iph->saddr : iph->daddr;
@@ -3451,7 +3445,6 @@ decode_session6(struct sk_buff *skb, struct flowi *fl, bool reverse)
 	struct ipv6_opt_hdr *exthdr;
 	const unsigned char *nh = skb_network_header(skb);
 	u16 nhoff = IP6CB(skb)->nhoff;
-	int oif = 0;
 	u8 nexthdr;
 
 	if (!nhoff)
@@ -3459,12 +3452,7 @@ decode_session6(struct sk_buff *skb, struct flowi *fl, bool reverse)
 
 	nexthdr = nh[nhoff];
 
-	if (skb_dst(skb) && skb_dst(skb)->dev)
-		oif = skb_dst(skb)->dev->ifindex;
-
 	memset(fl6, 0, sizeof(struct flowi6));
-	fl6->flowi6_mark = skb->mark;
-	fl6->flowi6_oif = reverse ? skb->skb_iif : oif;
 
 	fl6->daddr = reverse ? hdr->saddr : hdr->daddr;
 	fl6->saddr = reverse ? hdr->daddr : hdr->saddr;
@@ -3570,6 +3558,18 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
 		return -EAFNOSUPPORT;
 	}
 
+	fl->flowi_mark = skb->mark;
+	if (reverse) {
+		fl->flowi_oif = skb->skb_iif;
+	} else {
+		int oif = 0;
+
+		if (skb_dst(skb) && skb_dst(skb)->dev)
+			oif = skb_dst(skb)->dev->ifindex;
+
+		fl->flowi_oif = oif;
+	}
+
 	return security_xfrm_decode_session(skb, &fl->flowi_secid);
 }
 EXPORT_SYMBOL(__xfrm_decode_session);
-- 
2.34.1


