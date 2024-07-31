Return-Path: <netdev+bounces-114709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276B9438A8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE6D1F22700
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772EE16DED4;
	Wed, 31 Jul 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0bacMzI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232416DC36
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463856; cv=none; b=VDvRHoozihaXxijJ8KhQ4YAtS/hi2h61KZQzNTLjHAl1YM1rqWznS16LjsDjXUas6IbCFMOQbwo7NQ7VUYI3juw+m2CLWXXkYZaZzOu2wtFagHr4azi9NboFfPeUILcmtH2wWfzON09+aEAfN/rlgb0PLuePqE/69Tj6T8pRfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463856; c=relaxed/simple;
	bh=4cHWpRwI67+xaBLFRwywBoUN/MEIegWx/OqaJ9usGhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYoZ4OhtLE55mvrTQSfFOZCKDbOEygSiho+GRDErUqe6iexOy8gvJFfaoPyQHpcKhtWMo2zwmJXfbNdoAPO84RlyQghS5tQcNziRct0i05+S7eQpFzWxl7HqS64qB15yPLVb2SgJ4pz73JewLGcqj7YuHHbxg6kAwKFNcF4GHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0bacMzI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463855; x=1753999855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4cHWpRwI67+xaBLFRwywBoUN/MEIegWx/OqaJ9usGhs=;
  b=k0bacMzI/rgm1dc9McNEkeHA4D4W3K6MjOqkgspJGdTPAXrdd6yMel00
   XGCK56e0p5oU48PjT0UnP6572XE5rXE065fDgmp/m4BrIa38LZ9Hn3xOU
   hq2a2lw8Tq8QXnW96nPdbGnjqeFM0Q6ShjorXOgx5SYC/vePo9w+08tit
   tT2cTSfQ6ZJMX1mD1aacJ2iUtUqz3sG8thOtevx6651Hi5uEub9bs8b4w
   c+tPrEKIauqbWY/RDrezBQDqNCAxk+zBXG4n+VL+CYMEUf10fHECyBdQo
   nqke6i81iEFot6jnJYJE0MZHRSxo6PP4jMmh3smf0Gs4++mCEx/cRx1uO
   g==;
X-CSE-ConnectionGUID: UFdIJDnsQCCMLJwy9c5qMQ==
X-CSE-MsgGUID: Q6mboLjASIyF908N+oSWUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765566"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765566"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:47 -0700
X-CSE-ConnectionGUID: 65TCDN8dTeSWkSFG+XLkgQ==
X-CSE-MsgGUID: AyBaMWDoTTen2NrrAP55Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734172"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 12/15] ice: implement netdevice ops for SF representor
Date: Wed, 31 Jul 2024 15:10:23 -0700
Message-ID: <20240731221028.965449-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Subfunction port representor needs the basic netdevice ops to work
correctly. Create them.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 57 +++++++++++++++++------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 229831fe2cd2..78abfdf5d47b 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -59,12 +59,13 @@ static void
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
@@ -93,7 +94,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
 }
 
 /**
- * ice_repr_open - Enable port representor's network interface
+ * ice_repr_vf_open - Enable port representor's network interface
  * @netdev: network interface device structure
  *
  * The open entry point is called when a port representor's network
@@ -102,7 +103,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
  *
  * Returns 0 on success
  */
-static int ice_repr_open(struct net_device *netdev)
+static int ice_repr_vf_open(struct net_device *netdev)
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 	struct ice_vf *vf;
@@ -118,8 +119,16 @@ static int ice_repr_open(struct net_device *netdev)
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
@@ -128,7 +137,7 @@ static int ice_repr_open(struct net_device *netdev)
  *
  * Returns 0 on success
  */
-static int ice_repr_stop(struct net_device *netdev)
+static int ice_repr_vf_stop(struct net_device *netdev)
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 	struct ice_vf *vf;
@@ -144,6 +153,14 @@ static int ice_repr_stop(struct net_device *netdev)
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
@@ -245,10 +262,20 @@ ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	}
 }
 
-static const struct net_device_ops ice_repr_netdev_ops = {
+static const struct net_device_ops ice_repr_vf_netdev_ops = {
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
 	.ndo_get_stats64 = ice_repr_get_stats64,
-	.ndo_open = ice_repr_open,
-	.ndo_stop = ice_repr_stop,
+	.ndo_open = ice_repr_sf_open,
+	.ndo_stop = ice_repr_sf_stop,
 	.ndo_start_xmit = ice_eswitch_port_start_xmit,
 	.ndo_setup_tc = ice_repr_setup_tc,
 	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
@@ -261,18 +288,20 @@ static const struct net_device_ops ice_repr_netdev_ops = {
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
@@ -386,7 +415,7 @@ static int ice_repr_add_vf(struct ice_repr *repr)
 		return err;
 
 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &vf->devlink_port);
-	err = ice_repr_reg_netdev(repr->netdev);
+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_vf_netdev_ops);
 	if (err)
 		goto err_netdev;
 
@@ -447,7 +476,7 @@ static int ice_repr_add_sf(struct ice_repr *repr)
 		return err;
 
 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
-	err = ice_repr_reg_netdev(repr->netdev);
+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_sf_netdev_ops);
 	if (err)
 		goto err_netdev;
 
-- 
2.42.0


