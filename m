Return-Path: <netdev+bounces-74122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5508860321
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643D9B263CC
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13C14B833;
	Thu, 22 Feb 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hs84Q2sy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8114B834
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628692; cv=none; b=eJtpNU8DimrmXAr5ZwHsQMBdroQeFC4YNmqqTn0ZLgabwiY3rmBbj1k1UP1i7C561VO+de2Bx7YsQ0oJPcRMr3NmCrvP6G9ZG2IOwt6L8rX42HwcpaTsG8HLYm/VraP7IDuzmRu2a1EU+g/dE/GC/h3mVraHuN7zV4pzoGaCBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628692; c=relaxed/simple;
	bh=DTDM8XGda25E7Zu4p0XL/KLmUVHVXgSVPBBdL4kiaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCNJjNmj4XuXQ2mJKqt/An2AtxNff4fyNqjjh7rzSlrWDiRmwQgOpHrEdBLO+v3hHMcH6LVzd5sk2GWsFnquALmlxCW4CXAXmCStPwyEg31Jkd7jBoKP87R8lox83SBnt2rhLmFD3VF92HagT9962psPLW55NPdeGPlgudmV/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hs84Q2sy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708628690; x=1740164690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTDM8XGda25E7Zu4p0XL/KLmUVHVXgSVPBBdL4kiaPY=;
  b=Hs84Q2sy2XKxuf3hLEFrAxXcEARdojXCqsQwljp7q+B0nhFrXUcxpnys
   /R7kfKkiti76HTvweu5JIdr+HsvaXi96A/9aFqhuS4zQOt+1QhxppHsLU
   FBK3KiGsxehc7LLupv37ray693MrZrEptrzZ4tnZFr7176hUnHxRrH3S3
   7VeHgBp2T/D4XptQNh4k3HH5HKel+x/yXKlvcXJoMncuqTHV67dSX7jvs
   AeiMdsBtGdVtRxCOyhpEuZkXmfJ2FERVb1KC+rfglcbV6e8oeU5ZE/OUi
   Eu/kAktejE/GoRDbcBOu5hafEnZCDUv6UmmitPxaMmvoINW2mmoN5YAVu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13506349"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13506349"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10171100"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 11:04:49 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v6 01/11 iwl-next] idpf: add idpf_virtchnl.h
Date: Thu, 22 Feb 2024 11:04:31 -0800
Message-ID: <20240222190441.2610930-2-alan.brady@intel.com>
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

idpf.h is quite heavy. We can reduce the burden a fair bit by
introducing an idpf_virtchnl.h file. This mostly just moves function
declarations but there are many of them. This also makes an attempt to
group those declarations in a way that makes some sense instead of
mishmashed.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 50 -------------
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  1 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  1 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  1 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   | 71 +++++++++++++++++++
 8 files changed, 77 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 0acc125decb3..b2f1bc63c3b6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -903,68 +903,18 @@ void idpf_mbx_task(struct work_struct *work);
 void idpf_vc_event_task(struct work_struct *work);
 void idpf_dev_ops_init(struct idpf_adapter *adapter);
 void idpf_vf_dev_ops_init(struct idpf_adapter *adapter);
-int idpf_vport_adjust_qs(struct idpf_vport *vport);
-int idpf_init_dflt_mbx(struct idpf_adapter *adapter);
-void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter);
-int idpf_vc_core_init(struct idpf_adapter *adapter);
-void idpf_vc_core_deinit(struct idpf_adapter *adapter);
 int idpf_intr_req(struct idpf_adapter *adapter);
 void idpf_intr_rel(struct idpf_adapter *adapter);
-int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
-			   struct idpf_vec_regs *reg_vals);
 u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
-int idpf_send_delete_queues_msg(struct idpf_vport *vport);
-int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
-			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq);
 int idpf_initiate_soft_reset(struct idpf_vport *vport,
 			     enum idpf_vport_reset_cause reset_cause);
-int idpf_send_enable_vport_msg(struct idpf_vport *vport);
-int idpf_send_disable_vport_msg(struct idpf_vport *vport);
-int idpf_send_destroy_vport_msg(struct idpf_vport *vport);
-int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport);
-int idpf_send_ena_dis_loopback_msg(struct idpf_vport *vport);
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
-int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter);
-int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors);
 void idpf_deinit_task(struct idpf_adapter *adapter);
 int idpf_req_rel_vector_indexes(struct idpf_adapter *adapter,
 				u16 *q_vector_idxs,
 				struct idpf_vector_info *vec_info);
-int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport);
-int idpf_send_get_stats_msg(struct idpf_vport *vport);
-int idpf_get_vec_ids(struct idpf_adapter *adapter,
-		     u16 *vecids, int num_vecids,
-		     struct virtchnl2_vector_chunks *chunks);
-int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     void *msg, int msg_size);
-int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     u16 msg_size, u8 *msg);
 void idpf_set_ethtool_ops(struct net_device *netdev);
-int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
-			    struct idpf_vport_max_q *max_q);
-void idpf_vport_dealloc_max_qs(struct idpf_adapter *adapter,
-			       struct idpf_vport_max_q *max_q);
-int idpf_add_del_mac_filters(struct idpf_vport *vport,
-			     struct idpf_netdev_priv *np,
-			     bool add, bool async);
-int idpf_set_promiscuous(struct idpf_adapter *adapter,
-			 struct idpf_vport_user_config_data *config_data,
-			 u32 vport_id);
-int idpf_send_disable_queues_msg(struct idpf_vport *vport);
-void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q);
-u32 idpf_get_vport_id(struct idpf_vport *vport);
-int idpf_vport_queue_ids_init(struct idpf_vport *vport);
-int idpf_queue_reg_init(struct idpf_vport *vport);
-int idpf_send_config_queues_msg(struct idpf_vport *vport);
-int idpf_send_enable_queues_msg(struct idpf_vport *vport);
-int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
-			       struct idpf_vport_max_q *max_q);
-int idpf_check_supported_desc_ids(struct idpf_vport *vport);
 void idpf_vport_intr_write_itr(struct idpf_q_vector *q_vector,
 			       u16 itr, bool tx);
-int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map);
-int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs);
 
 u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 34ad1ac46b78..3df9935685e9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_lan_pf_regs.h"
+#include "idpf_virtchnl.h"
 
 #define IDPF_PF_ITR_IDX_SPACING		0x4
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 58179bd733ff..1832f800a370 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_virtchnl.h"
 
 static const struct net_device_ops idpf_netdev_ops_splitq;
 static const struct net_device_ops idpf_netdev_ops_singleq;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index e1febc74cefd..92e73fdd7bbe 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_devids.h"
+#include "idpf_virtchnl.h"
 
 #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2f8ad79ae3f0..6dd7a66bb897 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_virtchnl.h"
 
 /**
  * idpf_buf_lifo_push - push a buffer pointer onto stack
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 8ade4e3a9fe1..be40dd68358e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_lan_vf_regs.h"
+#include "idpf_virtchnl.h"
 
 #define IDPF_VF_ITR_IDX_SPACING		0x40
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d0cdd63b3d5b..6217a05389cd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_virtchnl.h"
 
 /**
  * idpf_recv_event_msg - Receive virtchnl event message
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
new file mode 100644
index 000000000000..78aff791f3a9
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _IDPF_VIRTCHNL_H_
+#define _IDPF_VIRTCHNL_H_
+
+struct idpf_adapter;
+struct idpf_netdev_priv;
+struct idpf_vec_regs;
+struct idpf_vport;
+struct idpf_vport_max_q;
+struct idpf_vport_user_config_data;
+
+int idpf_init_dflt_mbx(struct idpf_adapter *adapter);
+void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter);
+int idpf_vc_core_init(struct idpf_adapter *adapter);
+void idpf_vc_core_deinit(struct idpf_adapter *adapter);
+
+int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
+			   struct idpf_vec_regs *reg_vals);
+int idpf_queue_reg_init(struct idpf_vport *vport);
+int idpf_vport_queue_ids_init(struct idpf_vport *vport);
+
+int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
+		     void *msg, int msg_size);
+int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
+		     u16 msg_size, u8 *msg);
+
+void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q);
+u32 idpf_get_vport_id(struct idpf_vport *vport);
+int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
+			       struct idpf_vport_max_q *max_q);
+int idpf_send_destroy_vport_msg(struct idpf_vport *vport);
+int idpf_send_enable_vport_msg(struct idpf_vport *vport);
+int idpf_send_disable_vport_msg(struct idpf_vport *vport);
+
+int idpf_vport_adjust_qs(struct idpf_vport *vport);
+int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
+			    struct idpf_vport_max_q *max_q);
+void idpf_vport_dealloc_max_qs(struct idpf_adapter *adapter,
+			       struct idpf_vport_max_q *max_q);
+int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
+			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq);
+int idpf_send_delete_queues_msg(struct idpf_vport *vport);
+int idpf_send_enable_queues_msg(struct idpf_vport *vport);
+int idpf_send_disable_queues_msg(struct idpf_vport *vport);
+int idpf_send_config_queues_msg(struct idpf_vport *vport);
+
+int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport);
+int idpf_get_vec_ids(struct idpf_adapter *adapter,
+		     u16 *vecids, int num_vecids,
+		     struct virtchnl2_vector_chunks *chunks);
+int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors);
+int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter);
+int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map);
+
+int idpf_add_del_mac_filters(struct idpf_vport *vport,
+			     struct idpf_netdev_priv *np,
+			     bool add, bool async);
+int idpf_set_promiscuous(struct idpf_adapter *adapter,
+			 struct idpf_vport_user_config_data *config_data,
+			 u32 vport_id);
+int idpf_check_supported_desc_ids(struct idpf_vport *vport);
+int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport);
+int idpf_send_ena_dis_loopback_msg(struct idpf_vport *vport);
+int idpf_send_get_stats_msg(struct idpf_vport *vport);
+int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
+int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
+int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+
+#endif /* _IDPF_VIRTCHNL_H_ */
-- 
2.43.0


