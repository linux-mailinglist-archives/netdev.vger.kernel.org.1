Return-Path: <netdev+bounces-168321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD3A3E82C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA77817F934
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C79264616;
	Thu, 20 Feb 2025 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBBc8wm7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1F1F4E3B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093343; cv=none; b=NHNXkaNIWh5wnut9kJbGV4Ch22v5FdRjrncO6oWwN+zEHvHna57mo9Tm1TOESwaquC/3/mHqJhFn4fIcL97yQPqxPU6TAGaD2IuIV/wTYaGl2ma4iRU8mJO9D2rY8qyE+fk5wbOSpsrU5SWKxMuPHn0fXO7Qgt6/jh9UOFv1YoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093343; c=relaxed/simple;
	bh=xiF91DRXq61q4vpXvNa8LutOEIEBtwUAL8JN8LXZTXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SpREHMZQck1YLsGmEn8XDlm2fbbT5HitGiLaWeR6Cv3dORCvM9EwFgnYF95nV8fcrXxyAdfumCn+naQXo1cGcv0PYnZISQQcQ2L0KkNdVeSKL+f7k8YTjGRMOhvqI3jU1YUQPpAiAK6/fRoIsCQmYur99ooHLyDfiyh/nsd0jDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBBc8wm7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740093342; x=1771629342;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=xiF91DRXq61q4vpXvNa8LutOEIEBtwUAL8JN8LXZTXk=;
  b=LBBc8wm7czwHNbj9jTuIICH42hkIvePYRL3Qal8SZj8Mjau2QFDqXXok
   dBgTSN+Th0RDS+KyC8Kh64MsqeROJOIUTqHHio2k6HAfkL8VCCB9We5L9
   CXBZvzmh+sBJxezJLnj3ooI7d0awXxefne1i2fWES4aXobWNbXIu9Z587
   Ith4Cs+4ILFyjmqteZqNbSO0oGK41p+rJ/ZGa9IWvJzH06c+DWikDW6gg
   et1+pK2zcwHCe+SJs0/oU2vS0nHsjl0pVCqF+FuH1uPVskkaj/WaMxcX9
   AQYtsY3EOPNJp65Ei6MvWLcSVun1fpLZJlihiWMT3OSLoWz4A2+E8W06C
   Q==;
X-CSE-ConnectionGUID: sHM2ZDRwQ9Wbo2bvu6+fOw==
X-CSE-MsgGUID: g/erfG2hTLSdVjCkCSmwvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40085530"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40085530"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 15:15:41 -0800
X-CSE-ConnectionGUID: /c0sQfnlRbm3QgPZGJ8AZg==
X-CSE-MsgGUID: DgwZGjsuQzS88LsfEB+oFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120306173"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 15:15:41 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 20 Feb 2025 15:15:24 -0800
Subject: [PATCH iwl-net v2] ice: fix Get Tx Topology AQ command error on
 E830
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-jk-e830-ddp-loading-fix-v2-1-7c9663a442c1@intel.com>
X-B4-Tracking: v=1; b=H4sIAIu3t2cC/4WNQQ6CMBBFr2Jm7ZhSIVRX3sOwKJ0BRrElLUEN4
 e42XMDl/y///RUSR+EE18MKkRdJEnwO+ngAN1jfMwrlDFrpSunC4OOJbM4KiSYcgyXxPXbywQt
 31FLndK0s5PUUOde7+Q7yHtHzDE0Gg6Q5xO/+uBQ7/itfCiywrMkZNlTatrqJn3k8ufCCZtu2H
 7kZeV3HAAAA
X-Change-ID: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Paul Greenwalt <paul.greenwalt@intel.com>

The Get Tx Topology AQ command (opcode 0x0418) has different read flag
requriements depending on the hardware/firmware. For E810, E822, and E823
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
---
Changes in v2:
- Update commit message to include the warning users see
- Rework code to set the flag for E810 and E822 instead of to *not* set it
  for E825-C and E830. We anticipate that future hardware and firmware
  versions will behave like E830.
- Link to v1: https://lore.kernel.org/r/20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 03988be03729b76e96188864896527060c8c4d5b..59323c019544fc1f75dcb8a5d31e0b0c82932fe1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
 			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
 					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
 
-		if (ice_is_e825c(hw))
-			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 	} else {
 		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
 		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
-	}
 
-	if (!ice_is_e825c(hw))
-		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		if (hw->mac_type == ICE_MAC_E810 ||
+		    hw->mac_type == ICE_MAC_GENERIC)
+			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+	}
 
 	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
 	if (status)

---
base-commit: 992ee3ed6e9fdd0be83a7daa5ff738e3cf86047f
change-id: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


