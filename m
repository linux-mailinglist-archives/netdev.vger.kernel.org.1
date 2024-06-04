Return-Path: <netdev+bounces-100771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6218FBE9C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927E3B24425
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321F14D2A8;
	Tue,  4 Jun 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ejdxuo5e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61514C5B8;
	Tue,  4 Jun 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539219; cv=none; b=mXzpF7golB70QhpQgdF+xXrTsKGPfI0smcC0DLmu9kZ0s++vj3MpEZF/9l4d8DQDwwxtDquJLBkquNPa9bJaE/Ey2jqOAz6bkLc7h1f/aaSs4Sp7tiGSF8Fct/SVk0ZJ2HNHxP4+lEkKxCoabtpiFKOwj4yyMkyDFKAb/0GLvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539219; c=relaxed/simple;
	bh=rL5kinlQFFzU1XTq/6TzJBFgGwuFIH/m9QaI0R7Q2QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfA16lYcbP2yhUGLafTDxT+/Lt2MHI+bzzVSYLIO+9KRB+LS5D+cOSBW58tZ0OcgDlOr3LQEoguxVvK3wzwDES6KzThd+K+wGGzLv5eN6U+qzJ8hVv/P8rAXrPXJ6N6zoiWkh3saWrdTKmEo7p/HeRzuoR5nLWCG3c1kMp/8mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ejdxuo5e; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717539218; x=1749075218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rL5kinlQFFzU1XTq/6TzJBFgGwuFIH/m9QaI0R7Q2QI=;
  b=Ejdxuo5eDHOsK6YYFYmiBjDZU1m6CzIdFqkECBwAdjZJocQeT5BM8dBI
   zCtXjETbSddIjwojBLjXHwzyd6zTiNMXwHbO+QVLYXe9HTwrT9eYvxjdM
   Iz1PgPFwSOVU4NRf3r/H0aTNLNwWc8+6VukOyF0Xn43/8n50A7Q5EEao1
   4vlR260fM+PZxGqu2kgX2i495dX3JGX62COKuE1EJVyZJgjYibI3VdeJm
   4tqveFgeC+rEDQZwzCF7VwDxA4eTpEtlWXpCFoy+5lRH4mYp1CS9zBzIn
   tFarXdiaPH96UKNs8Lf+6tltIVk/k+vccn30EH82/s2PkvnbJqKzGmOuL
   A==;
X-CSE-ConnectionGUID: s0KhUZgJRWWxmv65yA+shg==
X-CSE-MsgGUID: XtTirt37RNSy5e9zKemxug==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36635265"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="36635265"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:33 -0700
X-CSE-ConnectionGUID: 8ueFfticQIuvX4QYVHfsiw==
X-CSE-MsgGUID: WKaPZkS4T1OFBSWIH2Cx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37503245"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:33 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v1 4/5] ice: implement transmit hardware timestamp statistics
Date: Tue,  4 Jun 2024 15:13:24 -0700
Message-ID: <20240604221327.299184-5-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604221327.299184-1-jesse.brandeburg@intel.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
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


