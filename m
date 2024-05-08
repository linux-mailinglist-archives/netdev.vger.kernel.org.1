Return-Path: <netdev+bounces-94540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85198BFCDD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B404B24CB1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4E83CCF;
	Wed,  8 May 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U8pSDJv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46583A12
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169985; cv=none; b=lzJC6jIBIBQ1YYUlNsYJYatRH4PHWjgU96SZr1QvHktUL11h+gN1i/iUS4ESzAAaWaKZVfvez3R3KelZF6JjsPZAabZ86h/y+FFOQf/j7NwzrQoYNMM2amgwJQaZ7ioPsU7pjcwlKXG/D8uCpjCKB5drJxcus41fAwKVQGNJSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169985; c=relaxed/simple;
	bh=u68YNwcuyN1Xx3DofuEVXBZn1CkHAmqSQV8d6wAiC1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kW3KjJ3qkER5xZyyPku3/dAcauexc55EfzZHOtVvMQ8ZSZSF1eZ0TJvpcgEykzcd+UTfDMWywnX0Q4po3BBULqxBLYy1E/xa/kpGvzKsYg76IxBytLxo5FO74im3m3do4pTS7n8VceqwoOiffGdmxZ1oU4DmILHIyIJFEOQlrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U8pSDJv8; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [114.249.184.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 788F93F6CC;
	Wed,  8 May 2024 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715169976;
	bh=dK4QW0JXh/HALH9tt2xBOqDUcgd53vJGCuGFFNdKyHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=U8pSDJv88W2aOh6d8eDNUVyv+fA3Ye70nfu/1RfewvGmlq6sJtvInmsVmhCuYh7Dg
	 O+0qokeJXHFqB7YDIfONIQZZg/rWM9deZpL1JNaAUaJMF8WxPLO6vLbRBV8FAi2srx
	 LO0wiOpCg9Q6aajAogpEKw5+xT5nhzYb/9rmOfL7wk4jKdqeSInEVwm5FMqIDj5L13
	 fmME4HGXE18REEBjg0VgvixlWskWhU1T/2nZPktIimHaWCAzbPPVo2d1yHnzqOPy5f
	 y8dIs9CssX503OoMlQ2vPNwoUmgzMjLf//l85TxOaEAXBtjuJHF7ucclpLWTvvheo5
	 OX8+/SASLG5uw==
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
Subject: [PATCH v2] e1000e: move force SMBUS near the end of enable_ulp function
Date: Wed,  8 May 2024 20:06:04 +0800
Message-Id: <20240508120604.233166-1-hui.wang@canonical.com>
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
CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without the referred commit, the
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
In the v2:
 Change "this commit" to "the referred commit" in the commit header
 Fix a potential infinite loop if ret_val is not zero
 
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


