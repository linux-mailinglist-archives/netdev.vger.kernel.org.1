Return-Path: <netdev+bounces-32896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0079AABB
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C31C209C9
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F9156F7;
	Mon, 11 Sep 2023 18:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A515AD1
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5E103
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455863; x=1725991863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0IYqdEnPAY0K2ZlxE1BnknG1N6HJWqJLl0/gn0L278=;
  b=foFcDo/OL69D7lUBQv0uTT0g87GWnX5Zh7nkd2XHz62c45I0fgAtDLNE
   kTngfSSGtxdBHXJXJjkDcid2raMmzx5kveNu2XihWZ/IQQT+ZWzSqNCbw
   Jqk0vCNW+F1taJOCDTsfQ9UmBEVadXTlbh5QdmOABL61XI04TzmAdWCcN
   fAVYCZPj6eypbW/wPLIOZe8P/9KFWN41FKSjYXaiE4hLWyTaDbprmk5US
   DCnhDbr9LgKcwL1Qw5KDYfGVQkzcbfatHfnfmnRaJORnKEMCY0UFhh4mz
   pOJaUowRKWpwE+HckzFffPgSbDkCk/PP9big9wafSvvy2yYt5f2y/IrLC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075616"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075616"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129929"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129929"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 03/13] ice: Support cross-timestamping for E823 devices
Date: Mon, 11 Sep 2023 11:03:04 -0700
Message-Id: <20230911180314.4082659-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

The E822 hardware has cross timestamping support using a device feature
termed "Hammock Harbor" by the data sheet. This device feature is similar
to PCIe PTM, and captures the Always Running Timer (ART) simultaneously
with the PTP hardware clock time.

This functionality also exists on E823 devices, but is not currently
enabled.

Rename the cross-timestamp functions to use the _e82x postfix, indicating
that the support works across the E82x family of devices and not just the
E822 hardware.

The flow for capturing a cross-timestamp requires an additional step on
E823 devices. The GLTSYN_CMD register must be programmed with the READ_TIME
command. Otherwise, the cross timestamp will always report a value of zero
for the PTP hardware clock time.

To fix this, call ice_ptp_src_cmd() prior to initiating the cross timestamp
logic. Once the cross timestamp has completed, call ice_ptp_src_cmd() with
ICE_PTP_OP to ensure that the timer command registers are cleared.

Co-developed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 29 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e75bb6e7d680..cda674645a7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1993,6 +1993,9 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 		return -EBUSY;
 	}
 
+	/* Program cmd to master timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
+
 	/* Start the ART and device clock sync sequence */
 	hh_art_ctl = rd32(hw, GLHH_ART_CTL);
 	hh_art_ctl = hh_art_ctl | GLHH_ART_CTL_ACTIVE_M;
@@ -2022,6 +2025,10 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			break;
 		}
 	}
+
+	/* Clear the master timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	/* Release HW lock */
 	hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
 	hh_lock = hh_lock & ~PFHH_SEM_BUSY_M;
@@ -2034,7 +2041,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 }
 
 /**
- * ice_ptp_getcrosststamp_e822 - Capture a device cross timestamp
+ * ice_ptp_getcrosststamp_e82x - Capture a device cross timestamp
  * @info: the driver's PTP info structure
  * @cts: The memory to fill the cross timestamp info
  *
@@ -2042,14 +2049,14 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
  * clock. Fill the cross timestamp information and report it back to the
  * caller.
  *
- * This is only valid for E822 devices which have support for generating the
- * cross timestamp via PCIe PTM.
+ * This is only valid for E822 and E823 devices which have support for
+ * generating the cross timestamp via PCIe PTM.
  *
  * In order to correctly correlate the ART timestamp back to the TSC time, the
  * CPU must have X86_FEATURE_TSC_KNOWN_FREQ.
  */
 static int
-ice_ptp_getcrosststamp_e822(struct ptp_clock_info *info,
+ice_ptp_getcrosststamp_e82x(struct ptp_clock_info *info,
 			    struct system_device_crosststamp *cts)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
@@ -2283,22 +2290,22 @@ ice_ptp_setup_pins_e823(struct ice_pf *pf, struct ptp_clock_info *info)
 }
 
 /**
- * ice_ptp_set_funcs_e822 - Set specialized functions for E822 support
+ * ice_ptp_set_funcs_e82x - Set specialized functions for E82x support
  * @pf: Board private structure
  * @info: PTP info to fill
  *
- * Assign functions to the PTP capabiltiies structure for E822 devices.
+ * Assign functions to the PTP capabiltiies structure for E82x devices.
  * Functions which operate across all device families should be set directly
- * in ice_ptp_set_caps. Only add functions here which are distinct for E822
+ * in ice_ptp_set_caps. Only add functions here which are distinct for E82x
  * devices.
  */
 static void
-ice_ptp_set_funcs_e822(struct ice_pf *pf, struct ptp_clock_info *info)
+ice_ptp_set_funcs_e82x(struct ice_pf *pf, struct ptp_clock_info *info)
 {
 #ifdef CONFIG_ICE_HWTS
 	if (boot_cpu_has(X86_FEATURE_ART) &&
 	    boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
-		info->getcrosststamp = ice_ptp_getcrosststamp_e822;
+		info->getcrosststamp = ice_ptp_getcrosststamp_e82x;
 #endif /* CONFIG_ICE_HWTS */
 }
 
@@ -2332,6 +2339,8 @@ ice_ptp_set_funcs_e810(struct ice_pf *pf, struct ptp_clock_info *info)
 static void
 ice_ptp_set_funcs_e823(struct ice_pf *pf, struct ptp_clock_info *info)
 {
+	ice_ptp_set_funcs_e82x(pf, info);
+
 	info->enable = ice_ptp_gpio_enable_e823;
 	ice_ptp_setup_pins_e823(pf, info);
 }
@@ -2359,7 +2368,7 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	else if (ice_is_e823(&pf->hw))
 		ice_ptp_set_funcs_e823(pf, info);
 	else
-		ice_ptp_set_funcs_e822(pf, info);
+		ice_ptp_set_funcs_e82x(pf, info);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index d62016111c84..39cf1e734113 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -107,7 +107,7 @@ static u64 ice_ptp_read_src_incval(struct ice_hw *hw)
  *
  * Prepare the source timer for an upcoming timer sync command.
  */
-static void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
+void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
 	u32 cmd_val;
 	u8 tmr_idx;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3e4e91322c72..dc1d398da7a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -131,6 +131,7 @@ extern const struct ice_vernier_info_e822 e822_vernier[NUM_ICE_PTP_LNK_SPD];
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
 bool ice_ptp_lock(struct ice_hw *hw);
 void ice_ptp_unlock(struct ice_hw *hw);
+void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd);
 int ice_ptp_init_time(struct ice_hw *hw, u64 time);
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval);
 int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval);
-- 
2.38.1


