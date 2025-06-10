Return-Path: <netdev+bounces-196243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16426AD4028
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750F87A8393
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C626245008;
	Tue, 10 Jun 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7qPbuBF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918B244683
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575640; cv=none; b=TCyvjrPyWl6FDUFfqqQibRhKV7bcq+KA9+B6yeXtK+lNNdMPL02QOHNYO5YNwrPkYO/td+NgS7++dnEbjrk6qYR9gql9MBTiZ6cbCFzjuFsuF31Eezs5ZO3R/6P592Or2ycLnHdLri+hOkgRrUKwUIiaq2zTqLxAmN5T7Ekzlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575640; c=relaxed/simple;
	bh=dK8QU8UHnRJP//mFTeqvarUIGFFppKBlM8Aa6g18raA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNPACbQucknuRRkV+UAdIOfJEkITWDIW/H4HCleEXaGV6VYuGT3iHq6PsQX7EqBKqczHeAkgvXQ7caxM1NiezSUaId0jpm0+0XVBGdJfrlHrIkVyKjZ9IcMpXmffMl98F8S6OtJf4A2AybNHVms5lZyYpxry2YzcS6ko6pqQ+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7qPbuBF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749575638; x=1781111638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dK8QU8UHnRJP//mFTeqvarUIGFFppKBlM8Aa6g18raA=;
  b=P7qPbuBF1+ILXlYbIHXcVjLnRsz4tJiDLmHcZtSXuoGY5c8fm8t4m5hL
   W5hqNyOOhh/VKUro06WeuFQVB6SZDzBiWjyHp5kwWhRL0u+OgMiW3w2ZS
   sWhw6CEttPqdxjemG+7IV4F/MrVko9CndOtNQ4v5iTSTe02ycBW6lS9u+
   Wp8x5PFfDRTXlivYN8ULQ+sUTPwLWwoOAu2vgixQ2I28lX6kHLuaUECo6
   XWEwU4aG3btUtFbKVdvzuX6XhYXmLKM/ts7ZWF806bHBgLZ8oPA1tAwNF
   M+BMsPCUoQGqn85D4gykJN7NLnqcrtN9BCO6s6AjpztCs/vh55y+o1tU3
   g==;
X-CSE-ConnectionGUID: wOtSZS2qTyevC3xdDSyD0Q==
X-CSE-MsgGUID: RmL7TLY8TQ26LzuQDJEd9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51554678"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51554678"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:13:54 -0700
X-CSE-ConnectionGUID: xofe7KcEQ7mNTsq+GpZhLA==
X-CSE-MsgGUID: wmF7yNC1TsKDPH6Z5frmUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147850449"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 10:13:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	anthony.l.nguyen@intel.com,
	stfomichev@gmail.com,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	John <john.cs.hey@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 5/5] e1000: Move cancel_work_sync to avoid deadlock
Date: Tue, 10 Jun 2025 10:13:45 -0700
Message-ID: <20250610171348.1476574-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
References: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

Previously, e1000_down called cancel_work_sync for the e1000 reset task
(via e1000_down_and_stop), which takes RTNL.

As reported by users and syzbot, a deadlock is possible in the following
scenario:

CPU 0:
  - RTNL is held
  - e1000_close
  - e1000_down
  - cancel_work_sync (cancel / wait for e1000_reset_task())

CPU 1:
  - process_one_work
  - e1000_reset_task
  - take RTNL

To remedy this, avoid calling cancel_work_sync from e1000_down
(e1000_reset_task does nothing if the device is down anyway). Instead,
call cancel_work_sync for e1000_reset_task when the device is being
removed.

Fixes: e400c7444d84 ("e1000: Hold RTNL when e1000_down can be called")
Reported-by: syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/683837bf.a00a0220.52848.0003.GAE@google.com/
Reported-by: John <john.cs.hey@gmail.com>
Closes: https://lore.kernel.org/netdev/CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com/
Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..d8595e84326d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -477,10 +477,6 @@ static void e1000_down_and_stop(struct e1000_adapter *adapter)
 
 	cancel_delayed_work_sync(&adapter->phy_info_task);
 	cancel_delayed_work_sync(&adapter->fifo_stall_task);
-
-	/* Only kill reset task if adapter is not resetting */
-	if (!test_bit(__E1000_RESETTING, &adapter->flags))
-		cancel_work_sync(&adapter->reset_task);
 }
 
 void e1000_down(struct e1000_adapter *adapter)
@@ -1266,6 +1262,10 @@ static void e1000_remove(struct pci_dev *pdev)
 
 	unregister_netdev(netdev);
 
+	/* Only kill reset task if adapter is not resetting */
+	if (!test_bit(__E1000_RESETTING, &adapter->flags))
+		cancel_work_sync(&adapter->reset_task);
+
 	e1000_phy_hw_reset(hw);
 
 	kfree(adapter->tx_ring);
-- 
2.47.1


