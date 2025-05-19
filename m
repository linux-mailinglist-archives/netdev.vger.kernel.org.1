Return-Path: <netdev+bounces-191389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B43ABB60B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64581895408
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF933266F1E;
	Mon, 19 May 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfaX4Wr2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5830266B6C;
	Mon, 19 May 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639243; cv=none; b=lMOtD9w2EnX8g6cD97ZWYKtsWVUS5ld9oNtlCvw/Wxuo5x21bKDpsVgvuoY55fB/QpksGCzENotMeIGeYlpmAYP9zhiAzeEDttc5E8oD9IagLFa2jWtsZVjrf2iwBgll9kHMHdmE36LxesHbcrTp5dz1xjbqRla0WMswC9V3n+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639243; c=relaxed/simple;
	bh=X7n7rR82XQJo1WypxQezqqyl90YGNPvBN0QcTvREVko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oorVGBOE5Ut4WZ3j4LqfuA9y6yh8Q52UkPEeLr8dKdPUQKMPwBxJAFYOxI+mCteyCtoAaeBfJrnlkrUumTEYMYq/ViTVA7Zd0V3v5ZPnnnms192uPiuEzXMYdszMOdsKwJlwJQv8Scfc54tyjCrVC2lMk01gfyPtoJUSPNBjbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfaX4Wr2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747639242; x=1779175242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7n7rR82XQJo1WypxQezqqyl90YGNPvBN0QcTvREVko=;
  b=MfaX4Wr2cOWhOWjAdiOn+DT1K3zUCMEDugvXnagjw4Z6pN10AaYGgpIy
   fgIaJzJDVt5aIyGMd+hyS+WITxkBWYboRwvhkTJ4QqBWziJmoVfOd++AZ
   7jUYqQzW7PzHTH0XFkAuo9+gXDOEAsZL+6luFhhRZS9/R2V/YmwG3XGzt
   4Lgd/vkGBYjN7Dv3FQa/Uu0JWg7+5mU81anV/t7k9uOJNHc50qEXR0BZj
   pwmFmJiNbGsRFDquJ3vHnpFcNXSpmIQhJqN+xhZykYB1mjapxlp3kHMhC
   mjgLyftPj7/u0nUxOn7W8OkCsu4kIzCtXV4ZMpY3/e7alhbpqRWx5xRS2
   Q==;
X-CSE-ConnectionGUID: +zfZ0pzLSWuKUF/QzBLcfw==
X-CSE-MsgGUID: R/MhEAyFQaSSnS478od+hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="72030701"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72030701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:20:42 -0700
X-CSE-ConnectionGUID: fqTvO+mdQEqMTLlG7bMIDg==
X-CSE-MsgGUID: 3AzgyEQaTOSXwq+joGUE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139798752"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2025 00:20:38 -0700
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
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
	Simon Horman <horms@kernel.org>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v3 1/7] igc: move TXDCTL and RXDCTL related macros
Date: Mon, 19 May 2025 03:19:05 -0400
Message-Id: <20250519071911.2748406-2-faizal.abdul.rahim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
References: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
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
2.34.1


