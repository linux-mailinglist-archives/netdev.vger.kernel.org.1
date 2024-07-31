Return-Path: <netdev+bounces-114701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E339438A1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14505283E47
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA316D9B2;
	Wed, 31 Jul 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fz19nACV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CE16D4CE
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463850; cv=none; b=Qu7pPBqoJwQM1UukIudXUIV6H0AgLoOgRMbmugyJDANJ0UdsRRJpg3CQxL7LRQ0JKedVcAaL9mTQiaH/WVDq3cGFCnarFKr7JcsJlB1sgM9+Ai8xPnM+lVTD6/AomQuBFDuKvgZDWg0PxPvU+vElxJwf8AO7C4QvC4LGJvDzhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463850; c=relaxed/simple;
	bh=yQuPQvJS1fQs3zzuzRlxQdih2XQKm6jjjrde7c7EA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxZe7ZWzkhnJyRZa83vEhhCbPWosxlUQAZk9pl7JFm9SxctWWE8JK4mAiFiyxcFhiPXaJlmOfQaUke/mVd4ri9mR+uckjGM2B49bJ8cmvpZAVJfpG8Ki+0PFRiZbGgqycaGdsd07hGcwAhfscX0dWk1ZZhSSU88O6NCRE/mMcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fz19nACV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463849; x=1753999849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQuPQvJS1fQs3zzuzRlxQdih2XQKm6jjjrde7c7EA6E=;
  b=Fz19nACVhNDQ1F4Lk7i82nS+D5GrxR0GsrbTXthxIDOpl0dFYQoCko2E
   7EojvwvOLAGR1EUrvQwQdu5DeM1XvOtIBWxv/d+dCTOIza0DpL15+x/w0
   QQixhaVh22+bCuOMbGdn8DCrpPBu+8SAcKDwJyANSJSapJNoPN+7ebqVw
   Vj1KVi0HePgjey6tnUshYZmjhaDU97d0trEGHA9FpfLoakYyxONJhESxa
   XeKK35EMmhw10bY70mo2TEBdmElq8jl0vsJJRRffkYXewkcS1F0ux7TAq
   lzCpmsmCMoT1iUXpKDyiO/cvm5Tar2EY2520MqOFuBgf0jbYBTf48CKX/
   w==;
X-CSE-ConnectionGUID: UPAAhmvVTrqJy96AEkYYgw==
X-CSE-MsgGUID: n0I70vhbRBK+M+K0S66w6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765498"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:45 -0700
X-CSE-ConnectionGUID: 84L3d7zQQmGVKutCnIvdCA==
X-CSE-MsgGUID: WVmszEQdRreP/FAMiP4x4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734131"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:46 -0700
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
Subject: [PATCH net-next v2 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Wed, 31 Jul 2024 15:10:15 -0700
Message-ID: <20240731221028.965449-5-anthony.l.nguyen@intel.com>
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

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f0ffdaae33d2..a329c8a2002c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6728,7 +6728,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7426,7 +7427,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


