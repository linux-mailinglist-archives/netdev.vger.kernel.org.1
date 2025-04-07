Return-Path: <netdev+bounces-179954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8AA7EFD9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4677A37E5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488652116ED;
	Mon,  7 Apr 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BItBlcAS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF91ADC67;
	Mon,  7 Apr 2025 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062689; cv=none; b=ZTXmjAmvvOo6A40khRCUg4Iwom2+KzJbwn8+ZjWshC/PW3ZL/wHiFVwvE4TRruGun7VRYwTCfF31h8jW2A2AMMdOig3cdkEcO4TLSOxQBR7oGT/cpw+L76hUPv2l4Wm8YKW2tYMjEsWnqPv0T1kKfsOQ0dXF8FDLWxRfqJs8+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062689; c=relaxed/simple;
	bh=Mp/3znzsz+Ey98Dg7VZONCKmnt7Xmt3n7NQSJaYaQow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ie22Svb0l6uEoq3Jyeo3XpWGsV1mAe2gyIEXZQ6Kgqxn+WrjHVgBlqUJarNvLJTKDPhRrsNEfIpt+tbjpfqp01GAeBdkITxogwX6vGc94LYH5WgvYzZSPxDSlZb01B0tBDKEclpfzPXaW/h2Hr3YXZ3W44KJZKK8XG4KjgXk9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BItBlcAS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744062688; x=1775598688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mp/3znzsz+Ey98Dg7VZONCKmnt7Xmt3n7NQSJaYaQow=;
  b=BItBlcASr5J4smlKskN1xfDEw43CvnDt3Hl+Q6udZHFK6zszAi2td4hq
   N/9HlZI/ctjbCjeucjEpj/NNx2riKwXkCmA8IiRfU5dDnv63IEFTjCPem
   NWVmxw+iLZC0jBYYfv+PyP6MOneThXVkgTDeQq/lUo0ZnCs9Ebn6o6uHS
   huE9j+XwkX3sRcfqSKVrDfZ75uaLDiEDwmYArv/3/Dd/nt8lZxkl5M5f4
   rYlRQ45D+YSTjxzZruo3tgEH9SYV++XxXZqpyqJazUwmj+7Se0zyvFneS
   eMdxNs6Z6nuLhFwTZP//CJKevvsTv3a9B5LhbOC4QIh54nv8n6RwktgTX
   w==;
X-CSE-ConnectionGUID: VNAiRUdbRYyGNDsCzqiCJg==
X-CSE-MsgGUID: 3oO+23/GTyqLkTrMB5A6Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49268564"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="49268564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 14:51:27 -0700
X-CSE-ConnectionGUID: r2F3yJ1xRMmynGWnuhLm7g==
X-CSE-MsgGUID: BaGnbDt5RfWbNYpm/ICb2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="133055738"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2025 14:51:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 00/15][pull request] ixgbe: Add basic devlink support
Date: Mon,  7 Apr 2025 14:51:04 -0700
Message-ID: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jedrzej Jagielski says:

Create devlink specific directory for more convenient future feature
development.

Flashing and reloading are supported only by E610 devices.

Introduce basic FW/NVM validation since devlink reload introduces
possibility of runtime NVM update. Check FW API version, FW recovery mode
and FW rollback mode. Introduce minimal recovery probe to let user to
reload the faulty FW when recovery mode is detected.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250313150346.356612-1-jedrzej.jagielski@intel.com/

The following are changes since commit 61f96e684edd28ca40555ec49ea1555df31ba619:
  Merge tag 'net-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

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
 Documentation/networking/devlink/ixgbe.rst    |  110 ++
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ixgbe/Makefile     |    3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  582 +++++++
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   21 +
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1512 +++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   18 +
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
 26 files changed, 3359 insertions(+), 243 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h

-- 
2.47.1


