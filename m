Return-Path: <netdev+bounces-28614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85877FFE8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5900E281703
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2901BEEB;
	Thu, 17 Aug 2023 21:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21C1BEE7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BFE55
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307778; x=1723843778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2sp8SqFhMVbm4EVoHfIboaiptHkdk46GGLi27J7Y/Cs=;
  b=jF8fVd13VDCDphP1VAijPNNaC6w04cC8ODAha3Vln6Iogl1Y351nhb8V
   iNourEawdM2aCDmnWe1STqcJrWsJzYC59THvfvBn3UDbhXhXuOvEvx+bB
   UioaLbp11rGXr9NWDaNwDLBJ7QZD6fwmNaQy3i5usonTzvt7oeCbXuwBV
   VU5/d5D4X2cgDlyqLk9JvLEtjRkgoa1O01JLcXCl81QXYUtmTwMFELfmu
   77rxSCXyKNSHLlkdfW5QlmD5tIAlEJc/VetuGKBCEm0At92hkqV3Yfbcp
   w27i9emH/LmjEPlnJ6T4cUkXONb3cUlEuovAvbdtS0UtppifKj4iMCOKk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095065"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095065"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813708"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813708"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	leonro@nvidia.com
Subject: [PATCH net-next v2 05/15] ice: Utilize assign_bit() helper
Date: Thu, 17 Aug 2023 14:22:29 -0700
Message-Id: <20230817212239.2601543-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The if/else check for bit setting can be replaced by using the
assign_bit() helper so do so.

Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 20c4beaa05d8..b95931272b16 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -407,10 +407,7 @@ static int ice_vf_rebuild_host_tx_rate_cfg(struct ice_vf *vf)
  */
 static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
 {
-	if (vf->trusted)
-		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
-	else
-		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, vf->trusted);
 }
 
 /**
-- 
2.38.1


