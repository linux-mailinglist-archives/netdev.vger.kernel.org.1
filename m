Return-Path: <netdev+bounces-37566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8C7B606B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5B0A8B20986
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20801375;
	Tue,  3 Oct 2023 05:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34E10FD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 05:32:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4383B3;
	Mon,  2 Oct 2023 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696311122; x=1727847122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFMy4xx+Sj2GKtLX3a/Sf+EbgsqvUQF1nDj0BB8WZTA=;
  b=bBrfpu3bPM9R03EYig3/RSz2CzlPi7wPZzNCnh4jEUFcNbO1jtJjW6/K
   hiUQruuOZKJWwWUOAWFV+YWCdb2/FOkdmmhS/cCoDhhNW9M3UAWkLi7PI
   +HIMtxVSmmsr24q9ycX8OtT1ZC0ebrznhKwmRGRVsucXKq9rDnprs0SmC
   khhak0NWTKpxpX0K9nkAch+CUeSiPv0wqYs5xOrdIx6znHJI4kc2gRi07
   NHudRUAJW5L169UkyrNjgF6RC5RWcna5RjlLJxXVZnIWHEf2AAFsjdDRI
   jx/s40QGiwWnsP02/DCMiIvYjqkJCcvDNVPR2056kLX8f3mZIRpkuJ15G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1385306"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1385306"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081881159"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081881159"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:32:00 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1] ice: fix over-shifted variable
Date: Mon,  2 Oct 2023 22:31:10 -0700
Message-Id: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
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

Since the introduction of the ice driver the code has been
double-shifting the RSS enabling field, because the define already has
shifts in it and can't have the regular pattern of "a << shiftval &
mask" applied.

Most places in the code got it right, but one line was still wrong. Fix
this one location for easy backports to stable. An in-progress patch
fixes the defines to "standard" and will be applied as part of the
regular -next process sometime after this one.

Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: stable@vger.kernel.org
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 201570cd2e0b..0aac519cc298 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1201,8 +1201,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 static void

base-commit: 6a70e5cbedaf8ad10528ac9ac114f3ec20f422df
-- 
2.39.3


