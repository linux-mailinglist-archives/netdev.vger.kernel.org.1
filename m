Return-Path: <netdev+bounces-102462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3FF903273
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1DCB25BA4
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEF817165E;
	Tue, 11 Jun 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HrktNblH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353686116
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087073; cv=none; b=AtvEoV15zp300pUOW7BSse+OpgU1KeSZLeq/5osCLv52At7XT4wUvlrJXqZe+yI88DIsD/ikH4z5BfGL+gtGpiXOihYTgMaVBvbLNaaE6B4vqfj1D+BXeyEINl/jicDpfroaJPrRie6nKmpnbNKJaTLvl2gK/bv+bNEIE/JiDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087073; c=relaxed/simple;
	bh=JXY6EM5Rqyl9A2O+nkgbh02Cag5N+9QPwwbUxNtoiVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s6G5EiOus6Sb5OS24DSfnhFvAMzm7AyYlb+9PUDy3VVYmLig8ySsBYsjdasRIu64Svn3ZxQLouinvniNz+3KYmUAyMrdkLumBm+kCcL3QeQrMFzyWn1/5IqeAyGRI/t0hNB3F1/l6Qeq5VXCgfv5oG/75m8fbrxGmb13Vvx9qTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HrktNblH; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.. (unknown [103.229.218.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F3DFA3F73C;
	Tue, 11 Jun 2024 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718087068;
	bh=WsKZcfyrQfK6FTCUm2GsLjowAkjZh/8keEZARTRePAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=HrktNblHPEil+mx3hgel2/XYInXlQmIDdj+KLHI/wMjjwiYshFIby4OR+6vKMukWC
	 9kW06dDigXjGlkSYPtVnR9yAxPKUiOeBZB3Wufw9GWOnCA7ZoC0nHJxnQk/kSPhhXK
	 OG7wPoikBstJEnbCONEXO+lEMWvydBcr5TX2Wyj+dL334/fP8QnDMtss3imApz/nwj
	 vKaQjEhEXkCl03BSjuNLRXbrq0IOCV32n7uU2MD8Xbg6LOeOK1C+ip/HnfQDbIurrz
	 AD+/17OCFbxMeHq0JN06kYrgWXZ7MUWJ4IONgoWdCXG+TdE1kbncShVphSl251DK4X
	 zqNushfx2Ommw==
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
Subject: [iwl-net][PATCH v2] Revert "e1000e: move force SMBUS near the end of enable_ulp function"
Date: Tue, 11 Jun 2024 14:24:16 +0800
Message-Id: <20240611062416.16440-1-hui.wang@canonical.com>
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

About the regression introduced by commit 861e8086029e ("e1000e: move
force SMBUS from enable ulp function to avoid PHY loss issue"), looks
like it is not trivial to fix, we need to find a better way to resolve
it.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218940
Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218936
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
in V2:
change "regression the commit ... tried to fix" to "regression
introduced by commit"

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


