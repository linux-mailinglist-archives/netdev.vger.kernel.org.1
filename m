Return-Path: <netdev+bounces-81817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35188B2D2
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7CE1FA508E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A477317C;
	Mon, 25 Mar 2024 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVVDUOn2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE366D1B9
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402210; cv=none; b=WLkGpI9lzSRCIYEruvSUW+Cc08x26etRjdulY3fwHLpzF/TITinnztHEjSx792Fi+KI5Z/KkE3SeBlKxoPLpP0D5nBrykhXO2Mrqqg4A6F0olF0Ms5AIk3+Fu25W0t9OrhkyF3V32QHre9dIHc0cfjAnwMLeQQkzBTuo0mf1QTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402210; c=relaxed/simple;
	bh=svMfBlLUAhgw33LS7DXsoVKFb0fJ5tSWXIWUQCBDyjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkZbsTA7o31GZrTzT8h46N7cz/1KViTLkzseFNlzXgOotfC6FDHnUxNCH7WYVc3/HSh4Q6wHrok715wPeGpcaMjV9PxJ86MNzZcsSwA4M3xCqoCn0orvrua9Ft0Z05mCcfqsEYIEngCE379ha0XcSirH6Ou/Wp0hjzDdjHXY8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVVDUOn2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711402209; x=1742938209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svMfBlLUAhgw33LS7DXsoVKFb0fJ5tSWXIWUQCBDyjs=;
  b=CVVDUOn2qb5z29xEGb1hfEuN751f9s4wAjRMNBG489BR6tvfDE8m9gG0
   vgJzKxVzvS4JQOF6DHggBnYSAzgnpQ896+/9nSApU0Bh/paZQ5i8rqK4N
   sm49cxIrFMjM2x0cTa4kPoLE069eGDkK6NUD29Oj9fNhrsIzf+VdHenVf
   cflsfGoSmrFQsWpfRErNzNjgEPRctXiqom2QqngVnFrNR2DPKSJ36ffl4
   HQPpOqRioQqBb21JGvrskf4E+JHI1N2aUglS+Qjofrc+dIBLI5EfImWHm
   /shAmMnYbefsuFro1biscbtARETvJzLvMJfID707mw7Wy/qUUkNEWOys4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17064554"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17064554"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 14:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15713512"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 25 Mar 2024 14:30:06 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [iwl-next v1 3/3] ice: hold devlink lock for whole init/cleanup
Date: Mon, 25 Mar 2024 22:34:33 +0100
Message-ID: <20240325213433.829161-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
References: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify devlink lock code in driver by taking it for whole init/cleanup
path. Instead of calling devlink functions that taking lock call the
lockless versions.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_main.c     |  7 ++--
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 71c2f30984d8..8b57e455160d 100644
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
index b8b7a47c3b8a..31e7c74c289f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5180,21 +5180,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
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
 	pci_disable_device(pdev);
@@ -5291,9 +5290,9 @@ static void ice_remove(struct pci_dev *pdev)
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
+	devl_lock(priv_to_devlink(pf));
 	ice_deinit_devlink(pf);
 
-	devl_lock(priv_to_devlink(pf));
 	ice_unload(pf);
 	devl_unlock(priv_to_devlink(pf));
 
-- 
2.42.0


