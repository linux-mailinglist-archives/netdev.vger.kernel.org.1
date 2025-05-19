Return-Path: <netdev+bounces-191656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03984ABC8DE
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E7217D44A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508621B90B;
	Mon, 19 May 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVAPS3Gx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB3211A00
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688733; cv=none; b=ROz49t4YOP/p2YshkcKWldItLhErYvBxkjCkPoTfb5g1zTE/cbDjibY9/9h80itrb23oIfHL3Xp9JVBPK2exOnurfzK8zQYkeHuz7ZxWtBsEi90IbfbBadu+Rp5NQMKmwZwMq2l4YbPiJ/h8I2INGejfWRxhqJ7+rJSfaR90ATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688733; c=relaxed/simple;
	bh=nsTdxTlXks6s3c/mxpuPhOPTX8/37SUWqo49Gu4dqEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGbH3vFDHYNew1Yt57mVq7dH0+QteLqPY45Dyw6B1/x1onnqPAlvt/Frc4pjvFyJlt7iAw6CCtzYnEXG5cTxVzq/SLe8k0UyPV2eHlPiPDT2EOd5O9HJpJtT6Gbk4KQMmnzMoA5Uw1cMCwIs/vbxY9R/kK/jV9gl66tiB0xObRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVAPS3Gx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747688732; x=1779224732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsTdxTlXks6s3c/mxpuPhOPTX8/37SUWqo49Gu4dqEU=;
  b=eVAPS3GxOhljElzqlPFb9NuKRYZXMQeMuNQqF1WC4QsifTMafZRCyzPF
   s6q3ZxEVq+WUE2xx0+/Mop9Liv+cuX3GAC0PaVe4lR99TTGNbeg8BpsLe
   Khzpu57QFaC5ocKd3mIrJR7rQXvfAjiZ1ToC+rq9sk8FuRlzUHOnjOrM9
   ykAL5mpqF9HWCPCEGMar4OpVOuW2gdh8glS/KDTtE4STeEEgc8z718FLg
   JJKa/v9smDW6qnb25xlyJbohnpLhA8C4HoNZn6RhYG5wl5N9fVy7MaA8M
   MZLFXPagkh66jEZSzXtocSu7sRPkJ5UxTAhzle7hZ45sLvGZXH3REEdxa
   g==;
X-CSE-ConnectionGUID: nDL6lZ1YTWySSnquQHuGfQ==
X-CSE-MsgGUID: fCflt/gdTLKsaECta73twQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49668534"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49668534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:05:30 -0700
X-CSE-ConnectionGUID: eGQuzG6vSxm9NYv7FnPRYg==
X-CSE-MsgGUID: LeNFZn0PRvKSgUoCAxNngA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="140491854"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2025 14:05:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 2/3] ice: Fix LACP bonds without SRIOV environment
Date: Mon, 19 May 2025 14:05:19 -0700
Message-ID: <20250519210523.1866503-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
References: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

If an aggregate has the following conditions:
- The SRIOV LAG DDP package has been enabled
- The bond is in 802.3ad LACP mode
- The bond is disqualified from supporting SRIOV VF LAG
- Both interfaces were added simultaneously to the bond (same command)

Then there is a chance that the two interfaces will be assigned different
LACP Aggregator ID's.  This will cause a failure of the LACP control over
the bond.

To fix this, we can detect if the primary interface for the bond (as
defined by the driver) is not in switchdev mode, and exit the setup flow
if so.

Reproduction steps:

%> ip link add bond0 type bond mode 802.3ad miimon 100
%> ip link set bond0 up
%> ifenslave bond0 eth0 eth1
%> cat /proc/net/bonding/bond0 | grep Agg

Check for Aggregator IDs that differ.

Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event handler")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 22371011c249..2410aee59fb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1321,12 +1321,18 @@ static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
 		 */
 		if (!primary_lag) {
 			lag->primary = true;
+			if (!ice_is_switchdev_running(lag->pf))
+				return;
+
 			/* Configure primary's SWID to be shared */
 			ice_lag_primary_swid(lag, true);
 			primary_lag = lag;
 		} else {
 			u16 swid;
 
+			if (!ice_is_switchdev_running(primary_lag->pf))
+				return;
+
 			swid = primary_lag->pf->hw.port_info->sw_id;
 			ice_lag_set_swid(swid, lag, true);
 			ice_lag_add_prune_list(primary_lag, lag->pf);
-- 
2.47.1


