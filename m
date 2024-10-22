Return-Path: <netdev+bounces-137729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA01E9A98C2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ABC1C215D3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55714659B;
	Tue, 22 Oct 2024 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFoO6VgR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D623140E30
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575681; cv=none; b=JLqBATWV4rS1+TlcxBd7l3NTYbcpnd6C2LlRXGHEYshyidBGSSb4gjCuSVrXe3xrmSFljOk2IOQZsQqAHrBvvt9wdF0YCFCRR4S9hTFMKMT/Jl0jViQcpCD4RfgDIoTzGwkWI1BRGRI0Uge3J23p476TRTz8JgGW2EqbwKB23gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575681; c=relaxed/simple;
	bh=t4KJ8GpVDCwBC+8iEFuUM+lt1UuXsB6tJ9CVvAjwB8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf/BbKGHpHujxCwDVoiU7TAkjoaUqyfvSmTJ19S8hUAPwAwD6kWL9+ePR1WVfYkV5Jyqh12MhEpscGaJ7+3hwtz3xm3ntHWBaTMXD0AwNjxIwbwU/yW8K+pkD/dvlJR9SMZ8lHoR1P34HnXFjXXDItLxTwHAvCloS7KNOIkQm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFoO6VgR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575679; x=1761111679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4KJ8GpVDCwBC+8iEFuUM+lt1UuXsB6tJ9CVvAjwB8c=;
  b=eFoO6VgRmgcrNbna9CEf7iSG4HtOvNSbGv4vD1FDeMFyglXC88ROKdCI
   SqDMkdR55hm7OatFP4YTqd/G3i288809Rz0wpmxO5e/f8jhaIs63jO0Oc
   /QnN/8lvviK6NNoQZK335ukRAIO1WorwxkMg7PPZYUbSbvBf/00k7g/D3
   t05cOWVUK8f/BCiRmeC/16K6p/W1JZ7NnWlnv2Y+jf7HI/YWH1Y6LteZS
   EvsmZs1pDgJ9EwEsLZW2IC+tjPlSuxNc3BXMftb+/q28TA0xUrSaBPBPo
   PqKnfFzMuilxAGoUHziGfIEnkCLPD1PPB9kcNEClufj/0Lyh++ZxAvN0G
   w==;
X-CSE-ConnectionGUID: iKrTRV/uRa2E83k/I7KNag==
X-CSE-MsgGUID: zs8SaTQVTEu2apCSRYyhtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="33015621"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="33015621"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:41:17 -0700
X-CSE-ConnectionGUID: zVz2K4kRQsymQcnUewO5Gg==
X-CSE-MsgGUID: UAb7nsSBROSdzfu2sGdb4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84558108"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 22:41:15 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C2A7427BCD;
	Tue, 22 Oct 2024 06:41:13 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v12 08/14] iavf: periodically cache PHC time
Date: Tue, 22 Oct 2024 07:41:15 -0400
Message-Id: <20241022114121.61284-9-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
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


