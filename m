Return-Path: <netdev+bounces-31188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E978C280
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1629928103F
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AB156DD;
	Tue, 29 Aug 2023 10:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F3156C8
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:41:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4507219F
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305670; x=1724841670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZuOf/Zu3k2qwD+EABgE2Vqa+fbd80dxj8iH2we8IU/A=;
  b=fpRYii5kiLKSYL3QQ/NyvXZ/KRTf2gzrG5ahwh3y6zz3oxYqqm5UDsBw
   Ee7UzcbcvDzHbbtBcX2r3Gy/9C1sLmpNJeKJIklDvsHaZsZTLJ/BhGNjc
   q3bx8h944wNQ1ZnX4SVckD0e/flV1lI8IlDJ83ln8E5Z4lylepqQ+Fq+M
   Fa5KhNEd1q1RTc6HejS56BnYVno8sWKGmteox3lQuq0JTQjpHelRltCcJ
   7qKqqugoCDecfWwWW1pXLxErYJOJpZteqEzAsYhpgZja3Y3cuOkej0nCe
   9NU5iyaGVlZSs9ESyeWRdcOnwZttKGaWiIQ0Zfia0ispopMQEINYfGzpY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461696918"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461696918"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853229837"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853229837"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 03:41:08 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 09/11] ice: modify tstamp_config only during TS mode set
Date: Tue, 29 Aug 2023 12:40:39 +0200
Message-Id: <20230829104041.64131-10-karol.kolacinski@intel.com>
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

The driver stores the current Tx and Rx timestamping configuration in
pf->ptp.tstamp_config. This structure is supposed to represent the
currently requested configuration from userspace that we've applied to
the device.

The values of this structure are modified within the low level
ice_set_tx_tstamp() and ice_set_rx_tstamp() functions. These functions
*are* called by ice_ptp_set_timestamp_mode. However, they are also
called during the driver reset and rebuild flow. Because of this, the
driver overwrites user configuration during reset, preventing itself
from being able to properly restore the configuration after a reset.

Instead, stop modifying this saved configuration state outside of
ice_ptp_set_timestamp_mode. Instead, set the values directly within this
function. This avoids losing the configuration data.

A following change will refactor the rebuild flow to properly restore
the configuration after a PF reset.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index f2b315b18cbd..085f415e98ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -307,8 +307,6 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 {
 	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
 		ice_ptp_cfg_tx_interrupt(pf, on);
-
-	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 }
 
 /**
@@ -331,9 +329,6 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
 			continue;
 		vsi->rx_rings[i]->ptp_rx = on;
 	}
-
-	pf->ptp.tstamp_config.rx_filter = on ? HWTSTAMP_FILTER_ALL :
-					       HWTSTAMP_FILTER_NONE;
 }
 
 /**
@@ -2054,9 +2049,11 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		ice_set_tx_tstamp(pf, false);
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 		break;
 	case HWTSTAMP_TX_ON:
 		ice_set_tx_tstamp(pf, true);
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_ON;
 		break;
 	default:
 		return -ERANGE;
@@ -2065,6 +2062,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ice_set_rx_tstamp(pf, false);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
@@ -2081,6 +2079,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	case HWTSTAMP_FILTER_NTP_ALL:
 	case HWTSTAMP_FILTER_ALL:
 		ice_set_rx_tstamp(pf, true);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
-- 
2.39.2


