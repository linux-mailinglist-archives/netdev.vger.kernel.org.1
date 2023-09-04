Return-Path: <netdev+bounces-31872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F6C791011
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 04:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA8E28108C
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1A818;
	Mon,  4 Sep 2023 02:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1E3C31
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:16:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE49B
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 19:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693793762; x=1725329762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TrelpE8cu6lQnLypFm0G4KTqSDJFZgI/P0bx9U4Zxc=;
  b=ZHLynxmYK1vpVKZEqvr5cCBHh2mvnJ2W7zbbdvWJJ00a7ABtiR20coJr
   CSveUihG+TM592Kh9ydunVvPKZy+Eg+r4GpCgwZEI+fK3ru5P8ZW7BdM6
   w5Agx/8bCiOSL20TSM/S2PKUoMzJyYTuUKUM4CHKnPHxkVPlrl5l/p0Lu
   1vlZKIxFgwS2hxRkTIuZAT6Acnz5fnWrOQV6vkQWeH//5bDtjWb3LzyCC
   etx5KZBz99B7Wo4osYZBvz5bOoyxooWzvO83BTX+thU4LGuqdVGibSfuL
   TM1N1hZgd1crYylCWQ/W1aK8P8N92lPFeWsZlHwtamknvD0+H/DwyClMk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379215341"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379215341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769826949"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769826949"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2023 19:15:58 -0700
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
Subject: [PATCH iwl-next v9 13/15] ice: support double vlan mode configure for parser
Date: Mon,  4 Sep 2023 10:14:53 +0800
Message-Id: <20230904021455.3944605-14-junfeng.guo@intel.com>
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

Add API ice_parser_dvm_set to support turn on/off parser's
double vlan mode.

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_bst_tcam.c | 17 +++++++++
 drivers/net/ethernet/intel/ice/ice_bst_tcam.h |  4 +++
 drivers/net/ethernet/intel/ice/ice_parser.c   | 36 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   |  2 ++
 4 files changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_bst_tcam.c b/drivers/net/ethernet/intel/ice/ice_bst_tcam.c
index 99148f1cf4f1..8d7fda43b24c 100644
--- a/drivers/net/ethernet/intel/ice/ice_bst_tcam.c
+++ b/drivers/net/ethernet/intel/ice/ice_bst_tcam.c
@@ -334,3 +334,20 @@ ice_bst_tcam_match(struct ice_bst_tcam_item *tcam_table, u8 *pat)
 
 	return NULL;
 }
+
+struct ice_bst_tcam_item *
+ice_bst_tcam_search(struct ice_bst_tcam_item *tcam_table,
+		    struct ice_lbl_item *lbl_table,
+		    const char *prefix, u16 *start)
+{
+	u16 i = *start;
+
+	for (; i < ICE_BST_TCAM_TABLE_SIZE; i++) {
+		if (strstarts(lbl_table[i].label, prefix)) {
+			*start = i;
+			return &tcam_table[lbl_table[i].idx];
+		}
+	}
+
+	return NULL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_bst_tcam.h b/drivers/net/ethernet/intel/ice/ice_bst_tcam.h
index 73a46dc56b29..c3ced00b4920 100644
--- a/drivers/net/ethernet/intel/ice/ice_bst_tcam.h
+++ b/drivers/net/ethernet/intel/ice/ice_bst_tcam.h
@@ -33,4 +33,8 @@ struct ice_lbl_item *ice_bst_lbl_table_get(struct ice_hw *hw);
 
 struct ice_bst_tcam_item *
 ice_bst_tcam_match(struct ice_bst_tcam_item *tcam_table, u8 *pat);
+struct ice_bst_tcam_item *
+ice_bst_tcam_search(struct ice_bst_tcam_item *tcam_table,
+		    struct ice_lbl_item *lbl_table,
+		    const char *prefix, u16 *start);
 #endif /*_ICE_BST_TCAM_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 1bd1417e32c6..5ce98cd303e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -325,3 +325,39 @@ void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt)
 	dev_info(ice_hw_to_dev(hw), "flags_fd = 0x%04x\n", rslt->flags_fd);
 	dev_info(ice_hw_to_dev(hw), "flags_rss = 0x%04x\n", rslt->flags_rss);
 }
+
+#define ICE_BT_VLD_KEY	0xFF
+#define ICE_BT_INV_KEY	0xFE
+
+static void _ice_bst_vm_set(struct ice_parser *psr, const char *prefix,
+			    bool on)
+{
+	u16 i = 0;
+
+	while (true) {
+		struct ice_bst_tcam_item *item;
+
+		item = ice_bst_tcam_search(psr->bst_tcam_table,
+					   psr->bst_lbl_table,
+					   prefix, &i);
+		if (!item)
+			break;
+
+		item->key[ICE_BT_VM_OFF] =
+			(u8)(on ? ICE_BT_VLD_KEY : ICE_BT_INV_KEY);
+		item->key_inv[ICE_BT_VM_OFF] =
+			(u8)(on ? ICE_BT_VLD_KEY : ICE_BT_INV_KEY);
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
+	_ice_bst_vm_set(psr, "BOOST_MAC_VLAN_DVM", on);
+	_ice_bst_vm_set(psr, "BOOST_MAC_VLAN_SVM", !on);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index bfcef4f597bf..c9eee988ebb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -33,6 +33,7 @@
 #define ICE_SID_LBL_ENTRY_SIZE				66
 
 #define ICE_PARSER_PROTO_OFF_PAIR_SIZE			16
+#define ICE_BT_VM_OFF					0
 
 struct ice_parser {
 	struct ice_hw *hw; /* pointer to the hardware structure */
@@ -74,6 +75,7 @@ struct ice_parser {
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
 void ice_parser_destroy(struct ice_parser *psr);
+void ice_parser_dvm_set(struct ice_parser *psr, bool on);
 
 struct ice_parser_proto_off {
 	u8 proto_id;	/* hardware protocol ID */
-- 
2.25.1


