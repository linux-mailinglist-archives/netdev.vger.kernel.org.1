Return-Path: <netdev+bounces-219697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B3B42AD6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167A57C3156
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3D36998B;
	Wed,  3 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eufo0Xe6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D5362095
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931146; cv=none; b=Hmjvz1IqpWyLkEZWmZ2F14Rfa0R9ta+xZsrsOSbHiJ8e9I5s2Ps/qoqoEAbuDVh8z0YHdPt/Ns8f0wftne6411OKmJGHJLEbdoXMJBGMd/mla7wQBWxrwqj41duozjWVCUenUwUs4rEyIs1iaU+y2mXhDrVOqlCONBqCJREO0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931146; c=relaxed/simple;
	bh=1ABikgClIq8SFL7WixsTfyfkfnbYnhRDUgQVuFe6bac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2AXVn57sJmArE0vQ/74MksMPyX5FrEG0rulyHPnVyiPTh8RZab2UvUYR6NjZXny25+6Ahcq+E7GPukLg1hv8XAdEzdYPvQ4l3MRpqNeksdzZb4zTrcYl6Q1+fRYPZHT0txqb55I17SGWn9awPdRMRPfgbCLqJMg+5yletFHUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eufo0Xe6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931145; x=1788467145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ABikgClIq8SFL7WixsTfyfkfnbYnhRDUgQVuFe6bac=;
  b=eufo0Xe6s+LRZ39kt9j0s4DgBAYjXFDmN//Or7zH+DrE6h1tB5g7eyKl
   yfHh1nof4t905m9fbovsqgFiWtZYQuVXllCJ8dnqDwthYvyA3e+/8zvY2
   OaMYrpoi76ZJg3aS2YZB0IyD6TpcL7o0aZbpGVhnJOgW9nyBnBAEpk8Bu
   Q6W+90a4r6Q/5RJQd2Sgtw0Bc5spx8SReX4A1LDFnmtjKgsGRx5p+NcyI
   46LJ9/OmsEqujdGEHTi/oA4Dr9DK7WabGOwqHSW0iwrv1c/MAFGvV2hds
   U65dXamO1nCiSQmjU/zR/CL02zjJNlYNvaMJ6oE9jbGhlyH+34tZLWS3M
   Q==;
X-CSE-ConnectionGUID: Jj0nFFbCQluEAR/EOcWt7g==
X-CSE-MsgGUID: v6sXmYtPTZSBb0o1eOVpAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173052"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173052"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: /nkCr+jTQ6qP/gVn8goyUg==
X-CSE-MsgGUID: 6b+bvw7GRmaAFuy8UKlTxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823462"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacek Kowalski <jacek@jacekk.info>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 7/9] igb: drop unnecessary constant casts to u16
Date: Wed,  3 Sep 2025 13:25:33 -0700
Message-ID: <20250903202536.3696620-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Kowalski <jacek@jacekk.info>

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Additionally replace IGB_MNG_VLAN_NONE with resulting value
rather than casting -1 to u16.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_i210.c  | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c   | 4 ++--
 drivers/net/ethernet/intel/igb/igb.h         | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c    | 3 +--
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 64dfc362d1dc..44a85ad749a4 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2372,7 +2372,7 @@ static s32 igb_validate_nvm_checksum_with_offset(struct e1000_hw *hw,
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -2406,7 +2406,7 @@ static s32 igb_update_nvm_checksum_with_offset(struct e1000_hw *hw, u16 offset)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, (NVM_CHECKSUM_REG + offset), 1,
 				&checksum);
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 503b239868e8..9db29b231d6a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -602,7 +602,7 @@ static s32 igb_update_nvm_checksum_i210(struct e1000_hw *hw)
 			}
 			checksum += nvm_data;
 		}
-		checksum = (u16) NVM_SUM - checksum;
+		checksum = NVM_SUM - checksum;
 		ret_val = igb_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 						&checksum);
 		if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index 2dcd64d6dec3..c8638502c2be 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -636,7 +636,7 @@ s32 igb_validate_nvm_checksum(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -668,7 +668,7 @@ s32 igb_update_nvm_checksum(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c3f4f7cd264e..0fff1df81b7b 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -217,7 +217,7 @@ static inline int igb_skb_pad(void)
 #define IGB_MASTER_SLAVE	e1000_ms_hw_default
 #endif
 
-#define IGB_MNG_VLAN_NONE	-1
+#define IGB_MNG_VLAN_NONE	0xFFFF
 
 enum igb_tx_flags {
 	/* cmd_type flags */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae61e..5e63d7f6a568 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1531,8 +1531,7 @@ static void igb_update_mng_vlan(struct igb_adapter *adapter)
 		adapter->mng_vlan_id = IGB_MNG_VLAN_NONE;
 	}
 
-	if ((old_vid != (u16)IGB_MNG_VLAN_NONE) &&
-	    (vid != old_vid) &&
+	if (old_vid != IGB_MNG_VLAN_NONE && vid != old_vid &&
 	    !test_bit(old_vid, adapter->active_vlans)) {
 		/* remove VID from filter table */
 		igb_vfta_set(hw, vid, pf_id, false, true);
-- 
2.47.1


