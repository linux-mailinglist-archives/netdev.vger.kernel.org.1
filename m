Return-Path: <netdev+bounces-42159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA537CD6FE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E12CB2125D
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C55156F0;
	Wed, 18 Oct 2023 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C115AFE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:51:36 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A29F9D;
	Wed, 18 Oct 2023 01:51:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qt2H5-0006KA-4O; Wed, 18 Oct 2023 10:51:31 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 2/7] netfilter: nf_tables: mask out non-verdict bits when checking return value
Date: Wed, 18 Oct 2023 10:51:06 +0200
Message-ID: <20231018085118.10829-3-fw@strlen.de>
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

nftables trace infra must mask out the non-verdict bit parts of the
return value, else followup changes that 'return errno << 8 | NF_STOLEN'
will cause breakage.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_core.c  | 2 +-
 net/netfilter/nf_tables_trace.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 4d0ce12221f6..6009b423f60a 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -115,7 +115,7 @@ static noinline void __nft_trace_verdict(const struct nft_pktinfo *pkt,
 {
 	enum nft_trace_types type;
 
-	switch (regs->verdict.code) {
+	switch (regs->verdict.code & NF_VERDICT_MASK) {
 	case NFT_CONTINUE:
 	case NFT_RETURN:
 		type = NFT_TRACETYPE_RETURN;
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index 6d41c0bd3d78..a83637e3f455 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -258,17 +258,21 @@ void nft_trace_notify(const struct nft_pktinfo *pkt,
 	case __NFT_TRACETYPE_MAX:
 		break;
 	case NFT_TRACETYPE_RETURN:
-	case NFT_TRACETYPE_RULE:
+	case NFT_TRACETYPE_RULE: {
+		unsigned int v;
+
 		if (nft_verdict_dump(skb, NFTA_TRACE_VERDICT, verdict))
 			goto nla_put_failure;
 
 		/* pkt->skb undefined iff NF_STOLEN, disable dump */
-		if (verdict->code == NF_STOLEN)
+		v = verdict->code & NF_VERDICT_MASK;
+		if (v == NF_STOLEN)
 			info->packet_dumped = true;
 		else
 			mark = pkt->skb->mark;
 
 		break;
+	}
 	case NFT_TRACETYPE_POLICY:
 		mark = pkt->skb->mark;
 
-- 
2.41.0


