Return-Path: <netdev+bounces-196674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B302CAD5DBF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0E316D6C7
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619226E6FD;
	Wed, 11 Jun 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hT7oeL5z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5623958C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665009; cv=none; b=IijrM3WnnvhKoBHJIYE7Ck1I14pEUs3Qj5jZ/QVGj12d93nLcpB/AsrrkgQRtyINEECWI0+SImj9PsiYJuVsNudXJcadjlPYoFn/H1W68pPfq9xz+T37HsrjVAoJW3vfEuTxm2eT/Xlr8fFKUT3fF0EegGgOs47AXdo5sTy86FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665009; c=relaxed/simple;
	bh=n0YIY/2UAk8J7ZCA7rGsAlgwEGwaPMmo/aE3WJhQth8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFeZNVT5I7S1bhkYIgnZ/VZOpWtDrPLmdQDCOX9UapmwugTuJyCmx5V7ij2cqOgtJC+/rO791A1ajkqHI4xJ+YvrjtfVMiADvIrmqn988B6pQjeOzusYfgTxFPvWhHwmkgRa02AyJppTx6DPekSFICuSdcHK/K+2Nm98kWL1BbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hT7oeL5z; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665007; x=1781201007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0YIY/2UAk8J7ZCA7rGsAlgwEGwaPMmo/aE3WJhQth8=;
  b=hT7oeL5zWjAQIiyBYSQEhm3AiSt3cMkwwVNYBAPdjTG4Zm5ppCDvBpey
   j6plXndQdSsmYLywwRhtNypWjpkKIbkh5dYCw3JubapC2wd6ts09KXVFG
   SVDEeJgoQcZOv08/kE506ipD1ePVviQQKuJI7hDV0OoJnCVhuF/Q4p7Kb
   bbUBpsYcSmMGLi+wfXwyQphWudtzoXtp5xArz8ZxS3OEvLsDqRALVQZTa
   DWVs3y4kzwICDi3hIxxwlXpk7EFrOQjKwpE+l8THUQtq8n3i0tQlazE+q
   0U1cIH05FRzqZJxfnOUvodEZQJo2TTgpInUX2ZwovX64a4Ux6kcE8k+Ag
   A==;
X-CSE-ConnectionGUID: setMj+Q9T5SAD37qvTZe3Q==
X-CSE-MsgGUID: XqgQHYkcRMu7BCcdoDQDwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51042544"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51042544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:03:26 -0700
X-CSE-ConnectionGUID: y6yWJgrgSsCjjXIn4qhLjA==
X-CSE-MsgGUID: irsz+nEYTAq+fwPv7NO+UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152418260"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 11:03:26 -0700
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
Subject: [PATCH net-next 2/7] igc: add DCTL prefix to related macros
Date: Wed, 11 Jun 2025 11:03:04 -0700
Message-ID: <20250611180314.2059166-3-anthony.l.nguyen@intel.com>
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

Rename macros to use the DCTL prefix for consistency with existing
macros that reference the same register. This prepares for an upcoming
patch that adds new fields to TXDCTL.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 12 ++++++------
 drivers/net/ethernet/intel/igc/igc_main.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 25695eada563..db1e2db1619e 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -485,17 +485,17 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
  *           descriptors until either it has this many to write back, or the
  *           ITR timer expires.
  */
-#define IGC_RX_PTHRESH			8
-#define IGC_RX_HTHRESH			8
-#define IGC_RX_WTHRESH			4
+#define IGC_RXDCTL_PTHRESH		8
+#define IGC_RXDCTL_HTHRESH		8
+#define IGC_RXDCTL_WTHRESH		4
 /* Ena specific Rx Queue */
 #define IGC_RXDCTL_QUEUE_ENABLE		0x02000000
 /* Receive Software Flush */
 #define IGC_RXDCTL_SWFLUSH		0x04000000
 
-#define IGC_TX_PTHRESH			8
-#define IGC_TX_HTHRESH			1
-#define IGC_TX_WTHRESH			16
+#define IGC_TXDCTL_PTHRESH		8
+#define IGC_TXDCTL_HTHRESH		1
+#define IGC_TXDCTL_WTHRESH		16
 /* Ena specific Tx Queue */
 #define IGC_TXDCTL_QUEUE_ENABLE		0x02000000
 /* Transmit Software Flush */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27575a1e1777..4f1a8bc006c6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -683,9 +683,9 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 
 	wr32(IGC_SRRCTL(reg_idx), srrctl);
 
-	rxdctl |= IGC_RX_PTHRESH;
-	rxdctl |= IGC_RX_HTHRESH << 8;
-	rxdctl |= IGC_RX_WTHRESH << 16;
+	rxdctl |= IGC_RXDCTL_PTHRESH;
+	rxdctl |= IGC_RXDCTL_HTHRESH << 8;
+	rxdctl |= IGC_RXDCTL_WTHRESH << 16;
 
 	/* initialize rx_buffer_info */
 	memset(ring->rx_buffer_info, 0,
@@ -749,9 +749,9 @@ static void igc_configure_tx_ring(struct igc_adapter *adapter,
 	wr32(IGC_TDH(reg_idx), 0);
 	writel(0, ring->tail);
 
-	txdctl |= IGC_TX_PTHRESH;
-	txdctl |= IGC_TX_HTHRESH << 8;
-	txdctl |= IGC_TX_WTHRESH << 16;
+	txdctl |= IGC_TXDCTL_PTHRESH;
+	txdctl |= IGC_TXDCTL_HTHRESH << 8;
+	txdctl |= IGC_TXDCTL_WTHRESH << 16;
 
 	txdctl |= IGC_TXDCTL_QUEUE_ENABLE;
 	wr32(IGC_TXDCTL(reg_idx), txdctl);
-- 
2.47.1


