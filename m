Return-Path: <netdev+bounces-83786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0B89444A
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7212CB21B6A
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF94DA05;
	Mon,  1 Apr 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9f30UEK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7504CDE0
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992271; cv=none; b=RtpJojfi7SoFKLcIe5wZd/kgAERHIjtmdwGEypUW0X7hM+xZnBs6QpE5RTDahccM3S23xBB2KhgCPo8YtOPlDNoPAnh7+hgg4Fmjc9FeZo96qBSfnWmlHQ9dD6O94pIPJ3MWLEmitWA/THRIST+789OHRFJyddHNOVh8jMmJE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992271; c=relaxed/simple;
	bh=1KSwQaDOTaoLyJ+KIREERcRRGRgDhE6oQoqgCJk0+Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0lA2/uNihf095Mi6b1zCp3tA14FzRmu20VN23q5K1KzI0nDMyVwgfRCqbXMuItpHFL7fx5uGyocW/ab/NtQQ57V3WxBWROOqvZYpSAnI/1C6euUFEqGQZrwjO3htC3WMq5pdNccSyej627GxoOU8bw4enZVpK+sSh/f/Ojt3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9f30UEK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992270; x=1743528270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KSwQaDOTaoLyJ+KIREERcRRGRgDhE6oQoqgCJk0+Xs=;
  b=Q9f30UEKCCVFKChcdEWv4C05seT/C/r8E4MjpzEDuYM+IEWteAm/ak4h
   iUXvjEipZKxvzTL5sG4JWdwST1D2ZDP1890707kgqThA8B6feQ0F2dQpN
   az3x7a6sABQgMrLUBadPiT3Ae+zGqojRyFx1a5NUgW5uO8lpP//tJdks/
   gvTTdNTxiKVNdvBELIUJlvNHtP7Yx4VCikfQIdN8VFh5Wz2r2HIIzCJDU
   07haexkZXsSLG/bYHQV2dzRIqqX2qaBdVqhMOytDZYsU80SGS2BiX+aXF
   oibxLUdqFPgE4fSAPwO1PfLRhWOYydbZbTVuGz64/jMZZ3r6n+TKF05mV
   w==;
X-CSE-ConnectionGUID: NYpqXDCKQrKvLY25Jm82/w==
X-CSE-MsgGUID: 3LejDXG/QJGFxef/RkDYKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606147"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606147"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235082"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/8] ice: avoid the PTP hardware semaphore in gettimex64 path
Date: Mon,  1 Apr 2024 10:24:12 -0700
Message-ID: <20240401172421.1401696-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

The PTP hardware semaphore (PFTSYN_SEM) is used to synchronize
operations that program the PTP timers. The operations involve issuing
commands to the sideband queue. The E810 does not have a hardware
sideband queue, so the admin queue is used. The admin queue is slow.
I have observed delays in hundreds of milliseconds waiting for
ice_sq_done.

When phc2sys reads the time from the ice PTP clock and PFTSYN_SEM is
held by a task performing one of the slow operations, ice_ptp_lock can
easily time out. phc2sys gets -EBUSY and the kernel prints:
  ice 0000:XX:YY.0: PTP failed to get time
These messages appear once every few seconds, causing log spam.

The E810 datasheet recommends an algorithm for reading the upper 64 bits
of the GLTSYN_TIME register. It matches what's implemented in
ice_ptp_read_src_clk_reg. It is robust against wrap-around, but not
necessarily against the concurrent setting of the register (with
GLTSYN_CMD_{INIT,ADJ}_TIME commands). Perhaps that's why
ice_ptp_gettimex64 also takes PFTSYN_SEM.

The race with time setters can be prevented without relying on the PTP
hardware semaphore. Using the "ice_adapter" from the previous patch,
we can have a common spinlock for the PFs that share the clock hardware.
It will protect the reading and writing to the GLTSYN_TIME register.
The writing is performed indirectly, by the hardware, as a result of
the driver writing GLTSYN_CMD_SYNC in ice_ptp_exec_tmr_cmd. I wasn't
sure if the ice_flush there is enough to make sure GLTSYN_TIME has been
updated, but it works well in my testing.

My test code can be seen here:
https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-10
It consists of:
 - kernel threads reading the time in a busy loop and looking at the
   deltas between consecutive values, reporting new maxima.
 - a shell script that sets the time repeatedly;
 - a bpftrace probe to produce a histogram of the measured deltas.
Without the spinlock ptp_gltsyn_time_lock, it is easy to see tearing.
Deltas in the [2G, 4G) range appear in the histograms.
With the spinlock added, there is no tearing and the biggest delta I saw
was in the range [1M, 2M), that is under 2 ms.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 8 +-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 3 +++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index f00ab998e853..52d15ef7f4b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
 
@@ -35,6 +36,7 @@ static struct ice_adapter *ice_adapter_new(void)
 	if (!adapter)
 		return NULL;
 
+	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	return adapter;
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index cb5a02eb24c1..9d11014ec02f 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -4,15 +4,21 @@
 #ifndef _ICE_ADAPTER_H_
 #define _ICE_ADAPTER_H_
 
+#include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
 struct pci_dev;
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
+ * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
+ *                        register of the PTP clock.
  * @refcount: Reference count. struct ice_pf objects hold the references.
  */
 struct ice_adapter {
+	/* For access to the GLTSYN_TIME register */
+	spinlock_t ptp_gltsyn_time_lock;
+
 	refcount_t refcount;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c11eba07283c..0875f37add78 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -374,6 +374,7 @@ ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct ptp_system_timestamp *sts)
 	u8 tmr_idx;
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
+	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	/* Read the system timestamp pre PHC read */
 	ptp_read_system_prets(sts);
 
@@ -1925,15 +1926,8 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 		   struct ptp_system_timestamp *sts)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
-	struct ice_hw *hw = &pf->hw;
-
-	if (!ice_ptp_lock(hw)) {
-		dev_err(ice_pf_to_dev(pf), "PTP failed to get time\n");
-		return -EBUSY;
-	}
 
 	ice_ptp_read_time(pf, ts, sts);
-	ice_ptp_unlock(hw);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 187ce9b54e1a..2b9423a173bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -274,6 +274,9 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
  */
 static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+
+	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
 	ice_flush(hw);
 }
-- 
2.41.0


