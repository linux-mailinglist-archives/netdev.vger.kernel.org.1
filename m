Return-Path: <netdev+bounces-85915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B1289CD34
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BAA1C2171F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F731147C75;
	Mon,  8 Apr 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O28W8X7D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9A146589
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610543; cv=none; b=BnIwa17J+ao4ZFoRaa2DxNBOEDGzIH0VCzoTq7dlL88xrFdF9auUpltCezUvFyUcO/fezq1kI4JobXcTNwMFyZfEGYlk/1bC4L9XMoAO9hRMz10MfV+XuMdaqtuzhA35f15OD5l55oIDlOnDniqS/ycljsDgu27aTvCuRnZ7RKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610543; c=relaxed/simple;
	bh=DmwCz2CTt5Jwk1BdQShSlWwB8QYujoiJQ9h2MPnYw28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPzH8tdBVs07bS3q8KHNquDLuY0ePJpz2yKq5mil86qyx+MzGuhb2MKyWc5SD6xLM2AyH/D0HpI/xCTFl2e0dKUqNhM/jyeyEfAizIhDnvU/LRqlWZzMdCcHD09RCofLMwTYHPEHNvcHQSUQyQ3ASYTOqstcojAkjF9Hue4Ky7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O28W8X7D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712610541; x=1744146541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmwCz2CTt5Jwk1BdQShSlWwB8QYujoiJQ9h2MPnYw28=;
  b=O28W8X7D3tcidLTQobdeiZW8OwzU6loCcC6qpClRBr5CaIG0H8vFdNE1
   2ZLNBJaXzd3SMaE8fsNI8mGiyCoKnCD22dfh0x/Cyr+458endb3Dshqmy
   nBtIACX2cRw5XfcxcFzW0R+SLRSN/2Ds9YRYv2C2eqbU0Ryr9FwWf+qpB
   GUDDkpxukmL46yg1n1O9VIsxe6AtoL/AZ7IocHWrqt6MWPVJOBO4E6bfS
   2f7wHkDGbE+vXjyCYZaMHgRmu+bNBJo5N/iXjFmLy2Lld/gUr6gJ5/iWQ
   mMr+8t2jLhM2J+kUSbZErRlQ00ZAERbBMJaBMMmBsxXJIZbMqXDg9XwPe
   w==;
X-CSE-ConnectionGUID: 1X+WWwvwS3yoQEykio1EsA==
X-CSE-MsgGUID: i/IymY/jSsGcHqnChx8SlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7764063"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7764063"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:09:00 -0700
X-CSE-ConnectionGUID: qeMBaijXTU+wHJts/hErAQ==
X-CSE-MsgGUID: 5AFRBneNSk2X+Cp6JBvkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20128191"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2024 14:08:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 1/3] e1000e: Remove redundant runtime resume for ethtool_ops
Date: Mon,  8 Apr 2024 14:08:46 -0700
Message-ID: <20240408210849.3641172-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408210849.3641172-1-anthony.l.nguyen@intel.com>
References: <20240408210849.3641172-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

e60b22c5b7e5 ("e1000e: fix accessing to suspended device") added
ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
resume suspended devices before any ethtool_ops callback and allow suspend
after it completed.

3ef672ab1862 ("e1000e: ethtool unnecessarily takes device out of RPM
suspend") removed ethtool_ops.begin() and .complete() and instead did
pm_runtime_get_sync() only in the individual ethtool_ops callbacks that
access device registers.

Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
so the device is resumed before *any* ethtool_ops callback, as it was
before 3ef672ab1862.

Remove most runtime resumes from ethtool_ops, which are now redundant
because the resume has already been done by dev_ethtool().  This is
essentially a revert of 3ef672ab1862 ("e1000e: ethtool unnecessarily takes
device out of RPM suspend").

There are a couple subtleties:

  - Prior to 3ef672ab1862, the device was resumed only for the duration of
    a single ethtool callback.  3ef672ab1862 changed e1000_set_phys_id() so
    the device was resumed for ETHTOOL_ID_ACTIVE and remained resumed until
    a subsequent callback for ETHTOOL_ID_INACTIVE.  Preserve that part of
    3ef672ab1862 so the device will not be runtime suspended while in the
    ETHTOOL_ID_ACTIVE state.

  - 3ef672ab1862 added "if (!pm_runtime_suspended())" in before reading the
    STATUS register in e1000_get_settings().  This was racy and is now
    unnecessary because dev_ethtool() has resumed the device already, so
    revert that.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 62 ++-------------------
 1 file changed, 6 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index dc553c51d79a..85da20778e0f 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -156,7 +156,7 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 			speed = adapter->link_speed;
 			cmd->base.duplex = adapter->link_duplex - 1;
 		}
-	} else if (!pm_runtime_suspended(netdev->dev.parent)) {
+	} else {
 		u32 status = er32(STATUS);
 
 		if (status & E1000_STATUS_LU) {
@@ -274,16 +274,13 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	ethtool_convert_link_mode_to_legacy_u32(&advertising,
 						cmd->link_modes.advertising);
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	/* When SoL/IDER sessions are active, autoneg/speed/duplex
 	 * cannot be changed
 	 */
 	if (hw->phy.ops.check_reset_block &&
 	    hw->phy.ops.check_reset_block(hw)) {
 		e_err("Cannot change link characteristics when SoL/IDER is active.\n");
-		ret_val = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* MDI setting is only allowed when autoneg enabled because
@@ -291,16 +288,13 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	 * duplex is forced.
 	 */
 	if (cmd->base.eth_tp_mdix_ctrl) {
-		if (hw->phy.media_type != e1000_media_type_copper) {
-			ret_val = -EOPNOTSUPP;
-			goto out;
-		}
+		if (hw->phy.media_type != e1000_media_type_copper)
+			return -EOPNOTSUPP;
 
 		if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
 		    (cmd->base.autoneg != AUTONEG_ENABLE)) {
 			e_err("forcing MDI/MDI-X state is not supported when link speed and/or duplex are forced\n");
-			ret_val = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	}
 
@@ -347,7 +341,6 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	}
 
 out:
-	pm_runtime_put_sync(netdev->dev.parent);
 	clear_bit(__E1000_RESETTING, &adapter->state);
 	return ret_val;
 }
@@ -383,8 +376,6 @@ static int e1000_set_pauseparam(struct net_device *netdev,
 	while (test_and_set_bit(__E1000_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	if (adapter->fc_autoneg == AUTONEG_ENABLE) {
 		hw->fc.requested_mode = e1000_fc_default;
 		if (netif_running(adapter->netdev)) {
@@ -417,7 +408,6 @@ static int e1000_set_pauseparam(struct net_device *netdev,
 	}
 
 out:
-	pm_runtime_put_sync(netdev->dev.parent);
 	clear_bit(__E1000_RESETTING, &adapter->state);
 	return retval;
 }
@@ -448,8 +438,6 @@ static void e1000_get_regs(struct net_device *netdev,
 	u32 *regs_buff = p;
 	u16 phy_data;
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
 
 	regs->version = (1u << 24) |
@@ -495,8 +483,6 @@ static void e1000_get_regs(struct net_device *netdev,
 	e1e_rphy(hw, MII_STAT1000, &phy_data);
 	regs_buff[24] = (u32)phy_data;	/* phy local receiver status */
 	regs_buff[25] = regs_buff[24];	/* phy remote receiver status */
-
-	pm_runtime_put_sync(netdev->dev.parent);
 }
 
 static int e1000_get_eeprom_len(struct net_device *netdev)
@@ -529,8 +515,6 @@ static int e1000_get_eeprom(struct net_device *netdev,
 	if (!eeprom_buff)
 		return -ENOMEM;
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	if (hw->nvm.type == e1000_nvm_eeprom_spi) {
 		ret_val = e1000_read_nvm(hw, first_word,
 					 last_word - first_word + 1,
@@ -544,8 +528,6 @@ static int e1000_get_eeprom(struct net_device *netdev,
 		}
 	}
 
-	pm_runtime_put_sync(netdev->dev.parent);
-
 	if (ret_val) {
 		/* a read error occurred, throw away the result */
 		memset(eeprom_buff, 0xff, sizeof(u16) *
@@ -595,8 +577,6 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	ptr = (void *)eeprom_buff;
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	if (eeprom->offset & 1) {
 		/* need read/modify/write of first changed EEPROM word */
 		/* only the second byte of the word is being modified */
@@ -637,7 +617,6 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		ret_val = e1000e_update_nvm_checksum(hw);
 
 out:
-	pm_runtime_put_sync(netdev->dev.parent);
 	kfree(eeprom_buff);
 	return ret_val;
 }
@@ -733,8 +712,6 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		}
 	}
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	e1000e_down(adapter, true);
 
 	/* We can't just free everything and then setup again, because the
@@ -773,7 +750,6 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		e1000e_free_tx_resources(temp_tx);
 err_setup:
 	e1000e_up(adapter);
-	pm_runtime_put_sync(netdev->dev.parent);
 free_temp:
 	vfree(temp_tx);
 	vfree(temp_rx);
@@ -1816,8 +1792,6 @@ static void e1000_diag_test(struct net_device *netdev,
 	u8 autoneg;
 	bool if_running = netif_running(netdev);
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	set_bit(__E1000_TESTING, &adapter->state);
 
 	if (!if_running) {
@@ -1903,8 +1877,6 @@ static void e1000_diag_test(struct net_device *netdev,
 	}
 
 	msleep_interruptible(4 * 1000);
-
-	pm_runtime_put_sync(netdev->dev.parent);
 }
 
 static void e1000_get_wol(struct net_device *netdev,
@@ -2046,15 +2018,11 @@ static int e1000_set_coalesce(struct net_device *netdev,
 		adapter->itr_setting = adapter->itr & ~3;
 	}
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	if (adapter->itr_setting != 0)
 		e1000e_write_itr(adapter, adapter->itr);
 	else
 		e1000e_write_itr(adapter, 0);
 
-	pm_runtime_put_sync(netdev->dev.parent);
-
 	return 0;
 }
 
@@ -2068,9 +2036,7 @@ static int e1000_nway_reset(struct net_device *netdev)
 	if (!adapter->hw.mac.autoneg)
 		return -EINVAL;
 
-	pm_runtime_get_sync(netdev->dev.parent);
 	e1000e_reinit_locked(adapter);
-	pm_runtime_put_sync(netdev->dev.parent);
 
 	return 0;
 }
@@ -2084,12 +2050,8 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 	int i;
 	char *p = NULL;
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	dev_get_stats(netdev, &net_stats);
 
-	pm_runtime_put_sync(netdev->dev.parent);
-
 	for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
 		switch (e1000_gstrings_stats[i].type) {
 		case NETDEV_STATS:
@@ -2146,9 +2108,7 @@ static int e1000_get_rxnfc(struct net_device *netdev,
 		struct e1000_hw *hw = &adapter->hw;
 		u32 mrqc;
 
-		pm_runtime_get_sync(netdev->dev.parent);
 		mrqc = er32(MRQC);
-		pm_runtime_put_sync(netdev->dev.parent);
 
 		if (!(mrqc & E1000_MRQC_RSS_FIELD_MASK))
 			return 0;
@@ -2211,13 +2171,9 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val) {
-		pm_runtime_put_sync(netdev->dev.parent);
+	if (ret_val)
 		return -EBUSY;
-	}
 
 	/* EEE Capability */
 	ret_val = e1000_read_emi_reg_locked(hw, cap_addr, &phy_data);
@@ -2257,8 +2213,6 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	if (ret_val)
 		ret_val = -ENODATA;
 
-	pm_runtime_put_sync(netdev->dev.parent);
-
 	return ret_val;
 }
 
@@ -2299,16 +2253,12 @@ static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 
 	hw->dev_spec.ich8lan.eee_disable = !edata->eee_enabled;
 
-	pm_runtime_get_sync(netdev->dev.parent);
-
 	/* reset the link */
 	if (netif_running(netdev))
 		e1000e_reinit_locked(adapter);
 	else
 		e1000e_reset(adapter);
 
-	pm_runtime_put_sync(netdev->dev.parent);
-
 	return 0;
 }
 
-- 
2.41.0


