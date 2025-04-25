Return-Path: <netdev+bounces-186166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90630A9D576
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817A97AE96D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C892918DD;
	Fri, 25 Apr 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqOw4LHo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A7291167
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620009; cv=none; b=BLY7DqxNcPVLwWO/w0HWtYFnCOWwxexbo3Z+ll4UeFmYHTc4EiyCv04jbUiBMKeRzjvJ07oKOccDd20mBKpu96sr2VeRUXzEnv7v1Z3Y+oAqxCODrZwlBG5f7cSQXMUCMOr0uPeR42Q4xMo8lJDTmrYMSMoer3ZZi4cVa/U3DNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620009; c=relaxed/simple;
	bh=WkqW5FqHwl4jVkTZxzZ9EcVEXj4zvs2EXF+FGAxJquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChNLV0yChZ13j1jJ1a00l/z6ppgFcm3iAo/DiGchbzM3Jzq78mZrGHjsry3pCNfDjI1QGtitkU32zXpGmi778v8e0xtc/UL+jrm1MGTzM5rVuz/II1sqZKW852HXstBZsnw9zVGTN/63xvONZzW9WFx1cHD36WRIxChpBmE+Y8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqOw4LHo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745620007; x=1777156007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkqW5FqHwl4jVkTZxzZ9EcVEXj4zvs2EXF+FGAxJquU=;
  b=dqOw4LHoUkPk/l0j6aBV4uc+lTa3fPlE/Ct83uyI3Er+tQF2Jb0uZGsd
   ctwqKKKWH6gN07iVBdeOlbUUGmznEcHFrolIeeIOVWe57dWnboZGcJB8z
   NTt18phxpaL3vNP3WeExXjDyl2Y6ps7oXhEVTp9/4UG9XKR4ZzRChLoYK
   wQvxbtjoync6zS0KJ+K9WzYB+M8MPeoStcbIYRNK0O0anJioHsmcuIHco
   UEsX9YfCLe3XW3NnpCfDWPXNZX7abL1/9zsXjNbcgtczTZcgGFc4EKYfP
   vJy8bk0hc9yP3Ll7t3x4+xmwr4+qF+e4ZT15BlhCQFCfDo3lq1s79SBIZ
   g==;
X-CSE-ConnectionGUID: owHtR3MCSrWDRa7ToUFhMg==
X-CSE-MsgGUID: WEcd5XQ7TZKvqZpVzMSvig==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="50961374"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="50961374"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:26:45 -0700
X-CSE-ConnectionGUID: x8oCzDp7SzKkis7NUd8TNQ==
X-CSE-MsgGUID: VUla89miR3ahDjnnKub/WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133533700"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Apr 2025 15:26:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net v2 1/3] ice: fix Get Tx Topology AQ command error on E830
Date: Fri, 25 Apr 2025 15:26:31 -0700
Message-ID: <20250425222636.3188441-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
References: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

The Get Tx Topology AQ command (opcode 0x0418) has different read flag
requirements depending on the hardware/firmware. For E810, E822, and E823
firmware the read flag must be set, and for newer hardware (E825 and E830)
it must not be set.

This results in failure to configure Tx topology and the following warning
message during probe:

  DDP package does not support Tx scheduling layers switching feature -
  please update to the latest DDP package and try again

The current implementation only handles E825-C but not E830. It is
confusing as we first check ice_is_e825c() and then set the flag in the set
case. Finally, we check ice_is_e825c() again and set the flag for all other
hardware in both the set and get case.

Instead, notice that we always need the read flag for set, but only need
the read flag for get on E810, E822, and E823 firmware. Fix the logic to
check the MAC type and set the read flag in get only on the older devices
which require it.

Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 69d5b1a28491..59323c019544 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
 			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
 					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
 
-		if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
-			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 	} else {
 		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
 		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
-	}
 
-	if (hw->mac_type != ICE_MAC_GENERIC_3K_E825)
-		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		if (hw->mac_type == ICE_MAC_E810 ||
+		    hw->mac_type == ICE_MAC_GENERIC)
+			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+	}
 
 	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
 	if (status)
-- 
2.47.1


