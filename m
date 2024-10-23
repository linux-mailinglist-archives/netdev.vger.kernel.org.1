Return-Path: <netdev+bounces-138070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808749ABBAD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B1C1C22CCE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3D8248C;
	Wed, 23 Oct 2024 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4TMeZ+4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713535C603
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651198; cv=none; b=mv3BuccdMWc3pDuVi+/c5qD488uOqswPEYqSCHTP0xROJmWj4oxXlMkujM13if7W9LNBZRDlfyZg+2ZMKac/KM1EU6kkvLIcXvRLJZoVDO4qZwjjBKAJ4jfeuYGCVyt57AWSmmamKayv8i1RNjEArUAyDJBh+hs5XvkOHvv/1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651198; c=relaxed/simple;
	bh=fI2PP8aO+nTDU/nnhz7qcI6i6PH/omY2nZpMN6FK/9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t77H6UVW/OeA4KFdy4JsGOODnFLWOj9Ls9W7Tq4oyZIKRnSqJmb8uz6vA4k7OGoimBV0f5DwvPqMlYz6DAdLiBaNH9x1A/fyWp4a+KJa/ZDcEzvKvTyIAKkxkpX0TfeONGGPfaI3yQSJU6beDBLfg+z7hFkkWyfTna9WK8nl980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4TMeZ+4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729651197; x=1761187197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fI2PP8aO+nTDU/nnhz7qcI6i6PH/omY2nZpMN6FK/9o=;
  b=O4TMeZ+4BMsIVTzkfvmp5wKvUIiW8P+NI6hSNwsbXPjUjcAl0Gfh6og4
   C8KT4wWhCh9mcn5e9MyZDevDHtDQjTcmJ3sm1kY/KRoS2864U498lR/Bo
   vMKNOMC81EaJ2mepObQEbFVYk7rzztLGOzAP65CXOQb9qA7SSoboVz7h5
   DZsR/pZnO/hFlD3OszWne0zecQTUOfbtOWa9DlHxcL4akBWhWDGqGSuzV
   QP2rsfsgZjnm+S06mbJyvSyO/IIXQ1mNhHxyJu8nnczm2Cu+VVo+2CNu9
   29O7ZZznpN5Jr31BHnCN7cFTrioSJKDuBa2DFtbQjo1VjAeGZRuRs3sUH
   w==;
X-CSE-ConnectionGUID: KIkVRUVUSjy8KYmuyQwIwA==
X-CSE-MsgGUID: 49NkbMgQTiG3zuvoQOZUVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32918046"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32918046"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:39:55 -0700
X-CSE-ConnectionGUID: v24BRyP1T7ymzKN/4Lzeag==
X-CSE-MsgGUID: axdojXz8SaObmq+J6tzNtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80396834"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Oct 2024 19:39:54 -0700
From: Chris H <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v2 4/4] igc: Add lock preventing multiple simultaneous PTM transactions
Date: Wed, 23 Oct 2024 02:30:40 +0000
Message-Id: <20241023023040.111429-5-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023023040.111429-1-christopher.s.hall@intel.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
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
---
 drivers/net/ethernet/intel/igc/igc.h     |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4..323db1e2be38 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -319,6 +319,7 @@ struct igc_adapter {
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 	struct system_time_snapshot snapshot;
+	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
 
 	char fw_version[32];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index fb885fcaa97c..4e1379b7d2ee 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1068,9 +1068,16 @@ static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
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
@@ -1169,6 +1176,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->free_timer_lock);
 	spin_lock_init(&adapter->tmreg_lock);
+	mutex_init(&adapter->ptm_lock);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-- 
2.34.1


