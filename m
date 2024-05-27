Return-Path: <netdev+bounces-98307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4878D0A4E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA071C215ED
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CA1607AA;
	Mon, 27 May 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QByS9oyz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3115FD07
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836335; cv=none; b=N5wrO/tIv7ppO/Wl7y98RiMds8ZPqYhL8KBHlT5MjToqArjgw2zGbyoM75XyuNnv57vWS/tle3Dd6oPJ86BSoWjS+t4Q3I0fitb3DChr/0rzKzWKPwQZI5PXVr/bfQcBAZaHec56jpuv3R3z7JbCgAY7Gmc+5EsDSIUys2/cyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836335; c=relaxed/simple;
	bh=XHGl9wJHHyeG1eytyoEHjAH3NtQhN62Lvo1g5bU5eWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLKpC1TIftV8rR7TSwrzG4eGQxH6o6/MS1K6DDFIFXOaKIZKJxW5mapA0HeAOxX03XsgI6JuyaAZHdp5qln1FYYITEEseVumxHFSXJZ4rgjeRTiySbMKaeRy15fIfddPQqVbE5Sv8Pdj74tDg+kwNd1oeMnScKZGXFVZkQWliTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QByS9oyz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716836333; x=1748372333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHGl9wJHHyeG1eytyoEHjAH3NtQhN62Lvo1g5bU5eWg=;
  b=QByS9oyzPaUv2VqNYo7ks3E1MFjwjHhLEqaA17rmed8Swsde3B+PGd/U
   w+cMourTV4PVR1drKYO9JF0IrxpgdL97tV7CbGNXACx9ugN708R7mz/fJ
   ui+hQ99k+UU+W49vTdFVsaBVIaXsLxqWylkIxm2NvTTkJP4g3z7zzzuZz
   zrDggm2MHaZkRoYjBOzwr6WwFItFvHidvqYFXL+e89ObGg1M/RpULeJqn
   kTu8lpTmvQsU4H/B2UOcHibJ0czInxLYMTGnK0MyqTrAJgc3k38PhsUno
   QT9JvjM0mSn6dHwc6KGxlB6+Tw0No4va6S7aCsVQTBnsn/2rw8p3rm7P3
   w==;
X-CSE-ConnectionGUID: l+GpqRRRQgWRP3Vy1vRfFg==
X-CSE-MsgGUID: ZjMwGmpUR2KVY+N+VKjYsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13353933"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13353933"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 11:58:53 -0700
X-CSE-ConnectionGUID: WAcEm3HwR3uVPe0zrt7/MQ==
X-CSE-MsgGUID: bA+HWQvvSaSVE9cvo+4b8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34910029"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.208])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 11:58:50 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v2 06/13] ice: support turning on/off the parser's double vlan mode
Date: Mon, 27 May 2024 12:58:03 -0600
Message-ID: <20240527185810.3077299-7-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527185810.3077299-1-ahmed.zaki@intel.com>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

Add API ice_parser_dvm_set() to support turning on/off the parser's double
vlan mode.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 77 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_parser.h | 18 +++++
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index eacf332df0a7..c490bff94355 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -601,6 +601,31 @@ static struct ice_metainit_item *ice_metainit_table_get(struct ice_hw *hw)
 					ice_metainit_parse_item, false);
 }
 
+/**
+ * ice_bst_tcam_search - find a TCAM item with specific type
+ * @tcam_table: the TCAM table
+ * @lbl_table: the lbl table to search
+ * @type: the type we need to match against
+ * @start: start searching from this index
+ *
+ */
+struct ice_bst_tcam_item *
+ice_bst_tcam_search(struct ice_bst_tcam_item *tcam_table,
+		    struct ice_lbl_item *lbl_table,
+		    enum ice_lbl_type type, u16 *start)
+{
+	u16 i = *start;
+
+	for (; i < ICE_BST_TCAM_TABLE_SIZE; i++) {
+		if (lbl_table[i].type == type) {
+			*start = i;
+			return &tcam_table[lbl_table[i].idx];
+		}
+	}
+
+	return NULL;
+}
+
 /*** ICE_SID_RXPARSER_CAM, ICE_SID_RXPARSER_PG_SPILL,
  *    ICE_SID_RXPARSER_NOMATCH_CAM and ICE_SID_RXPARSER_NOMATCH_CAM
  *    sections ***/
@@ -1147,6 +1172,7 @@ static void ice_lbl_dump(struct ice_hw *hw, struct ice_lbl_item *item)
 	struct device *dev = ice_hw_to_dev(hw);
 
 	dev_info(dev, "index = %u\n", item->idx);
+	dev_info(dev, "type = %u\n", item->type);
 	dev_info(dev, "label = %s\n", item->label);
 }
 
@@ -1335,12 +1361,21 @@ static struct ice_bst_tcam_item *ice_bst_tcam_table_get(struct ice_hw *hw)
 }
 
 static void ice_parse_lbl_item(struct ice_hw *hw, u16 idx, void *item,
-			       void *data, int size)
+			       void *data, int __maybe_unused size)
 {
-	memcpy(item, data, size);
+	struct ice_lbl_item *lbl_item = (struct ice_lbl_item *)item;
+	struct ice_lbl_item *lbl_data = (struct ice_lbl_item *)data;
+
+	lbl_item->idx = lbl_data->idx;
+	memcpy(lbl_item->label, lbl_data->label, sizeof(lbl_item->label));
+
+	if (strstarts(lbl_item->label, ICE_LBL_BST_DVM))
+		lbl_item->type = ICE_LBL_BST_TYPE_DVM;
+	else if (strstarts(lbl_item->label, ICE_LBL_BST_SVM))
+		lbl_item->type = ICE_LBL_BST_TYPE_SVM;
 
 	if (hw->debug_mask & ICE_DBG_PARSER)
-		ice_lbl_dump(hw, (struct ice_lbl_item *)item);
+		ice_lbl_dump(hw, lbl_item);
 }
 
 /**
@@ -2103,3 +2138,39 @@ void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt)
 	dev_info(dev, "flags_fd = 0x%04x\n", rslt->flags_fd);
 	dev_info(dev, "flags_rss = 0x%04x\n", rslt->flags_rss);
 }
+
+#define ICE_BT_VLD_KEY	0xFF
+#define ICE_BT_INV_KEY	0xFE
+
+static void ice_bst_dvm_set(struct ice_parser *psr, enum ice_lbl_type type,
+			    bool on)
+{
+	u16 i = 0;
+
+	while (true) {
+		struct ice_bst_tcam_item *item;
+		u8 key;
+
+		item = ice_bst_tcam_search(psr->bst_tcam_table,
+					   psr->bst_lbl_table,
+					   type, &i);
+		if (!item)
+			break;
+
+		key = (on ? ICE_BT_VLD_KEY : ICE_BT_INV_KEY);
+		item->key[ICE_BT_VM_OFF] = key;
+		item->key_inv[ICE_BT_VM_OFF] = key;
+		i++;
+	}
+}
+
+/**
+ * ice_parser_dvm_set - configure double vlan mode for parser
+ * @psr: pointer to a parser instance
+ * @on: true to turn on; false to turn off
+ */
+void ice_parser_dvm_set(struct ice_parser *psr, bool on)
+{
+	ice_bst_dvm_set(psr, ICE_LBL_BST_TYPE_DVM, on);
+	ice_bst_dvm_set(psr, ICE_LBL_BST_TYPE_SVM, !on);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 71172cd7fc7c..a891d3acf1f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -274,13 +274,29 @@ struct ice_bst_tcam_item {
 };
 
 #define ICE_LBL_LEN			64
+#define ICE_LBL_BST_DVM			"BOOST_MAC_VLAN_DVM"
+#define ICE_LBL_BST_SVM			"BOOST_MAC_VLAN_SVM"
+
+enum ice_lbl_type {
+	ICE_LBL_BST_TYPE_UNKNOWN,
+	ICE_LBL_BST_TYPE_DVM,
+	ICE_LBL_BST_TYPE_SVM,
+};
+
 struct ice_lbl_item {
 	u16 idx;
 	char label[ICE_LBL_LEN];
+
+	/* must be at the end, not part of the DDP section */
+	enum ice_lbl_type type;
 };
 
 struct ice_bst_tcam_item *
 ice_bst_tcam_match(struct ice_bst_tcam_item *tcam_table, u8 *pat);
+struct ice_bst_tcam_item *
+ice_bst_tcam_search(struct ice_bst_tcam_item *tcam_table,
+		    struct ice_lbl_item *lbl_table,
+		    enum ice_lbl_type type, u16 *start);
 
 /*** ICE_SID_RXPARSER_MARKER_PTYPE section ***/
 #define ICE_PTYPE_MK_TCAM_TABLE_SIZE	1024
@@ -429,6 +445,7 @@ struct ice_parser_proto_off {
 
 #define ICE_PARSER_PROTO_OFF_PAIR_SIZE	16
 #define ICE_PARSER_FLAG_PSR_SIZE	8
+#define ICE_BT_VM_OFF			0
 
 struct ice_parser_result {
 	u16 ptype;	/* 16 bits hardware PTYPE */
@@ -477,6 +494,7 @@ struct ice_parser {
 
 struct ice_parser *ice_parser_create(struct ice_hw *hw);
 void ice_parser_destroy(struct ice_parser *psr);
+void ice_parser_dvm_set(struct ice_parser *psr, bool on);
 int ice_parser_run(struct ice_parser *psr, const u8 *pkt_buf,
 		   int pkt_len, struct ice_parser_result *rslt);
 void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt);
-- 
2.43.0


