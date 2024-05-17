Return-Path: <netdev+bounces-96966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EADA8C8775
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F682844FA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEA54BD3;
	Fri, 17 May 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kXTN60hg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F454BD7
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953868; cv=none; b=JICDwmpHqyF/JxdskAnCjjnSEN0kJw92diLvTlpjHAFstMx9W7WP1OHO2sNz+GennphjLZvtCWZRpJuzmZbkbkRl4foSEO3h9QER9Jo4jOfrn4dMCgB8WV3VUiZjCKYfSq8Jw62ZO/1hhuWS31o6tLREyPzNx3GuQFZSXWjG1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953868; c=relaxed/simple;
	bh=hrdw+xpZVHHGeNHROReDJ0lU3WDkwGrGTjm11LXGpOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nv6mg0K03AwnW2kXBBZla4mBUjcdLVreHPlULCg7iGON/66ZGRiGC4rRILKOH/OhJWR6FUHhxlOSLD9IseSFV9F7NWXQdo5AwWYFQzOf6lyqNLWHAhdMJAR74AR7mlZn1byIBr2++i8r2x1kl+Gw0TQvsdaocx7s2W+fnhudqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kXTN60hg; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.. (unknown [149.11.192.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D0FA83FA40;
	Fri, 17 May 2024 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715953860;
	bh=6gxW9Vl+576ign5vW/P5Se5+oW1Bp9cQhGUcs9R2Fk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=kXTN60hgjnDQTtlDqXdZVUPQwhojOICOTkxD51A16Pi885GfXvKjBTwqCXZCebQLt
	 3tcLhjdp4uGRbEYbZ1OSf174Rv3zgryn1EyXWzyxT0KErlJKxPOmuD2LaavNLfE+wX
	 CzXxuCUSTog9JeWfcYKVIWjQo8ENFSYGqh8PbOEFUvCCOKFH33lD9yYaytYlAoPwVw
	 OvycLkTEEpx2MnLUe0eQ4uOIFBoB0yVERi+06ewsuRE6EHl1rYrCx/ZK34PcWoIi8l
	 KdD16x1i329x7V8jY6I1qNmb9K90GMRzhw5lil7NoeDTPfd19ujV+NiyqRZC3P2DdJ
	 ss7Wz5xCLuxpw==
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
Cc: hui.wang@canonical.com
Subject: [iwl-net][PATCH v3] e1000e: move force SMBUS near the end of enable_ulp function
Date: Fri, 17 May 2024 21:50:59 +0800
Message-Id: <20240517135059.10646-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
In the v3:
addressed Paul's comment about commit header,
 - Change CH_MTP_I219_LM18 to PCH_MTP_I219_LM18
 - Change Link to link
 - Add a blank line and four spaces indent for [   43.305084] e1000e 0000:00:1f.6
 - Change immediate to immediately
 - Add system info about reproduced the issue and verified the fix

 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 +++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 18 -----------------
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
2.34.1


