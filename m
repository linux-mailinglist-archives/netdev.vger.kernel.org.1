Return-Path: <netdev+bounces-186336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F142DA9E7EA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F05E3B84BD
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CE31C6FE8;
	Mon, 28 Apr 2025 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T47E7lZu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1C1C2324;
	Mon, 28 Apr 2025 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820208; cv=none; b=B0z0qCpEXXEoEd/q67eVSPsrbnzaFYDgdYy226I0DCCNBP6hfkP6x4DaiPs3H6tLbtcLgI0iyWpfe9pdDvdflaKIbmdGMjbBXdaQ7xP5iEMR/CfL4jKE129cyOIIZcHHpZCXaeH51FN9OorzcVkuPIQ3H9dogGCUwEUcg3gICSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820208; c=relaxed/simple;
	bh=4bGpCp15hXzvEQMTcZCDeMmmBPhJF0lOvOCtQUjv3Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofRDaVxjecpWVXMiw5W0Vxzwkk2VlLoYdiNSKjavgUjHIdTkS234SgSuCN0p4TU2y6LLszTgfjD7/mQzhKyEgYCuNzvxSwW9a+LS6xPPH88H33fs1cBAStc/0feW+WSZCdCZuxPgw+JcZCka5QHlKnlMIWcS15UnfV66gwA44yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T47E7lZu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820207; x=1777356207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bGpCp15hXzvEQMTcZCDeMmmBPhJF0lOvOCtQUjv3Qc=;
  b=T47E7lZu2DCJr1Xa0H5KFyTuGOwGb06GNlhWdCBUhMetZkHzrVjqs9UZ
   qfkvvkZyGjyPs5D9WpJiY/NRTcWYIKRkHfToXGPhGw/N7EY478h/XtDCh
   +uGK5HEl3Nw+l498XyjD57C3NBxENWfRgEldMsVBO0C/S/aMNEze8P/3N
   bEo3vP8jJW14tQRZmxqbbcEJr9hjBJbQRsLCdMKOoLwMeGSOFb5iFgDV5
   aUYKKVbFpTHvHsBKIJtxJIWivGTkobciF2S9cryfaTpvrjTIma1yPBXpI
   9Gmt7KkAb0FBMH2etdCMwb2sFNxZipWf+DnrBW0YQsAMKc8wP4vWwvx0W
   A==;
X-CSE-ConnectionGUID: jejlNfO4SQOcXq260kSGeQ==
X-CSE-MsgGUID: ET9OfV65RYin44E3NSSSog==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51064585"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51064585"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:03:27 -0700
X-CSE-ConnectionGUID: OhCeRr4pS+OBkQloShu9cg==
X-CSE-MsgGUID: ndYlet1VSveyRIJujU6BCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133340732"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2025 23:03:24 -0700
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
Subject: [PATCH iwl-next v1 1/8] igc: move IGC_TXDCTL_QUEUE_ENABLE and IGC_TXDCTL_SWFLUSH
Date: Mon, 28 Apr 2025 02:02:18 -0400
Message-Id: <20250428060225.1306986-2-faizal.abdul.rahim@linux.intel.com>
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

Consolidate TXDCTL-related macros for better organization and readability.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 6 ++++++
 drivers/net/ethernet/intel/igc/igc_base.h | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 859a15e4ccba..e9d180eac015 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -492,6 +492,12 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
 #define IGC_RX_WTHRESH			4
 #define IGC_TX_WTHRESH			16
 
+/* Additional Transmit Descriptor Control definitions */
+/* Ena specific Tx Queue */
+#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000
+/* Transmit Software Flush */
+#define IGC_TXDCTL_SWFLUSH	0x04000000
+
 #define IGC_RX_DMA_ATTR \
 	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 6320eabb72fe..4a56c634977b 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -86,10 +86,6 @@ union igc_adv_rx_desc {
 	} wb;  /* writeback */
 };
 
-/* Additional Transmit Descriptor Control definitions */
-#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
-#define IGC_TXDCTL_SWFLUSH	0x04000000 /* Transmit Software Flush */
-
 /* Additional Receive Descriptor Control definitions */
 #define IGC_RXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Rx Queue */
 #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
-- 
2.34.1


