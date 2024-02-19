Return-Path: <netdev+bounces-72886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4485A0AA
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCFB21AE6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9825574;
	Mon, 19 Feb 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuOePoPs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DD2560F
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337606; cv=none; b=st4YD6VCdqHQoDQlj6FcWlDnPf4nQN+sgfNQgFlt8929CUJuXVjohmPwwvnvdyzx/3SwotWq6K8ds8AXzdeM+BSqbfN79jvOBMbWkDRV28UV4yIONQVs4ByWgvp3yY8nkM6bI61SkjMUS2z+PQmPoigIGtfwNSe3v5p9Ojez7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337606; c=relaxed/simple;
	bh=c+9i/Hpy+GGiqTCB/ogIjQDd+5p6PB4nAvRyyj069qU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qbe2ylZvHfD3HXAqA78nMSl+RCL7yOwcQO6fvvm2qdDAnCkp9DiyOTkCPYrDCQaaTNPV2ZaQbNFfIE9tHdxiESwLsCHfwBKFNCAtj/ILAO1BL+S+fkyjgPF1QMiEbpKVx4gKAChf2+LmONtHz1G/VeJxjTN+E9QxxVASswLXhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuOePoPs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708337605; x=1739873605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c+9i/Hpy+GGiqTCB/ogIjQDd+5p6PB4nAvRyyj069qU=;
  b=ZuOePoPsWUDa3rDhn1qYRQqnir91yRUuN7Tj3/R29yjV+SoGjWp9fZ/q
   76QMpu1wwo8V4bdZCyTTccavqSknyibsBsS/pQFGWG2Uewy/8utWuVEWf
   nX8iipMq29D4eGjjK0UjqXnxWBJBgjg/JvcgGR5jn6B7ze+/wgv4U2D2P
   db+AwCxYLtmnP9DT/ILkkgzH4USLanlwm9EtlPlTBymYt6/pJpjqf0bIL
   AdtRUID93Bu2LLZOucYen9aH6PqPb84Pyeuemq9PYRzgR2F0/Qb/7qo5q
   9Tis9LKUJslieYmDpN8fxOMsUWCZdAFeexVWdcwZrGu1AeJ1s/5uLzgSm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="27855997"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27855997"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9123295"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 19 Feb 2024 02:13:22 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6890D12429;
	Mon, 19 Feb 2024 10:13:21 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v4 0/5] ice: Support 5 layer Tx scheduler topology
Date: Mon, 19 Feb 2024 05:05:50 -0500
Message-Id: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For performance reasons there is a need to have support for selectable
Tx scheduler topology. Currently firmware supports only the default
9-layer and 5-layer topology. This patch series enables switch from
default to 5-layer topology, if user decides to opt-in.

---
v4:
- restored the initial way of passing firmware data to ice_cfg_tx_topo
  function in ice_init_tx_topology function in ice_main.c file. In v2
  and v3 version it was passed as const u8 parameter which caused kernel
  crash. Because of this change I decided to drop all Reviewed-by tags.

v3:
- fixed documentation warnings
https://lore.kernel.org/netdev/20231009090711.136777-1-mateusz.polchlopek@intel.com/

v2:
- updated documentation
- reorder of variables list (default-init first)
- comments changed to be more descriptive
- added elseif's instead of few if's
- returned error when ice_request_fw fails
- ice_cfg_tx_topo() changed to take const u8 as parameter (get rid of copy
  buffer)
- renamed all "balance" occurences to the new one
- prevent fail of ice_aq_read_nvm() function
- unified variables names (int err instead of int status in few
  functions)
- some smaller fixes, typo fixes
https://lore.kernel.org/netdev/20231006110212.96305-1-mateusz.polchlopek@intel.com/

v1:
https://lore.kernel.org/netdev/20230523174008.3585300-1-anthony.l.nguyen@intel.com/
---

Lukasz Czapnik (1):
  ice: Add tx_scheduling_layers devlink param

Michal Wilczynski (2):
  ice: Enable switching default Tx scheduler topology
  ice: Document tx_scheduling_layers parameter

Raj Victor (2):
  ice: Support 5 layer topology
  ice: Adjust the VSI/Aggregator layers

 Documentation/networking/devlink/ice.rst      |  41 ++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  31 +++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 199 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 169 +++++++++++++++
 .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
 .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 102 +++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_sched.c    |  37 ++--
 drivers/net/ethernet/intel/ice/ice_sched.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 14 files changed, 565 insertions(+), 45 deletions(-)

-- 
2.38.1


