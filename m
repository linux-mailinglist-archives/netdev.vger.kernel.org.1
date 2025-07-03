Return-Path: <netdev+bounces-203895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93194AF7F47
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B1E4E0D53
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CAC2F271B;
	Thu,  3 Jul 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l90zSMYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E882F2365
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564573; cv=none; b=WOSdAgE5FIUksKXbPsw4+o8XKsQmwZgpSg6S1nj6fK0mRXkd0xjr0BweMkUZz8tULtG8d1OeOhqY6F2YEv/7uriM/Yb5/pF8QbKDH3Jtd8b5kjcsKqN1+4tvCzX3RjzF4IdtC00yvBvm/wHU/XAKMZRsicPBIIE0HW7SOcakONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564573; c=relaxed/simple;
	bh=H5A/0kxSP2qktbFGr9VdOyDLH8QuajdQdwxhJydDRWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WT3g6TUL+i7fJ+bbftMQlSIxUEOMoWAiBzyrQBLsbY4AKTBKT0KoRYPym16lTSvPtBaA6D4M3ZMx2ni0WJiWXqNqq+81OnT9fZj2g6Zu+Weehs4f4/IY670IhGwrTIV9/h5jKzshcxfYtwaGQnz5E978wJ+leeVSXIZG+sHwD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l90zSMYZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564572; x=1783100572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5A/0kxSP2qktbFGr9VdOyDLH8QuajdQdwxhJydDRWE=;
  b=l90zSMYZWdfes/SLwkx4u52395nWnsoqTnQgluiMAd57qsby+YVGDVZ/
   XzINncP6GABfxcFYUwaNfK2DQUoGVTXEm+oTQ7oIyDoOVU4CGy0jmZSqZ
   Kw7tuUTPcZWDM6X8dMDoG3wR+Ijd4NvefCpUZlLfx7K7LE0bk+p720Yx2
   g6GXS3lZkzRbq7zEDPbRfbcQpZ/QL3T32NR8iNFqnz2h9Yp0ogGj87F3t
   rkHx/Ueshiahz/FWkr4udivkH8qVPoD+MPfbAOLqpzNQDqojNXL6FPZKY
   37kG157Qnmw9spGF1tGqOMiKu8Cz3XHtQBTwopZ2n1Uj6cxfmIIfW1ZfW
   Q==;
X-CSE-ConnectionGUID: CJpc5OgHSz2JsMeVfxInNQ==
X-CSE-MsgGUID: /ikvZyNMTymUnYoOX0S7Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767928"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767928"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:49 -0700
X-CSE-ConnectionGUID: 3YMRbZAMQguMWTG5SYlLpg==
X-CSE-MsgGUID: mKNv0WyCQcy75zx/KJm3KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997896"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 05/12] i40e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  3 Jul 2025 10:42:32 -0700
Message-ID: <20250703174242.3829277-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the Intel i40e driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl() path
completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  9 +++--
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +-----------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 43 +++++++++++----------
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 54d5fdc303ca..eea845b22089 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -661,7 +661,7 @@ struct i40e_pf {
 	struct ptp_clock_info ptp_caps;
 	struct sk_buff *ptp_tx_skb;
 	unsigned long ptp_tx_start;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct timespec64 ptp_prev_hw_time;
 	struct work_struct ptp_extts0_work;
 	ktime_t ptp_reset_start;
@@ -1303,8 +1303,11 @@ void i40e_ptp_tx_hang(struct i40e_pf *pf);
 void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf);
 void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index);
 void i40e_ptp_set_increment(struct i40e_pf *pf);
-int i40e_ptp_set_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
-int i40e_ptp_get_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
+int i40e_ptp_hwtstamp_get(struct net_device *netdev,
+			  struct kernel_hwtstamp_config *config);
+int i40e_ptp_hwtstamp_set(struct net_device *netdev,
+			  struct kernel_hwtstamp_config *config,
+			  struct netlink_ext_ack *extack);
 void i40e_ptp_save_hw_time(struct i40e_pf *pf);
 void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3b4f59d978a5..949b74fbb127 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2954,27 +2954,6 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-/**
- * i40e_ioctl - Access the hwtstamp interface
- * @netdev: network interface device structure
- * @ifr: interface request data
- * @cmd: ioctl command
- **/
-int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	struct i40e_netdev_priv *np = netdev_priv(netdev);
-	struct i40e_pf *pf = np->vsi->back;
-
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		return i40e_ptp_get_ts_config(pf, ifr);
-	case SIOCSHWTSTAMP:
-		return i40e_ptp_set_ts_config(pf, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 /**
  * i40e_vlan_stripping_enable - Turn on vlan stripping for the VSI
  * @vsi: the vsi being adjusted
@@ -13626,7 +13605,6 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= i40e_set_mac,
 	.ndo_change_mtu		= i40e_change_mtu,
-	.ndo_eth_ioctl		= i40e_ioctl,
 	.ndo_tx_timeout		= i40e_tx_timeout,
 	.ndo_vlan_rx_add_vid	= i40e_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= i40e_vlan_rx_kill_vid,
@@ -13654,6 +13632,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_xsk_wakeup	        = i40e_xsk_wakeup,
 	.ndo_dfwd_add_station	= i40e_fwd_add,
 	.ndo_dfwd_del_station	= i40e_fwd_del,
+	.ndo_hwtstamp_get	= i40e_ptp_hwtstamp_get,
+	.ndo_hwtstamp_set	= i40e_ptp_hwtstamp_set,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index b72a4b5d76b9..1d04ea7df552 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -912,23 +912,26 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
 }
 
 /**
- * i40e_ptp_get_ts_config - ioctl interface to read the HW timestamping
- * @pf: Board private structure
- * @ifr: ioctl data
+ * i40e_ptp_hwtstamp_get - interface to read the HW timestamping
+ * @netdev: Network device structure
+ * @config: Timestamping configuration structure
  *
  * Obtain the current hardware timestamping settigs as requested. To do this,
  * keep a shadow copy of the timestamp settings rather than attempting to
  * deconstruct it from the registers.
  **/
-int i40e_ptp_get_ts_config(struct i40e_pf *pf, struct ifreq *ifr)
+int i40e_ptp_hwtstamp_get(struct net_device *netdev,
+			  struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config *config = &pf->tstamp_config;
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
 
 	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	*config = pf->tstamp_config;
+
+	return 0;
 }
 
 /**
@@ -1167,7 +1170,7 @@ int i40e_ptp_alloc_pins(struct i40e_pf *pf)
  * more broad if the specific filter is not directly supported.
  **/
 static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
-				       struct hwtstamp_config *config)
+				       struct kernel_hwtstamp_config *config)
 {
 	struct i40e_hw *hw = &pf->hw;
 	u32 tsyntype, regval;
@@ -1290,9 +1293,10 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 }
 
 /**
- * i40e_ptp_set_ts_config - ioctl interface to control the HW timestamping
- * @pf: Board private structure
- * @ifr: ioctl data
+ * i40e_ptp_hwtstamp_set - interface to control the HW timestamping
+ * @netdev: Network device structure
+ * @config: Timestamping configuration structure
+ * @extack: Netlink extended ack structure for error reporting
  *
  * Respond to the user filter requests and make the appropriate hardware
  * changes here. The XL710 cannot support splitting of the Tx/Rx timestamping
@@ -1303,26 +1307,25 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
  * as the user receives the timestamps they care about and the user is notified
  * the filter has been broadened.
  **/
-int i40e_ptp_set_ts_config(struct i40e_pf *pf, struct ifreq *ifr)
+int i40e_ptp_hwtstamp_set(struct net_device *netdev,
+			  struct kernel_hwtstamp_config *config,
+			  struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
 	int err;
 
 	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = i40e_ptp_set_timestamp_mode(pf, &config);
+	err = i40e_ptp_set_timestamp_mode(pf, config);
 	if (err)
 		return err;
 
 	/* save these settings for future reference */
-	pf->tstamp_config = config;
+	pf->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
-- 
2.47.1


