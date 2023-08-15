Return-Path: <netdev+bounces-27649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84277CAC8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB28A281363
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B041094E;
	Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74710947
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14710C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9B7FE207A4;
	Tue, 15 Aug 2023 11:53:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlY82HEEu9zB; Tue, 15 Aug 2023 11:53:17 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A0AD52085F;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 925AA80004A;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:53:15 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:53:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 52A2A3183F14; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/11] xfrm: Silence warnings triggerable by bad packets
Date: Tue, 15 Aug 2023 11:53:03 +0200
Message-ID: <20230815095310.3310160-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815095310.3310160-1-steffen.klassert@secunet.com>
References: <20230815095310.3310160-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Herbert Xu <herbert@gondor.apana.org.au>

After the elimination of inner modes, a couple of warnings that
were previously unreachable can now be triggered by malformed
inbound packets.

Fix this by:

1. Moving the setting of skb->protocol into the decap functions.
2. Returning -EINVAL when unexpected protocol is seen.

Reported-by: Maciej Żenczykowski<maze@google.com>
Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

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
2.34.1


