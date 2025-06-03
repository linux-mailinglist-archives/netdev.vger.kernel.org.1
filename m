Return-Path: <netdev+bounces-194808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA01FACCBD9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E99169997
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954771CCEE0;
	Tue,  3 Jun 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNYXABXR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE725464D
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971040; cv=none; b=YxFvwep+Asjp/KwXzjwPwG4FWjc8aupHiQbnX1hmZb/7CvaqytxZIpqgKziAQc7NGR2PKupJot/5fe5vCO+FjwOJZqkybGDZ4ixp5RwWmGBohkSVfp6yrClZBpvhMnX53xL1xd5RCwyUtHcVmBw0zCT6T+YC1cz+j2ubwlWzSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971040; c=relaxed/simple;
	bh=YzWYnpAQET1gYB4atKJQGlUAR+pzhAeLGi0G9UqQ4Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce2PPQ4Q/GpovinjwXqlQcYFcfOuww29qjYyX4STAt4XGXIujlW9rFGTKAO9KsWmuB/dZGAYjR9sVYdcyYco9DuA8LOtl3ijjbiF9UrWVDi40V9OIDMv4MVn4fSODBLTOEpXOwBzmpzE/xZZ02MTPWnog1WROcxqCbYsXbd13qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNYXABXR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971039; x=1780507039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzWYnpAQET1gYB4atKJQGlUAR+pzhAeLGi0G9UqQ4Dk=;
  b=LNYXABXRyG7aCU/ARV6fpDgaNbagPznXUvuVU9ulPgJHOKkOQb1U5jEw
   8i4md6Yj+A15nxt9RRJWu9Inw/q3dyvA8F0jSjWJp89eUOerv77qzRJL5
   UsMYFlfXJ7XnA49nzr9N8FDbNPEVavGVKbTUlRnU9zEB9ocHuNbgY6NCK
   GbzC3in38EoocpBc4+gVkwTScqHyVSnNewfX0PduhoMoPXxnjZuFIkPYc
   qwedYXxtTTzlxigpBgURXSU+BXbjaCTUwopPxZ2qxdMUUbS6hnOxBcOEB
   7yhjvhqWirFkqc9a8FQ/KxGCVF7fQPaEXkqkEk4EekHCqNJaGF0JZJdxp
   g==;
X-CSE-ConnectionGUID: pA+BTbklSOSIvNqRN8ffyA==
X-CSE-MsgGUID: ED5nJlQrTyOYThAEQjJQrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73556760"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73556760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:17:17 -0700
X-CSE-ConnectionGUID: qTegEwM6RsOaOT1fgSgmYg==
X-CSE-MsgGUID: 1me12H4oSvyuBF++ZkDrOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145546406"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2025 10:17:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	sdf@fomichev.me,
	sassmann@kpanic.de,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/6] iavf: iavf_suspend(): take RTNL before netdev_lock()
Date: Tue,  3 Jun 2025 10:17:02 -0700
Message-ID: <20250603171710.2336151-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
References: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Fix an obvious violation of lock ordering.
Jakub's [1] added netdev_lock() call that is wrong ordered wrt RTNL,
but the Fixes tag points to crit_lock being wrongly placed (by lockdep
standards).

Actual reason we got it wrong is dated back to critical section managed by
pure flag checks, which is with us since the very beginning.

[1] afc664987ab3 ("eth: iavf: extend the netdev_lock usage")

Fixes: 5ac49f3c2702 ("iavf: use mutexes for locking of critical sections")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6d7ba4d67a19..a77c72643528 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5596,22 +5596,27 @@ static int iavf_suspend(struct device *dev_d)
 {
 	struct net_device *netdev = dev_get_drvdata(dev_d);
 	struct iavf_adapter *adapter = netdev_priv(netdev);
+	bool running;
 
 	netif_device_detach(netdev);
 
+	running = netif_running(netdev);
+	if (running)
+		rtnl_lock();
+
 	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 
-	if (netif_running(netdev)) {
-		rtnl_lock();
+	if (running)
 		iavf_down(adapter);
-		rtnl_unlock();
-	}
+
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
 	netdev_unlock(netdev);
+	if (running)
+		rtnl_unlock();
 
 	return 0;
 }
-- 
2.47.1


