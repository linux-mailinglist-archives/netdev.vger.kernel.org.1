Return-Path: <netdev+bounces-169497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EBA4437B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C387A3E57
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE521ABC0;
	Tue, 25 Feb 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cj0ul1sR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217F21ABAD
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494873; cv=none; b=FC4Rc7ABPol3keR8OSv+qJ7sbXG2ToxQsjZdPN9LHsGChkTe74w5tXWvKwvaObTI8M53uXyati7o1bNlbIAwxfNLKCztOUhsinFVDEqnhHbV04VyY1qHHfraM2BdKHCo7UYHF6qyuuslvl6q8gUtjWzSiBgF0CaJkyrnU7IL+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494873; c=relaxed/simple;
	bh=GOlnuZsMCeEkaF9DW/p74sS+cbCTA2hqkjHbsiAlfNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/5i92Q2rxkdpjZHzcLZNu+Ef7FMTSpgIG1B2dv/93NELpQ06H/VxsNGqCrhCdjqoHe6O3NzmPv8fW0jOlZJI3CNi+T9xz7FIaL4pyeJ9O9FVJZl+F9n3rNIgzju2UpdN7pEa5PMRi84ppAati6I9jW9PxMeBbipA0uG6QthKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cj0ul1sR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740494871; x=1772030871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GOlnuZsMCeEkaF9DW/p74sS+cbCTA2hqkjHbsiAlfNw=;
  b=Cj0ul1sRSCy/g4EiwftuBQkD1aP8ohG7O2jdZ5z4S8XD4mBFm5wL+t+l
   Aj31F0RN65pfsxk0OZR08RJIueZLyJSRb1XcPxZ9/71Hzww4Qde4ERB+o
   XzI2CKHOs2ik0UYxNF/W6d5c+qaZwx5LmX5jx6kz7zyoprFLMdO/PHXjE
   TUqWjJu6E5wOddYFEwhRJekNp+Nq7nnK6LwfNOiJU/G/1HNyzjt5cN54E
   ZT/sHLRjxjzO0jVdNAs68Y2RJi7g4th9PIg4nMkFxonRmjj2q7zgbyYMe
   sbscKu8L+r7OZyCEUgCI+1j+z8WMYhVPdq6bwOhTDjRs1q4VZRb2KlDdR
   g==;
X-CSE-ConnectionGUID: VcEDL56jR3u5BAZ7vKgVCw==
X-CSE-MsgGUID: BPb3g9S2S/CzIM1e9oHZUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52726744"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52726744"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:47:51 -0800
X-CSE-ConnectionGUID: PbCDNw04STqSU6KyEZRFHw==
X-CSE-MsgGUID: FOeA6XzKTl6CfEDKDeK1Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="139649337"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2025 06:47:48 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v5] ixgbe: add support for thermal sensor event reception
Date: Tue, 25 Feb 2025 15:33:55 +0100
Message-Id: <20250225143355.190469-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 NICs unlike the previous devices utilising ixgbe driver
are notified in the case of overheating by the FW ACI event.

In event of overheat when threshold is exceeded, FW suspends all
traffic and sends overtemp event to the driver. Then driver
logs appropriate message and disables the adapter instance.
The card remains in that state until the platform is rebooted.

This approach is a solution to the fact current version of the
E610 FW doesn't support reading thermal sensor data by the
SW. So give to user at least any info that overtemp event
has occurred, without interface disappearing from the OS
without any note.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2,3,4 : commit msg tweaks
v5: use ixgbe_down()
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20c9a30..41809dd02aff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3185,6 +3185,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 		case ixgbe_aci_opc_get_link_status:
 			ixgbe_handle_link_status_event(adapter, &event);
 			break;
+		case ixgbe_aci_opc_temp_tca_event:
+			e_crit(drv, "%s\n", ixgbe_overheat_msg);
+			ixgbe_down(adapter);
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


