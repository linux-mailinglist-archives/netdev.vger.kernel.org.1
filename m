Return-Path: <netdev+bounces-208225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A61B0AA66
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3676E4E413F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1A2E92D5;
	Fri, 18 Jul 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfqYAweL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85042E8E09
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864691; cv=none; b=XnH8xXjKE8P4sGi4WuqGd1FqIznF4Kd6QF/XmeEQ8cmGVuXqUi3BfcECqtKVBoB2R0zmCHErlglZGebY79O80mZWbnoYWZFXKlWySQZj6dk1ajREmb8F5OsMTcH1+/XyKC4B7EgEfkWUJsBoxjKLbOAz7JobmAmAWV6V05flLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864691; c=relaxed/simple;
	bh=H608TvNVr8uyXpdswA7EVmVV6+i3osiV32Iv4kCGcJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3fF2rQg9L3I5GZIcNIl0pOCUMX0cYDsym5Wgv9LfINCG0rt3C5atD3Gfov+/2rPcglr+kBxOrLwjBkAg2F3x0RSdRRPSB+T/puk+PbqGhj9lfipurymQOB2mB5Xk9KostG+GKj0wL0Yzavme0gxH7EQoMhoEgy1bw5MucT6iBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfqYAweL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864690; x=1784400690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H608TvNVr8uyXpdswA7EVmVV6+i3osiV32Iv4kCGcJk=;
  b=JfqYAweL4M3Z2+5Raf+Kle7DD6HHO9HxuvZq8/SCdxIWSqFhn14eDnfM
   EXqjWR/cEfFFDuRZzWtw/ZpSkfB+h+IdgLKTNHbyb6Eftou6yz+E3ycGX
   aT+ShHH4AEBpCJ9+6t+USK/b8qj1QjrC1L+p3bPVPsqZornAH7/OQ23sj
   XKKrTaDNGLVMOjx9TFTSLONZB0VSfElhNJRF28ShwnWYBH9DJGIF4uum6
   vGg0p6h9LGTig8LfqVQAXlpUQ0ZT6KXMW6AkYXMLN+jOrjDjeJ/aqoSL2
   OCa6v5SjW8r9XnpC/uLEdSDMTfKCakwH+/VcH4dFoOwliZc+ibGfbpQwH
   A==;
X-CSE-ConnectionGUID: fgDm0cS4QNmgjO51r7m3wQ==
X-CSE-MsgGUID: cW1XDkk7Q62cLY7RLqaQhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320586"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320586"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:24 -0700
X-CSE-ConnectionGUID: Ck6rQm3HTXiv3X8sfwSuYw==
X-CSE-MsgGUID: Dvh2LfJcQpO+qSlg9gUeCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506893"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 06/13] ice: add 40G speed to Admin Command GET PORT OPTION
Date: Fri, 18 Jul 2025 11:51:07 -0700
Message-ID: <20250718185118.2042772-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code
to process this new option in both the devlink and the Admin Queue Command
GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like
ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.

This feature allows the driver to correctly report configuration options
for 2x40G on E823 and other cards in the future via devlink.

Example command:
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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/port.c   | 2 ++
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 767419a67fef..63fb36fc4b3d 100644
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
index 97f9ebd62d93..39d99c2f7976 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1684,6 +1684,7 @@ struct ice_aqc_get_port_options_elem {
 #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
 #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
 #define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
+#define ICE_AQC_PORT_OPT_MAX_LANE_40G	9
 
 	u8 global_scid[2];
 	u8 phy_scid[2];
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 1b435e108d3c..b4fe096ace08 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4307,7 +4307,7 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
 
 		speed = options[active_idx].max_lane_speed;
 		/* If we don't get speed for this lane, it's unoccupied */
-		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
+		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_40G)
 			continue;
 
 		if (hw->pf_id == lport) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index e54221fba849..58ed875093cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -667,7 +667,8 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
 
 		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
 			port_topology->serdes_lane_count = 4;
-		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
+		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
+			 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)
 			port_topology->serdes_lane_count = 2;
 		else
 			port_topology->serdes_lane_count = 1;
-- 
2.47.1


