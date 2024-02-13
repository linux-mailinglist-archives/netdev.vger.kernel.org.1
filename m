Return-Path: <netdev+bounces-71195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F78529B2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C111F2105C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB51754E;
	Tue, 13 Feb 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kh5Qjqct"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B61754F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808991; cv=none; b=p0Y0OCL3yvXluKz2fgcDU3CDGyOuIuPO2Xd9+pYCCe3jZhb6f0rPudxIg00/RxLAs1Q6O0MvD+8CxmGib1MsFn4Q1wcUFHc5Yw7N6pWZ0s6W1Yb5wL2eFNj9k0dSzjEdOdkZ5YKdeaQAEKeW4JPxn+Al+HttDW0rQmMaGh6b544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808991; c=relaxed/simple;
	bh=fmMjSV/TwcjoFRbSnNFfL1tMSWdjsIk64WX/awgYy9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frawcxgqbzyY68fcTHSgF7re6HxleEUo/vi991KBFFPL1VbNb3y9A/UrAWjR1TFXeDqow4LzpCcKz7qxKrNPPNVU1hQLdcnNwGgmg/RC2cYtamPg48fFPnxH0hovMjcRmP1vqifc9Ur0HEvdBDSvRESNPy7DWr8ZmBuh/dM9Xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kh5Qjqct; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707808989; x=1739344989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fmMjSV/TwcjoFRbSnNFfL1tMSWdjsIk64WX/awgYy9s=;
  b=Kh5QjqctUiMyg8ZCR9bcyIdtEOTjq11963+jhKTRVyD5i/bFQ8ijqolm
   enr470rSZe94K+4Fn+F4q1FjZhdsoz2A6xXdUKOst5IjdCJ3lcG2EpI4H
   B8ed8iXltR/5Vx3ijkKaRwMYw6uA9nGP6MkWaE4zuDr1TegVV7HUsTGRJ
   m0LEH72Hs0gpx3UDaeAaCRczisU00cEpLjdFssTOlSvNnGm5XwXxJB37j
   x2b1SG4fThMYdtYkKSqVIh71ZfdCITX2dunbj3jmse5sKLvcos6CQRx/R
   jtjJwJ8PM6WZ0y5kGpfsiAC8UWzLpVT/w3Bn8DeHEccDLmBo1GW9+6ogQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27247930"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27247930"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385189"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:06 -0800
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 00/15] ice: support devlink subfunctions
Date: Tue, 13 Feb 2024 08:27:09 +0100
Message-ID: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Patch 1    -> Move devlink port related code to separate file
Patch 2-5  -> Add basic support for devlink subfunctions
Patch 6    -> Expose auxiliary bus devices for subfunctions
Patch 7    -> Expose auxiliary device sfnum attribute in sysfs
Patch 8-13 -> Add eswitch support for subfunctions

Michal Swiatkowski (8):
  ice: store SF data in VSI struct
  ice: store representor ID in bridge port
  ice: create port representor for SF
  ice: check if SF is ready in ethtool ops
  ice: netdevice ops for SF representor
  ice: support subfunction devlink Tx topology
  ice: basic support for VLAN in subfunctions
  ice: move ice_devlink.[ch] to devlink folder

Pawel Chmielewski (1):
  ice: add subfunctions ethtool ops

Piotr Raczynski (6):
  ice: move devlink port code to a separate file
  ice: add new VSI type for subfunctions
  ice: export ice ndo_ops functions
  ice: add basic devlink subfunctions support
  ice: add subfunction aux driver support
  ice: add auxiliary device sfnum attribute

 drivers/net/ethernet/intel/ice/Makefile       |   6 +-
 .../intel/ice/{ => devlink}/ice_devlink.c     | 468 +--------
 .../intel/ice/{ => devlink}/ice_devlink.h     |   3 +
 .../intel/ice/devlink/ice_devlink_port.c      | 986 ++++++++++++++++++
 .../intel/ice/devlink/ice_devlink_port.h      |  49 +
 drivers/net/ethernet/intel/ice/ice.h          |  19 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   3 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |  84 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |   4 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  43 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  53 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  70 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 197 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  23 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 354 +++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  36 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 28 files changed, 1902 insertions(+), 578 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ => devlink}/ice_devlink.c (80%)
 rename drivers/net/ethernet/intel/ice/{ => devlink}/ice_devlink.h (90%)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


