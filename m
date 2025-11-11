Return-Path: <netdev+bounces-237682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C1C4EC67
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BACE14E8A81
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED77364EA5;
	Tue, 11 Nov 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hBFbtfrM"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726A35F8A5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874360; cv=none; b=iwnBF65exuABLXz/+zA8VtENfi1IbC07gDDqk+oJ2NiX3NI682ZO4gC/GPmChHElvMA861LtKS9rEREw9RbIQCc40jpUSlwRlkZI67THRAKD/kAi1XEvSV3ZuFqQirOJWvLZuIqlh2HQcGCmBQBqx0q5tZZ9tWte/r/rDBaRWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874360; c=relaxed/simple;
	bh=S0B96wOLP5NEciL7Hq8y9JZ/2qZMwQYDeZVkipMeLOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSmcjrUwMW5ViPNLHNu1lwExLCjBdaOFH19vHCGiABxqn6dGSVgWrvFRy1JgaWaN2FgDGfVkFrODxd/0oOHc9TPZTXPuvI8fmuvuZ+9aS8insKXBNZzW/8EfRur4C+QfMayKrzZWyG/GVzfGhwDqaoN2z4OJ2Dat8GtteV9q0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hBFbtfrM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762874356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym5OzV3rYe2wTfzNWUcP2KPVhUB58Y9XqZmRKI0Td7I=;
	b=hBFbtfrMouxG1IVMQDBCk5qPxZTjjlAUcbXL4qLvdYo0ZpILTGWqXEiPA15IuzOJRCjL+Q
	q6O+dL/QjEqPUOxP1Y2XMn3IcuLi6FFVHg8jLLm6+gWC2q1heA2tC57ngKNtGUu7GIEh18
	PgwvlpzOSOgh6/qVJrbEcNpZNNU/cps=
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
Subject: [PATCH net-next v3 1/2] bnx2x: convert to use ndo_hwtstamp callbacks
Date: Tue, 11 Nov 2025 15:18:59 +0000
Message-ID: <20251111151900.1826871-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251111151900.1826871-1-vadim.fedorenko@linux.dev>
References: <20251111151900.1826871-1-vadim.fedorenko@linux.dev>
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
The driver has some logical problems with HW timestamping configuration.
The follow-up patchset will try to address at least 2 of them:
- not all TX timestamping options are provided, in case of any change it
  will make compilers issue a warning
- the driver doesn't actually disable TX timestamping
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 68 ++++++++++++-------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index f0f05d7315ac..7d433442a9fb 100644
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
@@ -15350,31 +15350,53 @@ int bnx2x_configure_ptp_filters(struct bnx2x *bp)
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
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		break;
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+	case HWTSTAMP_TX_ONESTEP_P2P:
+		NL_SET_ERR_MSG_MOD(extack,
+				   "One-step timestamping is not supported");
+		return -ERANGE;
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
+
+	return 0;
+}
+
+static int bnx2x_hwtstamp_get(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config)
+{
+	struct bnx2x *bp = netdev_priv(dev);
 
-	config.rx_filter = bp->rx_filter;
+	config->rx_filter = bp->rx_filter;
+	config->tx_type = bp->tx_type;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /* Configures HW for PTP */
-- 
2.47.3


