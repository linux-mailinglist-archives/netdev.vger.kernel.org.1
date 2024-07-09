Return-Path: <netdev+bounces-110427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C092C48F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3541F2323E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF64D8D0;
	Tue,  9 Jul 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eX9gHHHj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3731B86EA
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557098; cv=none; b=bzWH/QmrdxGfnMqudBRbDzGfLWCZnXGnJuyXCNG0ybHXiLTIE7/AlMXAXs/MQrHvZ3KQZc0veyw7dDfsbBJylm6KwP0B2F0738c6iuEWV7q0dSZE5klmxxNZc5IeeFosQ9+0fzCJUdTokqdVPot2B/LOYJGfzH6SnKy4NbHbrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557098; c=relaxed/simple;
	bh=1O8Gh1u0FwM6pfqjg3leHp/Mm07QIubdUeFk3w/usjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgCc8Vl9vI7eoM/J55OdGv0nC9yOHEOS07eTVII9UlIo03pedYuNMUtDrD0/bVRZQyKIPO6J1+sl4Olj9HcOCBCVdXMwo/xrWaFvg0C/ZZZ2B3TD9WDZHxcgt0wwAU7QB/SVyQLO5w83MJAb82mftdYEsXAI6n8G36QDbrzAlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eX9gHHHj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720557097; x=1752093097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1O8Gh1u0FwM6pfqjg3leHp/Mm07QIubdUeFk3w/usjc=;
  b=eX9gHHHjXJqQcbmj87mDQ5eF/5bKug+UX95f/kQHimZkcwbonKby89rG
   O1zvDc5Z1MOoF/g3RDhJ+ZVXCmYQFGH6IJ8AfrTCYFiRCJUQQeORCv81d
   GXPS1Ob1T8GMmyAOTpTfl1qUKgTlw09LxhNlSoQcJyJ36wFRGVQfvbGvq
   JcM3LmCRiA6z5pMM53n//kMMcqGobWqEYInyUJRQXdR7q9WB5XG1tVFsk
   /KXwmORPrV11yIeEBZo4aw8B4ROxacgejX32NVX1oV/EHdQ6bjJE1puJ9
   Zt9x1MpR/jxHi2Ouw6RWd67ysLnGUG4TuIXpaJ0zQBUCuIcXpe8sodWpx
   Q==;
X-CSE-ConnectionGUID: LhPgjdR/Sxq01obeS/4Lcg==
X-CSE-MsgGUID: OA2uyyKhQ/GxhLfeZlEllA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17985288"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17985288"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 13:31:37 -0700
X-CSE-ConnectionGUID: KLv74zIETmG07yHjqt48bw==
X-CSE-MsgGUID: V23yfKxnRKerOsTbFAlTyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="71205125"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jul 2024 13:31:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	hui.wang@canonical.com,
	pmenzel@molgen.mpg.de,
	Todd Brandt <todd.e.brandt@intel.com>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net] e1000e: fix force smbus during suspend flow
Date: Tue,  9 Jul 2024 13:31:22 -0700
Message-ID: <20240709203123.2103296-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Commit 861e8086029e ("e1000e: move force SMBUS from enable ulp function
to avoid PHY loss issue") resolved a PHY access loss during suspend on
Meteor Lake consumer platforms, but it affected corporate systems
incorrectly.

A better fix, working for both consumer and corporate systems, was
proposed in commit bfd546a552e1 ("e1000e: move force SMBUS near the end
of enable_ulp function"). However, it introduced a regression on older
devices, such as [8086:15B8], [8086:15F9], [8086:15BE].

This patch aims to fix the secondary regression, by limiting the scope of
the changes to Meteor Lake platforms only.

Fixes: bfd546a552e1 ("e1000e: move force SMBUS near the end of enable_ulp function")
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218940
Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218936
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 73 +++++++++++++++------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 2e98a2a0bead..ce227b56cf72 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1108,6 +1108,46 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 	return 0;
 }
 
+/**
+ *  e1000e_force_smbus - Force interfaces to transition to SMBUS mode.
+ *  @hw: pointer to the HW structure
+ *
+ *  Force the MAC and the PHY to SMBUS mode. Assumes semaphore already
+ *  acquired.
+ *
+ * Return: 0 on success, negative errno on failure.
+ **/
+static s32 e1000e_force_smbus(struct e1000_hw *hw)
+{
+	u16 smb_ctrl = 0;
+	u32 ctrl_ext;
+	s32 ret_val;
+
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
+	/* Force SMBus mode in the PHY */
+	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &smb_ctrl);
+	if (ret_val) {
+		e1000e_enable_phy_retry(hw);
+		return ret_val;
+	}
+
+	smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
+	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, smb_ctrl);
+
+	e1000e_enable_phy_retry(hw);
+
+	/* Force SMBus mode in the MAC */
+	ctrl_ext = er32(CTRL_EXT);
+	ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
+	ew32(CTRL_EXT, ctrl_ext);
+
+	return 0;
+}
+
 /**
  *  e1000_enable_ulp_lpt_lp - configure Ultra Low Power mode for LynxPoint-LP
  *  @hw: pointer to the HW structure
@@ -1165,6 +1205,14 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
+	if (hw->mac.type != e1000_pch_mtp) {
+		ret_val = e1000e_force_smbus(hw);
+		if (ret_val) {
+			e_dbg("Failed to force SMBUS: %d\n", ret_val);
+			goto release;
+		}
+	}
+
 	/* Si workaround for ULP entry flow on i127/rev6 h/w.  Enable
 	 * LPLU and disable Gig speed when entering ULP
 	 */
@@ -1225,27 +1273,12 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	}
 
 release:
-	/* Switching PHY interface always returns MDI error
-	 * so disable retry mechanism to avoid wasting time
-	 */
-	e1000e_disable_phy_retry(hw);
-
-	/* Force SMBus mode in PHY */
-	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
-	if (ret_val) {
-		e1000e_enable_phy_retry(hw);
-		hw->phy.ops.release(hw);
-		goto out;
+	if (hw->mac.type == e1000_pch_mtp) {
+		ret_val = e1000e_force_smbus(hw);
+		if (ret_val)
+			e_dbg("Failed to force SMBUS over MTL system: %d\n",
+			      ret_val);
 	}
-	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
-	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
-
-	e1000e_enable_phy_retry(hw);
-
-	/* Force SMBus mode in MAC */
-	mac_reg = er32(CTRL_EXT);
-	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
-	ew32(CTRL_EXT, mac_reg);
 
 	hw->phy.ops.release(hw);
 out:
-- 
2.41.0


