Return-Path: <netdev+bounces-235151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC5C2CA1F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97F3B34A813
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B031A7F7;
	Mon,  3 Nov 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qv3PPZf+"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251731A54E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182629; cv=none; b=kui916uEufDMxJmsyqrrZCdageeOABjhPGL/G+FZELYlrC3WB6ERDphwd6q3m3u3ukFNFmmBrKm3sCTlm9swgjKPwLIAytwU8DVK5KMUT2U/QnQ61PBac9asTMybM+NawwpfON4UOYpyP17bkClyO4ef0Vsxt7dgukjW7NvcsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182629; c=relaxed/simple;
	bh=DgpncGjpn0J1j+WbmYAYEjLLz563YIxtX/IvfbUHYUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6/W1zzKqFcUpgtYgfPqxnbOxJ2Nsb3dwgyHqem1iHHjhuxfxYlFmRWwjmJzhESwVe5ab0efLkqHaMkVD+dOE8LqZYAPBFVtoZ2fO/eT4j1eXZfk+Y0ZtP4tu8Qahg7tzCY0upuvFsq5qdfgisND7rpCmABKZJElbc1ZJT7BaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qv3PPZf+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9B+wJcC9hgti5SVgtCMBRDB3ojo71Fg4Ndlpeq6akg=;
	b=qv3PPZf+wkyHzVPgTYdgJP4CiZ4o2Bero1LkXwdFOOh65QEf0is1gZ+JEWJF1IzkA9tdr8
	+lEskTxS18Ok19J7a9yrMLUJCS63Vhc3tcVs1jT8snQ3ruap3PFntjKW2co+Rv7nnc9Nsb
	ji2hQlOOadxn8X2Iv3T4ZYdK2YveI+E=
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
Subject: [PATCH net-next v2 3/7] net: liquidio_vf: convert to use ndo_hwtstamp callbacks
Date: Mon,  3 Nov 2025 15:09:48 +0000
Message-ID: <20251103150952.3538205-4-vadim.fedorenko@linux.dev>
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

The driver implemented SIOCSHWTSTAMP ioctl command only, but there is a
way to get configuration back. Implement both ndo_hwtstamp_set and
ndo_hwtstamp_set callbacks.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 48 ++++++++-----------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 3230dff5ba05..e02942dbbcce 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -1236,20 +1236,13 @@ liquidio_get_stats64(struct net_device *netdev,
 		lstats->tx_carrier_errors;
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
 	struct lio *lio = GET_LIO(netdev);
-	struct hwtstamp_config conf;
-
-	if (copy_from_user(&conf, ifr->ifr_data, sizeof(conf)))
-		return -EFAULT;
 
-	switch (conf.tx_type) {
+	switch (conf->tx_type) {
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
 		break;
@@ -1257,7 +1250,7 @@ static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (conf.rx_filter) {
+	switch (conf->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 	case HWTSTAMP_FILTER_ALL:
@@ -1275,35 +1268,31 @@ static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr)
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
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return hwtstamp_ioctl(netdev, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
+	struct lio *lio = GET_LIO(netdev);
+
+	/* TX timestamping is techically always on */
+	conf->tx_type = HWTSTAMP_TX_ON;
+	conf->rx_filter = ifstate_check(lio, LIO_IFSTATE_RX_TIMESTAMP_ENABLED) ?
+			  HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+	return 0;
 }
 
 static void handle_timestamp(struct octeon_device *oct, u32 status, void *buf)
@@ -1881,9 +1870,10 @@ static const struct net_device_ops lionetdevops = {
 	.ndo_vlan_rx_add_vid    = liquidio_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = liquidio_vlan_rx_kill_vid,
 	.ndo_change_mtu		= liquidio_change_mtu,
-	.ndo_eth_ioctl		= liquidio_ioctl,
 	.ndo_fix_features	= liquidio_fix_features,
 	.ndo_set_features	= liquidio_set_features,
+	.ndo_hwtstamp_get	= liquidio_hwtstamp_get,
+	.ndo_hwtstamp_set	= liquidio_hwtstamp_set,
 };
 
 static int lio_nic_info(struct octeon_recv_info *recv_info, void *buf)
-- 
2.47.3


