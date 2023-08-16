Return-Path: <netdev+bounces-28215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CB77EB15
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DFE1C20E99
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0CD1AA70;
	Wed, 16 Aug 2023 20:54:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A211AA6C
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDB9E69
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219273; x=1723755273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDsjd1zQxS8JwC7/7q6nWLL/R3qSUKDZZ3n5B98MRf0=;
  b=BtgHGRwWbYNhxFYotkQ5fuaECfL0ixwMGTW4YGX1A9YJKmluhxlkA8un
   Cfb6Pi2D6/rbEyU+LqJaobDIK84IJHLYH6Y0z2j2q+h519qEGhWsf6ggg
   wzIsy3j/xUsIWut/UDWmRI1DCpftkRtZegQheyClm+0DJPJLiGwdFbN1a
   ehliSMD8YoVBSR1RTrAcyfSegQCivRSWVLLcw4HTU5T0/ujOqtpbC7wzC
   zcS6HrKhxVkdE1T9C1AfhJ4/CqbGSWnkPTRsdycC5tnPnuNNa2uqpaMMk
   oDOQs3+GcfGaKUJBh+2d70GvST3F5hjdbJke65tOiIZFT9vWL0NNo7gZW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604777"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626387"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626387"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 05/14] ice: refactor ice_sched to make functions static
Date: Wed, 16 Aug 2023 13:47:27 -0700
Message-Id: <20230816204736.1325132-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

As ice_sched_set_node_bw_lmt_per_tc is not used
outside of ice_sched, it can be made static.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_sched.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index f4677704b95e..c0533d7b66b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -3971,7 +3971,7 @@ ice_sched_get_node_by_id_type(struct ice_port_info *pi, u32 id,
  * This function sets BW limit of VSI or Aggregator scheduling node
  * based on TC information from passed in argument BW.
  */
-int
+static int
 ice_sched_set_node_bw_lmt_per_tc(struct ice_port_info *pi, u32 id,
 				 enum ice_agg_type agg_type, u8 tc,
 				 enum ice_rl_type rl_type, u32 bw)
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 8bd26353d76a..0055d9330c07 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -141,10 +141,6 @@ ice_cfg_vsi_bw_lmt_per_tc(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 int
 ice_cfg_vsi_bw_dflt_lmt_per_tc(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 			       enum ice_rl_type rl_type);
-int
-ice_sched_set_node_bw_lmt_per_tc(struct ice_port_info *pi, u32 id,
-				 enum ice_agg_type agg_type, u8 tc,
-				 enum ice_rl_type rl_type, u32 bw);
 int ice_cfg_rl_burst_size(struct ice_hw *hw, u32 bytes);
 int
 ice_sched_suspend_resume_elems(struct ice_hw *hw, u8 num_nodes, u32 *node_teids,
-- 
2.38.1


