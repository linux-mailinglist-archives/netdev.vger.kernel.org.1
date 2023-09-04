Return-Path: <netdev+bounces-31863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D872791005
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 04:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E71281023
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8AE644;
	Mon,  4 Sep 2023 02:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62B1364
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:15:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A0BF
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693793723; x=1725329723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0joeF6xt2YO6csAGe+Lafye/GYqykhG3d1ls6gewx6k=;
  b=RqHsKDfsUjH6qa1oTw1hKT/ZobHMWkNQDq7HqYZ/s2hCLyZDd+4RTjun
   cji5QLNSO7Z2Q+u/9wo2H5nz38stWpEgwpG58i8LyyvsY3/IRMAjNix+h
   GvTzHv4Bloms/roLeIu+SR0I7ZYsOG0JlTLItPwI1xCBU0tbrr/THqX/d
   WnDGbk7G80f//lzfvtcJVePjcjx02I66R1CPovAUMLRy4/LdwPBCQdHbY
   ln2DVTpG0g2lYcFWGlyXUxIfwbGSKUHA/jEtXztHkLTRhyBKDyRwdFsV9
   dWqEgWfC00fOHhTr9vtICwPKGL+XYjfnZt2d/orVW1dQnX3OaxGqysEUW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379215207"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379215207"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769826859"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769826859"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2023 19:15:18 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	qi.z.zhang@intel.com,
	ivecera@redhat.com,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	Junfeng Guo <junfeng.guo@intel.com>
Subject: [PATCH iwl-next v9 04/15] ice: init parse graph cam tables for parser
Date: Mon,  4 Sep 2023 10:14:44 +0800
Message-Id: <20230904021455.3944605-5-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230904021455.3944605-1-junfeng.guo@intel.com>
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
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

Parse DDP section ICE_SID_RXPARSER_CAM or ICE_SID_RXPARSER_PG_SPILL
into an array of struct ice_pg_cam_item.
Parse DDP section ICE_SID_RXPARSER_NOMATCH_CAM or
ICE_SID_RXPARSER_NOMATCH_SPILL into an array of struct ice_pg_nm_cam_item.

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile     |   1 +
 drivers/net/ethernet/intel/ice/ice_parser.c |  40 +++
 drivers/net/ethernet/intel/ice/ice_parser.h |  13 +
 drivers/net/ethernet/intel/ice/ice_pg_cam.c | 368 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_pg_cam.h |  67 ++++
 5 files changed, 489 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_pg_cam.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_pg_cam.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index feb7ab8e0eed..dfb684cbc7f1 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -28,6 +28,7 @@ ice-y := ice_main.o	\
 	 ice_flow.o	\
 	 ice_parser.o    \
 	 ice_imem.o      \
+	 ice_pg_cam.o    \
 	 ice_metainit.o  \
 	 ice_idc.o	\
 	 ice_devlink.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index e2e49fcf69c1..b654135419fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -28,6 +28,18 @@ void *ice_parser_sect_item_get(u32 sect_type, void *section,
 	case ICE_SID_RXPARSER_METADATA_INIT:
 		size = ICE_SID_RXPARSER_METADATA_INIT_ENTRY_SIZE;
 		break;
+	case ICE_SID_RXPARSER_CAM:
+		size = ICE_SID_RXPARSER_CAM_ENTRY_SIZE;
+		break;
+	case ICE_SID_RXPARSER_PG_SPILL:
+		size = ICE_SID_RXPARSER_PG_SPILL_ENTRY_SIZE;
+		break;
+	case ICE_SID_RXPARSER_NOMATCH_CAM:
+		size = ICE_SID_RXPARSER_NOMATCH_CAM_ENTRY_SIZE;
+		break;
+	case ICE_SID_RXPARSER_NOMATCH_SPILL:
+		size = ICE_SID_RXPARSER_NOMATCH_SPILL_ENTRY_SIZE;
+		break;
 	default:
 		return NULL;
 	}
@@ -120,6 +132,30 @@ int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
 		goto err;
 	}
 
+	p->pg_cam_table = ice_pg_cam_table_get(hw);
+	if (!p->pg_cam_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->pg_sp_cam_table = ice_pg_sp_cam_table_get(hw);
+	if (!p->pg_sp_cam_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->pg_nm_cam_table = ice_pg_nm_cam_table_get(hw);
+	if (!p->pg_nm_cam_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->pg_nm_sp_cam_table = ice_pg_nm_sp_cam_table_get(hw);
+	if (!p->pg_nm_sp_cam_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
 	*psr = p;
 	return 0;
 err:
@@ -135,6 +171,10 @@ void ice_parser_destroy(struct ice_parser *psr)
 {
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->imem_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->mi_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->pg_cam_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->pg_sp_cam_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->pg_nm_cam_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->pg_nm_sp_cam_table);
 
 	devm_kfree(ice_hw_to_dev(psr->hw), psr);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index b52abad747b2..c709c56bf2e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -6,10 +6,15 @@
 
 #include "ice_metainit.h"
 #include "ice_imem.h"
+#include "ice_pg_cam.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
 #define ICE_SID_RXPARSER_METADATA_INIT_ENTRY_SIZE	24
+#define ICE_SID_RXPARSER_CAM_ENTRY_SIZE			16
+#define ICE_SID_RXPARSER_PG_SPILL_ENTRY_SIZE		17
+#define ICE_SID_RXPARSER_NOMATCH_CAM_ENTRY_SIZE		12
+#define ICE_SID_RXPARSER_NOMATCH_SPILL_ENTRY_SIZE	13
 
 struct ice_parser {
 	struct ice_hw *hw; /* pointer to the hardware structure */
@@ -18,6 +23,14 @@ struct ice_parser {
 	struct ice_imem_item *imem_table;
 	/* load data from section ICE_SID_RXPARSER_METADATA_INIT */
 	struct ice_metainit_item *mi_table;
+	/* load data from section ICE_SID_RXPARSER_CAM */
+	struct ice_pg_cam_item *pg_cam_table;
+	/* load data from section ICE_SID_RXPARSER_PG_SPILL */
+	struct ice_pg_cam_item *pg_sp_cam_table;
+	/* load data from section ICE_SID_RXPARSER_NOMATCH_CAM */
+	struct ice_pg_nm_cam_item *pg_nm_cam_table;
+	/* load data from section ICE_SID_RXPARSER_NOMATCH_SPILL */
+	struct ice_pg_nm_cam_item *pg_nm_sp_cam_table;
 };
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
diff --git a/drivers/net/ethernet/intel/ice/ice_pg_cam.c b/drivers/net/ethernet/intel/ice/ice_pg_cam.c
new file mode 100644
index 000000000000..8e4d03b9032a
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_pg_cam.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+#include "ice_parser_util.h"
+
+static void _ice_pg_cam_key_dump(struct ice_hw *hw, struct ice_pg_cam_key *key)
+{
+	dev_info(ice_hw_to_dev(hw), "key:\n");
+	dev_info(ice_hw_to_dev(hw), "\tvalid = %d\n", key->valid);
+	dev_info(ice_hw_to_dev(hw), "\tnode_id = %d\n", key->node_id);
+	dev_info(ice_hw_to_dev(hw), "\tflag0 = %d\n", key->flag0);
+	dev_info(ice_hw_to_dev(hw), "\tflag1 = %d\n", key->flag1);
+	dev_info(ice_hw_to_dev(hw), "\tflag2 = %d\n", key->flag2);
+	dev_info(ice_hw_to_dev(hw), "\tflag3 = %d\n", key->flag3);
+	dev_info(ice_hw_to_dev(hw), "\tboost_idx = %d\n", key->boost_idx);
+	dev_info(ice_hw_to_dev(hw), "\talu_reg = 0x%04x\n", key->alu_reg);
+	dev_info(ice_hw_to_dev(hw), "\tnext_proto = 0x%08x\n",
+		 key->next_proto);
+}
+
+static void _ice_pg_nm_cam_key_dump(struct ice_hw *hw,
+				    struct ice_pg_nm_cam_key *key)
+{
+	dev_info(ice_hw_to_dev(hw), "key:\n");
+	dev_info(ice_hw_to_dev(hw), "\tvalid = %d\n", key->valid);
+	dev_info(ice_hw_to_dev(hw), "\tnode_id = %d\n", key->node_id);
+	dev_info(ice_hw_to_dev(hw), "\tflag0 = %d\n", key->flag0);
+	dev_info(ice_hw_to_dev(hw), "\tflag1 = %d\n", key->flag1);
+	dev_info(ice_hw_to_dev(hw), "\tflag2 = %d\n", key->flag2);
+	dev_info(ice_hw_to_dev(hw), "\tflag3 = %d\n", key->flag3);
+	dev_info(ice_hw_to_dev(hw), "\tboost_idx = %d\n", key->boost_idx);
+	dev_info(ice_hw_to_dev(hw), "\talu_reg = 0x%04x\n", key->alu_reg);
+}
+
+static void _ice_pg_cam_action_dump(struct ice_hw *hw,
+				    struct ice_pg_cam_action *action)
+{
+	dev_info(ice_hw_to_dev(hw), "action:\n");
+	dev_info(ice_hw_to_dev(hw), "\tnext_node = %d\n", action->next_node);
+	dev_info(ice_hw_to_dev(hw), "\tnext_pc = %d\n", action->next_pc);
+	dev_info(ice_hw_to_dev(hw), "\tis_pg = %d\n", action->is_pg);
+	dev_info(ice_hw_to_dev(hw), "\tproto_id = %d\n", action->proto_id);
+	dev_info(ice_hw_to_dev(hw), "\tis_mg = %d\n", action->is_mg);
+	dev_info(ice_hw_to_dev(hw), "\tmarker_id = %d\n", action->marker_id);
+	dev_info(ice_hw_to_dev(hw), "\tis_last_round = %d\n",
+		 action->is_last_round);
+	dev_info(ice_hw_to_dev(hw), "\tho_polarity = %d\n",
+		 action->ho_polarity);
+	dev_info(ice_hw_to_dev(hw), "\tho_inc = %d\n", action->ho_inc);
+}
+
+/**
+ * ice_pg_cam_dump - dump an parse graph cam info
+ * @hw: pointer to the hardware structure
+ * @item: parse graph cam to dump
+ */
+void ice_pg_cam_dump(struct ice_hw *hw, struct ice_pg_cam_item *item)
+{
+	dev_info(ice_hw_to_dev(hw), "index = %d\n", item->idx);
+	_ice_pg_cam_key_dump(hw, &item->key);
+	_ice_pg_cam_action_dump(hw, &item->action);
+}
+
+/**
+ * ice_pg_nm_cam_dump - dump an parse graph no match cam info
+ * @hw: pointer to the hardware structure
+ * @item: parse graph no match cam to dump
+ */
+void ice_pg_nm_cam_dump(struct ice_hw *hw, struct ice_pg_nm_cam_item *item)
+{
+	dev_info(ice_hw_to_dev(hw), "index = %d\n", item->idx);
+	_ice_pg_nm_cam_key_dump(hw, &item->key);
+	_ice_pg_cam_action_dump(hw, &item->action);
+}
+
+#define ICE_PGCA_NN	GENMASK_ULL(10, 0)
+#define ICE_PGCA_NPC	GENMASK_ULL(18, 11)
+#define ICE_PGCA_IPG	BIT_ULL(19)
+#define ICE_PGCA_PID	GENMASK_ULL(30, 23)
+#define ICE_PGCA_IMG	BIT_ULL(31)
+#define ICE_PGCA_MID	GENMASK_ULL(39, 32)
+#define ICE_PGCA_ILR	BIT_ULL(40)
+#define ICE_PGCA_HOP	BIT_ULL(41)
+#define ICE_PGCA_HOI	GENMASK_ULL(50, 42)
+
+/** The function parses a 55 bits Parse Graph CAM Action with below format:
+ *  BIT 0-10:	Next Node ID		(action->next_node)
+ *  BIT 11-18:	Next PC			(action->next_pc)
+ *  BIT 19:	Is Protocol Group	(action->is_pg)
+ *  BIT 20-22:	reserved
+ *  BIT 23-30:	Protocol ID		(action->proto_id)
+ *  BIT 31:	Is Marker Group		(action->is_mg)
+ *  BIT 32-39:	Marker ID		(action->marker_id)
+ *  BIT 40:	Is Last Round		(action->is_last_round)
+ *  BIT 41:	Header Offset Polarity	(action->ho_poloarity)
+ *  BIT 42-50:	Header Offset Inc	(action->ho_inc)
+ *  BIT 51-54:	reserved
+ */
+static void _ice_pg_cam_action_init(struct ice_pg_cam_action *action, u64 data)
+{
+	action->next_node	= FIELD_GET(ICE_PGCA_NN, data);
+	action->next_pc		= FIELD_GET(ICE_PGCA_NPC, data);
+	action->is_pg		= FIELD_GET(ICE_PGCA_IPG, data);
+	action->proto_id	= FIELD_GET(ICE_PGCA_PID, data);
+	action->is_mg		= FIELD_GET(ICE_PGCA_IMG, data);
+	action->marker_id	= FIELD_GET(ICE_PGCA_MID, data);
+	action->is_last_round	= FIELD_GET(ICE_PGCA_ILR, data);
+	action->ho_polarity	= FIELD_GET(ICE_PGCA_HOP, data);
+	action->ho_inc		= FIELD_GET(ICE_PGCA_HOI, data);
+}
+
+#define ICE_PGNCK_VLD		BIT_ULL(0)
+#define ICE_PGNCK_NID		GENMASK_ULL(11, 1)
+#define ICE_PGNCK_F0		BIT_ULL(12)
+#define ICE_PGNCK_F1		BIT_ULL(13)
+#define ICE_PGNCK_F2		BIT_ULL(14)
+#define ICE_PGNCK_F3		BIT_ULL(15)
+#define ICE_PGNCK_BH		BIT_ULL(16)
+#define ICE_PGNCK_BI		GENMASK_ULL(24, 17)
+#define ICE_PGNCK_AR		GENMASK_ULL(40, 25)
+
+/** The function parses a 41 bits Parse Graph NoMatch CAM Key with below format:
+ *  BIT 0:	Valid		(key->valid)
+ *  BIT 1-11:	Node ID		(key->node_id)
+ *  BIT 12:	Flag 0		(key->flag0)
+ *  BIT 13:	Flag 1		(key->flag1)
+ *  BIT 14:	Flag 2		(key->flag2)
+ *  BIT 15:	Flag 3		(key->flag3)
+ *  BIT 16:	Boost Hit	(key->boost_idx to 0 if it is 0)
+ *  BIT 17-24:	Boost Index	(key->boost_idx only if Boost Hit is not 0)
+ *  BIT 25-40:	ALU Reg		(key->alu_reg)
+ */
+static void _ice_pg_nm_cam_key_init(struct ice_pg_nm_cam_key *key, u64 data)
+{
+	key->valid	= FIELD_GET(ICE_PGNCK_VLD, data);
+	key->node_id	= FIELD_GET(ICE_PGNCK_NID, data);
+	key->flag0	= FIELD_GET(ICE_PGNCK_F0, data);
+	key->flag1	= FIELD_GET(ICE_PGNCK_F1, data);
+	key->flag2	= FIELD_GET(ICE_PGNCK_F2, data);
+	key->flag3	= FIELD_GET(ICE_PGNCK_F3, data);
+
+	if (FIELD_GET(ICE_PGNCK_BH, data))
+		key->boost_idx = FIELD_GET(ICE_PGNCK_BI, data);
+	else
+		key->boost_idx = 0;
+
+	key->alu_reg	= FIELD_GET(ICE_PGNCK_AR, data);
+}
+
+#define ICE_PGCK_VLD	BIT_ULL(0)
+#define ICE_PGCK_NID	GENMASK_ULL(11, 1)
+#define ICE_PGCK_F0	BIT_ULL(12)
+#define ICE_PGCK_F1	BIT_ULL(13)
+#define ICE_PGCK_F2	BIT_ULL(14)
+#define ICE_PGCK_F3	BIT_ULL(15)
+#define ICE_PGCK_BH	BIT_ULL(16)
+#define ICE_PGCK_BI	GENMASK_ULL(24, 17)
+#define ICE_PGCK_AR	GENMASK_ULL(40, 25)
+#define ICE_PGCK_NPK_S	41	/* offset for the 2nd 64-bits field */
+#define ICE_PGCK_NPK	GENMASK_ULL(72 - ICE_PGCK_NPK_S, 41 - ICE_PGCK_NPK_S)
+
+/** The function parses a 73 bits Parse Graph CAM Key with below format:
+ *  BIT 0:	Valid		(key->valid)
+ *  BIT 1-11:	Node ID		(key->node_id)
+ *  BIT 12:	Flag 0		(key->flag0)
+ *  BIT 13:	Flag 1		(key->flag1)
+ *  BIT 14:	Flag 2		(key->flag2)
+ *  BIT 15:	Flag 3		(key->flag3)
+ *  BIT 16:	Boost Hit	(key->boost_idx to 0 if it is 0)
+ *  BIT 17-24:	Boost Index	(key->boost_idx only if Boost Hit is not 0)
+ *  BIT 25-40:	ALU Reg		(key->alu_reg)
+ *  BIT 41-72:	Next Proto Key	(key->next_proto)
+ */
+static void _ice_pg_cam_key_init(struct ice_pg_cam_key *key, u8 *data)
+{
+	u64 d64 = *(u64 *)data;
+	u8 idd, off;
+
+	key->valid	= FIELD_GET(ICE_PGCK_VLD, d64);
+	key->node_id	= FIELD_GET(ICE_PGCK_NID, d64);
+	key->flag0	= FIELD_GET(ICE_PGCK_F0, d64);
+	key->flag1	= FIELD_GET(ICE_PGCK_F1, d64);
+	key->flag2	= FIELD_GET(ICE_PGCK_F2, d64);
+	key->flag3	= FIELD_GET(ICE_PGCK_F3, d64);
+
+	if (FIELD_GET(ICE_PGCK_BH, d64))
+		key->boost_idx = FIELD_GET(ICE_PGCK_BI, d64);
+	else
+		key->boost_idx = 0;
+
+	key->alu_reg	= FIELD_GET(ICE_PGCK_AR, d64);
+
+	idd = ICE_PGCK_NPK_S / BITS_PER_BYTE;
+	off = ICE_PGCK_NPK_S % BITS_PER_BYTE;
+	d64 = *((u64 *)&data[idd]) >> off;
+
+	key->next_proto	= FIELD_GET(ICE_PGCK_NPK, d64);
+}
+
+#define ICE_PG_CAM_KEY_OFF	0
+#define ICE_PG_CAM_ACT_OFF	73
+
+/** The function parses a 128 bits Parse Graph CAM Entry with below format:
+ *  BIT 0-72:	Key	(ci->key)
+ *  BIT 73-127:	Action	(ci->action)
+ */
+static void _ice_pg_cam_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				   void *data, int size)
+{
+	struct ice_pg_cam_item *ci = item;
+	u8 *buf = data;
+	u64 d64;
+	u8 off;
+
+	ci->idx = idx;
+
+	_ice_pg_cam_key_init(&ci->key, buf);
+
+	off = ICE_PG_CAM_ACT_OFF % BITS_PER_BYTE;
+	d64 = *((u64 *)&buf[ICE_PG_CAM_ACT_OFF / BITS_PER_BYTE]) >> off;
+	_ice_pg_cam_action_init(&ci->action, d64);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_pg_cam_dump(hw, ci);
+}
+
+#define ICE_PG_SP_CAM_ACT_OFF	0
+#define ICE_PG_SP_CAM_KEY_OFF	56
+
+/** The function parses a 136 bits Parse Graph Spill CAM Entry with below
+ *  format:
+ *  BIT 0-55:	Action	(ci->key)
+ *  BIT 56-135:	Key	(ci->action)
+ */
+static void _ice_pg_sp_cam_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				      void *data, int size)
+{
+	struct ice_pg_cam_item *ci = item;
+	u8 *buf = data;
+	u64 d64;
+	u8 idd;
+
+	ci->idx = idx;
+
+	d64 = *(u64 *)buf;
+	_ice_pg_cam_action_init(&ci->action, d64);
+
+	idd = ICE_PG_SP_CAM_KEY_OFF / BITS_PER_BYTE;
+	_ice_pg_cam_key_init(&ci->key, &buf[idd]);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_pg_cam_dump(hw, ci);
+}
+
+#define ICE_PG_NM_CAM_KEY_OFF	0
+#define ICE_PG_NM_CAM_ACT_OFF	41
+
+/** The function parses a 96 bits Parse Graph NoMatch CAM Entry with below
+ *  format:
+ *  BIT 0-40:	Key	(ci->key)
+ *  BIT 41-95:	Action	(ci->action)
+ */
+static void _ice_pg_nm_cam_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				      void *data, int size)
+{
+	struct ice_pg_nm_cam_item *ci = item;
+	u8 *buf = data;
+	u64 d64;
+	u8 off;
+
+	ci->idx = idx;
+
+	d64 = *(u64 *)buf;
+	_ice_pg_nm_cam_key_init(&ci->key, d64);
+
+	off = ICE_PG_NM_CAM_ACT_OFF % BITS_PER_BYTE;
+	d64 = *((u64 *)&buf[ICE_PG_NM_CAM_ACT_OFF / BITS_PER_BYTE]) >> off;
+	_ice_pg_cam_action_init(&ci->action, d64);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_pg_nm_cam_dump(hw, ci);
+}
+
+#define ICE_PG_NM_SP_CAM_KEY_OFF	0
+#define ICE_PG_NM_SP_CAM_ACT_OFF	56
+
+/** The function parses a 104 bits Parse Graph NoMatch Spill CAM Entry with
+ *  below format:
+ *  BIT 0-55:	Key	(ci->key)
+ *  BIT 56-103:	Action	(ci->action)
+ */
+static void _ice_pg_nm_sp_cam_parse_item(struct ice_hw *hw, u16 idx,
+					 void *item, void *data, int size)
+{
+	struct ice_pg_nm_cam_item *ci = item;
+	u8 *buf = data;
+	u64 d64;
+	u8 off;
+
+	ci->idx = idx;
+
+	d64 = *(u64 *)buf;
+	_ice_pg_cam_action_init(&ci->action, d64);
+
+	off = ICE_PG_NM_SP_CAM_ACT_OFF % BITS_PER_BYTE;
+	d64 = *((u64 *)&buf[ICE_PG_NM_SP_CAM_ACT_OFF / BITS_PER_BYTE]) >> off;
+	_ice_pg_nm_cam_key_init(&ci->key, d64);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_pg_nm_cam_dump(hw, ci);
+}
+
+/**
+ * ice_pg_cam_table_get - create a parse graph cam table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_pg_cam_item *ice_pg_cam_table_get(struct ice_hw *hw)
+{
+	return (struct ice_pg_cam_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_CAM,
+					sizeof(struct ice_pg_cam_item),
+					ICE_PG_CAM_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_pg_cam_parse_item);
+}
+
+/**
+ * ice_pg_sp_cam_table_get - create a parse graph spill cam table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_pg_cam_item *ice_pg_sp_cam_table_get(struct ice_hw *hw)
+{
+	return (struct ice_pg_cam_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_PG_SPILL,
+					sizeof(struct ice_pg_cam_item),
+					ICE_PG_SP_CAM_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_pg_sp_cam_parse_item);
+}
+
+/**
+ * ice_pg_nm_cam_table_get - create a parse graph no match cam table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_pg_nm_cam_item *ice_pg_nm_cam_table_get(struct ice_hw *hw)
+{
+	return (struct ice_pg_nm_cam_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_NOMATCH_CAM,
+					sizeof(struct ice_pg_nm_cam_item),
+					ICE_PG_NM_CAM_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_pg_nm_cam_parse_item);
+}
+
+/**
+ * ice_pg_nm_sp_cam_table_get - create a parse graph no match spill cam table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw)
+{
+	return (struct ice_pg_nm_cam_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_NOMATCH_SPILL,
+					sizeof(struct ice_pg_nm_cam_item),
+					ICE_PG_NM_SP_CAM_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_pg_nm_sp_cam_parse_item);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_pg_cam.h b/drivers/net/ethernet/intel/ice/ice_pg_cam.h
new file mode 100644
index 000000000000..472f54530c4c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_pg_cam.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_PG_CAM_H_
+#define _ICE_PG_CAM_H_
+
+#define ICE_PG_CAM_TABLE_SIZE		2048
+#define ICE_PG_SP_CAM_TABLE_SIZE	128
+#define ICE_PG_NM_CAM_TABLE_SIZE	1024
+#define ICE_PG_NM_SP_CAM_TABLE_SIZE	64
+
+struct ice_pg_cam_key {
+	bool valid;
+	u16 node_id;
+	bool flag0;
+	bool flag1;
+	bool flag2;
+	bool flag3;
+	u8 boost_idx;
+	u16 alu_reg;
+	u32 next_proto;
+};
+
+struct ice_pg_nm_cam_key {
+	bool valid;
+	u16 node_id;
+	bool flag0;
+	bool flag1;
+	bool flag2;
+	bool flag3;
+	u8 boost_idx;
+	u16 alu_reg;
+};
+
+struct ice_pg_cam_action {
+	u16 next_node;
+	u8 next_pc;
+	bool is_pg;
+	u8 proto_id;
+	bool is_mg;
+	u8 marker_id;
+	bool is_last_round;
+	bool ho_polarity;
+	u16 ho_inc;
+};
+
+struct ice_pg_cam_item {
+	u16 idx;
+	struct ice_pg_cam_key key;
+	struct ice_pg_cam_action action;
+};
+
+struct ice_pg_nm_cam_item {
+	u16 idx;
+	struct ice_pg_nm_cam_key key;
+	struct ice_pg_cam_action action;
+};
+
+void ice_pg_cam_dump(struct ice_hw *hw, struct ice_pg_cam_item *item);
+void ice_pg_nm_cam_dump(struct ice_hw *hw, struct ice_pg_nm_cam_item *item);
+
+struct ice_pg_cam_item *ice_pg_cam_table_get(struct ice_hw *hw);
+struct ice_pg_cam_item *ice_pg_sp_cam_table_get(struct ice_hw *hw);
+
+struct ice_pg_nm_cam_item *ice_pg_nm_cam_table_get(struct ice_hw *hw);
+struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw);
+#endif /* _ICE_PG_CAM_H_ */
-- 
2.25.1


