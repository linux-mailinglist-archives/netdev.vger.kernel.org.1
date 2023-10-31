Return-Path: <netdev+bounces-45487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DD7DD840
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF9328193A
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB327452;
	Tue, 31 Oct 2023 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cv1tGCuw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42494D525
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 22:27:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D4103
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698791253; x=1730327253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBgxoazN0TAkndBwdZxKql4OSOrWI+t16ufJuF66F3U=;
  b=Cv1tGCuwqamdnMZX6/listVo5eGbEnyjZxZpUY1Xb8knOYLfEv6m2A+g
   S7VE8i3KeYCTA/tMV6JwSMkX9411OKTA5N0NprpNx5i2EaLdVmVGbuf0M
   hQsmmfuST/9v75ufxmUx+b39dnEGHpiqOhlCioFh0Js8TrgD67cr6T4w2
   fswpUotHBVqTsytPX8/q613num962X8cgqLpC8U6iKCr8e/JkjxisGQ9X
   0x3VWifgkj2pvAFAnM2Qal6lzhCzLqO72zjyPY78NuUVSY3m9988dLZxC
   wklr+aYHyjQI2iFlTis94Muts4U/UBJy+y738nXGUWL5ybgh+OqXBa9vG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1236093"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="1236093"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 15:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="1988800"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 15:27:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 1/3] ice: remove ptp_tx ring parameter flag
Date: Tue, 31 Oct 2023 15:27:23 -0700
Message-ID: <20231031222725.2819172-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031222725.2819172-1-jacob.e.keller@intel.com>
References: <20231031222725.2819172-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes since v1:
* Picked up Jesse's Reviewed-by.
* Add appropriate Fixes tag.

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


