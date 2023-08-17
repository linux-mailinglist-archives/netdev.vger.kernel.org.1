Return-Path: <netdev+bounces-28472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD777F88A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E953D281FE9
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6114ABF;
	Thu, 17 Aug 2023 14:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978B14AB2
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:18:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69C2D78
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692281894; x=1723817894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vYHA8+xlmi6PcYK2fPUjjFdwfUFUyHGGPF//QgxjG+Q=;
  b=oEeEz2eHCPF01n54TLN/jlRTw9Gx1lwom2CzHRqXcYbtNqgvOsBO8ipN
   kJswMksixtQG5bzY+eFGJnNqKh3NeTAQElQxdn49lkOu6Z8+KtIBzwm+c
   +9OR5APLG3jpm70mwYH56g/5llI25bq+7qD1uBE0V+fBUjIMgMHWFDvP9
   UWuLjOSwhNxJI6LgYMkKZUdCqrdUSmQ4IyvJTwS4Nylqi4ZUAWvF4iwPQ
   ZFqE5tfqvII40OXJI26jM3K7gYe21k/OGCPOTcIu05jaspARGBVDQb1Bd
   opiopVALLkSzYtWhdFUQOb0kpn2D8NxIvgx/pkODbTXeTlapzIZKgYti0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403804186"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403804186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981189642"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981189642"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 07:18:12 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 iwl-next 0/9] ice: fix timestamping in reset process
Date: Thu, 17 Aug 2023 16:17:37 +0200
Message-Id: <20230817141746.18726-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Jacob Keller (8):
  ice: use ice_pf_src_tmr_owned where available
  ice: pass reset type to PTP reset functions
  ice: rename PTP functions and fields
  ice: factor out ice_ptp_rebuild_owner()
  ice: remove ptp_tx ring parameter flag
  ice: modify tstamp_config only during TS mode set
  ice: restore timestamp configuration after reset
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

---
V1 -> V2: Adjusted commit S-o-bs and messages
  
 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 331 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  36 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   1 -
 7 files changed, 247 insertions(+), 143 deletions(-)

-- 
2.39.2


