Return-Path: <netdev+bounces-12421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17E737755
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 00:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD6B28137C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCD18B03;
	Tue, 20 Jun 2023 22:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676E18B00
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 22:17:22 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23110D0
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687299441; x=1718835441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A+Bitwg7iClPPL97PhwjmxcUejv5OxVKQNur3h6ohxg=;
  b=V8ZTQJphtqqtzuM8k720bTAo4sxrUZL1tRIySRO1G/5Z3M/h+HuNlCVD
   JRJvcEoMxNahdTjX9fogw/t5Nc/1L3DrtMtDfYecSnPK9/4bseoJflW4z
   lyTkzN6FfawUU4h6sLiavK0j/cIf/IX2W69xEAgQXsHm+kyb7nZ9XOH4C
   R1kScaI5bu2f143oOrFuBGlq6vl6xoCtEFavLFcp8vG/9M3QFcxkqJT6m
   GB8OHSM+E/d+LGN+nZUxIASkEJedM0XV3w7g/nPSu2/qwbgzXxdaCQY1j
   BSQr3mwLq5IcD5osGbXZTTzFOgWUGZpAauKUn7vVX2DVzWTkmNpxs9B4s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358869095"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="358869095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="858744949"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="858744949"
Received: from dmert-dev.jf.intel.com ([10.166.241.14])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:17:17 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	daniel.machon@microchip.com,
	simon.horman@corigine.com,
	bcreeley@amd.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v6 01/10] ice: Correctly initialize queue context values
Date: Tue, 20 Jun 2023 15:18:45 -0700
Message-Id: <20230620221854.848606-2-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620221854.848606-1-david.m.ertman@intel.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_alloc_lan_q_ctx function allocates the queue context array for a
given traffic class. This function uses devm_kcalloc which will
zero-allocate the structure. Thus, prior to any queue being setup by
ice_ena_vsi_txq, the q_ctx structure will have a q_handle of 0 and a q_teid
of 0. These are potentially valid values.

Modify the ice_alloc_lan_q_ctx function to initialize every member of the
q_ctx array to have invalid values. Modify ice_dis_vsi_txq to ensure that
it assigns q_teid to an invalid value when it assigns q_handle to the
invalid value as well.

This will allow other code to check whether the queue context is currently
valid before operating on it.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  1 +
 drivers/net/ethernet/intel/ice/ice_sched.c  | 23 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7a9e88f3f4b5..afcbcf0ae8ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4673,6 +4673,7 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 			break;
 		ice_free_sched_node(pi, node);
 		q_ctx->q_handle = ICE_INVAL_Q_HANDLE;
+		q_ctx->q_teid = ICE_INVAL_TEID;
 	}
 	mutex_unlock(&pi->sched_lock);
 	kfree(qg_list);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index b664d60fd037..79a8972873f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -569,18 +569,24 @@ ice_alloc_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 new_numqs)
 {
 	struct ice_vsi_ctx *vsi_ctx;
 	struct ice_q_ctx *q_ctx;
+	u16 idx;
 
 	vsi_ctx = ice_get_vsi_ctx(hw, vsi_handle);
 	if (!vsi_ctx)
 		return -EINVAL;
 	/* allocate LAN queue contexts */
 	if (!vsi_ctx->lan_q_ctx[tc]) {
-		vsi_ctx->lan_q_ctx[tc] = devm_kcalloc(ice_hw_to_dev(hw),
-						      new_numqs,
-						      sizeof(*q_ctx),
-						      GFP_KERNEL);
-		if (!vsi_ctx->lan_q_ctx[tc])
+		q_ctx = devm_kcalloc(ice_hw_to_dev(hw), new_numqs,
+				     sizeof(*q_ctx), GFP_KERNEL);
+		if (!q_ctx)
 			return -ENOMEM;
+
+		for (idx = 0; idx < new_numqs; idx++) {
+			q_ctx[idx].q_handle = ICE_INVAL_Q_HANDLE;
+			q_ctx[idx].q_teid = ICE_INVAL_TEID;
+		}
+
+		vsi_ctx->lan_q_ctx[tc] = q_ctx;
 		vsi_ctx->num_lan_q_entries[tc] = new_numqs;
 		return 0;
 	}
@@ -592,9 +598,16 @@ ice_alloc_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 new_numqs)
 				     sizeof(*q_ctx), GFP_KERNEL);
 		if (!q_ctx)
 			return -ENOMEM;
+
 		memcpy(q_ctx, vsi_ctx->lan_q_ctx[tc],
 		       prev_num * sizeof(*q_ctx));
 		devm_kfree(ice_hw_to_dev(hw), vsi_ctx->lan_q_ctx[tc]);
+
+		for (idx = prev_num; idx < new_numqs; idx++) {
+			q_ctx[idx].q_handle = ICE_INVAL_Q_HANDLE;
+			q_ctx[idx].q_teid = ICE_INVAL_TEID;
+		}
+
 		vsi_ctx->lan_q_ctx[tc] = q_ctx;
 		vsi_ctx->num_lan_q_entries[tc] = new_numqs;
 	}
-- 
2.40.1


