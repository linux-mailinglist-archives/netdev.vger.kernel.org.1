Return-Path: <netdev+bounces-59541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7150B81B30F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 11:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266E81F2366E
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB24D590;
	Thu, 21 Dec 2023 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKHnoG1U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78624D11C
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703153022; x=1734689022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2pdqU/fhOSnNppi5YRr6U/bIHHK77ykrv+xLE5+YdNk=;
  b=RKHnoG1UnjQjjS8W54e4rVgFiJB6Hebc+5ssaE+a7lwAPEj1OaLbHKlB
   mpfqABNhBLOwvyR1wSUFlOdUyShQnuA3ywSJuFuPVNPaEJtEWmNYGKWL0
   8a2KgFPFjEFcvS6HnF6JFk6yx8SL97sGRnN5wJPKUDX7XtJBNBQ0ilrH9
   9zCJm9XblVpZL+XjOi/BoIQKgv0+lxljLn1QJ/N+hyXyPKdOsqXOSRcog
   pTmNzjMHf5QNL5GstsQ3CS8C3yN9VKNV1Cpb9DGcp69Ut/EapdkHnDCXn
   ASY4cs7KnEYA7bRHpM1LOtAIv9fpAbcoCqb/4IJthHylbEEPGnTZ6DpS5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482133660"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="482133660"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="949875380"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949875380"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2023 02:03:40 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 0/6] ice: fix timestamping in reset process
Date: Thu, 21 Dec 2023 11:03:20 +0100
Message-Id: <20231221100326.1030761-1-karol.kolacinski@intel.com>
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

V2 -> V3: rebased the series fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 231 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 166 insertions(+), 106 deletions(-)


base-commit: 67b40ee196fd2fd6d9b7f9b58912587c837bdc39
-- 
2.40.1


