Return-Path: <netdev+bounces-190298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CEBAB6189
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8A94A2FBE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA31F0996;
	Wed, 14 May 2025 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpEs1ozH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00E1F4616;
	Wed, 14 May 2025 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197073; cv=none; b=LKr1UGLqz3h3/fowPBHz+cknamjyilpqOHlQkjbS/cpTwhbjiGEr42fqrNpjDDFJiWh/hNIxygKgNLw0luBiglt5LLUasT2w8bFI/gtZhtZu8rrfjaEmlGflWE3MxPydRsHwQvc97EEH05y/aW3w5zWCGWwZ7mbT21XLSsKiLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197073; c=relaxed/simple;
	bh=cj+IXujLa432okMaOhDaLe0C7KuZSXLAiC5Y8Yr1r0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4+9NQSGRSmHmoQ2xGSGGef1ATOs02Jo6hh1KY2usyajbHW6HaRf2EBL2nlCf/lJhvjrmdolrdeYGBWR3QGI5dURfIneYDXRr+aR7X86SLt5zaOkl4TWJlcMBWXah3qsDVA3Te4T5fkNHPJZTitrsxEtUTglI4TQltVRB0XSbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpEs1ozH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197071; x=1778733071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cj+IXujLa432okMaOhDaLe0C7KuZSXLAiC5Y8Yr1r0w=;
  b=FpEs1ozH2REqtOzRGGS7GJDjBU1cbQ1lccDAEmJV0MTfFOPcjNTKmFpo
   ajXLjB4PKHDWtBMmoPiIKfZdqHno2Nny1yt8JLxW4b3Zt6GNtZZRQ+aqg
   JyEBlDiE1+auCr7ZTMuq/qtU4QBFTymeAzSLP5ay6TkotCBQimxzwDx+y
   zLIxQbjMIe0Nnv+GBywEtkTPzd7Xd0ewc5xCaa/eevCN5SKxyAMuzC3Fd
   S+Pm2ZITvaNp6OcT6aAb0kYnH7vWXpAYllinlOnOvHXpGJPAXCNRrrziK
   O4TtXKo4gx/oZgmIgCoRDJiRi7ZoExmtU4rt3SKUzytEcKM3ukysXnJUX
   w==;
X-CSE-ConnectionGUID: djtiQKrRT5q2OjqDNmq9EA==
X-CSE-MsgGUID: 5dpyKFEASqKxybnaRpbIIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36699096"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="36699096"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:31:10 -0700
X-CSE-ConnectionGUID: QkYXNdkHTQuxVGrFUcmyXw==
X-CSE-MsgGUID: KV0uQuYNRUitKnrJYG197Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142861804"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa004.jf.intel.com with ESMTP; 13 May 2025 21:31:08 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v2 2/8] igc: add DCTL prefix to related macros
Date: Wed, 14 May 2025 00:29:39 -0400
Message-Id: <20250514042945.2685273-3-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename macros to use the DCTL prefix for consistency with existing
macros that reference the same register. This prepares for an upcoming
patch that adds new fields to TXDCTL.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
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
2.34.1


