Return-Path: <netdev+bounces-230604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067FBEBC98
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88092623A20
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2129E0FD;
	Fri, 17 Oct 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="a1pO2M+o"
X-Original-To: netdev@vger.kernel.org
Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0028A3F2
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735525; cv=none; b=deYZdBgbLKNiiLZJSm2k2zKaDvnLRRGf1yCOH/BTn8JKw0wL99b+MXCwPlAJCJ/wChRpMDXJbXo3uCTI7n4SBTf8KnxJT2aXSGU94Tln+EBkJb92U1TVckUfqob4VwaYMaQBCy2HrRM+z/SV0hyZAX2PF3kU3L95FINmM+fdun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735525; c=relaxed/simple;
	bh=wW5PC0xy0cenxyhska0wJ5leNHmYG7gngZBqdK6vEBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tgVcWoF4S7UsnpXnvimRrAUt0Xdw8zDYeASTEXD4C+9NIj/47sMYYyAZ9VE5/UyWkrYAtfwspoCvx84/Hg6OtKawyNawTiqRGyY34nWwWZvViVIaEFsiXHUJeiDj6rxFnAEtLCvX9n/w6Kxt0QWeZV+RZAvqDB5goSiJvjQE6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=a1pO2M+o; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DklIhhoFH/OC+KhQGJQ11qpWiALop1Y7huJXZ0oQr9k=; b=a1pO2M+o24DMx/fHtOdcBbLBYu
	33mE/GGY0cAFF5TSikDTCtx++CfpYp/7XEAFoxCY1FlNUdpL1AX6ib0OYtEDMQqjQAYzp1rpuffI+
	U3Av/Q219+GahFsNl4Vknys56sbe99le0y0b7w/8Wr2+SvgFKWBjBemjlP0Jr/bq+vI4=;
Received: from [93.82.65.102] (helo=hornet.engleder.at)
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v9rB2-0000000077j-3vwi;
	Fri, 17 Oct 2025 22:35:53 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next] tsnep: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Fri, 17 Oct 2025 22:34:30 +0200
Message-Id: <20251017203430.64321-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Vladimir Oltean <vladimir.oltean@nxp.com>

I took over this patch from Vladimir Oltean. The only change from my
side is the adaption of the commit message. I hope I mentioned his work
correctly in the tags.

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the tsnep driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl()
path completely.

The driver does not need the interface to be down in order for
timestamping to be changed. Thus, the netif_running() restriction in
tsnep_netdev_ioctl() is not migrated to the new API. There is no
interaction with hardware registers for either operation, just a
concurrency with the data path which is fine.

After removing the PHY timestamping logic from tsnep_netdev_ioctl(),
the rest is almost equivalent to phy_do_ioctl_running(), except for the
return code on the !netif_running() condition: -EINVAL vs -ENODEV.
Let's make the conversion to phy_do_ioctl_running() anyway, on the
premise that a return code standardized tree-wide is less complex.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep.h      |  8 +-
 drivers/net/ethernet/engleder/tsnep_main.c | 14 +---
 drivers/net/ethernet/engleder/tsnep_ptp.c  | 90 +++++++++++-----------
 3 files changed, 53 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
index f188fba021a6..452ab982afbe 100644
--- a/drivers/net/ethernet/engleder/tsnep.h
+++ b/drivers/net/ethernet/engleder/tsnep.h
@@ -176,7 +176,7 @@ struct tsnep_adapter {
 	struct tsnep_gcl gcl[2];
 	int next_gcl;
 
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	/* ptp clock lock */
@@ -203,7 +203,11 @@ extern const struct ethtool_ops tsnep_ethtool_ops;
 
 int tsnep_ptp_init(struct tsnep_adapter *adapter);
 void tsnep_ptp_cleanup(struct tsnep_adapter *adapter);
-int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
+int tsnep_hwtstamp_get(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config);
+int tsnep_hwtstamp_set(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
 
 int tsnep_tc_init(struct tsnep_adapter *adapter);
 void tsnep_tc_cleanup(struct tsnep_adapter *adapter);
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index eba73246f986..c12ad990a2b6 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2168,16 +2168,6 @@ static netdev_tx_t tsnep_netdev_xmit_frame(struct sk_buff *skb,
 	return tsnep_xmit_frame_ring(skb, &adapter->tx[queue_mapping]);
 }
 
-static int tsnep_netdev_ioctl(struct net_device *netdev, struct ifreq *ifr,
-			      int cmd)
-{
-	if (!netif_running(netdev))
-		return -EINVAL;
-	if (cmd == SIOCSHWTSTAMP || cmd == SIOCGHWTSTAMP)
-		return tsnep_ptp_ioctl(netdev, ifr, cmd);
-	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
-}
-
 static void tsnep_netdev_set_multicast(struct net_device *netdev)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
@@ -2384,7 +2374,7 @@ static const struct net_device_ops tsnep_netdev_ops = {
 	.ndo_open = tsnep_netdev_open,
 	.ndo_stop = tsnep_netdev_close,
 	.ndo_start_xmit = tsnep_netdev_xmit_frame,
-	.ndo_eth_ioctl = tsnep_netdev_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl_running,
 	.ndo_set_rx_mode = tsnep_netdev_set_multicast,
 	.ndo_get_stats64 = tsnep_netdev_get_stats64,
 	.ndo_set_mac_address = tsnep_netdev_set_mac_address,
@@ -2394,6 +2384,8 @@ static const struct net_device_ops tsnep_netdev_ops = {
 	.ndo_bpf = tsnep_netdev_bpf,
 	.ndo_xdp_xmit = tsnep_netdev_xdp_xmit,
 	.ndo_xsk_wakeup = tsnep_netdev_xsk_wakeup,
+	.ndo_hwtstamp_get = tsnep_hwtstamp_get,
+	.ndo_hwtstamp_set = tsnep_hwtstamp_set,
 };
 
 static int tsnep_mac_init(struct tsnep_adapter *adapter)
diff --git a/drivers/net/ethernet/engleder/tsnep_ptp.c b/drivers/net/ethernet/engleder/tsnep_ptp.c
index 54fbf0126815..f2d001f58017 100644
--- a/drivers/net/ethernet/engleder/tsnep_ptp.c
+++ b/drivers/net/ethernet/engleder/tsnep_ptp.c
@@ -19,56 +19,54 @@ void tsnep_get_system_time(struct tsnep_adapter *adapter, u64 *time)
 	*time = (((u64)high) << 32) | ((u64)low);
 }
 
-int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+int tsnep_hwtstamp_get(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config config;
-
-	if (!ifr)
-		return -EINVAL;
-
-	if (cmd == SIOCSHWTSTAMP) {
-		if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-			return -EFAULT;
-
-		switch (config.tx_type) {
-		case HWTSTAMP_TX_OFF:
-		case HWTSTAMP_TX_ON:
-			break;
-		default:
-			return -ERANGE;
-		}
-
-		switch (config.rx_filter) {
-		case HWTSTAMP_FILTER_NONE:
-			break;
-		case HWTSTAMP_FILTER_ALL:
-		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
-		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
-		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
-		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
-		case HWTSTAMP_FILTER_PTP_V2_EVENT:
-		case HWTSTAMP_FILTER_PTP_V2_SYNC:
-		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		case HWTSTAMP_FILTER_NTP_ALL:
-			config.rx_filter = HWTSTAMP_FILTER_ALL;
-			break;
-		default:
-			return -ERANGE;
-		}
-
-		memcpy(&adapter->hwtstamp_config, &config,
-		       sizeof(adapter->hwtstamp_config));
+
+	*config = adapter->hwtstamp_config;
+
+	return 0;
+}
+
+int tsnep_hwtstamp_set(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
+{
+	struct tsnep_adapter *adapter = netdev_priv(netdev);
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
 	}
 
-	if (copy_to_user(ifr->ifr_data, &adapter->hwtstamp_config,
-			 sizeof(adapter->hwtstamp_config)))
-		return -EFAULT;
+	adapter->hwtstamp_config = *config;
 
 	return 0;
 }
-- 
2.39.5


