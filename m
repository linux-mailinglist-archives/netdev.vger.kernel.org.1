Return-Path: <netdev+bounces-44282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD247D76CB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C11C20DBB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136238BAE;
	Wed, 25 Oct 2023 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1143715F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:26:14 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AF94191;
	Wed, 25 Oct 2023 14:26:13 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 19/19] netfilter: nf_tables: Carry reset boolean in nft_set_dump_ctx
Date: Wed, 25 Oct 2023 23:25:55 +0200
Message-Id: <20231025212555.132775-20-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025212555.132775-1-pablo@netfilter.org>
References: <20231025212555.132775-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

Relieve the dump callback from having to check nlmsg_type upon each
call. Prep work for set element reset locking.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ed3329fcbe7f..3c1fd8283bf4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5715,6 +5715,7 @@ static void audit_log_nft_set_reset(const struct nft_table *table,
 struct nft_set_dump_ctx {
 	const struct nft_set	*set;
 	struct nft_ctx		ctx;
+	bool			reset;
 };
 
 static int nft_set_catchall_dump(struct net *net, struct sk_buff *skb,
@@ -5752,7 +5753,6 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	bool set_found = false;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
-	bool reset = false;
 	u32 portid, seq;
 	int event;
 
@@ -5800,12 +5800,9 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	if (nest == NULL)
 		goto nla_put_failure;
 
-	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETSETELEM_RESET)
-		reset = true;
-
 	args.cb			= cb;
 	args.skb		= skb;
-	args.reset		= reset;
+	args.reset		= dump_ctx->reset;
 	args.iter.genmask	= nft_genmask_cur(net);
 	args.iter.skip		= cb->args[0];
 	args.iter.count		= 0;
@@ -5815,11 +5812,11 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 
 	if (!args.iter.err && args.iter.count == cb->args[0])
 		args.iter.err = nft_set_catchall_dump(net, skb, set,
-						      reset, cb->seq);
+						      dump_ctx->reset, cb->seq);
 	nla_nest_end(skb, nest);
 	nlmsg_end(skb, nlh);
 
-	if (reset && args.iter.count > args.iter.skip)
+	if (dump_ctx->reset && args.iter.count > args.iter.skip)
 		audit_log_nft_set_reset(table, cb->seq,
 					args.iter.count - args.iter.skip);
 
@@ -6072,6 +6069,9 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
+	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETSETELEM_RESET)
+		reset = true;
+
 	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
 			.start = nf_tables_dump_set_start,
@@ -6082,6 +6082,7 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 		struct nft_set_dump_ctx dump_ctx = {
 			.set = set,
 			.ctx = ctx,
+			.reset = reset,
 		};
 
 		c.data = &dump_ctx;
@@ -6091,9 +6092,6 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 	if (!nla[NFTA_SET_ELEM_LIST_ELEMENTS])
 		return -EINVAL;
 
-	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETSETELEM_RESET)
-		reset = true;
-
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr, reset);
 		if (err < 0) {
-- 
2.30.2


