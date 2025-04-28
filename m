Return-Path: <netdev+bounces-186338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A26A9E7F5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2235916F2EE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F71D61B7;
	Mon, 28 Apr 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHxiehA+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143D1D54FE;
	Mon, 28 Apr 2025 06:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820214; cv=none; b=CmiXY6gOeq+vGTAtXQxzM5DyLegmN4iUa45cf4W1mCtHnl4pZkf8yqJDAaZR5IDGXWIJRma7mXeK/INkWnN7LZq6z3lSRmyZoQyr/P2PNXnf2Vyb0p2oeJ452IV+t/DTtl4477PUYQYdUAxZAxL7L70fEEoKyomhfOOyM85grao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820214; c=relaxed/simple;
	bh=pS4q/Yjxbmtc0fCQ3ldogllC9oASKz4SUbDlI70Yroo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPuFzs+D98kR/r422bebTdtFDDaCMUT/SMjHmZn/XSR6OM3na+NxMvjVftxO+66jqYWJizAKsLhVMSxdTJ+AsRHLvW5Wo01fbVGRsAqNuFpjWnc3pe3TpoTMos4ZFOuHczy9aYpKD2EGHaxiO/d4bt2XnUVtjBh5H2GQhZxeC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHxiehA+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820214; x=1777356214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pS4q/Yjxbmtc0fCQ3ldogllC9oASKz4SUbDlI70Yroo=;
  b=cHxiehA+NYkhg0le5XKv1mlbs6jWeCUVuuigvTUf414bHgmddecU6CAi
   dDI5VqGRbOQyD1SHnBdeTKa0kJ1/EgkH9yv8Kfk8GXfQmSA7aoG7M7tHb
   l7aQuGeDQuj0/P3V7CYIyUSwdjs2cR3hbhL01R5aljiyru1zoo3zQXF/l
   edfS2F9b0pHQ1XifaDfs+kZcQnQgn5tbVsCWYksJjZUojy+RBiE+TN9Vu
   2focc2rp3MYsCdVHkMNxUNrjSPzk9EvL1FuXlQppm8nizOS3XBbHHetdU
   n0ZIH24hcvIjAZt1hCEm0wMgtzK8eiTEEBzmayxxvntrDGMIy8ErE6r9x
   w==;
X-CSE-ConnectionGUID: sR3zcGrnR++mCDBoQtM4Ew==
X-CSE-MsgGUID: STHZL5aQTg2eY/a3AcectA==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51064613"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51064613"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:03:34 -0700
X-CSE-ConnectionGUID: MNq7LqucQVCwYbZseCh3PQ==
X-CSE-MsgGUID: kKBHL5XaQna9TZ6tL/LZEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133340764"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2025 23:03:31 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v1 3/8] igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
Date: Mon, 28 Apr 2025 02:02:20 -0400
Message-Id: <20250428060225.1306986-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
References: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor TXDCTL macro handling to use FIELD_PREP and GENMASK macros.
This prepares the code for adding a new TXDCTL priority field in an
upcoming patch.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 16 +++++++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c |  6 ++----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index bc37cc8deefb..4e44304b0608 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -487,16 +487,22 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
  */
 #define IGC_RX_PTHRESH			8
 #define IGC_RX_HTHRESH			8
-#define IGC_TXDCTL_PTHRESH		8
-#define IGC_TXDCTL_HTHRESH		1
 #define IGC_RX_WTHRESH			4
-#define IGC_TXDCTL_WTHRESH		16
 
+#define IGC_TXDCTL_PTHRESH_MASK		GENMASK(4, 0)
+#define IGC_TXDCTL_HTHRESH_MASK		GENMASK(12, 8)
+#define IGC_TXDCTL_WTHRESH_MASK		GENMASK(20, 16)
+#define IGC_TXDCTL_QUEUE_ENABLE_MASK	GENMASK(25, 25)
+#define IGC_TXDCTL_SWFLUSH_MASK		GENMASK(26, 26)
+
+#define IGC_TXDCTL_PTHRESH(x)		FIELD_PREP(IGC_TXDCTL_PTHRESH_MASK, (x))
+#define IGC_TXDCTL_HTHRESH(x)		FIELD_PREP(IGC_TXDCTL_HTHRESH_MASK, (x))
+#define IGC_TXDCTL_WTHRESH(x)		FIELD_PREP(IGC_TXDCTL_WTHRESH_MASK, (x))
 /* Additional Transmit Descriptor Control definitions */
 /* Ena specific Tx Queue */
-#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000
+#define IGC_TXDCTL_QUEUE_ENABLE		FIELD_PREP(IGC_TXDCTL_QUEUE_ENABLE_MASK, 1)
 /* Transmit Software Flush */
-#define IGC_TXDCTL_SWFLUSH	0x04000000
+#define IGC_TXDCTL_SWFLUSH		FIELD_PREP(IGC_TXDCTL_SWFLUSH_MASK, 1)
 
 #define IGC_RX_DMA_ATTR \
 	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 725c8f0b9f3d..86716fabf6a9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -749,11 +749,9 @@ static void igc_configure_tx_ring(struct igc_adapter *adapter,
 	wr32(IGC_TDH(reg_idx), 0);
 	writel(0, ring->tail);
 
-	txdctl |= IGC_TXDCTL_PTHRESH;
-	txdctl |= IGC_TXDCTL_HTHRESH << 8;
-	txdctl |= IGC_TXDCTL_WTHRESH << 16;
+	txdctl |= IGC_TXDCTL_PTHRESH(8) | IGC_TXDCTL_HTHRESH(1) |
+		  IGC_TXDCTL_WTHRESH(16) | IGC_TXDCTL_QUEUE_ENABLE;
 
-	txdctl |= IGC_TXDCTL_QUEUE_ENABLE;
 	wr32(IGC_TXDCTL(reg_idx), txdctl);
 }
 
-- 
2.34.1


