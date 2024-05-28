Return-Path: <netdev+bounces-98437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E420C8D16D5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97514284F3F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E613C900;
	Tue, 28 May 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyCNLRsL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB14F1F2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887099; cv=none; b=Y79UTGG2pNQE1U0l+zRNvM/8GInT2/4pxndsDVfj9fonR/J36ZG0z9Dn84MbTRJLGid7d8GZrvrThd2Bt+BO3Jq185UV4Tpejey0JnxMMtYVbm6MxwwaLPlC9ztLPRR9r9CQh/1jU4oXPlrfXanPAraiZJ8zS6bPHv8TigzH2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887099; c=relaxed/simple;
	bh=/1gxvBhZO8hqCSsJ3sdBoq25DbXK+euP71L0GIG1il4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdY/gxWwZt2aOsEFZdDYv8ZVKZADHS37gHhg7q2MShSX71Ng4PFYGOUWra1PGc52a8IVqAcBTX8AOT5QM3c/eHAxB+SyVbR1Pr6t/39n4TeqN/3STd2aeW3/HJSeIj37oqMcHDxAvh7BerPAMUGbJ6YXvOFLw+/6NHp5KdIsrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyCNLRsL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716887097; x=1748423097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1gxvBhZO8hqCSsJ3sdBoq25DbXK+euP71L0GIG1il4=;
  b=kyCNLRsL5g7P0d7wdGvrPf9md3goSfHhNEaf8VOyTiNcw5pkZupiTpsf
   xh8ziSZ6YqNwJAt61YIzL5GWcjz9/Sp68I6yXbMcRt/ufW+9IBHzmtRRG
   iaTuvesnt6GJdJ52pLwXaASELsuuSzPFQ5FLqs4a+oONsAbacyFUtKbUz
   vd0yPsbgFY/dPDbfzOhTxhwgkZ9Cl+Z+1hLuLMZnZbr2p+AqDxEBhfx6E
   ONtYwh8K2w3PiDVbKOTaHikmJKv5o/u/pJeSPDZE2MI5AEX/qAWqfNLaN
   7LI9bnpPX/1fEmdkvHbyCnPfcWy5sJCf4uCD/fakudWiAztIdQ79VKrFt
   A==;
X-CSE-ConnectionGUID: 998X47E9REyGQP25dLXBpA==
X-CSE-MsgGUID: TU7SUWTaT0Kso+KD9uZj0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13405976"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13405976"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:04:44 -0700
X-CSE-ConnectionGUID: +2CEXDd7Tby+oO7Rz+30BA==
X-CSE-MsgGUID: eBnM9h1TRMyluxICWU2dHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39538382"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.123.220.50])
  by fmviesa004.fm.intel.com with ESMTP; 28 May 2024 02:04:43 -0700
From: Karen Ostrowska <karen.ostrowska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Eric Joyner <eric.joyner@intel.com>,
	netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>
Subject: [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in function
Date: Tue, 28 May 2024 11:01:40 +0200
Message-Id: <20240528090140.221964-1-karen.ostrowska@intel.com>
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


