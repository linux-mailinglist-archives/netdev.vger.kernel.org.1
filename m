Return-Path: <netdev+bounces-156486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB064A0681B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F407A2C11
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E3204F78;
	Wed,  8 Jan 2025 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ1joBND"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A76204C35
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374690; cv=none; b=NWlbszu61FU/2gTzNhT0dBBtvBLZzOnZnciQmDTD9fKMy9Hdapv36CawW9LGp8nG7mrzfNu4a1befVH0TUxHViZSOtYdeExeCErrESIEByGfyRSf4tog6Hmggz6hzSipH8bW2rSeWShVcTRhdelWSnBhejPYYffAGKUSomJrkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374690; c=relaxed/simple;
	bh=3bYbv/QdAt8WP+ti29nrJu1Jab8Tt6fGq6rXqxgaITQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ+vSZ4VXmUKWkGOvlsTxAzkUSdRJmz5e5gL168PNfSsvD/ENvMkWRMNzJJjSGxqlg78HEY9CwBy7LkVDdrRJJWKuKrlAWoibx2uVcWwFGZmmB/44Vd7qKbiK2REjSpK8xUDr6xJlkBSC5QD+rcuE8YS80DytF8t/54jiXOSQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ1joBND; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374689; x=1767910689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bYbv/QdAt8WP+ti29nrJu1Jab8Tt6fGq6rXqxgaITQ=;
  b=fJ1joBND7rG4+Wp/AuRCmikKoeIKmJJ2EG6hvNisx3FxbX6rgC064kjF
   02ysr5s7mu6PqIl47gbmvagDcKzgkpuq92hUv77xL2iaVSl1ZZT2r/Uja
   YnT9IjR4W/RncGnKDZ0y+K9OGcbB1eAN12GGc7eI3qZtx6Wzbifv6k8PE
   NHKE3dEhmEV7WOsFXR6HOoJg5u4ALdGSztgnrwGI1f6/W1aWw4Zx5ciGk
   1c83azbMfSE/66DebhFcxli979O8lI6mYwpY2Obk4tA7+T+OuPZlhW1EB
   ylRvy2nHi5/zBBTAx1fJwXUg7nidHz0ReUEhBelR770w+XYayPP484l3F
   w==;
X-CSE-ConnectionGUID: QeYebunRTA+HqAHdqFTRmg==
X-CSE-MsgGUID: NlXeF6BqQdyJaTu2nDGqgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384685"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:03 -0800
X-CSE-ConnectionGUID: +OsB1Ma2RT2VWpxbRufxTg==
X-CSE-MsgGUID: vUqBstOjRqu+NpjSjXlhTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545130"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	anton.nadezhdin@intel.com,
	przemyslaw.kitszel@intel.com,
	milena.olech@intel.com,
	arkadiusz.kubalewski@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 08/13] ice: use rd32_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
Date: Wed,  8 Jan 2025 14:17:45 -0800
Message-ID: <20250108221753.2055987-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_read_phy_tstamp_ll_e810 function repeatedly reads the PF_SB_ATQBAL
register until the TS_LL_READ_TS bit is cleared. This is a perfect
candidate for using rd32_poll_timeout. However, the default implementation
uses a sleep-based wait.

Add a new rd32_poll_timeout_atomic macro which is based on the non-sleeping
read_poll_timeout_atomic implementation. Use this to replace the loop
reading in the ice_read_phy_tstamp_ll_e810 function.

This will also be used in the future when low latency PHY timer updates are
supported.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_osdep.h  |  3 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 30 +++++++++------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
index b9f383494b3f..9bb343de80a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_osdep.h
+++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
@@ -26,6 +26,9 @@
 
 #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
 	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
+#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
+	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
+				 a, addr)
 
 #define ice_flush(a)		rd32((a), GLGEN_STAT)
 #define ICE_M(m, s)		((m ## U) << (s))
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 6f9d4dc82997..e9d3573e5606 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4858,32 +4858,28 @@ static int
 ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 {
 	u32 val;
-	u8 i;
+	int err;
 
 	/* Write TS index to read to the PF register so the FW can read it */
 	val = FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
 	wr32(hw, PF_SB_ATQBAL, val);
 
 	/* Read the register repeatedly until the FW provides us the TS */
-	for (i = TS_LL_READ_RETRIES; i > 0; i--) {
-		val = rd32(hw, PF_SB_ATQBAL);
-
-		/* When the bit is cleared, the TS is ready in the register */
-		if (!(FIELD_GET(TS_LL_READ_TS, val))) {
-			/* High 8 bit value of the TS is on the bits 16:23 */
-			*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
+	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
+				       !FIELD_GET(TS_LL_READ_TS, val),
+				       10, TS_LL_READ_TIMEOUT);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
+		return err;
+	}
 
-			/* Read the low 32 bit value and set the TS valid bit */
-			*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
-			return 0;
-		}
+	/* High 8 bit value of the TS is on the bits 16:23 */
+	*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
 
-		udelay(10);
-	}
+	/* Read the low 32 bit value and set the TS valid bit */
+	*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
 
-	/* FW failed to provide the TS in time */
-	ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
-	return -EINVAL;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1cee0f1bba2d..7a29faa593cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -689,7 +689,7 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define BYTES_PER_IDX_ADDR_L		4
 
 /* Tx timestamp low latency read definitions */
-#define TS_LL_READ_RETRIES		200
+#define TS_LL_READ_TIMEOUT		2000
 #define TS_LL_READ_TS_HIGH		GENMASK(23, 16)
 #define TS_LL_READ_TS_IDX		GENMASK(29, 24)
 #define TS_LL_READ_TS_INTR		BIT(30)
-- 
2.47.1


