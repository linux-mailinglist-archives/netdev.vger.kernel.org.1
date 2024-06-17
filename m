Return-Path: <netdev+bounces-104017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFB90AE31
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24F91F23793
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEF19754E;
	Mon, 17 Jun 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SItUZnN6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95332186294
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628590; cv=none; b=LLZiCdomcqxLEKfbf5riG8yyq4WI7k6pzZefdoZdKaXTZ9hQxtH236xDE75kj/yEkhWgK9VqrIVoU3apu6BRNEWWMj+2IJuN+cQd/qrlKqVlqmpcrGtzsVvYrrccvBNdablHBarnDE/jc8VVZ9e4lk8CiSDJ7gcvbyMhGAXvjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628590; c=relaxed/simple;
	bh=qh4B/NZTCQDCB5Wj1zIZd8CB8clsHUvOTAJ+ZTj5yjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMeYSZYpgNQAmQxL+h++aGM4R54Br0tVh23oK8SA3MB6L7tm1vEfVasOLjHhuhkBiiUEACgs+e92dfIC0i985usrlnwHLHSz/PP11ZqBBIS7vzQg6HvudxjJXmvYj4YQ31rUWPiur3oNsp2gX2B8TrldeEgAeqFkSICsB9a2edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SItUZnN6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628589; x=1750164589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qh4B/NZTCQDCB5Wj1zIZd8CB8clsHUvOTAJ+ZTj5yjA=;
  b=SItUZnN60PcnFnIQRSahJa3M6H+nVecqDThZN/hK0KRlHM0fF4Cz7gaS
   bpL1DFtWywMxbaLOowk9qX+mAZcaq+JLD7BNVvLhvl2ee0Fvj3MUi1VoJ
   D9ufEpsKEMcZsZoH7wN7iSt9eZLzQFE5OgBgA54kdIUrGIcvTq237c8dl
   BdeUoE/NR0KOO0eHaVNhYKJZkWDf1pvqi6iumy8nGMiG+uBGmvOMjpu/l
   7rgK2Gm/g39TR79BJ50SRcMNbrV+I2xdXssZzKjufWuLuJg3ZAzx1+h1S
   r2UkH9Z4oX4dGoolFkd0Ly9kIEkTkCREbZitRLG3QYxRURAqk9ayWBYNM
   A==;
X-CSE-ConnectionGUID: qfJlIKd+QuGtzn4qnf2n8w==
X-CSE-MsgGUID: NQt9hSswQ+ql8hyaaeGePw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19274160"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19274160"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:49:48 -0700
X-CSE-ConnectionGUID: 2ndLSbdgTTSyyaJC79CXXw==
X-CSE-MsgGUID: BXN1yGzYS8aRaPFiFBnQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41893533"
Received: from os-delivery.igk.intel.com ([10.123.220.50])
  by orviesa007.jf.intel.com with ESMTP; 17 Jun 2024 05:49:46 -0700
From: Karen Ostrowska <karen.ostrowska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Eric Joyner <eric.joyner@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>
Subject: [iwl-next v3] ice: Check all ice_vsi_rebuild() errors in function
Date: Mon, 17 Jun 2024 14:46:25 +0200
Message-Id: <20240617124625.9816-1-karen.ostrowska@intel.com>
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

On v2 there was wrong contex:
@@ -4155,15 +4155,23 @@ int ice_vsi_recfg_qs( 
and wrong indent.

Original patch was introduced as implementation change not because of
fixing something, so I will skip adding here Fixes tag.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7d9a4e856f61..1222e8a175d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4155,15 +4155,24 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
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
+	goto done;
+
+rebuild_err:
+	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
 done:
 	clear_bit(ICE_CFG_BUSY, pf->state);
 	return err;
-- 
2.39.3


