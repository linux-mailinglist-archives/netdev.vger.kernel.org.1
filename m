Return-Path: <netdev+bounces-115155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582CF94552F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3F11F238A9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C2A92D;
	Fri,  2 Aug 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb1XKc/T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0219474
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557889; cv=none; b=FdqGLc1Q/dDRhMW2A7evibpMdGjweWmhHQFNYhY5TU9OuNM+MWVmx0QffvgO4KUHz5vQ0vAg5nEhimSmbCsKkNt95A1dZ1KBuhUxIvyq5BvN/nDK1ooeANOzAv+KKOy8MxQgC0D2gmXeDIsIw6wBdkEqOFd3SdV0ZbQgt0LiFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557889; c=relaxed/simple;
	bh=kQhoIW+OBUkHTtcVjUMPCbxlYEoef/GWA+jQkTGVwJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLfUjzuoOfZpmINzXuhfE2A8oKDxyTYmRFKhyMxl2ymhvgjaVc6Dn88aEIi64ua8xDNtT9u1ZecrURSoDrZO+5XgdByxZbF6wR9vvNvCoAY3G/aAw+HJVvmFSEbpOs53nxMAm9Nht6cQr7WxEmRcvAy2IBLwp89sv/kSwYKpATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb1XKc/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3352C4AF0F;
	Fri,  2 Aug 2024 00:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557888;
	bh=kQhoIW+OBUkHTtcVjUMPCbxlYEoef/GWA+jQkTGVwJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb1XKc/TvO694aUYE6+nmiyxXaKCCrBLSjPWEr/9omNEl4TW5K0efL0aabZCzlhmA
	 JmopDlPMsxoTrhasiBO4BZ5I5nMalV38r/zfHGvRt60G4YscEh50T7qG5MeO9c15fX
	 sQ0Sp0mazh9BGTwBM38kb1McR3dixswQgf1psKAZIXmlgtXGgjG9BH0rl9EG+qkIOu
	 1Q34TRW6alC5nli+aF+/dtX3/VyDzr3uvez93aoLh7N33E7A+3VeTMpHA1wKph0FDf
	 Txi6lZdvScMEBWDz9I55WYLfqsfrzlykdu6GoB9BqcW2RSPD3YC/CEWsEH+zoBOvn7
	 CnO1LTc2eXneQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk
Subject: [PATCH net-next 02/12] eth: mvpp2: implement new RSS context API
Date: Thu,  1 Aug 2024 17:17:51 -0700
Message-ID: <20240802001801.565176-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the separate create/modify/delete ops for RSS.
No deep changes, just split of the logic.

No problems with IDs - even tho RSS tables are per device
the driver already seems to allocate IDs linearly per port
(there's a translation table from per-port context ID
to device context ID).

mvpp2 doesn't have a key for the hash, and indir table
is always specified at creation by the core, so the only
default we need to set for new contexts is hfunc.

Compile-tested only.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: marcin.s.wojtas@gmail.com
CC: linux@armlinux.org.uk
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 81 ++++++++++++++-----
 1 file changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0d62a33afa80..e962959676ac 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5696,40 +5696,77 @@ static int mvpp2_ethtool_get_rxfh(struct net_device *dev,
 	return ret;
 }
 
-static int mvpp2_ethtool_set_rxfh(struct net_device *dev,
-				  struct ethtool_rxfh_param *rxfh,
-				  struct netlink_ext_ack *extack)
+static bool mvpp2_ethtool_rxfh_okay(struct mvpp2_port *port,
+				    struct ethtool_rxfh_param *rxfh)
+{
+	if (!mvpp22_rss_is_supported(port))
+		return false;
+
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_CRC32)
+		return false;
+
+	if (rxfh->key)
+		return false;
+
+	return true;
+}
+
+static int mvpp2_create_rxfh_context(struct net_device *dev,
+				     struct ethtool_rxfh_context *ctx,
+				     const struct ethtool_rxfh_param *rxfh,
+				     struct netlink_ext_ack *extack)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
 	int ret = 0;
 
-	if (!mvpp22_rss_is_supported(port))
+	if (!mvpp2_ethtool_rxfh_okay(port, rxfh))
 		return -EOPNOTSUPP;
 
-	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	    rxfh->hfunc != ETH_RSS_HASH_CRC32)
+	ctx->hfunc = ETH_RSS_HASH_CRC32;
+
+	ret = mvpp22_port_rss_ctx_create(port, rss_context);
+	if (ret)
+		return ret;
+
+	return mvpp22_port_rss_ctx_indir_set(port, *rss_context, rxfh->indir);
+}
+
+static int mvpp2_modify_rxfh_context(struct net_device *dev,
+				     struct ethtool_rxfh_context *ctx,
+				     const struct ethtool_rxfh_param *rxfh,
+				     struct netlink_ext_ack *extack)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+	int ret = 0;
+
+	if (!mvpp2_ethtool_rxfh_okay(port, rxfh))
 		return -EOPNOTSUPP;
 
-	if (rxfh->key)
-		return -EOPNOTSUPP;
-
-	if (*rss_context && rxfh->rss_delete)
-		return mvpp22_port_rss_ctx_delete(port, *rss_context);
-
-	if (*rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		ret = mvpp22_port_rss_ctx_create(port, rss_context);
-		if (ret)
-			return ret;
-	}
-
 	if (rxfh->indir)
-		ret = mvpp22_port_rss_ctx_indir_set(port, *rss_context,
+		ret = mvpp22_port_rss_ctx_indir_set(port, rxfh->rss_context,
 						    rxfh->indir);
-
 	return ret;
 }
 
+static int mvpp2_remove_rxfh_context(struct net_device *dev,
+				     struct ethtool_rxfh_context *ctx,
+				     u32 rss_context,
+				     struct netlink_ext_ack *extack)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	return mvpp22_port_rss_ctx_delete(port, rss_context);
+}
+
+static int mvpp2_ethtool_set_rxfh(struct net_device *dev,
+				  struct ethtool_rxfh_param *rxfh,
+				  struct netlink_ext_ack *extack)
+{
+	return mvpp2_modify_rxfh_context(dev, NULL, rxfh, extack);
+}
+
 /* Device ops */
 
 static const struct net_device_ops mvpp2_netdev_ops = {
@@ -5750,6 +5787,7 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.cap_rss_ctx_supported	= true,
+	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.nway_reset		= mvpp2_ethtool_nway_reset,
@@ -5772,6 +5810,9 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= mvpp2_ethtool_get_rxfh,
 	.set_rxfh		= mvpp2_ethtool_set_rxfh,
+	.create_rxfh_context	= mvpp2_create_rxfh_context,
+	.modify_rxfh_context	= mvpp2_modify_rxfh_context,
+	.delete_rxfh_context	= mvpp2_delete_rxfh_context,
 };
 
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
-- 
2.45.2


