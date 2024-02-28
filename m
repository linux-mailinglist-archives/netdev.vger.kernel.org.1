Return-Path: <netdev+bounces-75763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9B86B1BF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B651F261A7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31489159574;
	Wed, 28 Feb 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCNJAiCp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14E1586E5
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130567; cv=none; b=V32kHfVnss4R7An4Raq7bQ5uO1TcJcqjxrp30ScsIOFadbnoj4acNCRIHEEwigqQi2tnyZbvPfxUXkU7CoOspVLGtCVJSlhbtgMVax4AMfsPgV7so2xUxE82IGC7xAtySGHtFpZjBM7NGfv+HU1SnmtVQvJePnVfJMsT3jpZ1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130567; c=relaxed/simple;
	bh=GeERZv5FxUm5eT6iirrpi8v1Wg64sAAxpmoKqxgAVqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GMdRfQ8OSZW5Jxt1d8U1POqlZLeZHUx3WCoj9emNnRMJbKTifpL63KVdJJ8HwLPymnGVaZQbvcqIqvfrnb9cARa1y1TOsBG6zTDVQii7uzdKb70k3/64J3F3wpRbyW80Eq58EqP61SEPFXHa0Cl2dJ+VVGBMTs8VkFxwbx/+iMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCNJAiCp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709130565; x=1740666565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GeERZv5FxUm5eT6iirrpi8v1Wg64sAAxpmoKqxgAVqs=;
  b=iCNJAiCpwkicleSDZUPsqeg4AAen/PGdpJWgHTqCshbpWG9347IcuhoF
   hIiyD7FEpT3DRJcpjdQNtH/QGhmowHWx36Jlewggw6Z0OfRLvdzQMETv2
   GfXhktx4uv5OEEb757ZN/MwruEc2/tgHNQFakjiAyniGRQQQvfmnxRRkn
   ZtYN39SOp7KBXsumk/71r6RpGVkf9QoPrw3dGNNoMo0rKxRDAEXA/m0LW
   BrmBXm65SXflN/pqHuwU15V1EU8DTqwqD4Du4Q/d4UgQTSMWSmohv1RIi
   gJZVbLf9cPnH/GBpj8oFppRQ+56QMTwoS+4NF0EzehPjaZa5nKZvft8gg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="25995525"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="25995525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="38281316"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 28 Feb 2024 06:29:21 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7045E36342;
	Wed, 28 Feb 2024 14:29:08 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	victor.raj@intel.com,
	michal.wilczynski@intel.com,
	lukasz.czapnik@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v5 0/5] ice: Support 5 layer Tx scheduler topology
Date: Wed, 28 Feb 2024 09:20:49 -0500
Message-Id: <20240228142054.474626-1-mateusz.polchlopek@intel.com>
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
v5:
- updated Documentation commit as suggested in v4 

v4:
- restored the initial way of passing firmware data to ice_cfg_tx_topo
  function in ice_init_tx_topology function in ice_main.c file. In v2
  and v3 version it was passed as const u8 parameter which caused kernel
  crash. Because of this change I decided to drop all Reviewed-by tags.
https://lore.kernel.org/netdev/20240219100555.7220-1-mateusz.polchlopek@intel.com/

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

 Documentation/networking/devlink/ice.rst      |  47 +++++
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
 14 files changed, 571 insertions(+), 45 deletions(-)

-- 
2.38.1


