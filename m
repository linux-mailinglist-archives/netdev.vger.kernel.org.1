Return-Path: <netdev+bounces-32568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23D7986BA
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A61281AA2
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537C5230;
	Fri,  8 Sep 2023 12:06:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8365381
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 12:06:44 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A381BC5
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 05:06:43 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qeaG2-00062a-2D; Fri, 08 Sep 2023 14:06:42 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [RFC ipsec-next 2/3] flow_dissector: add ipv6 mobility header support
Date: Fri,  8 Sep 2023 14:06:19 +0200
Message-ID: <20230908120628.26164-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908120628.26164-1-fw@strlen.de>
References: <20230908120628.26164-1-fw@strlen.de>
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

Needed to replace xfrm home-grown decoder with the flow dissector if we
don't want to lose functionality.

Alternative is to drop mobility header support and see if
anyone complains.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/flow_dissector.h |  5 +++++
 net/core/flow_dissector.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 1a7131d6cb0e..a82b7039d755 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -329,6 +329,10 @@ struct flow_dissector_key_cfm {
 #define FLOW_DIS_CFM_MDL_MASK GENMASK(7, 5)
 #define FLOW_DIS_CFM_MDL_MAX 7
 
+struct flow_dissector_ipv6_mh {
+	u8 mh_type;
+};
+
 enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_CONTROL, /* struct flow_dissector_key_control */
 	FLOW_DISSECTOR_KEY_BASIC, /* struct flow_dissector_key_basic */
@@ -363,6 +367,7 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
 	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
+	FLOW_DISSECTOR_KEY_IPV6MH, /* struct flow_dissector_ipv6_mh */
 
 	FLOW_DISSECTOR_KEY_MAX,
 };
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 89d15ceaf9af..6dcd608f8da6 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1531,6 +1531,33 @@ bool __skb_flow_dissect(const struct net *net,
 		fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
 	}
+	case NEXTHDR_MOBILITY: {
+		struct flow_dissector_ipv6_mh *key_ipv6mh;
+		u8 _opthdr[3], *opthdr;
+
+		if (proto != htons(ETH_P_IPV6))
+			break;
+
+		opthdr = __skb_header_pointer(skb, nhoff, sizeof(_opthdr),
+					      data, hlen, &_opthdr);
+		if (!opthdr) {
+			fdret = FLOW_DISSECT_RET_OUT_BAD;
+			break;
+		}
+
+		if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_IPV6MH))
+			break;
+
+		key_ipv6mh = skb_flow_dissector_target(flow_dissector,
+						       FLOW_DISSECTOR_KEY_IPV6MH,
+						       target_container);
+		ip_proto = opthdr[0];
+		nhoff += (opthdr[1] + 1) << 3;
+		key_ipv6mh->mh_type = opthdr[2];
+
+		fdret = FLOW_DISSECT_RET_OUT_GOOD;
+		break;
+	}
 	case NEXTHDR_FRAGMENT: {
 		struct frag_hdr _fh, *fh;
 
-- 
2.41.0


