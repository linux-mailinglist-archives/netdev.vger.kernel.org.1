Return-Path: <netdev+bounces-44497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA3B7D84E3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01571C20EE2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13132DF84;
	Thu, 26 Oct 2023 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E02C87F
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:36:53 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D091A2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:36:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qw1Td-0007Op-49; Thu, 26 Oct 2023 16:36:49 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>,
	Antony Antony <antony@phenome.org>
Subject: [PATCH ipsec-next] xfrm: policy: fix layer 4 flowi decoding
Date: Thu, 26 Oct 2023 16:36:15 +0200
Message-ID: <20231026143642.23775-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZTp4dDaWejic16eT@moon.secunet.de>
References: <ZTp4dDaWejic16eT@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit shiped with two bugs:
 fl4->fl4_icmp_type = flkeys->icmp.type;
 fl4->fl4_icmp_type = flkeys->icmp.code;
               ~~~~ should have been "code".

But the more severe bug is that I got fooled by flowi member defines:
fl4_icmp_type, fl4_gre_key and fl4_dport share the same union/address.

Fix typo and make gre/icmp keys l4 protocol dependent.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Reported-and-tested-by: Antony Antony <antony@phenome.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6aea8b2f45e0..e8c406eba11b 100644
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
+	case IPPROTO_ICMP:
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
2.41.0


