Return-Path: <netdev+bounces-70192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE784DFAD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59C728C64D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431B574E2E;
	Thu,  8 Feb 2024 11:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4973182;
	Thu,  8 Feb 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391727; cv=none; b=KDUYWzf24QoNe7jX0EFkNv37OxDrU56iFbZL//AVHpJlXgfji0YLRfWOWWvSpNdX1D8p/nwgHf2x2pSA1vuegJCgNu00cF/X4St6p+gXikqv6sQEYxIXQf7tjmmr1HOZNy9eVLqoOpF3b+NXSQRbHY7cap2Bb1kTqqlrSLDnYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391727; c=relaxed/simple;
	bh=cPeYWK4EosRjOppdC99VE/DsVaGgSBiEn8k33p4EeL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxaQsMHbDcf8iEC9mcA6xEjG1W+pWgOACJwPylh/rhAJ2my6VsrqIzQUHHd/55bV8P5Y1DUMxw+dGVUCbiegnvHSVAkj1hMoTiHbM6JjZsKz+z9ISqBM9o7wspJm3KWWsng4CvPORKXxoNblnJBOXTJnUysafpQ8J5fjMDN6eeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	kadlec@netfilter.org
Subject: [PATCH net 10/13] netfilter: nft_set_rbtree: skip end interval element from gc
Date: Thu,  8 Feb 2024 12:28:31 +0100
Message-Id: <20240208112834.1433-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240208112834.1433-1-pablo@netfilter.org>
References: <20240208112834.1433-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rbtree lazy gc on insert might collect an end interval element that has
been just added in this transactions, skip end interval elements that
are not yet active.

Fixes: f718863aca46 ("netfilter: nft_set_rbtree: fix overlap expiration walk")
Cc: stable@vger.kernel.org
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_rbtree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5fd74f993988..9944fe479e53 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -234,7 +234,7 @@ static void nft_rbtree_gc_elem_remove(struct net *net, struct nft_set *set,
 
 static const struct nft_rbtree_elem *
 nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
-		   struct nft_rbtree_elem *rbe, u8 genmask)
+		   struct nft_rbtree_elem *rbe)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
@@ -253,7 +253,7 @@ nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
 		if (nft_rbtree_interval_end(rbe_prev) &&
-		    nft_set_elem_active(&rbe_prev->ext, genmask))
+		    nft_set_elem_active(&rbe_prev->ext, NFT_GENMASK_ANY))
 			break;
 
 		prev = rb_prev(prev);
@@ -365,7 +365,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
-			removed_end = nft_rbtree_gc_elem(set, priv, rbe, genmask);
+			removed_end = nft_rbtree_gc_elem(set, priv, rbe);
 			if (IS_ERR(removed_end))
 				return PTR_ERR(removed_end);
 
-- 
2.30.2


