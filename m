Return-Path: <netdev+bounces-148346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF49E139D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E19D282573
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61331865EA;
	Tue,  3 Dec 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUtz5e4f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5E176AA1
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209104; cv=none; b=pep2J8oH/F3nwdxryvczpuoljfjN2Zg1LFAGO6UVzqAbHz6gWas4uZrYMDrQ9jVhbkV3+9SMR0/yF4Exi02oHD0QEtDFf87wad+mWPQJJBhAbEDEvOUQJ3nULn86Pk+jXB+fE00GhU44dgFGkoq9rcL2IPrGGZbBDm3uNR2AiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209104; c=relaxed/simple;
	bh=m7WjI6nwHce7B+Dt0tXOtDlBdaAbIGqHWDR7PhiBjjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmSalSifCk1NFJnODyx2xyXpEbwEuIUQBYaOL4JEmtP9zYk16twaikgs1xPdf6hnDKMVn7hRp8ZC2fIXwCpA116KnAgML2xZY08OO5CuKFLSvlwQSWELKBoHWEfl9NbYNUIk7CBQOY2a3OJ8218x47312TJ1SqGsrV23kpP3Pos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUtz5e4f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733209103; x=1764745103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m7WjI6nwHce7B+Dt0tXOtDlBdaAbIGqHWDR7PhiBjjo=;
  b=RUtz5e4fjgvPDftecE3z+upmJrytv4C1DdpZX65GtL84tr2Pwc67hj5N
   VXO3Qju3NlnnrTZrLxG+cUeCECsr2QFxoxVXOTA45LHs5B+l1NQ0w//Ev
   eP+oa97mHPRNGNu+3z406N0F/kGtfStflZy3t5zQmAFHGgCGwxuJIr6Wr
   hvYxrzWI7EcLzGlDHwOcCHlKen8RyImq0uzH4xvlkEHfo9avU6uJjphvR
   itYBi7WBjx6auwDpyFSckzGR4u2EnT6lxIMcHzPsqs/LJjAfmleurkVZZ
   w03shybjKb3IElxIgi0lv/lg0bqGwicEz+d3pIH/UFsOhWkrb+IdxqvXa
   Q==;
X-CSE-ConnectionGUID: fY55sAtuQ0uZ+jsWpbW/sg==
X-CSE-MsgGUID: XnamjMTwSxqW44FIH6uZ3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33330455"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33330455"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:58:22 -0800
X-CSE-ConnectionGUID: nN48hy6oTzqhGx52p6NnBg==
X-CSE-MsgGUID: 3YNjMIcoRkuG+RfntT9pkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93673670"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2024 22:58:18 -0800
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
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	himasekharx.reddy.pucha@intel.com,
	rafal.romanowski@intel.com
Subject: [iwl-next v9 0/9] ice: managing MSI-X in driver
Date: Tue,  3 Dec 2024 07:58:08 +0100
Message-ID: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
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

v8 --> v9: [8]
 * add tested-by tags
 * v8 was send incorrect, fix it here

v7 --> v8: [7]
 * fix unrolling in devlink parameters register function (patch 2)

v6 --> v7: [6]
 * use vu32 for devlink MSI-X parameters instead of u16 (patch 2)
 * < instead of <= for MSI-X min parameter validation (patch 2)
 * use u32 for MSI-X values (patch 2, 8)

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

[8] https://lore.kernel.org/netdev/20241114122009.97416-1-michal.swiatkowski@linux.intel.com/
[7] https://lore.kernel.org/netdev/20241104121337.129287-1-michal.swiatkowski@linux.intel.com/
[6] https://lore.kernel.org/netdev/20241028100341.16631-1-michal.swiatkowski@linux.intel.com/
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
 drivers/infiniband/hw/irdma/main.h            |   3 +
 drivers/net/ethernet/intel/ice/ice.h          |  21 +-
 drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
 include/linux/net/intel/iidc.h                |   2 +
 drivers/infiniband/hw/irdma/hw.c              |   2 -
 drivers/infiniband/hw/irdma/main.c            |  46 ++-
 .../net/ethernet/intel/ice/devlink/devlink.c  | 109 +++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   9 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
 drivers/net/ethernet/intel/ice/ice_irq.c      | 275 ++++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c      |  35 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 154 +---------
 15 files changed, 336 insertions(+), 424 deletions(-)

-- 
2.42.0


