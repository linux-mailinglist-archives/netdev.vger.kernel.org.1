Return-Path: <netdev+bounces-219696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6754FB42AD5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C891C23192
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF536934E;
	Wed,  3 Sep 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Av823a5G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDC3019B3
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931146; cv=none; b=ZyE+zOEGYg16Vt0Bdc+qKHKtPQPBRgoJ6vtdYoqTUYv2GFaK8IyYxS9JZUetrDQP+8CCa7Tyu/KR7D78k3LH3zBu7v1g095wCVZLDPcNEOsHrUjzOP4RRFruCpqKFBJeP9BttdAYhg58vhkBMCWDjYDAv2oR72SJpAD4Jr238k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931146; c=relaxed/simple;
	bh=kvV7dBB504WFOxCdZ7qvvO8X4W4392xjB+iIdUdlZeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHXFHqX0EAQ7OVFFI+3Hn+T2ccnc6HEhTGXBJWzQbHQG9oasDG+RTEUeEBTc+SERmQw9Wy9goDGigX9BiMHvswMQCXoEG0OI6kbPrHFOgihxpWQ1mm/NpJOAV31ZnCswiBc0U5+8W7tVeFlOLgCsJ3s8iLJBYHCCIAjpTlREn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Av823a5G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931145; x=1788467145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kvV7dBB504WFOxCdZ7qvvO8X4W4392xjB+iIdUdlZeo=;
  b=Av823a5G6ceI/G5tVFqdVKQMoud32X2+26ANdeKpb2jv3/Suw1VQpTRC
   Gc9OGUaHA9wBDfYXK1nbuZBA+Bk3yLUbCA1M3c+mayxSulHEsQBxxYB8x
   6eiM2Gl3wmsDXmdYtb9sGK0DqR5/aEWXx74zEXIZzaJOPoNkeK4zg+f4w
   45omRpnykfKjd86f6dU/Cb39Rxk8MrxQ95P69OoxZpYbKlEEygCJWKnPr
   gy5xihE+hPAiXpFuHliXTQp+wjdG+XYIMiVW4Kz35qEZtve1wikaUGv7P
   xBrfYPaVtu4FVZd/l1/3hyll2C2bTmozbSF/hhr213nVUI81c1HJHH49z
   w==;
X-CSE-ConnectionGUID: K+qzeS2rQ16j6DO2kW7MTQ==
X-CSE-MsgGUID: UqxKuu87SyOb8ENwbQFYvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173045"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: J4rJww3dRP+8nlxL+/mR3Q==
X-CSE-MsgGUID: dG7/FuzNQL6J955AmRl7kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823459"
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
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 6/9] e1000e: drop unnecessary constant casts to u16
Date: Wed,  3 Sep 2025 13:25:32 -0700
Message-ID: <20250903202536.3696620-7-anthony.l.nguyen@intel.com>
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

Additionally replace E1000_MNG_VLAN_NONE with resulting value
rather than casting -1 to u16.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   | 2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 4 ++--
 drivers/net/ethernet/intel/e1000e/nvm.c     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 952898151565..018e61aea787 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -64,7 +64,7 @@ struct e1000_info;
 #define AUTO_ALL_MODES			0
 #define E1000_EEPROM_APME		0x0400
 
-#define E1000_MNG_VLAN_NONE		(-1)
+#define E1000_MNG_VLAN_NONE		0xFFFF
 
 #define DEFAULT_JUMBO			9234
 
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index c0bbb12eed2e..06482ad50508 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -959,7 +959,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)NVM_SUM) && !(*data))
+	if (checksum != NVM_SUM && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b27a61fab371..201322dac233 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2761,7 +2761,7 @@ static void e1000e_vlan_filter_disable(struct e1000_adapter *adapter)
 		rctl &= ~(E1000_RCTL_VFE | E1000_RCTL_CFIEN);
 		ew32(RCTL, rctl);
 
-		if (adapter->mng_vlan_id != (u16)E1000_MNG_VLAN_NONE) {
+		if (adapter->mng_vlan_id != E1000_MNG_VLAN_NONE) {
 			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),
 					       adapter->mng_vlan_id);
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
@@ -2828,7 +2828,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
 		adapter->mng_vlan_id = vid;
 	}
 
-	if ((old_vid != (u16)E1000_MNG_VLAN_NONE) && (vid != old_vid))
+	if (old_vid != E1000_MNG_VLAN_NONE && vid != old_vid)
 		e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q), old_vid);
 }
 
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 16369e6d245a..4bde1c9de1b9 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -564,7 +564,7 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		return 0;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
 	}
@@ -594,7 +594,7 @@ s32 e1000e_update_nvm_checksum_generic(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = e1000_write_nvm(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		e_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.1


