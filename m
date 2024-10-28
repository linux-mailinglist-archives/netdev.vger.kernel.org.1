Return-Path: <netdev+bounces-139473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848709B2C37
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C291C2179C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3114186E26;
	Mon, 28 Oct 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/QQVALV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A78472
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109829; cv=none; b=fM0RDBydLbPyZbMWtWU7jW0Zfmv5LJc5X8Hd9MgVUV7VFWgXyeAIG9kat7dLEH+edHA+g1tP79poCU+ylc5/AQf0DL7LywALfg+OK4sT6atKVqTpZbElX2ulfh5RzZUABJV5GYugLbQwUt+ivgQFYoMrsx8TWDLjeQjB/0t/68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109829; c=relaxed/simple;
	bh=af/JTI5FMLotcKPq0HC4amBInS1wpiR0Ry9ax+mSdkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+N8sSyarJZVpqGTRhQJvjb1ePgOER+Z/QkrA43anxGKUkh8HQ7J7Ss+UBupI3YSW6TJjumbKKKxOF2fAJB07MDcH6XF2I1XHNbxjjEmeiKQHxK2CY7MXp6YD5li/blK2aoVHEmPYphL31ZUkQL9WZK93+dId6XDMhi1GpcZU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/QQVALV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109828; x=1761645828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=af/JTI5FMLotcKPq0HC4amBInS1wpiR0Ry9ax+mSdkU=;
  b=d/QQVALVWf0vRQz0sExpBOt/8aP6Ey22YGCrEmIRTo4bb5/gCg1Xlvm7
   02vVo5Ym/Pt6jq0BuK6qKucqCTMK89NW7y7zEYt63zk1C0f/OCX6MVkgL
   StD3vK7TeMDBH0CP2M7wWuWHhD9LYfxTLNzIQ+ekBfan2KcsZd9IABnbN
   F9T9hVSfXSIppOE/erWKxB9gDelutGMVpEdZvvbQpFtitlH4Eq4+8fE7T
   WTcsn9/T5cb6f6k8hE6HoTZt66EekwSIkWSs5C1k/goHAaPpvOnPo4scM
   YMgrZBVWeIrD9HRu8va2EBduf0TlLpgcWnYfp2f/DNtJ0ggOleFLB1C9s
   Q==;
X-CSE-ConnectionGUID: wdEayButSU6nqiq78wK3dw==
X-CSE-MsgGUID: APqafAwrThSA+cL7opkR1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29560706"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29560706"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 03:03:46 -0700
X-CSE-ConnectionGUID: cOVrWze/R++25KZk1tn0Ig==
X-CSE-MsgGUID: vfhcsBAxR2y/Cg0tPcyp+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86182268"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 28 Oct 2024 03:03:42 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM
Subject: [iwl-next v6 0/9] ice: managing MSI-X in driver
Date: Mon, 28 Oct 2024 11:03:32 +0100
Message-ID: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It is another try to allow user to manage amount of MSI-X used for each
feature in ice. First was via devlink resources API, it wasn't accepted
in upstream. Also static MSI-X allocation using devlink resources isn't
really user friendly.

This try is using more dynamic way. "Dynamic" across whole kernel when
platform supports it and "dynamic" across the driver when not.

To achieve that reuse global devlink parameter pf_msix_max and
pf_msix_min. It fits how ice hardware counts MSI-X. In case of ice amount
of MSI-X reported on PCI is a whole MSI-X for the card (with MSI-X for
VFs also). Having pf_msix_max allow user to statically set how many
MSI-X he wants on PF and how many should be reserved for VFs.

pf_msix_min is used to set minimum number of MSI-X with which ice driver
should probe correctly.

Meaning of this field in case of dynamic vs static allocation:
- on system with dynamic MSI-X allocation support
 * alloc pf_msix_min as static, rest will be allocated dynamically
- on system without dynamic MSI-X allocation support
 * try alloc pf_msix_max as static, minimum acceptable result is
 pf_msix_min

As Jesse and Piotr suggested pf_msix_max and pf_msix_min can (an
probably should) be stored in NVM. This patchset isn't implementing
that.

Dynamic (kernel or driver) way means that splitting MSI-X across the
RDMA and eth in case there is a MSI-X shortage isn't correct. Can work
when dynamic is only on driver site, but can't when dynamic is on kernel
site.

Let's remove this code and move to MSI-X allocation feature by feature.
If there is no more MSI-X for a feature, a feature is working with less
MSI-X or it is turned off.

There is a regression here. With MSI-X splitting user can run RDMA and
eth even on system with not enough MSI-X. Now only eth will work. RDMA
can be turned on by changing number of PF queues (lowering) and reprobe
RDMA driver.

Example:
72 CPU number, eth, RDMA and flow director (1 MSI-X), 1 MSI-X for OICR
on PF, and 1 more for RDMA. Card is using 1 + 72 + 1 + 72 + 1 = 147.

We set pf_msix_min = 2, pf_msix_max = 128

OICR: 1
eth: 72
flow director: 1
RDMA: 128 - 74 = 54

We can change number of queues on pf to 36 and do devlink reinit

OICR: 1
eth: 36
RDMA: 73
flow director: 1

We can also (implemented in "ice: enable_rdma devlink param") turned
RDMA off.

OICR: 1
eth: 72
RDMA: 0 (turned off)
flow director: 1

After this changes we have a static base vector for SRIOV (SIOV probably
in the feature). Last patch from this series is simplifying managing VF
MSI-X code based on static vector.

Now changing queues using ethtool is also changing MSI-X. If there is
enough MSI-X it is always one to one. When there is not enough there
will be more queues than MSI-X. There is a lack of ability to set how
many queues should be used per MSI-X. Maybe we should introduce another
ethtool param for it? Sth like queues_per_vector?

v5 --> v6: [5]
 * set default MSI-X max value based on needs instead of const define
   (patch 3)

v4 --> v5: [4]
 * count combined queues in ethtool for case the vectors aren't mapped
   1:1 to queues (patch 1)
 * change min_t to min where the casting isn't needed (and can hide
   problems) (patch 4)
 * load msix_max and msix_min value after devlink reload; it accidentally
   wasn't added after removing loading in probe path to mitigate error
   from devl_para_driverinit...() (patch 2)
 * add documentation in develink/ice for new parameters (patch 2)

v3 --> v4: [3]
 * drop unnecessary text in devlink validation comments
 * assume that devl_param_driverinit...() shouldn't return error in
   normal execution path

v2 --> v3: [2]
 * move flow director init before RDMA init
 * fix unrolling RDMA MSI-X allocation
 * add comment in commit message about lowering control RDMA MSI-X
   amount

v1 --> v2: [1]
 * change permanent MSI-X cmode parameters to driverinit
 * remove locking during devlink parameter registration (it is now
   locked for whole init/deinit part)

[5] https://lore.kernel.org/netdev/20241024121230.5861-1-michal.swiatkowski@linux.intel.com/T/#t
[4] https://lore.kernel.org/netdev/20240930120402.3468-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/20240808072016.10321-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240801093115.8553-1-michal.swiatkowski@linux.intel.com/
[1] https://lore.kernel.org/netdev/20240213073509.77622-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (9):
  ice: count combined queues using Rx/Tx count
  ice: devlink PF MSI-X max and min parameter
  ice: remove splitting MSI-X between features
  ice: get rid of num_lan_msix field
  ice, irdma: move interrupts code to irdma
  ice: treat dyn_allowed only as suggestion
  ice: enable_rdma devlink param
  ice: simplify VF MSI-X managing
  ice: init flow director before RDMA

 Documentation/networking/devlink/ice.rst      |  11 +
 drivers/infiniband/hw/irdma/hw.c              |   2 -
 drivers/infiniband/hw/irdma/main.c            |  46 ++-
 drivers/infiniband/hw/irdma/main.h            |   3 +
 .../net/ethernet/intel/ice/devlink/devlink.c  | 102 ++++++-
 drivers/net/ethernet/intel/ice/ice.h          |  21 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   9 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
 drivers/net/ethernet/intel/ice/ice_irq.c      | 275 ++++++------------
 drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  35 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 154 +---------
 include/linux/net/intel/iidc.h                |   2 +
 15 files changed, 328 insertions(+), 425 deletions(-)

-- 
2.42.0


