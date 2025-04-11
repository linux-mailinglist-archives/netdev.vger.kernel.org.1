Return-Path: <netdev+bounces-181701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF302A86345
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AA8C4D32
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1821B9D3;
	Fri, 11 Apr 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDwj83Ta"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596E21D3E3
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388954; cv=none; b=eAo1Dsb+uepoCSzdZrvTLBJzjeldRYjWnsCeJFJMOluOY6WBzpe8hSlDbFzdgc5BQQaMvpQzrADBeV/yfbCBktoC+FI+Q+LjXyeatUStqKnYj0xFH5a++mBU6sAl2bB58aJK82LKABtYf96ObLrTQCxYdrWQojB9hgkUQ/oZT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388954; c=relaxed/simple;
	bh=rMKGqkxOcLuVDnxn0me/rp92tp7cQUXjd78QQp48bvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agsiEREZf9kHy3FXwrPXPAsQKoQgPASOm1SwldehLY2AqbvVtEAVrcW5GVVa0FafoHd2R6AihaMaO51/XQUa7STQhqdpPZ2uezQrxahX6Z25kW1vqkEXEkYBmKgC8shETpwtPr+G8BT5b59+z5UP3VrQXDNP9/4czOUWHKYxXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDwj83Ta; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744388952; x=1775924952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rMKGqkxOcLuVDnxn0me/rp92tp7cQUXjd78QQp48bvE=;
  b=GDwj83TamaUrGcWtOsj9T7SUnXOYuMzRytUljlfHCRAiJxoXGzgFqs3P
   jgfMEUIq6NfLO2IUaQh4EB9nuU8/wACtn3ML00t37IBV/tQpUa6FLNzu9
   SHyywCcRnMYFY4a26xtbkLVM0sKcbiwrZplp/qpFJ3jc1W5rdz16amtgX
   KLouYrbTVnE7yftPA7f5l29z21ELGWkaFVW+JlXdaqin5Rk361fMkJXNt
   sR2HTtjrNG5OFAUzrqcg4CmExGVNMgL0wwIlegn0VfwLvQiT24EyedOB6
   Q8NGrkDRfwB/B/G1CTZOl5gRWIN1LdjfXI0MxdaxDqXIQkE+8nNR7bSd0
   g==;
X-CSE-ConnectionGUID: jozRSd24RNCMd3mRUR0Mzg==
X-CSE-MsgGUID: 5dnvV8rCSuKwEg1d78D+Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56610982"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56610982"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:29:10 -0700
X-CSE-ConnectionGUID: ISFSdVf7RYWk5MjJGwMGzQ==
X-CSE-MsgGUID: VSfxubGUTCqAHv54rYwrfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133343150"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 11 Apr 2025 09:29:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Christopher S M Hall <christopher.s.hall@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	michal.swiatkowski@linux.intel.com,
	richardcochran@gmail.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 6/6] igc: add lock preventing multiple simultaneous PTM transactions
Date: Fri, 11 Apr 2025 09:28:55 -0700
Message-ID: <20250411162857.2754883-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
References: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Add a mutex around the PTM transaction to prevent multiple transactors

Multiple processes try to initiate a PTM transaction, one or all may
fail. This can be reproduced by running two instances of the
following:

$ sudo phc2sys -O 0 -i tsn0 -m

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
 fails

Note: Normally two instance of PHC2SYS will not run, but one process
 should not break another.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h     |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index c35cc5cb1185..2f265c0959c7 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -319,6 +319,7 @@ struct igc_adapter {
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 	struct system_time_snapshot snapshot;
+	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
 
 	char fw_version[32];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 343205bffc35..612ed26a29c5 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -974,6 +974,7 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
 	}
 }
 
+/* The PTM lock: adapter->ptm_lock must be held when calling igc_ptm_trigger() */
 static void igc_ptm_trigger(struct igc_hw *hw)
 {
 	u32 ctrl;
@@ -990,6 +991,7 @@ static void igc_ptm_trigger(struct igc_hw *hw)
 	wrfl();
 }
 
+/* The PTM lock: adapter->ptm_lock must be held when calling igc_ptm_reset() */
 static void igc_ptm_reset(struct igc_hw *hw)
 {
 	u32 ctrl;
@@ -1068,9 +1070,16 @@ static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 {
 	struct igc_adapter *adapter = container_of(ptp, struct igc_adapter,
 						   ptp_caps);
+	int ret;
 
-	return get_device_system_crosststamp(igc_phc_get_syncdevicetime,
-					     adapter, &adapter->snapshot, cts);
+	/* This blocks until any in progress PTM transactions complete */
+	mutex_lock(&adapter->ptm_lock);
+
+	ret = get_device_system_crosststamp(igc_phc_get_syncdevicetime,
+					    adapter, &adapter->snapshot, cts);
+	mutex_unlock(&adapter->ptm_lock);
+
+	return ret;
 }
 
 static int igc_ptp_getcyclesx64(struct ptp_clock_info *ptp,
@@ -1169,6 +1178,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->free_timer_lock);
 	spin_lock_init(&adapter->tmreg_lock);
+	mutex_init(&adapter->ptm_lock);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
@@ -1181,6 +1191,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	if (IS_ERR(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
 		netdev_err(netdev, "ptp_clock_register failed\n");
+		mutex_destroy(&adapter->ptm_lock);
 	} else if (adapter->ptp_clock) {
 		netdev_info(netdev, "PHC added\n");
 		adapter->ptp_flags |= IGC_PTP_ENABLED;
@@ -1210,10 +1221,12 @@ static void igc_ptm_stop(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u32 ctrl;
 
+	mutex_lock(&adapter->ptm_lock);
 	ctrl = rd32(IGC_PTM_CTRL);
 	ctrl &= ~IGC_PTM_CTRL_EN;
 
 	wr32(IGC_PTM_CTRL, ctrl);
+	mutex_unlock(&adapter->ptm_lock);
 }
 
 /**
@@ -1255,6 +1268,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 		netdev_info(adapter->netdev, "PHC removed\n");
 		adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	}
+	mutex_destroy(&adapter->ptm_lock);
 }
 
 /**
@@ -1294,6 +1308,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		if (!igc_is_crosststamp_supported(adapter))
 			break;
 
+		mutex_lock(&adapter->ptm_lock);
 		wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
 		wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
 
@@ -1317,6 +1332,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
 		igc_ptm_reset(hw);
+		mutex_unlock(&adapter->ptm_lock);
 		break;
 	default:
 		/* No work to do. */
-- 
2.47.1


