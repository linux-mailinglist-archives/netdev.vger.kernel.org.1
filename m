Return-Path: <netdev+bounces-115469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C27946760
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9DB1F219B4
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3F8121B;
	Sat,  3 Aug 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgT82hpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291079B84
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659212; cv=none; b=qiLumVwzXYQwugybBEf/FPGmmMXyQ+KffOBvQ9n/DYhnHSdpxqgAtniU8wh2F/K8xDC7Vocg7vOKi9k6BWeTYRx9UHsSZFG5y4G73RBp5HD9P1sndcj12p6imXTthVAZM0CGYR75XQIxyUHzuHBEoiJc1MYatwbtNKRmRkDzSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659212; c=relaxed/simple;
	bh=tjLZCzOSAoLPYlpKaJnyShnO8KOdgGjMWgxCcWz2ltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpC1DFl+cBv23mDuMr2cZQTqhZ6c8swqQ9jkAU+WmLRJR8FGnI8TAZaSAe5HYJLCJ3PPAZ+xHEzsObNd/U5/gPSWLNCMT/5DrmMC+VOm8zf//NTm7X6/0M8NGJOsrNgyUKhKqBYW9PtaabDxJXeL31TgVjCCIxyUUWljneB36Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgT82hpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048B9C4AF0A;
	Sat,  3 Aug 2024 04:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659211;
	bh=tjLZCzOSAoLPYlpKaJnyShnO8KOdgGjMWgxCcWz2ltQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgT82hpNDLQDR1UUAMZhKsax+FtmVjyoAy71+Ej1dkKN8jN88oPsaXe+DBE1KUDwG
	 YFnJs0mMyuaj2LCvlACCf2wtjkb397bQFKYXDUcslERdcuaeCKNOdoo5sIr2BxajPN
	 1lpTZsBqL4kiydYaMufweoSNsc1zh1KLM/4XLmxdP6g/nvS4JAe83n+oSvqdbpWhRo
	 TsOsMZCPpmgqUbRGMU2qB90MuekCr+fwuEEZIThhPvNX3E7BSdPutw0DFBT1xz5OBe
	 5GySHZgbgrm2y/m40WalrKlXPDIft24xLkm19g6cYftXJkis3vYOay+NO00imrgkvF
	 2bZ0Z1ifG5k8A==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>,
	marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk
Subject: [PATCH net-next v2 02/12] eth: mvpp2: implement new RSS context API
Date: Fri,  2 Aug 2024 21:26:14 -0700
Message-ID: <20240803042624.970352-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the separate create/modify/delete ops for RSS.

No problems with IDs - even tho RSS tables are per device
the driver already seems to allocate IDs linearly per port.
There's a translation table from per-port context ID
to device context ID.

mvpp2 doesn't have a key for the hash, it defaults to
an empty/previous indir table.

Compile-tested only.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - copy the default indir table
 - use ID from the core
 - fix build issues

CC: marcin.s.wojtas@gmail.com
CC: linux@armlinux.org.uk
---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    |  18 +---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |   2 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 102 +++++++++++++-----
 3 files changed, 79 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 40aeaa7bd739..1641791a2d5b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1522,29 +1522,19 @@ static int mvpp22_rss_context_create(struct mvpp2_port *port, u32 *rss_ctx)
 	return 0;
 }
 
-int mvpp22_port_rss_ctx_create(struct mvpp2_port *port, u32 *port_ctx)
+int mvpp22_port_rss_ctx_create(struct mvpp2_port *port, u32 port_ctx)
 {
 	u32 rss_ctx;
-	int ret, i;
+	int ret;
 
 	ret = mvpp22_rss_context_create(port, &rss_ctx);
 	if (ret)
 		return ret;
 
-	/* Find the first available context number in the port, starting from 1.
-	 * Context 0 on each port is reserved for the default context.
-	 */
-	for (i = 1; i < MVPP22_N_RSS_TABLES; i++) {
-		if (port->rss_ctx[i] < 0)
-			break;
-	}
-
-	if (i == MVPP22_N_RSS_TABLES)
+	if (WARN_ON_ONCE(port->rss_ctx[port_ctx] >= 0))
 		return -EINVAL;
 
-	port->rss_ctx[i] = rss_ctx;
-	*port_ctx = i;
-
+	port->rss_ctx[port_ctx] = rss_ctx;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 663157dc8062..85c9c6e80678 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -264,7 +264,7 @@ int mvpp22_port_rss_init(struct mvpp2_port *port);
 int mvpp22_port_rss_enable(struct mvpp2_port *port);
 int mvpp22_port_rss_disable(struct mvpp2_port *port);
 
-int mvpp22_port_rss_ctx_create(struct mvpp2_port *port, u32 *rss_ctx);
+int mvpp22_port_rss_ctx_create(struct mvpp2_port *port, u32 rss_ctx);
 int mvpp22_port_rss_ctx_delete(struct mvpp2_port *port, u32 rss_ctx);
 
 int mvpp22_port_rss_ctx_indir_set(struct mvpp2_port *port, u32 rss_ctx,
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0d62a33afa80..90182f6fd9a1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5696,38 +5696,80 @@ static int mvpp2_ethtool_get_rxfh(struct net_device *dev,
 	return ret;
 }
 
+static bool mvpp2_ethtool_rxfh_okay(struct mvpp2_port *port,
+				    const struct ethtool_rxfh_param *rxfh)
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
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+	int ret = 0;
+
+	if (!mvpp2_ethtool_rxfh_okay(port, rxfh))
+		return -EOPNOTSUPP;
+
+	ctx->hfunc = ETH_RSS_HASH_CRC32;
+
+	ret = mvpp22_port_rss_ctx_create(port, rxfh->rss_context);
+	if (ret)
+		return ret;
+
+	if (!rxfh->indir)
+		ret = mvpp22_port_rss_ctx_indir_get(port, rxfh->rss_context,
+						    ethtool_rxfh_context_indir(ctx));
+	else
+		ret = mvpp22_port_rss_ctx_indir_set(port, rxfh->rss_context,
+						    rxfh->indir);
+	return ret;
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
+		return -EOPNOTSUPP;
+
+	if (rxfh->indir)
+		ret = mvpp22_port_rss_ctx_indir_set(port, rxfh->rss_context,
+						    rxfh->indir);
+	return ret;
+}
+
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
 static int mvpp2_ethtool_set_rxfh(struct net_device *dev,
 				  struct ethtool_rxfh_param *rxfh,
 				  struct netlink_ext_ack *extack)
 {
-	struct mvpp2_port *port = netdev_priv(dev);
-	u32 *rss_context = &rxfh->rss_context;
-	int ret = 0;
-
-	if (!mvpp22_rss_is_supported(port))
-		return -EOPNOTSUPP;
-
-	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	    rxfh->hfunc != ETH_RSS_HASH_CRC32)
-		return -EOPNOTSUPP;
-
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
-	if (rxfh->indir)
-		ret = mvpp22_port_rss_ctx_indir_set(port, *rss_context,
-						    rxfh->indir);
-
-	return ret;
+	return mvpp2_modify_rxfh_context(dev, NULL, rxfh, extack);
 }
 
 /* Device ops */
@@ -5750,6 +5792,7 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.cap_rss_ctx_supported	= true,
+	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.nway_reset		= mvpp2_ethtool_nway_reset,
@@ -5772,6 +5815,9 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= mvpp2_ethtool_get_rxfh,
 	.set_rxfh		= mvpp2_ethtool_set_rxfh,
+	.create_rxfh_context	= mvpp2_create_rxfh_context,
+	.modify_rxfh_context	= mvpp2_modify_rxfh_context,
+	.remove_rxfh_context	= mvpp2_remove_rxfh_context,
 };
 
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
-- 
2.45.2


