Return-Path: <netdev+bounces-156489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868EAA0681A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1E73A6DDF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF5204F9D;
	Wed,  8 Jan 2025 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm2TUp3D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BA204F79
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374692; cv=none; b=odZaNedCYyC4eLY68NvvCOTojffW+V5JeWCXYxmMo2pw41ymHY5cel8jjidHyndGzDdc5/THwkdgTEtRmHL4ckyHXrQ0WraObtvvrnj4G9avNs+IIY/16Bf/7kWmkD2JfQpG7sZROin3dKN239RVZg51zMVwtYw/QixEaJ7aA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374692; c=relaxed/simple;
	bh=Gm0/e2sXWo29BQVw9wrEZZYawSSD/tU8ilCKR8gzbMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1Np2lYqUk8eMEwU7ZAj9UgfStYlEDz+56BWzupTIl4R7zR9TIQ7HspFibw2sVGzYis6kt1a3byCujeSWFULhrNQDFcjZMlPC7iTDgQJ6FEPdAytAaiSFLCDp/qT0GKX2N4oQwNyFWi/xm7gaj2JrB0jJLbPtUrA4s0Hw7OjY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm2TUp3D; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374690; x=1767910690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gm0/e2sXWo29BQVw9wrEZZYawSSD/tU8ilCKR8gzbMc=;
  b=Xm2TUp3DRoEyfGfwGZLjHzLLWpM8qtJ3uoZg5sW2gnHs2Gah+FFwieJ8
   C8XZLr/Zqsd7qpPJxsPHcqav+kX9caM5RKhAqdNpk7qWLvV966bCUGJeN
   NVPHx0sZc24nUoJW96VabbqXqpU02s6rCnAW4MG7QoM/xgtJTY0kRqBL9
   YGipAp7r9DstFULWNtCVQxQs6vK8OEUH4xtlQgDwkIAq8phoVtslH5saW
   HBNXueN3hpWho9DlCXdzMI6DV/UWP0CahnnbGuKRX1wc1CciD7h0kdj9S
   9VFk04PZVZMs5QQqg50L8/57Y2jWIjpT82sNxtpknnJlwcxXH8Z7jB2ER
   A==;
X-CSE-ConnectionGUID: 7a8MYLKTS8C0xBW2bst+jA==
X-CSE-MsgGUID: uMcgIWH6Ruu7/jIrF+48lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384706"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384706"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:04 -0800
X-CSE-ConnectionGUID: THNCLvfLSMOW+PnA4O9i9g==
X-CSE-MsgGUID: iN1DuRZ2TTywxMNBq6Er4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545140"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:04 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	anton.nadezhdin@intel.com,
	przemyslaw.kitszel@intel.com,
	milena.olech@intel.com,
	arkadiusz.kubalewski@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 11/13] ice: check low latency PHY timer update firmware capability
Date: Wed,  8 Jan 2025 14:17:48 -0800
Message-ID: <20250108221753.2055987-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Newer versions of firmware support programming the PHY timer via the low
latency interface exposed over REG_LL_PROXY_L and REG_LL_PROXY_H. Add
support for checking the device capabilities for this feature.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 +++
 drivers/net/ethernet/intel/ice/ice_type.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7af169466655..9d143c6803f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2641,6 +2641,7 @@ ice_parse_1588_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 
 	info->ts_ll_read = ((number & ICE_TS_LL_TX_TS_READ_M) != 0);
 	info->ts_ll_int_read = ((number & ICE_TS_LL_TX_TS_INT_READ_M) != 0);
+	info->ll_phy_tmr_update = ((number & ICE_TS_LL_PHY_TMR_UPDATE_M) != 0);
 
 	info->ena_ports = logical_id;
 	info->tmr_own_map = phys_id;
@@ -2663,6 +2664,8 @@ ice_parse_1588_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 		  info->ts_ll_read);
 	ice_debug(hw, ICE_DBG_INIT, "dev caps: ts_ll_int_read = %u\n",
 		  info->ts_ll_int_read);
+	ice_debug(hw, ICE_DBG_INIT, "dev caps: ll_phy_tmr_update = %u\n",
+		  info->ll_phy_tmr_update);
 	ice_debug(hw, ICE_DBG_INIT, "dev caps: ieee_1588 ena_ports = %u\n",
 		  info->ena_ports);
 	ice_debug(hw, ICE_DBG_INIT, "dev caps: tmr_own_map = %u\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index d01a9e798678..f5eac66d207e 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -369,6 +369,7 @@ struct ice_ts_func_info {
 #define ICE_TS_TMR1_ENA_M		BIT(26)
 #define ICE_TS_LL_TX_TS_READ_M		BIT(28)
 #define ICE_TS_LL_TX_TS_INT_READ_M	BIT(29)
+#define ICE_TS_LL_PHY_TMR_UPDATE_M	BIT(30)
 
 struct ice_ts_dev_info {
 	/* Device specific info */
@@ -383,6 +384,7 @@ struct ice_ts_dev_info {
 	u8 tmr1_ena;
 	u8 ts_ll_read;
 	u8 ts_ll_int_read;
+	u8 ll_phy_tmr_update;
 };
 
 #define ICE_NAC_TOPO_PRIMARY_M	BIT(0)
-- 
2.47.1


