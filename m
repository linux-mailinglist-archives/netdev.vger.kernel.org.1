Return-Path: <netdev+bounces-110951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102292F1B4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236701C22150
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154D1A00F7;
	Thu, 11 Jul 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW8lDLGV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF11A00DF
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735641; cv=none; b=ZBizuLipgDTNFMnR64cSMxC84ldCCHguN24GtnjbqxKvFEImhHgL0HH4Fpma4ZG61BVr3Hdb5qHvGWgeT8u7w7P6PHsUk8EoCfwzO9O00aYOWsGeIJ/nHVnTd4WdPnk50LCn+AWew4lDMXZAncpkvDU7yRNAYSWZF9x6oGfiwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735641; c=relaxed/simple;
	bh=LnRzQSNxhKhZop4m9SC1mc7SXZX2f7qSaUKClO/ijpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV7HQ8FQBef4aVrSH/2ZLfUKmrALsctfMbYqERRPM4ah9+wf7DObYcNQqcCZwv9XoFPY3pRkDa2/klgGLJ82YYhf+R7WY79RQXjbCQP4Ry7oXR8E7UFgVArHvtTVFhgvemMwiL4zFkR+zm39TnupHG76x2aqzr0Ik2uFmXaXS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW8lDLGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BEBC4AF0D;
	Thu, 11 Jul 2024 22:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735641;
	bh=LnRzQSNxhKhZop4m9SC1mc7SXZX2f7qSaUKClO/ijpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tW8lDLGViUahmkcWvCiRjj+3u0cPC6WVMF7dla2tkmFrUQkolFYI1STT3YFIRQkLx
	 5CUnTqzH1D8X9PAz3kAY76Ew4hPTYFmomUGk2KX14Bh9+jharzK9qvO67RfIIT3/0y
	 Hivi9Rski9YDiaFGNy8Tk0pj/p5lyX5RdFrPjLdOrHXsZ+T4UJpsX9Qdat7wohTD9O
	 I6ghv5ukkwOJIY/Pb52V9P5XQWMDMbyiFTeyGjehtA6wIos4zttowKDt2MJHwcqmIq
	 1udgb0sUt0smu2go8XtcvhYGBGJXVgCliIqOo/V3XxooazyerVkgugruxanNlO3NBy
	 IJBHZB8M4HelA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/11] net: ethtool: let drivers declare max size of RSS indir table and key
Date: Thu, 11 Jul 2024 15:07:04 -0700
Message-ID: <20240711220713.283778-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
References: <20240711220713.283778-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers (bnxt but I think also mlx5 from ML discussions) change
the size of the indirection table depending on the number of Rx rings.
Decouple the max table size from the size of the currently used table,
so that we can reserve space in the context for table growth.

Static members in ethtool_ops are good enough for now, we can add
callbacks to read the max size more dynamically if someone needs
that.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v2:
 - move key_off to the end, under the private label (hiding from kdoc)
---
 include/linux/ethtool.h | 20 +++++++-----------
 net/ethtool/ioctl.c     | 46 ++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 89da0254ccd4..a1ee76936f53 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -181,6 +181,7 @@ struct ethtool_rxfh_context {
 	/* private: driver private data, indirection table, and hash key are
 	 * stored sequentially in @data area.  Use below helpers to access.
 	 */
+	u32 key_off;
 	u8 data[] __aligned(sizeof(void *));
 };
 
@@ -196,18 +197,7 @@ static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
 
 static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 {
-	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
-}
-
-static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
-					       u16 priv_size)
-{
-	size_t indir_bytes = array_size(indir_size, sizeof(u32));
-	size_t flex_len;
-
-	flex_len = size_add(size_add(indir_bytes, key_size),
-			    ALIGN(priv_size, sizeof(u32)));
-	return struct_size_t(struct ethtool_rxfh_context, data, flex_len);
+	return &ctx->data[ctx->key_off];
 }
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
@@ -723,6 +713,10 @@ struct ethtool_rxfh_param {
  *	contexts.
  * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
  *	RSS.
+ * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
+ *	size as returned by @get_rxfh_indir_size may change during lifetime
+ *	of the device. Leave as 0 if the table size is constant.
+ * @rxfh_key_space: same as @rxfh_indir_space, but for the key.
  * @rxfh_priv_size: size of the driver private data area the core should
  *	allocate for an RSS context (in &struct ethtool_rxfh_context).
  * @rxfh_max_context_id: maximum (exclusive) supported RSS context ID.  If this
@@ -940,6 +934,8 @@ struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
+	u32	rxfh_indir_space;
+	u16	rxfh_key_space;
 	u16	rxfh_priv_size;
 	u32	rxfh_max_context_id;
 	u32	supported_coalesce_params;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 615812ff8974..0732710a4836 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1290,6 +1290,40 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	return ret;
 }
 
+static struct ethtool_rxfh_context *
+ethtool_rxfh_ctx_alloc(const struct ethtool_ops *ops,
+		       u32 indir_size, u32 key_size)
+{
+	size_t indir_bytes, flex_len, key_off, size;
+	struct ethtool_rxfh_context *ctx;
+	u32 priv_bytes, indir_max;
+	u16 key_max;
+
+	key_max = max(key_size, ops->rxfh_key_space);
+	indir_max = max(indir_size, ops->rxfh_indir_space);
+
+	priv_bytes = ALIGN(ops->rxfh_priv_size, sizeof(u32));
+	indir_bytes = array_size(indir_max, sizeof(u32));
+
+	key_off = size_add(priv_bytes, indir_bytes);
+	flex_len = size_add(key_off, key_max);
+	size = struct_size_t(struct ethtool_rxfh_context, data, flex_len);
+
+	ctx = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		return NULL;
+
+	ctx->indir_size = indir_size;
+	ctx->key_size = key_size;
+	ctx->key_off = key_off;
+	ctx->priv_size = ops->rxfh_priv_size;
+
+	ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
+	ctx->input_xfrm = RXH_XFRM_NO_CHANGE;
+
+	return ctx;
+}
+
 static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 					       void __user *useraddr)
 {
@@ -1406,20 +1440,12 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			ret = -EINVAL;
 			goto out;
 		}
-		ctx = kzalloc(ethtool_rxfh_context_size(dev_indir_size,
-							dev_key_size,
-							ops->rxfh_priv_size),
-			      GFP_KERNEL_ACCOUNT);
+		ctx = ethtool_rxfh_ctx_alloc(ops, dev_indir_size, dev_key_size);
 		if (!ctx) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		ctx->indir_size = dev_indir_size;
-		ctx->key_size = dev_key_size;
-		ctx->priv_size = ops->rxfh_priv_size;
-		/* Initialise to an empty context */
-		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
-		ctx->input_xfrm = RXH_XFRM_NO_CHANGE;
+
 		if (ops->create_rxfh_context) {
 			u32 limit = ops->rxfh_max_context_id ?: U32_MAX;
 			u32 ctx_id;
-- 
2.45.2


