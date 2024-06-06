Return-Path: <netdev+bounces-101375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF9A8FE526
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FAD1C214C1
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BFA1953AE;
	Thu,  6 Jun 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjzLFyo9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A31953A7
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672823; cv=none; b=YV35oEnm+XI3jVqmW0JTa8Yxvhh//Wtj5/7N7QwpkERnxzn11W8bXVJjcxrmLGG65vd8wRhw6LxNsEvrZmv54eNImib/jDj9YwWRwPoi2ANGZWR1PDjb6/iLZxVLnmC9a6k7WMXWZoRbtXrZ0VeZwhO8G4MKxnQA/8ZAocyIy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672823; c=relaxed/simple;
	bh=noe5R0IKUpVFoLpG/bHmiJXDXxZdt8eMHzpsAW4vHuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSzEJl3oB69CvQqrA51BOj0A5C8jNCPslqN++RZEvUMLNb/KZw4WkRX5JiFmyw2KEMFShoWgUHBrCYVZJ1xGAXtVw5dYyUsV7EmkVNz7VZMpiqMOgqyY3XcxpKwWpUyU6I/B3OqlQePOjTu4DNVz7FRe8Y0J+RtoeNWmY94BGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjzLFyo9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717672822; x=1749208822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=noe5R0IKUpVFoLpG/bHmiJXDXxZdt8eMHzpsAW4vHuY=;
  b=cjzLFyo92EWCsjzJ+FRfVhpydvB24c8Gw4CI1gxd+KM6rREclGwAspAf
   pnL8+Fl8Wy/t2gHvlvgkL5wM0/xoojTYIOTSTl+IRsu1dw+DEowblzkQq
   5I8QrP8oVQUTINYSl4x+atcRyFd7uav1mkIPoU3RlctF6krOfV3O6XarP
   NLBxIl0mdqAE9gbkaLsBoEQsMTan70kubhtpFsj73Wd21XdsslrKB8Y4f
   jADV12VU+6EE2EEPWtxQeBG+M8CPSun7pihJE5alaS4gNUdB1GLwhRN9h
   MyI5IaGIyQNncLoEy/cXu/LonMPPCANjwxum8sd3Wz+/YHg3dGUltYVKT
   g==;
X-CSE-ConnectionGUID: oqRa2/HiQh+vlJosRaefEg==
X-CSE-MsgGUID: GsUlQ2TaRieFVTPBBoC46g==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18123711"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18123711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:20:22 -0700
X-CSE-ConnectionGUID: mOwORfPDS/mnMfKWlhp14g==
X-CSE-MsgGUID: vD1VjGYfSfitU6nZ1dp7XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42864504"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 06 Jun 2024 04:20:19 -0700
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
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org
Subject: [iwl-next v5 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Thu,  6 Jun 2024 13:24:52 +0200
Message-ID: <20240606112503.1939759-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e76e19036593..ddc348371841 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6726,7 +6726,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7427,7 +7428,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


