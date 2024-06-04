Return-Path: <netdev+bounces-100583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274838FB3B6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0311C20E1D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C11148304;
	Tue,  4 Jun 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2SSeqr5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA71474C9
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507502; cv=none; b=lahUy3QaUGH8G5PLZT+3/3wTSKjU/Wrm4hyzpPr2+IjpvxmP1K4VYjy2TqBdgyX0o2gg/5SrqawNP/QhLkZE2hu3Ac60DjMdH3HPGZYqY5okigo+l3APgaTR4yndzbsR+vMhFzFKOGn0bXI4FNHaXOZaMC2xeJiisWEKO0tSTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507502; c=relaxed/simple;
	bh=SJtoAqim9C4H+efPdyoHaXLb3TKk7D9yUZI3yXQwsCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fq0RA46WqMvtEgtqsxdEnKtKyejy5CH40zprhvOkegn12ZVn/p40zMfo99p8E3jmrPfRKmLR/P7yQZoQvJEajmjuHmO9slU598SutXbUK306b0rWJKaiyje9EgmIrggfLziql2kT7SPoWCYwq1SO9Na5lXPFctYNhdMfkWQa3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2SSeqr5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507501; x=1749043501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJtoAqim9C4H+efPdyoHaXLb3TKk7D9yUZI3yXQwsCQ=;
  b=G2SSeqr5jBanoCS2wzJ/U6D9blDKbKemaqawTWx7Rw5llgflHETcRCph
   mLKjj7dem2E09u/rERtL9Vxok9A/u5nSurFvKNLq4j+i55pg4dvUcQ0ky
   PhxhY45U3cBnxfxQ3UFuRbcgiC4iEpgm42Tw5S5zFvliADG9ElpPKHP6t
   e+lTtyqkzEr1+4vVpmrGNrCGpWvbbNEoDO282/PbQrcygF5dlyCGRHeAE
   hgwfYH3AxeR322TapHJCpvAFhOfL00Dv7mtJhn6UR6AvaT5G/9xmymXuC
   cA+ZgqzbIMi5LhG1Pp4jjE8ltwe7yQhlVa/dMfJjCJRQZr4tDeHUL+ucd
   A==;
X-CSE-ConnectionGUID: iXFbWbqVSPWDJgB9BR4pGw==
X-CSE-MsgGUID: MLsAAi5iRpiZQ8PdPTP53g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14245394"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14245394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:25:01 -0700
X-CSE-ConnectionGUID: ix8Ll0kGSaOsHBnAQi2z0w==
X-CSE-MsgGUID: 67ZZWa5KRRyooUpI6aAuTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37109771"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 06:24:59 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6CB2F1241B;
	Tue,  4 Jun 2024 14:24:51 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v7 08/12] iavf: periodically cache PHC time
Date: Tue,  4 Jun 2024 09:13:56 -0400
Message-Id: <20240604131400.13655-9-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
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


