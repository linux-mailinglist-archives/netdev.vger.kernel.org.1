Return-Path: <netdev+bounces-117262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02294D586
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBAB1C21562
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F8714A0AE;
	Fri,  9 Aug 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0TuQu8B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DF1442E8
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225000; cv=none; b=O2hpli8GMjjS0s06sQkTnFr2be9UZPtwQLldW4ZxZwicP5VbGonshNj0Gt7fcJYZ2FUVhnc7al+tdEADM4Q0OWTyRIuz0/Gpy+AvqWB2Ews/Rg3GBYp+lEmpHgycf3Gql8MlXZF8EMLHsp2IuVR8u/i6G+b9HU/qyEji1Rka5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225000; c=relaxed/simple;
	bh=dyt+1gbCLpb7f6PE/DSbxhmkVo+EG2dGI9Y907+XO0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acYAxE0j4Wn5MuPLMjDud3JLRrWRiIvV805/ZzAD2HM5BqMpWTiAjmjv7qPIsksSs+QA9VOSXvpTIvw+gihZ7K1Y+awejOIXXUbTrP0GB8XbZyPIDIWWxCAs2nC2CFr83Y3uBl0WVocq1CNawYhfnvIHOxklQk9OWsD4LEembOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0TuQu8B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723224998; x=1754760998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyt+1gbCLpb7f6PE/DSbxhmkVo+EG2dGI9Y907+XO0Q=;
  b=Y0TuQu8Blqi0qoGGG+ZepydfQK8a9Dx4kNbIPVB6JItGR6Mxbzruy6EW
   wfNkw1LnHYL+ZjFHqFMcJdxvx2n0slOm1ner5gHOSUbbYliCGFT2cIh0T
   2mdzkMBg83kqK38qC0A/P6cwSU565iswAMTji82RXbP6b6jeCW5+kVFRr
   otu5X73r6g5A+0AVQwM2eF2S/b8GZVu/V11+2dSzCzkKwK9/91mjmjbt8
   STIYT62p4TIVRyhHsDWAXn8tEro/g3bWkApLiMTrVugHyS5wppiG+m2vX
   +CyxMUwlWijyf9BeoBcJGA85DEe8ydDgGseK6UetcPe6Xyh3AGNq+uezA
   A==;
X-CSE-ConnectionGUID: zy7lhVyZROuXhaN18VZ6qA==
X-CSE-MsgGUID: KZgXAJU4SsW/1y399Glncw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21551298"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21551298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:36:31 -0700
X-CSE-ConnectionGUID: Pc4DRgvgScODL2Id3Hsr0w==
X-CSE-MsgGUID: RftU+eIeQ1WZhGaQ/vX0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57589182"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 10:36:30 -0700
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
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 07/13] ice: add UDP tunnels support to the parser
Date: Fri,  9 Aug 2024 10:36:06 -0700
Message-ID: <20240809173615.2031516-8-anthony.l.nguyen@intel.com>
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 98 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h | 13 +++
 2 files changed, 111 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index f032b907ccd2..ee89208bf21d 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -1379,6 +1379,12 @@ static void ice_parse_lbl_item(struct ice_hw *hw, u16 idx, void *item,
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
@@ -2204,3 +2210,95 @@ void ice_parser_dvm_set(struct ice_parser *psr, bool on)
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
2.42.0


