Return-Path: <netdev+bounces-101371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6058A8FE51E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA499B22643
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE19194C8A;
	Thu,  6 Jun 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RM6YSf2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14D1607BC
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672808; cv=none; b=LW1HbIWIklneY5qEOpXeyTvhb4s5Dje/4QF8nUG+XmYjR68vJSQfGNI+tSozcjAMYD4vnWUfnD4ypR/EapWrFicqFjp+7Mi5EnD2uupMwdZUgfa/T+OZjnuYMSXMc7tBLysmEzfy+ShsX30AHMBw/irOLV0TFyX5zQU2Nj1dZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672808; c=relaxed/simple;
	bh=4vhTgu3IWT84hCQV8QinoRx6X3Qlp5ZgSdsZDhps0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUQkC1IdzcQTog08NP8tlN2/6Jj1oxbkp7wzuAAKQVs8L0Pob488AS8rt6KlKZTU9uHDUKVHyOXtCzsZmM4bxfFDRWu6lj4dGIDDooxC265HI7ySQz/Rqv0XAMsW8/ymqSIq2E0qJtzAEfafn4N/RxYE1+QeeZBjHN8cXGqWZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RM6YSf2Z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717672807; x=1749208807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4vhTgu3IWT84hCQV8QinoRx6X3Qlp5ZgSdsZDhps0Ao=;
  b=RM6YSf2ZPdGVzmWZEAyTPHPLy2t6CxfcgcfHxgUsg4N34zdmFtU/YiNa
   MGpbwp1TNnNGzEOipmi47/fE9Gmk9da4gj6FjIk5wmOdIS6P2hpKcY1Kc
   KW/fiMVv4T6WYgpPIU9UTjAthcPglQM+5N2LzxVsehR8XF6CF3H3nY9Mw
   aHFcBVkKHnmL4PUP5xrULd+D4ZdABFUKyGdGzc1exYY06YPF4oSi0Rr2V
   i0HOGhqZ4NNPa/sKumOvsh1ukBgWt3Sw2kZ0WW2Q1M9JOBP/F//YlVxgj
   22unFiH/UMHdj+fMOZfPfxXunzYck9EHwg2mkzVaGDKv+/pFM0EPsF4XD
   Q==;
X-CSE-ConnectionGUID: US6WJhK5Q2Wv/jDZzLeYbA==
X-CSE-MsgGUID: blk3iBFgQpyn146CiqfY/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18123661"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18123661"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:20:06 -0700
X-CSE-ConnectionGUID: 1NP3tQa3T0yT3jMDx/eJTw==
X-CSE-MsgGUID: O3rz3D60SMOGYoAWFYinSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42864393"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 06 Jun 2024 04:20:02 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org
Subject: [iwl-next v5 00/15] ice: support devlink subfunction
Date: Thu,  6 Jun 2024 13:24:48 +0200
Message-ID: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Currently ice driver does not allow creating more than one networking
device per physical function. The only way to have more hardware backed
netdev is to use SR-IOV.

Following patchset adds support for devlink port API. For each new
pcisf type port, driver allocates new VSI, configures all resources
needed, including dynamically MSIX vectors, program rules and registers
new netdev.

This series supports only one Tx/Rx queue pair per subfunction.

Example commands:
devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
devlink port function set pci/0000:31:00.1/1 state active
devlink port function del pci/0000:31:00.1/1

Make the port representor and eswitch code generic to support
subfunction representor type.

VSI configuration is slightly different between VF and SF. It needs to
be reflected in the code.

v4 --> v5: [7]
 * use devlink_alloc() instead of devlink_alloc_ns() during subfunction
   devlink creation

v3 --> v4: [6]
 * fix comment in ice_allocate_sf()
 * return ERR_PTR instead of NULL in ice_allocate_sf()

v2 --> v3: [5]
 * fix misspealing in commit tilte
 * add missing doc entries in ice_dynamic_port
 * drop dev_err where extack is available
 * fix RCT in declaration

v1 --> v2: [4]
 * allow changing SF MAC address only when port isn't attached
 * split patch with port representor creation into two (first making
   code generic and than adding support for SF representor)
 * fix warning massege in case of SF device creation
 * remove double space
 * add verb in commit message

Changelog for previous patchset version (not containing port representor
for SF support).

v3 --> v4: [3]
 * get rid of unnecessary checks
 * fix cosmetic issues (whitespaces, wording)
 * move unrelated chunks to separate patch
 * move implementing activation/deactivation to last patch

v2 --> v3: [2]
 * fix building issue between the patches; allocating devlink for
 subfunction need to include base subfunction header
 * fix kdoc issues

v1 --> v2: [1]
 * use correct parameters in ice_devlink_alloc() thanks to Mateusz

[1] https://lore.kernel.org/netdev/20240507114516.9765-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240410050809.125043-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/20240412063053.339795-1-michal.swiatkowski@linux.intel.com/
[4] https://lore.kernel.org/netdev/20240408103049.19445-1-michal.swiatkowski@linux.intel.com/
[5] https://lore.kernel.org/netdev/20240513083735.54791-1-michal.swiatkowski@linux.intel.com/
[6] https://lore.kernel.org/netdev/20240528043813.1342483-1-michal.swiatkowski@linux.intel.com/
[7] https://lore.kernel.org/netdev/20240603095025.1395347-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (8):
  ice: treat subfunction VSI the same as PF VSI
  ice: make representor code generic
  ice: create port representor for SF
  ice: don't set target VSI for subfunction
  ice: check if SF is ready in ethtool ops
  ice: implement netdevice ops for SF representor
  ice: support subfunction devlink Tx topology
  ice: basic support for VLAN in subfunctions

Piotr Raczynski (7):
  ice: add new VSI type for subfunctions
  ice: export ice ndo_ops functions
  ice: add basic devlink subfunctions support
  ice: allocate devlink for subfunction
  ice: base subfunction aux driver
  ice: implement netdev for subfunction
  ice: allow to activate and deactivate subfunction

 drivers/net/ethernet/intel/ice/Makefile       |   2 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  47 ++
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
 drivers/net/ethernet/intel/ice/ice.h          |  19 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 113 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 329 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 26 files changed, 1395 insertions(+), 138 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


