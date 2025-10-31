Return-Path: <netdev+bounces-234534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD7C22D00
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BABD64E99AD
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F320298D;
	Fri, 31 Oct 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KyMF7YxZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75719539F
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871590; cv=none; b=U4WE9fwMqB+68LbnDYJ18woKcg/o65CGY6dHTHUl+ENAnPoDtOtxuHFqHFAUdhte/+krBIezFCrbnl9rzNm94KnwxLKpFTqHZsqCVOCvrQPD4DJ34EAr5zjcgMj86A3uL92ID6jYhwaQI+VJpap7HA2kX7iVzqYpRFwnMOn7hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871590; c=relaxed/simple;
	bh=VEnPKC4LXq/RMVa6zc+VuL7n2+jQ2YkZNZ+DrMBjwmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0f7Sn1DhVtGgFU2AoPCLa8si0DVYbg7kFPoOSH8oCSJq9M6WkrEoh2VuB3iEaotE3PSAA8XJhjJ3fo0ul3Y2c2/UytcQDmb28aO+DN77D8mHeznqNCWoTR6gYmeP4P2hNJss2oqNE6N/NFpKFV3R0Pqk6ILIg/PMqYkz55UvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KyMF7YxZ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761871586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJR9kboh+kN0SGBIC5dzc5FlgzqZ1XfKmrijQ/8YkFg=;
	b=KyMF7YxZizwXGZivtEKoRNbIEKIotIcgfNBn3v+ki8Rb67/dIJWwcLFU46zB6HeIAJjw7e
	Sr+jn+pJMv8IlQByAx//bQqt/v7BW0EE9iIhqEIQXNlCpUMMyj42/YfDk+v48G4XiVq9T2
	WOmcCGuQYghADbiLvso01BfydcIcMFk=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
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
Subject: [PATCH net-next 2/7] net: liquidio: convert to use ndo_hwtstamp callbacks
Date: Fri, 31 Oct 2025 00:46:02 +0000
Message-ID: <20251031004607.1983544-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver implemented SIOCSHWTSTAMP ioctl command only, but there is a
way to get configured status. Implement both ndo_hwtstamp_set and
ndo_hwtstamp_get callbacks.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 50 ++++++++-----------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 8e2fcec26ea1..0732440eeacd 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2107,20 +2107,16 @@ liquidio_get_stats64(struct net_device *netdev,
 		lstats->tx_fifo_errors;
 }
 
-/**
- * hwtstamp_ioctl - Handler for SIOCSHWTSTAMP ioctl
- * @netdev: network device
- * @ifr: interface request
- */
-static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr)
+static int liquidio_hwtstamp_set(struct net_device *netdev,
+				 struct kernel_hwtstamp_config *conf,
+				 struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config conf;
 	struct lio *lio = GET_LIO(netdev);
 
-	if (copy_from_user(&conf, ifr->ifr_data, sizeof(conf)))
-		return -EFAULT;
+	if (!lio->oct_dev->ptp_enable)
+		return -EOPNOTSUPP;
 
-	switch (conf.tx_type) {
+	switch (conf->tx_type) {
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
 		break;
@@ -2128,7 +2124,7 @@ static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (conf.rx_filter) {
+	switch (conf->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 	case HWTSTAMP_FILTER_ALL:
@@ -2146,39 +2142,32 @@ static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
-		conf.rx_filter = HWTSTAMP_FILTER_ALL;
+		conf->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	if (conf.rx_filter == HWTSTAMP_FILTER_ALL)
+	if (conf->rx_filter == HWTSTAMP_FILTER_ALL)
 		ifstate_set(lio, LIO_IFSTATE_RX_TIMESTAMP_ENABLED);
 
 	else
 		ifstate_reset(lio, LIO_IFSTATE_RX_TIMESTAMP_ENABLED);
 
-	return copy_to_user(ifr->ifr_data, &conf, sizeof(conf)) ? -EFAULT : 0;
+	return 0;
 }
 
-/**
- * liquidio_ioctl - ioctl handler
- * @netdev: network device
- * @ifr: interface request
- * @cmd: command
- */
-static int liquidio_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+static int liquidio_hwtstamp_get(struct net_device *netdev,
+				 struct kernel_hwtstamp_config *conf)
 {
 	struct lio *lio = GET_LIO(netdev);
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		if (lio->oct_dev->ptp_enable)
-			return hwtstamp_ioctl(netdev, ifr);
-		fallthrough;
-	default:
-		return -EOPNOTSUPP;
-	}
+	/* TX timestamping is technically always on */
+	conf->tx_type = HWTSTAMP_TX_ON;
+	conf->rx_filter = ifstate_check(lio, LIO_IFSTATE_RX_TIMESTAMP_ENABLED) ?
+			  HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+
+	return 0;
 }
 
 /**
@@ -3227,7 +3216,6 @@ static const struct net_device_ops lionetdevops = {
 	.ndo_vlan_rx_add_vid    = liquidio_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = liquidio_vlan_rx_kill_vid,
 	.ndo_change_mtu		= liquidio_change_mtu,
-	.ndo_eth_ioctl		= liquidio_ioctl,
 	.ndo_fix_features	= liquidio_fix_features,
 	.ndo_set_features	= liquidio_set_features,
 	.ndo_set_vf_mac		= liquidio_set_vf_mac,
@@ -3238,6 +3226,8 @@ static const struct net_device_ops lionetdevops = {
 	.ndo_set_vf_link_state  = liquidio_set_vf_link_state,
 	.ndo_get_vf_stats	= liquidio_get_vf_stats,
 	.ndo_get_port_parent_id	= liquidio_get_port_parent_id,
+	.ndo_hwtstamp_get	= liquidio_hwtstamp_get,
+	.ndo_hwtstamp_set	= liquidio_hwtstamp_set,
 };
 
 /**
-- 
2.47.3


