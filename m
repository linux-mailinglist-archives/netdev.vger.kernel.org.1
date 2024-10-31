Return-Path: <netdev+bounces-140620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5269B7440
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B0D1C21C05
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA1142E76;
	Thu, 31 Oct 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmeBjtUe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3A13E41A
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354417; cv=none; b=uauJ5CZr3bdC56Ogi1jqpUDJPx9lbozD8czW5VIj34njZvSeKdJbCzX8OPDz5W9Ui/1O0+HdgYyp2Whi9M+me3kgqhJM/FeG/ZXWjK/PgUMh5+kAvbyPkDVD3MJo+4ESGDBvjpVGgJty7CadItT4mRLOSNkJeaT6c3U7WZCckxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354417; c=relaxed/simple;
	bh=ah4ER9uuaDuiKqExVX2njPkUq8+DKNu+ToTM9QJUQk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxtp4Tc8/YsD3b9O9oviGtDpKyYhAs49hg94InyoTZkUOM4+E3GvmDhGWACNpYY30m9tx4lWwcUj/697eeE23PT3m8756JuDhhWLM0tnc4ssJqB5f0rVLR0v/aawY40yTht85fZ9Y2C5p2pPxwOItxfjU3qUrnaLOUttuGeQZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmeBjtUe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730354416; x=1761890416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ah4ER9uuaDuiKqExVX2njPkUq8+DKNu+ToTM9QJUQk8=;
  b=BmeBjtUetTnaK2SyAf1HLZkVhYnuTur/f3g2XYIeEMtzhB7YUVPq/PdI
   DEh9mbQViwqL0RPBDqbnaIEyCwmaf043ZreuaKBGSiT8fmWAw86b/lAMM
   3eVfyempVkZuS2XnFmPDypwVprJEPIkHgAKrxG93IH2InWlXbUpCROc89
   wr6PfWNSUYUTcg9c1aP6MT5nOYdB1Xxyb7y2w9l2jCqBkKlKkxb3BA6tp
   djcZQaxwxGstSmZky1GXDsUEFhom97VgAo6tPvbyUMBbecUSMY88XHQej
   /CzPevJgkCCezGjchZsiBEFfJOy5VIuPtguSLDYFYm05vTtOSiumK40RM
   A==;
X-CSE-ConnectionGUID: 7IlXKBgTT2ST/87oWlAhnA==
X-CSE-MsgGUID: 044kEkBDTT+0qyWH6g7sqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30272915"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30272915"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 23:00:14 -0700
X-CSE-ConnectionGUID: 7wwz33LMQzS7GO/vxF3PRw==
X-CSE-MsgGUID: HZDAcR/nS+SbesStu1tJag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82183636"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 23:00:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sridhar.samudrala@intel.com
Subject: [iwl-next v1 2/3] ice: ethtool support for SF
Date: Thu, 31 Oct 2024 07:00:08 +0100
Message-ID: <20241031060009.38979-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
References: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial support for subfunction device. Mostly it is sharing the same
ethtool ops as the PF, however, define new ops structure to support
only needed part of ethtool ops.

Define new function for getting stats length as subfunction VSI have
less stats available than PF one.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 28 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b552439fc1f9..9e2f20ed55d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -47,6 +47,7 @@ static int ice_q_stats_len(struct net_device *netdev)
 		 / sizeof(u64))
 #define ICE_ALL_STATS_LEN(n)	(ICE_PF_STATS_LEN + ICE_PFC_STATS_LEN + \
 				 ICE_VSI_STATS_LEN + ice_q_stats_len(n))
+#define ICE_SF_STATS_LEN(n)	(ICE_VSI_STATS_LEN + ice_q_stats_len(n))
 
 static const struct ice_stats ice_gstrings_vsi_stats[] = {
 	ICE_VSI_STAT("rx_unicast", eth_stats.rx_unicast),
@@ -4431,6 +4432,16 @@ static int ice_repr_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
+static int ice_sf_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ICE_SF_STATS_LEN(netdev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 #define ICE_I2C_EEPROM_DEV_ADDR		0xA0
 #define ICE_I2C_EEPROM_DEV_ADDR2	0xA2
 #define ICE_MODULE_TYPE_SFP		0x03
@@ -4870,6 +4881,23 @@ void ice_set_ethtool_repr_ops(struct net_device *netdev)
 	netdev->ethtool_ops = &ice_ethtool_repr_ops;
 }
 
+static const struct ethtool_ops ice_ethtool_sf_ops = {
+	.get_drvinfo		= ice_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_channels		= ice_get_channels,
+	.set_channels		= ice_set_channels,
+	.get_ringparam		= ice_get_ringparam,
+	.set_ringparam		= ice_set_ringparam,
+	.get_strings		= ice_get_strings,
+	.get_ethtool_stats	= ice_get_ethtool_stats,
+	.get_sset_count		= ice_sf_get_sset_count,
+};
+
+void ice_set_ethtool_sf_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &ice_ethtool_sf_ops;
+}
+
 /**
  * ice_set_ethtool_ops - setup netdev ethtool ops
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..d63492c25949 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -58,6 +58,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
+	ice_set_ethtool_sf_ops(netdev);
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
-- 
2.42.0


