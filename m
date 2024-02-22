Return-Path: <netdev+bounces-74129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614686022E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35851F2AAA4
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C76AF8A;
	Thu, 22 Feb 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZNmx9iz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484814B81F
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628709; cv=none; b=UahuEAD1Hub/THMeF1Nf7m//Ct5+2B1PiR2IWtQOkkYw58Ra7+lc3i++kfT2HG2TJcth/s7qFsEnAD9KGyr6OYyETZF8IHsspmPxMDHLGnoE6bs1MTF0xCQffBUQJMtq4B9JnUI7a8Qw5PIbxeGs8KmtPCOhtZepGBd8N4UEy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628709; c=relaxed/simple;
	bh=+T0ZgfrJSrIESU+558ivJCooWkkbabsH2tIe8PLcRIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODPu7YBDhtAyVdiOUIkt+I/N007DxmRx6roaIMevmzEUAdsUP5mTiNfK3RJ+eSzRZEFkEekQxuP8WJMPJLTD3xlfW6YjiRyRbof6HwU7KPb/JCUIpjCh0lY/pH4DFF7JmPGhCb+irYCefUE0YycoB8sSOf3CisbK1KZCtrv27eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZNmx9iz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708628708; x=1740164708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+T0ZgfrJSrIESU+558ivJCooWkkbabsH2tIe8PLcRIE=;
  b=NZNmx9izqHpB9qYqF4k/WVn/1/emtBdwNVKHgyPsi8JBkl62I1+6FTXd
   USk/BwE5lZJcaN3XzjCKAJAdYFi8Zb530l0DgRfIRj4E0S+jkqg2gLptZ
   7ruo1oMZ6qsT/UmmrlUpGV32ATcLn2YrWXssrQ2R6IPrnFgiv/F14wyzY
   rdkvO9J/QivKXja4lZFMdXcvXnsnUqxpBVnoRmafIhPmuPi6V9FBOJt7C
   Q6B5s/kjG+U78TKXfGEcP4E2GHc2oEWqGUqQnytPzTMaSZifsLGvlbh5Z
   Xtxee+ydC0hSUqLz5CGTOzliezbkG6aNreg8XXq3Azd7DiRUJXWwXeUij
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13506395"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13506395"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10171358"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 11:05:06 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH v6 08/11 iwl-next] idpf: cleanup virtchnl cruft
Date: Thu, 22 Feb 2024 11:04:38 -0800
Message-ID: <20240222190441.2610930-9-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222190441.2610930-1-alan.brady@intel.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can now remove a bunch of gross code we don't need anymore like the
vc state bits and vc_buf_lock since everything is using transaction API
now.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 88 +------------------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 25 +-----
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  2 -
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 13 ---
 4 files changed, 3 insertions(+), 125 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ed5474c1565a..5ed08be1dbc0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -37,8 +37,6 @@ struct idpf_vport_max_q;
 #define IDPF_MB_MAX_ERR			20
 #define IDPF_NUM_CHUNKS_PER_MSG(struct_sz, chunk_sz)	\
 	((IDPF_CTLQ_MAX_BUF_LEN - (struct_sz)) / (chunk_sz))
-#define IDPF_WAIT_FOR_EVENT_TIMEO_MIN	2000
-#define IDPF_WAIT_FOR_EVENT_TIMEO	60000
 
 #define IDPF_MAX_WAIT			500
 
@@ -207,71 +205,6 @@ struct idpf_dev_ops {
 	struct idpf_reg_ops reg_ops;
 };
 
-/* These macros allow us to generate an enum and a matching char * array of
- * stringified enums that are always in sync. Checkpatch issues a bogus warning
- * about this being a complex macro; but it's wrong, these are never used as a
- * statement and instead only used to define the enum and array.
- */
-#define IDPF_FOREACH_VPORT_VC_STATE(STATE)	\
-	STATE(IDPF_VC_CREATE_VPORT)		\
-	STATE(IDPF_VC_CREATE_VPORT_ERR)		\
-	STATE(IDPF_VC_ENA_VPORT)		\
-	STATE(IDPF_VC_ENA_VPORT_ERR)		\
-	STATE(IDPF_VC_DIS_VPORT)		\
-	STATE(IDPF_VC_DIS_VPORT_ERR)		\
-	STATE(IDPF_VC_DESTROY_VPORT)		\
-	STATE(IDPF_VC_DESTROY_VPORT_ERR)	\
-	STATE(IDPF_VC_CONFIG_TXQ)		\
-	STATE(IDPF_VC_CONFIG_TXQ_ERR)		\
-	STATE(IDPF_VC_CONFIG_RXQ)		\
-	STATE(IDPF_VC_CONFIG_RXQ_ERR)		\
-	STATE(IDPF_VC_ENA_QUEUES)		\
-	STATE(IDPF_VC_ENA_QUEUES_ERR)		\
-	STATE(IDPF_VC_DIS_QUEUES)		\
-	STATE(IDPF_VC_DIS_QUEUES_ERR)		\
-	STATE(IDPF_VC_MAP_IRQ)			\
-	STATE(IDPF_VC_MAP_IRQ_ERR)		\
-	STATE(IDPF_VC_UNMAP_IRQ)		\
-	STATE(IDPF_VC_UNMAP_IRQ_ERR)		\
-	STATE(IDPF_VC_ADD_QUEUES)		\
-	STATE(IDPF_VC_ADD_QUEUES_ERR)		\
-	STATE(IDPF_VC_DEL_QUEUES)		\
-	STATE(IDPF_VC_DEL_QUEUES_ERR)		\
-	STATE(IDPF_VC_ALLOC_VECTORS)		\
-	STATE(IDPF_VC_ALLOC_VECTORS_ERR)	\
-	STATE(IDPF_VC_DEALLOC_VECTORS)		\
-	STATE(IDPF_VC_DEALLOC_VECTORS_ERR)	\
-	STATE(IDPF_VC_SET_SRIOV_VFS)		\
-	STATE(IDPF_VC_SET_SRIOV_VFS_ERR)	\
-	STATE(IDPF_VC_GET_RSS_LUT)		\
-	STATE(IDPF_VC_GET_RSS_LUT_ERR)		\
-	STATE(IDPF_VC_SET_RSS_LUT)		\
-	STATE(IDPF_VC_SET_RSS_LUT_ERR)		\
-	STATE(IDPF_VC_GET_RSS_KEY)		\
-	STATE(IDPF_VC_GET_RSS_KEY_ERR)		\
-	STATE(IDPF_VC_SET_RSS_KEY)		\
-	STATE(IDPF_VC_SET_RSS_KEY_ERR)		\
-	STATE(IDPF_VC_GET_STATS)		\
-	STATE(IDPF_VC_GET_STATS_ERR)		\
-	STATE(IDPF_VC_ADD_MAC_ADDR)		\
-	STATE(IDPF_VC_ADD_MAC_ADDR_ERR)		\
-	STATE(IDPF_VC_DEL_MAC_ADDR)		\
-	STATE(IDPF_VC_DEL_MAC_ADDR_ERR)		\
-	STATE(IDPF_VC_GET_PTYPE_INFO)		\
-	STATE(IDPF_VC_GET_PTYPE_INFO_ERR)	\
-	STATE(IDPF_VC_LOOPBACK_STATE)		\
-	STATE(IDPF_VC_LOOPBACK_STATE_ERR)	\
-	STATE(IDPF_VC_NBITS)
-
-#define IDPF_GEN_ENUM(ENUM) ENUM,
-#define IDPF_GEN_STRING(STRING) #STRING,
-
-enum idpf_vport_vc_state {
-	IDPF_FOREACH_VPORT_VC_STATE(IDPF_GEN_ENUM)
-};
-
-extern const char * const idpf_vport_vc_state_str[];
-
 /**
  * enum idpf_vport_reset_cause - Vport soft reset causes
  * @IDPF_SR_Q_CHANGE: Soft reset queue change
@@ -356,11 +289,7 @@ struct idpf_port_stats {
  * @port_stats: per port csum, header split, and other offload stats
  * @link_up: True if link is up
  * @link_speed_mbps: Link speed in mbps
- * @vc_msg: Virtchnl message buffer
- * @vc_state: Virtchnl message state
- * @vchnl_wq: Wait queue for virtchnl messages
  * @sw_marker_wq: workqueue for marker packets
- * @vc_buf_lock: Lock to protect virtchnl buffer
  */
 struct idpf_vport {
 	u16 num_txq;
@@ -406,12 +335,7 @@ struct idpf_vport {
 	bool link_up;
 	u32 link_speed_mbps;
 
-	char vc_msg[IDPF_CTLQ_MAX_BUF_LEN];
-	DECLARE_BITMAP(vc_state, IDPF_VC_NBITS);
-
-	wait_queue_head_t vchnl_wq;
 	wait_queue_head_t sw_marker_wq;
-	struct mutex vc_buf_lock;
 };
 
 /**
@@ -474,15 +398,11 @@ struct idpf_vport_user_config_data {
  * enum idpf_vport_config_flags - Vport config flags
  * @IDPF_VPORT_REG_NETDEV: Register netdev
  * @IDPF_VPORT_UP_REQUESTED: Set if interface up is requested on core reset
- * @IDPF_VPORT_ADD_MAC_REQ: Asynchronous add ether address in flight
- * @IDPF_VPORT_DEL_MAC_REQ: Asynchronous delete ether address in flight
  * @IDPF_VPORT_CONFIG_FLAGS_NBITS: Must be last
  */
 enum idpf_vport_config_flags {
 	IDPF_VPORT_REG_NETDEV,
 	IDPF_VPORT_UP_REQUESTED,
-	IDPF_VPORT_ADD_MAC_REQ,
-	IDPF_VPORT_DEL_MAC_REQ,
 	IDPF_VPORT_CONFIG_FLAGS_NBITS,
 };
 
@@ -601,9 +521,6 @@ struct idpf_vc_xn_manager;
  * @stats_task: Periodic statistics retrieval task
  * @stats_wq: Workqueue for statistics task
  * @caps: Negotiated capabilities with device
- * @vchnl_wq: Wait queue for virtchnl messages
- * @vc_state: Virtchnl message state
- * @vc_msg: Virtchnl message buffer
  * @vcxn_mngr: Virtchnl transaction manager
  * @dev_ops: See idpf_dev_ops
  * @num_vfs: Number of allocated VFs through sysfs. PF does not directly talk
@@ -660,11 +577,8 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
-
-	wait_queue_head_t vchnl_wq;
-	DECLARE_BITMAP(vc_state, IDPF_VC_NBITS);
-	char vc_msg[IDPF_CTLQ_MAX_BUF_LEN];
 	struct idpf_vc_xn_manager *vcxn_mngr;
+
 	struct idpf_dev_ops dev_ops;
 	int num_vfs;
 	bool crc_enable;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 4c6c7b9db762..0714d7dcab10 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -7,10 +7,6 @@
 static const struct net_device_ops idpf_netdev_ops_splitq;
 static const struct net_device_ops idpf_netdev_ops_singleq;
 
-const char * const idpf_vport_vc_state_str[] = {
-	IDPF_FOREACH_VPORT_VC_STATE(IDPF_GEN_STRING)
-};
-
 /**
  * idpf_init_vector_stack - Fill the MSIX vector stack with vector index
  * @adapter: private data struct
@@ -976,7 +972,6 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 	struct idpf_rss_data *rss_data;
 	struct idpf_vport_max_q max_q;
 	u16 idx = vport->idx;
-	int i;
 
 	vport_config = adapter->vport_config[vport->idx];
 	idpf_deinit_rss(vport);
@@ -986,20 +981,6 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 
 	idpf_send_destroy_vport_msg(vport);
 
-	/* Set all bits as we dont know on which vc_state the vport vhnl_wq
-	 * is waiting on and wakeup the virtchnl workqueue even if it is
-	 * waiting for the response as we are going down
-	 */
-	for (i = 0; i < IDPF_VC_NBITS; i++)
-		set_bit(i, vport->vc_state);
-	wake_up(&vport->vchnl_wq);
-
-	mutex_destroy(&vport->vc_buf_lock);
-
-	/* Clear all the bits */
-	for (i = 0; i < IDPF_VC_NBITS; i++)
-		clear_bit(i, vport->vc_state);
-
 	/* Release all max queues allocated to the adapter's pool */
 	max_q.max_rxq = vport_config->max_q.max_rxq;
 	max_q.max_txq = vport_config->max_q.max_txq;
@@ -1544,9 +1525,7 @@ void idpf_init_task(struct work_struct *work)
 	vport_config = adapter->vport_config[index];
 
 	init_waitqueue_head(&vport->sw_marker_wq);
-	init_waitqueue_head(&vport->vchnl_wq);
 
-	mutex_init(&vport->vc_buf_lock);
 	spin_lock_init(&vport_config->mac_filter_list_lock);
 
 	INIT_LIST_HEAD(&vport_config->user_config.mac_filter_list);
@@ -1905,7 +1884,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	 * mess with. Nothing below should use those variables from new_vport
 	 * and should instead always refer to them in vport if they need to.
 	 */
-	memcpy(new_vport, vport, offsetof(struct idpf_vport, vc_state));
+	memcpy(new_vport, vport, offsetof(struct idpf_vport, link_speed_mbps));
 
 	/* Adjust resource parameters prior to reallocating resources */
 	switch (reset_cause) {
@@ -1954,7 +1933,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	/* Same comment as above regarding avoiding copying the wait_queues and
 	 * mutexes applies here. We do not want to mess with those if possible.
 	 */
-	memcpy(vport, new_vport, offsetof(struct idpf_vport, vc_state));
+	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_speed_mbps));
 
 	/* Since idpf_vport_queues_alloc was called with new_port, the queue
 	 * back pointers are currently pointing to the local new_vport. Reset
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index c9b6ef3166aa..f784eea044bd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -233,8 +233,6 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mutex_init(&adapter->queue_lock);
 	mutex_init(&adapter->vc_buf_lock);
 
-	init_waitqueue_head(&adapter->vchnl_wq);
-
 	INIT_DELAYED_WORK(&adapter->init_task, idpf_init_task);
 	INIT_DELAYED_WORK(&adapter->serv_task, idpf_service_task);
 	INIT_DELAYED_WORK(&adapter->mbx_task, idpf_mbx_task);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cf8aff26c3a9..e89e2bad460d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3034,28 +3034,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
-	int i;
-
 	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
-	/* Set all bits as we dont know on which vc_state the vhnl_wq is
-	 * waiting on and wakeup the virtchnl workqueue even if it is waiting
-	 * for the response as we are going down
-	 */
-	for (i = 0; i < IDPF_VC_NBITS; i++)
-		set_bit(i, adapter->vc_state);
-	wake_up(&adapter->vchnl_wq);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
 
 	idpf_vport_params_buf_rel(adapter);
 
-	/* Clear all the bits */
-	for (i = 0; i < IDPF_VC_NBITS; i++)
-		clear_bit(i, adapter->vc_state);
-
 	kfree(adapter->vports);
 	adapter->vports = NULL;
 }
-- 
2.43.0


