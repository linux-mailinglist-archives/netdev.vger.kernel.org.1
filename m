Return-Path: <netdev+bounces-133365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479CE995BC0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F246D1F250D6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A22219493;
	Tue,  8 Oct 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0t3hhtZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEEA218D84
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430495; cv=none; b=uEDsg7iXLNBYSDaB57hku0Jf/RbH/QNJMsThWZMYPBnq2c/5/E4BHZFpOW94nEYTTv0ynknwWd/jvWepVsyIgFNnn1BZggaOah7z6+9wVCJF4YXRyZZUdeEs/cK423ybndIwQQKmw45v5NIDnqzVaA4OyDEFn3NHbMgxhcZK2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430495; c=relaxed/simple;
	bh=03IHojh6ZLY1Fn80mqlzdo8+VyEkmGkgh1HH4eAfHHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW+7Ayc3U9NjpKcauhYkNYJS+DCq41q8bsFsym78SF5s39lhpG9VRoIAMRHpj8uF80iOKmnobS4LokYZeSY6KlWOuMRFDDTstpiQmqS9Kp3ItMnIfGirAX0uRsBkcHHd8re5btaGbYHre17j8q1YvOuGXWvvj8EtqTN5dbr0/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0t3hhtZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430494; x=1759966494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03IHojh6ZLY1Fn80mqlzdo8+VyEkmGkgh1HH4eAfHHw=;
  b=B0t3hhtZ7MSa4pZOu8DFHcmwVtP0xHCTdBcoN80xyzLSTK4t0clM7p4I
   qKZdbuVdKDODcY7bWEG2MNHInfGnAOH7kMTYb3vmi6xQeg+QVeh/Gj+Yl
   yWZeuyfUUKER9nEcpD8Wny86IJjTawZ91Q5/JKX0bWnlxlqoHiKvijHty
   V+wIU4nVn9eHTN024YXOhT62oEId+6hUy9E+oms3buEs8R3R3u+dcjbCB
   u3qatsKPwj4S9OZwoW3BNhrbUbczxClpgH/stfiC2kltqsGoQpW7ftLpv
   4hisf+vNEvjZ9qjqJz+qGx8JcJi58jQ+Su+AZhKDjZqV0ZiPUVDIMozP6
   Q==;
X-CSE-ConnectionGUID: D7JV2z2STty73enwmRgHIg==
X-CSE-MsgGUID: od1711dWSqCCcyPrBAToPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779912"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779912"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:50 -0700
X-CSE-ConnectionGUID: uMFKAM8+SLK1A3OKJSZl/w==
X-CSE-MsgGUID: R8eaU9aCRzm40Q2c/zYEaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794203"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	anthony.l.nguyen@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 09/12] igb: Cleanup unused declarations
Date: Tue,  8 Oct 2024 16:34:35 -0700
Message-ID: <20241008233441.928802-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

e1000_init_function_pointers_82575() is never implemented and used since
commit 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver").
And commit 9835fd7321a6 ("igb: Add new function to read part number from
EEPROM in string format") removed igb_read_part_num() implementation.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.h | 1 -
 drivers/net/ethernet/intel/igb/e1000_nvm.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.h b/drivers/net/ethernet/intel/igb/e1000_mac.h
index 6e110f28f922..529b7d18b662 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.h
@@ -63,6 +63,5 @@ enum e1000_mng_mode {
 
 #define E1000_MNG_DHCP_COOKIE_STATUS_VLAN	0x2
 
-void e1000_init_function_pointers_82575(struct e1000_hw *hw);
 
 #endif
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.h b/drivers/net/ethernet/intel/igb/e1000_nvm.h
index 091cddf4ada8..4f652ab713b3 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.h
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.h
@@ -7,7 +7,6 @@
 s32  igb_acquire_nvm(struct e1000_hw *hw);
 void igb_release_nvm(struct e1000_hw *hw);
 s32  igb_read_mac_addr(struct e1000_hw *hw);
-s32  igb_read_part_num(struct e1000_hw *hw, u32 *part_num);
 s32  igb_read_part_string(struct e1000_hw *hw, u8 *part_num,
 			  u32 part_num_size);
 s32  igb_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data);
-- 
2.42.0


