Return-Path: <netdev+bounces-114874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6394488D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83ABDB29684
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B6016D9A0;
	Thu,  1 Aug 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwmNzh/l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA6163A9B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504681; cv=none; b=hgGmOBwLsbW2dZEo+6rdytqgZ+L5jswKfMV+vpLYI+u5Xkx+cBxUhYutb9ZpTFnLj5MZJiGdeFBrAGiqAlvDt6LjLnP4AL/M5wvgk6u4PfhPMNzxAXn2OJ1CPIe7zHpY6Yce6sMycI7a5Ec+pHZ8eZHBL79thLq0X1+2RspyiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504681; c=relaxed/simple;
	bh=6FiAgBs+c2Z8zw0V3g2iXv2BRxFN7ioMj7oOa7ictZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRWSghEbaM16+UTJ7TUb8A2npK9DyrxyitiJ48f/KtM23q0Z3qOl1FOyqd1gFyh3rMYDFFQxC9WBowKnuH92LvPKUJnXgBZs9oajmegtHFiWpVbOm0ckF4j2TUOAqIbv2zIoVzKtDInqo6OiQoDzNGgjpMhnQPvX4UIrZX1E0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwmNzh/l; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722504680; x=1754040680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6FiAgBs+c2Z8zw0V3g2iXv2BRxFN7ioMj7oOa7ictZ4=;
  b=IwmNzh/lVtukkls5q1+jzO6g3IwrhGG58xjgq4T8OaY8XvbYcVp9xuf/
   RaOG/g44ElsG9v355mf+kSL1o8WDKCUBjFLGaqXXBuySbbssEz0dsdo62
   IbjNL/0hU005cJ7Pn4WEfEjT9t2j1TxUFPEV8kPLqzHC6bwd6G5rB0i88
   xt1G2p5zLHKbDqW9/6WE4kHyInMyKUbHF48Z2WMRVA2GgWdXz8nTRbkyT
   B/rRlpMczoyVqtFUp7Jy10qIUZnxn0RH0PUNcXYaHP77Haxgjh9C8r8GY
   x3g5wx4P46vu3XNfMfgw/LQpi+u/gVPv0wcT7fqXhjzD3Z39++6etj2aa
   g==;
X-CSE-ConnectionGUID: YgehUISfQhqzYBawkoWQ3A==
X-CSE-MsgGUID: eGYtt8TqSqOxKD4l16Yd3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="23363358"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="23363358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 02:31:19 -0700
X-CSE-ConnectionGUID: HMxJr4khSJSsgvSn2K0ibA==
X-CSE-MsgGUID: +hdhW9fLT6Wiro12VeXO6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59628127"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 01 Aug 2024 02:31:16 -0700
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
	jiri@resnulli.us
Subject: [iwl-next v2 0/7] ice: managing MSI-X in driver
Date: Thu,  1 Aug 2024 11:31:08 +0200
Message-ID: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
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

v1 --> v2: [1]
 * change permanent MSI-X cmode parameters to driverinit
 * remove locking during devlink parameter registration (it is now
   locked for whole init/deinit part)

[1] https://lore.kernel.org/netdev/20240213073509.77622-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (7):
  ice: devlink PF MSI-X max and min parameter
  ice: remove splitting MSI-X between features
  ice: get rid of num_lan_msix field
  ice, irdma: move interrupts code to irdma
  ice: treat dyn_allowed only as suggestion
  ice: enable_rdma devlink param
  ice: simplify VF MSI-X managing

 drivers/infiniband/hw/irdma/hw.c              |   2 -
 drivers/infiniband/hw/irdma/main.c            |  46 ++-
 drivers/infiniband/hw/irdma/main.h            |   3 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  75 ++++-
 drivers/net/ethernet/intel/ice/ice.h          |  21 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
 drivers/net/ethernet/intel/ice/ice_irq.c      | 277 ++++++------------
 drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  36 ++-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 153 +---------
 include/linux/net/intel/iidc.h                |   2 +
 13 files changed, 287 insertions(+), 423 deletions(-)

-- 
2.42.0


