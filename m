Return-Path: <netdev+bounces-236517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF9C3D847
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 22:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270D5188E294
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597F305078;
	Thu,  6 Nov 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TcTyIM5n"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D91302760
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465062; cv=none; b=ZHorwYhLEPlF0G1VRBO7F4h+Q6X1e5ck3osh0z1F2UYtWYkE/1TOpDyqI7I+vv/TwofH9F09xnSzqBXYSZ2fgeJil1oSbBmlJMiqc++sRJVNmVcTwj73DY63cZInBdYKe8d4ichzdXYQT5oBLQXamcfwmOjhLIGJO8Z8OE04XCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465062; c=relaxed/simple;
	bh=YX19L2tS4d0X1ULGHfNYM59IANhicIG5342Gwf3Tk1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNp2xk/O50ExpjXRSATjPj/0YJt312wfnzRzLcLZlQaxsJudhIy0ZdbCIQvJ8nXnwxKkLVM+JAWHy9PP2NvlzlctY7H3nxc7ryZo7lXacjFdDFyCj6or/VovCJk5kPaiIEPPKwAofVpvxqlyrk1akFXS2qXNmG4t5SIPwSUtLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TcTyIM5n; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762465056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNigygw3EZ8VVzkMsbNNBs9qoN2sr2CCi39O5jEg2Kk=;
	b=TcTyIM5nIKMhhqvMjjR8IOhO7aoR0YyIWqZ1BRvQy87+3DMYxRAagt64tku39BdujhelaE
	sML5C/MZlPidV6GLuyP/wkGyR/wcGM1chyjtmZIbQiblTCi0DljgGWTaxCLKU1UTfsSoWO
	tHNj4nWJacNtBQDb3IIVSD+FQCbLleU=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/2] bnx2x: convert to use ndo_hwtstamp callbacks
Date: Thu,  6 Nov 2025 21:37:16 +0000
Message-ID: <20251106213717.3543174-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
References: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver implemented SIOCSHWTSTAMP ioctl command only, but at the same
time it has configuration stored in a private structure. Implement both
ndo_hwtstamp_set and ndo_hwtstamp_get callback using stored info.
ndo_hwtstamp_set callback implements a check for unsupported 1-step
timestamping. The same check is removed from bnx2x_configure_ptp_filters
function as it's not needed anymore. Another call site of
bnx2x_configure_ptp_filters has hwtstamp_ioctl_called guard.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 73 ++++++++++++-------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index f0f05d7315ac..94dba7db4b6a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -308,8 +308,11 @@ static int bnx2x_set_storm_rx_mode(struct bnx2x *bp);
 /****************************************************************************
 * General service functions
 ****************************************************************************/
-
-static int bnx2x_hwtstamp_ioctl(struct bnx2x *bp, struct ifreq *ifr);
+static int bnx2x_hwtstamp_set(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack);
+static int bnx2x_hwtstamp_get(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config);
 
 static void __storm_memset_dma_mapping(struct bnx2x *bp,
 				       u32 addr, dma_addr_t mapping)
@@ -12813,14 +12816,9 @@ static int bnx2x_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	if (!netif_running(dev))
 		return -EAGAIN;
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return bnx2x_hwtstamp_ioctl(bp, ifr);
-	default:
-		DP(NETIF_MSG_LINK, "ioctl: phy id 0x%x, reg 0x%x, val_in 0x%x\n",
-		   mdio->phy_id, mdio->reg_num, mdio->val_in);
-		return mdio_mii_ioctl(&bp->mdio, mdio, cmd);
-	}
+	DP(NETIF_MSG_LINK, "ioctl: phy id 0x%x, reg 0x%x, val_in 0x%x\n",
+	   mdio->phy_id, mdio->reg_num, mdio->val_in);
+	return mdio_mii_ioctl(&bp->mdio, mdio, cmd);
 }
 
 static int bnx2x_validate_addr(struct net_device *dev)
@@ -13036,6 +13034,8 @@ static const struct net_device_ops bnx2x_netdev_ops = {
 	.ndo_get_phys_port_id	= bnx2x_get_phys_port_id,
 	.ndo_set_vf_link_state	= bnx2x_set_vf_link_state,
 	.ndo_features_check	= bnx2x_features_check,
+	.ndo_hwtstamp_get	= bnx2x_hwtstamp_get,
+	.ndo_hwtstamp_set	= bnx2x_hwtstamp_set,
 };
 
 static int bnx2x_init_dev(struct bnx2x *bp, struct pci_dev *pdev,
@@ -15285,10 +15285,8 @@ int bnx2x_configure_ptp_filters(struct bnx2x *bp)
 		REG_WR(bp, param, BNX2X_PTP_TX_ON_PARAM_MASK);
 		REG_WR(bp, rule, BNX2X_PTP_TX_ON_RULE_MASK);
 		break;
-	case HWTSTAMP_TX_ONESTEP_SYNC:
-	case HWTSTAMP_TX_ONESTEP_P2P:
-		BNX2X_ERR("One-step timestamping is not supported\n");
-		return -ERANGE;
+	default:
+		break;
 	}
 
 	param = port ? NIG_REG_P1_LLH_PTP_PARAM_MASK :
@@ -15350,31 +15348,52 @@ int bnx2x_configure_ptp_filters(struct bnx2x *bp)
 	return 0;
 }
 
-static int bnx2x_hwtstamp_ioctl(struct bnx2x *bp, struct ifreq *ifr)
+static int bnx2x_hwtstamp_set(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct bnx2x *bp = netdev_priv(dev);
 	int rc;
 
-	DP(BNX2X_MSG_PTP, "HWTSTAMP IOCTL called\n");
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
+	DP(BNX2X_MSG_PTP, "HWTSTAMP SET called\n");
 
 	DP(BNX2X_MSG_PTP, "Requested tx_type: %d, requested rx_filters = %d\n",
-	   config.tx_type, config.rx_filter);
+	   config->tx_type, config->rx_filter);
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+	case HWTSTAMP_TX_ONESTEP_P2P:
+		NL_SET_ERR_MSG_MOD(extack,
+				   "One-step timestamping is not supported");
+		return -ERANGE;
+	default:
+		break;
+	}
 
 	bp->hwtstamp_ioctl_called = true;
-	bp->tx_type = config.tx_type;
-	bp->rx_filter = config.rx_filter;
+	bp->tx_type = config->tx_type;
+	bp->rx_filter = config->rx_filter;
 
 	rc = bnx2x_configure_ptp_filters(bp);
-	if (rc)
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "HW configuration failure");
 		return rc;
+	}
+
+	config->rx_filter = bp->rx_filter;
 
-	config.rx_filter = bp->rx_filter;
+	return 0;
+}
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+static int bnx2x_hwtstamp_get(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config)
+{
+	struct bnx2x *bp = netdev_priv(dev);
+
+	config->rx_filter = bp->rx_filter;
+	config->tx_type = bp->tx_type;
+
+	return 0;
 }
 
 /* Configures HW for PTP */
-- 
2.47.3


