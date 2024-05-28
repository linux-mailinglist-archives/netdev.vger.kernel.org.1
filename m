Return-Path: <netdev+bounces-98434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35DD8D16B4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BF91C21CBA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02138DE9;
	Tue, 28 May 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtZlbccT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087A2837F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886518; cv=none; b=WCCq0Ez3SeTIqrnDAcIlXqCpm9GPmAcVl9oPaJvNV/2vEgZ4TV1dys04Vc1i6+tNyF6SSlGodq7m+h97Y5AK4QfWXs3mSWYqEtAKBRAw1IzGwUB5HqbgWlrUV0yAKdglWejhzpXt7OjvGr/7g6y1qrjRsui+TbEz9vKisPmnDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886518; c=relaxed/simple;
	bh=/1gxvBhZO8hqCSsJ3sdBoq25DbXK+euP71L0GIG1il4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yc4IwofP6ozFJ7RWZMNUF0fFAJnPc838CP976GxKMtTdJ47UlNsKMAJyzP/Fw6bpT8QA61juAuwS2eXLzVnp3o4VwPfuQAjJClu3P1IxANkMLXR+wW37dDIHp6oDU1cEOHmp2mPcsh5sPYKfejG+4VNL149Ztoa6jUZHXNwidwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtZlbccT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716886517; x=1748422517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1gxvBhZO8hqCSsJ3sdBoq25DbXK+euP71L0GIG1il4=;
  b=UtZlbccTQ3lce3RqAFrBGMfC0tsIbkZkxllumJEYa0RPK49Jk8aU45zh
   IDQ36BiwS6fJTb44NNAA6bmBT8dxm2sKDQ/G4Pg2WGlKeuh41D3dyNgcu
   SJH+MMgp/gHETxhBS3v5LPOQH6lE7UqsP7FOkAXb915RBUI3hVT7+fF96
   6KjcWdua54n9amgpHdt30t1zoCFDKPJZmDJkBcEHesSmRa1JJtEmo8tn1
   PWMZRX24Dyj0+guYQrWI2xj9dFc3iPt8MwOGGBtIEVVuHuu7KtnIaBPq3
   iPI4YF/BqQH2EpngVR/vMV8ZgQKo6Azkqoxn7ateU2iTnKfG3lg1hQc/q
   Q==;
X-CSE-ConnectionGUID: NlZOBswlRFGFINkgiLK/Ng==
X-CSE-MsgGUID: WHAWjCimQj6mx7LYJvB9cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24346109"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="24346109"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:55:17 -0700
X-CSE-ConnectionGUID: fYaUiNSNStWUVcNGebfeBQ==
X-CSE-MsgGUID: DyIzkEViSByE2Xd4Vey8nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39827217"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.123.220.50])
  by orviesa005.jf.intel.com with ESMTP; 28 May 2024 01:55:14 -0700
From: Karen Ostrowska <karen.ostrowska@intel.com>
To: karen.ostrowska@intel.com
Cc: Eric Joyner <eric.joyner@intel.com>,
	netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in function
Date: Tue, 28 May 2024 10:52:12 +0200
Message-Id: <20240528085212.220000-1-karen.ostrowska@intel.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..e8c30b1730a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4135,15 +4135,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
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
+
+rebuild_err:
+	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
 done:
 	clear_bit(ICE_CFG_BUSY, pf->state);
 	return err;
-- 
2.31.1


