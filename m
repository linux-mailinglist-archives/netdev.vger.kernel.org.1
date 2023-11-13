Return-Path: <netdev+bounces-47543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F87EA732
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5E8280C6A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00983E476;
	Mon, 13 Nov 2023 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKAi6KWp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBB3E461
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:59:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A69D8F
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699919944; x=1731455944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fH4JpMdDEZAExostlD6al4nlrb0YZR0fPX257O4FYuM=;
  b=TKAi6KWptnvhumVHp9f7356SqInLHQhWqrsFCxcbSmqFomWJnXQh0TRF
   uB2cgp0LRsO8rrO6lnAgGMaRvS4yjzywEP4WrNw7i1l6Fq4PaqxZqhhwm
   eRNmD6Z0d8j0DkccPBHVcprnRC53Apg99E6Ek5itAkgjokJt2OOMmrcXf
   k/st7EW4WNA5eqllcgD2CjOHlBH9AYkwZSHRhohMEutvfyOUyuTEMDgib
   itoxAIlUI5tW9m2FN2Wgxrvl5GSQKnMRHWH2QvIF68rxdCl4jdHY427qU
   ri3Q92hSld/ZHMHNuF/sxDd7ZER1SgRHUK8h3q4ZeN+Hjc9RLYNNBchfB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370728155"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370728155"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="5816389"
Received: from sbahadur1-bxdsw.sj.intel.com ([10.232.237.139])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:59:03 -0800
From: Sachin Bahadur <sachin.bahadur@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2] ice: Block PF reinit if attached to bond
Date: Mon, 13 Nov 2023 15:58:56 -0800
Message-Id: <20231113235856.772920-1-sachin.bahadur@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PF interface part of LAG should not allow driver reinit via devlink. The
Bond config will be lost due to driver reinit. ice_devlink_reload_down is
called before PF driver reinit. If PF is attached to bond,
ice_devlink_reload_down returns error.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index f4e24d11ebd0..5fe88e949b09 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 					   "Remove all VFs before doing reinit\n");
 			return -EOPNOTSUPP;
 		}
+		if (pf->lag && pf->lag->bonded) {
+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");
+			return -EBUSY;
+		}
 		ice_unload(pf);
 		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
-- 
2.25.1


