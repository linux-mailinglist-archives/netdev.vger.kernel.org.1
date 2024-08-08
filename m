Return-Path: <netdev+bounces-116966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53A94C3BC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E52B27780
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928418B46F;
	Thu,  8 Aug 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw0HREzu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33720326
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138272; cv=none; b=tkDjPE+rnU3XuWTdyJOXTvBC0jGvxgrq8asNcvUkwJMpgt1ZRH09VGrpA1B/F+La0Rq7s+vuwCZdq5dAUcJnifMSI2XO9o1DvLa/MTUrLcOWobr4zeypEhBF4w7mVkLuD8mvbma1GtWaN7yjewA2h8psrWeoQWthkFwzV6CLPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138272; c=relaxed/simple;
	bh=07Fagsz20/bjxUJMlpqHDNxeOFaQAHYUluNrW9joHEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVgdU4npCfYMt6IV9YcYO35vonDtmdoHke4DA+5EwDnAAhsmnzTeMuca54OT34ZCWIvSlYQLnDvYrkOXJX/U9RC9Hg2L0KWYVyuubdAtToMKUpv2ZbQwMGpl+pLVFwhi6KzqyRkVXAY+3Tfrm8ZLpvP7Lr9bYbogRG1bXIHXJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw0HREzu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723138271; x=1754674271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07Fagsz20/bjxUJMlpqHDNxeOFaQAHYUluNrW9joHEM=;
  b=Kw0HREzuyvs36PXho1dCl23PWs/oYFI9BcjhulSk6KjiAUKV5+fWxy/u
   af+uicdj9D9hq8L6S1v9XT8NywUuONejRnRm5eWU7KQrxw8pUdjNT7+co
   n3q8Ni9YheviRxN0+tHvcF4czz2pxSN+jt7C0v91FX2i7gVLonuQp+Xuj
   cIzdWsII6YIkuiwbiVs3k6pybUneZMXVDDBT1wIqi6CitYS+G8H3Ju//J
   XD6QSXz+sYMyi2Kw/r2tmEVOZMDJEPAYKB9DPHFlWVdESYCyAP/Ax5wuc
   fa5n9Sv2tGdrsN4KX6wxfRKiJuAJDb54+IqLDXF9b4X0w2F4jgrRldTL5
   A==;
X-CSE-ConnectionGUID: E9OEeKv6SzmeU7yzyTMW0w==
X-CSE-MsgGUID: UaODglSrRWqDEdciYm7KGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32675369"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="32675369"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 10:31:09 -0700
X-CSE-ConnectionGUID: q1Ccjgn7S5uhaciOF4rIGw==
X-CSE-MsgGUID: P91cjrC5SL2Zede0YqZyWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61682410"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 10:31:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com
Subject: [PATCH net-next v3 00/15][pull request] ice: support devlink subfunction
Date: Thu,  8 Aug 2024 10:30:46 -0700
Message-ID: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
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
---
v3:
- move active checking into functions where it is set
- move devlink port creation for subfunction into patchset where it is
  used
- change error message in subfunction activation to be consistent
- remove leftover from patch 5 (sorry Simon that I missed your comment
  previously)
- add support for xsk ZC multi-buffer for subfunction netdev

v2: https://lore.kernel.org/netdev/20240731221028.965449-1-anthony.l.nguyen@intel.com/
- Add more recipients

v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/

iwl-next: https://lore.kernel.org/intel-wired-lan/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/

The following are changes since commit 91d516d4de48532d967a77967834e00c8c53dfe6:
  net: mvpp2: Increase size of queue_name buffer
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
 .../net/ethernet/intel/ice/devlink/devlink.c  |  46 ++
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 506 ++++++++++++++++++
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
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 328 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 26 files changed, 1395 insertions(+), 137 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


