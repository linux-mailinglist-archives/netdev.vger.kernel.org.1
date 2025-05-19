Return-Path: <netdev+bounces-191390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680BEABB60D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943697A4731
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD0267702;
	Mon, 19 May 2025 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ir0llfRX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E72676F4;
	Mon, 19 May 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639247; cv=none; b=RA3TWOMezIEiZnCE4jN6fkVWldsvpvAbZ0Q5ZnNBu9fUq8v8k1W61IRjUcAN/kOsiZ0atMzwgtPJ0ZTddnCeMx5StS7pxmw/0OG0U2MMeSsO4s56nyJ4CugzyX+dzHV8wJya7b3PLPd1o8Dc095ERMBAifXnwcTNPo+S2eB/zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639247; c=relaxed/simple;
	bh=JiyXN0SaYOPJC2/fNDPQ9eo7Bs71lNhqigdwaAiILpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diorXaXYfRTEzRNDToLTrrvhdmoCsJGDlOFuX3CUgZaWcKMvGs+nfboReJJsnp96OXIpACafTlUwIQG30o0CuppkiplGoKQ09QxcvRyH9gJnUX/qzh3qdVvMN3aobZWwWKyHFrpw30m85a6NADzqo6+qkH08K1OcdY/3glxa01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ir0llfRX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747639246; x=1779175246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiyXN0SaYOPJC2/fNDPQ9eo7Bs71lNhqigdwaAiILpM=;
  b=ir0llfRXTRURwUQg73MC9pIHsyMimbABfIAidNPXOY7suVRqPCaj6n26
   qJJNsEw7+IVvDVS1tl64jvMcdCeOpItwccd1H3odbTyJGI0Dd62qIEq9r
   6MP/Yn5Vuv2/HXr+4pEmwqCvqB+hIdezzcHckvk04bgGDx94c+ISjoaTV
   1q8m6lPPnrW2JXvdjvnnT8IBaGBNnDc82sSoBBaXyjzWu5hntq/4BkaUm
   6FJSVXo2B8EVlgC0N0DhxOWF4GTIu3NzBCN9wm2CiuqVd14C2ZSlks9cK
   u2gNBb6JAHzx+vq+9ZZ2fjYmu+QWr3aVS/5cxYNpC13mQ+NCzYEuOFdMG
   A==;
X-CSE-ConnectionGUID: zU8yEmpOTKiaA17J6MCfPA==
X-CSE-MsgGUID: /7E8i/8wRgKehPMila3tLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="72030717"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72030717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:20:46 -0700
X-CSE-ConnectionGUID: e2JBfEhJRpqWI8+/F4i1Qw==
X-CSE-MsgGUID: BU1rhTELTkaLa9me0AG04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139798793"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2025 00:20:43 -0700
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
Subject: [PATCH iwl-next v3 2/7] igc: add DCTL prefix to related macros
Date: Mon, 19 May 2025 03:19:06 -0400
Message-Id: <20250519071911.2748406-3-faizal.abdul.rahim@intel.com>
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

Rename macros to use the DCTL prefix for consistency with existing
macros that reference the same register. This prepares for an upcoming
patch that adds new fields to TXDCTL.

Reviewed-by: Simon Horman <horms@kernel.org>
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


