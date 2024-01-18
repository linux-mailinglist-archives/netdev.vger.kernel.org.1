Return-Path: <netdev+bounces-64245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82C831EA5
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B3EB25CEB
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF462D03B;
	Thu, 18 Jan 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHz6FW4f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE982D603
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599970; cv=none; b=I7segjVW5ABF4ngUvT0bgfGYh155MAMdOvvn65ibWmc/8nF7wzN0Y+k2HF64QJ5WtvPtrNAqW6CwrU8mNY13dprPVcAf5LaZvjCsGXU+NLEamo1NH/9iwCyDHLDAC8uBAV/EtnjSUzg5lRaX6kxBEnC+xgh2aEBYhhe004KE/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599970; c=relaxed/simple;
	bh=QVDzK7qu8Dn9oJm3knKewxlwsWJntp4EWgC54cySeok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taqi5LQoZb8pZazrWmDbzJNuLYGXN+c7IoC92T19ZfEhaPmhwcKfyG0zz1TZyzPG9M3hkVxqG+HfOU61qL2LhHNM6Ew3BJ4Zs2hYgtWV8z2ReRsB9kNsAqBTBLH/m+ecCGVgfpomemID6KiJ8NDeu6bJ48rv/TyjAaRd80G9p5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHz6FW4f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705599970; x=1737135970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVDzK7qu8Dn9oJm3knKewxlwsWJntp4EWgC54cySeok=;
  b=aHz6FW4fK873e8Y7QzmGOUrTk9ev0EsIOoJwabzWZZXW2RN3L32L135X
   nkEsX7upEVQKCcA4AVmwtzdv99L/vdcOIMZ1ynWmCFv1tTrAiWJ8oTjM+
   864PcHs/i3T7DKhsnnmyyeNEhzOvRb69n5Ug0cwltW4OrxColnka7EfzO
   3HkUiVO8zC1LCgTB5ehQ4vo8Rd4q9+qkwdaIxkTmJeWXBkolbsds+lobD
   nQk76miCz3ScL8j90U/sILWpHI5OFree6jeU6KfG2frGpI2sUfVtxw3YQ
   K7icclJBt9hMkbtxR1A8/DymW94ha3PLOAsucXFWzh1z12rLsY8MBqoc4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="22001380"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="22001380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 09:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="26819567"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jan 2024 09:46:07 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v6 iwl-next 0/7] ice: fix timestamping in reset process
Date: Thu, 18 Jan 2024 18:45:45 +0100
Message-Id: <20240118174552.2565889-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (6):
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: don't check has_ready_bitmap in E810 functions
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

V4 -> V6: patch 'ice: rename verify_cached to has_ready_bitmap' split into 2
V4 -> V5: rebased the series
V2 -> V3: rebased the series and fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 229 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 164 insertions(+), 106 deletions(-)


base-commit: c8c06ff7ca5d9fc593fd634e3c3ff78a7e2bc5fe
-- 
2.40.1


