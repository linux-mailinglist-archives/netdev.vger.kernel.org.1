Return-Path: <netdev+bounces-33214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A6079D0AF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDE11C20E23
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20629182CC;
	Tue, 12 Sep 2023 12:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E82182A1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:04:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA610D2;
	Tue, 12 Sep 2023 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694520249; x=1726056249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PCXzH8JJDaRgoFGvNdNnXQNwSzVXB7b6+V2gb/zaWHE=;
  b=JfiLJlELO+vSbJ4JC60Z1FWQU5ZBC/ji38s0PpUhyLUxgW05KMLCwjVX
   XIq9976xlIa4UY5touY4P+bPpR6GCZzweM0HFeTkKMEH/F4qKSQmIRqxg
   bojaAwrLfUmOBplmgMZgFEMNhK+GqPo5bO8ntZJkZ7hSlwgUkdyd+jacA
   etr2NHBnCB7/foDeuAJyRqbGjWkM5ZqJdKaLy8fqtgDm7xw5U0Gpo7RTL
   U75y42J79dTf5y2/y42STNtXXkC3IgFO2zl76D21XxCarcd5pOvtRSoyv
   UiLjFDBhZHEYqp4dMKSB7unQqzzAitTSatI24sT5bOI17LDlcP35mzUW9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378265486"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378265486"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720389779"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720389779"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2023 05:02:59 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9DC2A333E6;
	Tue, 12 Sep 2023 13:02:58 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Kees Cook <keescook@chromium.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 6/7] ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
Date: Tue, 12 Sep 2023 07:59:36 -0400
Message-Id: <20230912115937.1645707-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
References: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use DEFINE_FLEX() macro for 1-elem flex array use case
of struct ice_aqc_dis_txq_item.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 1/1 up/down: 9/-18 (-9)
---
 drivers/net/ethernet/intel/ice/ice_common.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 80deca45ab59..068079ab5e23 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4726,11 +4726,11 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 i, buf_size = __struct_size(qg_list);
 	struct ice_q_ctx *q_ctx;
 	int status = -ENOENT;
 	struct ice_hw *hw;
-	u16 i, buf_size;
 
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return -EIO;
@@ -4748,11 +4748,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		return -EIO;
 	}
 
-	buf_size = struct_size(qg_list, q_id, 1);
-	qg_list = kzalloc(buf_size, GFP_KERNEL);
-	if (!qg_list)
-		return -ENOMEM;
-
 	mutex_lock(&pi->sched_lock);
 
 	for (i = 0; i < num_queues; i++) {
@@ -4785,7 +4780,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		q_ctx->q_teid = ICE_INVAL_TEID;
 	}
 	mutex_unlock(&pi->sched_lock);
-	kfree(qg_list);
 	return status;
 }
 
@@ -4954,22 +4948,17 @@ int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 qg_size = __struct_size(qg_list);
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
@@ -4994,7 +4983,6 @@ ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 	}
 
 	mutex_unlock(&pi->sched_lock);
-	kfree(qg_list);
 	return status;
 }
 
-- 
2.40.1


