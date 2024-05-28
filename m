Return-Path: <netdev+bounces-98498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 703508D19A2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5093B26A41
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00F316D306;
	Tue, 28 May 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5N7iigL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5316C872
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896041; cv=none; b=m852DC/K0rykcsF8sZCw8RfZzy4yGq4GfiX+xBwgxQJL7IwzQCrl+cmeEhjnx7ti6rRcFPkoESuTM4Er6SfyVHERpBXw287dX1vDj60LAetXPxm4BUVqSxfR85eC9e1XAbC/0T36+dTczF1fJa7ffovhlPTyd1pRtuI2p/zP6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896041; c=relaxed/simple;
	bh=SJtoAqim9C4H+efPdyoHaXLb3TKk7D9yUZI3yXQwsCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoTMVlZeW0tbMo+LGeHeTnm47DpP7IhqSRv6oKpm+xabroS0zdF//CcKyjamAP1JKetZCh3l99CthxhDIXU6QpvX6nihuog51DsCl+gmbRLN+QofPyLhXaYoPs/8hqe6wn1Wl0mbQ4uFXNzAL7fN4DP5Tyb7aWsQhWSRodh/QAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5N7iigL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716896040; x=1748432040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJtoAqim9C4H+efPdyoHaXLb3TKk7D9yUZI3yXQwsCQ=;
  b=m5N7iigLYCshqpeqMYYSidrNKw6Sk5eGL62RQHc9vrVWag6+cEOx6lbA
   lNRqaU8EuuJyUthjBiOe3jMwfritBvznas5lLT9pOJFDcVJgNvJzaEEsV
   E+jD2exKGu8DnOuR620rUdyk0seC6JQEg2VlK1Qq99yLS/zXebtoQKWQ7
   1f46OId2ByJ/lPSw1OUhONlPWMKl9QUXzCeyozfCMTCRqDm1yfJnWH7ra
   kiS9HuFV9CV1hYUGUFdQFV/5yOt9nnnI8ZNlIGass67eYDW5HtrgPf/zt
   vg4cZ8ZNyrQo84Krp2BhR6ePXaIyrXr72rlAzMb8CoR3/UCPEmnQK/R4w
   w==;
X-CSE-ConnectionGUID: laaUJTmUSHK6CF4qQJWoKg==
X-CSE-MsgGUID: SjNyKLxVROKItWh2TFASjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30757359"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="30757359"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:34:00 -0700
X-CSE-ConnectionGUID: VdD7ZuZWR5ubIabq39eJvg==
X-CSE-MsgGUID: bxt7qRckSDS5J9oig5RF5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35126681"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 04:33:58 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 43D1527BBA;
	Tue, 28 May 2024 12:33:57 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v6 08/12] iavf: periodically cache PHC time
Date: Tue, 28 May 2024 07:22:57 -0400
Message-Id: <20240528112301.5374-9-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
References: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
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
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 52 ++++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index d63f018792de..69e4948a9057 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -169,6 +169,55 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *ptp,
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
+	if (time_is_before_jiffies(adapter->ptp.cached_phc_updated + HZ)) {
+		/* The response from virtchnl will store the time into
+		 * cached_phc_time
+		 */
+		iavf_send_phc_read(adapter);
+	}
+}
+
+/**
+ * iavf_ptp_do_aux_work - Perform periodic work required for PTP support
+ * @ptp: PTP clock info structure
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
+long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp)
+{
+	struct iavf_adapter *adapter = clock_to_adapter(ptp);
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
@@ -189,6 +238,7 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
 	adapter->ptp.clock = ptp_clock_register(ptp_info, dev);
 	if (IS_ERR(adapter->ptp.clock))
@@ -228,6 +278,8 @@ void iavf_ptp_init(struct iavf_adapter *adapter)
 		return;
 	}
 
+	ptp_schedule_worker(adapter->ptp.clock, 0);
+
 	adapter->ptp.initialized = true;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 4f84416743e1..7a25647980f3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -34,5 +34,6 @@ void iavf_ptp_release(struct iavf_adapter *adapter);
 void iavf_ptp_process_caps(struct iavf_adapter *adapter);
 bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap);
 void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
+long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp);
 
 #endif /* _IAVF_PTP_H_ */
-- 
2.38.1


