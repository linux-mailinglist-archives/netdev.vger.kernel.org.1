Return-Path: <netdev+bounces-116628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61C94B371
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E4B21F05
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC9155CBD;
	Wed,  7 Aug 2024 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BA91iDZy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F35155A21
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072419; cv=none; b=At0AUmTiR9WyomAzPho2WFbds8/wlAouIO5O97NOfVKQ49qsFtVbiVdeZ7cCqjfN3ab1Cc4Nh0zt0hpdwMOcOVZwTKhCpPnAq2kDPsIRGBFchkqXU5IP4iPonfxc/V9FsiKXaUQtVdyWONxmYiOVUR0PF9jKSD/Vy9EYFtF2oZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072419; c=relaxed/simple;
	bh=+sgRE3ATJn+TS8TiBRcbN9sQCHaISZPkexzHT2Sa89Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNDEar2MvAWbiRW0pYr5TJIiFshvqUIlMa2rGADMGL4ujT5FrVfQKA1i/6Cr2yhOGVZUPdekBC9rL9A017A075UXJj2E41VjGX7MOqi7azcZqysfJLhji+LSM7Y07Nrc4ARWqzdZ6+HFbCtAx8gm1CItl8RdR6GZPsfNob5rNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BA91iDZy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072418; x=1754608418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+sgRE3ATJn+TS8TiBRcbN9sQCHaISZPkexzHT2Sa89Y=;
  b=BA91iDZydrKCf1yMXnxvs2LHUlLLYLAHgKslz8LxLkjpozb3dis572nS
   8ej6vs6Ao3rU7kdEED7Cagu60kLZHu0WmUqQqiob+M5TwkTzu/jjK9GFd
   ouS7R+X+cnIevHL6A0qgnnEq6frY5vyNSzZOYRBc5zt0XrvH+tsESknnW
   ASAWd40dbQauEHnR0CCenl4PqLefn6EcazoELG0g54PTo81ljiEq6gYb2
   Y7T4SAWuja4sBhN/pJdWpPQBbODSAwEhu7cgLK1Juu4PVCobY10njxjbX
   sjzSx4PiMGF4FwnsRDZslu+8bCNHNSUcjU8OVpYukUluQ4Wpab7s+taW5
   g==;
X-CSE-ConnectionGUID: 8/uhVFuJRrmYcDw8CA8UuQ==
X-CSE-MsgGUID: R/k56QpvQ0CHT3MDh0zxRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577313"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:13:34 -0700
X-CSE-ConnectionGUID: FtMIhrW1T0yNHB7F7FGZ5A==
X-CSE-MsgGUID: EFq5rzRIRYWTOtvnBJJYZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61956625"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 16:13:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 3/4] igc: Fix reset adapter logics when tx mode change
Date: Wed,  7 Aug 2024 16:13:27 -0700
Message-ID: <20240807231329.3827092-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
References: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Following the "igc: Fix TX Hang issue when QBV Gate is close" changes,
remaining issues with the reset adapter logic in igc_tsn_offload_apply()
have been observed:

1. The reset adapter logics for i225 and i226 differ, although they should
   be the same according to the guidelines in I225/6 HW Design Section
   7.5.2.1 on software initialization during tx mode changes.
2. The i225 resets adapter every time, even though tx mode doesn't change.
   This occurs solely based on the condition  igc_is_device_id_i225() when
   calling schedule_work().
3. i226 doesn't reset adapter for tsn->legacy tx mode changes. It only
   resets adapter for legacy->tsn tx mode transitions.
4. qbv_count introduced in the patch is actually not needed; in this
   context, a non-zero value of qbv_count is used to indicate if tx mode
   was unconditionally set to tsn in igc_tsn_enable_offload(). This could
   be replaced by checking the existing register
   IGC_TQAVCTRL_TRANSMIT_MODE_TSN bit.

This patch resolves all issues and enters schedule_work() to reset the
adapter only when changing tx mode. It also removes reliance on qbv_count.

qbv_count field will be removed in a future patch.

Test ran:

1. Verify reset adapter behaviour in i225/6:
   a) Enrol a new GCL
      Reset adapter observed (tx mode change legacy->tsn)
   b) Enrol a new GCL without deleting qdisc
      No reset adapter observed (tx mode remain tsn->tsn)
   c) Delete qdisc
      Reset adapter observed (tx mode change tsn->legacy)

2. Tested scenario from "igc: Fix TX Hang issue when QBV Gate is closed"
   to confirm it remains resolved.

Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 8ed7b965484d..ada751430517 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -49,6 +49,13 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	return new_flags;
 }
 
+static bool igc_tsn_is_tx_mode_in_tsn(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	return !!(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);
+}
+
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -365,15 +372,22 @@ int igc_tsn_reset(struct igc_adapter *adapter)
 	return err;
 }
 
-int igc_tsn_offload_apply(struct igc_adapter *adapter)
+static bool igc_tsn_will_tx_mode_change(struct igc_adapter *adapter)
 {
-	struct igc_hw *hw = &adapter->hw;
+	bool any_tsn_enabled = !!(igc_tsn_new_flags(adapter) &
+				  IGC_FLAG_TSN_ANY_ENABLED);
+
+	return (any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
+	       (!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter));
+}
 
-	/* Per I225/6 HW Design Section 7.5.2.1, transmit mode
-	 * cannot be changed dynamically. Require reset the adapter.
+int igc_tsn_offload_apply(struct igc_adapter *adapter)
+{
+	/* Per I225/6 HW Design Section 7.5.2.1 guideline, if tx mode change
+	 * from legacy->tsn or tsn->legacy, then reset adapter is needed.
 	 */
 	if (netif_running(adapter->netdev) &&
-	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
+	    igc_tsn_will_tx_mode_change(adapter)) {
 		schedule_work(&adapter->reset_task);
 		return 0;
 	}
-- 
2.42.0


