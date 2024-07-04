Return-Path: <netdev+bounces-109210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8E927609
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DF0282C4D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E51AB51A;
	Thu,  4 Jul 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEM++TN9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4A1AAE3B
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096243; cv=none; b=DSsQ6arkZRq30lg6V+14xpu2/bjmdjYHv+8mnOJPrFuYZzP/B5yBaTvzOkbA22YVyJI/GW6R6+LdtzSP+6BiO5Q4XRf+l9S02s3IWiZcB2DXWSOw5yRV0LdVGc7NEkPgks2Ev3yIi26+Ztyaqwj0sE1+7eRWwO5o/UIDblf7+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096243; c=relaxed/simple;
	bh=I3HHJCYyOawm3B2PrzYQZA6DulgXKucpF/TAE489InI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+wh7YlSGCFLVk1PLmswNFAE1p2Ca/dsrsb1aOzEgaR5RpGP3KssJ6TecDVBN3mnFonJtwp3RieKYBuloK5E1GHqiZ5V2MhWaJQp7P3+vf/TfoBKe2b4G5lEffU3k80EtE/ccLUhCqBLM81D/P3/uxPp7/aHYhVuehBbEbWUewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEM++TN9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720096241; x=1751632241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3HHJCYyOawm3B2PrzYQZA6DulgXKucpF/TAE489InI=;
  b=eEM++TN9so/75tjTH9I9qRfqkLx2WuvGL7Nidl/I0iTqRjb65k4RDA8Z
   fAI4LFEfEr8Ocnyl7Y4NF2ayOSRp0OdbOLE4ywAVHW1iaikg/zKCNGDkO
   59VCI6YrgfoSEXsnUVF8wZSFfyNBP+QuKLtIugApWBhbFC18eZTlNDRP1
   TmqLZpcLwKL1K/r7Ahsd8SG6zNgSEUv89sDfrIDmZIatqGQDt+0wsz3OD
   F35vcOepC21zemWZBT7uC32P2KWTFr9Hc5wZZjxY/Eeg81GWTcyj2ybnr
   gyMtpLdscQSuFYIFQvx83ys/DXygZGvmFJcsOO/vaGbB7XOpgrVxVMRg0
   A==;
X-CSE-ConnectionGUID: tfwHye/JSquRuDfcUMk9xg==
X-CSE-MsgGUID: uSqBCRtHQB29+tj5MrGtoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17484153"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17484153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 05:30:41 -0700
X-CSE-ConnectionGUID: FmGCh7V5Sz6kwpfPYzU94A==
X-CSE-MsgGUID: YnaiJZuTRFaitEcU+VGGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46550307"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.117.61])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2024 05:30:40 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v8 5/7] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Thu,  4 Jul 2024 14:26:53 +0200
Message-ID: <20240704122655.39671-6-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
References: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required to adopt x540 specific functions by E610 device.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
index b69a680..6ed360c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
+
+#ifndef _IXGBE_X540_H_
+#define _IXGBE_X540_H_
 
 #include "ixgbe_type.h"
 
@@ -17,3 +20,5 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_release_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_init_swfw_sync_X540(struct ixgbe_hw *hw);
 int ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw);
+
+#endif /* _IXGBE_X540_H_ */
-- 
2.43.0


