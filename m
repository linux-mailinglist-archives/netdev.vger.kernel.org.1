Return-Path: <netdev+bounces-142121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3579BD882
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B551F22378
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0362170BA;
	Tue,  5 Nov 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkN7HR1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A5216E00
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845449; cv=none; b=labI08gIuqz3L9LbcjcfMf/ahNcqhrRMmEr8WyL8V0ocwPaZfbppN6zxv9yjsZF4ATdjNtb52iKP3UU+Nk7RmGSTqvo3dzaGIbhSbOuca/BjnpIlOr+bHg2PiM0/PQO62nTJnl8u9dAkE2vBjEAWhYiStBrorrQInlO/d1hEXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845449; c=relaxed/simple;
	bh=+qkYZqfvjzxp0CFLFUzJYCAAr85X49pQUa1hWU8bHvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2dzRiX11Z0H6+eZcnB/SRW0Jf31mLc3BChpQ7TtJVJFGIRRkmHCGeNX43Z8qxguj+YkUWI5OPkz3K2nseskCtE69dWr+SDnLvWPFboRy1vOj3KQ3XZT4VW+AzfHzxSaFmKPtr0x8atVRV3m+3RCr9047bSZiEunnIGZmTANLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkN7HR1Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845448; x=1762381448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+qkYZqfvjzxp0CFLFUzJYCAAr85X49pQUa1hWU8bHvI=;
  b=lkN7HR1QJ/Kqa15KiQw/1+31x2iPi4qWT5phgmGFKecs27yTvqAsDP9X
   i7qy8vi/825lFYEVzFZ3nopBinPbmRFM9yXlw2tsoYXqHLuDlbMq3yTPi
   hbc9kNQfWAA3EhFa1V0dylyuvrLWZrPDPY0+Y64KKL9kY/rNqMaCcJSfE
   XQbIHv9JL16fnTaTCpWKgrHdzmJr2FJA58BS/bk4I8hhsR1vT4lTRCBE1
   jbbO3oZn6x3buSaOegIuHxGWB/qFvIUolsyZY851+d5LhsV1cBbyfqjih
   yxhO0UH/EJqeZPTHLlJsjKlpf9trmpu6E1GyWtLTN5esg5tybAkhA83ax
   w==;
X-CSE-ConnectionGUID: DXMAYzjuQKqbJkwu47kiAg==
X-CSE-MsgGUID: TY1oJ3IaRe6lARsuTvfjjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314334"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314334"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:03 -0800
X-CSE-ConnectionGUID: cHTkNZjaQqyP9WgUoVkCXg==
X-CSE-MsgGUID: Dyl0Ma0sSUKOo01GhbEnlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322477"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:02 -0800
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
Subject: [PATCH net-next 14/15] igbvf: remove unused spinlock
Date: Tue,  5 Nov 2024 14:23:48 -0800
Message-ID: <20241105222351.3320587-15-anthony.l.nguyen@intel.com>
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


