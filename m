Return-Path: <netdev+bounces-113844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0994011C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746741C21EE5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFE18FDB0;
	Mon, 29 Jul 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0yaG1SJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0318FC85
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292489; cv=none; b=KeWqt3HeAMOmIpi7dGhfplSnrUrPWC4XjttOcLwDmoZcw+Ru/VKrevwpDAmy/CUh8UGCt2aRxVb10QgkRI/olWjBVs+QIthysxTpMABb65uugwzlWfOx9fnXezIPOKcvyOY8wGGQ2UYoPgG54NQ7lTCGHtJvgXJ3lbz6VSJHbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292489; c=relaxed/simple;
	bh=g9mCwqh+CJ5G5wbBwv+GXtGW0PUDRYtDFrb7K8hqWqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFvN2XcekdTepngEjy2o5Ool9uM5BLgnbzrzuJonInQf8ha9bkbxDjFBCs9NJiJ9ccX6BAzT0bze51O0sdc9YV2BatJosOGKA1v6MutXKVL69Pfi8xX6/0Imzs6c4RqUg51XIUlGpSb176lKFnnqxdyg5t5fiW0POOcluo/nMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0yaG1SJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722292487; x=1753828487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9mCwqh+CJ5G5wbBwv+GXtGW0PUDRYtDFrb7K8hqWqY=;
  b=J0yaG1SJs1/mAW8zDZ5Ru2LRPKSU6eW4DA0x+9l5WnXjoxdv0WWi8TrV
   Ug6WsDvD73K6oTPgXpScfy1iKW7/TBSPOH+glECmWR2SAKuIb/65J0TxW
   UefWmekCDWBJY7Ow90BL/kvrJVpMhZXZgODahZIUxTe7qKgLtx+Byk+6q
   199umyz+54h1VuyalhkIlf1CQjc9AzenG5ryEbOKI/SuK7WojW/IsjOob
   wjys+09DHBa5PHDgGyz6npDhf/OO3SB3Sz6tL0nVcSW8spcFpSrpL6O5f
   9eqR8GOm64GMMyUbBQ0zz15rHcg/DfDRMU9G2KFs3IxXkr2fsx/y2vs0A
   Q==;
X-CSE-ConnectionGUID: oEp9pFFkTJmltjJewsC80A==
X-CSE-MsgGUID: Cz3AzWXNQdWjrQS9CXZHvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20216838"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20216838"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:34:42 -0700
X-CSE-ConnectionGUID: o3jmOaazR0yAuEHc/aasAg==
X-CSE-MsgGUID: fZTncTJXTya0GhAYIR/I8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="77344589"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 15:34:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 11/15] ice: check if SF is ready in ethtool ops
Date: Mon, 29 Jul 2024 15:34:26 -0700
Message-ID: <20240729223431.681842-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
References: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Now there is another type of port representor. Correct checking if
parent device is ready to reflect also new PR type.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  7 +++----
 drivers/net/ethernet/intel/ice/ice_repr.c    | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_repr.h    |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8c990c976132..7b1f7725c0c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4414,7 +4414,7 @@ ice_repr_get_drvinfo(struct net_device *netdev,
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
-	if (ice_check_vf_ready_for_cfg(repr->vf))
+	if (repr->ops.ready(repr))
 		return;
 
 	__ice_get_drvinfo(netdev, drvinfo, repr->src_vsi);
@@ -4426,8 +4426,7 @@ ice_repr_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
 	/* for port representors only ETH_SS_STATS is supported */
-	if (ice_check_vf_ready_for_cfg(repr->vf) ||
-	    stringset != ETH_SS_STATS)
+	if (repr->ops.ready(repr) || stringset != ETH_SS_STATS)
 		return;
 
 	__ice_get_strings(netdev, stringset, data, repr->src_vsi);
@@ -4440,7 +4439,7 @@ ice_repr_get_ethtool_stats(struct net_device *netdev,
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
-	if (ice_check_vf_ready_for_cfg(repr->vf))
+	if (repr->ops.ready(repr))
 		return;
 
 	__ice_get_ethtool_stats(netdev, stats, data, repr->src_vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5ea8b512c421..229831fe2cd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -283,6 +283,16 @@ ice_repr_reg_netdev(struct net_device *netdev)
 	return register_netdev(netdev);
 }
 
+static int ice_repr_ready_vf(struct ice_repr *repr)
+{
+	return !ice_check_vf_ready_for_cfg(repr->vf);
+}
+
+static int ice_repr_ready_sf(struct ice_repr *repr)
+{
+	return !repr->sf->active;
+}
+
 /**
  * ice_repr_destroy - remove representor from VF
  * @repr: pointer to representor structure
@@ -420,6 +430,7 @@ struct ice_repr *ice_repr_create_vf(struct ice_vf *vf)
 	repr->vf = vf;
 	repr->ops.add = ice_repr_add_vf;
 	repr->ops.rem = ice_repr_rem_vf;
+	repr->ops.ready = ice_repr_ready_vf;
 
 	ether_addr_copy(repr->parent_mac, vf->hw_lan_addr);
 
@@ -466,6 +477,7 @@ struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf)
 	repr->sf = sf;
 	repr->ops.add = ice_repr_add_sf;
 	repr->ops.rem = ice_repr_rem_sf;
+	repr->ops.ready = ice_repr_ready_sf;
 
 	ether_addr_copy(repr->parent_mac, sf->hw_addr);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index ee28632e87b4..35bd93165e1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -36,6 +36,7 @@ struct ice_repr {
 	struct {
 		int (*add)(struct ice_repr *repr);
 		void (*rem)(struct ice_repr *repr);
+		int (*ready)(struct ice_repr *repr);
 	} ops;
 };
 
-- 
2.42.0


