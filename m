Return-Path: <netdev+bounces-203901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F2AF7F51
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30CC541D54
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEAF2F2C73;
	Thu,  3 Jul 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWV6S3Wi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092D2F2C4F
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564576; cv=none; b=osz2Ma3XErZczB8nQGTE53oZxi2mNud7YBX966c9BBoP1XoUYzyxT2h684jEU8cfPMZj8sqRn9vJcFVwSloPnX6m5B17d4m18EpRcEiKRNX1UbOaFy5n/+3HSLVAdaiGdE5xdkIaUoxqToGF5+KsDVCJZ0+1u1O77Z4Ikjbj/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564576; c=relaxed/simple;
	bh=egC1CPmD+VczhvFaUjd8DQY/hrOlG7M4x0+BmKvLsn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIiM9hgWQsCGn8Jb4YdpPKfwR5rXyaXAxHfIR8NGx9WHdbUOqgXXlGTSMPEXMct+e++LBej1h8AP9BZvqPX2PtrUegMAGm9dS/mYgQKV7po1VdROGsnjKnuHW0oRccnI/P+8ouSVg5zrAcXS2dyyVSknmzWJ1B+q45WtBFDKtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWV6S3Wi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564576; x=1783100576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egC1CPmD+VczhvFaUjd8DQY/hrOlG7M4x0+BmKvLsn0=;
  b=EWV6S3WifprhvNGFIi9nrpT5JImp9AQ9QvYPudyR0C18IXHScShv6H44
   T9knz5yAyIecOsTluCxXKwrH4fQoSCsYnFROAmzqkV+ebbcoSmsvtFcbK
   2/+vFqWy2Yya+hb98Jr5qX+I8fD8Byrno+8JAjRHlzenAq7kRDIWbI4CM
   /liJ2W16YArI8NtcG/0OVfmJW7i2k1pB+OAcLIfu7GgAOhwbd6jutzM9k
   Qe2rGLAB3KXVSeLTJLlby6gsu5F8nUW8bVEu5Si6V9t9EYwV5zxrGn+ox
   +eQBhDtmSJiRYLJO5TyOge+BWKQpApoO4uqFSHXKS4lBSeZSsFo8s15Jy
   A==;
X-CSE-ConnectionGUID: j6UPIAFASQCzIF30e0hPyg==
X-CSE-MsgGUID: xqW4060iTg+0boswq252RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767970"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767970"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:53 -0700
X-CSE-ConnectionGUID: kq9JIzE+TsGLhgXhFWbEyw==
X-CSE-MsgGUID: AxmTUSPmSK2wbYy6wtSS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997931"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 11/12] igbvf: remove unused interrupt counter fields from struct igbvf_adapter
Date: Thu,  3 Jul 2025 10:42:38 -0700
Message-ID: <20250703174242.3829277-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

Remove `int_counter0` and `int_counter1` from struct igbvf_adapter since
they are only incremented in interrupt handlers igbvf_intr_msix_rx() and
igbvf_msix_other(), but never read or used anywhere in the driver.

Note that igbvf_intr_msix_tx() does not have similar counter increments,
suggesting that these were likely overlooked during development.

Eliminate the fields and their unnecessary accesses in interrupt
handlers.

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 2 --
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index ca6e44245a7b..ba9c3fee6da7 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -238,8 +238,6 @@ struct igbvf_adapter {
 	int int_mode;
 	u32 eims_enable_mask;
 	u32 eims_other;
-	u32 int_counter0;
-	u32 int_counter1;
 
 	u32 eeprom_wol;
 	u32 wol;
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index e55dd9345833..aed9162afd38 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -855,8 +855,6 @@ static irqreturn_t igbvf_msix_other(int irq, void *data)
 	struct igbvf_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
-	adapter->int_counter1++;
-
 	hw->mac.get_link_status = 1;
 	if (!test_bit(__IGBVF_DOWN, &adapter->state))
 		mod_timer(&adapter->watchdog_timer, jiffies + 1);
@@ -899,8 +897,6 @@ static irqreturn_t igbvf_intr_msix_rx(int irq, void *data)
 	struct net_device *netdev = data;
 	struct igbvf_adapter *adapter = netdev_priv(netdev);
 
-	adapter->int_counter0++;
-
 	/* Write the ITR value calculated at the end of the
 	 * previous interrupt.
 	 */
-- 
2.47.1


