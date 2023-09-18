Return-Path: <netdev+bounces-34562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBC7A4A5A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBB4281CB3
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA51CFBF;
	Mon, 18 Sep 2023 13:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95D1CF94
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:00:22 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753491B5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:59:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qiDqg-00073l-4d; Mon, 18 Sep 2023 14:59:34 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: nharold@google.com,
	lorenzo@google.com,
	benedictwong@google.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 1/2] xfrm: move mark and oif flowi decode into common code
Date: Mon, 18 Sep 2023 14:59:08 +0200
Message-ID: <20230918125914.21391-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918125914.21391-1-fw@strlen.de>
References: <20230918125914.21391-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

flowi4_oif/flowi6_oif and mark are aliased to flowi_common field, i.e.
all can be used interchangeably.

Instead of duplicating place this in common code.
No functional changes intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c4c4fc29ccf5..a014783f6d8a 100644
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
@@ -3570,6 +3558,18 @@ int __xfrm_decode_session(struct sk_buff *skb, struct flowi *fl,
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
2.41.0


