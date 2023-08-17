Return-Path: <netdev+bounces-28625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48477FFF6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445B928220F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF21ED44;
	Thu, 17 Aug 2023 21:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1D1ED3D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D03E55
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307782; x=1723843782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjEpxvkDmCUxFK911xa9omBB7B3df1oijdAcFXX7TUw=;
  b=ddRvZ5PyV2gIgilYD4h3Z3NQgP6QKP0ahx1LxsEZYYfJB2hrFD4Z01TR
   2/aOu6h3Jy0igCx967A6EDbPpI7bIN7upeTjBQBssC912oMTWYYm1iUHg
   /ux3ca3IgZjiTblWi6rvpuNHaHuZicQX9mb1mYjGmgkWd6WADMdYgR3pn
   IBkL5W2tDwN25Ohh2V81ewHOygWakBJd116YCCaua+Dhc6UE9lgt/ja5n
   uMw5p0AHiTZik3jmK8YQZCSqVUMRciaHy3cPRUJGZ+U4gQKPII8uyPvj8
   wXFLcLK1BaIiT/GINkG/6v0CW7akk+ndIJBHApJhm5yfR128/EyqJ6DYJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095131"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095131"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813747"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813747"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:39 -0700
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
Subject: [PATCH net-next v2 15/15] ice: split ice_aq_wait_for_event() func into two
Date: Thu, 17 Aug 2023 14:22:39 -0700
Message-Id: <20230817212239.2601543-16-anthony.l.nguyen@intel.com>
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

Mitigate race between registering on wait list and receiving
AQ Response from FW.

ice_aq_prep_for_event() should be called before sending AQ command,
ice_aq_wait_for_event() should be called after sending AQ command,
to wait for AQ Response.

Please note, that this was found by reading the code,
an actual race has not yet materialized.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  5 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 13 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 67 ++++++++++++-------
 3 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 9a334287bd92..5022b036ca4f 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -919,6 +919,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
 
 enum ice_aq_task_state {
+	ICE_AQ_TASK_NOT_PREPARED,
 	ICE_AQ_TASK_WAITING,
 	ICE_AQ_TASK_COMPLETE,
 	ICE_AQ_TASK_CANCELED,
@@ -931,8 +932,10 @@ struct ice_aq_task {
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
index b08be6700b2a..81c1018b57d1 100644
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
2.38.1


