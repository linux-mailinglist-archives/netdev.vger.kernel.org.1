Return-Path: <netdev+bounces-39589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA47BFFC3
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91DE1C20E34
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3E200DC;
	Tue, 10 Oct 2023 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8224C7D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:10 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06FAC;
	Tue, 10 Oct 2023 07:54:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7X-0001Og-UT; Tue, 10 Oct 2023 16:54:03 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Phil Sutter <phil@nwl.cc>
Subject: [PATCH net-next 4/8] netfilter: nf_tables: Carry s_idx in nft_rule_dump_ctx
Date: Tue, 10 Oct 2023 16:53:34 +0200
Message-ID: <20231010145343.12551-5-fw@strlen.de>
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

In order to move the context into struct netlink_callback's scratch
area, the latter must be unused first.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 567c414351da..a2e6c826bd08 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3441,6 +3441,7 @@ static void audit_log_rule_reset(const struct nft_table *table,
 }
 
 struct nft_rule_dump_ctx {
+	unsigned int s_idx;
 	char *table;
 	char *chain;
 	bool reset;
@@ -3455,7 +3456,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 	struct nft_rule_dump_ctx *ctx = cb->data;
 	struct net *net = sock_net(skb->sk);
 	const struct nft_rule *rule, *prule;
-	unsigned int s_idx = cb->args[0];
 	unsigned int entries = 0;
 	int ret = 0;
 	u64 handle;
@@ -3464,7 +3464,7 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 	list_for_each_entry_rcu(rule, &chain->rules, list) {
 		if (!nft_is_active(net, rule))
 			goto cont_skip;
-		if (*idx < s_idx)
+		if (*idx < ctx->s_idx)
 			goto cont;
 		if (prule)
 			handle = prule->handle;
@@ -3498,7 +3498,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
-	const struct nft_rule_dump_ctx *ctx = cb->data;
+	struct nft_rule_dump_ctx *ctx = cb->data;
 	struct nft_table *table;
 	const struct nft_chain *chain;
 	unsigned int idx = 0;
@@ -3547,7 +3547,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 done:
 	rcu_read_unlock();
 
-	cb->args[0] = idx;
+	ctx->s_idx = idx;
 	return skb->len;
 }
 
-- 
2.41.0


