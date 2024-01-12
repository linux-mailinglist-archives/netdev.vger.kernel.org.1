Return-Path: <netdev+bounces-63227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFF82BE1E
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1531F21B73
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12D5D739;
	Fri, 12 Jan 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGpGSF/v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BE57877
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705054186; x=1736590186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYlwYu/JnYFP0dZJ9hFqUmlC0ICBzK/58VCU/teM4uE=;
  b=DGpGSF/vdVbG8amWWVrmcHgzqn3MRfEx/PBjPwDNxghnyEXaPP6mwILN
   AjhgsVJsJEQVZOliT1MHmEn2+tpBcHBM5CCOrrLKYNPES4/HeS5BYXVEG
   JJq8HFc90BQHLVMnvVgzqXzksImWhtYSzo3r5eBzcjdhqXC9g2xBSiAJ8
   Azk1M5K3jw2nRDzVdNskAiVA9Qd7GQaNrF5GdEhqrha/DrRJYmfop9JOB
   aMF/l3HJcrJO8d1f6jVxWnTytu28oBIcpx6ZKbx2yMKelPk5pa5o5Ncev
   Df6THP3XPG0EfGdE1UzVlx0SkCptyV08kOOfp/rDwq/UkJJzCkztcA0wp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5867349"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5867349"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:09:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="759083275"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="759083275"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2024 02:09:29 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemyslaw R Karpinski <przemyslaw.r.karpinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 1/2] i40e: Add read alternate indirect command
Date: Fri, 12 Jan 2024 10:59:44 +0100
Message-Id: <20240112095945.450590-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240112095945.450590-1-jedrzej.jagielski@intel.com>
References: <20240112095945.450590-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw R Karpinski <przemyslaw.r.karpinski@intel.com>

Introduce implementation of 0x0903 Admin Queue command.
This indirect command reads a block of data from the alternate structure
of memory. The command defines the number of Dwords to be read and the
starting address inside the alternate structure.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemyslaw R Karpinski <przemyslaw.r.karpinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 40 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  3 ++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 18a1c3b6d72c..50785f7e6d08 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1983,14 +1983,14 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write);
  * Indirect read (indirect 0x0903)
  */
 
-struct i40e_aqc_alternate_ind_write {
+struct i40e_aqc_alternate_ind_read_write {
 	__le32 address;
 	__le32 length;
 	__le32 addr_high;
 	__le32 addr_low;
 };
 
-I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_ind_write);
+I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_ind_read_write);
 
 /* Done alternate write (direct 0x0904)
  * uses i40e_aq_desc
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index de6ca6295742..93971c9c98cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4375,6 +4375,46 @@ static int i40e_aq_alternate_read(struct i40e_hw *hw,
 	return status;
 }
 
+/**
+ * i40e_aq_alternate_read_indirect
+ * @hw: pointer to the hardware structure
+ * @addr: address of the alternate structure field
+ * @dw_count: number of alternate structure fields to read
+ * @buffer: pointer to the command buffer
+ *
+ * Read 'dw_count' dwords from alternate structure starting at 'addr' and
+ * place them in 'buffer'. The buffer should be allocated by caller.
+ *
+ **/
+int i40e_aq_alternate_read_indirect(struct i40e_hw *hw, u32 addr, u32 dw_count,
+				    void *buffer)
+{
+	struct i40e_aqc_alternate_ind_read_write *cmd_resp;
+	struct i40e_aq_desc desc;
+	int status;
+
+	if (!buffer)
+		return -EINVAL;
+
+	cmd_resp = (struct i40e_aqc_alternate_ind_read_write *)&desc.params.raw;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_alternate_read_indirect);
+
+	desc.flags |= cpu_to_le16(I40E_AQ_FLAG_RD);
+	desc.flags |= cpu_to_le16(I40E_AQ_FLAG_BUF);
+	if (dw_count > I40E_AQ_LARGE_BUF / 4)
+		desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
+
+	cmd_resp->address = cpu_to_le32(addr);
+	cmd_resp->length = cpu_to_le32(dw_count);
+
+	status = i40e_asq_send_command(hw, &desc, buffer,
+				       lower_16_bits(4 * dw_count), NULL);
+
+	return status;
+}
+
 /**
  * i40e_aq_suspend_port_tx
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index af4269330581..37c23a0bded6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -322,6 +322,9 @@ i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     u8 filter_count);
 int i40e_read_lldp_cfg(struct i40e_hw *hw,
 		       struct i40e_lldp_variables *lldp_cfg);
+
+int i40e_aq_alternate_read_indirect(struct i40e_hw *hw, u32 addr, u32 dw_count,
+				    void *buffer);
 int
 i40e_aq_suspend_port_tx(struct i40e_hw *hw, u16 seid,
 			struct i40e_asq_cmd_details *cmd_details);
-- 
2.31.1


