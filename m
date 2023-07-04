Return-Path: <netdev+bounces-15259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D47466AF
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 02:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EA5280E96
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413E367;
	Tue,  4 Jul 2023 00:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345D620
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 00:54:05 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF6D137
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:54:01 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qGUIm-000PWy-K8; Tue, 04 Jul 2023 10:53:57 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Jul 2023 08:53:49 +0800
Date: Tue, 4 Jul 2023 08:53:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Benedict Wong <benedictwong@google.com>,
	Lorenzo Colitti <lorenzo@google.com>, Yan Yan <evitayan@google.com>
Subject: [PATCH] xfrm: Silence warnings triggerable by bad packets
Message-ID: <ZKNtndEkrzhtmqkF@gondor.apana.org.au>
References: <20230630153759.3349299-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630153759.3349299-1-maze@google.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 08:37:58AM -0700, Maciej Żenczykowski wrote:
> Steffan, this isn't of course a patch meant for inclusion, instead just a WARN_ON hit report.
> The patch is simply what prints the following extra info:
> 
> xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->protocol:17
> 
> (note: XFRM_MODE_TUNNEL=1 IPPROTO_UDP=17)

Thanks for the report.  This patch should fix the warnings:

---8<---
After the elimination of inner modes, a couple of warnings that
were previously unreachable can now be triggered by malformed
inbound packets.

Fix this by:

1. Moving the setting of skb->protocol into the decap functions.
2. Returning -EINVAL when unexpected protocol is seen.

Reported-by: Maciej Żenczykowski<maze@google.com>
Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 815b38080401..d5ee96789d4b 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -180,6 +180,8 @@ static int xfrm4_remove_beet_encap(struct xfrm_state *x, struct sk_buff *skb)
 	int optlen = 0;
 	int err = -EINVAL;
 
+	skb->protocol = htons(ETH_P_IP);
+
 	if (unlikely(XFRM_MODE_SKB_CB(skb)->protocol == IPPROTO_BEETPH)) {
 		struct ip_beet_phdr *ph;
 		int phlen;
@@ -232,6 +234,8 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int err = -EINVAL;
 
+	skb->protocol = htons(ETH_P_IP);
+
 	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
 		goto out;
 
@@ -267,6 +271,8 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int err = -EINVAL;
 
+	skb->protocol = htons(ETH_P_IPV6);
+
 	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 		goto out;
 
@@ -296,6 +302,8 @@ static int xfrm6_remove_beet_encap(struct xfrm_state *x, struct sk_buff *skb)
 	int size = sizeof(struct ipv6hdr);
 	int err;
 
+	skb->protocol = htons(ETH_P_IPV6);
+
 	err = skb_cow_head(skb, size + skb->mac_len);
 	if (err)
 		goto out;
@@ -346,6 +354,7 @@ xfrm_inner_mode_encap_remove(struct xfrm_state *x,
 			return xfrm6_remove_tunnel_encap(x, skb);
 		break;
 		}
+		return -EINVAL;
 	}
 
 	WARN_ON_ONCE(1);
@@ -366,19 +375,6 @@ static int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb)
 		return -EAFNOSUPPORT;
 	}
 
-	switch (XFRM_MODE_SKB_CB(skb)->protocol) {
-	case IPPROTO_IPIP:
-	case IPPROTO_BEETPH:
-		skb->protocol = htons(ETH_P_IP);
-		break;
-	case IPPROTO_IPV6:
-		skb->protocol = htons(ETH_P_IPV6);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-
 	return xfrm_inner_mode_encap_remove(x, skb);
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

