Return-Path: <netdev+bounces-112869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4F93B8AD
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57113B24DFB
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6ED13B5B6;
	Wed, 24 Jul 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a10syM3W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C113AA3B
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857054; cv=none; b=RchB0+gKApaLxvMut3+4vxYPiKHLvc9/aTERqUS3itzGS9a2LyQi/sETjbE+si/tI6F/Q2NzS/ta8UPiE3ZAUnJWDKDzFwec1vBXoNp/obTXo8OBXosSWqbAZK7uGeoM9MJdiUwMkClJt59JVuVsmFnHqSc2OXuRm0JxxB8+6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857054; c=relaxed/simple;
	bh=IPt9gcrzWKY0XM6x44Jty6/5UUxceuAzKis+WKGVnXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxZ4+ZVCIjbYzbDQrgEkAblKDaDpxW6yWN9E/RfZKBy4hqvFREnem30TjJ+QIXrhOtnIMNqlUg9AIPBSTVqG7jpi8yLEo75PUYJEv2t1EBSZHLGPBBaHmwz9wf0VnKK9TRrMXyw7j1v5SlVeGmyDmS/XY1IYN3m3YMESOIoi8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a10syM3W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857053; x=1753393053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPt9gcrzWKY0XM6x44Jty6/5UUxceuAzKis+WKGVnXQ=;
  b=a10syM3WkpsUB7osQAYlzJYbDHvSQMEhfPVcOgKs+i4Zg8rInujjgEZr
   sY4va3Cg32r5hPB1zlXeTf2A0SGuC+qACwmMS5I8lS0PreeOjk70WEQ0q
   4Pgem/bk5uzv64225mEKsZ//22qmVMs7Ud5mRJacqFaCI5SXn60dPlCHz
   nEiBT8N07tLzilVp6pu4oj6Z/mGKe/06thDU8iVHVNtqY48DhJs0BnbzR
   QN3U1Ocw3LBs/jCa3h8zW3Jj80FgpyHafMlihKIof41ga3tiRrakn/4Vf
   FoXhprgDOreLKYjw9NZw3Cp5Xw+XGDdNhOD77RoXiwrBg5PzRsN4DZ91g
   A==;
X-CSE-ConnectionGUID: gH33QHExQMqBOHYWKk0WJw==
X-CSE-MsgGUID: 3sm3evQAR+W1kIKhx5PG0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19704209"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19704209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:37:33 -0700
X-CSE-ConnectionGUID: rhILtSgnQuGERR1JpdOjPQ==
X-CSE-MsgGUID: KoQGfzuhRgGXKHBhcCd4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52579575"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.206])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:37:26 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH iwl-next v4 07/13] ice: add UDP tunnels support to the parser
Date: Wed, 24 Jul 2024 15:36:16 -0600
Message-ID: <20240724213623.324532-8-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724213623.324532-1-ahmed.zaki@intel.com>
References: <20240724213623.324532-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

Add support for the vxlan, geneve, ecpri UDP tunnels through the
following APIs:
- ice_parser_vxlan_tunnel_set()
- ice_parser_geneve_tunnel_set()
- ice_parser_ecpri_tunnel_set()

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 98 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h | 13 +++
 2 files changed, 111 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 650a94292cd0..5c780e2a427b 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -1380,6 +1380,12 @@ static void ice_parse_lbl_item(struct ice_hw *hw, u16 idx, void *item,
 		lbl_item->type = ICE_LBL_BST_TYPE_DVM;
 	else if (strstarts(lbl_item->label, ICE_LBL_BST_SVM))
 		lbl_item->type = ICE_LBL_BST_TYPE_SVM;
+	else if (strstarts(lbl_item->label, ICE_LBL_TNL_VXLAN))
+		lbl_item->type = ICE_LBL_BST_TYPE_VXLAN;
+	else if (strstarts(lbl_item->label, ICE_LBL_TNL_GENEVE))
+		lbl_item->type = ICE_LBL_BST_TYPE_GENEVE;
+	else if (strstarts(lbl_item->label, ICE_LBL_TNL_UDP_ECPRI))
+		lbl_item->type = ICE_LBL_BST_TYPE_UDP_ECPRI;
 
 	if (hw->debug_mask & ICE_DBG_PARSER)
 		ice_lbl_dump(hw, lbl_item);
@@ -2205,3 +2211,95 @@ void ice_parser_dvm_set(struct ice_parser *psr, bool on)
 	ice_bst_dvm_set(psr, ICE_LBL_BST_TYPE_DVM, on);
 	ice_bst_dvm_set(psr, ICE_LBL_BST_TYPE_SVM, !on);
 }
+
+static int ice_tunnel_port_set(struct ice_parser *psr, enum ice_lbl_type type,
+			       u16 udp_port, bool on)
+{
+	u8 *buf = (u8 *)&udp_port;
+	u16 i = 0;
+
+	while (true) {
+		struct ice_bst_tcam_item *item;
+
+		item = ice_bst_tcam_search(psr->bst_tcam_table,
+					   psr->bst_lbl_table,
+					   type, &i);
+		if (!item)
+			break;
+
+		/* found empty slot to add */
+		if (on && item->key[ICE_BT_TUN_PORT_OFF_H] == ICE_BT_INV_KEY &&
+		    item->key_inv[ICE_BT_TUN_PORT_OFF_H] == ICE_BT_INV_KEY) {
+			item->key_inv[ICE_BT_TUN_PORT_OFF_L] =
+						buf[ICE_UDP_PORT_OFF_L];
+			item->key_inv[ICE_BT_TUN_PORT_OFF_H] =
+						buf[ICE_UDP_PORT_OFF_H];
+
+			item->key[ICE_BT_TUN_PORT_OFF_L] =
+				ICE_BT_VLD_KEY - buf[ICE_UDP_PORT_OFF_L];
+			item->key[ICE_BT_TUN_PORT_OFF_H] =
+				ICE_BT_VLD_KEY - buf[ICE_UDP_PORT_OFF_H];
+
+			return 0;
+		/* found a matched slot to delete */
+		} else if (!on &&
+			   (item->key_inv[ICE_BT_TUN_PORT_OFF_L] ==
+			    buf[ICE_UDP_PORT_OFF_L] ||
+			    item->key_inv[ICE_BT_TUN_PORT_OFF_H] ==
+			    buf[ICE_UDP_PORT_OFF_H])) {
+			item->key_inv[ICE_BT_TUN_PORT_OFF_L] = ICE_BT_VLD_KEY;
+			item->key_inv[ICE_BT_TUN_PORT_OFF_H] = ICE_BT_INV_KEY;
+
+			item->key[ICE_BT_TUN_PORT_OFF_L] = ICE_BT_VLD_KEY;
+			item->key[ICE_BT_TUN_PORT_OFF_H] = ICE_BT_INV_KEY;
+
+			return 0;
+		}
+		i++;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * ice_parser_vxlan_tunnel_set - configure vxlan tunnel for parser
+ * @psr: pointer to a parser instance
+ * @udp_port: vxlan tunnel port in UDP header
+ * @on: true to turn on; false to turn off
+ *
+ * Return: 0 on success or errno on failure.
+ */
+int ice_parser_vxlan_tunnel_set(struct ice_parser *psr,
+				u16 udp_port, bool on)
+{
+	return ice_tunnel_port_set(psr, ICE_LBL_BST_TYPE_VXLAN, udp_port, on);
+}
+
+/**
+ * ice_parser_geneve_tunnel_set - configure geneve tunnel for parser
+ * @psr: pointer to a parser instance
+ * @udp_port: geneve tunnel port in UDP header
+ * @on: true to turn on; false to turn off
+ *
+ * Return: 0 on success or errno on failure.
+ */
+int ice_parser_geneve_tunnel_set(struct ice_parser *psr,
+				 u16 udp_port, bool on)
+{
+	return ice_tunnel_port_set(psr, ICE_LBL_BST_TYPE_GENEVE, udp_port, on);
+}
+
+/**
+ * ice_parser_ecpri_tunnel_set - configure ecpri tunnel for parser
+ * @psr: pointer to a parser instance
+ * @udp_port: ecpri tunnel port in UDP header
+ * @on: true to turn on; false to turn off
+ *
+ * Return: 0 on success or errno on failure.
+ */
+int ice_parser_ecpri_tunnel_set(struct ice_parser *psr,
+				u16 udp_port, bool on)
+{
+	return ice_tunnel_port_set(psr, ICE_LBL_BST_TYPE_UDP_ECPRI,
+				   udp_port, on);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 92319c60b388..f9500ddf1567 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -276,11 +276,17 @@ struct ice_bst_tcam_item {
 #define ICE_LBL_LEN			64
 #define ICE_LBL_BST_DVM			"BOOST_MAC_VLAN_DVM"
 #define ICE_LBL_BST_SVM			"BOOST_MAC_VLAN_SVM"
+#define ICE_LBL_TNL_VXLAN		"TNL_VXLAN"
+#define ICE_LBL_TNL_GENEVE		"TNL_GENEVE"
+#define ICE_LBL_TNL_UDP_ECPRI		"TNL_UDP_ECPRI"
 
 enum ice_lbl_type {
 	ICE_LBL_BST_TYPE_UNKNOWN,
 	ICE_LBL_BST_TYPE_DVM,
 	ICE_LBL_BST_TYPE_SVM,
+	ICE_LBL_BST_TYPE_VXLAN,
+	ICE_LBL_BST_TYPE_GENEVE,
+	ICE_LBL_BST_TYPE_UDP_ECPRI,
 };
 
 struct ice_lbl_item {
@@ -445,7 +451,11 @@ struct ice_parser_proto_off {
 
 #define ICE_PARSER_PROTO_OFF_PAIR_SIZE	16
 #define ICE_PARSER_FLAG_PSR_SIZE	8
+#define ICE_BT_TUN_PORT_OFF_H		16
+#define ICE_BT_TUN_PORT_OFF_L		15
 #define ICE_BT_VM_OFF			0
+#define ICE_UDP_PORT_OFF_H		1
+#define ICE_UDP_PORT_OFF_L		0
 
 struct ice_parser_result {
 	u16 ptype;	/* 16 bits hardware PTYPE */
@@ -495,6 +505,9 @@ struct ice_parser {
 struct ice_parser *ice_parser_create(struct ice_hw *hw);
 void ice_parser_destroy(struct ice_parser *psr);
 void ice_parser_dvm_set(struct ice_parser *psr, bool on);
+int ice_parser_vxlan_tunnel_set(struct ice_parser *psr, u16 udp_port, bool on);
+int ice_parser_geneve_tunnel_set(struct ice_parser *psr, u16 udp_port, bool on);
+int ice_parser_ecpri_tunnel_set(struct ice_parser *psr, u16 udp_port, bool on);
 int ice_parser_run(struct ice_parser *psr, const u8 *pkt_buf,
 		   int pkt_len, struct ice_parser_result *rslt);
 void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt);
-- 
2.43.0


