Return-Path: <netdev+bounces-47512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B987EA6C0
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F680280F6F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB23E49F;
	Mon, 13 Nov 2023 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwjG3LwJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103C3E489
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC09D68
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917061; x=1731453061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=euUn1udkFRwfjyoxxiCZGbK4ULn8N650ObQVbl2NtJc=;
  b=EwjG3LwJiHBigq9gUM4D4xvMHFQGQcQuREbu1kUkSSg6w6yLxBGSNMux
   kN/QAiOhM0sATXP/c4ziVTU40DkNbpBu2Nm4YbmRlrklOL6f7fMa1aMa2
   fC888xhKWAJYn8XrKudrIvae3EJXCL0POr3wABAAjQutYnVBcKomCPl3c
   jQnNvcnMo9RIB9elYjXWSw35UnxkCZqWjUuA/EMeTREWdz1ApuEEegNpK
   xNNEoGN66t4MT1p8bTppo6dIPq5j5ZiocLE2vQcS9VtQdzMTOMTZSZ1gn
   1w2LJw5TS3rvXO3DfeLZhF3Fuh2gfrUwxry3b+hloCS5BSmI+L8stqP89
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562647"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562647"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051423"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051423"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 10/15] i40e: Move i40e_is_aq_api_ver_ge helper
Date: Mon, 13 Nov 2023 15:10:29 -0800
Message-ID: <20231113231047.548659-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Move i40e_is_aq_api_ver_ge helper function (used to check if AdminQ
API version is recent enough) to header so it can be used from
other .c files.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 23 ++++---------------
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 14 +++++++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 7fce881abc93..df7ba349030d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1749,21 +1749,6 @@ int i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
 	return status;
 }
 
-/**
- * i40e_is_aq_api_ver_ge
- * @aq: pointer to AdminQ info containing HW API version to compare
- * @maj: API major value
- * @min: API minor value
- *
- * Assert whether current HW API version is greater/equal than provided.
- **/
-static bool i40e_is_aq_api_ver_ge(struct i40e_adminq_info *aq, u16 maj,
-				  u16 min)
-{
-	return (aq->api_maj_ver > maj ||
-		(aq->api_maj_ver == maj && aq->api_min_ver >= min));
-}
-
 /**
  * i40e_aq_add_vsi
  * @hw: pointer to the hw struct
@@ -1890,14 +1875,14 @@ int i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
 
 	if (set) {
 		flags |= I40E_AQC_SET_VSI_PROMISC_UNICAST;
-		if (rx_only_promisc && i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+		if (rx_only_promisc && i40e_is_aq_api_ver_ge(hw, 1, 5))
 			flags |= I40E_AQC_SET_VSI_PROMISC_RX_ONLY;
 	}
 
 	cmd->promiscuous_flags = cpu_to_le16(flags);
 
 	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_UNICAST);
-	if (i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 		cmd->valid_flags |=
 			cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_RX_ONLY);
 
@@ -2000,13 +1985,13 @@ int i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
 
 	if (enable) {
 		flags |= I40E_AQC_SET_VSI_PROMISC_UNICAST;
-		if (i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+		if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 			flags |= I40E_AQC_SET_VSI_PROMISC_RX_ONLY;
 	}
 
 	cmd->promiscuous_flags = cpu_to_le16(flags);
 	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_UNICAST);
-	if (i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 		cmd->valid_flags |=
 			cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_RX_ONLY);
 	cmd->seid = cpu_to_le16(seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 346a74a516a8..8b1efb6b91c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -594,6 +594,20 @@ static inline bool i40e_is_vf(struct i40e_hw *hw)
 		hw->mac.type == I40E_MAC_X722_VF);
 }
 
+/**
+ * i40e_is_aq_api_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is greater/equal than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.api_maj_ver > maj ||
+		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
+}
+
 struct i40e_driver_version {
 	u8 major_version;
 	u8 minor_version;
-- 
2.41.0


