Return-Path: <netdev+bounces-204673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C3EAFBAEC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE43188C144
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF02264F96;
	Mon,  7 Jul 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN5u0kkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C81265626
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913684; cv=none; b=WrVOeYEzbgUAQP0h1K6f6+JuxKcxG+WXRmmvpn0+i5N3ktjsNg0/nwNKR/RAUgZp4QXaafeMwhFGxoCoOqzkZ63r7AYzJlK/fJMgLKuur+eF8boM+BPnZeFYHOivmbh05Go/ndoTSjE1bdfbn9Ra1EGVXHKDe7L94LUWgrhxzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913684; c=relaxed/simple;
	bh=f1J+eeO3muAeWjpybnOK6yyMcjLTy4C5b56gUhzavuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZpM4MJeNaxPttO/m4ka9gcdMWy4gEJvvKxZmjt3+YMEp/YWmpe26okG3IaDCQePceEArHjHJCjNxY13ldZjBjHHsjFlm97jL4gidZudhRC/4RKoRsgqex8nRFgIhhRtQSLQpJ80FKlpEc0b/n1bSlGsYj+f3YDLmlBcxCfgdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN5u0kkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E92C4CEE3;
	Mon,  7 Jul 2025 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913684;
	bh=f1J+eeO3muAeWjpybnOK6yyMcjLTy4C5b56gUhzavuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NN5u0kkk8sHnlYjdkaJse2N1SEAR8AmAoOqvUOK0DTaDt7BQkXB8TAt+74MmDQ793
	 sIjfXRXLgCml7ceah9UTurFQ4aBrpc1arBGFILPIz6rsDUix+NgGXkVYuvBirBp+jY
	 E2YPFbGrPHUjmhN4AL5viZ9viTLaDswV6SKA8BZhSUL3+lrWCStThRRgd3rXAwkNaf
	 l2FFqYbpzrC5yBJLk4JEILwZ7Bns8vdcOFa97udoZT1Ch3D6NxhwUjBWg23L6xbJjz
	 fEW/O515lwCmXOra+r1bOxyGR7N7gq7qHppBEj5L2CRVPvwhmDDKtfNyXiFpy3MG/I
	 7RJnaK8R8LO5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 4/5] net: ethtool: remove the compat code for _rxfh_context ops
Date: Mon,  7 Jul 2025 11:41:14 -0700
Message-ID: <20250707184115.2285277-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707184115.2285277-1-kuba@kernel.org>
References: <20250707184115.2285277-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers are now converted to dedicated _rxfh_context ops.
Remove the use of >set_rxfh() to manage additional contexts.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - remove a couple more branches
 - bring back a comment
v2: https://lore.kernel.org/20250702030606.1776293-5-kuba@kernel.org
 - remove rxfh struct in netdev_rss_contexts_free()
v1: https://lore.kernel.org/20250630160953.1093267-5-kuba@kernel.org
---
 include/linux/ethtool.h |  4 ---
 net/core/dev.c          | 15 +---------
 net/ethtool/ioctl.c     | 65 +++++++++--------------------------------
 net/ethtool/rss.c       |  3 +-
 4 files changed, 16 insertions(+), 71 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 59877fd2a1d3..de5bd76a400c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -865,9 +865,6 @@ struct kernel_ethtool_ts_info {
  * @supported_input_xfrm: supported types of input xfrm from %RXH_XFRM_*.
  * @cap_link_lanes_supported: indicates if the driver supports lanes
  *	parameter.
- * @cap_rss_ctx_supported: indicates if the driver supports RSS
- *	contexts via legacy API, drivers implementing @create_rxfh_context
- *	do not have to set this bit.
  * @rxfh_per_ctx_fields: device supports selecting different header fields
  *	for Rx hash calculation and RSS for each additional context.
  * @rxfh_per_ctx_key: device supports setting different RSS key for each
@@ -1100,7 +1097,6 @@ struct kernel_ethtool_ts_info {
 struct ethtool_ops {
 	u32     supported_input_xfrm:8;
 	u32     cap_link_lanes_supported:1;
-	u32     cap_rss_ctx_supported:1;
 	u32	rxfh_per_ctx_fields:1;
 	u32	rxfh_per_ctx_key:1;
 	u32	cap_rss_rxnfc_adds:1;
diff --git a/net/core/dev.c b/net/core/dev.c
index 96d33dead604..0268cad04301 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11976,21 +11976,8 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 
 	mutex_lock(&dev->ethtool->rss_lock);
 	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
-		struct ethtool_rxfh_param rxfh;
-
-		rxfh.indir = ethtool_rxfh_context_indir(ctx);
-		rxfh.key = ethtool_rxfh_context_key(ctx);
-		rxfh.hfunc = ctx->hfunc;
-		rxfh.input_xfrm = ctx->input_xfrm;
-		rxfh.rss_context = context;
-		rxfh.rss_delete = true;
-
 		xa_erase(&dev->ethtool->rss_ctx, context);
-		if (dev->ethtool_ops->create_rxfh_context)
-			dev->ethtool_ops->remove_rxfh_context(dev, ctx,
-							      context, NULL);
-		else
-			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
+		dev->ethtool_ops->remove_rxfh_context(dev, ctx, context, NULL);
 		kfree(ctx);
 	}
 	xa_destroy(&dev->ethtool->rss_ctx);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b6d96e562c9a..d8a17350d3e8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1391,8 +1391,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
-	if (rxfh.rss_context && !(ops->cap_rss_ctx_supported ||
-				  ops->create_rxfh_context))
+	if (rxfh.rss_context && !ops->create_rxfh_context)
 		return -EOPNOTSUPP;
 
 	rxfh.indir_size = rxfh_dev.indir_size;
@@ -1534,8 +1533,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
-	if (rxfh.rss_context && !(ops->cap_rss_ctx_supported ||
-				  ops->create_rxfh_context))
+	if (rxfh.rss_context && !ops->create_rxfh_context)
 		return -EOPNOTSUPP;
 	/* Check input data transformation capabilities */
 	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
@@ -1634,6 +1632,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	}
 
 	if (create) {
+		u32 limit, ctx_id;
+
 		if (rxfh_dev.rss_delete) {
 			ret = -EINVAL;
 			goto out_unlock;
@@ -1644,21 +1644,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			goto out_unlock;
 		}
 
-		if (ops->create_rxfh_context) {
-			u32 limit = ops->rxfh_max_num_contexts ?: U32_MAX;
-			u32 ctx_id;
-
-			/* driver uses new API, core allocates ID */
-			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
-				       XA_LIMIT(1, limit - 1),
-				       GFP_KERNEL_ACCOUNT);
-			if (ret < 0) {
-				kfree(ctx);
-				goto out_unlock;
-			}
-			WARN_ON(!ctx_id); /* can't happen */
-			rxfh.rss_context = ctx_id;
+		limit = ops->rxfh_max_num_contexts ?: U32_MAX;
+		ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
+			       XA_LIMIT(1, limit - 1), GFP_KERNEL_ACCOUNT);
+		if (ret < 0) {
+			kfree(ctx);
+			goto out_unlock;
 		}
+		WARN_ON(!ctx_id); /* can't happen */
+		rxfh.rss_context = ctx_id;
 	} else if (rxfh.rss_context) {
 		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
 		if (!ctx) {
@@ -1670,7 +1664,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.rss_context = rxfh.rss_context;
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
-	if (rxfh.rss_context && ops->create_rxfh_context) {
+	if (rxfh.rss_context) {
 		if (create) {
 			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
 						       extack);
@@ -1693,8 +1687,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (ret) {
 		if (create) {
 			/* failed to create, free our new tracking entry */
-			if (ops->create_rxfh_context)
-				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
+			xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
 			kfree(ctx);
 		}
 		goto out_unlock;
@@ -1713,36 +1706,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
 	/* Update rss_ctx tracking */
-	if (create && !ops->create_rxfh_context) {
-		/* driver uses old API, it chose context ID */
-		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh_dev.rss_context))) {
-			/* context ID reused, our tracking is screwed */
-			kfree(ctx);
-			goto out_unlock;
-		}
-		/* Allocate the exact ID the driver gave us */
-		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh_dev.rss_context,
-				       ctx, GFP_KERNEL))) {
-			kfree(ctx);
-			goto out_unlock;
-		}
-
-		/* Fetch the defaults for the old API, in the new API drivers
-		 * should write defaults into ctx themselves.
-		 */
-		rxfh_dev.indir = (u32 *)rss_config;
-		rxfh_dev.indir_size = dev_indir_size;
-
-		rxfh_dev.key = rss_config + indir_bytes;
-		rxfh_dev.key_size = dev_key_size;
-
-		ret = ops->get_rxfh(dev, &rxfh_dev);
-		if (WARN_ON(ret)) {
-			xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
-			kfree(ctx);
-			goto out_unlock;
-		}
-	}
 	if (rxfh_dev.rss_delete) {
 		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
 		kfree(ctx);
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index e717f23cbc10..4e8ca2c38175 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -163,8 +163,7 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		return -EOPNOTSUPP;
 
 	/* Some drivers don't handle rss_context */
-	if (request->rss_context &&
-	    !ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
+	if (request->rss_context && !ops->create_rxfh_context)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&dev->ethtool->rss_lock);
-- 
2.50.0


