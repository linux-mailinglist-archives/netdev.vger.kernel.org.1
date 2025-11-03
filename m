Return-Path: <netdev+bounces-235149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A709C2CB1A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7B4F84E2
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196A31A547;
	Mon,  3 Nov 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2v0JD5r"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F12319866
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182626; cv=none; b=mq6uuaOXJy6vWMRRYAaGNq2k3izuSuBen7rN1wWk1eVhtCF40j/k+aiKZcyxTS5U/17kc8hwTxwsuKrV8aKBqzE6NeTeTJLIsL+Bd5VJjpvHIMFZfw1IUjzLHoKqOKKnR5hcylyGfdwH5tL4wEUIPIJHyd2HpepDrwZEX7NpaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182626; c=relaxed/simple;
	bh=z8bMMD+iNuAZHQUSB2xTlyzNaZ5Ii8Lx3LfvpuixHGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdeZfBbzgtOBV4opeBaM3+3vpwlvWK/fNV6E5Rdz4lOgcgxvHGjoFn6QFME/vO3t4N7o5VhiGz0Hd1agvUomhQ88XL2t4sdJeH8pZpt+mfozB/PA7T/ONDRaU6uAvNgn0DLhyetUJxrzfSkIB3FRhWIez+Mh0YQzyx4+kanzSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2v0JD5r; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBCMZ4BUDDpL3sd2MB4BmbVH43KzHCgZiWv4IjZJMtM=;
	b=d2v0JD5rll2csmKUzFG84GFsBBcO0Turmr+J0Te4+Ljgni2YcDL57nmdJ1fJmx72Gmcq9i
	8uMzx5Tbqzc7K3lPEfDyP1astOP3REifW5/wPMEtX01VR0/jeLShWaYmVTGUfmtBaoB9Vq
	yUX/Vt+GMPu0RQbgmEfdK7aA+VAWBw8=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/7] bnx2x: convert to use ndo_hwtstamp callbacks
Date: Mon,  3 Nov 2025 15:09:46 +0000
Message-ID: <20251103150952.3538205-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
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

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 53 +++++++++++--------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index f0f05d7315ac..289b1f6b42d0 100644
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
@@ -15350,31 +15350,40 @@ int bnx2x_configure_ptp_filters(struct bnx2x *bp)
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
 
 	bp->hwtstamp_ioctl_called = true;
-	bp->tx_type = config.tx_type;
-	bp->rx_filter = config.rx_filter;
+	bp->tx_type = config->tx_type;
+	bp->rx_filter = config->rx_filter;
 
 	rc = bnx2x_configure_ptp_filters(bp);
 	if (rc)
 		return rc;
 
-	config.rx_filter = bp->rx_filter;
+	config->rx_filter = bp->rx_filter;
+
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


