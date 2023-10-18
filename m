Return-Path: <netdev+bounces-42161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922F7CD702
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F24281C14
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4215AF0;
	Wed, 18 Oct 2023 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D015AE2
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:51:46 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8DF9;
	Wed, 18 Oct 2023 01:51:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qt2HD-0006L3-8M; Wed, 18 Oct 2023 10:51:39 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 4/7] netfilter: nf_nat: mask out non-verdict bits when checking return value
Date: Wed, 18 Oct 2023 10:51:08 +0200
Message-ID: <20231018085118.10829-5-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018085118.10829-1-fw@strlen.de>
References: <20231018085118.10829-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Same as previous change: we need to mask out the non-verdict bits, as
upcoming patches may embed an errno value in NF_STOLEN verdicts too.

NF_DROP could already do this, but not all called functions do this.

Checks that only test ret vs NF_ACCEPT are fine, the 'errno parts'
are always 0 for those.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_nat_proto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index 5a049740758f..6d969468c779 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -999,11 +999,12 @@ static unsigned int
 nf_nat_ipv6_in(void *priv, struct sk_buff *skb,
 	       const struct nf_hook_state *state)
 {
-	unsigned int ret;
+	unsigned int ret, verdict;
 	struct in6_addr daddr = ipv6_hdr(skb)->daddr;
 
 	ret = nf_nat_ipv6_fn(priv, skb, state);
-	if (ret != NF_DROP && ret != NF_STOLEN &&
+	verdict = ret & NF_VERDICT_MASK;
+	if (verdict != NF_DROP && verdict != NF_STOLEN &&
 	    ipv6_addr_cmp(&daddr, &ipv6_hdr(skb)->daddr))
 		skb_dst_drop(skb);
 
-- 
2.41.0


