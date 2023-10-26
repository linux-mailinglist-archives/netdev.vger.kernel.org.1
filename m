Return-Path: <netdev+bounces-44507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5E7D853F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB311F228FB
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF02EAFE;
	Thu, 26 Oct 2023 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D61D52B
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:51:46 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A31B2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:51:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qw1i3-0007WM-3B; Thu, 26 Oct 2023 16:51:43 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>,
	Antony Antony <antony@phenome.org>
Subject: [PATCH ipsec-next v2] xfrm: policy: fix layer 4 flowi decoding
Date: Thu, 26 Oct 2023 16:45:42 +0200
Message-ID: <20231026144610.26347-1-fw@strlen.de>
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
---
 v2: decode_session6 must use IPPROTO_ICMPV6, not IPPROTO_ICMP.

 I normally do not resend immediately but in this case it seems like the
 lesser evil.  Alternative is to defer this until after -next merges
 have completed and then handle it via ipsec.git.

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
2.41.0


