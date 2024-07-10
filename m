Return-Path: <netdev+bounces-110656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216192DA48
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C191F24438
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67370198825;
	Wed, 10 Jul 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJF2Fvd+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD351195F3A
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644066; cv=none; b=QbHNImEeMBMRHph0oltR6ghLbl/OVH6KaZ2yV5rGYlmj0aZWMULFxUApK9/BHivcoWCeNnbWhnNKwkM6KODnYgwsMslPm3askgvNzERTAY0nW9wzMBksHTephYOas1q3mhdfv2r8yXloB8VT/pGiU9UZmWPVnQRqu29cJylJA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644066; c=relaxed/simple;
	bh=JG9pc8yo7bPfRDVplidTqJ/G3llYJdwhujPLdoyDMN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eemhn+6aECQEQbNoBUdKvgGzgyC+e4jvBz7anjBZ2vp2bfaOqYj0NxyTJGvGrD4011mwBUvPIzas1reb3Hz8xnsBoEDmhLNLJHwkesnIzxNFv6N5dYS2VlaJh/MXC+Gcs0iizHQfiqj8yTDzbZ6Bmg5V7smHpTgjkkTxha3FOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJF2Fvd+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720644065; x=1752180065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG9pc8yo7bPfRDVplidTqJ/G3llYJdwhujPLdoyDMN0=;
  b=MJF2Fvd+c3hcReJhe7tvWqn6pb521mwvBpgLhlYrIXGXZ0XkV/10sV8J
   cAIXZJ2Ih/UmYvdvxX+5lY7nUkjNuMk2E/dVH3fCHP0ZYOsK/uKZBVuqL
   zBdlNtc2MuDJ0WlH30Kiz/CEwzlid6lDiFI1lhyZ7q1sFM88cnhMBIjbD
   6tpcKi96igm5+Lf4VjkB53tQNg5PF1cS/6t1b/uCeC4gCSkzgtDLepelU
   4/lTQJqlN9SYtbgEStfP7po2idCzfc1rAW+iR3JbXZqK8EGeOGEWC3hLb
   9nMhQLe8hrgTrHm8736+hLbyG+3LsKD7Hsz7Pp6ov6ovgdt0R4UIL49yO
   A==;
X-CSE-ConnectionGUID: 5+CFiimqTlWXStlFQ+JsEw==
X-CSE-MsgGUID: IoPJmCFGT/GTrOumHVUU1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29153332"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29153332"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:41:04 -0700
X-CSE-ConnectionGUID: d5uPFg7RRsC9afnumi7kWg==
X-CSE-MsgGUID: hQESloq2Ru2VmStd8IN4Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48301210"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.184])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:41:00 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v3 08/13] ice: add API for parser profile initialization
Date: Wed, 10 Jul 2024 14:40:10 -0600
Message-ID: <20240710204015.124233-9-ahmed.zaki@intel.com>
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

Add API ice_parser_profile_init() to init a parser profile based on
a parser result and a mask buffer. The ice_parser_profile struct is used
by the low level FXP engine to create HW profile/field vectors.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 127 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_parser.h |  26 ++++
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index ac722c44d467..1921016b562b 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -2256,9 +2256,9 @@ static int ice_tunnel_port_set(struct ice_parser *psr, enum ice_lbl_type type,
 		/* found a matched slot to delete */
 		} else if (!on &&
 			   (item->key_inv[ICE_BT_TUN_PORT_OFF_L] ==
-			    buf[ICE_UDP_PORT_OFF_L] ||
+				buf[ICE_UDP_PORT_OFF_L] ||
 			    item->key_inv[ICE_BT_TUN_PORT_OFF_H] ==
-			    buf[ICE_UDP_PORT_OFF_H])) {
+				buf[ICE_UDP_PORT_OFF_H])) {
 			item->key_inv[ICE_BT_TUN_PORT_OFF_L] = ICE_BT_VLD_KEY;
 			item->key_inv[ICE_BT_TUN_PORT_OFF_H] = ICE_BT_INV_KEY;
 
@@ -2315,3 +2315,126 @@ int ice_parser_ecpri_tunnel_set(struct ice_parser *psr,
 	return ice_tunnel_port_set(psr, ICE_LBL_BST_TYPE_UDP_ECPRI,
 				   udp_port, on);
 }
+
+/* ice_nearest_proto_id
+ * @rslt: pointer to a parser result instance
+ * @offset: a min value for the protocol offset
+ * @proto_id: the protocol ID (output)
+ * @proto_off: the protocol offset (output)
+ *
+ * From the protocols in @rslt, find the nearest protocol that has offset
+ * larger than @offset. Return the protocol's ID and offset.
+ */
+static bool ice_nearest_proto_id(struct ice_parser_result *rslt, u16 offset,
+				 u8 *proto_id, u16 *proto_off)
+{
+	u16 dist = U16_MAX;
+	u8 proto = 0;
+	int i;
+
+	for (i = 0; i < rslt->po_num; i++) {
+		if (offset < rslt->po[i].offset)
+			continue;
+		if (offset - rslt->po[i].offset < dist) {
+			proto = rslt->po[i].proto_id;
+			dist = offset - rslt->po[i].offset;
+		}
+	}
+
+	if (dist % 2)
+		return false;
+
+	*proto_id = proto;
+	*proto_off = dist;
+
+	return true;
+}
+
+/** default flag mask to cover GTP_EH_PDU, GTP_EH_PDU_LINK and TUN2
+ * In future, the flag masks should learn from DDP
+ */
+#define ICE_KEYBUILD_FLAG_MASK_DEFAULT_SW	0x4002
+#define ICE_KEYBUILD_FLAG_MASK_DEFAULT_ACL	0x0000
+#define ICE_KEYBUILD_FLAG_MASK_DEFAULT_FD	0x6080
+#define ICE_KEYBUILD_FLAG_MASK_DEFAULT_RSS	0x6010
+
+/**
+ * ice_parser_profile_init - initialize a FXP profile based on parser result
+ * @rslt: a instance of a parser result
+ * @pkt_buf: packet data buffer
+ * @msk_buf: packet mask buffer
+ * @buf_len: packet length
+ * @blk: FXP pipeline stage
+ * @prof: input/output parameter to save the profile
+ *
+ * Return: 0 on success or errno on failure.
+ */
+int ice_parser_profile_init(struct ice_parser_result *rslt,
+			    const u8 *pkt_buf, const u8 *msk_buf,
+			    int buf_len, enum ice_block blk,
+			    struct ice_parser_profile *prof)
+{
+	u8 proto_id = U8_MAX;
+	u16 proto_off = 0;
+	u16 off;
+
+	memset(prof, 0, sizeof(*prof));
+	set_bit(rslt->ptype, prof->ptypes);
+	if (blk == ICE_BLK_SW) {
+		prof->flags	= rslt->flags_sw;
+		prof->flags_msk	= ICE_KEYBUILD_FLAG_MASK_DEFAULT_SW;
+	} else if (blk == ICE_BLK_ACL) {
+		prof->flags	= rslt->flags_acl;
+		prof->flags_msk	= ICE_KEYBUILD_FLAG_MASK_DEFAULT_ACL;
+	} else if (blk == ICE_BLK_FD) {
+		prof->flags	= rslt->flags_fd;
+		prof->flags_msk	= ICE_KEYBUILD_FLAG_MASK_DEFAULT_FD;
+	} else if (blk == ICE_BLK_RSS) {
+		prof->flags	= rslt->flags_rss;
+		prof->flags_msk	= ICE_KEYBUILD_FLAG_MASK_DEFAULT_RSS;
+	} else {
+		return -EINVAL;
+	}
+
+	for (off = 0; off < buf_len - 1; off++) {
+		if (msk_buf[off] == 0 && msk_buf[off + 1] == 0)
+			continue;
+		if (!ice_nearest_proto_id(rslt, off, &proto_id, &proto_off))
+			continue;
+		if (prof->fv_num >= ICE_PARSER_FV_MAX)
+			return -EINVAL;
+
+		prof->fv[prof->fv_num].proto_id	= proto_id;
+		prof->fv[prof->fv_num].offset	= proto_off;
+		prof->fv[prof->fv_num].spec	= *(const u16 *)&pkt_buf[off];
+		prof->fv[prof->fv_num].msk	= *(const u16 *)&msk_buf[off];
+		prof->fv_num++;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_parser_profile_dump - dump an FXP profile info
+ * @hw: pointer to the hardware structure
+ * @prof: profile info to dump
+ */
+void ice_parser_profile_dump(struct ice_hw *hw,
+			     struct ice_parser_profile *prof)
+{
+	struct device *dev = ice_hw_to_dev(hw);
+	u16 i;
+
+	dev_info(dev, "ptypes:\n");
+	for (i = 0; i < ICE_FLOW_PTYPE_MAX; i++)
+		if (test_bit(i, prof->ptypes))
+			dev_info(dev, "\t%u\n", i);
+
+	for (i = 0; i < prof->fv_num; i++)
+		dev_info(dev, "proto = %u, offset = %2u, spec = 0x%04x, mask = 0x%04x\n",
+			 prof->fv[i].proto_id, prof->fv[i].offset,
+			 prof->fv[i].spec, prof->fv[i].msk);
+
+	dev_info(dev, "flags = 0x%04x\n", prof->flags);
+	dev_info(dev, "flags_msk = 0x%04x\n", prof->flags_msk);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 99acd09f026d..ed088bdf8413 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -451,6 +451,8 @@ struct ice_parser_proto_off {
 
 #define ICE_PARSER_PROTO_OFF_PAIR_SIZE	16
 #define ICE_PARSER_FLAG_PSR_SIZE	8
+#define ICE_PARSER_FV_SIZE		48
+#define ICE_PARSER_FV_MAX		24
 #define ICE_BT_TUN_PORT_OFF_H		16
 #define ICE_BT_TUN_PORT_OFF_L		15
 #define ICE_BT_VM_OFF			0
@@ -511,4 +513,28 @@ int ice_parser_ecpri_tunnel_set(struct ice_parser *psr, u16 udp_port, bool on);
 int ice_parser_run(struct ice_parser *psr, const u8 *pkt_buf,
 		   int pkt_len, struct ice_parser_result *rslt);
 void ice_parser_result_dump(struct ice_hw *hw, struct ice_parser_result *rslt);
+
+struct ice_parser_fv {
+	u8 proto_id;	/* hardware protocol ID */
+	u16 offset;	/* offset from the start of the protocol header */
+	u16 spec;	/* pattern to match */
+	u16 msk;	/* pattern mask */
+};
+
+struct ice_parser_profile {
+	/* array of field vectors */
+	struct ice_parser_fv fv[ICE_PARSER_FV_SIZE];
+	int fv_num;		/* # of field vectors must <= 48 */
+	u16 flags;		/* key builder flags */
+	u16 flags_msk;		/* key builder flag mask */
+
+	DECLARE_BITMAP(ptypes, ICE_FLOW_PTYPE_MAX); /* PTYPE bitmap */
+};
+
+int ice_parser_profile_init(struct ice_parser_result *rslt,
+			    const u8 *pkt_buf, const u8 *msk_buf,
+			    int buf_len, enum ice_block blk,
+			    struct ice_parser_profile *prof);
+void ice_parser_profile_dump(struct ice_hw *hw,
+			     struct ice_parser_profile *prof);
 #endif /* _ICE_PARSER_H_ */
-- 
2.43.0


