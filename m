Return-Path: <netdev+bounces-131191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78B98D289
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A3B1C21AAF
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168220010B;
	Wed,  2 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPeGaq+f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608391E6DFF
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870002; cv=none; b=uanOhXgPvd92cGsMg65vF/d41ILAUFTh5qF5FOZutyYcJAl34NwwH52eIsTSa/zA+/q7mAt9GWJNMfYJPK5GzBzoUQHl+3lSOE72Xl192vRr1+TYtOLphoIxa+oiRHzclujzrjfAso8oFIi4Vm0uYOK8mOkFKdLzGnTNebk0HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870002; c=relaxed/simple;
	bh=gRLCXlAAXvMxcKis8qdtfZ4PICzp51CV5Rb+XWIMM08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO8YzW+iJAH7fuam+NPCHSGPx4jdjNfy4T8M4S2w3t9vDXL6R8PC23QLS90O0/KijvsSPtaF6RBoRzupp9OgAsuWe7QqxNXxCOXCXKR/L9kKSr4N4RCgwyXbWMPGSAnr8amO/oX1JWwhUsTEhYJJaGRTaU3JByyddYKCygIFgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPeGaq+f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727870000; x=1759406000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRLCXlAAXvMxcKis8qdtfZ4PICzp51CV5Rb+XWIMM08=;
  b=XPeGaq+fTXv9jnAj9rk6YJTZ0Jt75HNxPZBLme8PK/wsY5//olHV/VlR
   akAhzLUrQ20OnUlmqTJN32CTp1FfXaJm6+LoeLKRpETwGmN54UfVSFoU/
   7bwL83qqAxLt98K4ZXzVAd3GXQAvSxGwWQoj2w2VjXgSgmyOiUuRLAqL+
   dTESD0skR3WppdGpCQW/FGD2kF/kQr5qzdMZyzhdDzd8XyUuO3f0kdxm1
   0xBwkDcR+1+gC8xoY3ovmLY2QcMTx7073w+VhpzxInCRuDshS12MMXxoa
   JZzgMSwg4Ro4pqphDX6Di7OZR4wAUL5JthzE5mvapBozYlUaRZvV9cMwA
   Q==;
X-CSE-ConnectionGUID: Blg6H9zLT+iXBYJqivvf3w==
X-CSE-MsgGUID: 3l8wDhaTQGiFHMLaxb+gfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27183846"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="27183846"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:53:20 -0700
X-CSE-ConnectionGUID: 2sLrcrDSQNavHLKzQ145kg==
X-CSE-MsgGUID: 2iIkKckxRpyedwn5g9zzoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78396376"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 04:53:18 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.21])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DD56128167;
	Wed,  2 Oct 2024 12:53:16 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 2/4] ice: split ice_init_hw() out from ice_init_dev()
Date: Wed,  2 Oct 2024 13:50:22 +0200
Message-ID: <20241002115304.15127-8-przemyslaw.kitszel@intel.com>
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

Split ice_init_hw() call out from ice_init_dev(). Such move enables
pulling the former to be even earlier on call path, what would enable
moving ice_adapter init to be between the two (in subsequent commit).
Such move enables ice_adapter to know about number of PFs.

Do the same for ice_deinit_hw(), so the init and deinit calls could
be easily mirrored.
Next commit will rename unrelated goto labels to unroll prefix.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 10 ++++++++-
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 +++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 415445cefdb2..24bb85dbfa86 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1207,9 +1207,15 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	int err;
 
+	err = ice_init_hw(&pf->hw);
+	if (err) {
+		dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
+		return err;
+	}
+
 	err = ice_init_dev(pf);
 	if (err)
-		return err;
+		goto unroll_hw_init;
 
 	vsi->flags = ICE_VSI_FLAG_INIT;
 
@@ -1232,6 +1238,8 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	rtnl_unlock();
 err_vsi_cfg:
 	ice_deinit_dev(pf);
+unroll_hw_init:
+	ice_deinit_hw(&pf->hw);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 53479b729492..f0903dddcb16 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4753,12 +4753,6 @@ int ice_init_dev(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	err = ice_init_hw(hw);
-	if (err) {
-		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
-	}
-
 	ice_init_feature_support(pf);
 
 	err = ice_init_ddp_config(hw, pf);
@@ -4779,7 +4773,7 @@ int ice_init_dev(struct ice_pf *pf)
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto err_init_pf;
+		return err;
 	}
 
 	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
@@ -4823,8 +4817,6 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_clear_interrupt_scheme(pf);
 err_init_interrupt_scheme:
 	ice_deinit_pf(pf);
-err_init_pf:
-	ice_deinit_hw(hw);
 	return err;
 }
 
@@ -5315,9 +5307,15 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		hw->debug_mask = debug;
 #endif
 
+	err = ice_init_hw(hw);
+	if (err) {
+		dev_err(dev, "ice_init_hw failed: %d\n", err);
+		goto unroll_adapter;
+	}
+
 	err = ice_init(pf);
 	if (err)
-		goto err_init;
+		goto unroll_hw_init;
 
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
@@ -5336,7 +5334,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 err_load:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
-err_init:
+unroll_hw_init:
+	ice_deinit_hw(hw);
+unroll_adapter:
 	ice_adapter_put(pdev);
 	return err;
 }
-- 
2.46.0


