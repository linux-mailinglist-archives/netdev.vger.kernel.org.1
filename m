Return-Path: <netdev+bounces-76523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C945486E09B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1793DB2169B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BC6CDC6;
	Fri,  1 Mar 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpbAkD5y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AB6931B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293791; cv=none; b=VGgVDeBcnbfMJ9p9MWbm2AkUhnnR6wYbtt1+GlpJlt0K1g8qjVdwNH+2aqexaQpAz7Ne06oSusICkxmrAEgnPAG1z3uNHR0mRQLDaMNxu4XwE/4AANErU3eSi+0bVJ1cpZYLpr9iptK3wjYQczy4C1KMSq5n9Mo7j1FUWq6mwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293791; c=relaxed/simple;
	bh=mtwcUNm96eIoo1Taovp0m0XkY+ZEMgl5G3UFN02ThdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmW2yKlQFl7pXNo68e4CLsGzH5OKBe91LYLD5iJSHSQSSDxXekrA+gCr0peQOJ8dSUfZth6AxtzFquJOW/xIB4vk/mUtpa2BVAVF82EHWlLJllQbJp0ojtXjK0wrBlYINax/PIxix1toOl2e4a5p5qVKeDXRAT96hdrTOHvVJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpbAkD5y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709293790; x=1740829790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mtwcUNm96eIoo1Taovp0m0XkY+ZEMgl5G3UFN02ThdY=;
  b=TpbAkD5ytkFfyMjTehXgtqx/+BaOh7PzUWZcKkslHz9gJx3ZDspLx3br
   5aPpn0wEjy9xs48Q9lsOxrJOwTeaB6EKbew6kf5+4oJXUSA8aulHeYP94
   clgBdG27NBhRyCPvwWIq3f7/pmGdJ3NCa4DZsXoVfcizB5T0v7NB8nkyB
   9RJqIhYLxGYxXHzan45FSvozmZRJYkcyWVqNdkq6fYBwARjxI5fis1GlP
   na5jcoHht7lC0O3hK2RobAl0AReUhkxEfarTzGJ16UotUxIFdeiQi9Ce2
   oqaO0z80EZExisxm+2BFO+7Tr86jOrxKZUKPBqLHEt43Z9oYoJHiXqBne
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4000024"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="4000024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:49:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="39195027"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2024 03:49:47 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	sujai.buvaneswaran@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v3 0/8] ice: use less resources in switchdev
Date: Fri,  1 Mar 2024 12:54:06 +0100
Message-ID: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Switchdev is using one queue per created port representor. This can
quickly lead to Rx queue shortage, as with subfunction support user
can create high number of PRs.

Save one MSI-X and 'number of PRs' * 1 queues.
Refactor switchdev slow-path to use less resources (even no additional
resources). Do this by removing control plane VSI and move its
functionality to PF VSI. Even with current solution PF is acting like
uplink and can't be used simultaneously for other use cases (adding
filters can break slow-path).

In short, do Tx via PF VSI and Rx packets using PF resources. Rx needs
additional code in interrupt handler to choose correct PR netdev.
Previous solution had to queue filters, it was way more elegant but
needed one queue per PRs. Beside that this refactor mostly simplifies
switchdev configuration.

v2 --> v3 [2]:
 * fix problem found by Sujai [3]; add LB enable bit in LAG Tx rule
v1 --> v2 [1]:
 * more idiomatic error handling in config LAG

[1] https://lore.kernel.org/netdev/20240125125314.852914-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240202145929.12444-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/PH0PR11MB5013FE0E638F52C059BC9A5F964C2@PH0PR11MB5013.namprd11.prod.outlook.com/

Michal Swiatkowski (8):
  ice: remove eswitch changing queues algorithm
  ice: do Tx through PF netdev in slow-path
  ice: default Tx rule instead of to queue
  ice: control default Tx rule in lag
  ice: remove switchdev control plane VSI
  ice: change repr::id values
  ice: do switchdev slow-path Rx using PF VSI
  ice: count representor stats

 drivers/net/ethernet/intel/ice/ice.h          |   7 -
 drivers/net/ethernet/intel/ice/ice_base.c     |  44 +--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 362 +++---------------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  13 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  53 ++-
 drivers/net/ethernet/intel/ice/ice_lag.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  49 +--
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 126 +++---
 drivers/net/ethernet/intel/ice/ice_repr.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 -
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   1 -
 18 files changed, 232 insertions(+), 489 deletions(-)

-- 
2.42.0


