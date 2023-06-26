Return-Path: <netdev+bounces-13868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A473D7F8
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57DF1C204F8
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6F1872;
	Mon, 26 Jun 2023 06:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC44A0F
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:48:00 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82404E50;
	Sun, 25 Jun 2023 23:47:59 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 5/8] netfilter: nf_tables: permit update of set size
Date: Mon, 26 Jun 2023 08:47:46 +0200
Message-Id: <20230626064749.75525-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230626064749.75525-1-pablo@netfilter.org>
References: <20230626064749.75525-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Florian Westphal <fw@strlen.de>

Now that set->nelems is always updated permit update of the sets max size.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 3 +++
 net/netfilter/nf_tables_api.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2e24ea1d744c..89b1ac4e6d4a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1589,6 +1589,7 @@ struct nft_trans_set {
 	u64				timeout;
 	bool				update;
 	bool				bound;
+	u32				size;
 };
 
 #define nft_trans_set(trans)	\
@@ -1603,6 +1604,8 @@ struct nft_trans_set {
 	(((struct nft_trans_set *)trans->data)->timeout)
 #define nft_trans_set_gc_int(trans)	\
 	(((struct nft_trans_set *)trans->data)->gc_int)
+#define nft_trans_set_size(trans)	\
+	(((struct nft_trans_set *)trans->data)->size)
 
 struct nft_trans_chain {
 	bool				update;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0396fd8f4e71..dfd441ff1e3e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -483,6 +483,7 @@ static int __nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 		nft_trans_set_update(trans) = true;
 		nft_trans_set_gc_int(trans) = desc->gc_int;
 		nft_trans_set_timeout(trans) = desc->timeout;
+		nft_trans_set_size(trans) = desc->size;
 	}
 	nft_trans_commit_list_add_tail(ctx->net, trans);
 
@@ -9428,6 +9429,9 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 				WRITE_ONCE(set->timeout, nft_trans_set_timeout(trans));
 				WRITE_ONCE(set->gc_int, nft_trans_set_gc_int(trans));
+
+				if (nft_trans_set_size(trans))
+					WRITE_ONCE(set->size, nft_trans_set_size(trans));
 			} else {
 				nft_clear(net, nft_trans_set(trans));
 				/* This avoids hitting -EBUSY when deleting the table
-- 
2.30.2


