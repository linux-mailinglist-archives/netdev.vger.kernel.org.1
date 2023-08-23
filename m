Return-Path: <netdev+bounces-30055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE311785C13
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89814281368
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7873C8D1;
	Wed, 23 Aug 2023 15:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BCC8C5
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:27:25 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AFBCFE;
	Wed, 23 Aug 2023 08:27:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qYplQ-0001jU-0R; Wed, 23 Aug 2023 17:27:20 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net 1/6] netfilter: nf_tables: validate all pending tables
Date: Wed, 23 Aug 2023 17:26:49 +0200
Message-ID: <20230823152711.15279-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823152711.15279-1-fw@strlen.de>
References: <20230823152711.15279-1-fw@strlen.de>
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

We have to validate all tables in the transaction that are in
VALIDATE_DO state, the blamed commit below did not move the break
statement to its right location so we only validate one table.

Moreover, we can't init table->validate to _SKIP when a table object
is allocated.

If we do, then if a transcaction creates a new table and then
fails the transaction, nfnetlink will loop and nft will hang until
user cancels the command.

Add back the pernet state as a place to stash the last state encountered.
This is either _DO (we hit an error during commit validation) or _SKIP
(transaction passed all checks).

Fixes: 00c320f9b755 ("netfilter: nf_tables: make validation state per table")
Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h |  1 +
 net/netfilter/nf_tables_api.c     | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index e9ae567c037d..ffcbdf08380f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1729,6 +1729,7 @@ struct nftables_pernet {
 	u64			table_handle;
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
+	u8			validate_state;
 };
 
 extern unsigned int nf_tables_net_id;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3e841e45f2c0..a76a62ebe9c9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1373,7 +1373,7 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 	if (table == NULL)
 		goto err_kzalloc;
 
-	table->validate_state = NFT_VALIDATE_SKIP;
+	table->validate_state = nft_net->validate_state;
 	table->name = nla_strdup(attr, GFP_KERNEL_ACCOUNT);
 	if (table->name == NULL)
 		goto err_strdup;
@@ -9051,9 +9051,8 @@ static int nf_tables_validate(struct net *net)
 				return -EAGAIN;
 
 			nft_validate_state_update(table, NFT_VALIDATE_SKIP);
+			break;
 		}
-
-		break;
 	}
 
 	return 0;
@@ -9799,8 +9798,10 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	}
 
 	/* 0. Validate ruleset, otherwise roll back for error reporting. */
-	if (nf_tables_validate(net) < 0)
+	if (nf_tables_validate(net) < 0) {
+		nft_net->validate_state = NFT_VALIDATE_DO;
 		return -EAGAIN;
+	}
 
 	err = nft_flow_rule_offload_commit(net);
 	if (err < 0)
@@ -10059,6 +10060,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
 
 	nft_gc_seq_end(nft_net, gc_seq);
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -11115,6 +11117,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	mutex_init(&nft_net->commit_mutex);
 	nft_net->base_seq = 1;
 	nft_net->gc_seq = 0;
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 
 	return 0;
 }
-- 
2.41.0


