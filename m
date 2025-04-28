Return-Path: <netdev+bounces-186337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A97A9E7F0
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473C9189B8A9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96C11D5142;
	Mon, 28 Apr 2025 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP/w9fnr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AD1CAA6E;
	Mon, 28 Apr 2025 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820211; cv=none; b=MywTI6Tu4VZW2S7Nr7N6RATu4CeIVBYKg6IWQ1/wTjyz5WiaLP+OiCShrdov7ThapOzxt+3zFZlk6IvSVSVIVF6LBvonFxv/T7G0VndrJLzJFEqYf5H05BA6Z7jnVlBvsjHVLKPjqm5e18XUvkhITZL8PhPNtUzZZu/S7GCiPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820211; c=relaxed/simple;
	bh=utJgU/4E0lRF86nAOgNjxmBrTEjRQTmBI49DKxLnVb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CihJbBZWoLtdnyz0oeSiTnOSglfeDnWH1bjt0pdmejSiizxY9QZcf+y9j+SzTUcXagBuysiAVtfmPNGwH7ofxZtNEDHSVBjCMTt9d0dNgVMOhz4nLcKrPsw/+xMBSXLEmv1Nrhxjiv20NWEqzaYjAANkaXG+zdL7yP2fnbeo8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GP/w9fnr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820211; x=1777356211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utJgU/4E0lRF86nAOgNjxmBrTEjRQTmBI49DKxLnVb0=;
  b=GP/w9fnrOFpOFEAvgxy0yEvGMNp+qiQqvHnBzQvcPgR8onBxniv0V7So
   8FsROgG4p8NfQoO1mCulj2n5fdrMrYGGsmIakxg2yag+bho3YTrhSjpWz
   M0GwhYsC+HLUCB5zC1EGtWeA4acFpLTjYw1r4vHOH9ciGchtj562yq+2i
   cJYUTGhJSwZCsP02ollY5qDrm9AHAzfngR2pY33nDAPPfATQULERu+1Ud
   809B9Hg2GYgMyEc1asAcF4zb5d7WIJQ/0o/s+PVvrXBE46aZXxumY6Bsl
   zyEqpxxoy0ojoVbSuJqE7ciaD0cze+39CvZovxKfRu53SUDNU0BX3rMG1
   w==;
X-CSE-ConnectionGUID: IKcu9tqHSM6kSzH3An6kjQ==
X-CSE-MsgGUID: jrMXmdgNR5WANJb1BxxuUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51064601"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51064601"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:03:30 -0700
X-CSE-ConnectionGUID: r8L480b1Qx+M0KGADanF6A==
X-CSE-MsgGUID: jQ1pQTfzS6mZjH6ajiiPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133340742"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2025 23:03:27 -0700
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
Subject: [PATCH iwl-next v1 2/8] igc: add TXDCTL prefix to related macros
Date: Mon, 28 Apr 2025 02:02:19 -0400
Message-Id: <20250428060225.1306986-3-faizal.abdul.rahim@linux.intel.com>
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

Rename macros to include the TXDCTL_ prefix for consistency and clarity.
This aligns naming with the register they configure and improves code
readability.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 6 +++---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index e9d180eac015..bc37cc8deefb 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -487,10 +487,10 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
  */
 #define IGC_RX_PTHRESH			8
 #define IGC_RX_HTHRESH			8
-#define IGC_TX_PTHRESH			8
-#define IGC_TX_HTHRESH			1
+#define IGC_TXDCTL_PTHRESH		8
+#define IGC_TXDCTL_HTHRESH		1
 #define IGC_RX_WTHRESH			4
-#define IGC_TX_WTHRESH			16
+#define IGC_TXDCTL_WTHRESH		16
 
 /* Additional Transmit Descriptor Control definitions */
 /* Ena specific Tx Queue */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27575a1e1777..725c8f0b9f3d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
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


