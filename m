Return-Path: <netdev+bounces-106826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F291917D2F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492021F2127E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB58003B;
	Wed, 26 Jun 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgiE2cnH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B56173342
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396264; cv=none; b=HtlInfsdgMwpXOXvWASoEKJTJ/sWZqWR/o/wW9sG3VdYIjCIqZuw1B1ZJN3hNbSiAoULtVaWK7c2nFQsBf/gf52vTSmSNPyaBEb2R5UHjJmh7/jHTSyRcvB49RITEDOApx29W5V+R0xd6Rj2fdK0yqoz4WcCjy52aJByp6xLpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396264; c=relaxed/simple;
	bh=3HBoWOKl6SbY13vd0tm05QnlOYhyCgkxJmDDKHhVy5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kp1Ic4c6oztnu/hwokVgEqvBEcWVbk1y1P9qg+GEQt4egVp2c807cYYmjJ975x/T3TZJnXq/n+cSipuCkM3bhbJV4CKCBUPjOs90ZOhAcfNHTNarVBpCcGoIEgNtAtzXgYNAxAtZkqKFDwBJ32HB0JG6sT7ZlHU6oA3ELiWVZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgiE2cnH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719396263; x=1750932263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3HBoWOKl6SbY13vd0tm05QnlOYhyCgkxJmDDKHhVy5E=;
  b=PgiE2cnHalRVSfzqw8wJeDeZ7oTRpUHsV8r/CBe9W5iufSlPeRLD6N7E
   x4Dyqf7JTjwYQ31UuVgsvDNeAahU8BYC0NVybEK1vCFwE9FZfxAAkRj98
   yHKIQwDLtziuaKWc0xbW4fjNztLHgcERE1ZMPEPotFhJ7DAP/10xJoMxH
   jqceoZmGvk2DEKLrrS/QyQnvmF0vQE6LvRU8i0jICaoomrQ9opMshS3sP
   8MO47HLf1AT1qho0zFJGVlOkzFyZ4Z0HAeG0/76FTmiG9fpDAEzB0w/lv
   KEcAhNvaXpOpSy3ynqBZ/wfdD6FBSr3jLV/GhR7+SNxXz3WZQiZxJ0RL1
   w==;
X-CSE-ConnectionGUID: 73NbjjP/R3CAkgZ/0eKbaw==
X-CSE-MsgGUID: 52jWM0kNRPidD8mISdqiiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27145085"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27145085"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:04:22 -0700
X-CSE-ConnectionGUID: DS3510ETSKOPSRupHyzOVA==
X-CSE-MsgGUID: PsNyLdluQAmLNKnm9WKPsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="67162091"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2024 03:04:21 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v1 0/4] Replace auxbus with ice_adapter in the PTP support code
Date: Wed, 26 Jun 2024 12:03:03 +0200
Message-ID: <20240626100307.64365-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces multiple aux buses and devices used in
the PTP support code with struct ice_adapter holding the necessary
shared data

Patches 1,2 add convenience wrappers
Patch 3 does the main refactoring
Patch 4 finalizes the refactoring

Sergey Temerkhanov (4):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   6 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  21 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 338 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 111 insertions(+), 310 deletions(-)

-- 
2.43.0


