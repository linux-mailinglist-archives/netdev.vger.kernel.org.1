Return-Path: <netdev+bounces-28003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E277DDFA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822262817F5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E9FBF3;
	Wed, 16 Aug 2023 09:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232EFBF1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:57:30 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C1C1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:57:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3F6DE20799;
	Wed, 16 Aug 2023 11:57:28 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OI1GhXPR---5; Wed, 16 Aug 2023 11:57:27 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 939B5207B0;
	Wed, 16 Aug 2023 11:57:27 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8DFD780004A;
	Wed, 16 Aug 2023 11:57:27 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:57:27 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 11:57:26 +0200
Date: Wed, 16 Aug 2023 11:57:21 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: Eyal Birger <eyal.birger@gmail.com>, Antony Antony
	<antony.antony@secunet.com>, <devel@linux-ipsec.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 ipsec-next 1/3] xfrm: Use the XFRM_GRO to indicate a GRO
 call on input.
Message-ID: <5ecd7fd867b0a90173f79dc8d6b07fd043fd20e6.1692172297.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1692172297.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1692172297.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Steffen Klassert <steffen.klassert@secunet.com>

This is needed to support GRO for ESP in UDP encapsulation.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/ipv4/esp4_offload.c | 2 +-
 net/ipv6/esp6_offload.c | 2 +-
 net/xfrm/xfrm_input.c   | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 3969fa805679..77bb01032667 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -76,7 +76,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,

 	/* We don't need to handle errors from xfrm_input, it does all
 	 * the error handling and frees the resources on error. */
-	xfrm_input(skb, IPPROTO_ESP, spi, -2);
+	xfrm_input(skb, IPPROTO_ESP, spi, 0);

 	return ERR_PTR(-EINPROGRESS);
 out_reset:
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 75c02992c520..ee5f5abdb503 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -103,7 +103,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,

 	/* We don't need to handle errors from xfrm_input, it does all
 	 * the error handling and frees the resources on error. */
-	xfrm_input(skb, IPPROTO_ESP, spi, -2);
+	xfrm_input(skb, IPPROTO_ESP, spi, 0);

 	return ERR_PTR(-EINPROGRESS);
 out_reset:
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 39fb91ff23d9..7d4a0bb9ca8d 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -466,7 +466,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;

-	if (encap_type < 0) {
+	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
 		x = xfrm_input_state(skb);

 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
@@ -489,9 +489,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
-
-		/* encap_type < -1 indicates a GRO call. */
-		encap_type = 0;
+		/* GRO call */
 		seq = XFRM_SPI_SKB_CB(skb)->seq;

 		if (xo && (xo->flags & CRYPTO_DONE)) {
--
2.30.2


