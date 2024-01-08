Return-Path: <netdev+bounces-62396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3D826EE1
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A101F2102E
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6078E41767;
	Mon,  8 Jan 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTuehdpX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F340C1C
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704718046; x=1736254046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VGs+ZJUpKX3KvN3rtWTzrwtVsSqIw06Chl2fIx+a8vc=;
  b=UTuehdpXh3XRwcYwzqUxODqfAdUiTFZ8mQR6EbG5AV3a6xIlyi1kzGOL
   Kdywj5NKLN9pliO1SXgmGZOc2oquYqDeoEPot2lrXgCplwSK8jibsUvC5
   q32ueMwLhpphnkdJ72Mk3qOVAW4Cf2f8E29h2pkeU7HO2WMXTRZopVoDt
   40t/pDKWda5jtKxADi5XeWYFAG2pupROs8+CYw/+ZJXV5VgdUOLseXB5U
   5Z403wbscHG7Xn6XP+Chg3KxYTOUgzz3OQ3bFKQBsDGT/3HzArD/syIgF
   yodFtthdoSoZlcceBC3sW5qa2OX73jyvDbLMDP8p+b+TicAyAn47MiYSl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="11359547"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="11359547"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 04:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="904791302"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="904791302"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2024 04:47:23 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v5 iwl-next 0/6] ice: fix timestamping in reset process
Date: Mon,  8 Jan 2024 13:47:11 +0100
Message-Id: <20240108124717.1845481-1-karol.kolacinski@intel.com>
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

V4 -> V5: rebased the series
V2 -> V3: rebased the series and fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 231 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 166 insertions(+), 106 deletions(-)


base-commit: 006c8fe67ee86e7810f2aa3b365ab6de65cf2299
-- 
2.40.1


