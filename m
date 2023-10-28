Return-Path: <netdev+bounces-44985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E57DA5FC
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8ED91C20B01
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEFB8F7E;
	Sat, 28 Oct 2023 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5728EA
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:53:07 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93CF0
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:53:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 95FED205CD;
	Sat, 28 Oct 2023 10:53:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FMvToNej22R1; Sat, 28 Oct 2023 10:53:04 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1D31620590;
	Sat, 28 Oct 2023 10:53:04 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 1832980004A;
	Sat, 28 Oct 2023 10:53:04 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:53:03 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:53:03 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 694893183DF8; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/10] xfrm Fix use after free in __xfrm6_udp_encap_rcv.
Date: Sat, 28 Oct 2023 10:43:27 +0200
Message-ID: <20231028084328.3119236-10-steffen.klassert@secunet.com>
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

A recent patch changed xfrm6_udp_encap_rcv to not
free the skb itself anymore but fogot the case
where xfrm4_udp_encap_rcv is called subsequently.

Fix this by moving the call to xfrm4_udp_encap_rcv
from __xfrm6_udp_encap_rcv to xfrm6_udp_encap_rcv.

Fixes: 221ddb723d90 ("xfrm: Support GRO for IPv6 ESP in UDP encapsulation")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/xfrm4_input.c | 3 ++-
 net/ipv6/xfrm6_input.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 42879c5e026a..c54676998eb6 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -159,7 +159,6 @@ static int __xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
 	/* process ESP */
 	return 0;
 }
-EXPORT_SYMBOL(xfrm4_udp_encap_rcv);
 
 /* If it's a keepalive packet, then just eat it.
  * If it's an encapsulated packet, then pass it to the
@@ -184,6 +183,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 
 	return ret;
 }
+EXPORT_SYMBOL(xfrm4_udp_encap_rcv);
 
 struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 					struct sk_buff *skb)
@@ -223,6 +223,7 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 
 	return NULL;
 }
+EXPORT_SYMBOL(xfrm4_gro_udp_encap_rcv);
 
 int xfrm4_rcv(struct sk_buff *skb)
 {
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index ccf79b84c061..6e36e5047fba 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -80,9 +80,6 @@ static int __xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
 	__be32 *udpdata32;
 	u16 encap_type;
 
-	if (skb->protocol == htons(ETH_P_IP))
-		return xfrm4_udp_encap_rcv(sk, skb);
-
 	encap_type = READ_ONCE(up->encap_type);
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
@@ -169,6 +166,9 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int ret;
 
+	if (skb->protocol == htons(ETH_P_IP))
+		return xfrm4_udp_encap_rcv(sk, skb);
+
 	ret = __xfrm6_udp_encap_rcv(sk, skb, true);
 	if (!ret)
 		return xfrm6_rcv_encap(skb, IPPROTO_ESP, 0,
@@ -190,6 +190,9 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	struct sk_buff *pp = NULL;
 	int ret;
 
+	if (skb->protocol == htons(ETH_P_IP))
+		return xfrm4_gro_udp_encap_rcv(sk, head, skb);
+
 	offset = offset - sizeof(struct udphdr);
 
 	if (!pskb_pull(skb, offset))
-- 
2.34.1


