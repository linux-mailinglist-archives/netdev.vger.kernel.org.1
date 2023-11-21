Return-Path: <netdev+bounces-49792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC397F37E2
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1F5B2143D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041355C23;
	Tue, 21 Nov 2023 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtpDzrZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06CA1A1
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601186; x=1732137186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hanVR1e5CLgBWYLwKCrp/fjEWKM7ijPRcKxsA1rQi6M=;
  b=AtpDzrZ50qpXosl4U21BuipkWfiDFUvXWvVGcM/w0YXyMRnczS8Oe4Bv
   z2WnVy+lFkQjJB1LkJjRstbsIkf4csydCakhZGypa5Rqg5o8VvlLYnG/G
   i3itHHT87iZXxbPZGYiSduE8iz7l+5KEahlhULgBzB1lozE9ALZ8wS4DR
   UhhSoaE3VCKRCj6EFtjJSVsb4d68jCKbbxG0EdQ50wr3NuJExhfvWOtBo
   9Nh3cxI1JL7cx7Dmcaj19cGCFI8WGp2ft6BKgvQEJxbHpjG9qtkrGAD/w
   RSJg2FlzZTfqi3roi8wXgIaIx+YKlUBqpbJzI7/0qiAN10UeBnMgdx592
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391701751"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="391701751"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014031673"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1014031673"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2023 13:13:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/3] ice: remove ptp_tx ring parameter flag
Date: Tue, 21 Nov 2023 13:12:55 -0800
Message-ID: <20231121211259.3348630-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121211259.3348630-1-anthony.l.nguyen@intel.com>
References: <20231121211259.3348630-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Before performing a Tx timestamp in ice_stamp(), the driver checks a ptp_tx
ring variable to see if timestamping is enabled on that ring. This value is
set for all rings whenever userspace configures Tx timestamping.

Ostensibly this was done to avoid wasting cycles checking other fields when
timestamping has not been enabled. However, for Tx timestamps we already
get an individual per-SKB flag indicating whether userspace wants to
request a timestamp on that packet. We do not gain much by also having
a separate flag to check for whether timestamping was enabled.

In fact, the driver currently fails to restore the field after a PF reset.
Because of this, if a PF reset occurs, timestamps will be disabled.

Since this flag doesn't add value in the hotpath, remove it and always
provide a timestamp if the SKB flag has been set.

A following change will fix the reset path to properly restore user
timestamping configuration completely.

This went unnoticed for some time because one of the most common
applications using Tx timestamps, ptp4l, will reconfigure the socket as
part of its fault recovery logic.

Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 14 --------------
 drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ---
 drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
 3 files changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1eddcbe89b0c..affd90622a68 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -280,20 +280,6 @@ static void ice_ptp_configure_tx_tstamp(struct ice_pf *pf, bool on)
  */
 static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 {
-	struct ice_vsi *vsi;
-	u16 i;
-
-	vsi = ice_get_main_vsi(pf);
-	if (!vsi)
-		return;
-
-	/* Set the timestamp enable flag for all the Tx rings */
-	ice_for_each_txq(vsi, i) {
-		if (!vsi->tx_rings[i])
-			continue;
-		vsi->tx_rings[i]->ptp_tx = on;
-	}
-
 	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
 		ice_ptp_configure_tx_tstamp(pf, on);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 52d0a126eb61..9e97ea863068 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2306,9 +2306,6 @@ ice_tstamp(struct ice_tx_ring *tx_ring, struct sk_buff *skb,
 	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
 		return;
 
-	if (!tx_ring->ptp_tx)
-		return;
-
 	/* Tx timestamps cannot be sampled when doing TSO */
 	if (first->tx_flags & ICE_TX_FLAGS_TSO)
 		return;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 166413fc33f4..daf7b9dbb143 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -380,7 +380,6 @@ struct ice_tx_ring {
 #define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
 	u8 flags;
 	u8 dcb_tc;			/* Traffic class of ring */
-	u8 ptp_tx;
 } ____cacheline_internodealigned_in_smp;
 
 static inline bool ice_ring_uses_build_skb(struct ice_rx_ring *ring)
-- 
2.41.0


