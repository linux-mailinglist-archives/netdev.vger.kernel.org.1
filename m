Return-Path: <netdev+bounces-226225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD9B9E4AA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE733B74AC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4452E8B8F;
	Thu, 25 Sep 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U29J0cfn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E125A631
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792200; cv=none; b=RP8RgKO7WsaSjKMll053MiypTzCX+AQM5B9Co3vZtkWc0bvAv7/nk8WCH5hMAwtU2Uk1i9hKTrdjWUqObRrua2hps2Q0mEgflLvE9Li7ogkpa1NQ9h+UIBv3XHK2xE8emu/iGf2IR/6PgP/qtKdKoUtg/3irrNjrrm6RAykir5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792200; c=relaxed/simple;
	bh=hziz8ecxwUxtmhqfVmrk5zyNrYYPEepYYr8bU3ObER8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6O0KyYSdNwtZTXpJlqQUlJFgIE0AyjhUd706NOJUHoHQdJyIx5aldB1Vqii0MHTt9FSoFeTB3BpMzlNACzrTjhFUc7hW/g0rb6iYGalhEqAz2x+0Cf9VwSjgj9nyGsPPnpHgqTnroHZqmnFEJITcyA5ocW7kgUrgtK8pAZoFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U29J0cfn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758792198; x=1790328198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hziz8ecxwUxtmhqfVmrk5zyNrYYPEepYYr8bU3ObER8=;
  b=U29J0cfne3pTSWJv4JIBdzT3Z9Y15Rfwl5/nF4Z0XpBwRpXYx8CqLTHD
   kjKYjxgcwju/GGXfsXqBDLGhaq1XqSg1J5Nt857Hlrob9LkdhaGHu/06n
   CzgJ0eFWxiWbsjVhLYM1jNeiDMeqhn8jqh8OFBv6ss4piWHVnNphpX3ES
   6G3DCaryxIYWEcUHAKNS/HhvZYDaZ2boI1ahX57M1kPHdJ59vhN7/2V47
   Ak6kVV5VYfGe67z65vTpbEyRG/QXXLPXFUzS4zLFOAlFey6p/QDW9qxrs
   awzQkkdCGL4gcNwN2m41N6RSz1j1zQsJxX3BOh/oSjichpYU35iJGmtLl
   g==;
X-CSE-ConnectionGUID: 0GgphDVGTHCvo91V0Ak0sA==
X-CSE-MsgGUID: fosg0JqLSU6s+RK6xAk2fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71724547"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71724547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:23:17 -0700
X-CSE-ConnectionGUID: JMsNwcIMS1GAmsC9Bet67A==
X-CSE-MsgGUID: fuM4GIUNSjmXLbCcs8nfFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="214411791"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:23:15 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de,
	anthony.l.nguyen@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next v3 0/3] ice: convert Rx path to Page Pool
Date: Thu, 25 Sep 2025 11:22:50 +0200
Message-ID: <20250925092253.1306476-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the Rx path in the ice driver by removing legacy
code and switching to the Page Pool API. The changes follow the same
direction as previously done for the iavf driver, and aim to simplify
buffer management, improve maintainability, and prepare for future
infrastructure reuse.

An important motivation for this work was addressing reports of poor
performance in XDP_TX mode when IOMMU is enabled. The legacy Rx model
incurred significant overhead due to per-frame DMA mapping, which
limited throughput in virtualized environments. This series eliminates
those bottlenecks by adopting Page Pool and bi-directional DMA mapping.

The first patch removes the legacy Rx path, which relied on manual skb
allocation and header copying. This path has become obsolete due to the
availability of build_skb() and the increasing complexity of supporting
features like XDP and multi-buffer.

The second patch drops the page splitting and recycling logic. While
once used to optimize memory usage, this logic introduced significant
complexity and hotpath overhead. Removing it simplifies the Rx flow and
sets the stage for Page Pool adoption.

The final patch switches the driver to use the Page Pool and libeth
APIs. It also updates the XDP implementation to use libeth_xdp helpers
and optimizes XDP_TX by avoiding per-frame DMA mapping. This results in
a significant performance improvement in virtualized environments with
IOMMU enabled (over 5x gain in XDP_TX throughput). In other scenarios,
performance remains on par with the previous implementation.

This conversion also aligns with the broader effort to modularize and
unify XDP support across Intel Ethernet drivers.

Tested on various workloads including netperf and XDP modes (PASS, DROP,
TX) with and without IOMMU. No regressions observed.

Thanks,
Michal

---

v3:
 - Fix the offset calculation for XDP_TX buffers in patch #3 (Larysa).
 - Remove more dead code (Olek).
 - Remove all hardcodes introduced in the patch #2 (Olek).
 - Add an explanation about the performance drop for small MTU on XDP_DROP
   action in the commit message for the patch #3.

v2:
 - Fix the traffic hang issue on iperf3 testing while MTU=9K is set (Jake).
 - Fix crashes on MTU=9K and iperf3 testing (Jake).
 - Improve the logic in the Rx path after it was integrated with libeth (Jake & Olek).
 - Remove unused variables and structure members (Jake).
 - Extract the fix for using a bad allocation counter to a separate patch targeted to "net"
   (Paul).

v2: https://lore.kernel.org/intel-wired-lan/20250808155659.1053560-1-michal.kubiak@intel.com/
v1: https://lore.kernel.org/intel-wired-lan/20250704161859.871152-1-michal.kubiak@intel.com/

Michal Kubiak (3):
  ice: remove legacy Rx and construct SKB
  ice: drop page splitting and recycling
  ice: switch to Page Pool

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_base.c     | 123 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  21 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 647 +++---------------
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 125 +---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 146 +---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
 drivers/net/ethernet/intel/ice/virt/queues.c  |   5 +-
 13 files changed, 212 insertions(+), 962 deletions(-)

-- 
2.45.2


