Return-Path: <netdev+bounces-174199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA1A5DD9F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6167A18963B6
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE52459F6;
	Wed, 12 Mar 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJwq7tfP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E624338F
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785177; cv=none; b=ime6ELd0Zv2VgiAfaeO6m7i8NRVt5jhTU8WRP4syt5tb8A5jpugHXgovO+dI5/6gBu8T2MT5pg5kg5O6itUcllWzlaFLJHZkS52d0ZEfT6Y+Kzd+Z1RvbblGnQIi/hYKb5TvHhiS1R0/4SgsUG56VzYYTr1zFmbsTq3uFLg54Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785177; c=relaxed/simple;
	bh=ebtUdL7x+P1BZSl0p+b3iP4EYbjPvBEbMyFX9UN5+Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePddmBg8dMcrsqZkNeuGcTvFe4sT0sUXbrkuWxhC+8ierMpOqv7jkuRgO1nmP0NN0WhKWF6I34LkFI4RDbIRk5HMKvHriQVVrmZ6eJYEhaMqJmf+0xul2IHmjLINDBIVerdjo/kQA5kPNcUJqjUoxUxt5sf2CukwMQ5yQvh6jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJwq7tfP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741785176; x=1773321176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebtUdL7x+P1BZSl0p+b3iP4EYbjPvBEbMyFX9UN5+Fc=;
  b=TJwq7tfPMEexcHlDRonV1SpUTEzjAQDfDDQDvoVG3jgQz0CVuEi6v2pV
   z+Zfd3mPfmZyZjeHeNruujVp7tSyM6Gaeh+wzYN3ux/QWREKIL3NawXfC
   bA65pkyfKedn+tENuEO/TAi5GEnn/ymGAr2+bd1GzYIBrZH1jVuRHIABU
   ckrO21LQYEQGFqMUoR3PFD+TYmpssibnP08OJzuRzyoKceW4zy1yYKSU7
   T0asMh1mcULc46NWsPTkJlnIbfmzZ3JvVpWwwuNIeUdAI+7sl3B1JxcwZ
   4vaB65jJ7JqIYS0Is1iE1Pxx4aoFg8Ve/xTseuTVp/X+HxFZPmabHLSlp
   Q==;
X-CSE-ConnectionGUID: MVQPr301TwGpaSnSNNe9sQ==
X-CSE-MsgGUID: gUtxFgPcTQKrGG6wQfZ4sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53510657"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53510657"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:12:54 -0700
X-CSE-ConnectionGUID: PQSk0ZcrSSmVLr9EZwWaWw==
X-CSE-MsgGUID: FFx2ZXN2TtiTLfFc/j1ZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121542042"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 06:12:52 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v7 00/15] ixgbe: Add basic devlink support
Date: Wed, 12 Mar 2025 13:58:28 +0100
Message-Id: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
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
  ixgbe: extend .info_get with() stored versions
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
 Documentation/networking/devlink/ixgbe.rst    |  107 ++
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ixgbe/Makefile     |    3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  585 +++++++
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   21 +
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1515 +++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   16 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   86 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |   12 +-
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |  707 ++++++++
 .../ethernet/intel/ixgbe/ixgbe_fw_update.h    |   12 +
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  269 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  161 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |    2 +-
 net/devlink/dev.c                             |    2 +-
 26 files changed, 3361 insertions(+), 242 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h


base-commit: 0a5f2afff8673e66160725b8ec8310f47c74f8b9
-- 
2.31.1


