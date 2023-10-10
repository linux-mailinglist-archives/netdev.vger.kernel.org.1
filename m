Return-Path: <netdev+bounces-39590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACA7BFFC5
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BD8281C04
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EC24C95;
	Tue, 10 Oct 2023 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088924C7D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:15 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A2B4;
	Tue, 10 Oct 2023 07:54:13 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7c-0001PJ-03; Tue, 10 Oct 2023 16:54:08 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Phil Sutter <phil@nwl.cc>
Subject: [PATCH net-next 5/8] netfilter: nf_tables: Don't allocate nft_rule_dump_ctx
Date: Tue, 10 Oct 2023 16:53:35 +0200
Message-ID: <20231010145343.12551-6-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010145343.12551-1-fw@strlen.de>
References: <20231010145343.12551-1-fw@strlen.de>
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

From: Phil Sutter <phil@nwl.cc>

Since struct netlink_callback::args is not used by rule dumpers anymore,
use it to hold nft_rule_dump_ctx. Add a build-time check to make sure it
won't ever exceed the available space.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a2e6c826bd08..68321345bb6d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3453,7 +3453,7 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 				  const struct nft_table *table,
 				  const struct nft_chain *chain)
 {
-	struct nft_rule_dump_ctx *ctx = cb->data;
+	struct nft_rule_dump_ctx *ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
 	const struct nft_rule *rule, *prule;
 	unsigned int entries = 0;
@@ -3498,7 +3498,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
-	struct nft_rule_dump_ctx *ctx = cb->data;
+	struct nft_rule_dump_ctx *ctx = (void *)cb->ctx;
 	struct nft_table *table;
 	const struct nft_chain *chain;
 	unsigned int idx = 0;
@@ -3553,42 +3553,35 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 
 static int nf_tables_dump_rules_start(struct netlink_callback *cb)
 {
+	struct nft_rule_dump_ctx *ctx = (void *)cb->ctx;
 	const struct nlattr * const *nla = cb->data;
-	struct nft_rule_dump_ctx *ctx = NULL;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
-	if (!ctx)
-		return -ENOMEM;
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
 
 	if (nla[NFTA_RULE_TABLE]) {
 		ctx->table = nla_strdup(nla[NFTA_RULE_TABLE], GFP_ATOMIC);
-		if (!ctx->table) {
-			kfree(ctx);
+		if (!ctx->table)
 			return -ENOMEM;
-		}
 	}
 	if (nla[NFTA_RULE_CHAIN]) {
 		ctx->chain = nla_strdup(nla[NFTA_RULE_CHAIN], GFP_ATOMIC);
 		if (!ctx->chain) {
 			kfree(ctx->table);
-			kfree(ctx);
 			return -ENOMEM;
 		}
 	}
 	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETRULE_RESET)
 		ctx->reset = true;
 
-	cb->data = ctx;
 	return 0;
 }
 
 static int nf_tables_dump_rules_done(struct netlink_callback *cb)
 {
-	struct nft_rule_dump_ctx *ctx = cb->data;
+	struct nft_rule_dump_ctx *ctx = (void *)cb->ctx;
 
 	kfree(ctx->table);
 	kfree(ctx->chain);
-	kfree(ctx);
 	return 0;
 }
 
-- 
2.41.0


