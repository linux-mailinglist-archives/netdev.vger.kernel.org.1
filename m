Return-Path: <netdev+bounces-104459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2690C9B5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A061F23C4F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6F16EB78;
	Tue, 18 Jun 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4umkVWT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D784153815
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707409; cv=none; b=cygUaMPuwp1VkLvgDQo0gP1VgJIfsmDiNleNm1ga3+mlvy75XXnV0qLQpuYLR6EBNcPzWaQ28hKSufuHV2SPKNNiMLfYpGsKOA+SgtWBksXcC/aUV4ouqD988gpQrd18zIq3uRQVKJcnppAioWzCPv6dF1nElOVd3vAM2rAAPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707409; c=relaxed/simple;
	bh=I2rHd+h8O2gHOSw9PqzrGE6GMI7NzzdGJkYn5swzmT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMwp1uHO/7t8e/JuYC3UxkDL6EgOCCWttOY/gNF1ehO2LaxMIxc+Dx7nQWEXCz4Zu+X92VoMxDd2RZrs2InK6KAUe69E6xmwY9mdKGcfvFNfBOIpfPPiq2qe69txLI2PIEc3Gf/2Y61YmcNyl985/5acRAaKM5V2QsVYbmeNP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4umkVWT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718707408; x=1750243408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2rHd+h8O2gHOSw9PqzrGE6GMI7NzzdGJkYn5swzmT4=;
  b=K4umkVWTpNH/PqNF9iPHkgfKv9+A/AorEHDSw8LfE4TV++AwKGHSmjtD
   Lx3wF43V6Ib+bOqFPf1gbdLc+jVnxTUF44co1vJZgqAGkRMCqfIcCtRGc
   3ZBHzwD1Ll22Qhjv86rxyfAZiZp5HT8CyiHNZkubQLeB1aCFZMPVbyoA5
   NDP0c37fFKelhcRj6BhOaf/T28IKr3Do9zcIm5SVxuNQH7uYf2p0e4UAI
   hDT1LjSwhqR0XEfI/MW9RCDdQ0QCX+fFhBxQ1z0GU12fCzSn0qDtQN0+F
   lGjBKHkdGusveUjFTPeRqmJ2jDn7PifYXSkmldp937fTBOXRNmhz38/OE
   Q==;
X-CSE-ConnectionGUID: bRdVBHavTsuUMFamQFeSEg==
X-CSE-MsgGUID: O/8d2WEaQKChI8aEgUwDbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15719454"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15719454"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:43:28 -0700
X-CSE-ConnectionGUID: NA2wzNRxS3OxWrqKT/KAag==
X-CSE-MsgGUID: nU0iYmc0SrW+IWloPXDEwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42227762"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2024 03:43:26 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-net 2/3] ice: Don't process extts if PTP is disabled
Date: Tue, 18 Jun 2024 12:41:37 +0200
Message-ID: <20240618104310.1429515-3-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618104310.1429515-1-karol.kolacinski@intel.com>
References: <20240618104310.1429515-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_extts_event() function can race with ice_ptp_release() and
result in a NULL pointer dereference which leads to a kernel panic.

Panic occurs because the ice_ptp_extts_event() function calls
ptp_clock_event() with a NULL pointer. The ice driver has already
released the PTP clock by the time the interrupt for the next external
timestamp event occurs.

To fix this, modify the ice_ptp_extts_event() function to check the
PTP state and bail early if PTP is not ready. To ensure that the IRQ
sees the state change, call synchronize_irq() before removing the PTP
clock.

Another potential fix would be to ensure that all the GPIO configuration
gets disabled during release of the driver. This is currently not
trivial as each device family has its own set of configuration which is
not shared across all devices. In addition, only some of the device
families use the pin configuration interface. For now, relying on the
state flag is the simpler solution.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 30f1f910e6d9..b952cad42f92 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 	u8 chan, tmr_idx;
 	u32 hi, lo;
 
+	/* Don't process timestamp events if PTP is not ready */
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	/* Event time is captured by one of the two matched registers
 	 *      GLTSYN_EVNT_L: 32 LSB of sampled time event
@@ -1573,10 +1577,8 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 			event.timestamp = (((u64)hi) << 32) | lo;
 			event.type = PTP_CLOCK_EXTTS;
 			event.index = chan;
-
-			/* Fire event */
-			ptp_clock_event(pf->ptp.clock, &event);
 			pf->ptp.ext_ts_irq &= ~(1 << chan);
+			ptp_clock_event(pf->ptp.clock, &event);
 		}
 	}
 }
-- 
2.43.0


