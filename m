Return-Path: <netdev+bounces-81011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD5885824
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30AD1F21879
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499F58AC0;
	Thu, 21 Mar 2024 11:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413F5813B;
	Thu, 21 Mar 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020087; cv=none; b=FjrJ7bmRTz4F1dUMhAQ01ehoWGF2epGYFuIyFLmEgPr+emdJtMM7QK6HrsZqfEG5gTXQnvJ2NlqIB20ZiCcFF3ObZ4FvY2JMk2akki61XatCJxr9PtoLrHxvgdMLQ3HJU4zftzODjAXrGy2njjBlKFSjS53TrP4REub6RrKNh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020087; c=relaxed/simple;
	bh=ZWDJNGv/fYX3DYM/IgV4AkcO6UwWPFiUHdwDGw+UIlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6vLypPOGhux4HKfvpF76sITJFAXvJ6TbFZ6u9tGxQhmfKE5MwoLKtN8xRQxhXzK6cW5ih+J5azY88auQAFJ8MYwx4S7NGPfRZlU+Vb3nNagLKEzZNs5ApiXylr5yPtnIP7jbRxxRHpZdZ4XyGEcXcQF2r2KTZVbQUdQAffTMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 1/3] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Thu, 21 Mar 2024 12:21:15 +0100
Message-Id: <20240321112117.36737-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240321112117.36737-1-pablo@netfilter.org>
References: <20240321112117.36737-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clone already always provides a current view of the lookup table, use it
to destroy the set, otherwise it is possible to destroy elements twice.

This fix requires:

 212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")

which came after:

 9827a0e6e23b ("netfilter: nft_set_pipapo: release elements in clone from abort path").

Fixes: 9827a0e6e23b ("netfilter: nft_set_pipapo: release elements in clone from abort path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index c0ceea068936..df8de5090246 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2329,8 +2329,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(ctx, set, m);
-
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2342,8 +2340,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (priv->clone) {
 		m = priv->clone;
 
-		if (priv->dirty)
-			nft_set_pipapo_match_destroy(ctx, set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
-- 
2.30.2


