Return-Path: <netdev+bounces-166406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D519DA35F43
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F5C1661D2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F2264A68;
	Fri, 14 Feb 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EntKg153"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8524BBFE
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539829; cv=none; b=TOyry2fNmedf780MwdHw3tnW++V/1B+IKUHGbpMjNTXy2grizUdc8wRZCvNGvxOTZ91pVLNV6KWWH1JZF9ihla9qc4+t8rc0qyov12/WbgaOeoBErQqVRyFY4JR2SJzUruXb7sy7LLPlOqv8HbIx/MhB1bgXl2QBcauYhToiZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539829; c=relaxed/simple;
	bh=AS29S8jBIY6gtkdcAFHeXi4qGHONZ2Gpcr1OaLv9Dyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDZ+HRm2tNH9s/lnmR0/GE1dva2TOW9G4eGoU81qu4Lahyf942694hjPeMVGvvwVAcFcI0ANh5BNos6NgFxp4SRJCcBrM76WwYj2Zoj2v4bxQrxmHab0dzOa4xvJyzrpAmKWO8gATzHTVL445Jil9MW162OqDrjyDCz5t+qr4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EntKg153; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539828; x=1771075828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AS29S8jBIY6gtkdcAFHeXi4qGHONZ2Gpcr1OaLv9Dyk=;
  b=EntKg153xfKZp5E6/e6WPIiWhd/wgAfGyo+rGA7ekSx+FjJQhniFc1y1
   aKKANNq6tpNX/HmHBLpkbUIap9bbyiCP/paVM0I+3DTODHkuf9tHc3Zik
   WWiJhDwxd0hg9IVazZaVB95iirYNugfEt9MmOu+Xf2dVKoYwqidHhhvsG
   on3cmL+T1Uq+6ktamcL+aRyp6MrEHM/prLHJB+eoG9DvNCStEtue/WZ7W
   rmniGLVjLPv5l9YOgsLssZ59fyIzie0C3U2fkkBq6EvYgJRmAMtnrQN5J
   DP9l8ePKFgq0LHMYi8Q7b0pZ5ZbeLIR/9WDsx6Mzn0dXmYNlWKZWWeErk
   g==;
X-CSE-ConnectionGUID: +/Y0M7YVSYy1s3hm259RrQ==
X-CSE-MsgGUID: wb65eOy9RMKjwY/Avj9EEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40159275"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40159275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:30:27 -0800
X-CSE-ConnectionGUID: RKwB1/PyT5Obt8053aO1CQ==
X-CSE-MsgGUID: yGwirmg4Td2ENlz7pm/xpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114094300"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2025 05:30:25 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	"mailto:przemyslaw.kitszel"@intel.com, jiri@nvidia.com,
	horms@kernel.org, Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 00/15] ixgbe: Add basic devlink support
Date: Fri, 14 Feb 2025 14:16:31 +0100
Message-Id: <20250214131646.118437-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create devlink specific directory for more convenient future feature
development.

Flashing and reloading are supported only by E610 devices.

Introduce basic FW/NVM validation since devlink reload introduces
possibility of runtime NVM update. Check FW API version, FW recovery mode
and FW rollback mode. Introduce minimal recovery probe to let user to
reload the faulty FW when recovery mode is detected.

This series is based on the series introducing initial E610 device
support:
https://lore.kernel.org/intel-wired-lan/20241205084450.4651-1-piotr.kwapulinski@intel.com/
---
v3: introduce to the series additional patch touching devlink/dev.c
v4: introduce to the series additional patch changing netdev allocation
---
Andrii Staikov (1):
  ixgbe: add support for FW rollback mode

Jedrzej Jagielski (10):
  devlink: add value check to devlink_info_version_put()
  ixgbe: add initial devlink support
  ixgbe: add handler for devlink .info_get()
  ixgbe: add .info_get extension specific for E610 devices
  ixgbe: add E610 functions getting PBA and FW ver info
  ixgbe: extend .info_get with stored versions
  ixgbe: add device flash update via devlink
  ixgbe: add support for devlink reload
  ixgbe: add FW API version check
  ixgbe: add E610 implementation of FW recovery mode

Przemek Kitszel (1):
  ixgbe: wrap netdev_priv() usage

Slawomir Mrozowicz (3):
  ixgbe: add E610 functions for acquiring flash data
  ixgbe: read the OROM version information
  ixgbe: read the netlist version information

 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixgbe.rst    |  105 ++
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ixgbe/Makefile     |    3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  571 +++++++
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   21 +
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1510 +++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   16 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   86 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |   12 +-
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |  708 ++++++++
 .../ethernet/intel/ixgbe/ixgbe_fw_update.h    |   12 +
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  258 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  161 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |    2 +-
 net/devlink/dev.c                             |    2 +-
 26 files changed, 3332 insertions(+), 240 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h


base-commit: 0a5f2afff8673e66160725b8ec8310f47c74f8b9
-- 
2.31.1


