Return-Path: <netdev+bounces-129067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A297D4F4
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C50285A54
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440F143888;
	Fri, 20 Sep 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlJ9d9iz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70514386D
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833142; cv=none; b=dsrJO9jMfnVrscSk/w/IPql/hdg4LzwzQdQL95CNPcqOQsJAAJJkRihWRHVQU/zl7MHQ0MqWbqOWfqXy7nyPlDTAkT91qmkPk/A5IVUbPdHEQPfL8skjqPcgOkH8wly3Q9Kzzbb95APycJF5yTS+Irs7VbIZpn2vmjnZz86VmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833142; c=relaxed/simple;
	bh=RiozRk7VfjzRUIe3LI7qPJXH9LFjSxqMrA5xS4AOpsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqWxx6eEJSgYuzUdhQOA7oOaTnngGJX1VOnMbHoShYOfRFKgu+Vo9T6mO/6S2uzkwn8EM3/tkL3zPBXleMUmYMBKAjintgoVlN5IEd7feJZ54+L/JsvYnJYGjgk9Lv/LPZg1rrDeZrh3FnVBnoH2KcOczWd3H4knMmd/QdmzVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlJ9d9iz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726833142; x=1758369142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RiozRk7VfjzRUIe3LI7qPJXH9LFjSxqMrA5xS4AOpsc=;
  b=QlJ9d9iz8SesvX/wIKP9i7aisW8+uuFaO1mVMxzVEeMGsT5k2hw9hi6n
   +fmBAhdmygWehhB0u0DoiF08mLV8k4BH6nVU4zrXmMD5DvgEWH5kizGKW
   W/V3M6lqI8yKbP/spDLpodMq35a3ZcRoqIADqyHWmJDnw32fOPW85KlSe
   GHFF+LQq+UaQ3I0dLAmYzLmitiCGECTA3pLScesThzKuDjW9L/nwmyQK5
   HQVCa5kmK1XL9ihnBWn+u+TwJGCfAvN1EkgfGyDwjSmF01uRZb6f1g9+t
   jDuXE8QGlhbehYMAyTBN9JwvXtjIwpnHxm1EA0WdKAD82Q7tjxAr+1hfg
   A==;
X-CSE-ConnectionGUID: uGBn3CLuQj+gzUy3LabnPA==
X-CSE-MsgGUID: Y9+CpP6cRj6r8V73lIoeVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25708348"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25708348"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:52:21 -0700
X-CSE-ConnectionGUID: PJIy/0DTTCOTr2fGBf7pzA==
X-CSE-MsgGUID: poA2NL46RGSmRtsboYKHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75046032"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 20 Sep 2024 04:52:19 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2345127BB0;
	Fri, 20 Sep 2024 12:52:18 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mateusz.polchlopek@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 1/2] ice: Fix entering Safe Mode
Date: Fri, 20 Sep 2024 13:55:09 +0200
Message-ID: <20240920115508.3168-3-marcin.szycik@linux.intel.com>
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

Don't check return value of ice_init_ddp_config() to fix this.

Repro:
* Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
* Load ice

Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0f5c9d347806..7b6725d652e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4748,9 +4748,7 @@ int ice_init_dev(struct ice_pf *pf)
 
 	ice_init_feature_support(pf);
 
-	err = ice_init_ddp_config(hw, pf);
-	if (err)
-		return err;
+	ice_init_ddp_config(hw, pf);
 
 	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
 	 * set in pf->state, which will cause ice_is_safe_mode to return
-- 
2.45.0


