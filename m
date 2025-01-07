Return-Path: <netdev+bounces-156008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0922A049CD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F20C166C4D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39D18A6C0;
	Tue,  7 Jan 2025 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO1Dmut6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628311F4282
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276526; cv=none; b=bxn+SBlSvSUUtuee8KWeQE0/QxyXSBcK0adzrj+ZdhraMLsORQU057hyciz0GBWMZ3nncBqgFicElGBkv+z/fG+GFnXb18+JL2X3Sxjbgj+EEJ7ElgnAi9eNkFDjoXKkeXPGzc0PjAyZH+OTOPq0rhXd603/Nurhx8tUk3HZAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276526; c=relaxed/simple;
	bh=gQwwIBkr0ZPm2XmuCz6vqYL8nnkBSU8T1YrWDPxGU5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fop9O4+3jtCPWt3jxYD7vUIx+Ia3lBqmu7kH5XZioCGaFJuWPSvCq0pamUP1Mg+cAQMUAczPQlraktHxLEtNnzTV5+SOnE+xY8wahdtTR4kfG5Enq3DSv9uvOeoirsh8F2EJMbAQgehfvtAvRcCI7wDe2XZ1n1DCEfQqi5R7sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO1Dmut6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736276523; x=1767812523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQwwIBkr0ZPm2XmuCz6vqYL8nnkBSU8T1YrWDPxGU5c=;
  b=TO1Dmut6aA2xUBR0Jo+Z+x+uoopGlAybuv7QLrPSEHX3aBMQEta/Jo+3
   1pB6LMk0LS9jR9DLQF34gY7RXshcNIDfIuAAkaboeiVV/8fWCE41SXRKN
   j4B0SCxQGEFfM7b+OyFUP3TaHER/ivxOaHuXLjC1vLtSo+SnYJk6U+j8M
   qNje2qQkC8WPGyJQZvveCV/SmnsRfoehWuBYP+oiRAStUDpoCNsZ0gWRY
   eTset9JvyUQM8/OnANYs9L1Yxz2khLmVmqXikvDJLBg+kjOS5XT55Ub7D
   SEqLomFFMr9FUysn33rVcp5qnjQYqVaSK2XqUropAUkJjNjs9YIiUd9eQ
   A==;
X-CSE-ConnectionGUID: /SNdXsrXTT+kOieTDKgDMQ==
X-CSE-MsgGUID: a7+FyTcUSWaJ36azFBe72g==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="24083647"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="24083647"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:02:00 -0800
X-CSE-ConnectionGUID: zABGl+peRGiZqSKCTHwVuA==
X-CSE-MsgGUID: FVfalpHWSz+PNCiKvUWfDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="133709298"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2025 11:02:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: En-Wei Wu <en-wei.wu@canonical.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 3/3] igc: return early when failing to read EECD register
Date: Tue,  7 Jan 2025 11:01:47 -0800
Message-ID: <20250107190150.1758577-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: En-Wei Wu <en-wei.wu@canonical.com>

When booting with a dock connected, the igc driver may get stuck for ~40
seconds if PCIe link is lost during initialization.

This happens because the driver access device after EECD register reads
return all F's, indicating failed reads. Consequently, hw->hw_addr is set
to NULL, which impacts subsequent rd32() reads. This leads to the driver
hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
prevents retrieving the expected value.

To address this, a validation check and a corresponding return value
catch is added for the EECD register read result. If all F's are
returned, indicating PCIe link loss, the driver will return -ENXIO
immediately. This avoids the 40-second hang and significantly improves
boot time when using a dock with an igc NIC.

Log before the patch:
[    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
[    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
[   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
[   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
[   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
[   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity

Log after the patch:
[    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
[    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
[    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity

Fixes: ab4056126813 ("igc: Add NVM support")
Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 9fae8bdec2a7..1613b562d17c 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
 	u32 eecd = rd32(IGC_EECD);
 	u16 size;
 
+	/* failed to read reg and got all F's */
+	if (!(~eecd))
+		return -ENXIO;
+
 	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
 
 	/* Added to a constant, "size" becomes the left-shift value
@@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 
 	/* NVM initialization */
 	ret_val = igc_init_nvm_params_base(hw);
+	if (ret_val)
+		goto out;
 	switch (hw->mac.type) {
 	case igc_i225:
 		ret_val = igc_init_nvm_params_i225(hw);
-- 
2.47.1


