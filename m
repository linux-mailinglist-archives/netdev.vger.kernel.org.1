Return-Path: <netdev+bounces-31179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E71D78C264
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D2281016
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA9A14F84;
	Tue, 29 Aug 2023 10:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4A110C
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:40:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D781A2
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305655; x=1724841655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=38QVTwQDh3SArRq4J8AC4ydcMEE8h68Lcm9Uzet8GwQ=;
  b=TpaQql0f8RcVPh6KSr4g7MFus1+aQ73uTPafG9F5xl7eG9bWe8Iew+bA
   oknNZiAOaBWzRn/jstYDPth20JOW+2uux8pT29INQDiaez2ZTmB02Jex9
   HXN7MUH9z7ZV41oKxGmN+XMAYAXYPZrrMrnRXUkk2a5k2OOsuuzq65n3S
   YaRgr5TqRIvxKlNoz3GrKEJb2RYt8kW+KqAEYAiYxOJxVY40U25Yg2/HF
   1Jrdj5lA5N02rA2DZUbzagyC2F55k3cUshQvVxX9SjnC7tfq9iqYrJw1N
   gY278H0XHFVLx8XZLjyyGonzHnnR6132TUKgxynnvEyVBAWXSsNqU/wO9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461696868"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461696868"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853229745"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853229745"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 03:40:53 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 00/11] ice: fix timestamping in reset process
Date: Tue, 29 Aug 2023 12:40:30 +0200
Message-Id: <20230829104041.64131-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
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

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (10):
  ice: use ice_pf_src_tmr_owned where available
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: rename ice_ptp_configure_tx_tstamp
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: remove ptp_tx ring parameter flag
  ice: modify tstamp_config only during TS mode set
  ice: restore timestamp configuration after reset
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

---
V3 -> V4: Split patch ice: rename PTP functions and fields into 3
          separate patches
V2 -> V3: Adjusted commit authors and added base commit
V1 -> V2: Adjusted commit S-o-bs and messages

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 334 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  38 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   1 -
 7 files changed, 247 insertions(+), 148 deletions(-)


base-commit: 938672aefaeb88c4e3b6d8bc04ff97900e0809dd
-- 
2.39.2


