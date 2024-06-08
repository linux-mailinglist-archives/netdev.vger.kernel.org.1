Return-Path: <netdev+bounces-102046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3B9013E1
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 00:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD041C20CD0
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6871A2D04E;
	Sat,  8 Jun 2024 22:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5281804E
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717885245; cv=none; b=fSuDwxhwfmDJI9BFFxXaBZuJcPhWPMrxoj7M6Z49aEdR3tAWz2TcMrtXjVxsrfuXCbCCGwPzWue2NperzZL09e1rSDqoZIbpKCTtoA+0gpiIUPZ2sc/zxSEN+nXCf6rvnaDPAxr2jy34/1lTIhmnuOpaSaqukAAfMCjcrF8QbSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717885245; c=relaxed/simple;
	bh=/THOkb+pqF4RXvc0saAgPhix/AADZCEigr6HtTFyehA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/Np2ssGns41l+unjaMgWNgVMtDUlkWjK9US9xk3dj6brSFMm1xEz5J7trS1ODbIj1+ZhOrmdXJlFtAAKvneqYPKNiVBSFBeGkphMNTpDq4AhSKgOHfWOsJLUcaGfaFGtVFoJvJNjRKLMG1//becpDI2gEGKWlOsJgLP09JOqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sG4QU-0003iq-CW; Sun, 09 Jun 2024 00:20:42 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	willemb@google.com,
	pablo@netfilter.org
Subject: [PATCH net-next v2 2/2] net: add and use __skb_get_hash_symmetric_net
Date: Sun,  9 Jun 2024 00:10:40 +0200
Message-ID: <20240608221057.16070-3-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240608221057.16070-1-fw@strlen.de>
References: <20240608221057.16070-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous patch: apply same logic for
__skb_get_hash_symmetric and let callers pass the netns to the dissector
core.

Existing function is turned into a wrapper to avoid adjusting all
callers, nft_hash.c uses new function.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 No changes.

 include/linux/skbuff.h    | 8 +++++++-
 net/core/flow_dissector.c | 6 +++---
 net/netfilter/nft_hash.c  | 3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6e78019f899a..813406a9bd6c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1498,8 +1498,14 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)
 	__skb_set_hash(skb, hash, true, is_l4);
 }
 
+u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb);
+
+static inline u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
+{
+	return __skb_get_hash_symmetric_net(NULL, skb);
+}
+
 void __skb_get_hash_net(const struct net *net, struct sk_buff *skb);
-u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
 u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 		   const struct flow_keys_basic *keys, int hlen);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 702b4f0a70b6..e479790db0f7 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1845,19 +1845,19 @@ EXPORT_SYMBOL(make_flow_keys_digest);
 
 static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
 
-u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
+u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {
 	struct flow_keys keys;
 
 	__flow_hash_secret_init();
 
 	memset(&keys, 0, sizeof(keys));
-	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
+	__skb_flow_dissect(net, skb, &flow_keys_dissector_symmetric,
 			   &keys, NULL, 0, 0, 0, 0);
 
 	return __flow_hash_from_keys(&keys, &hashrnd);
 }
-EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
+EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric_net);
 
 /**
  * __skb_get_hash_net: calculate a flow hash
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index 92d47e469204..868d68302d22 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -51,7 +51,8 @@ static void nft_symhash_eval(const struct nft_expr *expr,
 	struct sk_buff *skb = pkt->skb;
 	u32 h;
 
-	h = reciprocal_scale(__skb_get_hash_symmetric(skb), priv->modulus);
+	h = reciprocal_scale(__skb_get_hash_symmetric_net(nft_net(pkt), skb),
+			     priv->modulus);
 
 	regs->data[priv->dreg] = h + priv->offset;
 }
-- 
2.44.2


