Return-Path: <netdev+bounces-101578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA6D8FF7D0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1F41F2764A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6913E8AF;
	Thu,  6 Jun 2024 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKKgyEW+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184013E042;
	Thu,  6 Jun 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714037; cv=none; b=Jv9jXh2o3h/574jy1uYZN0/FtBU/C0EPwrnQDWlj+Lc47LfrNAjISPw99ufybXIMRCqHS4WGDowtIyyJhRkrw2nweWNH9uWNgAokCmefgoI9ic7PoorlN/BpdNmDkrVooeGumyGuQdpwizzV/cbXlt8+4h8kBjtehPgYPYgd7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714037; c=relaxed/simple;
	bh=WJPwdnA8Lj4NLq97gnr8zSK5cfQQDsGNC1zvghOKkgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7ksP0fD9CoH2pmuBvLVmbI3bxNwnSYIK9GAE9rDJwys2X+9TdSUAgLbymhWq4g6Jr8tL+Gxlz9Iv05zzi5G5zcoMsOCt3rk4qj2KAce4z9pGsb8/PW0yqOMk0241U/tivuWCLk40FgUMVx7BxoS2D1xDQ83FpBBLtlRek1SMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKKgyEW+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717714036; x=1749250036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJPwdnA8Lj4NLq97gnr8zSK5cfQQDsGNC1zvghOKkgw=;
  b=iKKgyEW+Xx7LuOIQF5UnkZ785z6YzKljyAxhW/pvdwEPQw5Dqk1dGF45
   ywrrkUshA3WsArelQVdp03/KER/wvUDVNQPZif7X9slGwRSeDy0u7ihnu
   aWkR2/JGnZYag0Ar/o1tk52Ru8ukAKj5tndomSwXF8fUNnWf/M3LYMa2M
   ouJAMqndeEoB0Y+bQpfiIGr15zOD3os5KXEo8rzg5vaJs08QWJ0roM8br
   cxtgI3wieU0mNlIYUh+ZSJzq5DghiULCJ5uuI1+EPYazUMFzX+lx+37u/
   TVV0h6Gh4T/+zs2K8viXIVAXoLoHAAavzblg9Rm4b+LMvaXG9cnWrou7L
   A==;
X-CSE-ConnectionGUID: CIOvW2YoRYqApOA42wjghg==
X-CSE-MsgGUID: JncA2QNGQ2yJyZoHGovu3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14224014"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14224014"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:12 -0700
X-CSE-ConnectionGUID: Ruw+N1/qSvi/splh/Vr6bg==
X-CSE-MsgGUID: +aZnIgdAR6CkgvddpW3EBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38243843"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:12 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: [PATCH iwl-next v2 4/5] ice: implement transmit hardware timestamp statistics
Date: Thu,  6 Jun 2024 15:46:58 -0700
Message-ID: <20240606224701.359706-5-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606224701.359706-1-jesse.brandeburg@intel.com>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel now has common statistics for transmit timestamps, so
implement them in the ice driver.

use via
ethtool -I -T eth0

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---

$ sudo ethtool -I -T eth0
Time stamping parameters for eth0:
Capabilities:
        hardware-transmit
        software-transmit
        hardware-receive
        software-receive
        software-system-clock
        hardware-raw-clock
PTP Hardware Clock: 0
Hardware Transmit Timestamp Modes:
        off
        on
Hardware Receive Filter Modes:
        none
        all
Statistics:
  tx_pkts: 17
  tx_lost: 0
  tx_err: 0
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 6f0a857f55c9..97a7a0632a1d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4357,6 +4357,23 @@ static void ice_get_rmon_stats(struct net_device *netdev,
 	*ranges = ice_rmon_ranges;
 }
 
+/* ice_get_ts_stats - provide timestamping stats
+ * @netdev: the netdevice pointer from ethtool
+ * @ts_stats: the ethtool data structure to fill in
+ */
+static void ice_get_ts_stats(struct net_device *netdev,
+			     struct ethtool_ts_stats *ts_stats)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_ptp *ptp = &pf->ptp;
+
+	ts_stats->pkts = ptp->tx_hwtstamp_good;
+	ts_stats->err = ptp->tx_hwtstamp_skipped +
+			ptp->tx_hwtstamp_flushed +
+			ptp->tx_hwtstamp_discarded;
+	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4407,6 +4424,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_eth_mac_stats	= ice_get_eth_mac_stats,
 	.get_pause_stats	= ice_get_pause_stats,
 	.get_rmon_stats		= ice_get_rmon_stats,
+	.get_ts_stats		= ice_get_ts_stats,
 };
 
 static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
-- 
2.43.0


