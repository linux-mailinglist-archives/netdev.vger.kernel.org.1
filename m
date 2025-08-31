Return-Path: <netdev+bounces-218573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AAFB3D529
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 22:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE8C3B6AAB
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983621DED63;
	Sun, 31 Aug 2025 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UAWgazX1"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFD101DE
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756672423; cv=none; b=TN+azfrgCq7jWenxIMwkn+4/w45FTgXYe+rhZ0pzSCe4s6O74MJkq0O4XdH70D4/QEEjqFwjF66YUIjhaSoS50EDWAtpfulX0ZkUGm7FajGlHzFHAzjKvxBsYJDCgnQE9EakQP9kutqBs9Kwqs03abuNOGtJT1UMGIZ18FIGWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756672423; c=relaxed/simple;
	bh=XrKUmP65ziijmVvWRPpGYMW/IXFFS7DpCNbpmna4ZYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8/2jz/mxSN79XPBZYLhPgrK3GVHMjn4jkzo2llvRKOwtrJwXqkgoH+HzfS3XCLHIUXi7gnn4emXJKMg0bMwIYXYqY5NxfR17O32geC1D5K6EL5K9R8m9MfYWSUkHV8sJEYpGnziNFyFKDT0rBgrUlKtLTQ4HIp0KWj8HuSy4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UAWgazX1; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756672421; x=1788208421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9lXtsj+zOMk9a4ftfSw7UIbPSQIDGEcXmVpc9bndFeA=;
  b=UAWgazX15M3usBT+y3igsfd8WjjolS8f3LMuRxDZvun2Kn46g0gpXYgX
   JG9AcUaIzdstHWwddMGO+pr8yu4ymfFF0JiMCMgCSjSyGSDpcc+eSrOB8
   g9/lc2W6e7YssR3mvj7/M15moojKsOE6UqranUl5N2WiwqxNb6ICczksL
   KKuHj/ZKav6cjgwgw0XuIMuAWBpOZ8cpUpfA1Zp5+ib/vSb3hRCMv8OGq
   Br5DtZwRWa/CL9b3PErJJQThkzodu7NjnAho8dm9iASd19Kn1OzzCaImV
   196nDNbZBeUGpqoiabiqgej90MYNprYBqD5Vo3BLw8My7++DUr2NlR1F9
   w==;
X-CSE-ConnectionGUID: bTAjT5F5QgmVRp6kA0JgtQ==
X-CSE-MsgGUID: JN40oS72Sba1r503Cr5t+A==
X-IronPort-AV: E=Sophos;i="6.18,225,1751241600"; 
   d="scan'208";a="2009676"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 20:33:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:9664]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id 29d4a506-946c-4d77-88c8-5830e4a2e0af; Sun, 31 Aug 2025 20:33:39 +0000 (UTC)
X-Farcaster-Flow-ID: 29d4a506-946c-4d77-88c8-5830e4a2e0af
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Sun, 31 Aug 2025 20:33:39 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sun, 31 Aug 2025 20:33:37 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Stefan Wegrzyn
	<stefan.wegrzyn@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>, Koichiro Den <den@valinux.co.jp>
Subject: [PATCH iwl-net v1] ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()
Date: Mon, 1 Sep 2025 05:33:11 +0900
Message-ID: <20250831203327.53155-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The error path of ixgbe_recovery_probe() has two memory bugs.

For non-E610 adapters, the function jumps to clean_up_probe without
calling devlink_free(), leaking the devlink instance and its embedded
adapter structure.

For E610 adapters, devlink_free() is called at shutdown_aci, but
clean_up_probe then accesses adapter->state, sometimes triggering
use-after-free because adapter is embedded in devlink. This UAF is
similar to the one recently reported in ixgbe_remove(). (Link)

Fix both issues by moving devlink_free() after adapter->state access,
aligning with the cleanup order in ixgbe_probe().

Link: https://lore.kernel.org/intel-wired-lan/20250828020558.1450422-1-den@valinux.co.jp/
Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
Cc: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ff6e8ebda5ba..08368e2717c2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11510,10 +11510,10 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 shutdown_aci:
 	mutex_destroy(&adapter->hw.aci.lock);
 	ixgbe_release_hw_control(adapter);
-	devlink_free(adapter->devlink);
 clean_up_probe:
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
+	devlink_free(adapter->devlink);
 	pci_release_mem_regions(pdev);
 	if (disable_dev)
 		pci_disable_device(pdev);
-- 
2.51.0


