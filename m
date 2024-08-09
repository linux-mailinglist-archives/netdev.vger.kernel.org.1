Return-Path: <netdev+bounces-117259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497694D582
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9C282B65
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4A143C7E;
	Fri,  9 Aug 2024 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHf+V5O5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EA7D405
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224998; cv=none; b=KitU6B9UmojhVBuRV7MPhZzgZB1CFo62W1RVlVfbB0mrKSXecvv7sbc1uKEn+xDBbb3cGaZZ8oX+ZX+tgfX1iTGhqpb9ugWcGErl9tpZ86/zI9GKMzjFW8YHcBfJNGjF5LyrFCjdEFL0RjC3iCRVsOGtYZKzZTa+ayPtm4j3iFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224998; c=relaxed/simple;
	bh=KQHJ2SgNY64HGwyqSaa4nSLlYVYOHnD/TPPAnpF+oyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIx4AHD06t4g/Fwjlto7cyylChXTEFd6+MoZWDxuXOGU9t9Y68URfGJ0z2pEpYAQI05gbMWTxzU70ZrB6TQfU+Vsa+aOyqpC4Zp9/Kphkh5s+LtSSMPPLoEfSX5QUXJixVDOZd1lzKp+tEgALq19kpJdG0lOsuLBzPE/kt5E2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHf+V5O5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723224996; x=1754760996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KQHJ2SgNY64HGwyqSaa4nSLlYVYOHnD/TPPAnpF+oyg=;
  b=jHf+V5O5E7EfM7FwUhUHo4FJHZfHxJLzlycXm4izXWMAnGWgmalPwJ9e
   r9dOhNSWZjZ30xCG1FXqtIlC8tpR+pTeLFAQP5z6FXWBHIT0ViIGfiOit
   QkQmIO6w/b0qE3T8jR2xuJ6CPgfqaPM3lcsyVoaDFWUVnCFqaENZCXtjY
   FU/rDdlPU9Zjhj5rSP15Jk+4eMiwXGo8nVDpZTGhqxPbFvH2lACYs9VWy
   ElVnzYRrQLEqqxxTg7A21niX6bq+gDkLTpD1QLAbHwSyDqlDEIDBOtJgg
   fJnjT+mapRHo3GpxmTvyhbp0ZNlrC5JI3ssw1YtiE4scdT9Kwh8orhcIC
   g==;
X-CSE-ConnectionGUID: QOFBqzHnSXuFM/sJen4/dg==
X-CSE-MsgGUID: /TlkKhm0QNuOhgy8EoAWkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21551269"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21551269"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:36:29 -0700
X-CSE-ConnectionGUID: uKqeOvrKQ7ufEuXi9DlEsQ==
X-CSE-MsgGUID: LMB5CXw7Q1qUFz5aUBT96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57589172"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 10:36:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Junfeng Guo <junfeng.guo@intel.com>,
	anthony.l.nguyen@intel.com,
	ahmed.zaki@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 04/13] ice: add parser internal helper functions
Date: Fri,  9 Aug 2024 10:36:03 -0700
Message-ID: <20240809173615.2031516-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
References: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

Add the following internal helper functions:

- ice_bst_tcam_match():
  to perform ternary match on boost TCAM.

- ice_pg_cam_match():
  to perform parse graph key match in cam table.

- ice_pg_nm_cam_match():
  to perform parse graph key no match in cam table.

- ice_ptype_mk_tcam_match():
  to perform ptype markers match in tcam table.

- ice_flg_redirect():
  to redirect parser flags to packet flags.

- ice_xlt_kb_flag_get():
  to aggregate 64 bit packet flag into 16 bit key builder flags.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 208 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h |  51 +++--
 2 files changed, 244 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 23ba1a36742e..f44310e94150 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -957,6 +957,109 @@ static struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw)
 				       ice_pg_nm_sp_cam_parse_item, false);
 }
 
+static bool __ice_pg_cam_match(struct ice_pg_cam_item *item,
+			       struct ice_pg_cam_key *key)
+{
+	return (item->key.valid &&
+		!memcmp(&item->key.val, &key->val, sizeof(key->val)));
+}
+
+static bool __ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *item,
+				  struct ice_pg_cam_key *key)
+{
+	return (item->key.valid &&
+		!memcmp(&item->key.val, &key->val, sizeof(item->key.val)));
+}
+
+/**
+ * ice_pg_cam_match - search parse graph cam table by key
+ * @table: parse graph cam table to search
+ * @size: cam table size
+ * @key: search key
+ *
+ * Return: a pointer to the matching PG CAM item or NULL.
+ */
+struct ice_pg_cam_item *ice_pg_cam_match(struct ice_pg_cam_item *table,
+					 int size, struct ice_pg_cam_key *key)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		struct ice_pg_cam_item *item = &table[i];
+
+		if (__ice_pg_cam_match(item, key))
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
+ *
+ * Return: a pointer to the matching PG No Match CAM item or NULL.
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
+		if (__ice_pg_nm_cam_match(item, key))
+			return item;
+	}
+
+	return NULL;
+}
+
+/*** Ternary match ***/
+/* Perform a ternary match on a 1-byte pattern (@pat) given @key and @key_inv
+ * Rules (per bit):
+ *     Key == 0 and Key_inv == 0 : Never match (Don't care)
+ *     Key == 0 and Key_inv == 1 : Match on bit == 1
+ *     Key == 1 and Key_inv == 0 : Match on bit == 0
+ *     Key == 1 and Key_inv == 1 : Always match (Don't care)
+ *
+ * Return: true if all bits match, false otherwise.
+ */
+static bool ice_ternary_match_byte(u8 key, u8 key_inv, u8 pat)
+{
+	u8 bit_key, bit_key_inv, bit_pat;
+	int i;
+
+	for (i = 0; i < BITS_PER_BYTE; i++) {
+		bit_key = key & BIT(i);
+		bit_key_inv = key_inv & BIT(i);
+		bit_pat = pat & BIT(i);
+
+		if (bit_key != 0 && bit_key_inv != 0)
+			continue;
+
+		if ((bit_key == 0 && bit_key_inv == 0) || bit_key == bit_pat)
+			return false;
+	}
+
+	return true;
+}
+
+static bool ice_ternary_match(const u8 *key, const u8 *key_inv,
+			      const u8 *pat, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (!ice_ternary_match_byte(key[i], key_inv[i], pat[i]))
+			return false;
+
+	return true;
+}
+
 /*** ICE_SID_RXPARSER_BOOST_TCAM and ICE_SID_LBL_RXPARSER_TMEM sections ***/
 static void ice_bst_np_kb_dump(struct ice_hw *hw, struct ice_np_keybuilder *kb)
 {
@@ -1259,6 +1362,31 @@ static struct ice_lbl_item *ice_bst_lbl_table_get(struct ice_hw *hw)
 				       ice_parse_lbl_item, true);
 }
 
+/**
+ * ice_bst_tcam_match - match a pattern on the boost tcam table
+ * @tcam_table: boost tcam table to search
+ * @pat: pattern to match
+ *
+ * Return: a pointer to the matching Boost TCAM item or NULL.
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
+
 /*** ICE_SID_RXPARSER_MARKER_PTYPE section ***/
 /**
  * ice_ptype_mk_tcam_dump - dump an ptype marker tcam info
@@ -1312,6 +1440,30 @@ struct ice_ptype_mk_tcam_item *ice_ptype_mk_tcam_table_get(struct ice_hw *hw)
 				       ice_parse_ptype_mk_tcam_item, true);
 }
 
+/**
+ * ice_ptype_mk_tcam_match - match a pattern on a ptype marker tcam table
+ * @table: ptype marker tcam table to search
+ * @pat: pattern to match
+ * @len: length of the pattern
+ *
+ * Return: a pointer to the matching Marker PType item or NULL.
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
+
 /*** ICE_SID_RXPARSER_MARKER_GRP section ***/
 /**
  * ice_mk_grp_dump - dump an marker group item info
@@ -1504,6 +1656,31 @@ static struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw)
 				       ice_flg_rd_parse_item, false);
 }
 
+/**
+ * ice_flg_redirect - redirect a parser flag to packet flag
+ * @table: flag redirect table
+ * @psr_flg: parser flag to redirect
+ *
+ * Return: flag or 0 if @psr_flag = 0.
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
+
 /*** ICE_SID_XLT_KEY_BUILDER_SW, ICE_SID_XLT_KEY_BUILDER_ACL,
  * ICE_SID_XLT_KEY_BUILDER_FD and ICE_SID_XLT_KEY_BUILDER_RSS
  * sections ***/
@@ -1737,6 +1914,37 @@ static struct ice_xlt_kb *ice_xlt_kb_get_rss(struct ice_hw *hw)
 	return ice_xlt_kb_get(hw, ICE_SID_XLT_KEY_BUILDER_RSS);
 }
 
+#define ICE_XLT_KB_MASK		GENMASK_ULL(5, 0)
+
+/**
+ * ice_xlt_kb_flag_get - aggregate 64 bits packet flag into 16 bits xlt flag
+ * @kb: xlt key build
+ * @pkt_flag: 64 bits packet flag
+ *
+ * Return: XLT flag or 0 if @pkt_flag = 0.
+ */
+u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag)
+{
+	struct ice_xlt_kb_entry *entry = &kb->entries[0];
+	u16 flag = 0;
+	int i;
+
+	/* check flag 15 */
+	if (kb->flag15 & pkt_flag)
+		flag = BIT(ICE_XLT_KB_FLAG0_14_CNT);
+
+	/* check flag 0 - 14 */
+	for (i = 0; i < ICE_XLT_KB_FLAG0_14_CNT; i++) {
+		/* only check first entry */
+		u16 idx = entry->flg0_14_sel[i] & ICE_XLT_KB_MASK;
+
+		if (pkt_flag & BIT(idx))
+			flag |= (u16)BIT(i);
+	}
+
+	return flag;
+}
+
 /*** Parser API ***/
 /**
  * ice_parser_create - create a parser instance
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 6e8054d59644..1d2453890d8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -197,25 +197,29 @@ struct ice_metainit_item {
 
 struct ice_pg_cam_key {
 	bool valid;
-	u16 node_id;	/* Node ID of protocol in parse graph */
-	bool flag0;
-	bool flag1;
-	bool flag2;
-	bool flag3;
-	u8 boost_idx;	/* Boost TCAM match index */
-	u16 alu_reg;
-	u32 next_proto;	/* next Protocol value */
+	struct_group_attr(val, __packed,
+		u16 node_id;	/* Node ID of protocol in parse graph */
+		bool flag0;
+		bool flag1;
+		bool flag2;
+		bool flag3;
+		u8 boost_idx;	/* Boost TCAM match index */
+		u16 alu_reg;
+		u32 next_proto;	/* next Protocol value (must be last) */
+	);
 };
 
 struct ice_pg_nm_cam_key {
 	bool valid;
-	u16 node_id;
-	bool flag0;
-	bool flag1;
-	bool flag2;
-	bool flag3;
-	u8 boost_idx;
-	u16 alu_reg;
+	struct_group_attr(val, __packed,
+		u16 node_id;
+		bool flag0;
+		bool flag1;
+		bool flag2;
+		bool flag3;
+		u8 boost_idx;
+		u16 alu_reg;
+	);
 };
 
 struct ice_pg_cam_action {
@@ -244,6 +248,12 @@ struct ice_pg_nm_cam_item {
 	struct ice_pg_cam_action action;
 };
 
+struct ice_pg_cam_item *ice_pg_cam_match(struct ice_pg_cam_item *table,
+					 int size, struct ice_pg_cam_key *key);
+struct ice_pg_nm_cam_item *
+ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *table, int size,
+		    struct ice_pg_cam_key *key);
+
 /*** ICE_SID_RXPARSER_BOOST_TCAM and ICE_SID_LBL_RXPARSER_TMEM sections ***/
 #define ICE_BST_TCAM_TABLE_SIZE		256
 #define ICE_BST_TCAM_KEY_SIZE		20
@@ -269,6 +279,9 @@ struct ice_lbl_item {
 	char label[ICE_LBL_LEN];
 };
 
+struct ice_bst_tcam_item *
+ice_bst_tcam_match(struct ice_bst_tcam_item *tcam_table, u8 *pat);
+
 /*** ICE_SID_RXPARSER_MARKER_PTYPE section ***/
 #define ICE_PTYPE_MK_TCAM_TABLE_SIZE	1024
 #define ICE_PTYPE_MK_TCAM_KEY_SIZE	10
@@ -280,6 +293,9 @@ struct ice_ptype_mk_tcam_item {
 	u8 key_inv[ICE_PTYPE_MK_TCAM_KEY_SIZE];
 } __packed;
 
+struct ice_ptype_mk_tcam_item *
+ice_ptype_mk_tcam_match(struct ice_ptype_mk_tcam_item *table,
+			u8 *pat, int len);
 /*** ICE_SID_RXPARSER_MARKER_GRP section ***/
 #define ICE_MK_GRP_TABLE_SIZE		128
 #define ICE_MK_COUNT_PER_GRP		8
@@ -308,6 +324,7 @@ struct ice_proto_grp_item {
 
 /*** ICE_SID_RXPARSER_FLAG_REDIR section ***/
 #define ICE_FLG_RD_TABLE_SIZE	64
+#define ICE_FLG_RDT_SIZE	64
 
 /* Flags Redirection item */
 struct ice_flg_rd_item {
@@ -316,6 +333,8 @@ struct ice_flg_rd_item {
 	u8 intr_flg_id;	/* Internal Flag ID */
 };
 
+u64 ice_flg_redirect(struct ice_flg_rd_item *table, u64 psr_flg);
+
 /*** ICE_SID_XLT_KEY_BUILDER_SW, ICE_SID_XLT_KEY_BUILDER_ACL,
  * ICE_SID_XLT_KEY_BUILDER_FD and ICE_SID_XLT_KEY_BUILDER_RSS
  * sections ***/
@@ -341,6 +360,8 @@ struct ice_xlt_kb {
 	struct ice_xlt_kb_entry entries[ICE_XLT_KB_TBL_CNT];
 };
 
+u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag);
+
 /*** Parser API ***/
 struct ice_parser {
 	struct ice_hw *hw; /* pointer to the hardware structure */
-- 
2.42.0


