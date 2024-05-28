Return-Path: <netdev+bounces-98785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACC8D27BC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462E4284598
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206213DDC5;
	Tue, 28 May 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4AcIOtk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158913DDA0
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933982; cv=none; b=LOAjzcBkaef4VbJeychrc9KkenQbq1qUwq+NPd5Tr/0l/vL4yuQ0Mq7b29Pr6Vy55sEAju857IUdqJrDJfUPBwT/dV92bi6QPA1CIIiHX6FoPjK02M2M/qMTYpwP5hlvnh1VtGgiDjMdBLUTws0u+P7+pCrnWzxy65uc+xQZHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933982; c=relaxed/simple;
	bh=EP5jliQQA1aDxaD55qaHmvCwOiAkdubRjW8Cxzy69sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmPdOBgbOMpNys0iM9yBV0Zrl93CIRjwL1hsGi1m7Y+7s32kFmOxZESt3kkYJVuI4x2fbmDUdBHrBxvpaKJEsoUq8aHdNu3H9XdIRuP5ls0TYbu8g8HXMR67OXl9ZjVS85UhqetqeeVfXXeoXgjnirzor6HRS/iStkN4aGRToqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4AcIOtk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933981; x=1748469981;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EP5jliQQA1aDxaD55qaHmvCwOiAkdubRjW8Cxzy69sM=;
  b=J4AcIOtkwfu59Q6X2jStJNK1gC/2UEZe5j0+XPMu9svTA21+iuNM0WNL
   YJKvoAGd3jfhYdBRjZbEV6tTMab/bC1EEyuZWpdrmXu1iVQD4fbebMadJ
   FFfUt99gCMBRkiX6kYhs6k+7/PXK+5+VnY3KvrlLoXWeJ+8ykEPrlF+YQ
   +vFn0xx+sjfrtSYZL23ipPagMMxpQmROywF+NWKBsMX9sYjUzEVE3n2GG
   vI+Q3MSvbWGKnexLkfL/kfLmCMctdoQqUZ+TO1nAbj6qd13jAqtVhAFab
   3/PGYB+qV5L98bOnQoOmpSTrbTb3qVoFuD7TxNMA5rvsbpud4zqBM2u5N
   A==;
X-CSE-ConnectionGUID: mwQ0o1OyT2Og9WXkC1c0rQ==
X-CSE-MsgGUID: MG5zwQzIQq+T+FnDD4A6vA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439602"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439602"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: 5j54vXYOQsy1UOdi3LvNuQ==
X-CSE-MsgGUID: W6oTQIFcTj6fTZAo0CDNfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087513"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:04 -0700
Subject: [PATCH net 1/8] e1000e: move force SMBUS near the end of
 enable_ulp function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-1-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Hui Wang <hui.wang@canonical.com>, 
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>, Simon Horman <horms@kernel.org>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Zhang Rui <rui.zhang@intel.com>
X-Mailer: b4 0.13.0

From: Hui Wang <hui.wang@canonical.com>

The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
function to avoid PHY loss issue") introduces a regression on
PCH_MTP_I219_LM18 (PCIID: 0x8086550A). Without the referred commit, the
ethernet works well after suspend and resume, but after applying the
commit, the ethernet couldn't work anymore after the resume and the
dmesg shows that the NIC link changes to 10Mbps (1000Mbps originally):

    [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx

Without the commit, the force SMBUS code will not be executed if
"return 0" or "goto out" is executed in the enable_ulp(), and in my
case, the "goto out" is executed since FWSM_FW_VALID is set. But after
applying the commit, the force SMBUS code will be ran unconditionally.

Here move the force SMBUS code back to enable_ulp() and put it
immediately ahead of hw->phy.ops.release(hw), this could allow the
longest settling time as possible for interface in this function and
doesn't change the original code logic.

The issue was found on a Lenovo laptop with the ethernet hw as below:
00:1f.6 Ethernet controller [0200]: Intel Corporation Device [8086:550a]
(rev 20).

And this patch is verified (cable plug and unplug, system suspend
and resume) on Lenovo laptops with ethernet hw: [8086:550a],
[8086:550b], [8086:15bb], [8086:15be], [8086:1a1f], [8086:1a1c] and
[8086:0dc7].

Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Acked-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ++++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 18 ------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f9e94be36e97..2e98a2a0bead 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1225,6 +1225,28 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	}
 
 release:
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
+	/* Force SMBus mode in PHY */
+	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
+	if (ret_val) {
+		e1000e_enable_phy_retry(hw);
+		hw->phy.ops.release(hw);
+		goto out;
+	}
+	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
+	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
+
+	e1000e_enable_phy_retry(hw);
+
+	/* Force SMBus mode in MAC */
+	mac_reg = er32(CTRL_EXT);
+	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
+	ew32(CTRL_EXT, mac_reg);
+
 	hw->phy.ops.release(hw);
 out:
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 220d62fca55d..da5c59daf8ba 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6623,7 +6623,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, ctrl_ext, rctl, status, wufc;
 	int retval = 0;
-	u16 smb_ctrl;
 
 	/* Runtime suspend should only enable wakeup for link changes */
 	if (runtime)
@@ -6697,23 +6696,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			if (retval)
 				return retval;
 		}
-
-		/* Force SMBUS to allow WOL */
-		/* Switching PHY interface always returns MDI error
-		 * so disable retry mechanism to avoid wasting time
-		 */
-		e1000e_disable_phy_retry(hw);
-
-		e1e_rphy(hw, CV_SMB_CTRL, &smb_ctrl);
-		smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
-		e1e_wphy(hw, CV_SMB_CTRL, smb_ctrl);
-
-		e1000e_enable_phy_retry(hw);
-
-		/* Force SMBus mode in MAC */
-		ctrl_ext = er32(CTRL_EXT);
-		ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
-		ew32(CTRL_EXT, ctrl_ext);
 	}
 
 	/* Ensure that the appropriate bits are set in LPI_CTRL

-- 
2.44.0.53.g0f9d4d28b7e6


