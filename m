Return-Path: <netdev+bounces-25587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E606774D7A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024B12814CF
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D6E198A6;
	Tue,  8 Aug 2023 21:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F311773F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:57:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A6EE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691531839; x=1723067839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRHNJn65eDHmYFzdYXkjypozXpmLNgwKamLMhDh3sH4=;
  b=Da29R9QjNyBklkF3FFMpQX9R8N71GDGedNSO5tkDMJkoj1SJjlrRiIl8
   ZOBRHswbKTkdDgnvOTlBxL02xvjst18EqwWGzQ1JrJ0uRpOvja8HPkYk0
   xjbPwsWO+5mpkv4mDoOlQGkYnqj/lb3z2UJueXrfThvak7B+/UapKOcqT
   WvWL3hzrLpsaol9tcB9C/OQeffHTqQ0HcQUZ/0Rq5ucdo88vqLezRRNOb
   grH2JnM2ZodYTDH1EEqVlEcd+sUfnjbIQOm6Cq8VMYMm4q4joihosMqrX
   kSAEpOd5pE7eqBj6TcMc/BdUwnJMIbRxtA3EjDrs3oeExC0MuGkAwZ05e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368420328"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="368420328"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 14:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821569688"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="821569688"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 14:57:15 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 884B133BC9;
	Tue,  8 Aug 2023 22:57:14 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 3/3] ice: split ice_aq_wait_for_event() func into two
Date: Tue,  8 Aug 2023 17:54:17 -0400
Message-Id: <20230808215417.117910-4-przemyslaw.kitszel@intel.com>
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

Mitigate race between registering on wait list and receiving
AQ Response from FW.

ice_aq_prep_for_event() should be called before sending AQ command,
ice_aq_wait_for_event() should be called after sending AQ command,
to wait for AQ Response.

Please note, that this was found by reading the code,
an actual race has not yet materialized.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

---
add/remove: 2/0 grow/shrink: 1/3 up/down: 131/-61 (70)
---
 drivers/net/ethernet/intel/ice/ice.h          |  5 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 13 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 67 ++++++++++++-------
 3 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index bcd56ba908a7..3ac645afbc8d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -933,6 +933,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
 
 enum ice_aq_task_state {
+	ICE_AQ_TASK_NOT_PREPARED,
 	ICE_AQ_TASK_WAITING,
 	ICE_AQ_TASK_COMPLETE,
 	ICE_AQ_TASK_CANCELED,
@@ -945,8 +946,10 @@ struct ice_aq_task {
 	u16 opcode;
 };
 
+void ice_aq_prep_for_event(struct ice_pf *pf, struct ice_aq_task *task,
+			   u16 opcode);
 int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
-			  u16 opcode, unsigned long timeout);
+			  unsigned long timeout);
 int ice_open(struct net_device *netdev);
 int ice_open_internal(struct net_device *netdev);
 int ice_stop(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 819b70823e9c..319a2d6fe26c 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -302,6 +302,8 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 	dev_dbg(dev, "Writing block of %u bytes for module 0x%02x at offset %u\n",
 		block_size, module, offset);
 
+	ice_aq_prep_for_event(pf, &task, ice_aqc_opc_nvm_write);
+
 	err = ice_aq_update_nvm(hw, module, offset, block_size, block,
 				last_cmd, 0, NULL);
 	if (err) {
@@ -318,7 +320,7 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 	 * is conservative and is intended to prevent failure to update when
 	 * firmware is slow to respond.
 	 */
-	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_write, 15 * HZ);
+	err = ice_aq_wait_for_event(pf, &task, 15 * HZ);
 	if (err) {
 		dev_err(dev, "Timed out while trying to flash module 0x%02x with block of size %u at offset %u, err %d\n",
 			module, block_size, offset, err);
@@ -491,6 +493,8 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 
 	devlink_flash_update_timeout_notify(devlink, "Erasing", component, ICE_FW_ERASE_TIMEOUT);
 
+	ice_aq_prep_for_event(pf, &task, ice_aqc_opc_nvm_erase);
+
 	err = ice_aq_erase_nvm(hw, module, NULL);
 	if (err) {
 		dev_err(dev, "Failed to erase %s (module 0x%02x), err %d aq_err %s\n",
@@ -501,7 +505,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 		goto out_notify_devlink;
 	}
 
-	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_erase, ICE_FW_ERASE_TIMEOUT * HZ);
+	err = ice_aq_wait_for_event(pf, &task, ICE_FW_ERASE_TIMEOUT * HZ);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to respond with erase completion for %s (module 0x%02x), err %d\n",
 			component, module, err);
@@ -566,6 +570,8 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 	u8 response_flags;
 	int err;
 
+	ice_aq_prep_for_event(pf, &task, ice_aqc_opc_nvm_write_activate);
+
 	err = ice_nvm_write_activate(hw, activate_flags, &response_flags);
 	if (err) {
 		dev_err(dev, "Failed to switch active flash banks, err %d aq_err %s\n",
@@ -590,8 +596,7 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 		}
 	}
 
-	err = ice_aq_wait_for_event(pf, &task, ice_aqc_opc_nvm_write_activate,
-				    30 * HZ);
+	err = ice_aq_wait_for_event(pf, &task, 30 * HZ);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to switch active flash banks, err %d\n",
 			err);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 190be3d7cc6b..0baa44fa2baa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1251,43 +1251,62 @@ ice_handle_link_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 }
 
 /**
- * ice_aq_wait_for_event - Wait for an AdminQ event from firmware
+ * ice_aq_prep_for_event - Prepare to wait for an AdminQ event from firmware
  * @pf: pointer to the PF private structure
- * @task: ptr to task structure
+ * @task: intermediate helper storage and identifier for waiting
  * @opcode: the opcode to wait for
- * @timeout: how long to wait, in jiffies
  *
- * Waits for a specific AdminQ completion event on the ARQ for a given PF. The
- * current thread will be put to sleep until the specified event occurs or
- * until the given timeout is reached.
+ * Prepares to wait for a specific AdminQ completion event on the ARQ for
+ * a given PF. Actual wait would be done by a call to ice_aq_wait_for_event().
  *
- * To obtain only the descriptor contents, pass an event without an allocated
- * msg_buf. If the complete data buffer is desired, allocate the
- * event->msg_buf with enough space ahead of time.
+ * Calls are separated to allow caller registering for event before sending
+ * the command, which mitigates a race between registering and FW responding.
  *
- * Returns: zero on success, or a negative error code on failure.
+ * To obtain only the descriptor contents, pass an task->event with null
+ * msg_buf. If the complete data buffer is desired, allocate the
+ * task->event.msg_buf with enough space ahead of time.
  */
-int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
-			  u16 opcode, unsigned long timeout)
+void ice_aq_prep_for_event(struct ice_pf *pf, struct ice_aq_task *task,
+			   u16 opcode)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	unsigned long start;
-	long ret;
-	int err;
-
 	INIT_HLIST_NODE(&task->entry);
 	task->opcode = opcode;
 	task->state = ICE_AQ_TASK_WAITING;
 
 	spin_lock_bh(&pf->aq_wait_lock);
 	hlist_add_head(&task->entry, &pf->aq_wait_list);
 	spin_unlock_bh(&pf->aq_wait_lock);
+}
 
-	start = jiffies;
+/**
+ * ice_aq_wait_for_event - Wait for an AdminQ event from firmware
+ * @pf: pointer to the PF private structure
+ * @task: ptr prepared by ice_aq_prep_for_event()
+ * @timeout: how long to wait, in jiffies
+ *
+ * Waits for a specific AdminQ completion event on the ARQ for a given PF. The
+ * current thread will be put to sleep until the specified event occurs or
+ * until the given timeout is reached.
+ *
+ * Returns: zero on success, or a negative error code on failure.
+ */
+int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
+			  unsigned long timeout)
+{
+	enum ice_aq_task_state *state = &task->state;
+	struct device *dev = ice_pf_to_dev(pf);
+	unsigned long start = jiffies;
+	long ret;
+	int err;
 
-	ret = wait_event_interruptible_timeout(pf->aq_wait_queue, task->state,
+	ret = wait_event_interruptible_timeout(pf->aq_wait_queue,
+					       *state != ICE_AQ_TASK_WAITING,
 					       timeout);
-	switch (task->state) {
+	switch (*state) {
+	case ICE_AQ_TASK_NOT_PREPARED:
+		WARN(1, "call to %s without ice_aq_prep_for_event()", __func__);
+		err = -EINVAL;
+		break;
 	case ICE_AQ_TASK_WAITING:
 		err = ret < 0 ? ret : -ETIMEDOUT;
 		break;
@@ -1298,15 +1317,15 @@ int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
 		err = ret < 0 ? ret : 0;
 		break;
 	default:
-		WARN(1, "Unexpected AdminQ wait task state %u", task->state);
+		WARN(1, "Unexpected AdminQ wait task state %u", *state);
 		err = -EINVAL;
 		break;
 	}
 
 	dev_dbg(dev, "Waited %u msecs (max %u msecs) for firmware response to op 0x%04x\n",
 		jiffies_to_msecs(jiffies - start),
 		jiffies_to_msecs(timeout),
-		opcode);
+		task->opcode);
 
 	spin_lock_bh(&pf->aq_wait_lock);
 	hlist_del(&task->entry);
@@ -1342,7 +1361,9 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 
 	spin_lock_bh(&pf->aq_wait_lock);
 	hlist_for_each_entry(task, &pf->aq_wait_list, entry) {
-		if (task->state || task->opcode != opcode)
+		if (task->state != ICE_AQ_TASK_WAITING)
+			continue;
+		if (task->opcode != opcode)
 			continue;
 
 		task_ev = &task->event;
-- 
2.40.1


