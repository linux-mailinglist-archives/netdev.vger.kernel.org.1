Return-Path: <netdev+bounces-190673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C9AB844E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023067B0935
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D41E9B2F;
	Thu, 15 May 2025 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeIYlL2/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5601297B63
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306233; cv=none; b=D4htFw9Pk9FAMtpo0Rr8uaTHNZW2RGCqiE3x3tIzkQrzifMm4mUYXYzNe2/dhsHDQBtaaUwvlx8RYzYSBMBBtEkXmCj3h6G4qp8yr56TG7AM5bbcbLWHncLEe6pUncZbP+DA7VnijVUQlRT/5OBRSsonezd7TLhgBqi6y+I0eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306233; c=relaxed/simple;
	bh=44yPQ2Ewq7rCnqRQFn0AxLyqSxd/bLzf7YEzRJQQrCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsJi+bC7Euj0IG7sLSZLHQEefi+zgJxyPLJ8HxFr4QUtWh3XQMBodxDNslHe3I9o67NOvYmnD4ypPEqDp4Hh7+wRw2N7Hu+LH4n7kts/Paf3degsyuQOAkuTN1zUU491AphMbsPUChkngHMqDAspRA2KbamV7UdE7zBBjXj6O2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeIYlL2/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747306232; x=1778842232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44yPQ2Ewq7rCnqRQFn0AxLyqSxd/bLzf7YEzRJQQrCw=;
  b=FeIYlL2/SYCDhdDpIQt4fqjhLzj+sPLeY05a1zOC6d3poVklrlreCeoo
   pg/10j2GUSj4BzyB7mkcTuaREWO8Y3PxKGWDGFIxxfWSbBOQMttrVDvR2
   heDORXCwvyuSV+F2zdrEKf8BsY9yHnj/JMF9RX2NjuYjm8V1+db4YDysa
   P1jhXbIxPR3/uA1ATfsufzC7W+6aXFVkD/pbYu1j7xJc+qg72pMzeIqUI
   B9FwNRLaPBX2OWjzuvfOaZDIg3JeAPcJnIGcKJBU/0G09sZ0C9bH1DwmX
   U1s8gMo23Hv+0kjSgcpKar3zCbOODK9MlMw/GSiqrKFRkETooaJKa3V7R
   Q==;
X-CSE-ConnectionGUID: IR4XzAKmTZu+HgVBDWDhgw==
X-CSE-MsgGUID: BROhUQh5R22G4yb4li6kfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66786952"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66786952"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:50:31 -0700
X-CSE-ConnectionGUID: U7fOgo58RUihgvs8WWe3cA==
X-CSE-MsgGUID: iNttbOASQ3ew1RFbVsKVag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138873879"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa007.jf.intel.com with ESMTP; 15 May 2025 03:50:29 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	dawid.osuchowski@linux.intel.com,
	pmenzel@molgen.mpg.de,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-next v4 0/2] Add link_down_events counters to ixgbe and ice drivers
Date: Thu, 15 May 2025 12:50:08 +0200
Message-ID: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces link_down_events counters to the ixgbe and ice drivers.
The counters are incremented each time the link transitions from up to down,
allowing better diagnosis of link stability issues such as port flapping or
unexpected link drops.

The counter increments only on actual physical link-down events visible
to the PHY. It does not increment when the user performs a software-only
interface down/up (e.g. ip link set dev down).
The counter does increment in cases where the interface is reinitialized
in a way that causes a real link drop — such as eg. when attaching
an XDP program, reconfiguring channels, or toggling certain priv-flags.

The values are exposed via ethtool using the get_link_ext_stats() interface.

Example output:
#ethtool --include-statistics <ethX>
Settings for <ethX>:
        [...]
        Link Down Events: 2

Martyna Szapar-Mudlaw (2):
  ice: add link_down_events statistic
  ixgbe: add link_down_events statistic

v4->v3:
only cover letter edits
v3 -> v2:
ixgbe patch: rebased on latest ixgbe changes; added statistic for E610
no changes to ice driver patch 
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


