Return-Path: <netdev+bounces-212229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF1B1EC95
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAB2582A6F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3648274676;
	Fri,  8 Aug 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biebfg3b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12792276038
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668641; cv=none; b=K7NxjmOIPEDcvgbp5winHIfJRAefAT3CKBm6FFuPjpDPxU/oLRMHUPHKoav3upE0KeX+fj70Stupbm6Wx1fJaZJACN2AfwKQIKqYvZ6DLe6xutOtaZpYBkmLHlxXJ9rnm/cd+oWom0G9JdOrcusB3ut5faHIjmvnKN3dXL7tdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668641; c=relaxed/simple;
	bh=cecSysv4GaVxekLvn8V684XwCGqf2shWl6eqL0HBOFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcEaVIU9Y2KPrJXjLGJfhn+/oGFJU1au0LBZYzIDMnRJv4I556VYegipcOkj4VfEhq1vlMO+0aKc5J/LsAZYUw4D9pAWzbUc8+dq1IRrXwkLCMd638NUZo5wgmROjvqceU4X8GM0sQ30D1yxqq/SKuLJWI4Ddj0z79rZcS5G9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biebfg3b; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754668640; x=1786204640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cecSysv4GaVxekLvn8V684XwCGqf2shWl6eqL0HBOFE=;
  b=biebfg3bNAApHwnEYpjgfZ9g5pPJLyxnLeUSoNoNK+fsi6BFhSyk5/30
   cWG9/l1RqYLb31KMsCmOo/zv9Tz/bTGMeyaphCM6pEZ2woYGHhy7cP3WS
   08M3Z8GgZC1kNdR+Z5mhu/HQI/mPcfKcYQa7n8pmd+5cdsYdosvrcl7G0
   8PRBjzheGYiD1RuxcQt03G7p64wMX+E486r7yJP9yDTJYTAHKIJGNe+Z/
   sslZ0XcLSYjamQf0QJ87zyiB0AROHBAzUm/q9xJG2AS4iLj45JGGbcyGO
   rWpKRqUoRuqHrxm6AC5R0VekJOWKVtPLp0xLD2N3tjfErVHomFKmt3gIm
   A==;
X-CSE-ConnectionGUID: FF5aBG6QRUy37DarBUfx7Q==
X-CSE-MsgGUID: UIQF8GkbSW+N1GA4Mh7yfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68099707"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68099707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 08:57:19 -0700
X-CSE-ConnectionGUID: hB66SZHVQGS+AmF2Q0kn8w==
X-CSE-MsgGUID: eXGzo5EITFKPFtRyqS7vdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169559875"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 08:57:16 -0700
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
Subject: [PATCH iwl-next v2 0/3] ice: convert Rx path to Page Pool
Date: Fri,  8 Aug 2025 17:56:56 +0200
Message-ID: <20250808155659.1053560-1-michal.kubiak@intel.com>
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

Last but not least, it is suspected that this series may also help
mitigate the memory consumption issues recently reported in the driver.
For further details, see:

https://lore.kernel.org/intel-wired-lan/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com/

Thanks,
Michal

---

v2:
 - Fix the traffic hang issue on iperf3 testing while MTU=9K is set (Jake).
 - Fix crashes on MTU=9K and iperf3 testing (Jake).
 - Improve the logic in the Rx path after it was integrated with libeth (Jake & Olek).
 - Remove unused variables and structure members (Jake).
 - Extract the fix for using a bad allocation counter to a separate patch targeted to "net"
   (Paul).


v1: https://lore.kernel.org/intel-wired-lan/20250704161859.871152-1-michal.kubiak@intel.com/

Michal Kubiak (3):
  ice: remove legacy Rx and construct SKB
  ice: drop page splitting and recycling
  ice: switch to Page Pool

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_base.c     | 124 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  21 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 645 +++---------------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  41 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   5 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 146 +---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
 13 files changed, 215 insertions(+), 874 deletions(-)

-- 
2.45.2


