Return-Path: <netdev+bounces-190297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E715FAB6187
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E998F7AC78D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547B1F4163;
	Wed, 14 May 2025 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbVlkZno"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82381F0996;
	Wed, 14 May 2025 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197069; cv=none; b=tFCxwpd3shIq2ZhCXOnnr3Dd5rI5I/hWYobZWrcEDstpFlzy9nIzWrGaNAN1Yj0oPZjUbzWT7ICdFktZiRVN6C0rrexQ6XaFzOvwyU0YZoBHYc8ALIHVWTqv+nvrK251YnjtpVlg8LakF4s/zU7aej31mc8/aF37K9Z8UOCWH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197069; c=relaxed/simple;
	bh=VHExT5zAhe3qyyN0VLyKjJJKmfIjQUC6t+Aknf3J+gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HN8qce5k0VfE501eEjsqI3UVODBesD9IlkhcfqYrdrB2i9vksE9m/shjev2L5oaEbcwzW3VSqrBYMxDnmd4OPPWZIUAcUP9E1t62ZQDwAOabWLEeP/Q7kn+xJ4xrVhSlFpwDlxQ9IXurDE9oCA75nSdpbhXhe0wHl5G4g3B3C60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbVlkZno; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197067; x=1778733067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VHExT5zAhe3qyyN0VLyKjJJKmfIjQUC6t+Aknf3J+gc=;
  b=EbVlkZno7sEvEgwmFBm7ef5mXUDsHqGr4UzR6nuKvKNB5V5EqjzW7/5s
   IV/KOTu4aFSbd8frZZFqLOoJFgrWyW5XTBtBWzQRqMEZ0gOu2BMkPif0T
   VHdvu7Bz+Uj1U+QdsQ3htEiRsOZeXJOmn151m5diUS9uWLQvkeIBrxO90
   BzqXcnv1AqhPobOn/rANxwAXXRihcGTBUFP7jwi4b/AWt1mIY6Zp1ka49
   mDxGP4c9UlU9o3beyn5B+kfrHCUwJ+iv2Pp+3hqQbdDCod3yrtmt5cRtB
   z6dOqFtGmhR2Zqa3V/onfhyli4/MXUap241CAVy0oppFYJTSK4obEkb84
   g==;
X-CSE-ConnectionGUID: 7eIZ4XUwRRi4yN3KJn7r+w==
X-CSE-MsgGUID: 4BbN1sTDRj2Y8OVwHQrGWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36699080"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="36699080"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:31:07 -0700
X-CSE-ConnectionGUID: IvBvaiAWRNGXLM849mgvWQ==
X-CSE-MsgGUID: N4EeITTsS/ap9aLIIGnbcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142861787"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa004.jf.intel.com with ESMTP; 13 May 2025 21:31:04 -0700
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
Subject: [PATCH iwl-next v2 1/8] igc: move TXDCTL and RXDCTL related macros
Date: Wed, 14 May 2025 00:29:38 -0400
Message-Id: <20250514042945.2685273-2-faizal.abdul.rahim@linux.intel.com>
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

Move and consolidate TXDCTL and RXDCTL macros in preparation for
upcoming TXDCTL changes. This improves organization and readability.

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


