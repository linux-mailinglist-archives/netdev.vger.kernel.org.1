Return-Path: <netdev+bounces-108630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AB924C54
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B15A1C2274C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B017DA15;
	Tue,  2 Jul 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa9QDB/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18317DA12
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964101; cv=none; b=Glb652c2YfJuUDuje2DcwJGB6Ovh/6HMmdYk3L+svUjLu3RsjOvCrusxpdN8v/lXi6QgMjK2kHWRgR41+Q038W8MEt4ScZwP0ozHwTAJeYNOC4PhwWgQflzGa3tWR9u96A9/cdeZrvbBhnsQBBIpR3C0qUbWGE/DeNJHjaeaw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964101; c=relaxed/simple;
	bh=r3DwL5bmR6kxDFjNiaO+3ZgEHfTYNXRyo10iBdK3y2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chxOGsSKoRkgRz+MVXM9RMX7p0B+xn1sdg/7veq9Sf+JiuuCg3NniYgDEDQg78uuZ+hiiFPdi3eaWBEJPNnNoMThK7K8BLAJIJbC8CacAdhgkX7AhnpZZJtlSQvKvqqCcVx+eigpzcOPR0pv5eIKw+qJsYap0esUHbX8U+IXh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa9QDB/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618F0C32781;
	Tue,  2 Jul 2024 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964101;
	bh=r3DwL5bmR6kxDFjNiaO+3ZgEHfTYNXRyo10iBdK3y2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aa9QDB/S+G7SY17eJT3JpscJlY2fUIkhTItV/PuOfEZXnQU2rLH4Q+R67+452ZjdV
	 is1+YkczW25vgundfF8YoaNXTIRvziTc7e3vEQYgObsgI28bX5/sOm0Xl6sV+9maRz
	 XJLrELz+jX6B6iLOmyFisRg31cqqz3m4yHVP1NwqS+Sa0OqiRbUhFI5O1SBTvUblcs
	 l44SYgPyd/Kt/Z0eCHhmmhP3GSASrtaNbSb3mOY567NIHAaahCz5czxjThu7HJxSw6
	 0uSr/tBTEaBjTDjHlSIaUOx8XZpFDv0QJEQone+UZcwLh01w66Lo15CKs6As/iUluQ
	 C33lVOluS2sLA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/11] net: ethtool: let drivers declare max size of RSS indir table and key
Date: Tue,  2 Jul 2024 16:47:48 -0700
Message-ID: <20240702234757.4188344-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702234757.4188344-1-kuba@kernel.org>
References: <20240702234757.4188344-1-kuba@kernel.org>
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
---
 include/linux/ethtool.h | 20 +++++++-----------
 net/ethtool/ioctl.c     | 46 ++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 3ce5be0d168a..dc8ed93097c3 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -173,6 +173,7 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 struct ethtool_rxfh_context {
 	u32 indir_size;
 	u32 key_size;
+	u32 key_off;
 	u16 priv_size;
 	u8 hfunc;
 	u8 input_xfrm;
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
index 46f0497ae6bc..7e0fa9fafc7d 100644
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


