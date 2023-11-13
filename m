Return-Path: <netdev+bounces-47510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B17EA6BE
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C9E2810AE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157AF3D969;
	Mon, 13 Nov 2023 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3Bw72au"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7503E466
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB71B5
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917061; x=1731453061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z0GGJuvJryel2Cg2elwWQitOGIVbE/zUDV6WvR/BnNc=;
  b=G3Bw72audHvaxbWfOs4bvT+/MpHeq8zG8Cu1IN5L2XPmrBGjcybI9yi0
   kc1xrTXJklStwoL10nrYmJUlfpJqXH+xCJfr5MP7c5g3zq2hZFNuDg8xV
   FJJW4Cj4zLOV9uao86Jmt9/Iz2YqMPbp/zMtNltT7AU+4aH0EsMfythsl
   uxpYUlRXO4q/3Csyx4k3He12qrUyMmzsmqrwbdrCrwmNvQnviLyAsmzJT
   FqD2O/02tIy4hXD7x1rLEW/ksNrHqYIjOEjd1UkCHEj4t9n8+A5B0omhn
   LNeSM8P4c6Y+IIZpnSW7lZJRTttyq4BNQiTEot/6xrTWT9XeSPNa5CzTi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562650"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562650"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051426"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051426"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next 11/15] i40e: Add other helpers to check version of running firmware and AQ API
Date: Mon, 13 Nov 2023 15:10:30 -0800
Message-ID: <20231113231047.548659-12-anthony.l.nguyen@intel.com>
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

Add another helper functions that will be used by subsequent
patch to refactor existing open-coded checks whether the version
of running firmware and AdminQ API is recent enough to provide
certain capabilities.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 8b1efb6b91c5..9752d145939c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -608,6 +608,60 @@ static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
 		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
 }
 
+/**
+ * i40e_is_aq_api_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is less than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_aq_api_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is greater/equal than provided.
+ **/
+static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.fw_maj_ver > maj ||
+		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
+}
+
+/**
+ * i40e_is_fw_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is less than provided.
+ **/
+static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_fw_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_eq
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is equal to provided.
+ **/
+static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.fw_maj_ver > maj ||
+		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
+}
+
 struct i40e_driver_version {
 	u8 major_version;
 	u8 minor_version;
-- 
2.41.0


