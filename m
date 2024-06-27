Return-Path: <netdev+bounces-107292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A591A7B1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98292835A9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB1C19049F;
	Thu, 27 Jun 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCH5LiRT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233A192B96
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494329; cv=none; b=q7ZStzFlGtWe7HhiZmwSIPtiNRvagw9/CGA2Gf6GuJzbu6xfihPQHDZSIqlR0lQTAuFo0e9fsUSAbTBKhHA3x7THY6hcsZr8fR/p9/GWTTR3WkRkBQDYpb2UeC0wtB7PsTkFUr3ou+7JadRysZYJfcvxR1V2hT8eKvt4OSYqbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494329; c=relaxed/simple;
	bh=8yCl0bfYTFzW60BvVt8rpeFgDlLi21G9cooCu3w9MMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGWtl6zA8Pkj4pZ/hHlJCFlAokG1m9FsKcy4EnS0TpV+VHZZQBV0u8N6dL+V9l8K/zgpUyZXam4oLaDC8qFIWNIR7f3YTgp9+GoKQnLGsVI5BFA4MeG2rpFG0c+ORabNPKbEDNNKh4GMRCeABQDt07eZpqKesKeBO3U1FGWCe78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCH5LiRT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494328; x=1751030328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yCl0bfYTFzW60BvVt8rpeFgDlLi21G9cooCu3w9MMY=;
  b=dCH5LiRT0G656Fk7m8g6uSJbPkYGSid1HI5LTuGBp80OETlYZmH2arx6
   bGDQBGVY5Nsr0+70/OG2yT5PPb+YP3gT8NqlWvFGwOP61d1fCVvOf5qJi
   qhd/MfM7sfVvnrAaxjH9cffRYW0IoqoPAeeLQYYg3BAP/t6nnYzi0g9Qp
   MAJQ5nSVWPZkvC2ihvwQcqTbb3x81z5yWWbsGgAksNo0rwIm5zL8Cwgva
   39lYo4AcSJ97RsbuBLh6VD62P6Qj1bKV3/oepf7mINmux0KUTo4BWhhzn
   5FUylUtGmTtnpE/TzUrvoO6a2CqI2UG+vLhUIhirN3ssBLsTMWJWVtp62
   Q==;
X-CSE-ConnectionGUID: WCJXQku9TeOiwP9tYJHfAw==
X-CSE-MsgGUID: fawAItbkT1Wl7AZ72UwGVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452344"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452344"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:18:48 -0700
X-CSE-ConnectionGUID: 53Gc+ZlFRdWc5Ssy/D376A==
X-CSE-MsgGUID: uw1ULaf8T+GRW0Ye7X42ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315381"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:18:45 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v4 iwl-net 2/8] ice: don't busy wait for Rx queue disable in ice_qp_dis()
Date: Thu, 27 Jun 2024 15:17:51 +0200
Message-Id: <20240627131757.144991-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
References: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ice driver is spammed with multiple xdpsock instances and flow
control is enabled, there are cases when Rx queue gets stuck and unable
to reflect the disable state in QRX_CTRL register. Similar issue has
previously been addressed in commit 13a6233b033f ("ice: Add support to
enable/disable all Rx queues before waiting").

To workaround this, let us simply not wait for a disabled state as later
patch will make sure that regardless of the encountered error in the
process of disabling a queue pair, the Rx queue will be enabled.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 72738b8b8a68..3104a5657b83 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -199,10 +199,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-- 
2.34.1


