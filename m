Return-Path: <netdev+bounces-54560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0472807745
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8234CB20EE7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269AE6F61B;
	Wed,  6 Dec 2023 18:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 546A0122;
	Wed,  6 Dec 2023 10:04:05 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 4/6] netfilter: nf_tables: bail out on mismatching dynset and set expressions
Date: Wed,  6 Dec 2023 19:03:55 +0100
Message-Id: <20231206180357.959930-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231206180357.959930-1-pablo@netfilter.org>
References: <20231206180357.959930-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dynset expressions provided by userspace is larger than the declared
set expressions, then bail out.

Fixes: 48b0ae046ee9 ("netfilter: nftables: netlink support for several set element expressions")
Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_dynset.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index b18a79039125..c09dba57354c 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -280,10 +280,15 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 			priv->expr_array[i] = dynset_expr;
 			priv->num_exprs++;
 
-			if (set->num_exprs &&
-			    dynset_expr->ops != set->exprs[i]->ops) {
-				err = -EOPNOTSUPP;
-				goto err_expr_free;
+			if (set->num_exprs) {
+				if (i >= set->num_exprs) {
+					err = -EINVAL;
+					goto err_expr_free;
+				}
+				if (dynset_expr->ops != set->exprs[i]->ops) {
+					err = -EOPNOTSUPP;
+					goto err_expr_free;
+				}
 			}
 			i++;
 		}
-- 
2.30.2


