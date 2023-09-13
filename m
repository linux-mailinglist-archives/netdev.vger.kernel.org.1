Return-Path: <netdev+bounces-33694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF079F494
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF27B20A76
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E52AB3B;
	Wed, 13 Sep 2023 21:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B222F19
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 21:58:21 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3140F1739;
	Wed, 13 Sep 2023 14:58:21 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 8/9] netfilter: nf_tables: Fix entries val in rule reset audit log
Date: Wed, 13 Sep 2023 23:57:59 +0200
Message-Id: <20230913215800.107269-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913215800.107269-1-pablo@netfilter.org>
References: <20230913215800.107269-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

The value in idx and the number of rules handled in that particular
__nf_tables_dump_rules() call is not identical. The former is a cursor
to pick up from if multiple netlink messages are needed, so its value is
ever increasing. Fixing this is not just a matter of subtracting s_idx
from it, though: When resetting rules in multiple chains,
__nf_tables_dump_rules() is called for each and cb->args[0] is not
adjusted in between. Introduce a dedicated counter to record the number
of rules reset in this call in a less confusing way.

While being at it, prevent the direct return upon buffer exhaustion: Any
rules previously dumped into that skb would evade audit logging
otherwise.

Fixes: 9b5ba5c9c5109 ("netfilter: nf_tables: Unbreak audit log reset")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c1e485aee763..d819b4d42962 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3451,6 +3451,8 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	const struct nft_rule *rule, *prule;
 	unsigned int s_idx = cb->args[0];
+	unsigned int entries = 0;
+	int ret = 0;
 	u64 handle;
 
 	prule = NULL;
@@ -3473,9 +3475,11 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 					NFT_MSG_NEWRULE,
 					NLM_F_MULTI | NLM_F_APPEND,
 					table->family,
-					table, chain, rule, handle, reset) < 0)
-			return 1;
-
+					table, chain, rule, handle, reset) < 0) {
+			ret = 1;
+			break;
+		}
+		entries++;
 		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 cont:
 		prule = rule;
@@ -3483,10 +3487,10 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 		(*idx)++;
 	}
 
-	if (reset && *idx)
-		audit_log_rule_reset(table, cb->seq, *idx);
+	if (reset && entries)
+		audit_log_rule_reset(table, cb->seq, entries);
 
-	return 0;
+	return ret;
 }
 
 static int nf_tables_dump_rules(struct sk_buff *skb,
-- 
2.30.2


