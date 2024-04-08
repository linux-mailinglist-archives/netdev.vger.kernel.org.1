Return-Path: <netdev+bounces-85917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC40E89CD36
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3FDB246DB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5E1487C5;
	Mon,  8 Apr 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzKJjVZv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F6147C68
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610544; cv=none; b=u9T7Yv1vNcgZ5bJiWnanN7p54LAXxNn/aWXjrfg+rUuIZH0fqDxyuR+LuEx62/+zS5bVMstBrpUFv8WAWbbem+oFH+yLFP98GKrOBagFCjg+TtVExkLSxlW674jzSHBr4r/ZG2+rAN2c52lsrHMEWd8htDXq3GaPNW1q4KZ6hdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610544; c=relaxed/simple;
	bh=XmZt9wARzCB6oIx/cy989noY+GIOhAL5o08a/1VEfDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UY4METe7oHqQySnoK/68VrUbPfMqEjfhDA3JJYCpCwUWKLFK747ZT4y9hLgWhMRY5Y/nAaMKKyi0qN5mv1SGduM4Of08XnNoaMF48c0VuMB5ZMmRpg6bDDH9fBYYStKl8g9hezBi7xjI71zNJw0YJvO5boOD2C0eV/JUa/sW2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzKJjVZv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712610542; x=1744146542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XmZt9wARzCB6oIx/cy989noY+GIOhAL5o08a/1VEfDE=;
  b=BzKJjVZvEP7IXavzoXPUmJjd/TjrD40e1D+ojw2DWQa5q+leRtPd8b+I
   0kl+/5IKSy02rbOcnlztBqb5gs3pKxiovEEfRvUnkLFyPTUx8TESa2NSc
   UYU03Z6G3HEkZ46ltD4gEXJvy+9z+LHJvD0CsXjEayi4I/PQJtqsiIacd
   9t9xRukMl28DG2kagPGzL3w+6Ub1J2lvt++qnBC7oq6zJdC7ZFi+93S14
   PcS3UPHSYtf+/ECPfg3/7ZBvT8RJ+K4snDKzau7WkcoUh5LM0NARfv/8c
   ECBJA71f3FT56B2oG8vAZgz47FVKMlRYNRT+Kb/HAEJJLxCA02WdQzLOS
   w==;
X-CSE-ConnectionGUID: BuHgsWoXRyKYwiQpj60Sjw==
X-CSE-MsgGUID: yvRwmmHSSbeG8W33k0Drqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7764074"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7764074"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:09:01 -0700
X-CSE-ConnectionGUID: ma6GR67fT6CtRsfdleH2Jg==
X-CSE-MsgGUID: nC3M674CSJ2voue34OtaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20128197"
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
	sasha.neftin@intel.com,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 3/3] igc: Remove redundant runtime resume for ethtool ops
Date: Mon,  8 Apr 2024 14:08:48 -0700
Message-ID: <20240408210849.3641172-4-anthony.l.nguyen@intel.com>
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

8c5ad0dae93c ("igc: Add ethtool support") added ethtool_ops.begin() and
.complete(), which used pm_runtime_get_sync() to resume suspended devices
before any ethtool_ops callback and allow suspend after it completed.

Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
so the device is resumed before any ethtool_ops callback even if the driver
didn't supply a .begin() callback.

Remove the .begin() and .complete() callbacks, which are now redundant
because dev_ethtool() already resumes the device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 1a64f1ca6ca8..f2c4f1966bb0 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1711,21 +1711,6 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
-static int igc_ethtool_begin(struct net_device *netdev)
-{
-	struct igc_adapter *adapter = netdev_priv(netdev);
-
-	pm_runtime_get_sync(&adapter->pdev->dev);
-	return 0;
-}
-
-static void igc_ethtool_complete(struct net_device *netdev)
-{
-	struct igc_adapter *adapter = netdev_priv(netdev);
-
-	pm_runtime_put(&adapter->pdev->dev);
-}
-
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2025,8 +2010,6 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
 	.get_eee		= igc_ethtool_get_eee,
 	.set_eee		= igc_ethtool_set_eee,
-	.begin			= igc_ethtool_begin,
-	.complete		= igc_ethtool_complete,
 	.get_link_ksettings	= igc_ethtool_get_link_ksettings,
 	.set_link_ksettings	= igc_ethtool_set_link_ksettings,
 	.self_test		= igc_ethtool_diag_test,
-- 
2.41.0


