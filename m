Return-Path: <netdev+bounces-173608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB5A5A009
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B083A52FB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537B230BF9;
	Mon, 10 Mar 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2TtwspW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DD23099F
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628710; cv=none; b=VuibBSrHPtB4/tAwJWRf3zOakK65IcO5CqTBEPIV8S7ZxpIYwOxK+T3No1+ndQnePtHYWFUG8Rm4PsmbX3NEW5QfT/j43yhoE8a/03EMXcV3NXbgAO6wiQgb93QKHaw3yxFZc/Af6egFzQdkgAtzZdqHbH1f1nI8Ln8rT1lQCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628710; c=relaxed/simple;
	bh=NHkmiNR6wjDZJejCZe7SoI8/491HYK9ZNd1aXet7HmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcTPTf3DsxyunLgm67ON8sorri7DSf4cq2EEb1BJD2yd6xf4rrSFoZ1/vMTJFsYekfRpu86ki5jp+iCEqpkl+z1jBUzBM0G8XSlbD69Y3yeztOaNYWbl5gfnx28HKCNCZaYYy/lLG9ZU9V583FzhKmpMC4BbxRCDyPWzYbWlMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2TtwspW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628709; x=1773164709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHkmiNR6wjDZJejCZe7SoI8/491HYK9ZNd1aXet7HmQ=;
  b=F2TtwspWgPxDcuK7CdzSt0ja2cLRhVmIQcBBreBFeTLfOdbbSZ0y1f11
   OfyabFrcdw2/Z7TYmfzbekLpgqaPm00eNXG//gcrnXyFUQcKIjacjEzrj
   jXwbsBthquFGIG7E01h8ACqjXzy4yhTIGud2QIoNSezHvPMNLtM0xiBoV
   rAuIm9U3qHY0mZNHLXNbMjnHjrmw0MdYMqLIghKgzlW1+Zn4JwCwcfSDy
   f4my/JuFneUfCyInvkFkfUmtXOD0YJckhsBkxddaUeBhA5AhvfU23FqT9
   voTVID/vFTEsAgJ78rEvwKpCfuGE8+37KDiSSk1ibcUHEtka4g+JiSIox
   Q==;
X-CSE-ConnectionGUID: qU0Llr5lSUGx8U3sPvP+1Q==
X-CSE-MsgGUID: ddCaqRgoTTSH7g+APbeV/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46548984"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46548984"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:45:06 -0700
X-CSE-ConnectionGUID: +Ie1pp0RR1aNb0MonDaZTA==
X-CSE-MsgGUID: lXIPAHpMSOGCt71ZJPdS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120950787"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2025 10:45:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 2/6] ice: rename ice_ptp_init_phc_eth56g function
Date: Mon, 10 Mar 2025 10:44:55 -0700
Message-ID: <20250310174502.3708121-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
References: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Refactor the code by changing ice_ptp_init_phc_eth56g function
name to ice_ptp_init_phc_e825, to be consistent with the naming pattern
for other devices.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3e824f7b30c0..fbaf2819e40e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2650,18 +2650,17 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
 }
 
 /**
- * ice_ptp_init_phc_eth56g - Perform E82X specific PHC initialization
+ * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Perform PHC initialization steps specific to E82X devices.
+ * Perform E825-specific PTP hardware clock initialization steps.
  *
- * Return:
- * * %0     - success
- * * %other - failed to initialize CGU
+ * Return: 0 on success, negative error code otherwise.
  */
-static int ice_ptp_init_phc_eth56g(struct ice_hw *hw)
+static int ice_ptp_init_phc_e825(struct ice_hw *hw)
 {
 	ice_sb_access_ena_eth56g(hw, true);
+
 	/* Initialize the Clock Generation Unit */
 	return ice_init_cgu_e82x(hw);
 }
@@ -6123,7 +6122,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_phc_eth56g(hw);
+		return ice_ptp_init_phc_e825(hw);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.47.1


