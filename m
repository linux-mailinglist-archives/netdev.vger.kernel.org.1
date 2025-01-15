Return-Path: <netdev+bounces-158306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12790A115DE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ACBC7A29B3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025466AA1;
	Wed, 15 Jan 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOZEcCP2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A832184F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899735; cv=none; b=E8PkJTEbIQGAEYvTGrnBK5Tl33sE9cF9yvFpxLkJ3JaowLWI29+s6TXE4COgOrow6YcPtnaUh9tSu8yP5z7ZIkLrS/czGiw+LTdF6Q4EXsnxVHLVI0qkg6IBZ1cC9QrxoZeshV6IxPaydxMBQJ7cz3Ki+f4LnGxPDRVzgLDj1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899735; c=relaxed/simple;
	bh=Oqd1RlCnDoZrJzYOjkUWEPRaGaDv37NpN2ml2ApCgYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mepzEnTYo+aa0rAKGpbc2/PFwG5gOczUervOUboBlnNTMywZGLH+N1YHNkSzLdMXVQ9ThjfgdKA6TxecqSzAHp5INYeGvZNBv28SxYoGwBn+us+j1mnuwJNAXRFSv7RqakM/HuWcVAVJPAURnQeo1jZI6MrZrJ8YsqDKkOHjrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOZEcCP2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899734; x=1768435734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oqd1RlCnDoZrJzYOjkUWEPRaGaDv37NpN2ml2ApCgYM=;
  b=fOZEcCP2qzM+vWARl4BHYioaV0iYsWmblxK5qqDzI36wPISVnGGfJkWc
   MeEQZSnxIa3kVv7NKsbm63I8EqlUDyULUJKS9uMLBG2YgYswJ9gpPGo/b
   zbQ1R25biPuVBqU97VtOgpXDuPkZ0HdKT7qIF7pXK+lQW47qk4LKzOgth
   0HPkRLcIHwp405A18gaLqKLl52B6bKQsmM5i1PBDdGJ0SY/nAIAhLIw5H
   D1U2ISBTYD4ypHBBExC+ee++lUT7Q3lTsAf3cyruYM5hULCAPpViOrdi0
   zM/hm8wx/ycPPA8Xq8n6lyLEX5WMrjvy+gNlB3wUjYklolvzymwCCL1up
   g==;
X-CSE-ConnectionGUID: C4WDHLlnRPOWDMmMepF3Fw==
X-CSE-MsgGUID: oa0S4eImSdmct6zvx/weeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897455"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897455"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:52 -0800
X-CSE-ConnectionGUID: ZJsuOgVXS1m9xllcL61FvQ==
X-CSE-MsgGUID: XxzaCXLsT+mQ6EyApxSRPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211394"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:51 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 02/13] ice: split ice_init_hw() out from ice_init_dev()
Date: Tue, 14 Jan 2025 16:08:28 -0800
Message-ID: <20250115000844.714530-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Split ice_init_hw() call out from ice_init_dev(). Such move enables
pulling the former to be even earlier on call path, what would enable
moving ice_adapter init to be between the two (in subsequent commit).
Such move enables ice_adapter to know about number of PFs.

Do the same for ice_deinit_hw(), so the init and deinit calls could
be easily mirrored.
Next commit will rename unrelated goto labels to unroll prefix.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 10 ++++++++-
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 +++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 1b10682c00b8..d1b9ccec5e05 100644
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
index f0a637cf3d87..5d7d4a66fbcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4755,12 +4755,6 @@ int ice_init_dev(struct ice_pf *pf)
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
@@ -4781,7 +4775,7 @@ int ice_init_dev(struct ice_pf *pf)
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto err_init_pf;
+		return err;
 	}
 
 	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
@@ -4825,8 +4819,6 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_clear_interrupt_scheme(pf);
 err_init_interrupt_scheme:
 	ice_deinit_pf(pf);
-err_init_pf:
-	ice_deinit_hw(hw);
 	return err;
 }
 
@@ -5319,9 +5311,15 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
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
@@ -5340,7 +5338,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
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
2.47.1


