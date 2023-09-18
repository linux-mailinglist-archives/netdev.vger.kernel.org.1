Return-Path: <netdev+bounces-34814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560437A5507
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10996281AAB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0028DD0;
	Mon, 18 Sep 2023 21:28:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F02869D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C7A10F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072525; x=1726608525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3BN95rMS5wHwFlCfM8xphg7SKsCPx1UCJzA6mjwksSM=;
  b=e/XrgYPUsa26C7W49LBl0ZgJTpvOtqj/UPgrc3V2fYMU9b7k4gZN7HgD
   iYWkL+yQ68ScoP0CNW7OjHW8WHC2iRHumyLPxms3Opj6N+Gn8wiJR8b9y
   +8WDevAAaSoJaTCN3eqM8UvmPe3MZQjviL8M5TjfGrtq6zabN5p9GG//w
   fBh8GkoMoDFRr8x6i1HL8envIu5QclRO/M4sH4kf/uRD86lKn1TsfwrjF
   S+U3aca9jaqAE4yrcnDqilGUlGsAFgsqnvKrKFhfU1fNl6yyxlIcwVR+9
   mA4H30smiW0BkV8aWanHRGfVgWByncJZ5JohjvU40jT+MjjMV5bGUfB2a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187237"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186200"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186200"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 02/11] ice: retry acquiring hardware semaphore during cross-timestamp request
Date: Mon, 18 Sep 2023 14:28:05 -0700
Message-Id: <20230918212814.435688-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Karol Kolacinski <karol.kolacinski@intel.com>

The hardware for performing a cross-timestamp on E822 uses a hardware
semaphore which we must acquire before initiating the cross-timestamp
operation.

The current implementation only attempts to acquire the semaphore once, and
assumes that it will succeed. If the semaphore is busy for any reason, the
cross-timestamp operation fails with -EFAULT.

Instead of immediately failing, try the acquire the lock a few times with a
small sleep between attempts. This ensures that most requests will go
through without issue.

Additionally, return -EBUSY instead of -EFAULT if the operation can't
continue due to the semaphore being busy.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 81d96a40d5a7..e75bb6e7d680 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1976,11 +1976,21 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 	u32 hh_lock, hh_art_ctl;
 	int i;
 
-	/* Get the HW lock */
-	hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
+#define MAX_HH_HW_LOCK_TRIES	5
+#define MAX_HH_CTL_LOCK_TRIES	100
+
+	for (i = 0; i < MAX_HH_HW_LOCK_TRIES; i++) {
+		/* Get the HW lock */
+		hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
+		if (hh_lock & PFHH_SEM_BUSY_M) {
+			usleep_range(10000, 15000);
+			continue;
+		}
+		break;
+	}
 	if (hh_lock & PFHH_SEM_BUSY_M) {
 		dev_err(ice_pf_to_dev(pf), "PTP failed to get hh lock\n");
-		return -EFAULT;
+		return -EBUSY;
 	}
 
 	/* Start the ART and device clock sync sequence */
@@ -1988,9 +1998,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 	hh_art_ctl = hh_art_ctl | GLHH_ART_CTL_ACTIVE_M;
 	wr32(hw, GLHH_ART_CTL, hh_art_ctl);
 
-#define MAX_HH_LOCK_TRIES 100
-
-	for (i = 0; i < MAX_HH_LOCK_TRIES; i++) {
+	for (i = 0; i < MAX_HH_CTL_LOCK_TRIES; i++) {
 		/* Wait for sync to complete */
 		hh_art_ctl = rd32(hw, GLHH_ART_CTL);
 		if (hh_art_ctl & GLHH_ART_CTL_ACTIVE_M) {
@@ -2019,7 +2027,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 	hh_lock = hh_lock & ~PFHH_SEM_BUSY_M;
 	wr32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), hh_lock);
 
-	if (i == MAX_HH_LOCK_TRIES)
+	if (i == MAX_HH_CTL_LOCK_TRIES)
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.38.1


