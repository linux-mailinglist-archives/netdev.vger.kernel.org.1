Return-Path: <netdev+bounces-180714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B342A823AD
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D119E89A2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72925E455;
	Wed,  9 Apr 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyW35lmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCF2566D9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198614; cv=none; b=nJCZMG1rycgWPuocbcNLzUPQ6qE77UJHNMFn9gpkjqcevW2L6Qvklo109e2n7yu3FZ39YQ+Eg27KAc+QxFnjsoFNlZPnFT+o8TUG7ejc5BKB1G2/sPvf1KMl2kr3DBNrooh6XLp6WTO6rCdiO5LNCzal+MyAhJHFYyoqKlshUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198614; c=relaxed/simple;
	bh=3gSFU8etlJ2ALK3wJLM+1gui3Fu9Z+tNavH9MANx/0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loOQ3VEaqI8/ysSfBIrLGHpr+oenzF1v+h4iv/0efclQF4xZqj9eJ32URqhvSj/kmF+TKjW1WyIJFYKLnHdrSTmieR1qBZndU1ZAiz+2PnF4FpTOX5v7xGCK9Plc1X4qOVZG3ROxCLu9WazkojoDNOiREpaBHsul53tF/9i9+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyW35lmZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744198613; x=1775734613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gSFU8etlJ2ALK3wJLM+1gui3Fu9Z+tNavH9MANx/0w=;
  b=EyW35lmZNwCfmWSOGqyCHrFPNJBaXzMOFdKquRJ0jXcvZnlHYqDOLdcL
   PSUbLBHZ0N+qgN+tMlve6v+Zyothcp/Fl4lfDicJA0hyzEJaOKkHd/mio
   1IKGhjb21SMZbkTxFzT54YvFFA/86wvXw0DNby9jIpJhhZLqLWS6WMRpD
   YLSK7wln/dMmUlPFaYAg3yR81A3cKxLvnl3/sZ9IwcydqW5twTg2MmEru
   GwyEcwfYT/8lAcNMt0G6H7GLzTiq4lDaiCtWfmygvtc99Zfk883XNCp2l
   mRBFsvHSMLhoyHXSlYH3Cb7YCeYR/Zt7FBEpZrIzx3zhHUWcr4o1Vq8La
   A==;
X-CSE-ConnectionGUID: UIHuVG5aScePiDcntc+Q+w==
X-CSE-MsgGUID: 5FN+LvdMSoO3LsPM172BNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45799655"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45799655"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:36:52 -0700
X-CSE-ConnectionGUID: GWE1NCiXSoi7xhEK7oeMgw==
X-CSE-MsgGUID: RWMfSsPYQe65BKOSwYTRFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159536710"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa001.fm.intel.com with ESMTP; 09 Apr 2025 04:36:50 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next 2/2] ixgbe: add link_down_events statistic
Date: Wed,  9 Apr 2025 13:36:25 +0200
Message-ID: <20250409113622.161379-6-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new ethtool statistic to ixgbe driver, `link_down_events`,
to track the number of times the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The counter increments when a link-down event occurs and is exposed
via ethtool stats as `link_down_events`.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index e6a380d4929b..7a8b4b6053c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -743,6 +743,7 @@ struct ixgbe_adapter {
 	bool link_up;
 	unsigned long sfp_poll_time;
 	unsigned long link_check_timeout;
+	u32 link_down_events;
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index f03925c1f521..ea1d2c2390f1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -91,6 +91,7 @@ static const struct ixgbe_stats ixgbe_gstrings_stats[] = {
 	{"rx_hwtstamp_cleared", IXGBE_STAT(rx_hwtstamp_cleared)},
 	{"tx_ipsec", IXGBE_STAT(tx_ipsec)},
 	{"rx_ipsec", IXGBE_STAT(rx_ipsec)},
+	{"link_down_events", IXGBE_STAT(link_down_events)},
 #ifdef IXGBE_FCOE
 	{"fcoe_bad_fccrc", IXGBE_STAT(stats.fccrc)},
 	{"rx_fcoe_dropped", IXGBE_STAT(stats.fcoerpdc)},
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 467f81239e12..cb5c782817fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7986,6 +7986,8 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	if (!netif_carrier_ok(netdev))
 		return;
 
+	adapter->link_down_events++;
+
 	/* poll for SFP+ cable when link is down */
 	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
-- 
2.47.0


