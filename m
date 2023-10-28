Return-Path: <netdev+bounces-44984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791DF7DA5EB
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B0D28270C
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF337CA56;
	Sat, 28 Oct 2023 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DEB661
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:43:40 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C3135
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:43:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E9A8E20839;
	Sat, 28 Oct 2023 10:43:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYmP2EGmVp5y; Sat, 28 Oct 2023 10:43:36 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8242120764;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 75DCD80004A;
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
	id 6D0753183E7A; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/10] xfrm: policy: fix layer 4 flowi decoding
Date: Sat, 28 Oct 2023 10:43:28 +0200
Message-ID: <20231028084328.3119236-11-steffen.klassert@secunet.com>
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

The commit shipped with two bugs:
 fl4->fl4_icmp_type = flkeys->icmp.type;
 fl4->fl4_icmp_type = flkeys->icmp.code;
               ~~~~ should have been "code".

But the more severe bug is that I got fooled by flowi member defines:
fl4_icmp_type, fl4_gre_key and fl4_dport share the same union/address.

Fix typo and make gre/icmp key setting depend on the l4 protocol.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Reported-and-tested-by: Antony Antony <antony@phenome.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6aea8b2f45e0..d2dddc570f4f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3400,11 +3400,18 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 		fl4->fl4_dport = flkeys->ports.dst;
 	}
 
+	switch (flkeys->basic.ip_proto) {
+	case IPPROTO_GRE:
+		fl4->fl4_gre_key = flkeys->gre.keyid;
+		break;
+	case IPPROTO_ICMP:
+		fl4->fl4_icmp_type = flkeys->icmp.type;
+		fl4->fl4_icmp_code = flkeys->icmp.code;
+		break;
+	}
+
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
 	fl4->flowi4_tos = flkeys->ip.tos;
-	fl4->fl4_icmp_type = flkeys->icmp.type;
-	fl4->fl4_icmp_type = flkeys->icmp.code;
-	fl4->fl4_gre_key = flkeys->gre.keyid;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3427,10 +3434,17 @@ decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 		fl6->fl6_dport = flkeys->ports.dst;
 	}
 
+	switch (flkeys->basic.ip_proto) {
+	case IPPROTO_GRE:
+		fl6->fl6_gre_key = flkeys->gre.keyid;
+		break;
+	case IPPROTO_ICMPV6:
+		fl6->fl6_icmp_type = flkeys->icmp.type;
+		fl6->fl6_icmp_code = flkeys->icmp.code;
+		break;
+	}
+
 	fl6->flowi6_proto = flkeys->basic.ip_proto;
-	fl6->fl6_icmp_type = flkeys->icmp.type;
-	fl6->fl6_icmp_type = flkeys->icmp.code;
-	fl6->fl6_gre_key = flkeys->gre.keyid;
 }
 #endif
 
-- 
2.34.1


