Return-Path: <netdev+bounces-142122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B129B9BD884
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6889F1F21BA2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE6216453;
	Tue,  5 Nov 2024 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4edpNde"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390022170C6
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845454; cv=none; b=PiqelEe+IasG7ib5sQ9upX3GdWeGYZhthTgT6tHG3xoqeLexVAs8lup3k7sm2yHTZq90tZkEqylePBDA3iWJ0zidF1vnPA+XwbE71SG2tQiRVlT63lmOkRKeuBtC9dG54WjvvToa7FebK7jdD4U5lPWdiEbYAkVqASwBBN4DRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845454; c=relaxed/simple;
	bh=3buNkZptrmm67XFSkWu1cSrwFgYDuF55Nz6t+nWwneA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n71VfQn4jVxS1sw3vd+FzuCH7/9FQHyERIhp+kKtc5719nSbSJLXONzOOAM+Paxe01MdbVEjKgIvs6fZY1Q/IhFfhYwAlMIxMxFwWxZWtoNDWjTUgOAVx/7rITaSycUl2JCDotk2bdOg5I0OYriSZJTV8IG4GT8eJOOz5GqFjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4edpNde; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845450; x=1762381450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3buNkZptrmm67XFSkWu1cSrwFgYDuF55Nz6t+nWwneA=;
  b=I4edpNdegP5NmSiUpxsiVJrp3G/4cKDUXGdCMe3N3dGw4CM97iplgaih
   XNopQqNPQxphph9Mwp06lhz9aNE24Y+FlwUA8pq59duVDcQNjH652LXwl
   1jLkIJ5sbIyxe2C5OpN9bCD35v9pLWqGiFJxqbXlNbO2tPcowF4/9C2aY
   W5tgfbvFSr/okAkFs6k2iJ8oYFmNPIgopbBB4wy8Amczjw5uC2mUhLmKu
   yyPx/DGe3DceckZhHxvY4rkaDoJPjIz5nIqURE9kEvl6Hp/ruth60mrlr
   B8qi37ZcR7bg0ieJYgDsdW3UuC6/gniAesds8p4ZXWQ8sSoZmhisUFT3b
   g==;
X-CSE-ConnectionGUID: Jz32ND2hSxGaWdoR6cXJoQ==
X-CSE-MsgGUID: WZ2GfZpSRKWuzlXz5DWJWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314343"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314343"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:03 -0800
X-CSE-ConnectionGUID: 3tefEK3qR/C3d6p/eDwh7Q==
X-CSE-MsgGUID: IsVA8e6/Tl+q5zlC8i7pQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322481"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH net-next 15/15] e1000: Hold RTNL when e1000_down can be called
Date: Tue,  5 Nov 2024 14:23:49 -0800
Message-ID: <20241105222351.3320587-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.

There are a few paths for e1000_down to be called in e1000 where RTNL is
not currently being held:
  - e1000_shutdown (pci shutdown)
  - e1000_suspend (power management)
  - e1000_reinit_locked (via e1000_reset_task delayed work)
  - e1000_io_error_detected (via pci error handler)

Hold RTNL in three places to fix this issue:
  - e1000_reset_task: igc, igb, and e100e all hold rtnl in this path.
  - e1000_io_error_detected (pci error handler): e1000e and ixgbe hold
    rtnl in this path. A patch has been posted for igc to do the same
    [1].
  - __e1000_shutdown (which is called from both e1000_shutdown and
    e1000_suspend): igb, ixgbe, and e1000e all hold rtnl in the same
    path.

The other paths which call e1000_down seemingly hold RTNL and are OK:
  - e1000_close (ndo_stop)
  - e1000_change_mtu (ndo_change_mtu)

Based on the above analysis and mailing list discussion [2], I believe
adding rtnl in the three places mentioned above is correct.

Fixes: 8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Closes: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
Link: https://lore.kernel.org/netdev/20241022215246.307821-3-jdamato@fastly.com/ [1]
Link: https://lore.kernel.org/netdev/ZxgVRX7Ne-lTjwiJ@LQ3V64L9R2/ [2]
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 4de9b156b2be..3f089c3d47b2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3509,7 +3509,9 @@ static void e1000_reset_task(struct work_struct *work)
 		container_of(work, struct e1000_adapter, reset_task);
 
 	e_err(drv, "Reset adapter\n");
+	rtnl_lock();
 	e1000_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
@@ -5074,7 +5076,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 			usleep_range(10000, 20000);
 
 		WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+		rtnl_lock();
 		e1000_down(adapter);
+		rtnl_unlock();
 	}
 
 	status = er32(STATUS);
@@ -5235,16 +5239,20 @@ static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
 	if (netif_running(netdev))
 		e1000_down(adapter);
 
 	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
 		pci_disable_device(pdev);
+	rtnl_unlock();
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
-- 
2.42.0


