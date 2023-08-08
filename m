Return-Path: <netdev+bounces-25586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72108774D78
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262722818F7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDE18049;
	Tue,  8 Aug 2023 21:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB571802A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:57:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461112D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691531837; x=1723067837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7kqg2MLNa1wwko72SfRleSYsvjVxljQs582Z0FL8Qw=;
  b=ezUaei7VJialVDa8rWaoPEhzL+zL61ovZXZJwSAEXG70mu2dSbWiNwIZ
   aJ++Ns0YfGQVOATE2D26YB+xDZHOWgRrudi4KVuJdj+0FQ2l0+Wcpb3N3
   qsSD2RJIl692FrpcAqQIL+YyIDhvGh1WFln1zdk111p4aVW3LMtiHx9/V
   3KaJdPjGk07lOdwsL6qnvzNt0tzlbcyRuSQ5rKo0jT4ql6P5f1zfobZD7
   Rt3N0GRTku9hQRAf9Gc9kyKuKVoN0XYEU+FQH0v+dZYfTN1O3wcjVyU+U
   vpeuLoX/OkxIFV/+WaV7Qe7TG5C3I1bsKis3+ms7IXp9JExtXcPUK8F7b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368420314"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="368420314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 14:57:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821569663"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="821569663"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 14:57:14 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1F43533BD6;
	Tue,  8 Aug 2023 22:57:13 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 2/3] ice: embed &ice_rq_event_info event into struct ice_aq_task
Date: Tue,  8 Aug 2023 17:54:16 -0400
Message-Id: <20230808215417.117910-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808215417.117910-1-przemyslaw.kitszel@intel.com>
References: <20230808215417.117910-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Expose struct ice_aq_task to callers,
what takes burden of memory ownership out from AQ-wait family of functions,
and reduces need for heap-based allocations.

Embed struct ice_rq_event_info event into struct ice_aq_task
(instead of it being a ptr). to remove some more code from the callers.

Subsequent commit will improve more based on this one.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

---
add/remove: 0/0 grow/shrink: 3/1 up/down: 266/-68 (198)
---
 drivers/net/ethernet/intel/ice/ice.h          | 18 +++++++-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 42 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_main.c     | 29 ++-----------
 3 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 34be1cb1e28f..bcd56ba908a7 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -931,8 +931,22 @@ void ice_fdir_release_flows(struct ice_hw *hw);
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
 
@@ -319,19 +318,20 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 	 * is conservative and is intended to prevent failure to update when
 	 * firmware is slow to respond.
 	 */
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write, 15 * HZ, &event);
+	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_write, 15 * HZ);
 	if (err) {
 		dev_err(dev, "Timed out while trying to flash module 0x%02x with block of size %u at offset %u, err %d\n",
 			module, block_size, offset, err);
 		NL_SET_ERR_MSG_MOD(extack, "Timed out waiting for firmware");
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
@@ -502,16 +501,17 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 		goto out_notify_devlink;
 	}
 
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_erase, ICE_FW_ERASE_TIMEOUT * HZ, &event);
+	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_erase, ICE_FW_ERASE_TIMEOUT * HZ);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to respond with erase completion for %s (module 0x%02x), err %d\n",
 			component, module, err);
 		NL_SET_ERR_MSG_MOD(extack, "Timed out waiting for firmware");
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
@@ -592,16 +590,16 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 		}
 	}
 
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write_activate, 30 * HZ,
-				    &event);
+	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_write_activate,
+				    30 * HZ);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to switch active flash banks, err %d\n",
 			err);
 		NL_SET_ERR_MSG_MOD(extack, "Timed out waiting for firmware");
 		return err;
 	}
 
-	completion_retval = le16_to_cpu(event.desc.retval);
+	completion_retval = le16_to_cpu(task.event.desc.retval);
 	if (completion_retval) {
 		dev_err(dev, "Firmware failed to switch active flash banks aq_err %s\n",
 			ice_aq_str((enum ice_aq_err)completion_retval));
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 279e7f790312..190be3d7cc6b 100644
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
2.40.1


