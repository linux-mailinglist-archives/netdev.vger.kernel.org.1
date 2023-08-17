Return-Path: <netdev+bounces-28624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548377FFF5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330B21C21526
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E421ED3B;
	Thu, 17 Aug 2023 21:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D21ED3A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E67E56
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307781; x=1723843781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLNirPooxwha0VJqtrlOrnEqbDPh19etH/s+t/bvl1M=;
  b=jWZIT+Umm6H+yBJ2dNN0tXoH9k4izYSJf45O97ap47PQEJam0EQ+zkEO
   DcqvxqD7KwL4DRcF2ejmZHH0946iNmvsGXEDUmfsM2DxvNvHqmKoiWJze
   HjBAKPTF5nUysbOgbMaENPE3QSU/6nIwr8uWWkMwN4kmJMTIEmqvf6XYK
   A7gAiNjAV2K4u7BRH/gqJMjPSeTdd+sDrHMLOWerMk7iJmPMgBId/IxjF
   8rEH96lR7hnpKbtOJIVJ1Mj8sF0X5YLOWMt7JKy6Ax5OuUX7RcmToV/2B
   46qppAOGOlCbH37ICRsbWM1R8MKBHc/UYTiAAlmgaxA4+644597okj7ak
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095125"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095125"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813742"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813742"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 14/15] ice: embed &ice_rq_event_info event into struct ice_aq_task
Date: Thu, 17 Aug 2023 14:22:38 -0700
Message-Id: <20230817212239.2601543-15-anthony.l.nguyen@intel.com>
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

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Expose struct ice_aq_task to callers,
what takes burden of memory ownership out from AQ-wait family of functions,
and reduces need for heap-based allocations.

Embed struct ice_rq_event_info event into struct ice_aq_task
(instead of it being a ptr) to remove some more code from the callers.

Subsequent commit will improve more based on this one.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          | 18 +++++++-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 42 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_main.c     | 29 ++-----------
 3 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5ac0ad12f9f1..9a334287bd92 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -917,8 +917,22 @@ void ice_fdir_release_flows(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
-int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
-			  struct ice_rq_event_info *event);
+
+enum ice_aq_task_state {
+	ICE_AQ_TASK_WAITING,
+	ICE_AQ_TASK_COMPLETE,
+	ICE_AQ_TASK_CANCELED,
+};
+
+struct ice_aq_task {
+	struct hlist_node entry;
+	struct ice_rq_event_info event;
+	enum ice_aq_task_state state;
+	u16 opcode;
+};
+
+int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
+			  u16 opcode, unsigned long timeout);
 int ice_open(struct net_device *netdev);
 int ice_open_internal(struct net_device *netdev);
 int ice_stop(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 3dc5662d62a6..819b70823e9c 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -293,13 +293,12 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 {
 	u16 completion_module, completion_retval;
 	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_rq_event_info event;
+	struct ice_aq_task task = {};
 	struct ice_hw *hw = &pf->hw;
+	struct ice_aq_desc *desc;
 	u32 completion_offset;
 	int err;
 
-	memset(&event, 0, sizeof(event));
-
 	dev_dbg(dev, "Writing block of %u bytes for module 0x%02x at offset %u\n",
 		block_size, module, offset);
 
@@ -319,7 +318,7 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 	 * is conservative and is intended to prevent failure to update when
 	 * firmware is slow to respond.
 	 */
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write, 15 * HZ, &event);
+	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_write, 15 * HZ);
 	if (err) {
 		dev_err(dev, "Timed out while trying to flash module 0x%02x with block of size %u at offset %u, err %d\n",
 			module, block_size, offset, err);
@@ -327,11 +326,12 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 		return -EIO;
 	}
 
-	completion_module = le16_to_cpu(event.desc.params.nvm.module_typeid);
-	completion_retval = le16_to_cpu(event.desc.retval);
+	desc = &task.event.desc;
+	completion_module = le16_to_cpu(desc->params.nvm.module_typeid);
+	completion_retval = le16_to_cpu(desc->retval);
 
-	completion_offset = le16_to_cpu(event.desc.params.nvm.offset_low);
-	completion_offset |= event.desc.params.nvm.offset_high << 16;
+	completion_offset = le16_to_cpu(desc->params.nvm.offset_low);
+	completion_offset |= desc->params.nvm.offset_high << 16;
 
 	if (completion_module != module) {
 		dev_err(dev, "Unexpected module_typeid in write completion: got 0x%x, expected 0x%x\n",
@@ -363,8 +363,8 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 	 */
 	if (reset_level && last_cmd && module == ICE_SR_1ST_NVM_BANK_PTR) {
 		if (hw->dev_caps.common_cap.pcie_reset_avoidance) {
-			*reset_level = (event.desc.params.nvm.cmd_flags &
-					ICE_AQC_NVM_RESET_LVL_M);
+			*reset_level = desc->params.nvm.cmd_flags &
+				       ICE_AQC_NVM_RESET_LVL_M;
 			dev_dbg(dev, "Firmware reported required reset level as %u\n",
 				*reset_level);
 		} else {
@@ -479,15 +479,14 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 {
 	u16 completion_module, completion_retval;
 	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_rq_event_info event;
+	struct ice_aq_task task = {};
 	struct ice_hw *hw = &pf->hw;
+	struct ice_aq_desc *desc;
 	struct devlink *devlink;
 	int err;
 
 	dev_dbg(dev, "Beginning erase of flash component '%s', module 0x%02x\n", component, module);
 
-	memset(&event, 0, sizeof(event));
-
 	devlink = priv_to_devlink(pf);
 
 	devlink_flash_update_timeout_notify(devlink, "Erasing", component, ICE_FW_ERASE_TIMEOUT);
@@ -502,7 +501,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 		goto out_notify_devlink;
 	}
 
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_erase, ICE_FW_ERASE_TIMEOUT * HZ, &event);
+	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_erase, ICE_FW_ERASE_TIMEOUT * HZ);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to respond with erase completion for %s (module 0x%02x), err %d\n",
 			component, module, err);
@@ -510,8 +509,9 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 		goto out_notify_devlink;
 	}
 
-	completion_module = le16_to_cpu(event.desc.params.nvm.module_typeid);
-	completion_retval = le16_to_cpu(event.desc.retval);
+	desc = &task.event.desc;
+	completion_module = le16_to_cpu(desc->params.nvm.module_typeid);
+	completion_retval = le16_to_cpu(desc->retval);
 
 	if (completion_module != module) {
 		dev_err(dev, "Unexpected module_typeid in erase completion for %s: got 0x%x, expected 0x%x\n",
@@ -560,14 +560,12 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 		       u8 *emp_reset_available, struct netlink_ext_ack *extack)
 {
 	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_rq_event_info event;
+	struct ice_aq_task task = {};
 	struct ice_hw *hw = &pf->hw;
 	u16 completion_retval;
 	u8 response_flags;
 	int err;
 
-	memset(&event, 0, sizeof(event));
-
 	err = ice_nvm_write_activate(hw, activate_flags, &response_flags);
 	if (err) {
 		dev_err(dev, "Failed to switch active flash banks, err %d aq_err %s\n",
@@ -592,8 +590,8 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 		}
 	}
 
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write_activate, 30 * HZ,
-				    &event);
+	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_write_activate,
+				    30 * HZ);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to switch active flash banks, err %d\n",
 			err);
@@ -601,7 +599,7 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 		return err;
 	}
 
-	completion_retval = le16_to_cpu(event.desc.retval);
+	completion_retval = le16_to_cpu(task.event.desc.retval);
 	if (completion_retval) {
 		dev_err(dev, "Firmware failed to switch active flash banks aq_err %s\n",
 			ice_aq_str((enum ice_aq_err)completion_retval));
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 872bd5572294..b08be6700b2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1250,26 +1250,12 @@ ice_handle_link_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 	return status;
 }
 
-enum ice_aq_task_state {
-	ICE_AQ_TASK_WAITING = 0,
-	ICE_AQ_TASK_COMPLETE,
-	ICE_AQ_TASK_CANCELED,
-};
-
-struct ice_aq_task {
-	struct hlist_node entry;
-
-	u16 opcode;
-	struct ice_rq_event_info *event;
-	enum ice_aq_task_state state;
-};
-
 /**
  * ice_aq_wait_for_event - Wait for an AdminQ event from firmware
  * @pf: pointer to the PF private structure
+ * @task: ptr to task structure
  * @opcode: the opcode to wait for
  * @timeout: how long to wait, in jiffies
- * @event: storage for the event info
  *
  * Waits for a specific AdminQ completion event on the ARQ for a given PF. The
  * current thread will be put to sleep until the specified event occurs or
@@ -1281,22 +1267,16 @@ struct ice_aq_task {
  *
  * Returns: zero on success, or a negative error code on failure.
  */
-int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
-			  struct ice_rq_event_info *event)
+int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
+			  u16 opcode, unsigned long timeout)
 {
 	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_aq_task *task;
 	unsigned long start;
 	long ret;
 	int err;
 
-	task = kzalloc(sizeof(*task), GFP_KERNEL);
-	if (!task)
-		return -ENOMEM;
-
 	INIT_HLIST_NODE(&task->entry);
 	task->opcode = opcode;
-	task->event = event;
 	task->state = ICE_AQ_TASK_WAITING;
 
 	spin_lock_bh(&pf->aq_wait_lock);
@@ -1331,7 +1311,6 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 	spin_lock_bh(&pf->aq_wait_lock);
 	hlist_del(&task->entry);
 	spin_unlock_bh(&pf->aq_wait_lock);
-	kfree(task);
 
 	return err;
 }
@@ -1366,7 +1345,7 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 		if (task->state || task->opcode != opcode)
 			continue;
 
-		task_ev = task->event;
+		task_ev = &task->event;
 		memcpy(&task_ev->desc, &event->desc, sizeof(event->desc));
 		task_ev->msg_len = event->msg_len;
 
-- 
2.38.1


