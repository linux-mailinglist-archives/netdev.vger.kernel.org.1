Return-Path: <netdev+bounces-191391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92DABB611
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F8E175316
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78793267B68;
	Mon, 19 May 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuSroHSx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2412267B0C;
	Mon, 19 May 2025 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639251; cv=none; b=j82xMe7OupXfM8gB/ejHj+2edwGFx295hvVolrMAkI8aWSe2u/omkTDoqEKv5qSDRXaEb18gqoDywoGz29KkEcVD/3C94QREkV0t097o9EWxrN1emOaubYyE3HjdZoLmh3JSsTUeXb3/29GlxOAshUUr9AT4lbE3GJe3efVSpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639251; c=relaxed/simple;
	bh=Cn7+DmmLvHcmgm6wbwcw12IySau9IeuVUICgR6NNYb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKC0vGAPrGpFu+Qlzkh59M5h+I9pJKdEDdTmHdKrxdB4jFLiPqq46fHkJkR6V/O+wMrzM3waJsQmS6eeaSjUO83Q0OF487c38jim3Z9Kk13NebKwklWNfHpkMjBKRGKj6EcQviGgQbfhBgxRdXOKrUCOpK04zms9MxqghBTNbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuSroHSx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747639250; x=1779175250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cn7+DmmLvHcmgm6wbwcw12IySau9IeuVUICgR6NNYb0=;
  b=BuSroHSxwvESz43soQjIouHOBfrDLK2yWZuj+SyF63Tf91YDnjDIaI7+
   ilphLhuVk688eeqm6Ow4tAP5D5GR5EZVoH6O68Hj6AGGGLLGi02qmHZzE
   Qk21nKIsWdAnvqZFzrw+meOC/Td94gTRl72hycGXwZVHxyW4R2jLXTicc
   EhSKdo+ph8X6uxjrOgHNYhz/t9mrNqtEyJ7a/A4u9EW+McchzMUi0xUAK
   +HvdIzqn9DKirEWDzpcQZEmmW2kV55qAUAD0IeSzz9kwKyXUoZT70yWMu
   F14Kfm6IPvzbjVMmOvfnIMOsnqpZp8MolYBQnnpWZ+Ev+fR1+k2srKvfy
   g==;
X-CSE-ConnectionGUID: ZDBEnRknTbG8W4DmjtVN3A==
X-CSE-MsgGUID: apQJ+gi7RqW/qIFaW6aQmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="72030727"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72030727"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:20:49 -0700
X-CSE-ConnectionGUID: l3aQ8PL6RPCeyb9Q+1Wl4A==
X-CSE-MsgGUID: R3MQYpjIStiebB3dOM0Dbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139798817"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2025 00:20:47 -0700
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
Subject: [PATCH iwl-next v3 3/7] igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
Date: Mon, 19 May 2025 03:19:07 -0400
Message-Id: <20250519071911.2748406-4-faizal.abdul.rahim@intel.com>
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

Refactor TXDCTL macro handling to use FIELD_PREP and GENMASK macros.
This prepares the code for adding a new TXDCTL priority field in an
upcoming patch.

Verified that the macro values remain unchanged before and after
refactoring.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 15 ++++++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c |  6 ++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index db1e2db1619e..daab06fc3f80 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -493,13 +493,18 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
 /* Receive Software Flush */
 #define IGC_RXDCTL_SWFLUSH		0x04000000
 
-#define IGC_TXDCTL_PTHRESH		8
-#define IGC_TXDCTL_HTHRESH		1
-#define IGC_TXDCTL_WTHRESH		16
+#define IGC_TXDCTL_PTHRESH_MASK		GENMASK(4, 0)
+#define IGC_TXDCTL_HTHRESH_MASK		GENMASK(12, 8)
+#define IGC_TXDCTL_WTHRESH_MASK		GENMASK(20, 16)
+#define IGC_TXDCTL_QUEUE_ENABLE_MASK	GENMASK(25, 25)
+#define IGC_TXDCTL_SWFLUSH_MASK		GENMASK(26, 26)
+#define IGC_TXDCTL_PTHRESH(x)		FIELD_PREP(IGC_TXDCTL_PTHRESH_MASK, (x))
+#define IGC_TXDCTL_HTHRESH(x)		FIELD_PREP(IGC_TXDCTL_HTHRESH_MASK, (x))
+#define IGC_TXDCTL_WTHRESH(x)		FIELD_PREP(IGC_TXDCTL_WTHRESH_MASK, (x))
 /* Ena specific Tx Queue */
-#define IGC_TXDCTL_QUEUE_ENABLE		0x02000000
+#define IGC_TXDCTL_QUEUE_ENABLE		FIELD_PREP(IGC_TXDCTL_QUEUE_ENABLE_MASK, 1)
 /* Transmit Software Flush */
-#define IGC_TXDCTL_SWFLUSH		0x04000000
+#define IGC_TXDCTL_SWFLUSH		FIELD_PREP(IGC_TXDCTL_SWFLUSH_MASK, 1)
 
 #define IGC_RX_DMA_ATTR \
 	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4f1a8bc006c6..f3a312c9413b 100644
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


