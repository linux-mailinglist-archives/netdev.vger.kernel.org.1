Return-Path: <netdev+bounces-63226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9682BE1B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C5287E50
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE745D8F4;
	Fri, 12 Jan 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmOsH2l1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E65D8F2
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705054174; x=1736590174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZvFke+XRGhfOl7Lb4+LszHZJfWeFfUICHvr9mpX/hxs=;
  b=TmOsH2l1KrMbgakXSEPIgpqMx5ICRIxTQbtdoyrQkyGMx5sLxYUzSmKv
   ckHFrKDKE8KzzxMX14Gz4NvGFhquP4sTKu3fM0MMw0E/rbFUelJDMkG7e
   Y1tXM9zFQJrTmgVInMYlPmT0NGraP1oBGcZMhq1ElGzyIPUbCOlN1hn52
   y5AODIjp7lvRx/sD3rg6W/Bq3MU4h3fyLNkNZaGGS7bZfJhd28suuBEKT
   aw4BbjRNXmKhSi5lo3RmP0gJSDytMvkphQ5dhBmgk24jlRFl/fuZbGGk7
   wSA7i6NjnxYQkABs+sn9bsSn2s9w5YwvK923wXf4cbr/sh/YeqgKRuKIF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5867355"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5867355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:09:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="759083278"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="759083278"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2024 02:09:31 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: [PATCH iwl-next v1 2/2] i40e-linux: Add support for reading Trace Buffer
Date: Fri, 12 Jan 2024 10:59:45 +0100
Message-Id: <20240112095945.450590-3-jedrzej.jagielski@intel.com>
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

Currently after entering FW Recovery Mode we have no info in logs
regarding current FW state.

Add function reading content of the alternate RAM storing that info and
print it into the log. Additionally print state of CSR register.

Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 35 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_register.h   |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +++
 4 files changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ba24f3fa92c3..6ebd2fd15e0e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -23,6 +23,8 @@
 /* Useful i40e defaults */
 #define I40E_MAX_VEB			16
 
+#define I40_BYTES_PER_WORD		2
+
 #define I40E_MAX_NUM_DESCRIPTORS	4096
 #define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
 #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4977ff391fed..f5abe8c9a88d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15414,6 +15414,39 @@ static int i40e_handle_resets(struct i40e_pf *pf)
 	return is_empr ? -EIO : pfr;
 }
 
+/**
+ * i40e_log_fw_recovery_mode - log current FW state in Recovery Mode
+ * @pf: board private structure
+ *
+ * Read alternate RAM and CSR registers and print them to the log
+ **/
+static void i40e_log_fw_recovery_mode(struct i40e_pf *pf)
+{
+	u8 buf[I40E_FW_STATE_BUFF_SIZE] = {0};
+	struct i40e_hw *hw = &pf->hw;
+	u8 fws0b, fws1b;
+	u32 fwsts;
+	int ret;
+
+	ret = i40e_aq_alternate_read_indirect(hw, I40E_ALT_CANARY,
+					      I40E_ALT_BUFF_DWORD_SIZE, buf);
+	if (ret) {
+		dev_warn(&pf->pdev->dev,
+			 "Cannot get FW trace buffer due to FW err %d aq_err %s\n",
+			 ret, i40e_aq_str(hw, hw->aq.asq_last_status));
+		return;
+	}
+
+	fwsts = rd32(&pf->hw, I40E_GL_FWSTS);
+	fws0b = FIELD_GET(I40E_GL_FWSTS_FWS0B_MASK, fwsts);
+	fws1b = FIELD_GET(I40E_GL_FWSTS_FWS1B_MASK, fwsts);
+
+	print_hex_dump(KERN_DEBUG, "Trace Buffer: ", DUMP_PREFIX_NONE,
+		       BITS_PER_BYTE * I40_BYTES_PER_WORD, 1, buf,
+		       I40E_FW_STATE_BUFF_SIZE, true);
+	dev_dbg(&pf->pdev->dev, "FWS0B=0x%x, FWS1B=0x%x\n", fws0b, fws1b);
+}
+
 /**
  * i40e_init_recovery_mode - initialize subsystems needed in recovery mode
  * @pf: board private structure
@@ -15497,6 +15530,8 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	mod_timer(&pf->service_timer,
 		  round_jiffies(jiffies + pf->service_timer_period));
 
+	i40e_log_fw_recovery_mode(pf);
+
 	return 0;
 
 err_switch_setup:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 14ab642cafdb..8e254ff9c035 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -169,6 +169,8 @@
 #define I40E_PRTDCB_TPFCTS_PFCTIMER_SHIFT 0
 #define I40E_PRTDCB_TPFCTS_PFCTIMER_MASK I40E_MASK(0x3FFF, I40E_PRTDCB_TPFCTS_PFCTIMER_SHIFT)
 #define I40E_GL_FWSTS 0x00083048 /* Reset: POR */
+#define I40E_GL_FWSTS_FWS0B_SHIFT 0
+#define I40E_GL_FWSTS_FWS0B_MASK  I40E_MASK(0xFF, I40E_GL_FWSTS_FWS0B_SHIFT)
 #define I40E_GL_FWSTS_FWS1B_SHIFT 16
 #define I40E_GL_FWSTS_FWS1B_MASK I40E_MASK(0xFF, I40E_GL_FWSTS_FWS1B_SHIFT)
 #define I40E_GL_FWSTS_FWS1B_EMPR_0 I40E_MASK(0x20, I40E_GL_FWSTS_FWS1B_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 725da7edbca3..0372a8d519ad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1372,6 +1372,11 @@ struct i40e_lldp_variables {
 #define I40E_ALT_BW_VALUE_MASK		0xFF
 #define I40E_ALT_BW_VALID_MASK		0x80000000
 
+/* Alternate Ram Trace Buffer*/
+#define I40E_ALT_CANARY				0xABCDEFAB
+#define I40E_ALT_BUFF_DWORD_SIZE		0x14 /* in dwords */
+#define I40E_FW_STATE_BUFF_SIZE			80
+
 /* RSS Hash Table Size */
 #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
 
-- 
2.31.1


