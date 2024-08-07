Return-Path: <netdev+bounces-116284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9E949D13
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF82B23A52
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72172AEFB;
	Wed,  7 Aug 2024 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9cTdrhW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9522770E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991019; cv=none; b=TXLhYF8GKkKLOTi7MAHb7XOUS7zsE604qJbbHZGzTndPMEgFl/GTihW7BU5Oa7o8IgT/yit4uvEkThtwqfALl7C0ywHEymBPYQ+/ucX+ndb97gMrFw2h+9ijEVMs0QPbwiDIRw2uXcuYdkr2+zy7XsbPv+lhv/r59F/OhB6qzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991019; c=relaxed/simple;
	bh=Rdr9qX500IejMlvTst8ST2srghzPY596qYKAm+Pca6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLxEi4hePs5kdj5TKL/yOviT+K7FPRLqiRSM3UR6mK3aapy6d6lGQMRHdfwVFeThZ6IEr5R/iF3b1MquyuJoRAmgkVZSv2W1MDxU1aPvbz8AM4/yKaGgyxnZytkcZUbZt/YRU6FitpPdy7FqhiTaIgFIPppWGeXzVLwkEdwlTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9cTdrhW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722991018; x=1754527018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rdr9qX500IejMlvTst8ST2srghzPY596qYKAm+Pca6Q=;
  b=E9cTdrhWKKEGbU7ifc8TI3AxleWXA7PsJy1RsWmP+GDVGu/oKCXQJqXr
   CDTWbqCoCtryatlj80aB+4ZPTF6jhF7xS8pSvdeimfJrJAON9ElOcUsfn
   0e8u4/dwdIRfSAk9XJj1oNXc3E8GizI/n/r1iajsZKrSDbqk8YZtqDKaR
   gdARzYr4fDrKypnlIOwy7MAHHeX5BIr04Y7GKFqNncG1cCCKz8UaqPKTQ
   Gdd+Qnfu93fJ8EVR1RuHaaYA565LZof3twSPvYjKeMFWqSUOeadUgdb48
   3ORXQOcEQ/CxuZ5NRJo/nR2yS7NU18GY9ynr4IT6qdf4nm8PaYgmfDlL0
   w==;
X-CSE-ConnectionGUID: 40m+/cQVSCebPnX8CBTySg==
X-CSE-MsgGUID: 0rPddeEKSlqS0WuQmI6JVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669762"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31669762"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:36:58 -0700
X-CSE-ConnectionGUID: cSuwcZ+2RVGto+yMtdbE9g==
X-CSE-MsgGUID: kvCrhZO1SAyCv7/j1r5Agw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61497023"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com) ([143.182.136.138])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:57 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v1 5/5] igc: Add lock preventing multiple simultaneous PTM transactions
Date: Tue,  6 Aug 2024 17:30:32 -0700
Message-Id: <20240807003032.10300-6-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
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
index c38b4d0f00ce..fbac02c79178 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -315,6 +315,7 @@ struct igc_adapter {
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 	struct system_time_snapshot snapshot;
+	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
 
 	char fw_version[32];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index f770e39650ef..c70a6393c210 100644
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
@@ -1302,6 +1309,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		wr32(IGC_PTM_CTRL, ctrl);
 
 		/* Force the first cycle to run. */
+		mutex_init(&adapter->ptm_lock);
 		igc_ptm_trigger(hw);
 
 		if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
-- 
2.34.1


