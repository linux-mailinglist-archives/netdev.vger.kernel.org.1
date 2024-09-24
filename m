Return-Path: <netdev+bounces-129505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069449842E2
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3728B1C228D0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654016C444;
	Tue, 24 Sep 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLOAIEjO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC71474A2
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172135; cv=none; b=Hv5aunx7dfqUyS+WZrI58F3E1Ej7WaYtB5Kag/x1tieP8rLoi60NxZnes3ftV0APXvPSYbZFXAJKzOOTWEDqWcJBpDQPr4MCYlpy/51dafUZkGShLrqy3e/4NxY1wPb94XYGIEc7lALCdejODynylfRDip2o8taUYNv2qDs65Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172135; c=relaxed/simple;
	bh=fWzi33r9j5RvdX7aTM0+xoJHBSYq79DFwoV4k5670xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPisi16Nsh03IGMrVjCU88dKYA/Z3s/kCj1nq1DYKRCa1ptg0Kl5L+Ni7OaFZnku8GdKdPUvX2ts9tQviVUPV2rbjJr5EfrWbU3T8Ub74/YoPirjAnEBZ4LI+b7GndRXCXW4y9kqiO41aK3NZjLqVluoEbC+R9RLFewHKT9eWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLOAIEjO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727172134; x=1758708134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fWzi33r9j5RvdX7aTM0+xoJHBSYq79DFwoV4k5670xI=;
  b=OLOAIEjOEd/IPSg5bSip0gVeLEod77lBS7DyUKcnP21kbNzdVxZorlJv
   FLdWBYwtSDQ2yqU+Zhsud2+WLldkafH+P1/b+ZpaMHOAzwREsnJDzJNNC
   hXGP6voy7H10s9afLSf6gQ1MpCJfEKQxRSegWokoJvKNWckovqo/HvydZ
   rHdeO3hXtH5kGKBh/++boOpW1AcQcrzOLladsABsJjjA+eQyfgJM/MB0d
   egIlHE8imGEODuSXeSIKsiDu+94f1IaYU3TCSuA7ya3qSXYYWCbLabw7j
   CCszX8XTj7oD7C2M7dylJ9+IiLIh02C//wxLByGhgH/TJdRzkvpWImTKE
   Q==;
X-CSE-ConnectionGUID: yUT3wHU8QlOst0eusmHrFw==
X-CSE-MsgGUID: HQMvbwYoRUC9vhYK0IKbJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36725587"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="36725587"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 03:02:14 -0700
X-CSE-ConnectionGUID: +NqXWJA9R4+NBzFH5pzaFQ==
X-CSE-MsgGUID: ho9Qm7d8TY+0ouj7wV4+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="76285967"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2024 03:02:12 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E507D135E8;
	Tue, 24 Sep 2024 11:02:10 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mateusz.polchlopek@intel.com,
	maciej.fijalkowski@intel.com,
	bcreeley@amd.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3 1/2] ice: Fix entering Safe Mode
Date: Tue, 24 Sep 2024 12:04:23 +0200
Message-ID: <20240924100422.8010-3-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If DDP package is missing or corrupted, the driver should enter Safe Mode.
Instead, an error is returned and probe fails.

To fix this, don't exit init if ice_init_ddp_config() returns an error.

Repro:
* Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
* Load ice

Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v3: Change ice_init_ddp_config() type to int, check return (Brett)
v2: Change ice_init_ddp_config() type to void (Maciej)
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0f5c9d347806..7a84d3c4c305 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4749,14 +4749,12 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_init_feature_support(pf);
 
 	err = ice_init_ddp_config(hw, pf);
-	if (err)
-		return err;
 
 	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
 	 * set in pf->state, which will cause ice_is_safe_mode to return
 	 * true
 	 */
-	if (ice_is_safe_mode(pf)) {
+	if (err || ice_is_safe_mode(pf)) {
 		/* we already got function/device capabilities but these don't
 		 * reflect what the driver needs to do in safe mode. Instead of
 		 * adding conditional logic everywhere to ignore these
-- 
2.45.0


