Return-Path: <netdev+bounces-32903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B36879AAC2
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53DA2812E9
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC66016419;
	Mon, 11 Sep 2023 18:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F016411
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE110F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455866; x=1725991866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1q++ew+unm7UrUurwdaxhMgf2XeJXFU2VmHJbCeD8b0=;
  b=ifbl57sI68OJzpWRNfDJDBwk2nBzwNMp+ySSgdcwCj2zNfI5bJETTEcb
   Ge8aFYMJ0r7cOH2OmRYQpDXImjUefnTsED8R/db4LGYALUh8gEIRdQHDh
   u8zd1eBq8vibDf6rb5AXeWPzig6Keb7yyzCx3G/MuWqg3S6fqZrMsGr4C
   OBNFzgicMhyKz7wSUR3fnzddC+356onPMH/9uoNttZ4CGH614B+ht485j
   i9Nd87jX0HKjPGB5EkPYebLRImPaBjTJDDW3Y2p9bRNZpdlDGiFyAdfNq
   L/kOfiKb6nC3mP/KEqgbNmzMF8gEdGJ3D3oNB7RN39Tbyohdi+jlL26TV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075676"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129956"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129956"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:02 -0700
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
Subject: [PATCH net-next 11/13] ice: don't enable PTP related capabilities on non-owner PFs
Date: Mon, 11 Sep 2023 11:03:12 -0700
Message-Id: <20230911180314.4082659-12-anthony.l.nguyen@intel.com>
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

The ice driver currently sets feature flags for certain PTP related
capabilities based on whether the device has support for the feature. Avoid
enabling these capabilities except on the ports which own the timer. This
ensures that the driver never attempts to access the features except on the
ports designated as controlling the main timer functionality.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5dfcb824f817..f29ff54383b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3986,6 +3986,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 	case ICE_DEV_ID_E810C_QSFP:
 	case ICE_DEV_ID_E810C_SFP:
 		ice_set_feature_support(pf, ICE_F_DSCP);
+		/* If we don't own the timer - don't enable other caps */
+		if (!ice_pf_src_tmr_owned(pf))
+			break;
 		if (ice_is_e810t(&pf->hw)) {
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
 			if (ice_gnss_is_gps_present(&pf->hw))
-- 
2.38.1


