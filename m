Return-Path: <netdev+bounces-186899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B8BAA3CEC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67341BC49FD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2D255F2D;
	Tue, 29 Apr 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcB8B2e6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85153246795
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970427; cv=none; b=dNmZdl2anqsjXHiklCJR3I1hSpqyEtD6VxvzRar+7swHXhYlZ7wvClyg3MOng0aYU1WoVdkUIAryZYwiQU46jWJf9lbbiOQs6U8sX/+NIfNUSBeKniY0zVp1y3HH5gEsA4fdk1WzSEOOG5qAarA4tx93I0u1s5W1rDf9Ebs9y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970427; c=relaxed/simple;
	bh=nxv6W5E5L6Kx4FfWDaxndpEMhnV5feDAiqyw2h222rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvfTij6e40PzRzeSbnDbBQ4tpZ5ry/jZk3P5zz6fKx+EzWOD9c4SqAFslYqXaFdm0B2FP8lJnokjOVh7Kx6z13fVYcoK7zbuXf8rQ/GrNahHy4TBnopFhukgyAfuR8VZX0ZleffJVVx6+CYXrHAhoLH8XhqcgmqJuDSU8mz+4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcB8B2e6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970426; x=1777506426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxv6W5E5L6Kx4FfWDaxndpEMhnV5feDAiqyw2h222rU=;
  b=WcB8B2e6yx/s/Ws8VOC3S/GIoz24+lR5B+1v9piQiVEnUrBWCX8z2kaU
   7QIoqPCdV+THeWgSaiIi1mZGpUsuvFqN57QKcQV5BOH5je13v0zc4iqpE
   hWsgnRlbWKioDbxU2IwKtJPI6RzfzqH7WYhDSHDyDb4WXxH8/t/JQwP8L
   fUUGSIfcrKri0czVI+YznyUKWGsuZnDlNAImjuIoCJez8CxV1HbAEiP+J
   PiZant0MRSRCukw3ae2586M8pxzc4Ud7cpSzZewHNLNifgKPS5PhWM7r2
   KvjD2mLp4Vvz30C9FBGoxtnpCucTs8QFcqKmXylSxc9JDQhVrzp65gJtK
   A==;
X-CSE-ConnectionGUID: zdRxHjfwQvuKvp05Vcq6BA==
X-CSE-MsgGUID: 3zaSSqNwRJ+TgyxbUCdKRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990122"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990122"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:03 -0700
X-CSE-ConnectionGUID: wJfnxub4QxefgI6heZPmbg==
X-CSE-MsgGUID: tsvB/yGlRRGAoAK2fUEL7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979640"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 09/13] ixgbe: apply different rules for setting FC on E610
Date: Tue, 29 Apr 2025 16:46:44 -0700
Message-ID: <20250429234651.3982025-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

E610 device doesn't support disabling FC autonegotiation.

Create dedicated E610 .set_pauseparam() implementation and assign
it to ixgbe_ethtool_ops_e610.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 57 ++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index abc8c279192a..435f3fc3cec3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -564,6 +564,22 @@ static void ixgbe_get_pauseparam(struct net_device *netdev,
 	}
 }
 
+static void ixgbe_set_pauseparam_finalize(struct net_device *netdev,
+					  struct ixgbe_fc_info *fc)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	/* If the thing changed then we'll update and use new autoneg. */
+	if (memcmp(fc, &hw->fc, sizeof(*fc))) {
+		hw->fc = *fc;
+		if (netif_running(netdev))
+			ixgbe_reinit_locked(adapter);
+		else
+			ixgbe_reset(adapter);
+	}
+}
+
 static int ixgbe_set_pauseparam(struct net_device *netdev,
 				struct ethtool_pauseparam *pause)
 {
@@ -592,15 +608,40 @@ static int ixgbe_set_pauseparam(struct net_device *netdev,
 	else
 		fc.requested_mode = ixgbe_fc_none;
 
-	/* if the thing changed then we'll update and use new autoneg */
-	if (memcmp(&fc, &hw->fc, sizeof(struct ixgbe_fc_info))) {
-		hw->fc = fc;
-		if (netif_running(netdev))
-			ixgbe_reinit_locked(adapter);
-		else
-			ixgbe_reset(adapter);
+	ixgbe_set_pauseparam_finalize(netdev, &fc);
+
+	return 0;
+}
+
+static int ixgbe_set_pauseparam_e610(struct net_device *netdev,
+				     struct ethtool_pauseparam *pause)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_fc_info fc = hw->fc;
+
+	if (!ixgbe_device_supports_autoneg_fc(hw))
+		return -EOPNOTSUPP;
+
+	if (pause->autoneg == AUTONEG_DISABLE) {
+		netdev_info(netdev,
+			    "Cannot disable autonegotiation on this device.\n");
+		return -EOPNOTSUPP;
 	}
 
+	fc.disable_fc_autoneg = false;
+
+	if (pause->rx_pause && pause->tx_pause)
+		fc.requested_mode = ixgbe_fc_full;
+	else if (pause->rx_pause)
+		fc.requested_mode = ixgbe_fc_rx_pause;
+	else if (pause->tx_pause)
+		fc.requested_mode = ixgbe_fc_tx_pause;
+	else
+		fc.requested_mode = ixgbe_fc_none;
+
+	ixgbe_set_pauseparam_finalize(netdev, &fc);
+
 	return 0;
 }
 
@@ -3710,7 +3751,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_ringparam          = ixgbe_set_ringparam,
 	.get_pause_stats	= ixgbe_get_pause_stats,
 	.get_pauseparam         = ixgbe_get_pauseparam,
-	.set_pauseparam         = ixgbe_set_pauseparam,
+	.set_pauseparam         = ixgbe_set_pauseparam_e610,
 	.get_msglevel           = ixgbe_get_msglevel,
 	.set_msglevel           = ixgbe_set_msglevel,
 	.self_test              = ixgbe_diag_test,
-- 
2.47.1


