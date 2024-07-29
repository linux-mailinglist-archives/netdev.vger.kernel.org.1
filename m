Return-Path: <netdev+bounces-113832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5430940110
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0F1F226E0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DA16F278;
	Mon, 29 Jul 2024 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5/XZ31q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7E8C07
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292481; cv=none; b=EWao6bXFn/buiEAYLfkAqCoIlJPGFia1wceKhrNbubM3VHXmf3JYAwwDG0iuEvVzlCHZhOwxZnDEZs/HZj0vNIrBdE0kUi7Ui+aSTp4Q23ScxgflmPM+Fkc/KUaVFeYskMuCkuyaLagH7RpPoMCItOsU2uoCtQMBAwkGx6VWr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292481; c=relaxed/simple;
	bh=6L+0xrR/MihgoKP1dcaxNzH3agLad9CBlBWVHZ7jK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSasMwc3Y4jNALICyDR06K5n/3lgrZMhk2WODxPUrS89g7b7cFBUBQ9S02mEYypg7jMke1Hz7DRuQzr4G2RCxh48Qr+I/vxjImbrYhFPbAFbXevt8D4S8tiGmQvGLEa6N3Yx7M0h7pWuFrlGZ41rqYGRystPOgJ+pPH7FgBGfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5/XZ31q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722292479; x=1753828479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6L+0xrR/MihgoKP1dcaxNzH3agLad9CBlBWVHZ7jK6k=;
  b=g5/XZ31qY1SwJuf/5rGrPQECob7nMF7RDIQKKbArySG0O583wDcnTH03
   mlGV3yzAPi4FlcU+wlrwHQxAeE3qLGuzB9LFryl0rQBWO6cZdT79nGhtv
   kNkG/1Jo4k8sSyl1qeDi6QePZxiyOvWQNjJW3Hg871o08T7AojIkYIaSU
   TLQCPlD520CmbKxCN/VKVEDXwhTFyoVadq/gltQR6porJ5IgHTO+FMye5
   c7yCYKgwF9iMS/WZhsGTBYFekWZ/wpsKTB29Sc/DV4ZKlVsJtIwulU8Bk
   1a8sPzvvaF5+oAreEEqN7uoaO4vTkUp+TWSsC5PspbwAh1JAr22ITaU7o
   Q==;
X-CSE-ConnectionGUID: mlDE3EsoSbyRkAoduJn1ug==
X-CSE-MsgGUID: NPCYDaMsTIKRP20/e3HyfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20216773"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20216773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:34:38 -0700
X-CSE-ConnectionGUID: 6YFGXsl3SBOzQiqPVwvvQw==
X-CSE-MsgGUID: wcSXQJVeTtuyHIWzCfKLlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="77344525"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 15:34:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com
Subject: [PATCH net-next 00/15][pull request] ice: support devlink subfunction
Date: Mon, 29 Jul 2024 15:34:15 -0700
Message-ID: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

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

The following are changes since commit 1722389b0d863056d78287a120a1d6cadb8d4f7b:
  Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

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
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 331 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 26 files changed, 1396 insertions(+), 137 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


