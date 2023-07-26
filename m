Return-Path: <netdev+bounces-21482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10E763B00
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEA71C21342
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251E253C6;
	Wed, 26 Jul 2023 15:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777DCA63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:25:46 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7394;
	Wed, 26 Jul 2023 08:25:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qOgOS-0001Hn-H8; Wed, 26 Jul 2023 17:25:40 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Kevin Rich <kevinrich1337@gmail.com>
Subject: [PATCH net 3/3] netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID
Date: Wed, 26 Jul 2023 17:23:49 +0200
Message-ID: <20230726152524.26268-4-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726152524.26268-1-fw@strlen.de>
References: <20230726152524.26268-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pablo Neira Ayuso <pablo@netfilter.org>

Bail out with EOPNOTSUPP when adding rule to bound chain via
NFTA_RULE_CHAIN_ID. The following warning splat is shown when
adding a rule to a deleted bound chain:

 WARNING: CPU: 2 PID: 13692 at net/netfilter/nf_tables_api.c:2013 nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
 CPU: 2 PID: 13692 Comm: chain-bound-rul Not tainted 6.1.39 #1
 RIP: 0010:nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b9a4d3fd1d34..d3c6ecd1f5a6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3811,8 +3811,6 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
-			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
 		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
@@ -3825,6 +3823,9 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		return -EINVAL;
 	}
 
+	if (nft_chain_is_bound(chain))
+		return -EOPNOTSUPP;
+
 	if (nla[NFTA_RULE_HANDLE]) {
 		handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_HANDLE]));
 		rule = __nft_rule_lookup(chain, handle);
-- 
2.41.0


