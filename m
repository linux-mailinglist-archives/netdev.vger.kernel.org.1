Return-Path: <netdev+bounces-83791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B998689444E
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700B62837BA
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F650249;
	Mon,  1 Apr 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T80g6KYm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91050255
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992274; cv=none; b=G00gDAGHgCgISP9Jxbv6AHAs3N/P59a5/nGQcWo/b+iwHYLtBR2Hi02sZ5VoLU7j9l+pMGV+V50qoBFnRGvitLlrb6Y1qBs1rJXY3LFdMWNRYPiA4cHOlc0oggkHIH5uM2s1V/GA3NtTBarJt/g8fpDj3kvMPXeXSR1RQ/eh4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992274; c=relaxed/simple;
	bh=yEtOoEHMPGuF8ODx6bCfo0QJhzfpDQxyzCAxCCKK2cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPgUBPUq0bgG8JR4N8kvqlBMTyi0dI1iyZZ2Es2GUq7k4pQXpF69SHJRPcNRKTJrfhuZCouY0H3BfG9XFfSTnORUKT0joYjJ4fM5HLWbcznCUEv1WFgOSa82vjxZMftyvhxHX9SJP/Lzqj3DhtSwnI6Jp0Jqo+P7hXz2CMWpclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T80g6KYm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992274; x=1743528274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yEtOoEHMPGuF8ODx6bCfo0QJhzfpDQxyzCAxCCKK2cU=;
  b=T80g6KYmfr2Hau9zQuvLWIHRqbYS23qu84i051VrF1XFC8Hwj4HpM+1m
   LUCg52PnSDK4teBci//oj3VQva/oEuq12K23co9XBmarWpJTDFrotFeFs
   z3gt8oweuHNP3IDyx3ZCjxFYwxauAQ9crCzv+bbH1DH/36SG92VD+iP0l
   Q/p5QHsocQZ/ke1bjM27aXOOHPS4aEPaeBx99JIDC6yAv3RIk+LJ+bot5
   5EuzPVDEPfDmdAAH5nYsROtsxJdPx3NtMW8vk/0pl5Qw6Y962sCNnZQDJ
   /21hNOuUMrG0QmzDRl0FNORusegOHsEOz2X41htB8pwRH8tpna25pl+hE
   A==;
X-CSE-ConnectionGUID: jek0pf15SlmtSlLxT6OrUg==
X-CSE-MsgGUID: G5HIr4kxRvaMTCsvqOZ2rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606185"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235103"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 8/8] ice: hold devlink lock for whole init/cleanup
Date: Mon,  1 Apr 2024 10:24:18 -0700
Message-ID: <20240401172421.1401696-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Simplify devlink lock code in driver by taking it for whole init/cleanup
path. Instead of calling devlink functions that taking lock call the
lockless versions.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_main.c     |  7 ++--
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 926a14ac0d6f..be9244bb8bbc 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1287,7 +1287,7 @@ void ice_devlink_register(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
 
-	devlink_register(devlink);
+	devl_register(devlink);
 }
 
 /**
@@ -1298,21 +1298,21 @@ void ice_devlink_register(struct ice_pf *pf)
  */
 void ice_devlink_unregister(struct ice_pf *pf)
 {
-	devlink_unregister(priv_to_devlink(pf));
+	devl_unregister(priv_to_devlink(pf));
 }
 
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
 
-	return devlink_params_register(devlink, ice_devlink_params,
-				       ARRAY_SIZE(ice_devlink_params));
+	return devl_params_register(devlink, ice_devlink_params,
+				    ARRAY_SIZE(ice_devlink_params));
 }
 
 void ice_devlink_unregister_params(struct ice_pf *pf)
 {
-	devlink_params_unregister(priv_to_devlink(pf), ice_devlink_params,
-				  ARRAY_SIZE(ice_devlink_params));
+	devl_params_unregister(priv_to_devlink(pf), ice_devlink_params,
+			       ARRAY_SIZE(ice_devlink_params));
 }
 
 #define ICE_DEVLINK_READ_BLK_SIZE (1024 * 1024)
@@ -1553,8 +1553,8 @@ void ice_devlink_init_regions(struct ice_pf *pf)
 	u64 nvm_size, sram_size;
 
 	nvm_size = pf->hw.flash.flash_size;
-	pf->nvm_region = devlink_region_create(devlink, &ice_nvm_region_ops, 1,
-					       nvm_size);
+	pf->nvm_region = devl_region_create(devlink, &ice_nvm_region_ops, 1,
+					    nvm_size);
 	if (IS_ERR(pf->nvm_region)) {
 		dev_err(dev, "failed to create NVM devlink region, err %ld\n",
 			PTR_ERR(pf->nvm_region));
@@ -1562,17 +1562,17 @@ void ice_devlink_init_regions(struct ice_pf *pf)
 	}
 
 	sram_size = pf->hw.flash.sr_words * 2u;
-	pf->sram_region = devlink_region_create(devlink, &ice_sram_region_ops,
-						1, sram_size);
+	pf->sram_region = devl_region_create(devlink, &ice_sram_region_ops,
+					     1, sram_size);
 	if (IS_ERR(pf->sram_region)) {
 		dev_err(dev, "failed to create shadow-ram devlink region, err %ld\n",
 			PTR_ERR(pf->sram_region));
 		pf->sram_region = NULL;
 	}
 
-	pf->devcaps_region = devlink_region_create(devlink,
-						   &ice_devcaps_region_ops, 10,
-						   ICE_AQ_MAX_BUF_LEN);
+	pf->devcaps_region = devl_region_create(devlink,
+						&ice_devcaps_region_ops, 10,
+						ICE_AQ_MAX_BUF_LEN);
 	if (IS_ERR(pf->devcaps_region)) {
 		dev_err(dev, "failed to create device-caps devlink region, err %ld\n",
 			PTR_ERR(pf->devcaps_region));
@@ -1589,11 +1589,11 @@ void ice_devlink_init_regions(struct ice_pf *pf)
 void ice_devlink_destroy_regions(struct ice_pf *pf)
 {
 	if (pf->nvm_region)
-		devlink_region_destroy(pf->nvm_region);
+		devl_region_destroy(pf->nvm_region);
 
 	if (pf->sram_region)
-		devlink_region_destroy(pf->sram_region);
+		devl_region_destroy(pf->sram_region);
 
 	if (pf->devcaps_region)
-		devlink_region_destroy(pf->devcaps_region);
+		devl_region_destroy(pf->devcaps_region);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1784382fe1ff..b68a4ad864b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5186,21 +5186,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
-	devl_unlock(priv_to_devlink(pf));
 	if (err)
 		goto err_load;
 
 	err = ice_init_devlink(pf);
 	if (err)
 		goto err_init_devlink;
+	devl_unlock(priv_to_devlink(pf));
 
 	return 0;
 
 err_init_devlink:
-	devl_lock(priv_to_devlink(pf));
 	ice_unload(pf);
-	devl_unlock(priv_to_devlink(pf));
 err_load:
+	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
 err_init:
 	ice_adapter_put(pdev);
@@ -5298,9 +5297,9 @@ static void ice_remove(struct pci_dev *pdev)
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
+	devl_lock(priv_to_devlink(pf));
 	ice_deinit_devlink(pf);
 
-	devl_lock(priv_to_devlink(pf));
 	ice_unload(pf);
 	devl_unlock(priv_to_devlink(pf));
 
-- 
2.41.0


