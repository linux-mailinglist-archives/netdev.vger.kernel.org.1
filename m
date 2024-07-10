Return-Path: <netdev+bounces-110654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3ED92DA43
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C50285257
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F28198A2A;
	Wed, 10 Jul 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3TM2HBB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FD197A65
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644058; cv=none; b=jVMGymV1R9Txy8NuaXkAO0gY4aF0/DWnM6nhzGIV3oByQCQs1eXmyZE3qUDXG8u2Mob0ZRa862QOlaE+hPlZFFmZMtrabuxYUtKqsnpGdw9/pc3KxL6STCnLmRYvKY9++8j/OzwSY4zGz9tC3gyqbclsuRBPBkncX/lTZSbFdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644058; c=relaxed/simple;
	bh=CeGyTQu9yUsLObxSYwDGR+7q+LVDoKrBLUxdKyFD0rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLnjmpHPtLT2Neu6zatNfwrMmelcm97F2GXiXgpvK853RSJVsEtqsR8VxzPUtDDJe8e9pFVXvBK1Kovh0tpFRQkW+/eCswEQ7Mtee02hFOGKUHh871hTrpk5jt6fv9D0VNPkH39/hudEgcyAmo6u0tx6xff8WiBQiT17TCo9KSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3TM2HBB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720644057; x=1752180057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CeGyTQu9yUsLObxSYwDGR+7q+LVDoKrBLUxdKyFD0rQ=;
  b=N3TM2HBBsqp92L9X2tv37keCkrC1h+K6xNaqTe2nDoNpXeTkdcGL5Gye
   NSXwlaLL007WBikhvF+bDpO3BZ6r/h28IG5aTsPr7R4SNwd44omqmOzPQ
   I0a4e0kgS4NGLXKfnBNy1TUktA2fdHstVJFQ4bIDv3vU/xxtUXdIAKwQx
   3JJqYe5ODsF/Mev2qtQkjXwKO0fkAHzeW8yQgwTkmdriXGzNs7KxkzQBC
   8TOpwBlV06Jv+qhm0lu4PLVUImsDrYQ9R7HB9m8A/u2tkF4ekIBSef/n3
   mimPszNn5sYpQdpAB1dKkxmNOyASNfhgs/USWW89hZs2a9INH4c93iS0y
   A==;
X-CSE-ConnectionGUID: cUfiKbJsRqWKv33SlandZQ==
X-CSE-MsgGUID: UV5z3kx1TC+5YDenVnlpdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29153300"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29153300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:40:56 -0700
X-CSE-ConnectionGUID: n0Y9KIj0Ql2bWoXxLtYv3A==
X-CSE-MsgGUID: LoWtP4A5SouGmxnR7MWXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48301180"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.184])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:40:52 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v3 06/13] ice: support turning on/off the parser's double vlan mode
Date: Wed, 10 Jul 2024 14:40:08 -0600
Message-ID: <20240710204015.124233-7-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710204015.124233-1-ahmed.zaki@intel.com>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_parser.c | 78 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_parser.h | 18 +++++
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index a077b3a33db7..e2f9d842b737 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -600,6 +600,32 @@ static struct ice_metainit_item *ice_metainit_table_get(struct ice_hw *hw)
 					ice_metainit_parse_item, false);
 }
 
+/**
+ * ice_bst_tcam_search - find a TCAM item with specific type
+ * @tcam_table: the TCAM table
+ * @lbl_table: the lbl table to search
+ * @type: the type we need to match against
+ * @start: start searching from this index
+ *
+ * Return: a pointer to the matching BOOST TCAM item or NULL.
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
@@ -1158,6 +1184,7 @@ static void ice_lbl_dump(struct ice_hw *hw, struct ice_lbl_item *item)
 	struct device *dev = ice_hw_to_dev(hw);
 
 	dev_info(dev, "index = %u\n", item->idx);
+	dev_info(dev, "type = %u\n", item->type);
 	dev_info(dev, "label = %s\n", item->label);
 }
 
@@ -1348,12 +1375,21 @@ static struct ice_bst_tcam_item *ice_bst_tcam_table_get(struct ice_hw *hw)
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
@@ -2145,3 +2181,39 @@ void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt)
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
index f3f2cb4043ea..77ddcdff0295 100644
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


