Return-Path: <netdev+bounces-29622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A503378410E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5B2810E6
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA311C9FF;
	Tue, 22 Aug 2023 12:41:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F77F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 12:41:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA8196
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692708073; x=1724244073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYKUU/xj0QxXFQ63kzSKlbFuP+Ql4C41o4hOcu7twBo=;
  b=MAJrhH5wy8Rse0F3ebxH/C+tGcFKLqmJpqpF/dYqLaiGabPraN1aPA48
   pr3lURWwP95xyQep9Ckk8f0foT2l920kDJwxfCV+VP1Z6xA/I5g66E739
   ifq6tQuj/Brh/I12KzQXozuBNwyYBDJH9enCCmPXlAKgNQQTbGxJbNtpd
   Z+lGuOybuTPsVSEybHBv5UKCdrC7y3W5MAbRCYfL1YiDNUoGxHnpK49ck
   C2IAtJivZSGYL2Kr+9RRX9F0SJsbKV1/lVawJTtQzR+T3m6zNJO7Juj7t
   vqocXyErQwXWojbf8pHkC2nG35hpD/crjd83K13vGjJHjOZfY6OPh20na
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376604635"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376604635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771342962"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="771342962"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 05:41:11 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 7/9] ice: modify tstamp_config only during TS mode set
Date: Tue, 22 Aug 2023 14:40:42 +0200
Message-Id: <20230822124044.301654-8-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822124044.301654-1-karol.kolacinski@intel.com>
References: <20230822124044.301654-1-karol.kolacinski@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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
index 120d47356830..dac77bff4d20 100644
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


