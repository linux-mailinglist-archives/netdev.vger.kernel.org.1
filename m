Return-Path: <netdev+bounces-142348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35449BE5B8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AE51C21961
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313701DED57;
	Wed,  6 Nov 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRZutY/N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0191DF720
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893078; cv=none; b=WU2nCj/R4jAp0vr2L0yCy+O51hDJJwNEFUBImIYKDPL4m2rC/l5MfWkoUeGi1JIpErFi8piLCW/V5tRKa5rDglQMLLZKw9QHkt8fr6/0MVIQwvV3/PaUbIuo7a1wFsWuA5Wo+2480YYOCBu6VZuIs8Q3Cm61v3ATt/ROz2xNCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893078; c=relaxed/simple;
	bh=b6zXC/mUJYJ5COFx5tnpM998HiHUroUgSPl0cMferBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kY1GJ3vg8eMAxs3+AaXHtvQVTCi0rktrHy93PTd7qjK7KY+5WL55mKSx9l0QwJrbfUnvGLmP0vfONPPmL4Y23O7SUj+Dk9PDDiPsPKJQD1bPbsmNAAWrzuKkTjZV6RloI3UsCNQFdWWZhiT9eDzcKO0YMT1ZrB1V1O8V6Y88DhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRZutY/N; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730893076; x=1762429076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6zXC/mUJYJ5COFx5tnpM998HiHUroUgSPl0cMferBs=;
  b=eRZutY/NgvZ5tnDNbfP4LEhSgX69mAZJ4smP4EUPqls0whaTXMkc3lhA
   y4+EWz4dV80Yi+uGKZ3r9NgE8rf9IBnaMr8hRpc1Fvq1buvtwcll2Z5ww
   Qt81CPublIk7plf/7OZ2MiXEzFeSKhMD50UAIV97f5VUxrJDAudIgB+nj
   hVzJClYFmc25Hqx+1zOGbHDACIbwGalH0j01/YTKZogDZvlCJNJgCNU1R
   5Ma34fgIm9T03gOsUIty+ypUvi2/bTVbVO0ohioKkacNz8AmK5K7pEl1v
   n6YbIhw5zbADc9xX8mzpBZ/r9yUfUjIrG+rya8Mc9RSTWJIPtcRVzMdtj
   w==;
X-CSE-ConnectionGUID: Y6LF5N86St6I14+Zoe+muA==
X-CSE-MsgGUID: KQwLtxWdSLeaNphMJPiFmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30455520"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30455520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:37:55 -0800
X-CSE-ConnectionGUID: MN+UheMLSRaNvCgvmwmbxQ==
X-CSE-MsgGUID: huv/RjFoR3aJjR/s1PVi7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="122020138"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2024 03:37:52 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 929D52FC49;
	Wed,  6 Nov 2024 11:37:51 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v13 08/14] iavf: periodically cache PHC time
Date: Wed,  6 Nov 2024 12:37:25 -0500
Message-Id: <20241106173731.4272-9-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106173731.4272-1-mateusz.polchlopek@intel.com>
References: <20241106173731.4272-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The Rx timestamps reported by hardware may only have 32 bits of storage
for nanosecond time. These timestamps cannot be directly reported to the
Linux stack, as it expects 64bits of time.

To handle this, the timestamps must be extended using an algorithm that
calculates the corrected 64bit timestamp by comparison between the PHC
time and the timestamp. This algorithm requires the PHC time to be
captured within ~2 seconds of when the timestamp was captured.

Instead of trying to read the PHC time in the Rx hotpath, the algorithm
relies on a cached value that is periodically updated.

Keep this cached time up to date by using the PTP .do_aux_work kthread
function.

The iavf_ptp_do_aux_work will reschedule itself about twice a second,
and will check whether or not the cached PTP time needs to be updated.
If so, it issues a VIRTCHNL_OP_1588_PTP_GET_TIME to request the time
from the PF. The jitter and latency involved with this command aren't
important, because the cached time just needs to be kept up to date
within about ~2 seconds.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index b9a341e98a98..c2e0d27552b0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -158,6 +158,56 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+/**
+ * iavf_ptp_cache_phc_time - Cache PHC time for performing timestamp extension
+ * @adapter: private adapter structure
+ *
+ * Periodically cache the PHC time in order to allow for timestamp extension.
+ * This is required because the Tx and Rx timestamps only contain 32bits of
+ * nanoseconds. Timestamp extension allows calculating the corrected 64bit
+ * timestamp. This algorithm relies on the cached time being within ~1 second
+ * of the timestamp.
+ */
+static void iavf_ptp_cache_phc_time(struct iavf_adapter *adapter)
+{
+	if (!time_is_before_jiffies(adapter->ptp.cached_phc_updated + HZ))
+		return;
+
+	/* The response from virtchnl will store the time into
+	 * cached_phc_time.
+	 */
+	iavf_send_phc_read(adapter);
+}
+
+/**
+ * iavf_ptp_do_aux_work - Perform periodic work required for PTP support
+ * @info: PTP clock info structure
+ *
+ * Handler to take care of periodic work required for PTP operation. This
+ * includes the following tasks:
+ *
+ *   1) updating cached_phc_time
+ *
+ *      cached_phc_time is used by the Tx and Rx timestamp flows in order to
+ *      perform timestamp extension, by carefully comparing the timestamp
+ *      32bit nanosecond timestamps and determining the corrected 64bit
+ *      timestamp value to report to userspace. This algorithm only works if
+ *      the cached_phc_time is within ~1 second of the Tx or Rx timestamp
+ *      event. This task periodically reads the PHC time and stores it, to
+ *      ensure that timestamp extension operates correctly.
+ *
+ * Returns: time in jiffies until the periodic task should be re-scheduled.
+ */
+static long iavf_ptp_do_aux_work(struct ptp_clock_info *info)
+{
+	struct iavf_adapter *adapter = iavf_clock_to_adapter(info);
+
+	iavf_ptp_cache_phc_time(adapter);
+
+	/* Check work about twice a second */
+	return msecs_to_jiffies(500);
+}
+
 /**
  * iavf_ptp_register_clock - Register a new PTP for userspace
  * @adapter: private adapter structure
@@ -176,6 +226,7 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 KBUILD_MODNAME, dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
 	clock = ptp_clock_register(ptp_info, dev);
 	if (IS_ERR(clock))
@@ -219,6 +270,8 @@ void iavf_ptp_init(struct iavf_adapter *adapter)
 
 		rx_ring->ptp = &adapter->ptp;
 	}
+
+	ptp_schedule_worker(adapter->ptp.clock, 0);
 }
 
 /**
-- 
2.38.1


