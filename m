Return-Path: <netdev+bounces-190657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FC0AB821C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493AE16A8A1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8728C5B5;
	Thu, 15 May 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c77C3eXm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C21F12E9
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300270; cv=none; b=QOb919bHKDswCr58xlXrgvtM8xPHVEd23exa52tuCCLWUqMGEoJOLSkIID5iiwm1TzUOF/djk3IbdP6eY0GrQfMv27l3BnCPYDUwZ7EWaHnVnIeEC20Mwhq0hSjNdwLzoknnFNmWIa9RPtHI4CQOWLKQXNWHgo5yK+yhQaXvNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300270; c=relaxed/simple;
	bh=o6OPIoyu9QkxYm6yRHM9Xg6p7JlrMMdaPIDa5I4vtCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRfaHVS61wrCZKABqHwyCHV56Cf9hb41JTUAZ5C22xR0eo+11gdu3lgn8IQ6ka72SWTVGkV4ySOzDiBIoR43yZ8Ps7JPOmkCY9BQDp5p+HHkqQY/BoS135h+jbtvgC6meQU/HeRuG/ZdeOynyt44hDUHi/GICzKRpl4I0eHjLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c77C3eXm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747300269; x=1778836269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6OPIoyu9QkxYm6yRHM9Xg6p7JlrMMdaPIDa5I4vtCY=;
  b=c77C3eXmZd5oY8Y89m5os4r5sx08jv2JwO/Rp1myVDURQ46ssjy90+5x
   zSCc4f4HYJIicnjr7FcfVRUDqXxU7D3oQzKMT+uKq9HImZ20zhh2Ppylz
   w1JBlJqw1O7tSEuDZQH+k9pndT21qg4HfcPAS9MyQkGu/cKWFtV2zsZpF
   CgNEY/7Mf79zB/Nsr3pUHigVrk/l9xcDLwqiVN/byyQIGDiPa8KMb/xlF
   Cr3HUhNudPwpGZgVhVlUOgT5ypYquaIDRwIb5iJoYiGhvvbca+eOBQ1Kd
   ni71ix781jdG9GlWWlquKPXBk/KZR7tMvbpgLK5WTbOZ/IZeRW4wa1tht
   w==;
X-CSE-ConnectionGUID: 26YH0H5sQW6M6yh+tRytpA==
X-CSE-MsgGUID: FXzy5BbSTRa0EFTUulIpQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48911619"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="48911619"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:11:08 -0700
X-CSE-ConnectionGUID: 16CVKo97SvS8gGJ6h1VrbQ==
X-CSE-MsgGUID: izREm6ZYSMmTLyLnMO1VWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143077147"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 15 May 2025 02:11:06 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1] ice: add 40G speed to Admin Command GET PORT OPTION
Date: Thu, 15 May 2025 09:11:05 +0000
Message-ID: <20250515091105.3005987-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code
to process this new option in both the devlink and the Admin Queue Command
GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like
ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.

This feature allows the driver to correctly report configuration options
for 2x40G on ICX-D LCC and other cards in the future via devlink.

Example comand:
 devlink port split pci/0000:01:00.0/0 count 2 

Example dmesg:
 ice 0000:01:00.0: Available port split options and max port speeds (Gbps):
 ice 0000:01:00.0: Status  Split      Quad 0          Quad 1
 ice 0000:01:00.0:         count  L0  L1  L2  L3  L4  L5  L6  L7
 ice 0000:01:00.0:         2      40   -   -   -  40   -   -   -
 ice 0000:01:00.0:         2      50   -  50   -   -   -   -   -
 ice 0000:01:00.0:         4      25  25  25  25   -   -   -   -
 ice 0000:01:00.0:         4      25  25   -   -  25  25   -   -
 ice 0000:01:00.0: Active  8      10  10  10  10  10  10  10  10
 ice 0000:01:00.0:         1     100   -   -   -   -   -   -   -

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/port.c   | 2 ++
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 767419a..63fb36f 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -30,6 +30,8 @@ static const char *ice_devlink_port_opt_speed_str(u8 speed)
 		return "10";
 	case ICE_AQC_PORT_OPT_MAX_LANE_25G:
 		return "25";
+	case ICE_AQC_PORT_OPT_MAX_LANE_40G:
+		return "40";
 	case ICE_AQC_PORT_OPT_MAX_LANE_50G:
 		return "50";
 	case ICE_AQC_PORT_OPT_MAX_LANE_100G:
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index bdee499..2ff141a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1672,6 +1672,7 @@ struct ice_aqc_get_port_options_elem {
 #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
 #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
 #define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
+#define ICE_AQC_PORT_OPT_MAX_LANE_40G	9
 
 	u8 global_scid[2];
 	u8 phy_scid[2];
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 4fedf01..2519ad6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4080,7 +4080,7 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
 
 		speed = options[active_idx].max_lane_speed;
 		/* If we don't get speed for this lane, it's unoccupied */
-		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
+		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_40G)
 			continue;
 
 		if (hw->pf_id == lport) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 6488151..f2c0b28 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -667,7 +667,8 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
 
 		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
 			port_topology->serdes_lane_count = 4;
-		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
+		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
+					 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)
 			port_topology->serdes_lane_count = 2;
 		else
 			port_topology->serdes_lane_count = 1;
-- 
2.49.0


