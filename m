Return-Path: <netdev+bounces-29929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A6785458
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BC3281313
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217FBBA4E;
	Wed, 23 Aug 2023 09:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD80BA2F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:32:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F244AF
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692783169; x=1724319169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vCYWVvxkMdL4IFxwc3MUYglzDpuG2NQY5N5/RVHYwa8=;
  b=Bj+zk4+oHtBhi8fPkq/2P5N8tB/RfTKnDznG/1pvnCx4TuGMBXbTaL6P
   HSFoUOKpeytx0RAUKyEeLApY/Jnw488Qi88pSg6+kJIMdZeTPCnWhkI5V
   EyPkxb06oWXgWEXaHlbG6wtX9vXV6Wo3JfJxCN9O+CEC3E76a8mpZFebS
   niws5ybjl6gUP853A0g5Spv8D5sw6qVXdUNP1oZ03o/ZAwteLLmzy5Zxr
   9hkGweSYMNfOsMUbFX0PL90Si2h7XWBdP5hj8t9BloHz3paibDrED78VS
   hayu11A4cuNWjsTEcFMTHKAvuS1jIzOMTF0LR0g3xmZz03cbnkgP0WSbC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="359100534"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359100534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 02:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713507543"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713507543"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2023 02:32:23 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	qi.z.zhang@intel.com,
	ivecera@redhat.com,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	Junfeng Guo <junfeng.guo@intel.com>
Subject: [PATCH iwl-next v7 07/15] ice: init marker and protocol group tables for parser
Date: Wed, 23 Aug 2023 17:31:50 +0800
Message-Id: <20230823093158.782802-8-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823093158.782802-1-junfeng.guo@intel.com>
References: <20230821081438.2937934-1-junfeng.guo@intel.com>
 <20230823093158.782802-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Parse DDP section ICE_SID_RXPARSER_MARKER_GRP into an array of
ice_mk_grp_item.
Parse DDP section ICE_SID_RXPARSER_PROTO_GRP into an array of
ice_proto_grp_item.

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_mk_grp.c   | 51 +++++++++++
 drivers/net/ethernet/intel/ice/ice_mk_grp.h   | 17 ++++
 drivers/net/ethernet/intel/ice/ice_parser.c   | 20 +++++
 drivers/net/ethernet/intel/ice/ice_parser.h   |  8 ++
 .../net/ethernet/intel/ice/ice_proto_grp.c    | 90 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_proto_grp.h    | 31 +++++++
 6 files changed, 217 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_mk_grp.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_mk_grp.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_proto_grp.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_proto_grp.h

diff --git a/drivers/net/ethernet/intel/ice/ice_mk_grp.c b/drivers/net/ethernet/intel/ice/ice_mk_grp.c
new file mode 100644
index 000000000000..395e43343165
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_mk_grp.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+#include "ice_parser_util.h"
+
+/**
+ * ice_mk_grp_dump - dump an marker group item info
+ * @hw: pointer to the hardware structure
+ * @item: marker group item to dump
+ */
+void ice_mk_grp_dump(struct ice_hw *hw, struct ice_mk_grp_item *item)
+{
+	int i;
+
+	dev_info(ice_hw_to_dev(hw), "index = %d\n", item->idx);
+	dev_info(ice_hw_to_dev(hw), "markers: ");
+	for (i = 0; i < ICE_MK_COUNT_PER_GRP; i++)
+		dev_info(ice_hw_to_dev(hw), "%d ", item->markers[i]);
+	dev_info(ice_hw_to_dev(hw), "\n");
+}
+
+static void _ice_mk_grp_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				   void *data, int size)
+{
+	struct ice_mk_grp_item *grp = item;
+	u8 *buf = data;
+	int i;
+
+	grp->idx = idx;
+
+	for (i = 0; i < ICE_MK_COUNT_PER_GRP; i++)
+		grp->markers[i] = buf[i];
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_mk_grp_dump(hw, grp);
+}
+
+/**
+ * ice_mk_grp_table_get - create a marker group table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_mk_grp_item *ice_mk_grp_table_get(struct ice_hw *hw)
+{
+	return (struct ice_mk_grp_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_MARKER_GRP,
+					sizeof(struct ice_mk_grp_item),
+					ICE_MK_GRP_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_mk_grp_parse_item, false);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_mk_grp.h b/drivers/net/ethernet/intel/ice/ice_mk_grp.h
new file mode 100644
index 000000000000..c5c8734b9d3e
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_mk_grp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_MK_GRP_H_
+#define _ICE_MK_GRP_H_
+
+#define ICE_MK_GRP_TABLE_SIZE	128
+#define ICE_MK_COUNT_PER_GRP	8
+
+struct ice_mk_grp_item {
+	int idx;
+	u8 markers[ICE_MK_COUNT_PER_GRP];
+};
+
+void ice_mk_grp_dump(struct ice_hw *hw, struct ice_mk_grp_item *item);
+struct ice_mk_grp_item *ice_mk_grp_table_get(struct ice_hw *hw);
+#endif /* _ICE_MK_GRP_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 01684a7c5c75..4da2d4c21bab 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -62,6 +62,12 @@ void *ice_parser_sect_item_get(u32 sect_type, void *section,
 	case ICE_SID_RXPARSER_MARKER_PTYPE:
 		size = ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE;
 		break;
+	case ICE_SID_RXPARSER_MARKER_GRP:
+		size = ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE;
+		break;
+	case ICE_SID_RXPARSER_PROTO_GRP:
+		size = ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE;
+		break;
 	default:
 		return NULL;
 	}
@@ -202,6 +208,18 @@ int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
 		goto err;
 	}
 
+	p->mk_grp_table = ice_mk_grp_table_get(hw);
+	if (!p->mk_grp_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->proto_grp_table = ice_proto_grp_table_get(hw);
+	if (!p->proto_grp_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
 	*psr = p;
 	return 0;
 err:
@@ -224,6 +242,8 @@ void ice_parser_destroy(struct ice_parser *psr)
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->bst_tcam_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->bst_lbl_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->ptype_mk_tcam_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->mk_grp_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->proto_grp_table);
 
 	devm_kfree(ice_hw_to_dev(psr->hw), psr);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index c0ac4b2a9a6e..4038833450f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -9,6 +9,8 @@
 #include "ice_pg_cam.h"
 #include "ice_bst_tcam.h"
 #include "ice_ptype_mk.h"
+#include "ice_mk_grp.h"
+#include "ice_proto_grp.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
@@ -19,6 +21,8 @@
 #define ICE_SID_RXPARSER_NOMATCH_SPILL_ENTRY_SIZE	13
 #define ICE_SID_RXPARSER_BOOST_TCAM_ENTRY_SIZE		88
 #define ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE		24
+#define ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE		8
+#define ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE		24
 
 #define ICE_SEC_LBL_DATA_OFFSET				2
 #define ICE_SID_LBL_ENTRY_SIZE				66
@@ -44,6 +48,10 @@ struct ice_parser {
 	struct ice_lbl_item *bst_lbl_table;
 	/* load data from section ICE_SID_RXPARSER_MARKER_PTYPE */
 	struct ice_ptype_mk_tcam_item *ptype_mk_tcam_table;
+	/* load data from section ICE_SID_RXPARSER_MARKER_GRP */
+	struct ice_mk_grp_item *mk_grp_table;
+	/* load data from section ICE_SID_RXPARSER_PROTO_GRP */
+	struct ice_proto_grp_item *proto_grp_table;
 };
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
diff --git a/drivers/net/ethernet/intel/ice/ice_proto_grp.c b/drivers/net/ethernet/intel/ice/ice_proto_grp.c
new file mode 100644
index 000000000000..c53970b47029
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_proto_grp.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+#include "ice_parser_util.h"
+
+static void _ice_proto_off_dump(struct ice_hw *hw, struct ice_proto_off *po,
+				int idx)
+{
+	dev_info(ice_hw_to_dev(hw), "proto %d\n", idx);
+	dev_info(ice_hw_to_dev(hw), "\tpolarity = %d\n", po->polarity);
+	dev_info(ice_hw_to_dev(hw), "\tproto_id = %d\n", po->proto_id);
+	dev_info(ice_hw_to_dev(hw), "\toffset = %d\n", po->offset);
+}
+
+/**
+ * ice_proto_grp_dump - dump a proto group item info
+ * @hw: pointer to the hardware structure
+ * @item: proto group item to dump
+ */
+void ice_proto_grp_dump(struct ice_hw *hw, struct ice_proto_grp_item *item)
+{
+	int i;
+
+	dev_info(ice_hw_to_dev(hw), "index = %d\n", item->idx);
+
+	for (i = 0; i < ICE_PROTO_COUNT_PER_GRP; i++)
+		_ice_proto_off_dump(hw, &item->po[i], i);
+}
+
+/** The function parses a 22 bits Protocol entry with below format:
+ *  BIT 0:	Polarity of Protocol Offset	(po->polarity)
+ *  BIT 1-8:	Protocol ID			(po->proto_id)
+ *  BIT 9-11:	reserved
+ *  BIT 12-21:	Protocol Offset			(po->offset)
+ */
+static void _ice_proto_off_parse(struct ice_proto_off *po, u32 data)
+{
+	po->polarity	= !!(data & ICE_PO_POL_M);
+	po->proto_id	= (u8)((data >> ICE_PO_PID_S) & ICE_PO_PID_M);
+	po->offset	= (u16)((data >> ICE_PO_OFF_S) & ICE_PO_OFF_M);
+}
+
+/** The function parses a 192 bits Protocol Group Table entry with below
+ *  format:
+ *  BIT 0-21:	Protocol 0	(grp->po[0])
+ *  BIT 22-43:	Protocol 1	(grp->po[1])
+ *  BIT 44-65:	Protocol 2	(grp->po[2])
+ *  BIT 66-87:	Protocol 3	(grp->po[3])
+ *  BIT 88-109:	Protocol 4	(grp->po[4])
+ *  BIT 110-131:Protocol 5	(grp->po[5])
+ *  BIT 132-153:Protocol 6	(grp->po[6])
+ *  BIT 154-175:Protocol 7	(grp->po[7])
+ *  BIT 176-191:reserved
+ */
+static void _ice_proto_grp_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				      void *data, int size)
+{
+	struct ice_proto_grp_item *grp = item;
+	u8 *buf = (u8 *)data;
+	u8 idd, off;
+	u32 d32;
+	int i;
+
+	grp->idx = idx;
+
+	for (i = 0; i < ICE_PROTO_COUNT_PER_GRP; i++) {
+		idd = (ICE_PROTO_GRP_ITEM_SIZE * i) / BITS_PER_BYTE;
+		off = (ICE_PROTO_GRP_ITEM_SIZE * i) % BITS_PER_BYTE;
+		d32 = *((u32 *)&buf[idd]) >> off;
+		_ice_proto_off_parse(&grp->po[i], d32);
+	}
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_proto_grp_dump(hw, grp);
+}
+
+/**
+ * ice_proto_grp_table_get - create a proto group table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_proto_grp_item *ice_proto_grp_table_get(struct ice_hw *hw)
+{
+	return (struct ice_proto_grp_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_PROTO_GRP,
+					sizeof(struct ice_proto_grp_item),
+					ICE_PROTO_GRP_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_proto_grp_parse_item, false);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_proto_grp.h b/drivers/net/ethernet/intel/ice/ice_proto_grp.h
new file mode 100644
index 000000000000..6e2b39151a92
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_proto_grp.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_PROTO_GRP_H_
+#define _ICE_PROTO_GRP_H_
+
+#define ICE_PROTO_COUNT_PER_GRP		8
+#define ICE_PROTO_GRP_TABLE_SIZE	192
+#define ICE_PROTO_GRP_ITEM_SIZE		22
+
+#define ICE_PO_POL_S	0
+#define ICE_PO_POL_M	BITMAP_MASK(1)
+#define ICE_PO_PID_S	1
+#define ICE_PO_PID_M	BITMAP_MASK(8)
+#define ICE_PO_OFF_S	12
+#define ICE_PO_OFF_M	BITMAP_MASK(10)
+
+struct ice_proto_off {
+	bool polarity; /* true: positive, false: nagtive */
+	u8 proto_id;
+	u16 offset;
+};
+
+struct ice_proto_grp_item {
+	u16 idx;
+	struct ice_proto_off po[ICE_PROTO_COUNT_PER_GRP];
+};
+
+void ice_proto_grp_dump(struct ice_hw *hw, struct ice_proto_grp_item *item);
+struct ice_proto_grp_item *ice_proto_grp_table_get(struct ice_hw *hw);
+#endif /* _ICE_PROTO_GRP_H_ */
-- 
2.25.1


