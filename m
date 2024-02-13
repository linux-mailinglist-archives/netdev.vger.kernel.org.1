Return-Path: <netdev+bounces-71218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C208529E7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21DE1F2191A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D41799D;
	Tue, 13 Feb 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eukhh4ke"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B38E17597
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809474; cv=none; b=BnL4RLzrrKvdTH+TiVQoHHbSvM+fSVr1lPAslbvhvOHgCn7gN5s6ktdNlhNSoRjwWhP8rPJzL9MzXw5A6iNhIaqYJ8Wo4B5LOksLkXUsQ0bx0O5UAh6CveouJ1X/OmNz2kQONvgQuo1SvIYwLNdgd1FfwD8sp/7NBEmGAWkpSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809474; c=relaxed/simple;
	bh=B55FnDYJcMX8cNbhPyRe0wM4Q8ZKYaV4fzW56DmFzB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp5db5lgkE7CxoJxHHOZbxztMOsmtEkIa2tos9ZAvNjM7Dnn4hC1HG3ufFC5FDE3AIiIqH8Bz1r54vKmlT+iO4Cs3B913safke7qL6GNZVICLm2nzRxP6NiCf6q+D32fY2ojduRP2bKG+inhRb8MVGSAcxPZ/KXmGXjuOaSW3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eukhh4ke; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809473; x=1739345473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B55FnDYJcMX8cNbhPyRe0wM4Q8ZKYaV4fzW56DmFzB0=;
  b=eukhh4ke4j+RIR3eQahQApUwyi6r8TcVZXNQc8GKhhujKcnTSISSrEjF
   MyEGRcX5L9vVhK/42LarhtFTggsvffQpwOE7hoHvdNlUnoYfosjkZCt4l
   TOEC3JJs+jspuXIwfY67yEy2zwuaTYuM5mi3yEcuAFH1pwPci62Y9E9Is
   kp7XlbK4ATxK/0vPI0di66BnhnUK1Bm/SwvXsS9iWWn3pvlV2+jbqZTp0
   u/IZbiHtzzmwCgv5WXKlKViHyGyzRNXL5qQZwuNf6eVhuPN38/XKIeUqK
   mU68CkKfr0hMBCUPZJF9j6zPG352V6hfq0oPsMGn1pIwxdwf8lPnEGChk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19219909"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="19219909"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2797556"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 12 Feb 2024 23:31:08 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: [iwl-next v1 6/7] ice: enable_rdma devlink param
Date: Tue, 13 Feb 2024 08:35:08 +0100
Message-ID: <20240213073509.77622-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement enable_rdma devlink parameter to allow user to turn RDMA
feature on and off.

It is useful when there is no enough interrupts and user doesn't need
RDMA feature.

Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 32 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c     |  8 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index b82ff9556a4b..4f048268db72 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1675,6 +1675,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
+					    union devlink_param_value val,
+					    struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	bool new_state = val.vbool;
+
+	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static const struct devlink_param ice_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      ice_devlink_enable_roce_get,
@@ -1700,6 +1713,8 @@ static const struct devlink_param ice_devlink_params[] = {
 			      ice_devlink_msix_min_pf_get,
 			      ice_devlink_msix_min_pf_set,
 			      ice_devlink_msix_min_pf_validate),
+	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_enable_rdma_validate),
 };
 
 static void ice_devlink_free(void *devlink_ptr)
@@ -1776,9 +1791,22 @@ ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	union devlink_param_value value;
+	int err;
+
+	err = devlink_params_register(devlink, ice_devlink_params,
+				      ARRAY_SIZE(ice_devlink_params));
+	if (err)
+		return err;
 
-	return devlink_params_register(devlink, ice_devlink_params,
-				       ARRAY_SIZE(ice_devlink_params));
+	devl_lock(devlink);
+	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
+					value);
+	devl_unlock(devlink);
+
+	return 0;
 }
 
 void ice_devlink_unregister_params(struct ice_pf *pf)
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a30d2d2b51c1..4d5c3d699044 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -829,7 +829,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
  */
 bool ice_is_rdma_ena(struct ice_pf *pf)
 {
-	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
+	union devlink_param_value value;
+	int err;
+
+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
+					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
+					      &value);
+	return err ? false : value.vbool;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 824732f16112..4dd59d888ec7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5177,23 +5177,21 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	if (err)
 		goto err_init;
 
+	err = ice_init_devlink(pf);
+	if (err)
+		goto err_init_devlink;
+
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
 	devl_unlock(priv_to_devlink(pf));
 	if (err)
 		goto err_load;
 
-	err = ice_init_devlink(pf);
-	if (err)
-		goto err_init_devlink;
-
 	return 0;
 
-err_init_devlink:
-	devl_lock(priv_to_devlink(pf));
-	ice_unload(pf);
-	devl_unlock(priv_to_devlink(pf));
 err_load:
+	ice_deinit_devlink(pf);
+err_init_devlink:
 	ice_deinit(pf);
 err_init:
 	pci_disable_device(pdev);
@@ -5290,12 +5288,12 @@ static void ice_remove(struct pci_dev *pdev)
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
-	ice_deinit_devlink(pf);
-
 	devl_lock(priv_to_devlink(pf));
 	ice_unload(pf);
 	devl_unlock(priv_to_devlink(pf));
 
+	ice_deinit_devlink(pf);
+
 	ice_deinit(pf);
 	ice_vsi_release_all(pf);
 
-- 
2.42.0


