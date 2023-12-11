Return-Path: <netdev+bounces-55944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7527180CEE0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D841C20A9B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A2D4A983;
	Mon, 11 Dec 2023 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm/tV1IC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B481CF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702306953; x=1733842953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/KrtDmmsQ++WSJtSiK7MMLaEx5uASusGRF2v36tCVVU=;
  b=Xm/tV1IC7nZu+rPzxDzJ9Ih56HmEk4bKAGVAOOKHqsdY2hxUoQrj60sb
   V1mZFdAQ5+9SfA4k1iHg0Ymj4UhfjBs7rpPizrMOTBzlawWTzYxko1DhQ
   snflimCTof0EkW+oPEjp7hfOoHCSh4AN8otY1CYWXhW7LM/NoltDvPbcS
   TM6LA91ru0rBlrUOOPR80Z32Z9crEO9fPhvQRjPDut4QqTIUZKftBghOS
   RIqSiG/goY6NW0pfgATtwXel7PBz0kXIFYrsflOa7uLGKj1HriiI7MNsH
   9blKYoZ0P6nrP7I4USYvf+zQvwqicR8icIiUS+k+OcwKzJ2QiNeFoI0SU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="393532292"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="393532292"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="773090842"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="773090842"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2023 07:02:31 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 0/6] ice: fix timestamping in reset process
Date: Mon, 11 Dec 2023 16:02:20 +0100
Message-Id: <20231211150226.295090-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (5):
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 226 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 163 insertions(+), 104 deletions(-)


base-commit: 9615a96563f03aef04320cb9b4c33f7bdabac5af
-- 
2.40.1


