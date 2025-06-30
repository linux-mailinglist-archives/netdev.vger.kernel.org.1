Return-Path: <netdev+bounces-202552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F10AEE417
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5535917F905
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC012E62CB;
	Mon, 30 Jun 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abs+HmTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947C292B20
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299804; cv=none; b=Iast/InZEODPuaZgubRBWMGmTrrgJ8hNdpCa75lr+yYyTj6ecy36iagywdm7VfWmhBQQ4Ri0QhuzQJQw65cJ1jiJ/T1BP6YVwsEN9lw3WKhP5oKqvFdOqZYDYdWWf9iccO1TZqGASAZB5T5WHwDbYji27x1JMFLNFz+EY0vXles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299804; c=relaxed/simple;
	bh=5UVzs+MFy2UQm2zhShEbkqCHzjRWdEXnlNrRmJ5xOz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqWotp3cg1cFtF7T/PvZ6IlYcFpKNJfwhPKt/WV5azFuq8EZmaQXTPq3FrN5T5y29q5UaunrUQAIOdKV7ARbpN45wWQX08ILAFoNl7myHyGXbqb8OO/6gRpHKDLdtAsykU78NscMlO4AKKNSwcRFi3wOCYf7f+eaiWB18V6VtFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abs+HmTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94618C4CEF3;
	Mon, 30 Jun 2025 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299804;
	bh=5UVzs+MFy2UQm2zhShEbkqCHzjRWdEXnlNrRmJ5xOz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abs+HmTs5hSh6hDNfVHFNxu+i+FWgDqdSWlQPAkFb6J56B6JSj5iykSCmWKuGFznw
	 jdDwCPK9A8i6EGvjsCDjNkKucyZLnw0aRLqJSh/j3OzCEZjhnJfcWYl37Oy8Y7Pvc1
	 Z1QM7ecJYtqP7yWjwrnooxBzo+t20hhhOURw21qDxLckHQpWk2jvCVJc35yMtlT1yR
	 LSI2cwj+F1MXefkmZAGQGAQq4lfnQpaNDxV608+I0IaAnZMssPbR8/EfA5doG2ODjr
	 UxCx2G4Hg0vMOz1kJFBqUBny055W5WpuS5bSmyWhT/6mul3VHYt5PgjSKCpelIsC21
	 lLDSizOnsMeeQ==
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
Subject: [PATCH net-next 4/5] net: ethtool: remove the compat code for _rxfh_context ops
Date: Mon, 30 Jun 2025 09:09:52 -0700
Message-ID: <20250630160953.1093267-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630160953.1093267-1-kuba@kernel.org>
References: <20250630160953.1093267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers are now converted to dedicated _rxfh_context ops.
Remove the use of >set_rxfh() to manage additional contexts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h |  4 ----
 net/core/dev.c          |  6 +-----
 net/ethtool/ioctl.c     | 39 +++------------------------------------
 net/ethtool/rss.c       |  3 +--
 4 files changed, 5 insertions(+), 47 deletions(-)

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
index 7ee808eb068e..d8936457d2f9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11988,11 +11988,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		rxfh.rss_delete = true;
 
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


