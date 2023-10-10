Return-Path: <netdev+bounces-39587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904D7BFFBF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB11C20E63
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180A24C9E;
	Tue, 10 Oct 2023 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576324C7D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:06 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922CAC;
	Tue, 10 Oct 2023 07:54:05 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7L-0001Np-Nk; Tue, 10 Oct 2023 16:53:51 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net-next 1/8] netfilter: nf_tables: Always allocate nft_rule_dump_ctx
Date: Tue, 10 Oct 2023 16:53:31 +0200
Message-ID: <20231010145343.12551-2-fw@strlen.de>
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

It will move into struct netlink_callback's scratch area later, just put
nf_tables_dump_rules_start in shape to reduce churn later.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 48 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b4405db710b0..ea30bee41a6e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3521,10 +3521,10 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
-		if (ctx && ctx->table && strcmp(ctx->table, table->name) != 0)
+		if (ctx->table && strcmp(ctx->table, table->name) != 0)
 			continue;
 
-		if (ctx && ctx->table && ctx->chain) {
+		if (ctx->table && ctx->chain) {
 			struct rhlist_head *list, *tmp;
 
 			list = rhltable_lookup(&table->chains_ht, ctx->chain,
@@ -3548,7 +3548,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 				goto done;
 		}
 
-		if (ctx && ctx->table)
+		if (ctx->table)
 			break;
 	}
 done:
@@ -3563,27 +3563,23 @@ static int nf_tables_dump_rules_start(struct netlink_callback *cb)
 	const struct nlattr * const *nla = cb->data;
 	struct nft_rule_dump_ctx *ctx = NULL;
 
-	if (nla[NFTA_RULE_TABLE] || nla[NFTA_RULE_CHAIN]) {
-		ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
-		if (!ctx)
-			return -ENOMEM;
+	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
 
-		if (nla[NFTA_RULE_TABLE]) {
-			ctx->table = nla_strdup(nla[NFTA_RULE_TABLE],
-							GFP_ATOMIC);
-			if (!ctx->table) {
-				kfree(ctx);
-				return -ENOMEM;
-			}
+	if (nla[NFTA_RULE_TABLE]) {
+		ctx->table = nla_strdup(nla[NFTA_RULE_TABLE], GFP_ATOMIC);
+		if (!ctx->table) {
+			kfree(ctx);
+			return -ENOMEM;
 		}
-		if (nla[NFTA_RULE_CHAIN]) {
-			ctx->chain = nla_strdup(nla[NFTA_RULE_CHAIN],
-						GFP_ATOMIC);
-			if (!ctx->chain) {
-				kfree(ctx->table);
-				kfree(ctx);
-				return -ENOMEM;
-			}
+	}
+	if (nla[NFTA_RULE_CHAIN]) {
+		ctx->chain = nla_strdup(nla[NFTA_RULE_CHAIN], GFP_ATOMIC);
+		if (!ctx->chain) {
+			kfree(ctx->table);
+			kfree(ctx);
+			return -ENOMEM;
 		}
 	}
 
@@ -3595,11 +3591,9 @@ static int nf_tables_dump_rules_done(struct netlink_callback *cb)
 {
 	struct nft_rule_dump_ctx *ctx = cb->data;
 
-	if (ctx) {
-		kfree(ctx->table);
-		kfree(ctx->chain);
-		kfree(ctx);
-	}
+	kfree(ctx->table);
+	kfree(ctx->chain);
+	kfree(ctx);
 	return 0;
 }
 
-- 
2.41.0


