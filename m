Return-Path: <netdev+bounces-32901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBAF79AAC0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F8C1C20978
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043516406;
	Mon, 11 Sep 2023 18:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140B15AFC
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC910D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455866; x=1725991866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ThWWO5RkKG2+ouOSl0lt+owvAMkJ5vUYwcKzR45xKyo=;
  b=ZGS/TV7VR/2jb0Eqd5/eUIC9/1HQjOV3UvJ2gK3aPjzn34sl+WH0Ltws
   ROVTpuvc4X59cIIuz8kiAFlT7p+Anej0kRUWA3LyucXlWPBgMfLr2xPkD
   QLEqqolivQ0/oAAq4qWZPcmEtUtpDsy7u8zuZOXjaKElw92+1gxZvhbjQ
   aQQGRApDUkmuR+eo1FosJ02kzNwSxk4QtDT4nelq5IV4U8RCiM6iL21Wj
   DiiXbOhkZhVnssfdSZYhYB1UJ8Kni7XZNCmdzLxC25vSac8DldsSokNIR
   gaJYgBUlrLAUhOOrTwh+k2n31517K79Xb+/wZV7YrQyXf3FJc8DuyeJwR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075661"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075661"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129949"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129949"
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
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net-next 09/13] ice: fix pin assignment for E810-T without SMA control
Date: Mon, 11 Sep 2023 11:03:10 -0700
Message-Id: <20230911180314.4082659-10-anthony.l.nguyen@intel.com>
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

Since commit 43c4958a3ddb ("ice: Merge pin initialization of E810 and E810T
adapters"), the ice_ptp_setup_pins_e810() function has been used for both
E810 and E810-T devices. The new implementation only distinguishes between
whether the device has SMA control or not. It was assumed this is always
true for E810-T devices. In addition, it does not set the n_per_out value
appropriately when SMA control is enabled.

In some cases, the E810-T device may not have access to SMA control. In
that case, the E810-T device actually has access to fewer pins than a
standard E810 device.

Fix the implementation to correctly assign the appropriate pin counts for
E810-T devices both with and without SMA control. The mentioned commit
already includes the appropriate macro values for these pin counts but they
were unused.

Instead of assigning the default E810 values and then overwriting them,
handle the cases separately in order of E810-T with SMA, E810-T without
SMA, and then standard E810. This flow makes following the logic easier.

Fixes: 43c4958a3ddb ("ice: Merge pin initialization of E810 and E810T adapters")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
This is not sent as a fix to net because it is effectively meaningless
without the following change to conditionally enable or disable the
ICE_F_SMA_CTRL flag. Currently for E810-T devices the driver always enables
ICE_F_SMA_CTRL. On failure to setup SMA pins, the driver clears all pin
functionality. Thus, this change does in some sense fix the mentioned
commit, but is not sufficient to meaningfully change behavior on its own as
it depends on the change to only enable SMA control when the device has
access according to the netlist.

 drivers/net/ethernet/intel/ice/ice_ptp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 066e7aadfa97..7ae1f1abe965 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2267,16 +2267,20 @@ ice_ptp_setup_sma_pins_e810t(struct ice_pf *pf, struct ptp_clock_info *info)
 static void
 ice_ptp_setup_pins_e810(struct ice_pf *pf, struct ptp_clock_info *info)
 {
-	info->n_per_out = N_PER_OUT_E810;
-	info->n_ext_ts = N_EXT_TS_E810;
-
 	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
 		info->n_ext_ts = N_EXT_TS_E810;
+		info->n_per_out = N_PER_OUT_E810T;
 		info->n_pins = NUM_PTP_PINS_E810T;
 		info->verify = ice_verify_pin_e810t;
 
 		/* Complete setup of the SMA pins */
 		ice_ptp_setup_sma_pins_e810t(pf, info);
+	} else if (ice_is_e810t(&pf->hw)) {
+		info->n_ext_ts = N_EXT_TS_NO_SMA_E810T;
+		info->n_per_out = N_PER_OUT_NO_SMA_E810T;
+	} else {
+		info->n_per_out = N_PER_OUT_E810;
+		info->n_ext_ts = N_EXT_TS_E810;
 	}
 }
 
-- 
2.38.1


