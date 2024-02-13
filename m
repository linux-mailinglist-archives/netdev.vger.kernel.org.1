Return-Path: <netdev+bounces-71207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DFB8529CD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B1FB215DC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD71775F;
	Tue, 13 Feb 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBLQScZq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F61946F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809022; cv=none; b=Ao1T959EqkdgAFh9pdNlr5fxjrgITeTJISrm39MGM7rBOtrBb4xlGFO8y8meUf+q+HIcGyOQFFEIi9sqHBj+aqoco7ouD/ryPG1q1+XVt8NLCtqHZaRcod/acW2G+OWbRlfsagBzGHcbYEEYccaX2ymlqZOdJ1nFsC1jVw5K4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809022; c=relaxed/simple;
	bh=2hLUxP1834Vl8fx9RVqq/1AoUwKtwNJO0XHMhBgEsYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7avo4uYdj2DbzKpKCTSMHYUojKJ2YHk5wsqwxgFUA+GVpIN4/b90aKtKPF1WuE/SK8I1SixxwWXXElJmdYZfc/4c4xI0tXH0L1PM0Cenm9ArdMyJIpLiABBO/2GfAP0Li7ou4IkZv/LyaapaduF+RyugpHmiKeouwqw7oGnDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBLQScZq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809021; x=1739345021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hLUxP1834Vl8fx9RVqq/1AoUwKtwNJO0XHMhBgEsYg=;
  b=OBLQScZqxx5g3sv7eozgb0a78pI0/GbfsMy/2RccKm7+CPUt4PpMnQSN
   4K+tWAxuEFvvc8BdWLgmJW10VrO+JlaChV+Deka7vEcJbh8BoAueml/J5
   y/BVWMlD4qYdIoX+vx96imubTSszvd7/geyuqv84FJeM7+6z6NSvLo+1f
   vqbE/WJyWsENEIXkauI/3VvZXBrsrCZhtTsTRhJH9cGNSLSyraccLE8Yt
   qLbJLlpvgC4bybN1e4nYk6jza0nNaIoWflxM12wi/ekFfCS1tzXWtrqiq
   CsTPM38uBmWkAy18lI6je1fS2AiBP8SCqWhxA1EBUO/Mfn/H264QyhDOK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27248005"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27248005"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385451"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:38 -0800
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 12/15] ice: netdevice ops for SF representor
Date: Tue, 13 Feb 2024 08:27:21 +0100
Message-ID: <20240213072724.77275-13-michal.swiatkowski@linux.intel.com>
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

Subfunction port representor needs the basic netdevice ops to work
correctly. Create them.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 63 +++++++++++++++++------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index f0ae7a9000b4..125bcf2e4c00 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -32,7 +32,10 @@ ice_repr_get_phys_port_name(struct net_device *netdev, char *buf, size_t len)
 	int res;
 
 	/* Devlink port is registered and devlink core is taking care of name formatting. */
-	if (repr->vf->devlink_port.devlink)
+	if ((repr->type == ICE_REPR_TYPE_VF &&
+	     repr->vf->devlink_port.devlink) ||
+	    (repr->type == ICE_REPR_TYPE_SF &&
+	     repr->sf->devlink_port.devlink))
 		return -EOPNOTSUPP;
 
 	res = snprintf(buf, len, "pf%dvfr%d", ice_repr_get_sw_port_id(repr),
@@ -92,12 +95,13 @@ static void
 ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_repr *repr = np->repr;
 	struct ice_eth_stats *eth_stats;
 	struct ice_vsi *vsi;
 
-	if (ice_is_vf_disabled(np->repr->vf))
+	if (repr->ops.ready(repr))
 		return;
-	vsi = np->repr->src_vsi;
+	vsi = repr->src_vsi;
 
 	ice_update_vsi_stats(vsi);
 	eth_stats = &vsi->eth_stats;
@@ -126,7 +130,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
 }
 
 /**
- * ice_repr_open - Enable port representor's network interface
+ * ice_repr_vf_open - Enable port representor's network interface
  * @netdev: network interface device structure
  *
  * The open entry point is called when a port representor's network
@@ -135,7 +139,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
  *
  * Returns 0 on success
  */
-static int ice_repr_open(struct net_device *netdev)
+static int ice_repr_vf_open(struct net_device *netdev)
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 	struct ice_vf *vf;
@@ -151,8 +155,16 @@ static int ice_repr_open(struct net_device *netdev)
 	return 0;
 }
 
+static int ice_repr_sf_open(struct net_device *netdev)
+{
+	netif_carrier_on(netdev);
+	netif_tx_start_all_queues(netdev);
+
+	return 0;
+}
+
 /**
- * ice_repr_stop - Disable port representor's network interface
+ * ice_repr_vf_stop - Disable port representor's network interface
  * @netdev: network interface device structure
  *
  * The stop entry point is called when a port representor's network
@@ -161,7 +173,7 @@ static int ice_repr_open(struct net_device *netdev)
  *
  * Returns 0 on success
  */
-static int ice_repr_stop(struct net_device *netdev)
+static int ice_repr_vf_stop(struct net_device *netdev)
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 	struct ice_vf *vf;
@@ -177,6 +189,14 @@ static int ice_repr_stop(struct net_device *netdev)
 	return 0;
 }
 
+static int ice_repr_sf_stop(struct net_device *netdev)
+{
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+
+	return 0;
+}
+
 /**
  * ice_repr_sp_stats64 - get slow path stats for port representor
  * @dev: network interface device structure
@@ -278,11 +298,22 @@ ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	}
 }
 
-static const struct net_device_ops ice_repr_netdev_ops = {
+static const struct net_device_ops ice_repr_vf_netdev_ops = {
+	.ndo_get_phys_port_name = ice_repr_get_phys_port_name,
+	.ndo_get_stats64 = ice_repr_get_stats64,
+	.ndo_open = ice_repr_vf_open,
+	.ndo_stop = ice_repr_vf_stop,
+	.ndo_start_xmit = ice_eswitch_port_start_xmit,
+	.ndo_setup_tc = ice_repr_setup_tc,
+	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
+	.ndo_get_offload_stats = ice_repr_ndo_get_offload_stats,
+};
+
+static const struct net_device_ops ice_repr_sf_netdev_ops = {
 	.ndo_get_phys_port_name = ice_repr_get_phys_port_name,
 	.ndo_get_stats64 = ice_repr_get_stats64,
-	.ndo_open = ice_repr_open,
-	.ndo_stop = ice_repr_stop,
+	.ndo_open = ice_repr_sf_open,
+	.ndo_stop = ice_repr_sf_stop,
 	.ndo_start_xmit = ice_eswitch_port_start_xmit,
 	.ndo_setup_tc = ice_repr_setup_tc,
 	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
@@ -295,18 +326,20 @@ static const struct net_device_ops ice_repr_netdev_ops = {
  */
 bool ice_is_port_repr_netdev(const struct net_device *netdev)
 {
-	return netdev && (netdev->netdev_ops == &ice_repr_netdev_ops);
+	return netdev && (netdev->netdev_ops == &ice_repr_vf_netdev_ops ||
+			  netdev->netdev_ops == &ice_repr_sf_netdev_ops);
 }
 
 /**
  * ice_repr_reg_netdev - register port representor netdev
  * @netdev: pointer to port representor netdev
+ * @ops: new ops for netdev
  */
 static int
-ice_repr_reg_netdev(struct net_device *netdev)
+ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
 {
 	eth_hw_addr_random(netdev);
-	netdev->netdev_ops = &ice_repr_netdev_ops;
+	netdev->netdev_ops = ops;
 	ice_set_ethtool_repr_ops(netdev);
 
 	netdev->hw_features |= NETIF_F_HW_TC;
@@ -418,7 +451,7 @@ static int ice_repr_add_vf(struct ice_repr *repr)
 		return err;
 
 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &vf->devlink_port);
-	err = ice_repr_reg_netdev(repr->netdev);
+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_vf_netdev_ops);
 	if (err)
 		goto err_netdev;
 
@@ -460,7 +493,7 @@ static int ice_repr_add_sf(struct ice_repr *repr)
 	struct ice_dynamic_port *sf = repr->sf;
 
 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
-	return ice_repr_reg_netdev(repr->netdev);
+	return ice_repr_reg_netdev(repr->netdev, &ice_repr_sf_netdev_ops);
 }
 
 struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf)
-- 
2.42.0


