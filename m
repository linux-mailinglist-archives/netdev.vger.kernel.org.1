Return-Path: <netdev+bounces-26274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E777760F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE01281F7C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785851FB26;
	Thu, 10 Aug 2023 10:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE021F958
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:38:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6876510E6;
	Thu, 10 Aug 2023 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691663926; x=1723199926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BF7cE5dz2JhMGxpxJeiyh6dv9ygPGiyynieI2gJHd/Y=;
  b=hOAGCY0GcwlSnFL6Xdwk/a9MVdtJbdW6Qa1Uw/74FzVFbGV3IUdXMb1Y
   WpIStrJ8k8WAVIYi9JLVC7RTxNdRfgkQY8l3BHV1GJIhkwTfc2C3OVK+a
   cZXEiiwlAAYFf/KwpIRVDLwwuk0FgJ1nJ8zfg82beIHmuAm7BQ+fzB6rX
   jUqUmhsP0xfFwN7LjiuF5masvVCyuSWzw39stD7oJPT0aBAqDV2uTzjRQ
   /3nl5afsvXPjQ8zyopbx6npMzgjmeeTOCTfg3W5Sn/8w4oFCBxlXrsGRO
   HxmIV/3SN5YFh+TLSHKUVblfkRpPhOKB4aT5Txd9hcwXGD58OPLADTxf9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260824"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370260824"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237177"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="767237177"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:43 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 39EBE340DA;
	Thu, 10 Aug 2023 11:38:43 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v1 6/7] ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
Date: Thu, 10 Aug 2023 06:35:08 -0400
Message-Id: <20230810103509.163225-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use DEFINE_FLEX() macro for 1-elem flex array use case
of struct ice_aqc_dis_txq_item.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 1/1 up/down: 9/-18 (-9)
---
 drivers/net/ethernet/intel/ice/ice_common.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a86255b529a0..ca30316d70a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4734,11 +4734,11 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 i, buf_size = const_flex_size(qg_list);
 	struct ice_q_ctx *q_ctx;
 	int status = -ENOENT;
 	struct ice_hw *hw;
-	u16 i, buf_size;
 
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return -EIO;
@@ -4756,11 +4756,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		return -EIO;
 	}
 
-	buf_size = struct_size(qg_list, q_id, 1);
-	qg_list = kzalloc(buf_size, GFP_KERNEL);
-	if (!qg_list)
-		return -ENOMEM;
-
 	mutex_lock(&pi->sched_lock);
 
 	for (i = 0; i < num_queues; i++) {
@@ -4793,7 +4788,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		q_ctx->q_teid = ICE_INVAL_TEID;
 	}
 	mutex_unlock(&pi->sched_lock);
-	kfree(qg_list);
 	return status;
 }
 
@@ -4962,22 +4956,17 @@ int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 qg_size = const_flex_size(qg_list);
 	struct ice_hw *hw;
 	int status = 0;
-	u16 qg_size;
 	int i;
 
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return -EIO;
 
 	hw = pi->hw;
 
-	qg_size = struct_size(qg_list, q_id, 1);
-	qg_list = kzalloc(qg_size, GFP_KERNEL);
-	if (!qg_list)
-		return -ENOMEM;
-
 	mutex_lock(&pi->sched_lock);
 
 	for (i = 0; i < count; i++) {
@@ -5002,7 +4991,6 @@ ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 	}
 
 	mutex_unlock(&pi->sched_lock);
-	kfree(qg_list);
 	return status;
 }
 
-- 
2.40.1


