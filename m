Return-Path: <netdev+bounces-184892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBE1A979B2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19723AABB5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544A27056C;
	Tue, 22 Apr 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMW1KDDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6826C388
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358514; cv=none; b=bmrIRR3vL18Q0hPZsPLqYtRnGiac5s1SdQe+CsTLJba0oQprJps5xprfU8wrSSvsY0O6pVxpLCnvtLZ2k9e3J/wdq3kddClmZNRUOKsxK3MOFySFTM5PZggWAqd+ObIFjxMPNt9CAtzQE8l1q3BX5QTUnzT4DYab8vp8/gUvIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358514; c=relaxed/simple;
	bh=WkqW5FqHwl4jVkTZxzZ9EcVEXj4zvs2EXF+FGAxJquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyal47Pc7hcTW/qFntknw6jxrPHnyhm2GPAZWmNRxaYcQzNbS+24Wd/93DC2vdd7D03DXoyRKGTt5fXGPFBJXm/yLk2OVxpEHZkCv6ubuRpAfXSGF4aoQCehI6HJ22d/h8Y/Aj/cJF8gSP9MH7iWg1IxQUaN1NIe0FwjLMA+PFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMW1KDDC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745358513; x=1776894513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkqW5FqHwl4jVkTZxzZ9EcVEXj4zvs2EXF+FGAxJquU=;
  b=iMW1KDDC+Izu4U1q92Dow9Oy3sPDs8IJ0uJmvYht7VdgwAiDJemXcQy4
   L4RK6NCLs8oqCX2sAY1VBGl5ATpiRNsdF8EWB5lkqxVMc1LPYr92uxuTV
   UjYbHX3P37WMDhORip3xvvwny6byGxs8ZybAiFKlhGIYl1NOKJUA6V5C5
   GbZUn54bAVum/El8RV1R74IqCx+G9Jybj5+vASrEMgkGseuhYR3V593h7
   xjesQKhhkDyQutBVjwlJwNZ8MKMubnxidWdNwJQIM60LBvfsXDwxYl6XE
   H3Exo8WzXknheTyNBBCPJO+NBAXXX7gGhbC3bia1nki62z4QWOjx+U6Xm
   Q==;
X-CSE-ConnectionGUID: veZySgwhSN2spNVGQU3Jmg==
X-CSE-MsgGUID: qTzl0qjJQVK3T2BJbPyY2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46949132"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46949132"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 14:48:32 -0700
X-CSE-ConnectionGUID: IKv2No8hQ2SBFuZ6K9qivQ==
X-CSE-MsgGUID: SuYGckxBTUSD8Z7Ibd1DQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="163186550"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 22 Apr 2025 14:48:31 -0700
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
Subject: [PATCH net 1/3] ice: fix Get Tx Topology AQ command error on E830
Date: Tue, 22 Apr 2025 14:48:05 -0700
Message-ID: <20250422214822.882674-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
References: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
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


