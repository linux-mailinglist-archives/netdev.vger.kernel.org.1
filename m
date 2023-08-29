Return-Path: <netdev+bounces-31187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063A78C27F
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B4F1C20A22
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8F154BD;
	Tue, 29 Aug 2023 10:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC56156C9
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:41:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744821B3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305668; x=1724841668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXO8V1ULgZycDSoU0VymmEVwhyU6WCRUOeeK4jScNUk=;
  b=BjD3S9dvG/jh9C0mpPipumqB7ST4DHrY3V5ADHmyo/ZBCw2zfGvOLoe4
   Z3fAw8ZDJ+8vvBTUTU9IPHB/JBlQ1BA+a9nYGHNSpbuYgn4vRLA5M8ucr
   Pk+RhhlBF5aWmw2+wvq/vaoNM7/ZQZ00Y/bKiUX71v7w5VmCPiGgRap6R
   PYqIKtmcSTtVmi9j3oe1AVbX0lKyk3T3ydc5WV+Eh/uUzWNgiIpymzmsS
   M2wDzPt7nHUwYqRkF0WVsYGfZ1czIWzsA/iHsteDD4PH+do2DFp5EnqI4
   69qQoV211plhqFERMry1LQyvnPigxIv55tvoX3y/xcU8z/+LhvEUb3u47
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461696910"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461696910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853229827"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853229827"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 03:41:06 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 08/11] ice: remove ptp_tx ring parameter flag
Date: Tue, 29 Aug 2023 12:40:38 +0200
Message-Id: <20230829104041.64131-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829104041.64131-1-karol.kolacinski@intel.com>
References: <20230829104041.64131-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

Before performing a Tx timestamp in ice_stamp(), the driver checks
a ptp_tx ring variable to see if timestamping is enabled on that ring.
This value is set for all rings whenever userspace configures Tx
timestamping.

Ostensibly this was done to avoid wasting cycles checking other fields
when timestamping has not been enabled. However, for Tx timestamps we
already get an individual per-SKB flag indicating whether userspace
wants to request a timestamp on that packet. We do not gain much by also
having a separate flag to check for whether timestamping was enabled.

In fact, the driver currently fails to restore the field after a PF
reset. Because of this, if a PF reset occurs, timestamps will be
disabled.

Since this flag doesn't add value in the hotpath, remove it and always
provide a timestamp if the SKB flag has been set.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 14 --------------
 drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ---
 drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
 3 files changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 12824da9f3da..f2b315b18cbd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -305,20 +305,6 @@ static void ice_ptp_cfg_tx_interrupt(struct ice_pf *pf, bool on)
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
 		ice_ptp_cfg_tx_interrupt(pf, on);
 
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
2.39.2


