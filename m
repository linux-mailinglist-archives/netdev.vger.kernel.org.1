Return-Path: <netdev+bounces-103545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6B9088AF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3FA1F21549
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE7193093;
	Fri, 14 Jun 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3Ii9z6j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2E1922D1
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358476; cv=none; b=efotsTFTaiUfEME/k0Ve9JuB5AXywx1/SXt8ZEoeuP4GKAmwPeEGFzLCYWGMif4J8eUrM4TAVHJEA6vUzD4PrYDTSpSqDN8msRZU7GB1XhQDDoCPcnbsxtkwjZkwxdBU7/v8Ft1YsZWKMYN/w0L0tMXGdSVP740NIiluT3TbzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358476; c=relaxed/simple;
	bh=UWF0tHOrIr5xcSYLhPIyVdLa6sMGe87xRous5b1FBIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TdTtzuCXEtJYgmGAXhl+JU8YVULWcW6A6MZgGtNP6LdZy/Gv3J10WqukdHTV2Kbx5kqTwcmWNd91MjlbtaAr2CwocuE80vIkrT0KXYs2mccraWGC0l9tVW2+52oTgcPVwgK3x+Os4oJfKS/p8BBML+F/WTlmgArCdsaDuVWLzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3Ii9z6j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718358474; x=1749894474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UWF0tHOrIr5xcSYLhPIyVdLa6sMGe87xRous5b1FBIg=;
  b=S3Ii9z6jbV1zhoXWUCa7bZDpgx9NIH3xl6fZf/RXczkBbTph0efUrKKW
   SxNcivG85liiUikJbv+g3gZgjDv47VWUHo5InEXRBa5OJrDsztf5nHIqW
   H0Cmt7FRojLF2LklVSyWcwWUdEoh/mkrYkY0/72/ONHVhxze5mSV2C2IN
   LfrGdsAI620+ulfQAhK0hs/NmuXhdR3GhDl1M+1fuywHHVSSWMXIGiPHI
   LX52gdqUtTCGTiy0EvohlmGH66L0vCQ3IAqhzE/RZSNuULgmCQxLVrswI
   nmk66LWJv0ddiSN4BhbvviIWl0c0LCAYYj3KNubxjKA+Wa4F1ptCANtRU
   Q==;
X-CSE-ConnectionGUID: yhDJfXEhRP2fAA+nTsGvmQ==
X-CSE-MsgGUID: eICotklcT620HYWq3c80tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32714399"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="32714399"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:47:53 -0700
X-CSE-ConnectionGUID: eXD3E9/hTl2W+DtKmlddDA==
X-CSE-MsgGUID: o1q4P4hjSEanyA3vLgwnZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45572374"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.123.220.50])
  by orviesa004.jf.intel.com with ESMTP; 14 Jun 2024 02:47:51 -0700
From: Karen Ostrowska <karen.ostrowska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Eric Joyner <eric.joyner@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>
Subject: [iwl-next v2] ice: Check all ice_vsi_rebuild() errors in function
Date: Fri, 14 Jun 2024 11:44:35 +0200
Message-Id: <20240614094435.4777-1-karen.ostrowska@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Joyner <eric.joyner@intel.com>

Check the return value from ice_vsi_rebuild() and prevent the usage of
incorrectly configured VSI.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
---
On v1 there was no goto done line added after ice_vsi_open(vsi).
It's needed to skip printing error message when is on success.

Original patch was introduced as implementation change not because of
fixing something, so I will skip adding here Fixes tag.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7d9a4e856f61..1222e8a175d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4155,15 +4155,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
 	/* set for the next time the netdev is started */
 	if (!netif_running(vsi->netdev)) {
-		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		if (err)
+			goto rebuild_err;
 		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
 		goto done;
 	}
 
 	ice_vsi_close(vsi);
-	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	if (err)
+		goto rebuild_err;
+
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
+       goto done;
+
+rebuild_err:
+	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
 done:
 	clear_bit(ICE_CFG_BUSY, pf->state);
 	return err;
-- 
2.39.3


