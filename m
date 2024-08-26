Return-Path: <netdev+bounces-122080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D495FD6B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD45A1F20EE2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527311A01DE;
	Mon, 26 Aug 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOk3w+Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3321A01A6
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712428; cv=none; b=GGGvVSDAbPYUQsEhbwmRSEp+xvTH4vEpXlv+jVaoQ+7H+Yp0ujOBhxXmpFuCQm7H8vqb05xkxFHfR4MNXizzrB0LXnYeushOBfwXxgfxMlSg0Ks7KFRCgEbFCrlpjT9shuVNL3oYAUNuVf1pAsj/i5ZOVSj3dI/atAPP9SbCr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712428; c=relaxed/simple;
	bh=/yLD/IQS38TjpRvdcdfkYodLx72EPTjE1ibcU3iJ8eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0iiveb8eyZlO6XlOOp5PqZk0p779kLQS8OkUBx1hJT3QCibBN4yXfZrtGX+LLFkRkH57JbtOOIoPOMDmpZwsoRE0GExOb3r+3vipoTCnzXfWBZymmWSxT6U4n8wH5A4U2k09gkhrSEMp2L3zgrXdHhNg+Rs+0O/OvGgth2P+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOk3w+Pe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712427; x=1756248427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yLD/IQS38TjpRvdcdfkYodLx72EPTjE1ibcU3iJ8eQ=;
  b=MOk3w+PeuP5Q7iPOmsLT/LcoABQF1UuTV9lw7Ui4cV1S9pA/P+BhaTPp
   GzObxGNLj7YK9pM/AX3Wr+aoVaQkfYJvDkmi45MktvjGCAxaIWsjzR0/H
   rEnlZzoiH48phFHVZtghgJBkWfUrbW/1i7flkFsm9LMSlc1bcMtZEnQtS
   e3PO1Zvp8DuVTjE5HTK4yK/obCWq2CUJpBax13zPaZ1BXoNEM6Pe4gf9l
   2VJ7Ve84GQxYT3jOYtwDcf+pvaZFWsTyqwGbhxONE0QZOXzEr4fSIOrgP
   uV+VVN7VDzTEhGZM8zHfj3HpL2LNdpfmIWF9MCqTb2qmJl5hRej63PtLp
   g==;
X-CSE-ConnectionGUID: Qi52POC3RqKBsZfBKFozsw==
X-CSE-MsgGUID: USEA6h9ASICwsHc2xOs13w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030986"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:02 -0700
X-CSE-ConnectionGUID: rWuAKcr7QfGlRMRzHRMgAA==
X-CSE-MsgGUID: 2rZEjgvtT7STUdY5v/4ZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822485"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 7/8] ice: Report NVM version numbers on mismatch during load
Date: Mon, 26 Aug 2024 15:46:47 -0700
Message-ID: <20240826224655.133847-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Report NVM version numbers (both detected and expected) when a mismatch b/w
driver and firmware is detected. This provides more useful information
about which NVM version the driver expects, rather than requiring manual
code inspection.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index b5774035e6f9..e3959ad442a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -488,7 +488,7 @@ static int ice_shutdown_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 }
 
 /**
- * ice_aq_ver_check - Check the reported AQ API version.
+ * ice_aq_ver_check - Check the reported AQ API version
  * @hw: pointer to the hardware structure
  *
  * Checks if the driver should load on a given AQ API version.
@@ -508,14 +508,20 @@ static bool ice_aq_ver_check(struct ice_hw *hw)
 	} else if (hw->api_maj_ver == exp_fw_api_ver_major) {
 		if (hw->api_min_ver > (exp_fw_api_ver_minor + 2))
 			dev_info(ice_hw_to_dev(hw),
-				 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+				 "The driver for the device detected a newer version (%u.%u) of the NVM image than expected (%u.%u). Please install the most recent version of the network driver.\n",
+				 hw->api_maj_ver, hw->api_min_ver,
+				 exp_fw_api_ver_major, exp_fw_api_ver_minor);
 		else if ((hw->api_min_ver + 2) < exp_fw_api_ver_minor)
 			dev_info(ice_hw_to_dev(hw),
-				 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+				 "The driver for the device detected an older version (%u.%u) of the NVM image than expected (%u.%u). Please update the NVM image.\n",
+				 hw->api_maj_ver, hw->api_min_ver,
+				 exp_fw_api_ver_major, exp_fw_api_ver_minor);
 	} else {
 		/* Major API version is older than expected, log a warning */
 		dev_info(ice_hw_to_dev(hw),
-			 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+			 "The driver for the device detected an older version (%u.%u) of the NVM image than expected (%u.%u). Please update the NVM image.\n",
+			 hw->api_maj_ver, hw->api_min_ver,
+			 exp_fw_api_ver_major, exp_fw_api_ver_minor);
 	}
 	return true;
 }
-- 
2.42.0


