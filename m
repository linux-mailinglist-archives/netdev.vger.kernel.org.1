Return-Path: <netdev+bounces-107821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2139391C72C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8201F2680E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD913A259;
	Fri, 28 Jun 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt9S9hMf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2A77F2F
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605626; cv=none; b=evMGxxeeri4Ob+hV3yYRSCtt2OZ5QHVsV7QoIKwuHc9mbKz6oW2BYRUpPOzriYERkC0J9dDC1/ZRkmOnW9gk0LcYXRS//9tTVBNmb9wWWcmR+LhrCR4tED/r65REBVzycu6eO0mMkTZF8Ko0hwvk1MH51dUJZwTRhJ+yEDJpoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605626; c=relaxed/simple;
	bh=HvMKm6+qqdgC0Tnafr08dBAYjUwYVKrZJ9VuYKZxaZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owNdz98BOEDSnUt2dVpFSMbE1MAzreR9nnJcwcI+1nJA5iJ/q/XyNtNhQKiPNamZDXydMBDYr5TF0+xi7amSJwSLhL5QmXhmqnGaqGetEd4FFe0ifMyOFb/fEoVxNVvAS1HPlt9BBx3Az+0x7aNkdrB/zvwj5m3j8KUGzmmO5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt9S9hMf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605625; x=1751141625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvMKm6+qqdgC0Tnafr08dBAYjUwYVKrZJ9VuYKZxaZA=;
  b=Tt9S9hMfoGUG1vHt5xHNL8ZTNJ1nl1JY6DN/n8Rc8cVhEh59Izr92F0a
   GJqVkOyOdtFXuKzqvj0k5zbyPobsNRoNQEiLSlqenxOhVJXO73rWJpJ7W
   4LR+pRPiKZ4iihf7UsclPsDtmWOZmiF89vTOhq8lljUtncEuKl3viz8AE
   fsvyFcB8fFKpnf+UZFrcqRb6TkTXWnH5MLtG+Mg+YS9CSNrcX4uqC35Uz
   fsZHnm5XmfxqIPjeH0d74pCaZeZh5SBdHuBLY2clW35DglHxuCqFPaEzd
   Ae44lVNd/iJpe3Ym5sRlKF4byL6fRAcU9vdPckrg/4eOBDuhzMhSZtKD+
   A==;
X-CSE-ConnectionGUID: wFvvowknTLy9+AsImeLBdg==
X-CSE-MsgGUID: huC0dEgFTMaeLaguKdroqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674913"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674913"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:42 -0700
X-CSE-ConnectionGUID: Dytd2mLtQRW73fY6rsAjeQ==
X-CSE-MsgGUID: 8cmceQzDT0ef0HjvqwnkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735529"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Eric Joyner <eric.joyner@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/6] ice: Check all ice_vsi_rebuild() errors in function
Date: Fri, 28 Jun 2024 13:13:21 -0700
Message-ID: <20240628201328.2738672-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 080efb7473aa..f4a39016a675 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4158,13 +4158,17 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
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
 
 	ice_for_each_traffic_class(i) {
 		if (vsi->tc_cfg.ena_tc & BIT(i))
@@ -4175,6 +4179,11 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 	}
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
+	goto done;
+
+rebuild_err:
+	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n",
+		err);
 done:
 	clear_bit(ICE_CFG_BUSY, pf->state);
 	return err;
-- 
2.41.0


