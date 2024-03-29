Return-Path: <netdev+bounces-83409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84AA89230E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2491F20CD3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8C137C4B;
	Fri, 29 Mar 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbFrotQs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC38137776
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735003; cv=none; b=CzkxvSgCqsU3t7W31g1eQhezvSll6pdxxKxMZDTqmxwKUCaFS/3hbVAgnKQFsuRYwrjrid+6c7Qq0Bt3n5ZLYNWiJrUVmBGL0MIKpeC68Tb5otSsLq+WsR+bxL2zfjNytjYi0eLfkpuhSHYvurRf021dAGekZSTJv2Zg3vIu6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735003; c=relaxed/simple;
	bh=jmiuodGiGc00yd9J2xJN6OE2DijM0th4S0/AnMtLzms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP+DMzaYZd8XZ1rwvu8G1xJ1K/h4zfpjl/FyS6CMZ3ZTnq5CLqEKwk+LRbnzftM4q20jwhLq4+ZGoSZhBDIA5vPQArXbDPXr+3tMOhTyYQvkVf9vzWYV/gKJi/p1FlFfJ0IlQpfzzaLxaBElOg/8wbBVaeWQmlZBW2i2+m7NtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbFrotQs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711735001; x=1743271001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmiuodGiGc00yd9J2xJN6OE2DijM0th4S0/AnMtLzms=;
  b=KbFrotQsV3CNiYRkGMVc84w+zSMbm1M9MgH2LnI4lGSHu3bD0v3CjBH7
   4aTYyRRXnycerlpD3qgJK1TFh8Y9dQeM0IzYvLgYeR3NGqL0ADfdyDpNL
   ESDHrXPNQlIE0ios7ijaWsW8LRcE+fqgPA7hk/VdVAFdtAhGYR8elzZYP
   5k/xnhAllLtS0qzS5RosNzLJLMtqNWvMyZN3x8NSpX/A9LnssVNWEiITi
   Pf1iLERCY8bHgoW3d2ZDlqicRdQE3DGdSS/C7wtvDE3uSPHXk0dm/ii5l
   wMHd+L7JtGH74//7SEnTolDKTfam9stTdY90FeKrH1j6Rvj/UGgK+pE3N
   Q==;
X-CSE-ConnectionGUID: Yk0y3lk9TQyoQXjOrjnI6Q==
X-CSE-MsgGUID: o/DHqjwlTt+Nx57t5DbrYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24422463"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24422463"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21499368"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 10:56:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 3/4] igc: Refactor runtime power management flow
Date: Fri, 29 Mar 2024 10:56:26 -0700
Message-ID: <20240329175632.211340-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
References: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

Following the corresponding discussion [1] and [2] refactor the 'igc_open'
method and avoid taking the rtnl_lock() during the 'igc_resume' method.
The rtnl_lock is held by the upper layer and could lead to the deadlock
during resuming from a runtime power management flow. Notify the stack of
the actual queue counts 'netif_set_real_num_*_queues' outside the
'_igc_open' wrapper. This notification doesn't have to be called on each
resume.

Test:
1. Disconnect the ethernet cable
2. Enable the runtime power management via file system:
echo auto > /sys/devices/pci0000\.../power/control
3. Check the device state (lspci -s <device> -vvv | grep -i Status)

Link: https://lore.kernel.org/netdev/20231206113934.8d7819857574.I2deb5804
ef1739a2af307283d320ef7d82456494@changeid/#r [1]
Link: https://lore.kernel.org/netdev/20211125074949.5f897431@kicinski-fedo
ra-pc1c0hjn.dhcp.thefacebook.com/t/ [2]
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 32 +++++++++++------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 998d8c345a78..d9bd001af7ba 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5929,15 +5929,6 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 	if (err)
 		goto err_req_irq;
 
-	/* Notify the stack of the actual queue counts. */
-	err = netif_set_real_num_tx_queues(netdev, adapter->num_tx_queues);
-	if (err)
-		goto err_set_queues;
-
-	err = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
-	if (err)
-		goto err_set_queues;
-
 	clear_bit(__IGC_DOWN, &adapter->state);
 
 	for (i = 0; i < adapter->num_q_vectors; i++)
@@ -5958,8 +5949,6 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 
 	return IGC_SUCCESS;
 
-err_set_queues:
-	igc_free_irq(adapter);
 err_req_irq:
 	igc_release_hw_control(adapter);
 	igc_power_down_phy_copper_base(&adapter->hw);
@@ -5976,6 +5965,17 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 
 int igc_open(struct net_device *netdev)
 {
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	int err;
+
+	/* Notify the stack of the actual queue counts. */
+	err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
+					adapter->num_rx_queues);
+	if (err) {
+		netdev_err(netdev, "error setting real queue count\n");
+		return err;
+	}
+
 	return __igc_open(netdev, false);
 }
 
@@ -7181,13 +7181,11 @@ static int igc_resume(struct device *dev)
 
 	wr32(IGC_WUS, ~0);
 
-	rtnl_lock();
-	if (!err && netif_running(netdev))
+	if (netif_running(netdev)) {
 		err = __igc_open(netdev, true);
-
-	if (!err)
-		netif_device_attach(netdev);
-	rtnl_unlock();
+		if (!err)
+			netif_device_attach(netdev);
+	}
 
 	return err;
 }
-- 
2.41.0


