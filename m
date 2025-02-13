Return-Path: <netdev+bounces-165871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00966A3396B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721327A0FEA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2C20AF80;
	Thu, 13 Feb 2025 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+jeldV0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAB20AF68
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433515; cv=none; b=hPvqBYvjyFxUqX37RNFOHeLJI+D/ro7pEnrlxyN1bT6AVB4aiiROIzG0DKnwB2tCAsm3jTbxj9Lgf3lhH625DSuKpTkhx1SPZGkltTfcMB4YpiutVQNdNAENfqIZsd9ihzLVKcrK9GxNcRNn5G1pTMDxgPyVsQbUeMy3Sv5AFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433515; c=relaxed/simple;
	bh=eO714YUOwB1fsBw+kHksu5IyTkPx0gHPMJKL78qm9/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpW1sT6i8DVZzWnI/gPydNfSCjBk0Bl9VkC2rZczITNAas/4QlMCmSCP9X1gPSwH8fgLl6XSOgsQZDiW/33MY6obVYhf5jHaR/Ekk/ZtJLkd4PosoUGaXoSH0NHpa+5vMZ8E2Jh+HuAiDh+esFh8xGZ6rkXavMN+7AIVf8LA+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+jeldV0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739433514; x=1770969514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eO714YUOwB1fsBw+kHksu5IyTkPx0gHPMJKL78qm9/8=;
  b=I+jeldV0Cib+2Wu4m+X58hn2ZrO5HL8o5aZC9uFaqqi3t3tYan5Rev2/
   OpgjFLlYo8U5CxmL52JBvgnUg+np+G9BJAT3O4sz3jNwdsZJViv6Dk3h+
   WIVFD99Iz4UF+nuYNuu4jdq4XNMDHDpcwtAU8jOyB3lvYxVsm5qXwPhur
   GcqrtkR872hV3ixWM03h/8a35UjcLCOwZ/b6F1KROaIjocOzH/BZpFEP7
   kx8fNlkCwaTDlktadPYzMi4geXzpiG+zEmojyi33TJfVl/42j6M7zFOAP
   cJuX3QPUbBp461GoAHtTEJJUWRmNAjWaqS0RkLh4gKxsyht37T2cdSfSm
   w==;
X-CSE-ConnectionGUID: QvmTbEUSSoe78mmmFdfDow==
X-CSE-MsgGUID: nAxgM2FUR42f6uNnIVLH6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39986405"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39986405"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:58:34 -0800
X-CSE-ConnectionGUID: iBRmOTwyQCGy6LYpbhKGuQ==
X-CSE-MsgGUID: VcGsciHLQsmNiuOLlqf80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118068872"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa004.jf.intel.com with ESMTP; 12 Feb 2025 23:58:32 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4] ixgbe: add support for thermal sensor event reception
Date: Thu, 13 Feb 2025 08:44:52 +0100
Message-Id: <20250213074452.95862-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 NICs unlike the previous devices utilizing ixgbe driver
are notified in the case of overheating by the FW ACI event.

In event of overheat when threshold is exceeded, FW suspends all
traffic and sends overtemp event to the driver. Then driver
logs appropriate message and closes the adapter instance.
The card remains in that state until the platform is rebooted.

This approach is a solution to the fact current version of the
E610 FW doesn't support reading thermal sensor data by the
SW. So give to user at least any info that overtemp event
has occurred, without interface disappearing from the OS
without any note.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2,3,4 : commit msg tweaks
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20c9a30..5c804948dd1f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3165,6 +3165,7 @@ static void ixgbe_aci_event_cleanup(struct ixgbe_aci_event *event)
 static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_aci_event event __cleanup(ixgbe_aci_event_cleanup);
+	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
 	bool pending = false;
 	int err;
@@ -3185,6 +3186,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 		case ixgbe_aci_opc_get_link_status:
 			ixgbe_handle_link_status_event(adapter, &event);
 			break;
+		case ixgbe_aci_opc_temp_tca_event:
+			e_crit(drv, "%s\n", ixgbe_overheat_msg);
+			ixgbe_close(netdev);
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 8d06ade3c7cd..617e07878e4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
 	ixgbe_aci_opc_done_alt_write			= 0x0904,
 	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
 
+	/* TCA Events */
+	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
+
 	/* debug commands */
 	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,
 
-- 
2.31.1


