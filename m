Return-Path: <netdev+bounces-78545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF599875A37
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 23:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A4283294
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2EA13E7F1;
	Thu,  7 Mar 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ4wH4Dq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02D1369A6
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850334; cv=none; b=ieS49BRkAoHiYLNbcmkSKsmAX5wBSZ+oODyQmM6a6IhC+b93XT2cvgwG2Rd4AkQwU7zElFxf4gmIQ2dZxaD67DM+iF3NICKXZ5odFkL7mYh5+ZUwqInerssnqpB5kqSuS/lskx3Z48P8X4lUvqN6O3qbALFogkcGRTRVZhrte9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850334; c=relaxed/simple;
	bh=KQcQreIf3KdOicPjO9dHk2ak2UkMoJ1DPP2sRE6UVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaotTQLS/2qcq/ubERnv39QwD2Y+/N14xsN5ez16v2sw3QyEHER34K32Lh3V10Crg9G4rpzJJRLCDy3+6gTHU0+MoJN0kV7+kczAWJFC67zVaksAE6XMc8ClcbwPCW28xQ4ZZtcJprPbW4EVTJfOva59fe5J3mOjB90WqArHWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ4wH4Dq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709850332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCashlk1j8zw2cFRgsBziq5vcTt9z8cZj/gEJ/sKkLE=;
	b=IJ4wH4Dq8fIJQPlAS53mEjwdqbJ2ageB3f1utlL2YnKXv16ULtYwC0V99+D7BRBRNmcgq8
	2YMqS2Snr2bB+Rdd4k4FNIdZb38WVb2IBjovPv4AUf14no8KDXTwsfC613MRA+FYNK/j2g
	FSCVgITT+JkOZ5uDNbIwfHO5bIK/0i4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-UAZAAPuCOCuz79uZczs4Pw-1; Thu, 07 Mar 2024 17:25:27 -0500
X-MC-Unique: UAZAAPuCOCuz79uZczs4Pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7639B800264;
	Thu,  7 Mar 2024 22:25:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5951C060D6;
	Thu,  7 Mar 2024 22:25:24 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net-next v3 2/3] ice: avoid the PTP hardware semaphore in gettimex64 path
Date: Thu,  7 Mar 2024 23:25:09 +0100
Message-ID: <20240307222510.53654-3-mschmidt@redhat.com>
In-Reply-To: <20240307222510.53654-1-mschmidt@redhat.com>
References: <20240307222510.53654-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-9
It consists of:
 - kernel threads reading the time in a busy loop and looking at the
   deltas between consecutive values, reporting new maxima.
 - a shell script that sets the time repeatedly;
 - a bpftrace probe to produce a histogram of the measured deltas.
Without the spinlock ptp_gltsyn_time_lock, it is easy to see tearing.
Deltas in the [2G, 4G) range appear in the histograms.
With the spinlock added, there is no tearing and the biggest delta I saw
was in the range [1M, 2M), that is under 2 ms.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 8 +-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 3 +++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 6b9eeba6edf7..bd5f346bc603 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -5,6 +5,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
 
@@ -28,6 +29,7 @@ static struct ice_adapter *ice_adapter_new(void)
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
2.43.2


