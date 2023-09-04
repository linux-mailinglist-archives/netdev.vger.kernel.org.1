Return-Path: <netdev+bounces-31868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CA79100D
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 04:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9148D1C2029F
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FA7FD;
	Mon,  4 Sep 2023 02:15:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1D7FB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:15:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C5EC5
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693793745; x=1725329745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V56aoUsDhYZoNlAORzKmdymW7lVjIwDC6aNR7co2fPs=;
  b=kr1fJxotwhw10I1YS1e7dhFlzcK1zdIpIlno4Wc4ByFhuDPRkvB1F3Mj
   AhCvmsPENfERu4aQkm7umxF2AKaKFt7qYIPk/oYl34DbLRwU1hAUZhnfe
   pYEJPGVd0TS2hl/q8HSux/l/nl1dsw8oxIpMXiOhp69UIXq6BWE6/c6Ka
   AsenqVtQQ1/HjTgk2IKCDVW7HRvwsXjxownJ89AaDF2a7X5EQ8KtHmUcF
   ZdE/RMQ6C4k5W+oETXGHInUGKR/uG44pEi6R03BwQsglyUqjcvO4ppP1W
   MkB69BtpMwU6y3Kzyq1fRxj7+qAxlo+Nz0KRxyrULEvzA6WojznTNisAK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379215295"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379215295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769826919"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769826919"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2023 19:15:40 -0700
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
Subject: [PATCH iwl-next v9 09/15] ice: init XLT key builder for parser
Date: Mon,  4 Sep 2023 10:14:49 +0800
Message-Id: <20230904021455.3944605-10-junfeng.guo@intel.com>
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

Parse below DDP section into struct ice_xlt_kb:
	ICE_SID_XLT_KEY_BUILDER_SW
	ICE_SID_XLT_KEY_BUILDER_ACL
	ICE_SID_XLT_KEY_BUILDER_FD
	ICE_SID_XLT_KEY_BUILDER_RSS

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile     |   1 +
 drivers/net/ethernet/intel/ice/ice_parser.c |  28 +++
 drivers/net/ethernet/intel/ice/ice_parser.h |   9 +
 drivers/net/ethernet/intel/ice/ice_xlt_kb.c | 230 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_xlt_kb.h |  33 +++
 5 files changed, 301 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_xlt_kb.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_xlt_kb.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 73245f7b0750..607730663766 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -35,6 +35,7 @@ ice-y := ice_main.o	\
 	 ice_mk_grp.o    \
 	 ice_proto_grp.o \
 	 ice_flg_rd.o    \
+	 ice_xlt_kb.o    \
 	 ice_idc.o	\
 	 ice_devlink.o	\
 	 ice_ddp.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 3c3f7d6bea52..6499bb774667 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -229,6 +229,30 @@ int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
 		goto err;
 	}
 
+	p->xlt_kb_sw = ice_xlt_kb_get_sw(hw);
+	if (!p->xlt_kb_sw) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->xlt_kb_acl = ice_xlt_kb_get_acl(hw);
+	if (!p->xlt_kb_acl) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->xlt_kb_fd = ice_xlt_kb_get_fd(hw);
+	if (!p->xlt_kb_fd) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	p->xlt_kb_rss = ice_xlt_kb_get_rss(hw);
+	if (!p->xlt_kb_rss) {
+		status = -EINVAL;
+		goto err;
+	}
+
 	*psr = p;
 	return 0;
 err:
@@ -254,6 +278,10 @@ void ice_parser_destroy(struct ice_parser *psr)
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->mk_grp_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->proto_grp_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->flg_rd_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->xlt_kb_sw);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->xlt_kb_acl);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->xlt_kb_fd);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->xlt_kb_rss);
 
 	devm_kfree(ice_hw_to_dev(psr->hw), psr);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 62123788e0a2..ca71ef4f50f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -12,6 +12,7 @@
 #include "ice_mk_grp.h"
 #include "ice_proto_grp.h"
 #include "ice_flg_rd.h"
+#include "ice_xlt_kb.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
@@ -56,6 +57,14 @@ struct ice_parser {
 	struct ice_proto_grp_item *proto_grp_table;
 	/* load data from section ICE_SID_RXPARSER_FLAG_REDIR */
 	struct ice_flg_rd_item *flg_rd_table;
+	/* load data from section ICE_SID_XLT_KEY_BUILDER_SW */
+	struct ice_xlt_kb *xlt_kb_sw;
+	/* load data from section ICE_SID_XLT_KEY_BUILDER_ACL */
+	struct ice_xlt_kb *xlt_kb_acl;
+	/* load data from section ICE_SID_XLT_KEY_BUILDER_FD */
+	struct ice_xlt_kb *xlt_kb_fd;
+	/* load data from section ICE_SID_XLT_KEY_BUILDER_RSS */
+	struct ice_xlt_kb *xlt_kb_rss;
 };
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
diff --git a/drivers/net/ethernet/intel/ice/ice_xlt_kb.c b/drivers/net/ethernet/intel/ice/ice_xlt_kb.c
new file mode 100644
index 000000000000..776f5db686f8
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_xlt_kb.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+
+static void _ice_xlt_kb_entry_dump(struct ice_hw *hw,
+				   struct ice_xlt_kb_entry *entry, int idx)
+{
+	int i;
+
+	dev_info(ice_hw_to_dev(hw), "key builder entry %d\n", idx);
+	dev_info(ice_hw_to_dev(hw), "\txlt1_ad_sel = %d\n",
+		 entry->xlt1_ad_sel);
+	dev_info(ice_hw_to_dev(hw), "\txlt2_ad_sel = %d\n",
+		 entry->xlt2_ad_sel);
+
+	for (i = 0; i < ICE_XLT_KB_FLAG0_14_CNT; i++)
+		dev_info(ice_hw_to_dev(hw), "\tflg%d_sel = %d\n", i,
+			 entry->flg0_14_sel[i]);
+
+	dev_info(ice_hw_to_dev(hw), "\txlt1_md_sel = %d\n",
+		 entry->xlt1_md_sel);
+	dev_info(ice_hw_to_dev(hw), "\txlt2_md_sel = %d\n",
+		 entry->xlt2_md_sel);
+}
+
+/**
+ * ice_xlt_kb_dump - dump a xlt key build info
+ * @hw: pointer to the hardware structure
+ * @kb: key build to dump
+ */
+void ice_xlt_kb_dump(struct ice_hw *hw, struct ice_xlt_kb *kb)
+{
+	int i;
+
+	dev_info(ice_hw_to_dev(hw), "xlt1_pm = %d\n", kb->xlt1_pm);
+	dev_info(ice_hw_to_dev(hw), "xlt2_pm = %d\n", kb->xlt2_pm);
+	dev_info(ice_hw_to_dev(hw), "prof_id_pm = %d\n", kb->prof_id_pm);
+	dev_info(ice_hw_to_dev(hw), "flag15 lo = 0x%08x\n", (u32)kb->flag15);
+	dev_info(ice_hw_to_dev(hw), "flag15 hi = 0x%08x\n",
+		 (u32)(kb->flag15 >> (sizeof(u32) * BITS_PER_BYTE)));
+
+	for (i = 0; i < ICE_XLT_KB_TBL_CNT; i++)
+		_ice_xlt_kb_entry_dump(hw, &kb->entries[i], i);
+}
+
+#define ICE_XLT_KB_X1AS_S	32	/* offset for the 1st 64-bits field */
+#define ICE_XLT_KB_X1AS		GENMASK_ULL(34 - ICE_XLT_KB_X1AS_S, 32 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_X2AS		GENMASK_ULL(37 - ICE_XLT_KB_X1AS_S, 35 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL00		GENMASK_ULL(46 - ICE_XLT_KB_X1AS_S, 38 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL01		GENMASK_ULL(55 - ICE_XLT_KB_X1AS_S, 47 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL02		GENMASK_ULL(64 - ICE_XLT_KB_X1AS_S, 56 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL03		GENMASK_ULL(73 - ICE_XLT_KB_X1AS_S, 65 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL04		GENMASK_ULL(82 - ICE_XLT_KB_X1AS_S, 74 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL05		GENMASK_ULL(91 - ICE_XLT_KB_X1AS_S, 83 - ICE_XLT_KB_X1AS_S)
+#define ICE_XLT_KB_FL06_S	92	/* offset for the 2nd 64-bits field */
+#define ICE_XLT_KB_FL06		GENMASK_ULL(100 - ICE_XLT_KB_FL06_S, 92 - ICE_XLT_KB_FL06_S)
+#define ICE_XLT_KB_FL07		GENMASK_ULL(109 - ICE_XLT_KB_FL06_S, 101 - ICE_XLT_KB_FL06_S)
+#define ICE_XLT_KB_FL08		GENMASK_ULL(118 - ICE_XLT_KB_FL06_S, 110 - ICE_XLT_KB_FL06_S)
+#define ICE_XLT_KB_FL09		GENMASK_ULL(127 - ICE_XLT_KB_FL06_S, 119 - ICE_XLT_KB_FL06_S)
+#define ICE_XLT_KB_FL10		GENMASK_ULL(136 - ICE_XLT_KB_FL06_S, 128 - ICE_XLT_KB_FL06_S)
+#define ICE_XLT_KB_FL11		GENMASK_ULL(145 - ICE_XLT_KB_FL06_S, 137 - ICE_XLT_KB_FL06_S)
+#define ICE_XLT_KB_FL12_S	146	/* offset for the 3rd 64-bits field */
+#define ICE_XLT_KB_FL12		GENMASK_ULL(154 - ICE_XLT_KB_FL12_S, 146 - ICE_XLT_KB_FL12_S)
+#define ICE_XLT_KB_FL13		GENMASK_ULL(163 - ICE_XLT_KB_FL12_S, 155 - ICE_XLT_KB_FL12_S)
+#define ICE_XLT_KB_FL14		GENMASK_ULL(181 - ICE_XLT_KB_FL12_S, 164 - ICE_XLT_KB_FL12_S)
+#define ICE_XLT_KB_X1MS		GENMASK_ULL(186 - ICE_XLT_KB_FL12_S, 182 - ICE_XLT_KB_FL12_S)
+#define ICE_XLT_KB_X2MS		GENMASK_ULL(191 - ICE_XLT_KB_FL12_S, 187 - ICE_XLT_KB_FL12_S)
+
+/** The function parses a 192 bits XLT Key Builder entry with below format:
+ *  BIT 0-31:	reserved
+ *  BIT 32-34:	XLT1 AdSel	(entry->xlt1_ad_sel)
+ *  BIT 35-37:	XLT2 AdSel	(entry->xlt2_ad_sel)
+ *  BIT 38-46:	Flag 0 Select	(entry->flg0_14_sel[0])
+ *  BIT 47-55:	Flag 1 Select	(entry->flg0_14_sel[1])
+ *  BIT 56-64:	Flag 2 Select	(entry->flg0_14_sel[2])
+ *  BIT 65-73:	Flag 3 Select	(entry->flg0_14_sel[3])
+ *  BIT 74-82:	Flag 4 Select	(entry->flg0_14_sel[4])
+ *  BIT 83-91:	Flag 5 Select	(entry->flg0_14_sel[5])
+ *  BIT 92-100:	Flag 6 Select	(entry->flg0_14_sel[6])
+ *  BIT 101-109:Flag 7 Select	(entry->flg0_14_sel[7])
+ *  BIT 110-118:Flag 8 Select	(entry->flg0_14_sel[8])
+ *  BIT 119-127:Flag 9 Select	(entry->flg0_14_sel[9])
+ *  BIT 128-136:Flag 10 Select	(entry->flg0_14_sel[10])
+ *  BIT 137-145:Flag 11 Select	(entry->flg0_14_sel[11])
+ *  BIT 146-154:Flag 12 Select	(entry->flg0_14_sel[12])
+ *  BIT 155-163:Flag 13 Select	(entry->flg0_14_sel[13])
+ *  BIT 164-172:Flag 14 Select	(entry->flg0_14_sel[14])
+ *  BIT 173-181:reserved
+ *  BIT 182-186:XLT1 MdSel	(entry->xlt1_md_sel)
+ *  BIT 187-191:XLT2 MdSel	(entry->xlt2_md_sel)
+ */
+static void _ice_kb_entry_init(struct ice_xlt_kb_entry *entry, u8 *data)
+{
+	u8 idd, off, i = 0;
+	u64 d64;
+
+	idd = ICE_XLT_KB_X1AS_S / BITS_PER_BYTE;
+	off = ICE_XLT_KB_X1AS_S % BITS_PER_BYTE;
+	d64 = *((u64 *)&data[idd]) >> off;
+
+	entry->xlt1_ad_sel	= FIELD_GET(ICE_XLT_KB_X1AS, d64);
+	entry->xlt2_ad_sel	= FIELD_GET(ICE_XLT_KB_X2AS, d64);
+
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL00, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL01, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL02, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL03, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL04, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL05, d64);
+
+	idd = ICE_XLT_KB_FL06_S / BITS_PER_BYTE;
+	off = ICE_XLT_KB_FL06_S % BITS_PER_BYTE;
+	d64 = *((u64 *)&data[idd]) >> off;
+
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL06, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL07, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL08, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL09, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL10, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL11, d64);
+
+	idd = ICE_XLT_KB_FL12_S / BITS_PER_BYTE;
+	off = ICE_XLT_KB_FL12_S % BITS_PER_BYTE;
+	d64 = *((u64 *)&data[idd]) >> off;
+
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL12, d64);
+	entry->flg0_14_sel[i++]	= FIELD_GET(ICE_XLT_KB_FL13, d64);
+	entry->flg0_14_sel[i]	= FIELD_GET(ICE_XLT_KB_FL14, d64);
+
+	entry->xlt1_md_sel	= FIELD_GET(ICE_XLT_KB_X1MS, d64);
+	entry->xlt2_md_sel	= FIELD_GET(ICE_XLT_KB_X2MS, d64);
+}
+
+#define ICE_XLT_KB_X1PM_OFF		0
+#define ICE_XLT_KB_X2PM_OFF		1
+#define ICE_XLT_KB_PIPM_OFF		2
+#define ICE_XLT_KB_FL15_OFF		4
+#define ICE_XLT_KB_TBL_OFF		12
+
+/** The function parses a 204 bytes XLT Key Build Table with below format:
+ *  byte 0:	XLT1 Partition Mode		(kb->xlt1_pm)
+ *  byte 1:	XLT2 Partition Mode		(kb->xlt2_pm)
+ *  byte 2:	Profile ID Partition Mode	(kb->prof_id_pm)
+ *  byte 3:	reserved
+ *  byte 4-11:	Flag15 Mask			(kb->flag15)
+ *  byte 12-203:8 Key Build entries		(kb->entries)
+ */
+static void _ice_parse_kb_data(struct ice_hw *hw, struct ice_xlt_kb *kb,
+			       void *data)
+{
+	u8 *buf = data;
+	int i;
+
+	kb->xlt1_pm	= buf[ICE_XLT_KB_X1PM_OFF];
+	kb->xlt2_pm	= buf[ICE_XLT_KB_X2PM_OFF];
+	kb->prof_id_pm	= buf[ICE_XLT_KB_PIPM_OFF];
+
+	kb->flag15 = *(u64 *)&buf[ICE_XLT_KB_FL15_OFF];
+	for (i = 0; i < ICE_XLT_KB_TBL_CNT; i++)
+		_ice_kb_entry_init(&kb->entries[i],
+				   &buf[ICE_XLT_KB_TBL_OFF +
+					i * ICE_XLT_KB_TBL_ENTRY_SIZE]);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_xlt_kb_dump(hw, kb);
+}
+
+static struct ice_xlt_kb *_ice_xlt_kb_get(struct ice_hw *hw, u32 sect_type)
+{
+	struct ice_seg *seg = hw->seg;
+	struct ice_pkg_enum state;
+	struct ice_xlt_kb *kb;
+	void *data;
+
+	if (!seg)
+		return NULL;
+
+	kb = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*kb), GFP_KERNEL);
+	if (!kb)
+		return NULL;
+
+	memset(&state, 0, sizeof(state));
+	data = ice_pkg_enum_section(seg, &state, sect_type);
+	if (!data) {
+		ice_debug(hw, ICE_DBG_PARSER, "failed to find section type %d.\n",
+			  sect_type);
+		return NULL;
+	}
+
+	_ice_parse_kb_data(hw, kb, data);
+
+	return kb;
+}
+
+/**
+ * ice_xlt_kb_get_sw - create switch xlt key build
+ * @hw: pointer to the hardware structure
+ */
+struct ice_xlt_kb *ice_xlt_kb_get_sw(struct ice_hw *hw)
+{
+	return _ice_xlt_kb_get(hw, ICE_SID_XLT_KEY_BUILDER_SW);
+}
+
+/**
+ * ice_xlt_kb_get_acl - create acl xlt key build
+ * @hw: pointer to the hardware structure
+ */
+struct ice_xlt_kb *ice_xlt_kb_get_acl(struct ice_hw *hw)
+{
+	return _ice_xlt_kb_get(hw, ICE_SID_XLT_KEY_BUILDER_ACL);
+}
+
+/**
+ * ice_xlt_kb_get_fd - create fdir xlt key build
+ * @hw: pointer to the hardware structure
+ */
+struct ice_xlt_kb *ice_xlt_kb_get_fd(struct ice_hw *hw)
+{
+	return _ice_xlt_kb_get(hw, ICE_SID_XLT_KEY_BUILDER_FD);
+}
+
+/**
+ * ice_xlt_kb_get_rss - create rss xlt key build
+ * @hw: pointer to the hardware structure
+ */
+struct ice_xlt_kb *ice_xlt_kb_get_rss(struct ice_hw *hw)
+{
+	return _ice_xlt_kb_get(hw, ICE_SID_XLT_KEY_BUILDER_RSS);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_xlt_kb.h b/drivers/net/ethernet/intel/ice/ice_xlt_kb.h
new file mode 100644
index 000000000000..81f1f5742075
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_xlt_kb.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_XLT_KB_H_
+#define _ICE_XLT_KB_H_
+
+#define ICE_XLT_KB_FLAG0_14_CNT		15
+#define ICE_XLT_KB_TBL_CNT		8
+#define ICE_XLT_KB_TBL_ENTRY_SIZE	24
+
+struct ice_xlt_kb_entry {
+	u8 xlt1_ad_sel;
+	u8 xlt2_ad_sel;
+	u16 flg0_14_sel[ICE_XLT_KB_FLAG0_14_CNT];
+	u8 xlt1_md_sel;
+	u8 xlt2_md_sel;
+};
+
+struct ice_xlt_kb {
+	u8 xlt1_pm;
+	u8 xlt2_pm;
+	u8 prof_id_pm;
+	u64 flag15;
+
+	struct ice_xlt_kb_entry entries[ICE_XLT_KB_TBL_CNT];
+};
+
+void ice_xlt_kb_dump(struct ice_hw *hw, struct ice_xlt_kb *kb);
+struct ice_xlt_kb *ice_xlt_kb_get_sw(struct ice_hw *hw);
+struct ice_xlt_kb *ice_xlt_kb_get_acl(struct ice_hw *hw);
+struct ice_xlt_kb *ice_xlt_kb_get_fd(struct ice_hw *hw);
+struct ice_xlt_kb *ice_xlt_kb_get_rss(struct ice_hw *hw);
+#endif /* _ICE_XLT_KB_H */
-- 
2.25.1


