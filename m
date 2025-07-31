Return-Path: <netdev+bounces-211193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6CAB171B1
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E853BECB0
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63654241671;
	Thu, 31 Jul 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsuPH4fW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEC2C326B
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966925; cv=none; b=PvuV1v9z5giTBaDNVEO83YO6evt9oJa8kdtqFpwjtfBsEIuRFbs7LXe5/C4QTofvZavaca0XvDZNpM/NYwzajSgoLoO+bpWzwVGRBraudzgvi3mz3fSMiiX4PnlUpXB1kbmEtyNRsoZ6Ryuk/TW+Dnw+7sRVissy7oGkUKqo9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966925; c=relaxed/simple;
	bh=LU7OIycQkBXRbFm7D7D3e62DNysA0g86zCh78MKoh6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqG5TZQnZm03unJF9J/9iCV/Wu4muGKZeoOHCNPuuhhh5GYpAe8k6D7apHQBsmErMPnfOxEBgkh1XVRFMV2H8pxcpU07m3H2vDvsAvWEmAooT9Hn3VGGCjfIUJHgPBNoAHAXPYQLs5A5/O4d3IzG6lmEmv3lYKAIyL0H9f6HDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsuPH4fW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753966923; x=1785502923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LU7OIycQkBXRbFm7D7D3e62DNysA0g86zCh78MKoh6o=;
  b=BsuPH4fW9OsxjsnySHB4NGtyAAnE9avhDcwW8P/I/4Pk53Bj+jS6ENvO
   cYUX5pUzUQlY5XqsQhhwXoQO4uP5wuglJG448SDKh1Bq8ajHwV0osNLTf
   NT6jPMfKGtqFalpLhD9rrytNlre49My+Qo9yfs8BQDZG+Sht8TgOSYvr4
   Ef3OdBZ8ft/k7iwR72yRiEY64nynYPMiSj9m+isqwzHlFP2y/H49e8uG8
   VjYlXZ73uXYT3G4Ei8HcUQtT4tIo2Bt331L/vRzV/8jgqiqlUt4M+XcLQ
   qQmS60lISpCNtwnfjs1TNnDww/3aPiHkWgkwjyda/Qec6/SgUyMqe83lO
   A==;
X-CSE-ConnectionGUID: 4W+N7zAPQTuSDTD4fOrlXw==
X-CSE-MsgGUID: xLo4pYxCSOiZcow3fnc/Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="73747653"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="73747653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 06:02:03 -0700
X-CSE-ConnectionGUID: I62m967pRCmlj9rLsCYUFQ==
X-CSE-MsgGUID: ZHsetmaXTeq2oIeEZdLEmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="186940781"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 31 Jul 2025 06:02:00 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v2] ixgbe: fix ixgbe_orom_civd_info struct layout
Date: Thu, 31 Jul 2025 14:45:33 +0200
Message-Id: <20250731124533.1683307-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current layout of struct ixgbe_orom_civd_info causes incorrect data
storage due to compiler-inserted padding. This results in issues when
writing OROM data into the structure.

Add the __packed attribute to ensure the structure layout matches the
expected binary format without padding.

Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: use get_unaligned_le32() per Simon's suggestion
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 71ea25de1bac..754c176fd4a7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3123,7 +3123,7 @@ static int ixgbe_get_orom_ver_info(struct ixgbe_hw *hw,
 	if (err)
 		return err;
 
-	combo_ver = le32_to_cpu(civd.combo_ver);
+	combo_ver = get_unaligned_le32(&civd.combo_ver);
 
 	orom->major = (u8)FIELD_GET(IXGBE_OROM_VER_MASK, combo_ver);
 	orom->patch = (u8)FIELD_GET(IXGBE_OROM_VER_PATCH_MASK, combo_ver);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 09df67f03cf4..38a41d81de0f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -1150,7 +1150,7 @@ struct ixgbe_orom_civd_info {
 	__le32 combo_ver;	/* Combo Image Version number */
 	u8 combo_name_len;	/* Length of the unicode combo image version string, max of 32 */
 	__le16 combo_name[32];	/* Unicode string representing the Combo Image version */
-};
+} __packed;
 
 /* Function specific capabilities */
 struct ixgbe_hw_func_caps {
-- 
2.31.1


