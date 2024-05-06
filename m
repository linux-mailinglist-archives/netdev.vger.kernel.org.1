Return-Path: <netdev+bounces-93805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C58BD3C5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251CF1F22372
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BF15746C;
	Mon,  6 May 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmAVdzT0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B215746B
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016148; cv=none; b=oYi+Lq4iKgnAd4lk1gXTz1hvuUFz/KLIuu5YzPy2b3Jxg6n0R85N99Qub5B81UIuuaZqrfbGMfxTQzRIpPq1RlhzjbPZJGvYmxG4OIwfoKBINZdHR0ziBuohwpdoxlup7Z8/F7hOYATXG+Btjkkv6n1IdAMDkIvvClHKwIah+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016148; c=relaxed/simple;
	bh=w5JpTUVdVIj7MCsrwGonYzwPX/ONJ1gB76fRSwQSqZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuV7a+UxtayJ7f4ILzCt0Eyn+hs1MJVg+hdL+tvUdZFYDj/SUVP3EhARikZGT2a84KoHbzsVigqXuVQKMgJBOv6lKWE6vO/I/eLjfKja+iQvGcRfBPkpTOpho4c/xfAhkJ0QREesUxrptZTNRQzAulUZh6PtbDo9t/xQNZJcdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmAVdzT0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715016146; x=1746552146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w5JpTUVdVIj7MCsrwGonYzwPX/ONJ1gB76fRSwQSqZE=;
  b=OmAVdzT0/sMWyn2an3RCHoOITBoWEacu4B28wJ0J+/4QPh5w/QLwNN4F
   Z6J/8PCyOfspYniWTEdxyw43DQBPXt1dR7jS/ist9qaHOWHIkCcRkPA+o
   6XolJ35+ae4iNk2Z6dVRJUebWcgkyqbfoqR7S7n6e1hkjUeUcw0OAE8EG
   RfAJDOoJGw3jXHd7plmE6YWuZ6zNXxue12ED/1MOTMQD0KV1+5nXAc0Im
   xuZ5l7Z3fksbiLXj/ui3dqiGx/iFVtJ3GaafoZOdLI8tiNUARY8ngLNw3
   BX5LY2DGVwflsVUyT+XOBCFC7zQSeJPEbVoUKqRdfsy2AtLqCE1W+g/LG
   w==;
X-CSE-ConnectionGUID: 32F52e50SXS3KpFvQ1Jcog==
X-CSE-MsgGUID: ABgu/vKgRtq5LSIcur4jRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10898964"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10898964"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:22:23 -0700
X-CSE-ConnectionGUID: rm8tWeH8QZ+g7fVKpWGAug==
X-CSE-MsgGUID: 05W8tn+gQSG3uQCkN3Smng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28816508"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 06 May 2024 10:22:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	dima.ruinskiy@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net] e1000e: move force SMBUS near the end of enable_ulp function
Date: Mon,  6 May 2024 10:22:16 -0700
Message-ID: <20240506172217.948756-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Wang <hui.wang@canonical.com>

The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
function to avoid PHY loss issue") introduces a regression on
CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without this commit, the
ethernet works well after suspend and resume, but after applying the
commit, the ethernet couldn't work anymore after the resume and the
dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
[   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx

Without the commit, the force SMBUS code will not be executed if
"return 0" or "goto out" is executed in the enable_ulp(), and in my
case, the "goto out" is executed since FWSM_FW_VALID is set. But after
applying the commit, the force SMBUS code will be ran unconditionally.

Here move the force SMBUS code back to enable_ulp() and put it
immediate ahead of hw->phy.ops.release(hw), this could allow the
longest settling time as possible for interface in this function and
doesn't change the original code logic.

Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Acked-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f9e94be36e97..dd670cd87df2 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1225,6 +1225,25 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	}
 
 release:
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
+	/* Force SMBus mode in PHY */
+	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
+	if (ret_val)
+		goto release;
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
index 3692fce20195..cc8c531ec3df 100644
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
2.41.0


