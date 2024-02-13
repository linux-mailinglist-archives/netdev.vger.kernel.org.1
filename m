Return-Path: <netdev+bounces-71200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78C8529C2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D3A1F23140
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5851B17562;
	Tue, 13 Feb 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eik8cLwl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9B17564
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809004; cv=none; b=jIH97kq+gyWTYxhWbuZp6vJNNxOO7MP5pZIW69gVWstiZTJyY/naLLMoDeCTSemEsZGE2VnKSj8oTyBxq713DlM1ygIS3tTh1DGIMLaK9G2kO6fi/ta3qMKvLIdj1T/uigow833yLK2XNiRCe/nvKrqxBXDKPd14309kErGx+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809004; c=relaxed/simple;
	bh=YwDvVWo6NXGGCpC/D2g1HCCbq25A5oMOA/dNZaDlsqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4Mogm6skqX5F6F3gHdaeqlRCcHLb3fsMZqzbKW467pGNz4fX+8UjdbOUg2XqaCKjOsW07UhC7dpF+zKqtELRMStXdxToXvpeoBJTZdLJNea0DsL2+E97Lwz8CgHdlG6pg5rYOYv3xr3sSjzpBpiP1DBAm44bA3qQW84XGrg+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eik8cLwl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809003; x=1739345003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwDvVWo6NXGGCpC/D2g1HCCbq25A5oMOA/dNZaDlsqE=;
  b=Eik8cLwlZWbsN9M76D1EYUaSHbw/GnPgUvCdigTKp+54RlYvaDlGi1xc
   rTEYHlvbabLeLlTIEfAy/4xxvtlMhzIz7qrldQFlC3jn952KbwN5Vik+G
   R2H89E37JdyR79dBh34h0EXJ+dAJw3piBRDz9qMkKhA7LdkkM6eRpOeFC
   3HSrJPGSOGoQkefxOtabk4tr/s3L+CauKw4Y43Ag3cLwqbG857lO9y2/F
   AznQiHJGiFLcGuI4TcblFHXaLUn0VcY2d1I1Eomqrl/jIvsR3Z5h1mfRn
   Cos5Cj8xBOcTMWA5vwy8bnIyCqBvhKoyz/X3EYJxIbAw7cF7HpC/Vh5RJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27247952"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27247952"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385253"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:20 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 05/15] ice: add subfunctions ethtool ops
Date: Tue, 13 Feb 2024 08:27:14 +0100
Message-ID: <20240213072724.77275-6-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

Add only limited number of ethtools ops. Also, stats set for a
subfunction is different than a regular netdev since there are
not port stats, show only related VSI statistics.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 36 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3cc364a4d682..c862b21bad9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1564,6 +1564,22 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 	return ret;
 }
 
+/**
+ * ice_get_sf_sset_count - get number of stats to display for specified netdev
+ * of subfunction flavor
+ * @netdev: network interface device structure
+ * @sset: set of statistics to display
+ */
+static int ice_get_sf_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ICE_VSI_STATS_LEN + ice_q_stats_len(netdev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ice_get_sset_count(struct net_device *netdev, int sset)
 {
 	switch (sset) {
@@ -4290,6 +4306,17 @@ static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
 	.get_channels		= ice_get_channels,
 };
 
+static const struct ethtool_ops ice_sf_ethtool_ops = {
+	.get_drvinfo		= ice_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_strings		= ice_get_strings,
+	.get_ethtool_stats	= ice_get_ethtool_stats,
+	.get_sset_count		= ice_get_sf_sset_count,
+	.get_ringparam		= ice_get_ringparam,
+	.set_ringparam		= ice_set_ringparam,
+	.get_channels		= ice_get_channels,
+};
+
 /**
  * ice_set_ethtool_safe_mode_ops - setup safe mode ethtool ops
  * @netdev: network interface device structure
@@ -4326,3 +4353,12 @@ void ice_set_ethtool_ops(struct net_device *netdev)
 {
 	netdev->ethtool_ops = &ice_ethtool_ops;
 }
+
+/**
+ * ice_set_ethtool_sf_ops - setup subfunction ethtool ops
+ * @netdev: network interface device structure
+ */
+void ice_set_ethtool_sf_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &ice_sf_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index f569f176f29f..f45ac76f0f43 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -55,6 +55,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
+	ice_set_ethtool_sf_ops(netdev);
 	SET_NETDEV_DEVLINK_PORT(netdev, &dyn_port->devlink_port);
 
 	err = register_netdev(netdev);
-- 
2.42.0


