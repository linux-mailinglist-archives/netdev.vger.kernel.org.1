Return-Path: <netdev+bounces-133333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD6995B46
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E771C2205F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AC21645B;
	Tue,  8 Oct 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5zqvW0T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84904215011
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428472; cv=none; b=IDZQJxy+pXbEQwoBV2bO6iPM0g4BSoIqUsyO75nw/fPL7gIAZYDrHuSt4caeSpdqM9iSmoNplRJNe85rHM9QkIy0LAlCJJWEvnaPVKM0o+jNvvrscRRDwN8yASOQGGcn2Mwf6KXi90C6pnKm6+J2QMC4X+0bI4W5ZbHHsIPhhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428472; c=relaxed/simple;
	bh=3dQ4XjTRMsfnlV6ZByugi51po1JJk35AH9+e8ooljc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPaqVZcVb/6sU6eYIOhBZv4rGKAxqnDT1jYGz8qahzB8Bil8kntpAFF5n0MBu2dj4/9ljbQ/cN7Rry94qvqt9aTi6W9dA1GMlQC/ftybfzl9E469zlnz7R1oaJB/TM8TrM77TZbuA4LzOK8uu5bztFLNd9DdnKUi3SZqgfnn14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5zqvW0T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428471; x=1759964471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dQ4XjTRMsfnlV6ZByugi51po1JJk35AH9+e8ooljc4=;
  b=I5zqvW0TrEryKq4GPC/pLfNDz9BqDXHkZ+wilqxeqAva9VYs5LtggD3G
   8W2rnt9sUiGErpc8wI7NuVs9dOOsAecWaUwA6ofC874MIdeSKlCvWXvwi
   5gY6L2JCIFh5b9NTLuHCPVdnCxGEecwjn5uV7vbN6ltavoQ+HeQ9Fx2oo
   rJjQYmUdwcVD6Dwa6m4gt88vW+OW09GuCg+PF1I2OWnz0pza0Wrnwqxz5
   f9HCEsJthDKQYqsfERhLl1kmboleiwu1gR1pUhhu7EFWDbkMxkg9Woq3l
   u+xTtC4wtTdBlsB1B2uD02DOwCdM8imuNcHeks7DQi9AQTnJTsZ+RwtTC
   Q==;
X-CSE-ConnectionGUID: aYmWnye/QCajENvcYSfhkQ==
X-CSE-MsgGUID: fleB0wXuQ+yiYRqGVzdyUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302395"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:09 -0700
X-CSE-ConnectionGUID: IpnLi+VkRWKSP474LlmU3Q==
X-CSE-MsgGUID: nZavYsCmSYGMENqOQ0gpoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787577"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	maciej.fijalkowski@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 2/7] ice: Fix netif_is_ice() in Safe Mode
Date: Tue,  8 Oct 2024 16:00:40 -0700
Message-ID: <20241008230050.928245-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

netif_is_ice() works by checking the pointer to netdev ops. However, it
only checks for the default ice_netdev_ops, not ice_netdev_safe_mode_ops,
so in Safe Mode it always returns false, which is unintuitive. While it
doesn't look like netif_is_ice() is currently being called anywhere in Safe
Mode, this could change and potentially lead to unexpected behaviour.

Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index da1352dc26af..09d1a4eb5716 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -87,7 +87,8 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
 
 bool netif_is_ice(const struct net_device *dev)
 {
-	return dev && (dev->netdev_ops == &ice_netdev_ops);
+	return dev && (dev->netdev_ops == &ice_netdev_ops ||
+		       dev->netdev_ops == &ice_netdev_safe_mode_ops);
 }
 
 /**
-- 
2.42.0


