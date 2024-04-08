Return-Path: <netdev+bounces-85916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F489CD35
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A879283243
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD8147C9D;
	Mon,  8 Apr 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7584G4s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3231474A6
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610543; cv=none; b=rlqumjf3hrp08P1q+BqOxt8TrTwvRGqjCm4ihQ8T9qJMwCrqa+FvxuCpG7TuQhqxJOtehcAUa8088yNIK9LE0adg92j+FVpgRN1uO6qGGP6uyf0gUyTzPs5PoOS4lkLlsnAgDgtqzTRR/PKciNxXffRkAk97W6zKaE3st+Jp49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610543; c=relaxed/simple;
	bh=XOySV6oDEPkTUb3PMQl9bv1g4nPxkfz/f4GWqTcEZgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikJfh2fhHJ70tR9wOasnPWrqZnQe4qxHH5WlbXtmwqanGkhOSOLfxNb9e0p0Y2pysNQ1Qp1f2aWnaXJ8bA4k6rwvvLdG1DAKoVriQcHBvB73w+VLsgbKzSncA/05Lo0luu9IeIf4mL4aUF7JzZUFTylTWSNrMjBBpIp/CrXRifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7584G4s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712610541; x=1744146541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XOySV6oDEPkTUb3PMQl9bv1g4nPxkfz/f4GWqTcEZgc=;
  b=N7584G4seQPYXTkfCK3aQfDVCuSbQYbeFDgU8Q/weOnHvsVBbwE0L0PM
   bt93BFDlHWiSjE7YYEFfW2ta1M003pecV5M9gJvVtHQZtnCU9+I2G6zZl
   mw9YESKmnRA45oZz3k0nTurC8mX+ytx14ze7wfePTrPevIEef7exu5UiA
   CRkvuZHMx/STUyKPgsd7ZSHTtz4OHu5x/pm3u9pRUuIztJ4h0KxsQ/wXC
   dSzkrM2URR5KevuSaKkIfC15OXToQDA1taowgFl2NbCWnsYFKcA1bGOy7
   FQEG11At+XQpdgxvys3OukP5TQH5MGfd/4dBpuHFCxFawDUINpMX+/y0Q
   w==;
X-CSE-ConnectionGUID: 2+wURW2WQNmh+lfd7PYFvA==
X-CSE-MsgGUID: VkQsTQByTeyExpCz95DI4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7764071"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7764071"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:09:00 -0700
X-CSE-ConnectionGUID: iTMyXGl+R9CrnzL+qVnTcA==
X-CSE-MsgGUID: MC/l/YxARsuUQDu8I8is/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20128194"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2024 14:09:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net-next 2/3] igb: Remove redundant runtime resume for ethtool_ops
Date: Mon,  8 Apr 2024 14:08:47 -0700
Message-ID: <20240408210849.3641172-3-anthony.l.nguyen@intel.com>
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

749ab2cd1270 ("igb: add basic runtime PM support") added
ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
resume suspended devices before any ethtool_ops callback and allow suspend
after it completed.

Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
so the device is resumed before any ethtool_ops callback even if the driver
didn't supply a .begin() callback.

Remove the .begin() and .complete() callbacks, which are now redundant
because dev_ethtool() already resumes the device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 99977a22b843..61d72250c0ed 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3272,19 +3272,6 @@ static int igb_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
-static int igb_ethtool_begin(struct net_device *netdev)
-{
-	struct igb_adapter *adapter = netdev_priv(netdev);
-	pm_runtime_get_sync(&adapter->pdev->dev);
-	return 0;
-}
-
-static void igb_ethtool_complete(struct net_device *netdev)
-{
-	struct igb_adapter *adapter = netdev_priv(netdev);
-	pm_runtime_put(&adapter->pdev->dev);
-}
-
 static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
 {
 	return IGB_RETA_SIZE;
@@ -3508,8 +3495,6 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.set_channels		= igb_set_channels,
 	.get_priv_flags		= igb_get_priv_flags,
 	.set_priv_flags		= igb_set_priv_flags,
-	.begin			= igb_ethtool_begin,
-	.complete		= igb_ethtool_complete,
 	.get_link_ksettings	= igb_get_link_ksettings,
 	.set_link_ksettings	= igb_set_link_ksettings,
 };
-- 
2.41.0


