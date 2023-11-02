Return-Path: <netdev+bounces-45768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3777DF721
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE811C20EF9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AFA1CAA2;
	Thu,  2 Nov 2023 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3tChDEy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF11D529
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:56:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA712E
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698940567; x=1730476567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/HOS4o57OIc05Uh+PE17GQ53W44y+VwquMnvqen8CPw=;
  b=S3tChDEypoCGnAd2wrcFYXAm35CtZAb5IZNlZ08qAe+hEjEuq6q5dK1g
   FvN40lx5mq0755+SrP16Ue0PmpB13YAc58PIKLnoKrCDYLOTofY6Dtlr2
   mLso1aqvRwFfmH4FGcjHIdTRPa33t0d0Ixyp/pzo8FpEiNceGeHxhiTUX
   C9BEhitleoStkFRQfwPy/CN5O6vwEOUnV2RbQgyvN0CmP0tPOFzB3X0wo
   L7bFitt0ZmTILHW1n7/eOsswHPSPPt/hxoxVqfjr6DxD/iVkHZmW+V4Eb
   BekOUVc0t+SKiPH2ZeRgJ8NuMj5kXVvdpn3uxVsRGS4XuIYJCG9TPKJkz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388559553"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388559553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796278345"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="796278345"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 02 Nov 2023 08:55:41 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 106FF122E3;
	Thu,  2 Nov 2023 15:55:40 +0000 (GMT)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	lukasz.czapnik@intel.com,
	Liang-Min Wang <liang-min.wang@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2] ice: Reset VF on Tx MDD event
Date: Thu,  2 Nov 2023 16:51:49 +0100
Message-Id: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang-Min Wang <liang-min.wang@intel.com>

In cases when VF sends malformed packets that are classified as malicious,
sometimes it causes Tx queue to freeze. This frozen queue can be stuck
for several minutes being unusable. This behavior can be reproduced with
DPDK application, testpmd.

When Malicious Driver Detection event occurs, perform graceful VF reset
to quickly bring VF back to operational state. Add a log message to
notify about the cause of the reset.

Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
Changelog
v1->v2:
Reverted unneeded formatting change, fixed commit message, fixed a log
message with a correct event name.
---

 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3c9419b05a2a..ee9752af6397 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1839,6 +1839,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_TCLAN detected on VF %d\n",
 					 vf->vf_id);
+			dev_info(dev,
+				 "PF-to-VF reset on VF %d due to Tx MDD TX_TCLAN event\n",
+				 vf->vf_id);
+			ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 		}
 
 		reg = rd32(hw, VP_MDET_TX_TDPU(vf->vf_id));
@@ -1849,6 +1853,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_TDPU detected on VF %d\n",
 					 vf->vf_id);
+			dev_info(dev,
+				 "PF-to-VF reset on VF %d due to Tx MDD TX_TDPU event\n",
+				 vf->vf_id);
+			ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 		}
 
 		reg = rd32(hw, VP_MDET_RX(vf->vf_id));
-- 
2.37.3


