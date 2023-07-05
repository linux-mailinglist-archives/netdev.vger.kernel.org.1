Return-Path: <netdev+bounces-15645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847C748EBF
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05181C20C16
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D715AC2;
	Wed,  5 Jul 2023 20:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF715AC0
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:19:17 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE461993
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588355; x=1720124355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uxZZHSkeAOnfy3AFIOXIJyw0MFlNx3qtolsv99tzuxo=;
  b=LTpwwu/7Q6KXrOyHxT/qa6a6AHywwdj0JfQf5GEdVTnXuSgI5+mKUHJ+
   m+uKQjAHUyEZFqNBODep+TsUi/DYkBrBQ53VmM0eYniLr2CDxIiS1CUxi
   1j9SYhHkPX5dX+HtPQJN2MRtTqN5xm5QtwxXvYoh27Qw1ftCvFP0fzOPe
   Ql6TPuLKndV5SVjknE0Mkua4pjmAyDL3I6wWIyijH8r9hNQ9H1N6GQhec
   g7tCOgM7gTOu+7TOpM1qmwq1/Z5U/mk0iToE13Cph0G7dIvbL89l6wYVV
   1Ivz3PKp4ModlLhNiMgoM05AMJ+ry65auGwxdW02Xl0GA/RtENN1wovwh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427117972"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="427117972"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="965944745"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="965944745"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2023 13:19:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	anthony.l.nguyen@intel.com,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Subject: [PATCH net 2/2] ice: Fix tx queue rate limit when TCs are configured
Date: Wed,  5 Jul 2023 13:13:46 -0700
Message-Id: <20230705201346.49370-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
References: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
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

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

Configuring tx_maxrate via sysfs interface
/sys/class/net/eth0/queues/tx-1/tx_maxrate was not working when
TCs are configured because always main VSI was being used. Fix by
using correct VSI in ice_set_tx_maxrate when TCs are configured.

Fixes: 1ddef455f4a8 ("ice: Add NDO callback to set the maximum per-queue bitrate")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  7 +++++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 22 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 64efe4c83a3e..19a5e7f3a075 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5739,6 +5739,13 @@ ice_set_tx_maxrate(struct net_device *netdev, int queue_index, u32 maxrate)
 	q_handle = vsi->tx_rings[queue_index]->q_handle;
 	tc = ice_dcb_get_tc(vsi, queue_index);
 
+	vsi = ice_locate_vsi_using_queue(vsi, queue_index);
+	if (!vsi) {
+		netdev_err(netdev, "Invalid VSI for given queue %d\n",
+			   queue_index);
+		return -EINVAL;
+	}
+
 	/* Set BW back to default, when user set maxrate to 0 */
 	if (!maxrate)
 		status = ice_cfg_q_bw_dflt_lmt(vsi->port_info, vsi->idx, tc,
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index b54052ef6050..4a34ef5f58d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -750,17 +750,16 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 /**
  * ice_locate_vsi_using_queue - locate VSI using queue (forward to queue action)
  * @vsi: Pointer to VSI
- * @tc_fltr: Pointer to tc_flower_filter
+ * @queue: Queue index
  *
- * Locate the VSI using specified queue. When ADQ is not enabled, always
- * return input VSI, otherwise locate corresponding VSI based on per channel
- * offset and qcount
+ * Locate the VSI using specified "queue". When ADQ is not enabled,
+ * always return input VSI, otherwise locate corresponding
+ * VSI based on per channel "offset" and "qcount"
  */
-static struct ice_vsi *
-ice_locate_vsi_using_queue(struct ice_vsi *vsi,
-			   struct ice_tc_flower_fltr *tc_fltr)
+struct ice_vsi *
+ice_locate_vsi_using_queue(struct ice_vsi *vsi, int queue)
 {
-	int num_tc, tc, queue;
+	int num_tc, tc;
 
 	/* if ADQ is not active, passed VSI is the candidate VSI */
 	if (!ice_is_adq_active(vsi->back))
@@ -770,7 +769,6 @@ ice_locate_vsi_using_queue(struct ice_vsi *vsi,
 	 * upon queue number)
 	 */
 	num_tc = vsi->mqprio_qopt.qopt.num_tc;
-	queue = tc_fltr->action.fwd.q.queue;
 
 	for (tc = 0; tc < num_tc; tc++) {
 		int qcount = vsi->mqprio_qopt.qopt.count[tc];
@@ -812,6 +810,7 @@ ice_tc_forward_action(struct ice_vsi *vsi, struct ice_tc_flower_fltr *tc_fltr)
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
 	u32 tc_class;
+	int q;
 
 	dev = ice_pf_to_dev(pf);
 
@@ -840,7 +839,8 @@ ice_tc_forward_action(struct ice_vsi *vsi, struct ice_tc_flower_fltr *tc_fltr)
 		/* Determine destination VSI even though the action is
 		 * FWD_TO_QUEUE, because QUEUE is associated with VSI
 		 */
-		dest_vsi = tc_fltr->dest_vsi;
+		q = tc_fltr->action.fwd.q.queue;
+		dest_vsi = ice_locate_vsi_using_queue(vsi, q);
 		break;
 	default:
 		dev_err(dev,
@@ -1716,7 +1716,7 @@ ice_tc_forward_to_queue(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr,
 	/* If ADQ is configured, and the queue belongs to ADQ VSI, then prepare
 	 * ADQ switch filter
 	 */
-	ch_vsi = ice_locate_vsi_using_queue(vsi, fltr);
+	ch_vsi = ice_locate_vsi_using_queue(vsi, fltr->action.fwd.q.queue);
 	if (!ch_vsi)
 		return -EINVAL;
 	fltr->dest_vsi = ch_vsi;
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 8bbc1a62bdb1..65d387163a46 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -204,6 +204,7 @@ static inline int ice_chnl_dmac_fltr_cnt(struct ice_pf *pf)
 	return pf->num_dmac_chnl_fltrs;
 }
 
+struct ice_vsi *ice_locate_vsi_using_queue(struct ice_vsi *vsi, int queue);
 int
 ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		   struct flow_cls_offload *cls_flower);
-- 
2.38.1


