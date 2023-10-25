Return-Path: <netdev+bounces-44278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B767D76C7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63612B20D9D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6A374E5;
	Wed, 25 Oct 2023 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606E34CD2
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:26:11 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CA6A12A;
	Wed, 25 Oct 2023 14:26:09 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 13/19] netfilter: nf_tables: Carry reset boolean in nft_obj_dump_ctx
Date: Wed, 25 Oct 2023 23:25:49 +0200
Message-Id: <20231025212555.132775-14-pablo@netfilter.org>
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

Relieve the dump callback from having to inspect nlmsg_type upon each
call, just do it once at start of the dump.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c84e2cc6d3b3..ecb251f6c6a6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7685,6 +7685,7 @@ struct nft_obj_dump_ctx {
 	unsigned int	s_idx;
 	char		*table;
 	u32		type;
+	bool		reset;
 };
 
 static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
@@ -7698,12 +7699,8 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned int entries = 0;
 	struct nft_object *obj;
 	unsigned int idx = 0;
-	bool reset = false;
 	int rc = 0;
 
-	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
-		reset = true;
-
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
 	cb->seq = READ_ONCE(nft_net->base_seq);
@@ -7730,7 +7727,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 						     NFT_MSG_NEWOBJ,
 						     NLM_F_MULTI | NLM_F_APPEND,
 						     table->family, table,
-						     obj, reset);
+						     obj, ctx->reset);
 			if (rc < 0)
 				break;
 
@@ -7739,7 +7736,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 cont:
 			idx++;
 		}
-		if (reset && entries)
+		if (ctx->reset && entries)
 			audit_log_obj_reset(table, nft_net->base_seq, entries);
 		if (rc < 0)
 			break;
@@ -7766,6 +7763,9 @@ static int nf_tables_dump_obj_start(struct netlink_callback *cb)
 	if (nla[NFTA_OBJ_TYPE])
 		ctx->type = ntohl(nla_get_be32(nla[NFTA_OBJ_TYPE]));
 
+	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
+		ctx->reset = true;
+
 	return 0;
 }
 
-- 
2.30.2


