Return-Path: <netdev+bounces-203132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB538AF08F9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C511C0679D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B11DE3D9;
	Wed,  2 Jul 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGvGCTdB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97471DDC08
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425612; cv=none; b=PXdzIWxr5J1ExZuiklYfh/G3eSI7azNN5WV/7OhM7DooSQyGzwdFwd0M4H3JdtQzI0qM02Vfp5sV6dTvGzYi8H1cs41JssBOzKHqbR6nvwkn5Nb71meqLls74nWexWojy3CZKP5LmJfeTSrDcMZw66S4a+X6gzO9m0agonhJ+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425612; c=relaxed/simple;
	bh=oHFGmOgGD3x7ggjJfX3uL5Ff/+BxAvyECc1HELXihkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcYeQBvAadUxlpoMzb8iu4iCLsgk0RcdmxtP9W8M7z9IcejY7duyEvF6U4V2HXYZcJPCmXcNsfj4f1IgM2MHBaru5hp4RlsrA58dsV9JlT8jkulGciu+R1Am4Re35R0JefZcdft412Abhz/Itj0gtO6u31xBp9SmwMjc3v4sdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGvGCTdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D7C4CEF2;
	Wed,  2 Jul 2025 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425612;
	bh=oHFGmOgGD3x7ggjJfX3uL5Ff/+BxAvyECc1HELXihkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGvGCTdB3y40L2l16eVNrzC+JMkprMVahcuM7VYi6RvNpl8hHnML0naz5tM0vd6M1
	 PeDDk4AK6a94vuj4GDKj/T0CIuAUCtgeTlr6rOvxPvMz0VmBxiN4YSACPUgqNHilsP
	 96q1jVT8efmhtYTp2SKFBvoRjfQ1I1NPMIn9i0/j4POlo7DKGK0YwjBLVs4tQalnFd
	 fRf2svsjNzcWaq2ZsvSDWFBNFUBgwsUPa5EpIcG56h8QWa/o0VuGBR8SElPnY9w08+
	 6x8BfD0eU1ji4yylfgQazuLB0kWbq3mFoZK8xJwQdQJN4TNXZS3CRNX556L26uny6k
	 s54JjqOPdZ4/A==
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
Subject: [PATCH net-next v2 4/5] net: ethtool: remove the compat code for _rxfh_context ops
Date: Tue,  1 Jul 2025 20:06:05 -0700
Message-ID: <20250702030606.1776293-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702030606.1776293-1-kuba@kernel.org>
References: <20250702030606.1776293-1-kuba@kernel.org>
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
v2:
 - remove rxfh struct in netdev_rss_contexts_free()
v1: https://lore.kernel.org/20250630160953.1093267-5-kuba@kernel.org
---
 include/linux/ethtool.h |  4 ----
 net/core/dev.c          | 15 +--------------
 net/ethtool/ioctl.c     | 39 +++------------------------------------
 net/ethtool/rss.c       |  3 +--
 4 files changed, 5 insertions(+), 56 deletions(-)

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
index 7ee808eb068e..ee32d87eb411 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11978,21 +11978,8 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 
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
index b6d96e562c9a..17dbda6afd96 100644
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
@@ -1670,7 +1668,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.rss_context = rxfh.rss_context;
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
-	if (rxfh.rss_context && ops->create_rxfh_context) {
+	if (rxfh.rss_context) {
 		if (create) {
 			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
 						       extack);
@@ -1712,37 +1710,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
-	/* Update rss_ctx tracking */
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


