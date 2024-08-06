Return-Path: <netdev+bounces-116224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8594985A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A4B2817A1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49051155351;
	Tue,  6 Aug 2024 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctty8EQX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBD155307
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972822; cv=none; b=gJMODNUSLB6JPVyukmp/zRAqhfM5UEV6Ek6NNRP4/zXt/386cZ/5k2yDmmLhEwb1nmgA8DMfezhU7tLTnSCK1vzA2qhL8w+7bJTdfKXMX4YhN9c+f9izuopvQpCq8HFLUdzElvAmdiJDIJIHcF2ARj3wljNSkbDVkkdg7Z6ys5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972822; c=relaxed/simple;
	bh=LqQJIT7AUEdDqYLilu2yynPsoirZlCFYGE2I3wcBUzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiAAO/OFISmC63c/g+8ywauWXPT1MpsHbwQ2ycKs7+y3bgX8hFItWlZWyGkSR2m44xiWtnokd2elLbfeVkF7pVUxIZ7STMc0V+C67l1QsM0rRS1EKIJD87chx2dzGzWaovjxyQfw3O2Alm8bAeXf3DM/dRKV3yjZYTv1ntcgbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctty8EQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E74C32786;
	Tue,  6 Aug 2024 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972821;
	bh=LqQJIT7AUEdDqYLilu2yynPsoirZlCFYGE2I3wcBUzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ctty8EQXKsS8dv/V9MG7tZ/Mz/3qpx+Av0rgbjipSB+toG/oIh3u2z+JTlBDz9D//
	 TaHhHs4attP3Mp4SPGzW/16AAKqmxFEhfnWPNuhdk9yvLR43tKDAtHWuXX0jInwFP7
	 LjzBrPf3otw1AiCmEQubgAvp0NJqPqccO7lPkciY1Apwmj0SdSls+piL+/yyvUhWs5
	 qmaN35QrwpPwMEmKKnTFCG6EPyfVEF4fkfxo+G9KgGjnZhDSK+6OLEsmVR3mXGExAA
	 KmQe94K1p0Qjj14/ECHsFGhV+jG8C+H9mvgGtIqWqRseFzWA9NVjE8YCUP+pNt2hQG
	 bxqu6XIOYpGrA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 06/12] ethtool: rss: don't report key if device doesn't support it
Date: Tue,  6 Aug 2024 12:33:11 -0700
Message-ID: <20240806193317.1491822-7-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

marvell/otx2 and mvpp2 do not support setting different
keys for different RSS contexts. Contexts have separate
indirection tables but key is shared with all other contexts.
This is likely fine, indirection table is the most important
piece.

Don't report the key-related parameters from such drivers.
This prevents driver-errors, e.g. otx2 always writes
the main key, even when user asks to change per-context key.
The second reason is that without this change tracking
the keys by the core gets complicated. Even if the driver
correctly reject setting key with rss_context != 0,
change of the main key would have to be reflected in
the XArray for all additional contexts.

Since the additional contexts don't have their own keys
not including the attributes (in Netlink speak) seems
intuitive. ethtool CLI seems to deal with it just fine.

Having to set the flag in majority of the drivers is
a bit tedious but not reporting the key is a safer
default.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - add safety note to the commit message
 - use true in sfc, drop sienna
 - extend kdoc of @rxfh_per_ctx_key
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  1 +
 drivers/net/ethernet/sfc/ef100_ethtool.c      |  1 +
 drivers/net/ethernet/sfc/ethtool.c            |  1 +
 include/linux/ethtool.h                       |  4 +++
 net/ethtool/ioctl.c                           | 25 ++++++++++++++++---
 net/ethtool/rss.c                             | 21 +++++++++++-----
 8 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 33e8cf0a3764..77621ccfff5e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5289,6 +5289,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
+	.rxfh_per_ctx_key		= 1,
 	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
 	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
 	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8c990c976132..b5b57926cdc0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4725,6 +4725,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH,
 	.cap_rss_sym_xor_supported = true,
+	.rxfh_per_ctx_key	= true,
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
 	.get_fec_stats		= ice_get_fec_stats,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 0b941482db30..2d514210aaec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2593,6 +2593,7 @@ static void mlx5e_get_ts_stats(struct net_device *netdev,
 
 const struct ethtool_ops mlx5e_ethtool_ops = {
 	.cap_rss_ctx_supported	= true,
+	.rxfh_per_ctx_key	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index 746b5314acb5..5c2551369812 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -58,6 +58,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
 
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
+	.rxfh_per_ctx_key	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 15245720c949..848b1923133a 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -267,6 +267,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.set_rxnfc		= efx_ethtool_set_rxnfc,
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
+	.rxfh_per_ctx_key	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 55c9f613ab64..8c89dc33d51c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -731,6 +731,9 @@ struct kernel_ethtool_ts_info {
  *	do not have to set this bit.
  * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
  *	RSS.
+ * @rxfh_per_ctx_key: device supports setting different RSS key for each
+ *	additional context. Netlink API should report hfunc, key, and input_xfrm
+ *	for every context, not just context 0.
  * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
  *	size as returned by @get_rxfh_indir_size may change during lifetime
  *	of the device. Leave as 0 if the table size is constant.
@@ -952,6 +955,7 @@ struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
+	u32	rxfh_per_ctx_key:1;
 	u32	rxfh_indir_space;
 	u16	rxfh_key_space;
 	u16	rxfh_priv_size;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 52dfb07393a6..e32b791f8d1c 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1261,10 +1261,15 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 		if (rxfh_dev.indir)
 			memcpy(rxfh_dev.indir, ethtool_rxfh_context_indir(ctx),
 			       indir_bytes);
-		if (rxfh_dev.key)
-			memcpy(rxfh_dev.key, ethtool_rxfh_context_key(ctx),
-			       user_key_size);
-		rxfh_dev.hfunc = ctx->hfunc;
+		if (!ops->rxfh_per_ctx_key) {
+			rxfh_dev.key_size = 0;
+		} else {
+			if (rxfh_dev.key)
+				memcpy(rxfh_dev.key,
+				       ethtool_rxfh_context_key(ctx),
+				       user_key_size);
+			rxfh_dev.hfunc = ctx->hfunc;
+		}
 		rxfh_dev.input_xfrm = ctx->input_xfrm;
 		ret = 0;
 	} else {
@@ -1281,6 +1286,11 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 				&rxfh_dev.input_xfrm,
 				sizeof(rxfh.input_xfrm))) {
 		ret = -EFAULT;
+	} else if (copy_to_user(useraddr +
+				offsetof(struct ethtool_rxfh, key_size),
+				&rxfh_dev.key_size,
+				sizeof(rxfh.key_size))) {
+		ret = -EFAULT;
 	} else if (copy_to_user(useraddr +
 			      offsetof(struct ethtool_rxfh, rss_config[0]),
 			      rss_config, total_size)) {
@@ -1386,6 +1396,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	indir_bytes = dev_indir_size * sizeof(rxfh_dev.indir[0]);
 
+	/* Check settings which may be global rather than per RSS-context */
+	if (rxfh.rss_context && !ops->rxfh_per_ctx_key)
+		if (rxfh.key_size ||
+		    (rxfh.hfunc && rxfh.hfunc != ETH_RSS_HASH_NO_CHANGE) ||
+		    (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_NO_CHANGE))
+			return -EOPNOTSUPP;
+
 	rss_config = kzalloc(indir_bytes + dev_key_size, GFP_USER);
 	if (!rss_config)
 		return -ENOMEM;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index a06bdac8b8a2..cd8100d81919 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -10,6 +10,7 @@ struct rss_req_info {
 
 struct rss_reply_data {
 	struct ethnl_reply_data		base;
+	bool				no_key_fields;
 	u32				indir_size;
 	u32				hkey_size;
 	u32				hfunc;
@@ -60,9 +61,12 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		return -EOPNOTSUPP;
 
 	/* Some drivers don't handle rss_context */
-	if (request->rss_context && !(ops->cap_rss_ctx_supported ||
-				      ops->create_rxfh_context))
-		return -EOPNOTSUPP;
+	if (request->rss_context) {
+		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
+			return -EOPNOTSUPP;
+
+		data->no_key_fields = !ops->rxfh_per_ctx_key;
+	}
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -132,13 +136,18 @@ rss_fill_reply(struct sk_buff *skb, const struct ethnl_req_info *req_base,
 	    nla_put_u32(skb, ETHTOOL_A_RSS_CONTEXT, request->rss_context))
 		return -EMSGSIZE;
 
+	if ((data->indir_size &&
+	     nla_put(skb, ETHTOOL_A_RSS_INDIR,
+		     sizeof(u32) * data->indir_size, data->indir_table)))
+		return -EMSGSIZE;
+
+	if (data->no_key_fields)
+		return 0;
+
 	if ((data->hfunc &&
 	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
 	    (data->input_xfrm &&
 	     nla_put_u32(skb, ETHTOOL_A_RSS_INPUT_XFRM, data->input_xfrm)) ||
-	    (data->indir_size &&
-	     nla_put(skb, ETHTOOL_A_RSS_INDIR,
-		     sizeof(u32) * data->indir_size, data->indir_table)) ||
 	    (data->hkey_size &&
 	     nla_put(skb, ETHTOOL_A_RSS_HKEY, data->hkey_size, data->hkey)))
 		return -EMSGSIZE;
-- 
2.45.2


