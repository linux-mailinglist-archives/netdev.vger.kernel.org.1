Return-Path: <netdev+bounces-144552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D89C7BB5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C791F21FE5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126882076C5;
	Wed, 13 Nov 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTsV8duY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD32071EE
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524089; cv=none; b=GgEH6O9gDEmo+ThKtQ6JJFZdKXS3RSxb84KAyS7928mgMF2TfrQAoSXdeEOqOGWPy7aQkPpkS3plIRlTa4jnjTliNHstb6bucOMcnwtCkN++mI9WyA1+tC6Ok1B6KnmT0ROFYNqKj9Ye5ilqDBoInZ1gi1tPs8/IVmXapID9Vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524089; c=relaxed/simple;
	bh=+qkYZqfvjzxp0CFLFUzJYCAAr85X49pQUa1hWU8bHvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8HNTtEOlCj/AsSxPlhMOj3T6j/VVeWCkA36qevgsvvRrIUvhGOkvBwyrHFmi93s1DW5Mrntq+ZoQpSExZ+dXDiER3M2WdG89SpHm2dcSjFMmKwHyuqsBoMhn2etyNKzeeWsG/IYd6jq88JueUJUYl/RO8DNqSkhObQfZqPNe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTsV8duY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524088; x=1763060088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+qkYZqfvjzxp0CFLFUzJYCAAr85X49pQUa1hWU8bHvI=;
  b=GTsV8duY0P7cTWUqX/CLkDrGXlBGqy5QsGcKmIKXdxKPfEWgaS7wk8YM
   ioot0uynSdUSNE5U9yeQsRvULVs0bCanbtsyRLXsdiwSq4sj0bcgbi/b6
   ptsmerwWF3pRABAOPj84jzXb7e7VaGhaMhKcgtyhXmFm+xHnhsEiu9nIt
   jla3K0oQIxdcZXloe9Ww9zWidSzNkk8mVQiYDhCQZy/frnHU2ih8RB8jV
   m3uq44ajV8fIOq6xjXZ5s8SlmsZoClkYR8Z35Zny/lFX+ys1eTLk/Xrh9
   pIevDQrV/8MTPl9911AjN2yvLqxwh+I6R1o27ftoxXlR7Y7golYtmXD0U
   A==;
X-CSE-ConnectionGUID: w3zRXjYdRa+7gSLy3mOf8g==
X-CSE-MsgGUID: 3Nt6FyPfRZeK2Yppq4w+uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589549"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:43 -0800
X-CSE-ConnectionGUID: TZ0XOjyKQwSqdX0RNYGd8w==
X-CSE-MsgGUID: UoRcWsekTfiJJTEnxBrK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520770"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next v2 13/14] igbvf: remove unused spinlock
Date: Wed, 13 Nov 2024 10:54:28 -0800
Message-ID: <20241113185431.1289708-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wander Lairson Costa <wander@redhat.com>

tx_queue_lock and stats_lock are declared and initialized, but never
used. Remove them.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 3 ---
 drivers/net/ethernet/intel/igbvf/netdev.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index 6ad35a00a287..ca6e44245a7b 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -169,8 +169,6 @@ struct igbvf_adapter {
 	u16 link_speed;
 	u16 link_duplex;
 
-	spinlock_t tx_queue_lock; /* prevent concurrent tail updates */
-
 	/* track device up/down/testing state */
 	unsigned long state;
 
@@ -220,7 +218,6 @@ struct igbvf_adapter {
 	/* OS defined structs */
 	struct net_device *netdev;
 	struct pci_dev *pdev;
-	spinlock_t stats_lock; /* prevent concurrent stats updates */
 
 	/* structs defined in e1000_hw.h */
 	struct e1000_hw hw;
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 925d7286a8ee..02044aa2181b 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1656,12 +1656,9 @@ static int igbvf_sw_init(struct igbvf_adapter *adapter)
 	if (igbvf_alloc_queues(adapter))
 		return -ENOMEM;
 
-	spin_lock_init(&adapter->tx_queue_lock);
-
 	/* Explicitly disable IRQ since the NIC can be in any state. */
 	igbvf_irq_disable(adapter);
 
-	spin_lock_init(&adapter->stats_lock);
 	spin_lock_init(&adapter->hw.mbx_lock);
 
 	set_bit(__IGBVF_DOWN, &adapter->state);
-- 
2.42.0


