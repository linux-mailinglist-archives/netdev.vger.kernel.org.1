Return-Path: <netdev+bounces-93796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB68BD39D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA0E1F22441
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C313DDD8;
	Mon,  6 May 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmXE7cGH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C28F5A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015316; cv=none; b=OQpYtkxi/Neu9R9+DeF+qJLvbKhaH4ksdmL4trGyO1jOmKKSu2bIHwcdXeyrNywZ8iUjnfWVPj0/2f7zEV2q3/85NeF0T4x8R0Z+EPVBHfe8yYSupLor1U1PG6/E4SAKXZmR6zzjYF7qgWLIddGKZ38BZeUjXRYeI5/WVYXK1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015316; c=relaxed/simple;
	bh=bZbX8yTyuVoX5owZoFC1e/r8lSSRKEhsO9atCkGuguc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLCOHqQxRJU540daz6IbCINBvOiduJDKdfqjAno4ERTHtqDN7aoBXox5V+7Ax00Zj+OECzz7xqLfrF7gVpMCGVA7FX9NyAlqDOYEbhe5ep3aCynJUbFXH7kxYFtHMF1eybh7iz9lCRDv2/ztrxL3rlxDlC1B8VugGdFddLaN4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmXE7cGH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715015315; x=1746551315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bZbX8yTyuVoX5owZoFC1e/r8lSSRKEhsO9atCkGuguc=;
  b=YmXE7cGHsQ9LTpoo+PdF86GCAJNTg88wSltq2MUiMzXmR3VyJmPCoxDI
   INMXfpCYipI4ULyHl9QtBQwaB1lB8Ic5jlpQ9XzhqsCsFBJQ47TDThS/x
   Qlu9sn1MfANyX0qy+ZXnRgRdey8YZfD9byNWKQ9RSqTNRcdn+lYU0Niy9
   zgHjWcXxvDo+8+wZU/sMcBb4nG+iMiHiQQ9L/mzAh3fszrWgx6ZzJ5l91
   seWaG7x2hxcvgx3yF6EBdK9uTG4V9NjPyDXxiZLlaYw6nV3vkHDU0X1IJ
   M75CTNyVxNYrA5pOBHlFkDJ4+vHquQzx+nmzIwgWDXbVvcIfCLNEK2Og/
   Q==;
X-CSE-ConnectionGUID: VN0Wj9x7Ry6AmCPScsTUpw==
X-CSE-MsgGUID: rmmGDnlYTemQj6sc1ZASSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10896781"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10896781"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:08:34 -0700
X-CSE-ConnectionGUID: V/UNtrkBQhqFWbeJdn65nA==
X-CSE-MsgGUID: 43XVJYexTQ+G27k/LSm60g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33037423"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 06 May 2024 10:08:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2024-05-06 (ice)
Date: Mon,  6 May 2024 10:08:21 -0700
Message-ID: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Paul adds support for additional E830 devices and adjusts naming for
existing E830 devices.

Marcin commonizes a couple of TC setup calls to reduce duplicated code.

Mateusz adds ice_vsi_cfg_params into ice_vsi to consolidate info.

The following are changes since commit 8c4e4798123fd8e0c55e48e49db0f24287c18def:
  Merge branch 'add-tcp-fraglist-gro-support'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Marcin Szycik (1):
  ice: Deduplicate tc action setup

Mateusz Polchlopek (1):
  ice: refactor struct ice_vsi_cfg_params to be inside of struct ice_vsi

Paul Greenwalt (2):
  ice: add additional E830 device ids
  ice: update E830 device ids and comments

 .../net/ethernet/intel/ice/devlink/devlink.c  |  6 +-
 drivers/net/ethernet/intel/ice/ice.h          | 14 +++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 14 +++--
 drivers/net/ethernet/intel/ice/ice_devids.h   | 22 ++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c      | 33 ++++-------
 drivers/net/ethernet/intel/ice/ice_lib.h      | 39 +------------
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 +++++---
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 56 +++++--------------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  8 +--
 10 files changed, 82 insertions(+), 134 deletions(-)

-- 
2.41.0


