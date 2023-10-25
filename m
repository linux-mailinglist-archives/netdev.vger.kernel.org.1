Return-Path: <netdev+bounces-44280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA67D76C9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D461C20E62
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B5381B8;
	Wed, 25 Oct 2023 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB034CC2
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:26:11 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A234136;
	Wed, 25 Oct 2023 14:26:07 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 09/19] netfilter: nf_tables: Unconditionally allocate nft_obj_filter
Date: Wed, 25 Oct 2023 23:25:45 +0200
Message-Id: <20231025212555.132775-10-pablo@netfilter.org>
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

Prep work for moving the filter into struct netlink_callback's scratch
area.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 36 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fa216d1cfb74..e2e0586307f5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7717,11 +7717,9 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 				goto cont;
 			if (idx < s_idx)
 				goto cont;
-			if (filter && filter->table &&
-			    strcmp(filter->table, table->name))
+			if (filter->table && strcmp(filter->table, table->name))
 				goto cont;
-			if (filter &&
-			    filter->type != NFT_OBJECT_UNSPEC &&
+			if (filter->type != NFT_OBJECT_UNSPEC &&
 			    obj->ops->type->type != filter->type)
 				goto cont;
 
@@ -7756,23 +7754,21 @@ static int nf_tables_dump_obj_start(struct netlink_callback *cb)
 	const struct nlattr * const *nla = cb->data;
 	struct nft_obj_filter *filter = NULL;
 
-	if (nla[NFTA_OBJ_TABLE] || nla[NFTA_OBJ_TYPE]) {
-		filter = kzalloc(sizeof(*filter), GFP_ATOMIC);
-		if (!filter)
-			return -ENOMEM;
+	filter = kzalloc(sizeof(*filter), GFP_ATOMIC);
+	if (!filter)
+		return -ENOMEM;
 
-		if (nla[NFTA_OBJ_TABLE]) {
-			filter->table = nla_strdup(nla[NFTA_OBJ_TABLE], GFP_ATOMIC);
-			if (!filter->table) {
-				kfree(filter);
-				return -ENOMEM;
-			}
+	if (nla[NFTA_OBJ_TABLE]) {
+		filter->table = nla_strdup(nla[NFTA_OBJ_TABLE], GFP_ATOMIC);
+		if (!filter->table) {
+			kfree(filter);
+			return -ENOMEM;
 		}
-
-		if (nla[NFTA_OBJ_TYPE])
-			filter->type = ntohl(nla_get_be32(nla[NFTA_OBJ_TYPE]));
 	}
 
+	if (nla[NFTA_OBJ_TYPE])
+		filter->type = ntohl(nla_get_be32(nla[NFTA_OBJ_TYPE]));
+
 	cb->data = filter;
 	return 0;
 }
@@ -7781,10 +7777,8 @@ static int nf_tables_dump_obj_done(struct netlink_callback *cb)
 {
 	struct nft_obj_filter *filter = cb->data;
 
-	if (filter) {
-		kfree(filter->table);
-		kfree(filter);
-	}
+	kfree(filter->table);
+	kfree(filter);
 
 	return 0;
 }
-- 
2.30.2


