Return-Path: <netdev+bounces-118210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B4950F52
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA06B23D2C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F941AC454;
	Tue, 13 Aug 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C35UaYPL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBF1AC432
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585826; cv=none; b=ludCT2OT2vocUvfYiKI2kGKJnzz5U8P36J8brdlEGvLhlzgzNrXQkSMBhM3XgF2oz3Qlf+LJdFXM2p4ituY/oGixWXTPjbeP+FVmQGaFpov3Rj7pj/rm14ZTJTRhpzRZ0Ws7ZoEoTUmO0AzNUKqxYZurhR+FwmoAZGKgjvpuRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585826; c=relaxed/simple;
	bh=Jt3qkvJhvFe2+s+JmEhpbQTGiN1aGNbjbRTKZ8iUGyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka7C99uCnQt8wViqoa0rH1oyZF0AJhNOqiJHLnXji3VdnMKETYByDvTPy7uAoreLuADJ261J0w8yMtN9K3n7+rmOAfWz4O6gCE90jabQcBKFecdCC7YdNPqaQVI6lHFrB2YqIHOMyUQmz22QhuRgfVTORTE3FcNxLI6fKrOeUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C35UaYPL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585825; x=1755121825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jt3qkvJhvFe2+s+JmEhpbQTGiN1aGNbjbRTKZ8iUGyk=;
  b=C35UaYPLl3o4abKYRfR4ABozOZPXbwdEuEB+RKsOjW5sCbuOOapC6jaX
   ocvruiJwUYUq9bbauewwvIX57NTQnhdpX9eIeU6B4c1kcgPis7/Tw31Hi
   L8pQ902Ggyx+A3/jMglEJ9PwDGEy4bprkXCtV+GHVfbRUciRzxYdl1Xit
   5AN27tl4tmVvSXUu8TLktp7beDTdsPrEKsWMXmyph2QDpRYzMLfrAvYvi
   3nBGMnPCyCGCc5Vzt9b7AAV0k9hx6vyJT7a2I0Jyu3m/ARrZBHsLyPRra
   mCuH7HsQFWmvDzaon9jJdNzwLeTnvb/u+QCx3hVob2vp9YhXZvBa1w0+P
   w==;
X-CSE-ConnectionGUID: i//hUhfoQ9WKVh68CgM4BQ==
X-CSE-MsgGUID: YsGnDsyERC6535mYkbYMww==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21748184"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21748184"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:50:08 -0700
X-CSE-ConnectionGUID: L7YzFYzESs6e+aonQ9cAyQ==
X-CSE-MsgGUID: Nnu4OoV7R86LwZriPz6v6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58685587"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2024 14:50:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
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
Subject: [PATCH net-next v4 11/15] ice: check if SF is ready in ethtool ops
Date: Tue, 13 Aug 2024 14:50:00 -0700
Message-ID: <20240813215005.3647350-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
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
index c7641d326ba5..0b2139ba23f3 100644
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


