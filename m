Return-Path: <netdev+bounces-29928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0464378544F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C011C20CA1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501EBA33;
	Wed, 23 Aug 2023 09:32:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F5BA2F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:32:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69344B5
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692783169; x=1724319169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g3aj2FsaLVnr3fWo9eMN3EsLaGk+BzQHq05GYFS+U5A=;
  b=VhNkkxQLHAciAuWgZA5i3Iq410alH1jdcdsSOHKFOTthLaONaRKofLrn
   rX42HLF3BLvpJQMRC82tzPO47NIwAoFOuplw6WApS17ZEs8QD5IUJGw6N
   KCIrHii+oDwFNM7+c8SmcjMh3ZqdMfS1YI2h/BA52q3+ggLf9UQmQ9WIw
   eiQ6EvdJ2RS8clU5/u9hVdJ7kdHRuJxdjoQGk1eMnge182fNe6p/UjMkO
   jFC1pCRM42wqD51G/Ut6Ih8RYGt8U5d+1IygZlLNxGs+YFbpggs2lzZsQ
   RnhGR+ATNX4t68GSFVOSAJhNnyq7/r7ORJzjznQTPEi2frajhUkZm/PeY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="359100551"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359100551"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 02:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713507562"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713507562"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2023 02:32:26 -0700
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
Subject: [PATCH iwl-next v7 08/15] ice: init flag redirect table for parser
Date: Wed, 23 Aug 2023 17:31:51 +0800
Message-Id: <20230823093158.782802-9-junfeng.guo@intel.com>
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

Parse DDP section ICE_SID_RXPARSER_FLAG_REDIR into an array of
ice_flag_rd_item.

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_flg_rd.c | 50 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_flg_rd.h | 23 ++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.c | 10 +++++
 drivers/net/ethernet/intel/ice/ice_parser.h |  4 ++
 5 files changed, 88 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_flg_rd.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_flg_rd.h

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index da5dfeed3b1f..45beed8b4415 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -261,6 +261,7 @@ struct ice_meta_sect {
 #define ICE_SID_CDID_KEY_BUILDER_PE 87
 #define ICE_SID_CDID_REDIR_PE 88
 
+#define ICE_SID_RXPARSER_FLAG_REDIR	97
 /* Label Metadata section IDs */
 #define ICE_SID_LBL_FIRST 0x80000010
 #define ICE_SID_LBL_RXPARSER_TMEM 0x80000018
diff --git a/drivers/net/ethernet/intel/ice/ice_flg_rd.c b/drivers/net/ethernet/intel/ice/ice_flg_rd.c
new file mode 100644
index 000000000000..9d5d66d0c773
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_flg_rd.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+#include "ice_parser_util.h"
+
+/**
+ * ice_flg_rd_dump - dump a flag redirect item info
+ * @hw: pointer to the hardware structure
+ * @item: flag redirect item to dump
+ */
+void ice_flg_rd_dump(struct ice_hw *hw, struct ice_flg_rd_item *item)
+{
+	dev_info(ice_hw_to_dev(hw), "index = %d\n", item->idx);
+	dev_info(ice_hw_to_dev(hw), "expose = %d\n", item->expose);
+	dev_info(ice_hw_to_dev(hw), "intr_flg_id = %d\n", item->intr_flg_id);
+}
+
+/** The function parses a 8 bits Flag Redirect Table entry with below format:
+ *  BIT 0:	Expose			(rdi->expose)
+ *  BIT 1-6:	Internal Flag ID	(rdi->intr_flg_id)
+ *  BIT 7:	reserved
+ */
+static void _ice_flg_rd_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				   void *data, int size)
+{
+	struct ice_flg_rd_item *rdi = item;
+	u8 d8 = *(u8 *)data;
+
+	rdi->idx		= idx;
+	rdi->expose		= !!(d8 & ICE_RDI_EXP_M);
+	rdi->intr_flg_id	= (u8)((d8 >> ICE_RDI_IFD_S) & ICE_RDI_IFD_M);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_flg_rd_dump(hw, rdi);
+}
+
+/**
+ * ice_flg_rd_table_get - create a flag redirect table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw)
+{
+	return (struct ice_flg_rd_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_FLAG_REDIR,
+					sizeof(struct ice_flg_rd_item),
+					ICE_FLG_RD_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_flg_rd_parse_item, false);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_flg_rd.h b/drivers/net/ethernet/intel/ice/ice_flg_rd.h
new file mode 100644
index 000000000000..b3b4fd7a9002
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_flg_rd.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_FLG_RD_H_
+#define _ICE_FLG_RD_H_
+
+#define ICE_FLG_RD_TABLE_SIZE	64
+#define ICE_FLG_RDT_SIZE	64
+
+#define ICE_RDI_EXP_S		0
+#define ICE_RDI_EXP_M		BITMAP_MASK(1)
+#define ICE_RDI_IFD_S		1
+#define ICE_RDI_IFD_M		BITMAP_MASK(6)
+
+struct ice_flg_rd_item {
+	u16 idx;
+	bool expose;
+	u8 intr_flg_id;
+};
+
+void ice_flg_rd_dump(struct ice_hw *hw, struct ice_flg_rd_item *item);
+struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw);
+#endif /* _ICE_FLG_RD_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 4da2d4c21bab..3c3f7d6bea52 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -68,6 +68,9 @@ void *ice_parser_sect_item_get(u32 sect_type, void *section,
 	case ICE_SID_RXPARSER_PROTO_GRP:
 		size = ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE;
 		break;
+	case ICE_SID_RXPARSER_FLAG_REDIR:
+		size = ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE;
+		break;
 	default:
 		return NULL;
 	}
@@ -220,6 +223,12 @@ int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
 		goto err;
 	}
 
+	p->flg_rd_table = ice_flg_rd_table_get(hw);
+	if (!p->flg_rd_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
 	*psr = p;
 	return 0;
 err:
@@ -244,6 +253,7 @@ void ice_parser_destroy(struct ice_parser *psr)
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->ptype_mk_tcam_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->mk_grp_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->proto_grp_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->flg_rd_table);
 
 	devm_kfree(ice_hw_to_dev(psr->hw), psr);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 4038833450f2..62123788e0a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -11,6 +11,7 @@
 #include "ice_ptype_mk.h"
 #include "ice_mk_grp.h"
 #include "ice_proto_grp.h"
+#include "ice_flg_rd.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
@@ -23,6 +24,7 @@
 #define ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE		24
 #define ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE		8
 #define ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE		24
+#define ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE		1
 
 #define ICE_SEC_LBL_DATA_OFFSET				2
 #define ICE_SID_LBL_ENTRY_SIZE				66
@@ -52,6 +54,8 @@ struct ice_parser {
 	struct ice_mk_grp_item *mk_grp_table;
 	/* load data from section ICE_SID_RXPARSER_PROTO_GRP */
 	struct ice_proto_grp_item *proto_grp_table;
+	/* load data from section ICE_SID_RXPARSER_FLAG_REDIR */
+	struct ice_flg_rd_item *flg_rd_table;
 };
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
-- 
2.25.1


