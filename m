Return-Path: <netdev+bounces-71212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9E8529D9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FBF1C21612
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549CE1756D;
	Tue, 13 Feb 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxXazEZx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D524914A96
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809454; cv=none; b=Iz6UD/jHS+ph77l5IhitoqCX28Z+vEEUzWcV85WKW8nBAicHy4cf44xdlup0jf/jsXRnA/MP8KX6fgPqRDd3ytBX90mQwSVfksPkscbF++878/L1thgEAr9ft0VTuzw/jYLpVachrsW0GZN5xocygJD9RexprMYmt+pN8xZwzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809454; c=relaxed/simple;
	bh=UT7AqtOeHiy16/k+wZnb/rch6zN8Plk2+nqOMcpTwUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcjTwzTwHNdrrhQf/mIqtxFPoUu5v14NtyP9AS664YotNMAk/r/Cl/AMcfDztx/rap0ObPgQRO/iJR86wl7VEqgSeTPhECIcX0TxkXggFU+xVZ/OcJSE9v3jprB0R/3qppj0yku+s1vk93UZynHkbGEKQnL6x91ThaOFWZWaCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxXazEZx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809453; x=1739345453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UT7AqtOeHiy16/k+wZnb/rch6zN8Plk2+nqOMcpTwUQ=;
  b=LxXazEZxTdjb6R8fSGQTMI9b/cvMn39QgVdMdPLmX1yjwKGkY+MLj3sU
   qoaLrpQvAmxwXh5u02RPfU8JHTqR7Se9VbMy6uz5XEm/uWrNAl9+uOqZ4
   mccjalM3b/8gfAj2/1tIAkXD3/bhL4xREfbBZsdI3euBFh6u+0SyLe7ob
   k11iWKdNeoqCU/m4hD+BeGIRcietbOHc7OtsBL9uMXtE8mdag43KdqL9Y
   YbJeDO6Ggcl73xoNr+I2CZFVdXzi8Je8KPRXhkwMhZX5V/hLSWO5kcNXI
   8HZ/Yj1Cd6h5cUVYBd8hLb1qK2VvP6BlMKG8UdqZluYUKO0XzkbHbXrIO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19219843"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="19219843"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2797523"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 12 Feb 2024 23:30:49 -0800
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 0/7] ice: managing MSI-X in driver
Date: Tue, 13 Feb 2024 08:35:02 +0100
Message-ID: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
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
RDMA: 128 - 73 = 55
flow director: turned off not enough MSI-X

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

Maybe flow director should have higher priority than RDMA? It needs only
1 MSI-X, so it seems more logic to lower RDMA by one then maxing MSI-X
on RDMA and turning off flow director (as default).

After this changes we have a static base vector for SRIOV (SIOV probably
in the feature). Last patch from this series is simplifying managing VF
MSI-X code based on static vector.

Now changing queues using ethtool is also changing MSI-X. If there is
enough MSI-X it is always one to one. When there is not enough there
will be more queues than MSI-X. There is a lack of ability to set how
many queues should be used per MSI-X. Maybe we should introduce another
ethtool param for it? Sth like queues_per_vector?

There is also a lack of ability to change RDMA queues / MSI-X. This
patchset moves managing RDMA MSI-X to irdma driver, but there is no
mechanism to change default MSI-X amount. Maybe devlink param for that
will work? We can think of storing this kind of param in NVM.

Michal Swiatkowski (7):
  ice: devlink PF MSI-X max and min parameter
  ice: remove splitting MSI-X between features
  ice: get rid of num_lan_msix field
  ice, irdma: move interrupts code to irdma
  ice: treat dyn_allowed only as suggestion
  ice: enable_rdma devlink param
  ice: simplify VF MSI-X managing

 drivers/infiniband/hw/irdma/hw.c             |   2 -
 drivers/infiniband/hw/irdma/main.c           |  46 +++-
 drivers/infiniband/hw/irdma/main.h           |   3 +
 drivers/net/ethernet/intel/ice/ice.h         |  21 +-
 drivers/net/ethernet/intel/ice/ice_base.c    |  10 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c | 114 +++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c     |  64 +----
 drivers/net/ethernet/intel/ice/ice_irq.c     | 271 ++++++-------------
 drivers/net/ethernet/intel/ice/ice_irq.h     |  13 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |  36 ++-
 drivers/net/ethernet/intel/ice/ice_main.c    |  18 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c   | 153 +----------
 include/linux/net/intel/iidc.h               |   2 +
 14 files changed, 327 insertions(+), 434 deletions(-)

-- 
2.42.0


