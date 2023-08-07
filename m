Return-Path: <netdev+bounces-25019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F3772A03
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60773281491
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B18125B3;
	Mon,  7 Aug 2023 16:01:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CF11C8B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:01:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35395E72
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691424106; x=1722960106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRFWB4wERpkMqlYJQIqqAgGTPpKVOYLv1Ur37d/lR1E=;
  b=XKcCPLFBTH/0qB8/UJGxW9NhQTTYv1IoVQra/upBuAs/W6HWbwEnjMYL
   uUPLyS4yB9GMWWCWUyTcbNSzQmfWdsENYgxKEQQq2mFvRYwe3EXSBwMqA
   qTMsYV54svwiG5AGHylhlTvnbmYRRpwgvPVQ6WvOgYKw6cXK0FUwKfA1N
   VtANc+nxheUkx+IaM9QWBHn8L9Kg6Iy4Rqfx5GaqfWx6rWMM7rBhwiQIv
   H4QMhK2Pvtt7+JKVZu44vLzuX/oxZJ3MifpVDY9fq953qOg2JRmL9qNKc
   FMSiGTrgTqW5jjiiwR3UI8GEjjksZ+xcZgb5HJNol1NOd19DwMhR1wLSp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401553937"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="401553937"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 09:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977492998"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="977492998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2023 09:01:43 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0629E312D4;
	Mon,  7 Aug 2023 17:01:42 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 3/3] ice: split ice_aq_wait_for_event() func into two
Date: Mon,  7 Aug 2023 11:58:48 -0400
Message-Id: <20230807155848.90907-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
References: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
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

Mitigate race between registering on wait list and receiving
AQ Response from FW.

ice_aq_prep_for_event() should be called before sending AQ command,
ice_aq_wait_for_event() should be called after sending AQ command,
to wait for AQ Response.

Please note, that this was found by reading the code,
an actual race has not yet materialized.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

---
add/remove: 2/0 grow/shrink: 1/3 up/down: 131/-61 (70)
---
 drivers/net/ethernet/intel/ice/ice.h          |  7 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 13 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 67 ++++++++++++-------
 3 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6346283c5d14..3ac645afbc8d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -933,6 +933,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
 
 enum ice_aq_task_state {
+	ICE_AQ_TASK_NOT_PREPARED,
 	ICE_AQ_TASK_WAITING,
 	ICE_AQ_TASK_COMPLETE,
 	ICE_AQ_TASK_CANCELED,
@@ -945,10 +946,10 @@ struct ice_aq_task {
 	u16 opcode;
 };
 
-
+void ice_aq_prep_for_event(struct ice_pf *pf, struct ice_aq_task *task,
+			   u16 opcode);
 int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
-			  u16 opcode, unsigned long timeout);
-
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
index 36772215b8c6..edbbadd20845 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1251,30 +1251,24 @@ ice_handle_link_event(struct ice_pf *pf, struct ice_rq_event_info *event)
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
@@ -1282,12 +1276,37 @@ int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
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
@@ -1298,7 +1317,7 @@ int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
 		err = ret < 0 ? ret : 0;
 		break;
 	default:
-		WARN(1, "Unexpected AdminQ wait task state %u", task->state);
+		WARN(1, "Unexpected AdminQ wait task state %u", *state);
 		err = -EINVAL;
 		break;
 	}
@@ -1306,7 +1325,7 @@ int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task *task,
 	dev_dbg(dev, "Waited %u msecs (max %u msecs) for firmware response to op 0x%04x\n",
 		jiffies_to_msecs(jiffies - start),
 		jiffies_to_msecs(timeout),
-		opcode);
+		task->opcode);
 
 	spin_lock_bh(&pf->aq_wait_lock);
 	hlist_del(&task->entry);
@@ -1343,7 +1362,9 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 
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


