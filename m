Return-Path: <netdev+bounces-102145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCE290193F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 03:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D606281B3F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3464337B;
	Mon, 10 Jun 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K9imTUcE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE0628
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717983183; cv=none; b=eqFmfrbCGQNLpyMSq+pHW/YufTgLSgdzGTpA3m4ItYmNK6q8xxajwmq7lZvVd99RTcsPru3kNVl04cj/Jr3m914b6BLaS4FUazRrcTG853qxXjl34FHX2ZmZdi6Am8zt8WNfeaJfoREJ+hv1/N5uIF6PnvssEsSYZmIOOXQhtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717983183; c=relaxed/simple;
	bh=O0iMYVsk7dHjMJqf4MrODLedO/zpJsr/ifmxRJKU0Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J84M6FG4+swkDa85tzDKGYU4Ss1TEFaptEULu7CXZm4v0jffcw+HgiFNoJSgDPFhmWZqpTSzTZFCr08K9xFOAMQD8kLuhsubfEKDWMZmlGq8s5kBa6cBc2HWzt9bsbw92HQDzF/YoXROc2zGmRlqDpi9tLRudgd1Xtt0dF8YN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K9imTUcE; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9DB03F94E;
	Mon, 10 Jun 2024 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717983171;
	bh=CM8RVCv8qEgwNBN7E7+ByiwzUl3Fkcuqyzp/ex5KlGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=K9imTUcEQyLR6VwAPQyStvUgWV++MyIRTCJubFOFpNkAE+iBRACTgeqYd//3cGs0q
	 wqYB33NZrKpZWfPN93dA1AJszX9InpQbCso+1aNwLQP7bayU1F3PlzIpXrwUhTDbdm
	 2ZG1dBMwbBqDfGC8nrgz0aTDBCC9owvZY+gdwFI64Bxft028ubGqmbVQI6w51u83/I
	 DQBqbTkWDUawgqomMmrcVT9Ezzk6GIJGlA9RQNuIVSQUMbVctFRV90L/PwDJK5cJCR
	 qOUFkpMvPkzdtsnrHbjrfj6DlW5SMGshRf0FlxiMHKFxo2Yx3SlttsP0XxX6+vOjyV
	 HceAp0ZabW5qQ==
From: Hui Wang <hui.wang@canonical.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	sasha.neftin@intel.com,
	naamax.meir@linux.intel.com
Cc: todd.e.brandt@intel.com,
	dmummenschanz@web.de,
	rui.zhang@intel.com,
	pmenzel@molgen.mpg.de,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	hui.wang@canonical.com
Subject: [iwl-net][PATCH] Revert "e1000e: move force SMBUS near the end of enable_ulp function"
Date: Mon, 10 Jun 2024 09:32:22 +0800
Message-Id: <20240610013222.12082-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bfd546a552e140b0a4c8a21527c39d6d21addb28

Commit bfd546a552e1 ("e1000e: move force SMBUS near the end of
enable_ulp function") introduces system suspend failure on some
ethernet cards, at the moment, the pciid of the affected ethernet
cards include [8086:15b8] and [8086:15bc].

About the regression the commit bfd546a552e1 ("e1000e: move force
SMBUS near the end of enable_ulp function") tried to fix, looks like
it is not trivial to fix, we need to find a better way to resolve it.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218940
Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218936
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ---------------------
 drivers/net/ethernet/intel/e1000e/netdev.c  | 18 +++++++++++++++++
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 2e98a2a0bead..f9e94be36e97 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1225,28 +1225,6 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
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
-	}
-	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
-	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
-
-	e1000e_enable_phy_retry(hw);
-
-	/* Force SMBus mode in MAC */
-	mac_reg = er32(CTRL_EXT);
-	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
-	ew32(CTRL_EXT, mac_reg);
-
 	hw->phy.ops.release(hw);
 out:
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index da5c59daf8ba..220d62fca55d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6623,6 +6623,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, ctrl_ext, rctl, status, wufc;
 	int retval = 0;
+	u16 smb_ctrl;
 
 	/* Runtime suspend should only enable wakeup for link changes */
 	if (runtime)
@@ -6696,6 +6697,23 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			if (retval)
 				return retval;
 		}
+
+		/* Force SMBUS to allow WOL */
+		/* Switching PHY interface always returns MDI error
+		 * so disable retry mechanism to avoid wasting time
+		 */
+		e1000e_disable_phy_retry(hw);
+
+		e1e_rphy(hw, CV_SMB_CTRL, &smb_ctrl);
+		smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
+		e1e_wphy(hw, CV_SMB_CTRL, smb_ctrl);
+
+		e1000e_enable_phy_retry(hw);
+
+		/* Force SMBus mode in MAC */
+		ctrl_ext = er32(CTRL_EXT);
+		ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
+		ew32(CTRL_EXT, ctrl_ext);
 	}
 
 	/* Ensure that the appropriate bits are set in LPI_CTRL
-- 
2.34.1


