Return-Path: <netdev+bounces-21480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CA763AFB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F12281374
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5C253DE;
	Wed, 26 Jul 2023 15:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56BCA63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:25:37 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6CBF;
	Wed, 26 Jul 2023 08:25:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qOgOK-0001Go-DI; Wed, 26 Jul 2023 17:25:32 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 1/3] netfilter: nft_set_rbtree: fix overlap expiration walk
Date: Wed, 26 Jul 2023 17:23:47 +0200
Message-ID: <20230726152524.26268-2-fw@strlen.de>
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

The lazy gc on insert that should remove timed-out entries fails to release
the other half of the interval, if any.

Can be reproduced with tests/shell/testcases/sets/0044interval_overlap_0
in nftables.git and kmemleak enabled kernel.

Second bug is the use of rbe_prev vs. prev pointer.
If rbe_prev() returns NULL after at least one iteration, rbe_prev points
to element that is not an end interval, hence it should not be removed.

Lastly, check the genmask of the end interval if this is active in the
current generation.

Fixes: c9e6978e2725 ("netfilter: nft_set_rbtree: Switch to node list walk for overlap detection")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_rbtree.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5c05c9b990fb..8d73fffd2d09 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -217,29 +217,37 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
-			      struct nft_rbtree_elem *rbe)
+			      struct nft_rbtree_elem *rbe,
+			      u8 genmask)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
-	struct nft_rbtree_elem *rbe_prev = NULL;
+	struct nft_rbtree_elem *rbe_prev;
 	struct nft_set_gc_batch *gcb;
 
 	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
 	if (!gcb)
 		return -ENOMEM;
 
-	/* search for expired end interval coming before this element. */
+	/* search for end interval coming before this element.
+	 * end intervals don't carry a timeout extension, they
+	 * are coupled with the interval start element.
+	 */
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
-		if (nft_rbtree_interval_end(rbe_prev))
+		if (nft_rbtree_interval_end(rbe_prev) &&
+		    nft_set_elem_active(&rbe_prev->ext, genmask))
 			break;
 
 		prev = rb_prev(prev);
 	}
 
-	if (rbe_prev) {
+	if (prev) {
+		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+
 		rb_erase(&rbe_prev->node, &priv->root);
 		atomic_dec(&set->nelems);
+		nft_set_gc_batch_add(gcb, rbe_prev);
 	}
 
 	rb_erase(&rbe->node, &priv->root);
@@ -321,7 +329,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		/* perform garbage collection to avoid bogus overlap reports. */
 		if (nft_set_elem_expired(&rbe->ext)) {
-			err = nft_rbtree_gc_elem(set, priv, rbe);
+			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
 
-- 
2.41.0


