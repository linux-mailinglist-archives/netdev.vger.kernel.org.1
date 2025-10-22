Return-Path: <netdev+bounces-231608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD54BFB73C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C106507D2F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE5322DD4;
	Wed, 22 Oct 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CsRpDf4m"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB5328B58
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130181; cv=none; b=S25YhF1UOmd+o7ygZwwej2bwizfot0My1nbJpdN49oAyq3Mray1EBpJozg06CVylmWtFpqodTPjGsRGSQ/MvQVzjOpsTjcSGVj5IuEuDdZJbK7DgZ9TloOodF5YQepQgGmX1I4rlDkgpI6WfPqmhsycrRfINoCcXdCbJGNrmDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130181; c=relaxed/simple;
	bh=ypTWxlOqTB9y2xHlJA+Fn0VZD2AxI5FgPl52ENZrzfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3L7v2VwFGnV0zqmEtsH3jVnZWndjVzCFdTx4+y/mV7AvSSNBdFI+Ym9OR39LfO+iuqP5Ofgzk4V3tXn/vPN8J9nna/SQrMkgFgxlLLqfWd2kGMyApXkH2HRiAioRWvV+uvq3yETobRVHu/69fqO1BsHO+hzPJhlg6m0xvehWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CsRpDf4m; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761130175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck/8SNZqh0oQH2Fzg+9cBNXBot0tUrZxpF22/bSwLLg=;
	b=CsRpDf4mEuhpEMqVR9ZDsl7IZEi+qJ+g9XAa2o5GLlcLMh0K74CZPW7gBZ7bVtTxnjM7yV
	aocY+6XnZBNx5ooZn30YEkkpGftZHe+TJwDL9ZIQZfMxeXhHFxJ/+WEOmmNa337D8ctlvc
	ekFCpnAlOPHpW/HD+AUim81uML6J2JQ=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4 5/6] net: renesas: rswitch: convert to ndo_hwtstamp API
Date: Wed, 22 Oct 2025 10:48:59 +0000
Message-ID: <20251022104900.901973-6-vadim.fedorenko@linux.dev>
In-Reply-To: <20251022104900.901973-1-vadim.fedorenko@linux.dev>
References: <20251022104900.901973-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert driver to use .ndo_hwtstamp_set()/.ndo_hwtstamp_get() callbacks.
rswitch_eth_ioctl() becomes phy_do_ioctl_running(), remove it and
replace .ndo_eth_ioctl callback with phy_do_ioctl_running().

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 53 ++++++++-------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 8d8acc2124b8..f21a814aa9d1 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1793,46 +1793,44 @@ static struct net_device_stats *rswitch_get_stats(struct net_device *ndev)
 	return &ndev->stats;
 }
 
-static int rswitch_hwstamp_get(struct net_device *ndev, struct ifreq *req)
+static int rswitch_hwstamp_get(struct net_device *ndev,
+			       struct kernel_hwtstamp_config *config)
 {
 	struct rswitch_device *rdev = netdev_priv(ndev);
 	struct rcar_gen4_ptp_private *ptp_priv;
-	struct hwtstamp_config config;
 
 	ptp_priv = rdev->priv->ptp_priv;
 
-	config.flags = 0;
-	config.tx_type = ptp_priv->tstamp_tx_ctrl ? HWTSTAMP_TX_ON :
+	config->flags = 0;
+	config->tx_type = ptp_priv->tstamp_tx_ctrl ? HWTSTAMP_TX_ON :
 						    HWTSTAMP_TX_OFF;
 	switch (ptp_priv->tstamp_rx_ctrl & RCAR_GEN4_RXTSTAMP_TYPE) {
 	case RCAR_GEN4_RXTSTAMP_TYPE_V2_L2_EVENT:
-		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 		break;
 	case RCAR_GEN4_RXTSTAMP_TYPE_ALL:
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
-		config.rx_filter = HWTSTAMP_FILTER_NONE;
+		config->rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	}
 
-	return copy_to_user(req->ifr_data, &config, sizeof(config)) ? -EFAULT : 0;
+	return 0;
 }
 
-static int rswitch_hwstamp_set(struct net_device *ndev, struct ifreq *req)
+static int rswitch_hwstamp_set(struct net_device *ndev,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
 	struct rswitch_device *rdev = netdev_priv(ndev);
 	u32 tstamp_rx_ctrl = RCAR_GEN4_RXTSTAMP_ENABLED;
-	struct hwtstamp_config config;
 	u32 tstamp_tx_ctrl;
 
-	if (copy_from_user(&config, req->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	if (config.flags)
+	if (config->flags)
 		return -EINVAL;
 
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		tstamp_tx_ctrl = 0;
 		break;
@@ -1843,7 +1841,7 @@ static int rswitch_hwstamp_set(struct net_device *ndev, struct ifreq *req)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		tstamp_rx_ctrl = 0;
 		break;
@@ -1851,7 +1849,7 @@ static int rswitch_hwstamp_set(struct net_device *ndev, struct ifreq *req)
 		tstamp_rx_ctrl |= RCAR_GEN4_RXTSTAMP_TYPE_V2_L2_EVENT;
 		break;
 	default:
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		tstamp_rx_ctrl |= RCAR_GEN4_RXTSTAMP_TYPE_ALL;
 		break;
 	}
@@ -1859,22 +1857,7 @@ static int rswitch_hwstamp_set(struct net_device *ndev, struct ifreq *req)
 	rdev->priv->ptp_priv->tstamp_tx_ctrl = tstamp_tx_ctrl;
 	rdev->priv->ptp_priv->tstamp_rx_ctrl = tstamp_rx_ctrl;
 
-	return copy_to_user(req->ifr_data, &config, sizeof(config)) ? -EFAULT : 0;
-}
-
-static int rswitch_eth_ioctl(struct net_device *ndev, struct ifreq *req, int cmd)
-{
-	if (!netif_running(ndev))
-		return -EINVAL;
-
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		return rswitch_hwstamp_get(ndev, req);
-	case SIOCSHWTSTAMP:
-		return rswitch_hwstamp_set(ndev, req);
-	default:
-		return phy_mii_ioctl(ndev->phydev, req, cmd);
-	}
+	return 0;
 }
 
 static int rswitch_get_port_parent_id(struct net_device *ndev,
@@ -1905,11 +1888,13 @@ static const struct net_device_ops rswitch_netdev_ops = {
 	.ndo_stop = rswitch_stop,
 	.ndo_start_xmit = rswitch_start_xmit,
 	.ndo_get_stats = rswitch_get_stats,
-	.ndo_eth_ioctl = rswitch_eth_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl_running,
 	.ndo_get_port_parent_id = rswitch_get_port_parent_id,
 	.ndo_get_phys_port_name = rswitch_get_phys_port_name,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_hwtstamp_get = rswitch_hwstamp_get,
+	.ndo_hwtstamp_set = rswitch_hwstamp_set,
 };
 
 bool is_rdev(const struct net_device *ndev)
-- 
2.47.3


