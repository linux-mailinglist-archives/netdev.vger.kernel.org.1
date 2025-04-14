Return-Path: <netdev+bounces-182162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797CA880FE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C41682B1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4D71EB36;
	Mon, 14 Apr 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsN2dFpy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55440433CB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635660; cv=none; b=MvNM5i9Bm5fw92S+uO3n7LiqYQ5OfhB/53D2hR3GytOLwCzIdyfZBvg6ndOyvbHnjHF3v2SquVJG1lZlgzqBWybFl4yfBhMQYgbJfjXmz8EAHVmfbI5E4tTiHOyBbMcpPcxKf+eoB42Y7mpDBFRYuYchRwTrTOZka7wMBQulo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635660; c=relaxed/simple;
	bh=jynLSUFv14kvafwgTIampPYuFvfpvKX+LRxo1UjOTfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pxc0e2ovxGOYQY1gej4bv0J2RltOynmC79qwYWgYlbuBPECryS08UVYmsbD54P0j/kpQzAo5bdB6k4sbyX6SxNr1A2m1VG3anxlsYLtd2dPzvOXuY75957rBUvnaNPEre0EPBtSCzPcBhQCkvmIc3jbtIOVKs6afb8DMriWx3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsN2dFpy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744635658; x=1776171658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jynLSUFv14kvafwgTIampPYuFvfpvKX+LRxo1UjOTfQ=;
  b=QsN2dFpyb3OEPbrJJGNijsTV4bd4AaRqSr7TKP/nlRGrNdUyVKT3nDKh
   6kARKQ6CcZYjWT0YxAEdUDwlNpmN8Pns0+vf4FUsUlOdiJezHRsV5g7OG
   Yqx7ZefRcG4FehfzH3jmymHXqZbp2r3Bx6CHvhbDWilQA63lBnOQVW28n
   TQcSkCH4fRigFXQRtZe1qbHtu0+aqm1LObjH5JTWxizHwLd779Pg3tInx
   DwuuLtv42MOOWIGafktLZBvh0lG9pWEdf2ZdXpR7AL/bDJXlTUvQoA53C
   GbNUA/9VzxD3guHEWWE7+juxYv8vKfp2cAdqoEmSKlLORGH7tZw/rlKiB
   Q==;
X-CSE-ConnectionGUID: 1WiQzgMCS4eNvuxCZpxR1Q==
X-CSE-MsgGUID: Wa+6QaW9QlKhMkgSbvNMKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57468659"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57468659"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:00:56 -0700
X-CSE-ConnectionGUID: 4Y6frGfARFKnR03FsSV5Nw==
X-CSE-MsgGUID: gn3Q8UEoTHesO8TcNV/tUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134966814"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa005.jf.intel.com with ESMTP; 14 Apr 2025 06:00:55 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-next v2 0/2] Add link_down_events counters to ixgbe and ice drivers
Date: Mon, 14 Apr 2025 15:00:06 +0200
Message-ID: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
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

v2 -> v1:
used ethtool get_link_ext_stats() interface to expose counters

 drivers/net/ethernet/intel/ice/ice.h             |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 10 ++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c        |  3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  9 +++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 ++
 6 files changed, 26 insertions(+)

-- 
2.47.0


