Return-Path: <netdev+bounces-31870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEA79100F
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 04:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F91C20862
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE1396;
	Mon,  4 Sep 2023 02:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396B28EB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:15:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331FF9B
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 19:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693793754; x=1725329754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2M/wZl5/QALIA2UtRlZFCqM9FUghMKmeb04B10t18qs=;
  b=HXknpoWATWuiYeGVZLMJGmCJxKqLdqI8CO2hHP48pE7aP+U5bq1cCAah
   zK6G90NmT+6cRBRfwGcMT4frEz3FDKXCbvBJgFZq7Bjh6F4R6flavIiga
   mKBQ87JTgUbLRnPc8YtfUeUkTtcL7AzS7SEdaHaKf+W4xFnfJxYX3MJd6
   khsd3uqg1EF9tgUXenYr5IO9BJ0Dwzq54h+qVNVUra3prxzVmqyAVeBaG
   27sNg8wSBYQjsagwC1VGVDSV9J5WH/+1P2GpHBWSOUBykesYmpgKttuCg
   ALs0l+OGCDvp8KJGbNgHlH1HlokCGYfsWq9ccZExXRhjIdMpKwiCDaK17
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379215318"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379215318"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769826930"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769826930"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2023 19:15:49 -0700
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
Subject: [PATCH iwl-next v9 11/15] ice: add internal help functions
Date: Mon,  4 Sep 2023 10:14:51 +0800
Message-Id: <20230904021455.3944605-12-junfeng.guo@intel.com>
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

Add below internal helper function:

- [ice_bst_tcam_match]:
  to perform ternary match on boost TCAM.

- [ice_pg_cam_match]:
  to perform parse graph key match in cam table.

- [ice_pg_nm_cam_match]:
  to perform parse graph key no match in cam table.

- [ice_ptype_mk_tcam_match]:
  to perform ptype markers match in tcam table.

- [ice_flg_redirect]:
  to redirect parser flags to packet flags.

- [ice_xlt_kb_flg_get]:
  to aggregate 64 bit packet flag into 16 bit key builder flags.

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_bst_tcam.c | 23 ++++++
 drivers/net/ethernet/intel/ice/ice_bst_tcam.h |  3 +
 drivers/net/ethernet/intel/ice/ice_flg_rd.c   | 23 ++++++
 drivers/net/ethernet/intel/ice/ice_flg_rd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_parser.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_pg_cam.c   | 76 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_pg_cam.h   |  6 ++
 drivers/net/ethernet/intel/ice/ice_ptype_mk.c | 22 ++++++
 drivers/net/ethernet/intel/ice/ice_ptype_mk.h |  3 +
 drivers/net/ethernet/intel/ice/ice_tmatch.h   | 40 ++++++++++
 drivers/net/ethernet/intel/ice/ice_xlt_kb.c   | 29 +++++++
 drivers/net/ethernet/intel/ice/ice_xlt_kb.h   |  1 +
 12 files changed, 228 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tmatch.h

diff --git a/drivers/net/ethernet/intel/ice/ice_bst_tcam.c b/drivers/net/ethernet/intel/ice/ice_bst_tcam.c
index af6fb48f3fa0..99148f1cf4f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_bst_tcam.c
+++ b/drivers/net/ethernet/intel/ice/ice_bst_tcam.c
@@ -311,3 +311,26 @@ struct ice_lbl_item *ice_bst_lbl_table_get(struct ice_hw *hw)
 					ice_parser_sect_item_get,
 					_ice_parse_lbl_item, true);
 }
+
+/**
+ * ice_bst_tcam_match - match a pattern on the boost tcam table
+ * @tcam_table: boost tcam table to search
+ * @pat: pattern to match
+ */
+struct ice_bst_tcam_item *
+ice_bst_tcam_match(struct ice_bst_tcam_item *tcam_table, u8 *pat)
+{
+	int i;
+
+	for (i = 0; i < ICE_BST_TCAM_TABLE_SIZE; i++) {
+		struct ice_bst_tcam_item *item = &tcam_table[i];
+
+		if (item->hit_idx_grp == 0)
+			continue;
+		if (ice_ternary_match(item->key, item->key_inv, pat,
+				      ICE_BST_TCAM_KEY_SIZE))
+			return item;
+	}
+
+	return NULL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_bst_tcam.h b/drivers/net/ethernet/intel/ice/ice_bst_tcam.h
index e824d10d5fa7..73a46dc56b29 100644
--- a/drivers/net/ethernet/intel/ice/ice_bst_tcam.h
+++ b/drivers/net/ethernet/intel/ice/ice_bst_tcam.h
@@ -30,4 +30,7 @@ void ice_bst_tcam_dump(struct ice_hw *hw, struct ice_bst_tcam_item *item);
 struct ice_bst_tcam_item *ice_bst_tcam_table_get(struct ice_hw *hw);
 
 struct ice_lbl_item *ice_bst_lbl_table_get(struct ice_hw *hw);
+
+struct ice_bst_tcam_item *
+ice_bst_tcam_match(struct ice_bst_tcam_item *tcam_table, u8 *pat);
 #endif /*_ICE_BST_TCAM_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_flg_rd.c b/drivers/net/ethernet/intel/ice/ice_flg_rd.c
index 774dd2dcef0c..a9011d9dd76a 100644
--- a/drivers/net/ethernet/intel/ice/ice_flg_rd.c
+++ b/drivers/net/ethernet/intel/ice/ice_flg_rd.c
@@ -52,3 +52,26 @@ struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw)
 					ice_parser_sect_item_get,
 					_ice_flg_rd_parse_item, false);
 }
+
+/**
+ * ice_flg_redirect - redirect a parser flag to packet flag
+ * @table: flag redirect table
+ * @psr_flg: parser flag to redirect
+ */
+u64 ice_flg_redirect(struct ice_flg_rd_item *table, u64 psr_flg)
+{
+	u64 flg = 0;
+	int i;
+
+	for (i = 0; i < ICE_FLG_RDT_SIZE; i++) {
+		struct ice_flg_rd_item *item = &table[i];
+
+		if (!item->expose)
+			continue;
+
+		if (psr_flg & BIT(item->intr_flg_id))
+			flg |= BIT(i);
+	}
+
+	return flg;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_flg_rd.h b/drivers/net/ethernet/intel/ice/ice_flg_rd.h
index 46220c3dc570..e4a863600594 100644
--- a/drivers/net/ethernet/intel/ice/ice_flg_rd.h
+++ b/drivers/net/ethernet/intel/ice/ice_flg_rd.h
@@ -15,4 +15,5 @@ struct ice_flg_rd_item {
 
 void ice_flg_rd_dump(struct ice_hw *hw, struct ice_flg_rd_item *item);
 struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw);
+u64 ice_flg_redirect(struct ice_flg_rd_item *table, u64 psr_flg);
 #endif /* _ICE_FLG_RD_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 5f98f3031294..bfcef4f597bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -14,6 +14,7 @@
 #include "ice_flg_rd.h"
 #include "ice_xlt_kb.h"
 #include "ice_parser_rt.h"
+#include "ice_tmatch.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
diff --git a/drivers/net/ethernet/intel/ice/ice_pg_cam.c b/drivers/net/ethernet/intel/ice/ice_pg_cam.c
index 5e0965286c02..112d661c5101 100644
--- a/drivers/net/ethernet/intel/ice/ice_pg_cam.c
+++ b/drivers/net/ethernet/intel/ice/ice_pg_cam.c
@@ -366,3 +366,79 @@ struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw)
 					ice_parser_sect_item_get,
 					_ice_pg_nm_sp_cam_parse_item, false);
 }
+
+static bool _ice_pg_cam_match(struct ice_pg_cam_item *item,
+			      struct ice_pg_cam_key *key)
+{
+	if (!item->key.valid ||
+	    item->key.node_id	!= key->node_id ||
+	    item->key.flag0	!= key->flag0 ||
+	    item->key.flag1	!= key->flag1 ||
+	    item->key.flag2	!= key->flag2 ||
+	    item->key.flag3	!= key->flag3 ||
+	    item->key.boost_idx	!= key->boost_idx ||
+	    item->key.alu_reg	!= key->alu_reg ||
+	    item->key.next_proto != key->next_proto)
+		return false;
+
+	return true;
+}
+
+static bool _ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *item,
+				 struct ice_pg_cam_key *key)
+{
+	if (!item->key.valid ||
+	    item->key.node_id	!= key->node_id ||
+	    item->key.flag0	!= key->flag0 ||
+	    item->key.flag1	!= key->flag1 ||
+	    item->key.flag2	!= key->flag2 ||
+	    item->key.flag3	!= key->flag3 ||
+	    item->key.boost_idx	!= key->boost_idx ||
+	    item->key.alu_reg	!= key->alu_reg)
+		return false;
+
+	return true;
+}
+
+/**
+ * ice_pg_cam_match - search parse graph cam table by key
+ * @table: parse graph cam table to search
+ * @size: cam table size
+ * @key: search key
+ */
+struct ice_pg_cam_item *ice_pg_cam_match(struct ice_pg_cam_item *table,
+					 int size, struct ice_pg_cam_key *key)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		struct ice_pg_cam_item *item = &table[i];
+
+		if (_ice_pg_cam_match(item, key))
+			return item;
+	}
+
+	return NULL;
+}
+
+/**
+ * ice_pg_nm_cam_match - search parse graph no match cam table by key
+ * @table: parse graph no match cam table to search
+ * @size: cam table size
+ * @key: search key
+ */
+struct ice_pg_nm_cam_item *
+ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *table, int size,
+		    struct ice_pg_cam_key *key)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		struct ice_pg_nm_cam_item *item = &table[i];
+
+		if (_ice_pg_nm_cam_match(item, key))
+			return item;
+	}
+
+	return NULL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_pg_cam.h b/drivers/net/ethernet/intel/ice/ice_pg_cam.h
index 472f54530c4c..6a0fbb6f7249 100644
--- a/drivers/net/ethernet/intel/ice/ice_pg_cam.h
+++ b/drivers/net/ethernet/intel/ice/ice_pg_cam.h
@@ -64,4 +64,10 @@ struct ice_pg_cam_item *ice_pg_sp_cam_table_get(struct ice_hw *hw);
 
 struct ice_pg_nm_cam_item *ice_pg_nm_cam_table_get(struct ice_hw *hw);
 struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw);
+
+struct ice_pg_cam_item *ice_pg_cam_match(struct ice_pg_cam_item *table,
+					 int size, struct ice_pg_cam_key *key);
+struct ice_pg_nm_cam_item *
+ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *table, int size,
+		    struct ice_pg_cam_key *key);
 #endif /* _ICE_PG_CAM_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptype_mk.c b/drivers/net/ethernet/intel/ice/ice_ptype_mk.c
index ee7b09618d54..fbd46ae857a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptype_mk.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptype_mk.c
@@ -49,3 +49,25 @@ struct ice_ptype_mk_tcam_item *ice_ptype_mk_tcam_table_get(struct ice_hw *hw)
 					ice_parser_sect_item_get,
 					_ice_parse_ptype_mk_tcam_item, true);
 }
+
+/**
+ * ice_ptype_mk_tcam_match - match a pattern on a ptype marker tcam table
+ * @table: ptype marker tcam table to search
+ * @pat: pattern to match
+ * @len: length of the pattern
+ */
+struct ice_ptype_mk_tcam_item *
+ice_ptype_mk_tcam_match(struct ice_ptype_mk_tcam_item *table,
+			u8 *pat, int len)
+{
+	int i;
+
+	for (i = 0; i < ICE_PTYPE_MK_TCAM_TABLE_SIZE; i++) {
+		struct ice_ptype_mk_tcam_item *item = &table[i];
+
+		if (ice_ternary_match(item->key, item->key_inv, pat, len))
+			return item;
+	}
+
+	return NULL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptype_mk.h b/drivers/net/ethernet/intel/ice/ice_ptype_mk.h
index 4a071d823bea..c8061f55cccc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptype_mk.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptype_mk.h
@@ -17,4 +17,7 @@ struct ice_ptype_mk_tcam_item {
 void ice_ptype_mk_tcam_dump(struct ice_hw *hw,
 			    struct ice_ptype_mk_tcam_item *item);
 struct ice_ptype_mk_tcam_item *ice_ptype_mk_tcam_table_get(struct ice_hw *hw);
+struct ice_ptype_mk_tcam_item *
+ice_ptype_mk_tcam_match(struct ice_ptype_mk_tcam_item *table,
+			u8 *pat, int len);
 #endif /* _ICE_PTYPE_MK_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_tmatch.h b/drivers/net/ethernet/intel/ice/ice_tmatch.h
new file mode 100644
index 000000000000..e7adcf22ae3f
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_tmatch.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_TMATCH_H_
+#define _ICE_TMATCH_H_
+
+static inline bool ice_ternary_match_byte(u8 key, u8 key_inv, u8 pat)
+{
+	u8 k1, k2, vv;
+	int i;
+
+	for (i = 0; i < BITS_PER_BYTE; i++) {
+		k1 = (u8)(key & BIT(i));
+		k2 = (u8)(key_inv & BIT(i));
+		vv = (u8)(pat & BIT(i));
+
+		if (k1 != 0 && k2 != 0)
+			continue;
+		if (k1 == 0 && k2 == 0)
+			return false;
+
+		if (k1 == vv)
+			return false;
+	}
+
+	return true;
+}
+
+static inline bool ice_ternary_match(const u8 *key, const u8 *key_inv,
+				     const u8 *pat, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (!ice_ternary_match_byte(key[i], key_inv[i], pat[i]))
+			return false;
+
+	return true;
+}
+#endif /* _ICE_TMATCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xlt_kb.c b/drivers/net/ethernet/intel/ice/ice_xlt_kb.c
index 776f5db686f8..b69edec59610 100644
--- a/drivers/net/ethernet/intel/ice/ice_xlt_kb.c
+++ b/drivers/net/ethernet/intel/ice/ice_xlt_kb.c
@@ -228,3 +228,32 @@ struct ice_xlt_kb *ice_xlt_kb_get_rss(struct ice_hw *hw)
 {
 	return _ice_xlt_kb_get(hw, ICE_SID_XLT_KEY_BUILDER_RSS);
 }
+
+#define ICE_XLT_KB_FLAG	GENMASK_ULL(5, 0)
+
+/**
+ * ice_xlt_kb_flag_get - aggregate 64 bits packet flag into 16 bits xlt flag
+ * @kb: xlt key build
+ * @pkt_flag: 64 bits packet flag
+ */
+u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag)
+{
+	struct ice_xlt_kb_entry *entry = &kb->entries[0];
+	u16 flg = 0;
+	int i;
+
+	/* check flag 15 */
+	if (kb->flag15 & pkt_flag)
+		flg = (u16)BIT(ICE_XLT_KB_FLAG0_14_CNT);
+
+	/* check flag 0 - 14 */
+	for (i = 0; i < ICE_XLT_KB_FLAG0_14_CNT; i++) {
+		/* only check first entry */
+		u16 idx = (u16)(entry->flg0_14_sel[i] & ICE_XLT_KB_FLAG);
+
+		if (pkt_flag & BIT(idx))
+			flg |=  (u16)BIT(i);
+	}
+
+	return flg;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_xlt_kb.h b/drivers/net/ethernet/intel/ice/ice_xlt_kb.h
index 81f1f5742075..3fd87184cc7e 100644
--- a/drivers/net/ethernet/intel/ice/ice_xlt_kb.h
+++ b/drivers/net/ethernet/intel/ice/ice_xlt_kb.h
@@ -30,4 +30,5 @@ struct ice_xlt_kb *ice_xlt_kb_get_sw(struct ice_hw *hw);
 struct ice_xlt_kb *ice_xlt_kb_get_acl(struct ice_hw *hw);
 struct ice_xlt_kb *ice_xlt_kb_get_fd(struct ice_hw *hw);
 struct ice_xlt_kb *ice_xlt_kb_get_rss(struct ice_hw *hw);
+u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag);
 #endif /* _ICE_XLT_KB_H */
-- 
2.25.1


