Return-Path: <netdev+bounces-189680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF9AB32B4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3F41883EA7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D4A24E4CE;
	Mon, 12 May 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvUB3DFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C913212A
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040745; cv=none; b=LJco1b4g4nfV79FOlCkHEhgKTUXZBFaqVvBVuTo97r1QJXQJhRGIFJI5UhnGrl6a8q2F4PegPJUPraVmxZ3V8Lehr0LcA4eplvMz+6fG7iYBQFSLMuPw8moLbVK6es1DZQSc5C+auNdd2LYMrZRWctMTx7+tJmDWJYAwg72USJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040745; c=relaxed/simple;
	bh=37USgan+qVadVMyB7rdtZtBl3URORBaWw8tpk4INn0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUqRAXit3TNb/DaRy0hMJzRt0AY/wDuuqIoHcfW9mSjiCcwPzbhLGCyH6EDWCb7TULlZ3fBKo8/hotkOH+RdMbzlOfq7xNdFzZPGgjxcdX711fMfiwrwAb02pvzxYgewK8ZgLz/9wlYfjPISzXPkagVQY+SM9u/RDt4pResfUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvUB3DFJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747040744; x=1778576744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=37USgan+qVadVMyB7rdtZtBl3URORBaWw8tpk4INn0g=;
  b=dvUB3DFJ/y7AUwg+6esJ+Flz9ZpdJqAyKwLOOkGSx7fnpkOkW5rQVXnM
   scM9SGLFF2PI08Dr7cjAQc1R+ttZjez39aak0eaWoE3TtH4QSY0hzRhex
   id0iZ2AEYxg4uFym55HkVEuP4WrC6TarVVeocrqEFAepxXzSLnAv11Md8
   Ds7VV/fik5hhXlNM/xg7CoDHRbEtKxuT4m+O4bpJchcK49Zp/1GCBdRz1
   O+xCxwr6xtJDaK52enl7EDRjng6JRp22dTKs5J+86OlQNmcCetZSdPed6
   pDtVc05kF0KLFqCllCk0loGGuEEDzWu4LqeDKw0I8nN6kLpRHkou5hYcX
   g==;
X-CSE-ConnectionGUID: 3p3yD7uBTRyfUDG3lQiyJA==
X-CSE-MsgGUID: llO1mL5aR0SWM6Ag4N+aNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="59459673"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="59459673"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:05:43 -0700
X-CSE-ConnectionGUID: maDKF4W8SKyHhmEMlwsXYw==
X-CSE-MsgGUID: AhRbfURUQQCBbIqcM0kLJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142262965"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa004.jf.intel.com with ESMTP; 12 May 2025 02:05:42 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-next v3 0/2] Add link_down_events counters to ixgbe and ice drivers
Date: Mon, 12 May 2025 11:05:14 +0200
Message-ID: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces link_down_events counters to the ixgbe and ice drivers.
The counters are incremented each time the link transitions from up to down,
allowing better diagnosis of link stability issues such as port flapping or
unexpected link drops.

The values are exposed via ethtool using the get_link_ext_stats() interface.

Martyna Szapar-Mudlaw (2):
  ice: add link_down_events statistic
  ixgbe: add link_down_events statistic

v3 -> v2:
ixgbe patch: rebased on latest ixgbe changes; added statistic for E610
no changes to ice driver patch
v2 -> v1:
used ethtool get_link_ext_stats() interface to expose counters

 drivers/net/ethernet/intel/ice/ice.h             |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 10 ++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c        |  3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 ++
 6 files changed, 27 insertions(+)

-- 
2.47.0


