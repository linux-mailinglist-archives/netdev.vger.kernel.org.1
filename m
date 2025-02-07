Return-Path: <netdev+bounces-163924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF94A2C0C8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0C0169566
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306551DC9A3;
	Fri,  7 Feb 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKZc6cTu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916291DE3C7
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925028; cv=none; b=oAYAgwOUpGy+s+k4uWjcs5UqiRSyq9X+WDxUNPpd8D7wwGvFqqmFb7QkkO7an0g8NMFKVwGyXQn9xJufwi5YqeakN08dWbO8D+A+nI/wkXE0BcdTMxJYbxrVwfeBuLdUbxuOAI2avVTNZurEvwwPYybQpmNe8VjJHfHKsFwQd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925028; c=relaxed/simple;
	bh=+P3HLtADhmrmNGgsvWskNIvrO88Mxapm/ysDKpFFEqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzAm/0PJdfq11wio4vfv8ax4oFw03/zwEP09HjR6AU+kMFamgsPo0xh6jZrFz8YQN3tBE7aom9JssQvMPETMJxsBBVJCMz0wufo8cBENY0znz2Jzo6ol3zl5Zb4rX/dJmiE1qzUPbIF2vKpjOJbXFh9jkADvCvZ3e8RMi5BhtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKZc6cTu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738925026; x=1770461026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+P3HLtADhmrmNGgsvWskNIvrO88Mxapm/ysDKpFFEqY=;
  b=DKZc6cTuQl+r8pJnVsDGYlloWebxP4BqgIxyfOJLRSiqU7jmZEdGUjcz
   RLM+xGWaldvFKHztfyaCh3AawS2tW4xRRe0WDuXWKFi3Ik0oCUx8RUivL
   dOU1a6ZZN8As/FwwgZavXVRj/YVpLAkm7tRBSJBSMVVIBe0w+63gLnt9D
   3CiSMEHfZHCyXkw/gUhGQ1EYnaNVMPGQ7N8FypGwjTBMiCGuT49KfmNL8
   uOfqmPI3AqIgDs5WZsCR/kh+Eui4PiExfNjkdAoWkqpxcT4sIC1fb75qw
   EiBRld/AmTl9k0xMrI8HCe8TPilRifx9HehKljPCFWHUYrnoZQy2nXYo+
   A==;
X-CSE-ConnectionGUID: Lpw6NGv8SEarQbXzPAbDEA==
X-CSE-MsgGUID: +Ea+ijchS4Cgc+thWIh2WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="62039827"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="62039827"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 02:43:46 -0800
X-CSE-ConnectionGUID: a+RYWCvIS7OVefdW2AaAvA==
X-CSE-MsgGUID: 4UFibppgSHSXkCarmM2WRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116429784"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2025 02:43:44 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com
Subject: [iwl-next v1 0/4] ixgbe: support MDD events
Date: Fri,  7 Feb 2025 11:43:39 +0100
Message-ID: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset is adding support for MDD (malicious driver detection) for
ixgbe driver. It can catch the error on VF side and reset malicious VF.

An MDD event can be triggered for example by sending from VF a TSO packet
with segment number set to 0.

Add checking for Tx hang in case of MDD is unhandled. It will prevent VF
from staying in Tx hang state.

Don Skidmore (1):
  ixgbe: check for MDD events

Paul Greenwalt (1):
  ixgbe: add MDD support

Radoslaw Tyl (1):
  ixgbe: turn off MDD while modifying SRRCTL

Slawomir Mrozowicz (1):
  ixgbe: add Tx hang detection unhandled MDD

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  42 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 224 ++++++++++++++++--
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  50 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 119 ++++++++++
 9 files changed, 430 insertions(+), 23 deletions(-)

-- 
2.42.0


