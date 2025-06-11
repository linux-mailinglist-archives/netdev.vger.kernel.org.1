Return-Path: <netdev+bounces-196673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23170AD5DBC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77E21BC1E1D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20DB2686B9;
	Wed, 11 Jun 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyXvf5jA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF281E1DE9
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665008; cv=none; b=Lj8zMGzl2nvEmU9ihnEbWA/DKKRMjH7MKjmh3C5WTglASmcB6TjHt7VOeDR+jVammWVq8EvbxQr2sdJmM5MJavFaqAYFIOAdkmsEm6spcvgQnRWnMd92+IP453aQvR8Myj4ujhWz2rQnp+GJFTEtmaTfZiWWPZTQ2zfvVO+jZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665008; c=relaxed/simple;
	bh=WcxoMfTw/AZgXpD+a4D0qIj9VN7Ndfm6hc8nY9UEvzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj/q3qtpAliJw2LHwzcoj2g0lkydh/yX0n22A8Myvn6cWglMzpr+onLcQ2NDRA2VCTY3/AIReGPh8AsvGz/Sf3CvpyIUIKgYZpfmfewc8JFUpYkgNvOvFLNSwBsG+KhwZY9k+94EpFxEaV8MD5EQR0HIX8r89BL9jdTMrueEwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyXvf5jA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665007; x=1781201007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WcxoMfTw/AZgXpD+a4D0qIj9VN7Ndfm6hc8nY9UEvzQ=;
  b=fyXvf5jAj0XrMhAxMQwJPtNB35qAiPtA0NdLrwRBFPQaCiQ7jr2OKUEo
   9UZox1IEcIK1lCyl3cipzqURwV04bAMd+ziSG8jpC9fVcrBMig4+0Wb7z
   xTrgL7uiAZu34kS8sYWOveJ9+ymGqqaBg69auyWKHQ8xyghQmbcRZuhvm
   lqsG21hxqcWtJ143LJ1tDcGfrPVH4RgT1dr4scEaLw0r4fxDLlKPAq+F8
   xpXVP+OPCiUDnE/Hi+Rmk5zdKQ7vshocJptabItNQsus2r3EX4Oae6Jpx
   iuZpXiWHQzGSPuq2Ni8e7FWhKpFVT6DZJa37BJw0YADUcs7UjFL1ZXmo3
   A==;
X-CSE-ConnectionGUID: kErnQ2LaTF66U80up7Oglw==
X-CSE-MsgGUID: ZTtRuRtfR/eyRnd8i7UhYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51042537"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51042537"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:03:25 -0700
X-CSE-ConnectionGUID: 8IH8G0S9Sj6TmlKYoK6CIg==
X-CSE-MsgGUID: kUv1bmVwTY6JOfTuqePHVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152418253"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 11:03:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	faizal.abdul.rahim@intel.com,
	chwee.lin.choong@intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 1/7] igc: move TXDCTL and RXDCTL related macros
Date: Wed, 11 Jun 2025 11:03:03 -0700
Message-ID: <20250611180314.2059166-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Move and consolidate TXDCTL and RXDCTL macros in preparation for
upcoming TXDCTL changes. This improves organization and readability.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 11 ++++++++++-
 drivers/net/ethernet/intel/igc/igc_base.h |  8 --------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 859a15e4ccba..25695eada563 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -487,10 +487,19 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
  */
 #define IGC_RX_PTHRESH			8
 #define IGC_RX_HTHRESH			8
+#define IGC_RX_WTHRESH			4
+/* Ena specific Rx Queue */
+#define IGC_RXDCTL_QUEUE_ENABLE		0x02000000
+/* Receive Software Flush */
+#define IGC_RXDCTL_SWFLUSH		0x04000000
+
 #define IGC_TX_PTHRESH			8
 #define IGC_TX_HTHRESH			1
-#define IGC_RX_WTHRESH			4
 #define IGC_TX_WTHRESH			16
+/* Ena specific Tx Queue */
+#define IGC_TXDCTL_QUEUE_ENABLE		0x02000000
+/* Transmit Software Flush */
+#define IGC_TXDCTL_SWFLUSH		0x04000000
 
 #define IGC_RX_DMA_ATTR \
 	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 6320eabb72fe..eaf17cd031c3 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -86,14 +86,6 @@ union igc_adv_rx_desc {
 	} wb;  /* writeback */
 };
 
-/* Additional Transmit Descriptor Control definitions */
-#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
-#define IGC_TXDCTL_SWFLUSH	0x04000000 /* Transmit Software Flush */
-
-/* Additional Receive Descriptor Control definitions */
-#define IGC_RXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Rx Queue */
-#define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
-
 /* SRRCTL bit definitions */
 #define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
 #define IGC_SRRCTL_BSIZEPKT(x)		FIELD_PREP(IGC_SRRCTL_BSIZEPKT_MASK, \
-- 
2.47.1


