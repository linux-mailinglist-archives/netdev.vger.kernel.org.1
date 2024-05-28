Return-Path: <netdev+bounces-98791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C68D27C2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621501C245EA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E913E028;
	Tue, 28 May 2024 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFIrEfeD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29B13E3E3
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933985; cv=none; b=D1WC5IhZM8mg51cUy+OIfg4fzqOGhfbifjC5ihJxrjMsrAzIRP7xSstKzVHGhavuYeE/mlQXO4187Qz20oHKvgi3Gdse2k6+frNKZoPU/3bvZCL1ccXRJbjLBT77vCO9TSS863IOM0R9n0i5G/9ewu8nqubNwM93PAI9BGdcv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933985; c=relaxed/simple;
	bh=wUFFfCSxXVn5PpxDHUCC5vNayV787a98kBb2Kz9C4s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GA9s+knzOim0d4CEqbHniDaKjWPS8FhNI1ZW6So7oug3kbpHRrk9NY0swEFtlOfbj5A0uIjreuCOHmNV1nbER2F4G9VUo4D95xcOT6jEzVOrAi0S/x6/Gpnp4L0XWHiyno8cPVtXpxrTMu/lkylyzJPC/yo0wuj5dcmDGOunzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFIrEfeD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933984; x=1748469984;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wUFFfCSxXVn5PpxDHUCC5vNayV787a98kBb2Kz9C4s4=;
  b=JFIrEfeDyPV/QEc78KiNQkufHjLO9lp1R1bdlRECUwBNdcUCYyVWAU2Z
   rqkYxn2Fg+IVfeHMt9MHeecSgO5aAUwgmW8olS/4VjmYz4kMilek7Rni0
   28HI8zUjEx533XSp+viuhd8TEcVHKnVo/0B9U8Ald29BRvBiALu/pFNUO
   /d6kiUFBHB15bpuD8xL5v5Etk5UGCMP19eF09NNaSKIKdSlQa/fkot479
   ZIvT+dvtL0W4aptAx84ggSrfetHk6892SR74tEdspIwZZg1ZpgMmRqiC8
   42MgmkKiw9foVOFHU701Wtw5cE3xy15QbJVJEBY6iCIdudVtzW46ciM6U
   Q==;
X-CSE-ConnectionGUID: 2OLD0a9eRdieqbNsMHgMXA==
X-CSE-MsgGUID: Ew5x4b3bTSyzZCPFJKAMhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439629"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: SwkDcVBsRA63cOJmdvBA/w==
X-CSE-MsgGUID: dWFpQu1rTpi+AMvuH3rpRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087533"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:11 -0700
Subject: [PATCH net 8/8] ice: check for unregistering correct number of
 devlink params
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-8-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Dave Ertman <david.m.ertman@intel.com>, 
 Lukasz Czapnik <lukasz.czapnik@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Dave Ertman <david.m.ertman@intel.com>

On module load, the ice driver checks for the lack of a specific PF
capability to determine if it should reduce the number of devlink params
to register.  One situation when this test returns true is when the
driver loads in safe mode.  The same check is not present on the unload
path when devlink params are unregistered.  This results in the driver
triggering a WARN_ON in the kernel devlink code.

The current check and code path uses a reduction in the number of elements
reported in the list of params.  This is fragile and not good for future
maintaining.

Change the parameters to be held in two lists, one always registered and
one dependent on the check.

Add a symmetrical check in the unload path so that the correct parameters
are unregistered as well.

Fixes: 109eb2917284 ("ice: Add tx_scheduling_layers devlink param")
CC: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 31 +++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index c4b69655cdf5..704e9ad5144e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1388,7 +1388,7 @@ enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
 };
 
-static const struct devlink_param ice_devlink_params[] = {
+static const struct devlink_param ice_dvl_rdma_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      ice_devlink_enable_roce_get,
 			      ice_devlink_enable_roce_set,
@@ -1397,6 +1397,9 @@ static const struct devlink_param ice_devlink_params[] = {
 			      ice_devlink_enable_iw_get,
 			      ice_devlink_enable_iw_set,
 			      ice_devlink_enable_iw_validate),
+};
+
+static const struct devlink_param ice_dvl_sched_params[] = {
 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
 			     "tx_scheduling_layers",
 			     DEVLINK_PARAM_TYPE_U8,
@@ -1464,21 +1467,31 @@ int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
 	struct ice_hw *hw = &pf->hw;
-	size_t params_size;
+	int status;
 
-	params_size =  ARRAY_SIZE(ice_devlink_params);
+	status = devl_params_register(devlink, ice_dvl_rdma_params,
+				      ARRAY_SIZE(ice_dvl_rdma_params));
+	if (status)
+		return status;
 
-	if (!hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
-		params_size--;
+	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
+		status = devl_params_register(devlink, ice_dvl_sched_params,
+					      ARRAY_SIZE(ice_dvl_sched_params));
 
-	return devl_params_register(devlink, ice_devlink_params,
-				    params_size);
+	return status;
 }
 
 void ice_devlink_unregister_params(struct ice_pf *pf)
 {
-	devl_params_unregister(priv_to_devlink(pf), ice_devlink_params,
-			       ARRAY_SIZE(ice_devlink_params));
+	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_hw *hw = &pf->hw;
+
+	devl_params_unregister(devlink, ice_dvl_rdma_params,
+			       ARRAY_SIZE(ice_dvl_rdma_params));
+
+	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
+		devl_params_unregister(devlink, ice_dvl_sched_params,
+				       ARRAY_SIZE(ice_dvl_sched_params));
 }
 
 #define ICE_DEVLINK_READ_BLK_SIZE (1024 * 1024)

-- 
2.44.0.53.g0f9d4d28b7e6


