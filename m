Return-Path: <netdev+bounces-203129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E8AF08F6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DB74E262D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277E1D07BA;
	Wed,  2 Jul 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bylQX3Kw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88F1CAA7D
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425611; cv=none; b=qpUVJIo4ykm/GvpLN54LfiyzOODdf31YJLpNn3Fbuwe7E3NY09I2ojJz9UqbIyFGGylU/vBdGY03ky+utX2R7ZaFsF3Hh5FQ6W3Mmm06HSvejbkHH30gtGL3I9ooBg+PrZutVbngk6uww/1rxUu3uhlBmIN+Cyb/NBDv0XDrSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425611; c=relaxed/simple;
	bh=yO5WaZne+s6pgpapAaqg++swEQawGa3U3Q1QyZdaM7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsjTRguQfMiKHToFQJfmDdHgbVVpxWgDO7A0ShsUCqKLvJdSVZlL/QXkGOh7mDqryukth9Rc923G9TSydAmrUlk6Xwst1WhIw281JFft5Qt0+PbCYBEsE0qQsbCxBzoL+HxqIsLVDPpgO9WzTDWZkHyIRgncRaGaww+oTqERhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bylQX3Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C362C4CEF2;
	Wed,  2 Jul 2025 03:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425610;
	bh=yO5WaZne+s6pgpapAaqg++swEQawGa3U3Q1QyZdaM7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bylQX3KwWZwxfzqGN93mKtzbmUN+ow58dAnvEjn1tz5YsHB0y2dTfcmGYa4YjqAtP
	 264+2P9nam8VsWqiN3A1lR3G5LjVSkPNHha8g5OVclnOQaMmRsy+IeYYc8kIwmgXB5
	 FnUimx1Z+vjT+/jep27MN+DGnyebNiApn3mwpCchOn/cSRelMyyw7m3DUji3U2XRLB
	 Dt/xvjbCGVy4pSvlecDk6pu/Z2yRqHt0AZATCOSd3TJYI8Qm/aog49u0tH0EEXzOcH
	 FFgkmgd068wTo0WYULiGeLhunBHaZWgEfZzLy/CSBLdgc/u3jDeUMQKbfk5riFtEIj
	 jyDwb/tasMsyQ==
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
Subject: [PATCH net-next v2 1/5] eth: otx2: migrate to the *_rxfh_context ops
Date: Tue,  1 Jul 2025 20:06:02 -0700
Message-ID: <20250702030606.1776293-2-kuba@kernel.org>
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

otx2 only supports additional indirection tables (no separate keys
etc.) so the conversion to dedicated callbacks and core-allocated
context is mostly removing the code which stores the extra tables
in the driver. Core already stores the indirection tables for
additional contexts, and doesn't call .get for them.

One subtle change here is that we'll now start with the table
covering all queues, not directing all traffic to queue 0.
This is what core expects if the user doesn't pass the initial
indir table explicitly (there's a WARN_ON() in the core trying
to make sure driver authors don't forget to populate ctx to
defaults).

Drivers implementing .create_rxfh_context don't have to set
cap_rss_ctx_supported, so remove it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_common.h       |   8 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  27 ++--
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 137 ++++++++++--------
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c |   4 +-
 5 files changed, 90 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 6b59881f78e0..e3765b73c434 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -93,10 +93,6 @@ struct otx2_lmt_info {
 	u64 lmt_addr;
 	u16 lmt_id;
 };
-/* RSS configuration */
-struct otx2_rss_ctx {
-	u8  ind_tbl[MAX_RSS_INDIR_TBL_SIZE];
-};
 
 struct otx2_rss_info {
 	u8 enable;
@@ -104,7 +100,7 @@ struct otx2_rss_info {
 	u16 rss_size;
 #define RSS_HASH_KEY_SIZE	44   /* 352 bit key */
 	u8  key[RSS_HASH_KEY_SIZE];
-	struct otx2_rss_ctx	*rss_ctx[MAX_RSS_GROUPS];
+	u32 ind_tbl[MAX_RSS_INDIR_TBL_SIZE];
 };
 
 /* NIX (or NPC) RX errors */
@@ -1067,7 +1063,7 @@ int otx2_set_hw_capabilities(struct otx2_nic *pfvf);
 int otx2_rss_init(struct otx2_nic *pfvf);
 int otx2_set_flowkey_cfg(struct otx2_nic *pfvf);
 void otx2_set_rss_key(struct otx2_nic *pfvf);
-int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id);
+int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id, const u32 *ind_tbl);
 
 /* Mbox handlers */
 void mbox_handler_msix_offset(struct otx2_nic *pfvf,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 9a10396e7504..f674729124e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -318,21 +318,20 @@ int otx2_set_flowkey_cfg(struct otx2_nic *pfvf)
 	return err;
 }
 
-int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id)
+int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id, const u32 *ind_tbl)
 {
 	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
 	const int index = rss->rss_size * ctx_id;
 	struct mbox *mbox = &pfvf->mbox;
-	struct otx2_rss_ctx *rss_ctx;
 	struct nix_aq_enq_req *aq;
 	int idx, err;
 
 	mutex_lock(&mbox->lock);
-	rss_ctx = rss->rss_ctx[ctx_id];
+	ind_tbl = ind_tbl ?: rss->ind_tbl;
 	/* Get memory to put this msg */
 	for (idx = 0; idx < rss->rss_size; idx++) {
 		/* Ignore the queue if AF_XDP zero copy is enabled */
-		if (test_bit(rss_ctx->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
+		if (test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))
 			continue;
 
 		aq = otx2_mbox_alloc_msg_nix_aq_enq(mbox);
@@ -352,7 +351,7 @@ int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id)
 			}
 		}
 
-		aq->rss.rq = rss_ctx->ind_tbl[idx];
+		aq->rss.rq = ind_tbl[idx];
 
 		/* Fill AQ info */
 		aq->qidx = index + idx;
@@ -390,30 +389,22 @@ void otx2_set_rss_key(struct otx2_nic *pfvf)
 int otx2_rss_init(struct otx2_nic *pfvf)
 {
 	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
-	struct otx2_rss_ctx *rss_ctx;
 	int idx, ret = 0;
 
-	rss->rss_size = sizeof(*rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP]);
+	rss->rss_size = sizeof(*rss->ind_tbl);
 
 	/* Init RSS key if it is not setup already */
 	if (!rss->enable)
 		netdev_rss_key_fill(rss->key, sizeof(rss->key));
 	otx2_set_rss_key(pfvf);
 
-	if (!netif_is_rxfh_configured(pfvf->netdev)) {
-		/* Set RSS group 0 as default indirection table */
-		rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP] = kzalloc(rss->rss_size,
-								  GFP_KERNEL);
-		if (!rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP])
-			return -ENOMEM;
-
-		rss_ctx = rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP];
+	if (!netif_is_rxfh_configured(pfvf->netdev))
 		for (idx = 0; idx < rss->rss_size; idx++)
-			rss_ctx->ind_tbl[idx] =
+			rss->ind_tbl[idx] =
 				ethtool_rxfh_indir_default(idx,
 							   pfvf->hw.rx_queues);
-	}
-	ret = otx2_set_rss_table(pfvf, DEFAULT_RSS_CONTEXT_GROUP);
+
+	ret = otx2_set_rss_table(pfvf, DEFAULT_RSS_CONTEXT_GROUP, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 20de517dfb09..998c734ff839 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -796,35 +796,75 @@ static u32 otx2_get_rxfh_indir_size(struct net_device *dev)
 	return  MAX_RSS_INDIR_TBL_SIZE;
 }
 
-static int otx2_rss_ctx_delete(struct otx2_nic *pfvf, int ctx_id)
+static int otx2_create_rxfh(struct net_device *dev,
+			    struct ethtool_rxfh_context *ctx,
+			    const struct ethtool_rxfh_param *rxfh,
+			    struct netlink_ext_ack *extack)
 {
-	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
+	struct otx2_nic *pfvf = netdev_priv(dev);
+	struct otx2_rss_info *rss;
+	unsigned int queues;
+	u32 *ind_tbl;
+	int idx;
 
-	otx2_rss_ctx_flow_del(pfvf, ctx_id);
-	kfree(rss->rss_ctx[ctx_id]);
-	rss->rss_ctx[ctx_id] = NULL;
+	rss = &pfvf->hw.rss_info;
+	queues = pfvf->hw.rx_queues;
+
+	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
+	ctx->hfunc = ETH_RSS_HASH_TOP;
+
+	if (!rss->enable) {
+		netdev_err(dev, "RSS is disabled, cannot change settings\n");
+		return -EIO;
+	}
+
+	ind_tbl = rxfh->indir;
+	if (!ind_tbl) {
+		ind_tbl = ethtool_rxfh_context_indir(ctx);
+		for (idx = 0; idx < rss->rss_size; idx++)
+			ind_tbl[idx] = ethtool_rxfh_indir_default(idx, queues);
+	}
+
+	otx2_set_rss_table(pfvf, rxfh->rss_context, ind_tbl);
+	return 0;
+}
+
+static int otx2_modify_rxfh(struct net_device *dev,
+			    struct ethtool_rxfh_context *ctx,
+			    const struct ethtool_rxfh_param *rxfh,
+			    struct netlink_ext_ack *extack)
+{
+	struct otx2_nic *pfvf = netdev_priv(dev);
+
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
+
+	if (!pfvf->hw.rss_info.enable) {
+		netdev_err(dev, "RSS is disabled, cannot change settings\n");
+		return -EIO;
+	}
+
+	if (rxfh->indir)
+		otx2_set_rss_table(pfvf, rxfh->rss_context, rxfh->indir);
 
 	return 0;
 }
 
-static int otx2_rss_ctx_create(struct otx2_nic *pfvf,
-			       u32 *rss_context)
+static int otx2_remove_rxfh(struct net_device *dev,
+			    struct ethtool_rxfh_context *ctx,
+			    u32 rss_context,
+			    struct netlink_ext_ack *extack)
 {
-	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
-	u8 ctx;
+	struct otx2_nic *pfvf = netdev_priv(dev);
 
-	for (ctx = 0; ctx < MAX_RSS_GROUPS; ctx++) {
-		if (!rss->rss_ctx[ctx])
-			break;
+	if (!pfvf->hw.rss_info.enable) {
+		netdev_err(dev, "RSS is disabled, cannot change settings\n");
+		return -EIO;
 	}
-	if (ctx == MAX_RSS_GROUPS)
-		return -EINVAL;
-
-	rss->rss_ctx[ctx] = kzalloc(sizeof(*rss->rss_ctx[ctx]), GFP_KERNEL);
-	if (!rss->rss_ctx[ctx])
-		return -ENOMEM;
-	*rss_context = ctx;
 
+	otx2_rss_ctx_flow_del(pfvf, rss_context);
 	return 0;
 }
 
@@ -833,23 +873,14 @@ static int otx2_set_rxfh(struct net_device *dev,
 			 struct ethtool_rxfh_param *rxfh,
 			 struct netlink_ext_ack *extack)
 {
-	u32 rss_context = DEFAULT_RSS_CONTEXT_GROUP;
 	struct otx2_nic *pfvf = netdev_priv(dev);
-	struct otx2_rss_ctx *rss_ctx;
 	struct otx2_rss_info *rss;
-	int ret, idx;
+	int idx;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->rss_context)
-		rss_context = rxfh->rss_context;
-
-	if (rss_context != ETH_RXFH_CONTEXT_ALLOC &&
-	    rss_context >= MAX_RSS_GROUPS)
-		return -EINVAL;
-
 	rss = &pfvf->hw.rss_info;
 
 	if (!rss->enable) {
@@ -861,21 +892,12 @@ static int otx2_set_rxfh(struct net_device *dev,
 		memcpy(rss->key, rxfh->key, sizeof(rss->key));
 		otx2_set_rss_key(pfvf);
 	}
-	if (rxfh->rss_delete)
-		return otx2_rss_ctx_delete(pfvf, rss_context);
 
-	if (rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		ret = otx2_rss_ctx_create(pfvf, &rss_context);
-		rxfh->rss_context = rss_context;
-		if (ret)
-			return ret;
-	}
 	if (rxfh->indir) {
-		rss_ctx = rss->rss_ctx[rss_context];
 		for (idx = 0; idx < rss->rss_size; idx++)
-			rss_ctx->ind_tbl[idx] = rxfh->indir[idx];
+			rss->ind_tbl[idx] = rxfh->indir[idx];
 	}
-	otx2_set_rss_table(pfvf, rss_context);
+	otx2_set_rss_table(pfvf, DEFAULT_RSS_CONTEXT_GROUP, NULL);
 
 	return 0;
 }
@@ -884,9 +906,7 @@ static int otx2_set_rxfh(struct net_device *dev,
 static int otx2_get_rxfh(struct net_device *dev,
 			 struct ethtool_rxfh_param *rxfh)
 {
-	u32 rss_context = DEFAULT_RSS_CONTEXT_GROUP;
 	struct otx2_nic *pfvf = netdev_priv(dev);
-	struct otx2_rss_ctx *rss_ctx;
 	struct otx2_rss_info *rss;
 	u32 *indir = rxfh->indir;
 	int idx, rx_queues;
@@ -894,32 +914,21 @@ static int otx2_get_rxfh(struct net_device *dev,
 	rss = &pfvf->hw.rss_info;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (rxfh->rss_context)
-		rss_context = rxfh->rss_context;
-
 	if (!indir)
 		return 0;
 
-	if (!rss->enable && rss_context == DEFAULT_RSS_CONTEXT_GROUP) {
+	if (!rss->enable) {
 		rx_queues = pfvf->hw.rx_queues;
 		for (idx = 0; idx < MAX_RSS_INDIR_TBL_SIZE; idx++)
 			indir[idx] = ethtool_rxfh_indir_default(idx, rx_queues);
 		return 0;
 	}
-	if (rss_context >= MAX_RSS_GROUPS)
-		return -ENOENT;
 
-	rss_ctx = rss->rss_ctx[rss_context];
-	if (!rss_ctx)
-		return -ENOENT;
-
-	if (indir) {
-		for (idx = 0; idx < rss->rss_size; idx++) {
-			/* Ignore if the rx queue is AF_XDP zero copy enabled */
-			if (test_bit(rss_ctx->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
-				continue;
-			indir[idx] = rss_ctx->ind_tbl[idx];
-		}
+	for (idx = 0; idx < rss->rss_size; idx++) {
+		/* Ignore if the rx queue is AF_XDP zero copy enabled */
+		if (test_bit(rss->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
+			continue;
+		indir[idx] = rss->ind_tbl[idx];
 	}
 	if (rxfh->key)
 		memcpy(rxfh->key, rss->key, sizeof(rss->key));
@@ -1307,12 +1316,12 @@ static void otx2_get_fec_stats(struct net_device *netdev,
 }
 
 static const struct ethtool_ops otx2_ethtool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.supported_ring_params  = ETHTOOL_RING_USE_RX_BUF_LEN |
 				  ETHTOOL_RING_USE_CQE_SIZE,
+	.rxfh_max_num_contexts	= MAX_RSS_GROUPS,
 	.get_link		= otx2_get_link,
 	.get_drvinfo		= otx2_get_drvinfo,
 	.get_strings		= otx2_get_strings,
@@ -1332,6 +1341,9 @@ static const struct ethtool_ops otx2_ethtool_ops = {
 	.set_rxfh		= otx2_set_rxfh,
 	.get_rxfh_fields	= otx2_get_rss_hash_opts,
 	.set_rxfh_fields	= otx2_set_rss_hash_opts,
+	.create_rxfh_context	= otx2_create_rxfh,
+	.modify_rxfh_context	= otx2_modify_rxfh,
+	.remove_rxfh_context	= otx2_remove_rxfh,
 	.get_msglevel		= otx2_get_msglevel,
 	.set_msglevel		= otx2_set_msglevel,
 	.get_pauseparam		= otx2_get_pauseparam,
@@ -1426,12 +1438,12 @@ static int otx2vf_get_link_ksettings(struct net_device *netdev,
 }
 
 static const struct ethtool_ops otx2vf_ethtool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.supported_ring_params  = ETHTOOL_RING_USE_RX_BUF_LEN |
 				  ETHTOOL_RING_USE_CQE_SIZE,
+	.rxfh_max_num_contexts	= MAX_RSS_GROUPS,
 	.get_link		= otx2_get_link,
 	.get_drvinfo		= otx2vf_get_drvinfo,
 	.get_strings		= otx2vf_get_strings,
@@ -1447,6 +1459,9 @@ static const struct ethtool_ops otx2vf_ethtool_ops = {
 	.set_rxfh		= otx2_set_rxfh,
 	.get_rxfh_fields	= otx2_get_rss_hash_opts,
 	.set_rxfh_fields	= otx2_set_rss_hash_opts,
+	.create_rxfh_context	= otx2_create_rxfh,
+	.modify_rxfh_context	= otx2_modify_rxfh,
+	.remove_rxfh_context	= otx2_remove_rxfh,
 	.get_ringparam		= otx2_get_ringparam,
 	.set_ringparam		= otx2_set_ringparam,
 	.get_coalesce		= otx2_get_coalesce,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 4e2d1206e1b0..b23585c5e5c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2158,7 +2158,6 @@ int otx2_stop(struct net_device *netdev)
 	struct otx2_nic *pf = netdev_priv(netdev);
 	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
-	struct otx2_rss_info *rss;
 	int qidx, vec, wrk;
 
 	/* If the DOWN flag is set resources are already freed */
@@ -2176,10 +2175,7 @@ int otx2_stop(struct net_device *netdev)
 	otx2_rxtx_enable(pf, false);
 
 	/* Clear RSS enable flag */
-	rss = &pf->hw.rss_info;
-	rss->enable = false;
-	if (!netif_is_rxfh_configured(netdev))
-		kfree(rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP]);
+	pf->hw.rss_info.enable = false;
 
 	/* Cleanup Queue IRQ */
 	vec = pci_irq_vector(pf->pdev,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
index b328aae23d73..7d67b4cbaf71 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -132,7 +132,7 @@ int otx2_xsk_pool_enable(struct otx2_nic *pf, struct xsk_buff_pool *pool, u16 qi
 	set_bit(qidx, pf->af_xdp_zc_qidx);
 	otx2_clean_up_rq(pf, qidx);
 	/* Reconfigure RSS table as 'qidx' cannot be part of RSS now */
-	otx2_set_rss_table(pf, DEFAULT_RSS_CONTEXT_GROUP);
+	otx2_set_rss_table(pf, DEFAULT_RSS_CONTEXT_GROUP, NULL);
 	/* Kick start the NAPI context so that receiving will start */
 	return otx2_xsk_wakeup(pf->netdev, qidx, XDP_WAKEUP_RX);
 }
@@ -153,7 +153,7 @@ int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qidx)
 	clear_bit(qidx, pf->af_xdp_zc_qidx);
 	xsk_pool_dma_unmap(pool, DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	/* Reconfigure RSS table as 'qidx' now need to be part of RSS now */
-	otx2_set_rss_table(pf, DEFAULT_RSS_CONTEXT_GROUP);
+	otx2_set_rss_table(pf, DEFAULT_RSS_CONTEXT_GROUP, NULL);
 
 	return 0;
 }
-- 
2.50.0


