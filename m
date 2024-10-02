Return-Path: <netdev+bounces-131194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793B98D28F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C01F2317F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9294200132;
	Wed,  2 Oct 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciUImlDI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B984200112
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870003; cv=none; b=kYXYFiJ59to8qzzn84Fz4Mx9OLsNQ45JeRg71n/vKCmEA8ZnpnGtTij+JekQI8etxK2K5F5/YriUw3Kzg98dg4uHUqtnVRPUWIYg1aiVXJOtIneJlWF+doHBUpG73DWZWEd4uRWp0VINjDWXWbEQK8c0gvFT0MI3uiNhYT6qtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870003; c=relaxed/simple;
	bh=lBVtk9x2YLfOlUE3TMNMHn5v07L1WswRQRfR62EXUtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAVcBptPrzJ8dAMci8pc3hUHAKcnzuNFrQNRNaUyvYuPxs4DPc0+tBEGbNPJ7JYMjagNkSnmpgYRoQgb3kUjPhpY+PJMNbeSHwbto8eOjyJxCOmo+BGCLQ99cY9TMtX7aiircF6ey79TxryJeNuPxlZ+9N5myeeseKCBTDm693Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciUImlDI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727870002; x=1759406002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBVtk9x2YLfOlUE3TMNMHn5v07L1WswRQRfR62EXUtI=;
  b=ciUImlDIb7iMN3lyq10gf3/yELhzo0gMUjrjZ+O5e1WdJm/1cK4fzUmq
   vvoO7yS121BrLU+dnskRRQSn8ae9U7+sOOKOE9SO1/zlCDQiRR/vQRt0F
   JOxH/CpP3XchhvLLLQdFFl8apaN35JCF/iN62jBR87TGm+flgYafQecAr
   maCFxQMA6/deLK8NcoBAWhAjmpSc7cThwEdDOFrjo+C+1rRKE9ZEwh5iz
   zFZHT00BMFYxfci1KxNKC3RAWFcRWSP3vWJdMLhS502pdP1LrNSrSMjMW
   emBGpQCGh/BWXCcnITXZxZ1w1IissBrczmmX+fPgFgOM/bgWHOJJNSGCi
   A==;
X-CSE-ConnectionGUID: LDfQIFzSQ+mEFFUK+R9gtQ==
X-CSE-MsgGUID: Cw8txJc2SriaKzWzIoW3qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27183854"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="27183854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:53:21 -0700
X-CSE-ConnectionGUID: K4Q5q0PxQGiBWcdA7X5ymg==
X-CSE-MsgGUID: TuvBr/TeSCeEf1bqV11oNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78396383"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 04:53:20 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.21])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CE5E628195;
	Wed,  2 Oct 2024 12:53:18 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 4/4] ice: ice_probe: init ice_adapter after HW init
Date: Wed,  2 Oct 2024 13:50:24 +0200
Message-ID: <20241002115304.15127-10-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
References: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ice_adapter initialization to be after HW init, so it could use HW
capabilities, like number of PFs. This is needed for devlink-resource
based RSS LUT size management for PF/VF (not in this series).

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a043deccf038..2b8db14d99f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5273,13 +5273,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	}
 
 	pci_set_master(pdev);
-
-	adapter = ice_adapter_get(pdev);
-	if (IS_ERR(adapter))
-		return PTR_ERR(adapter);
-
 	pf->pdev = pdev;
-	pf->adapter = adapter;
 	pci_set_drvdata(pdev, pf);
 	set_bit(ICE_DOWN, pf->state);
 	/* Disable service task until DOWN bit is cleared */
@@ -5310,12 +5304,19 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		goto unroll_adapter;
+		return err;
 	}
 
+	adapter = ice_adapter_get(pdev);
+	if (IS_ERR(adapter)) {
+		err = PTR_ERR(adapter);
+		goto unroll_hw_init;
+	}
+	pf->adapter = adapter;
+
 	err = ice_init(pf);
 	if (err)
-		goto unroll_hw_init;
+		goto unroll_adapter;
 
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
@@ -5334,10 +5335,10 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
-unroll_hw_init:
-	ice_deinit_hw(hw);
 unroll_adapter:
 	ice_adapter_put(pdev);
+unroll_hw_init:
+	ice_deinit_hw(hw);
 	return err;
 }
 
-- 
2.46.0


