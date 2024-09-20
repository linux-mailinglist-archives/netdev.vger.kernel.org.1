Return-Path: <netdev+bounces-129110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAAC97D8A1
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8E2815D2
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893DA17BEC6;
	Fri, 20 Sep 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcTsNHUL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19D79C0
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851397; cv=none; b=j5it6I65x10ZTZKjWvbVbXYjxlxhqMnlNUXnLGmZPDs/xWp6S20jz1c3eJHpqrQisHe/gRRVPxgAutv2lzZfpn3icAGWX34Jzyhrau9aewr85YBbS6oOIiu3KeIChNRvmn0AOB7akPPppRk/CWMq1BPf/0qJ/pWGp5BC3lRj4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851397; c=relaxed/simple;
	bh=OMRGaYWcJ8kuLjSDdQXJDwBIFRal6V100eD6nlGYOb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KECupwpMZ3gTMWYO662ub6O84ew727Q8o/BbHVVv0QpAj34aBt9m3ZlS2Xzuwk5VuxMsnSS1lRKaPTQZD7t76t7hRd/+RNt/SkibnaU02bNf9CTiSodi1ZFT2fwrQ5nAVbk4yCosclyhqu23nhQJLFB8ZMknp0CvVp7WJYN1nyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcTsNHUL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726851396; x=1758387396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OMRGaYWcJ8kuLjSDdQXJDwBIFRal6V100eD6nlGYOb4=;
  b=WcTsNHULz5KI59QopBtJhsG+SxbAmB3ySVyht1PxeBBuy3QzLfS6sw+a
   3k9mBh+y/iyohRBe6zd4XhhSxz+HjL95C1+3PA/JzLP4f3POroxKxSgU+
   D4j9xwdfbTHUYV/lQJ+ZlCRGbgvE9FA7cd0g7ETZeqie/PqJxR6PATwTO
   c59s5L3aCNKFshU9vUHDnKzFxHKUFTcdcXCov3iIQs1rYgj0NHoBicEEZ
   sJyvHs4a6SJmRqEaCjwlq71p4oBBfOKB/5g66QxIvmbdgOPidKQJckiUj
   tsQKYB7GnX9GrstD6kpQGPXNjC1+b0x/K7qNur+VzgVSV5cHPBhyHHt9E
   Q==;
X-CSE-ConnectionGUID: p1blepoLSOuTpNCF7INufw==
X-CSE-MsgGUID: kbrWcykOQ5afQOGJMtbNmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25813929"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25813929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 09:56:35 -0700
X-CSE-ConnectionGUID: SinkSpCxTFibPAGvZs2uFA==
X-CSE-MsgGUID: rCWWVavxQhmflfXx0cBKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="101100621"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 20 Sep 2024 09:56:34 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B28F32F1E;
	Fri, 20 Sep 2024 17:56:32 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mateusz.polchlopek@intel.com,
	maciej.fijalkowski@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2 1/2] ice: Fix entering Safe Mode
Date: Fri, 20 Sep 2024 18:59:17 +0200
Message-ID: <20240920165916.9592-3-marcin.szycik@linux.intel.com>
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

Change ice_init_ddp_config() type to void, as now its return is never
checked.

Repro:
* Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
* Load ice

Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2: Change ice_init_ddp_config() type to void
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0f5c9d347806..aeebf4ae25ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4548,34 +4548,27 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
  *
  * This function loads DDP file from the disk, then initializes Tx
  * topology. At the end DDP package is loaded on the card.
- *
- * Return: zero when init was successful, negative values otherwise.
  */
-static int ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
+static void ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	const struct firmware *firmware = NULL;
 	int err;
 
 	err = ice_request_fw(pf, &firmware);
-	if (err) {
+	if (err)
 		dev_err(dev, "Fail during requesting FW: %d\n", err);
-		return err;
-	}
 
 	err = ice_init_tx_topology(hw, firmware);
 	if (err) {
 		dev_err(dev, "Fail during initialization of Tx topology: %d\n",
 			err);
 		release_firmware(firmware);
-		return err;
 	}
 
 	/* Download firmware to device */
 	ice_load_pkg(firmware, pf);
 	release_firmware(firmware);
-
-	return 0;
 }
 
 /**
@@ -4748,9 +4741,7 @@ int ice_init_dev(struct ice_pf *pf)
 
 	ice_init_feature_support(pf);
 
-	err = ice_init_ddp_config(hw, pf);
-	if (err)
-		return err;
+	ice_init_ddp_config(hw, pf);
 
 	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
 	 * set in pf->state, which will cause ice_is_safe_mode to return
-- 
2.45.0


