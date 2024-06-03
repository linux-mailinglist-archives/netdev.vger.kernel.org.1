Return-Path: <netdev+bounces-100379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7538FA48B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B121F24C6E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A213C68E;
	Mon,  3 Jun 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aijqTTDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AE80603
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451487; cv=none; b=UgKL0EOUEPWRgmzXasdlF4N3Ho/w9MWYB5hL1fMXCzXGw+ENUrDXUYrqAvbwrHiYAF0cxGBYRwHk0nXTyumhYQXsd4FmkVyWa7fzs6jtE42C8XjXgjadX/pcjtHVL2fI9I4hWWbVB/lt3QviMgYmYrmzj/Reg0F9wc5hLIWtNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451487; c=relaxed/simple;
	bh=S5IIQlvNNKUU5rjEJQa2BPfxmYM3G+O4k9W2Zz3kin0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DhuUhowZUN4VXjTcyGnU+6AswnXce3PM8K+PxhAr2JohAce/54ZlxFixAN3TsfUsDSjeiIKkNnnE0D7r3dFuf1MqCt86YMIYqurIjNs+tamjFvjUzi2ZMrJM6wmvha9XtMdu6qvjlC1G2GSyKbrx2cMHAytO6Ik9mWJ2kkys/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aijqTTDJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451485; x=1748987485;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=S5IIQlvNNKUU5rjEJQa2BPfxmYM3G+O4k9W2Zz3kin0=;
  b=aijqTTDJ00CIe9noWfEvYgPGFGR3uYXeJHw9Nq80tuAaDa0SCdPwTWbN
   hlxVoGEtn4RCkpTUnIGs6BUiVKBoriGyNHWNL6WNQf8q1CYEP/qxRfZY+
   MrytDtTDr3522Ecec3MK/FFkdkrIh2J/QblntYBeey9ZpAz3BAObQm5Hy
   V0JzHrvnS+6iQatJtNNXzCL98HiWTtGzWWODobaraSRaRe8CzLgvg/tD/
   hZ6Ri1Lkp1A0F9cNru+O1y8r/mL/0B2DMWMY3ZgeRYvvAbkMkMLcfYPK+
   lfZKMQII9CrR4IhEJfg63hX3Th4Bd9kzkCxNrdslWGkQh9tC9p/2Jp9av
   w==;
X-CSE-ConnectionGUID: Wl5+ypvORF+hpI4RYAZSjA==
X-CSE-MsgGUID: +wd8lnMHRbC96uBvw3q2TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547582"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547582"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:24 -0700
X-CSE-ConnectionGUID: j4MqdJwPT7iGFmj4C2gwkw==
X-CSE-MsgGUID: cGO/AfW+Q76UOkmHonhkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608235"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 0/6] Intel Wired LAN Driver Updates 2024-05-29 (ice,
 igc)
Date: Mon, 03 Jun 2024 14:42:29 -0700
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMY4XmYC/42NQQ7CIBBFr9LM2jFQJUVX3sN0ITDYSZQaII2m6
 d0dOYHL9//P+ysUykwFzt0KmRYuPCeBfteBn27pTshBGHrVH5U5KExU8QeoDApyqvRoYeQ3FXT
 e+GCNCcMwgEhemVohjivIDEYJJy51zp92uuhW/etfNCq0Tmtv/cnFaC9tsffzE8Zt275NWo2k0
 QAAAA==
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, Simon Horman <horms@kernel.org>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, 
 Sasha Neftin <sasha.neftin@intel.com>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>
X-Mailer: b4 0.13.0

This series includes fixes for the ice driver as well as a fix for the igc
driver.

Jacob fixes two issues in the ice driver with reading the NVM for providing
firmware data via devlink info. First, fix an off-by-one error when reading
the Preserved Fields Area, resolving an infinite loop triggered on some
NVMs which lack certain data in the NVM. Second, fix the reading of the NVM
Shadow RAM on newer E830 and E825-C devices which have a variable sized CSS
header rather than assuming this header is always the same fixed size as in
the E810 devices.

Larysa fixes three issues with the ice driver XDP logic that could occur if
the number of queues is changed after enabling an XDP program. First, the
af_xdp_zc_qps bitmap is removed and replaced by simpler logic to track
whether queues are in zero-copy mode. Second, the reset and .ndo_bpf flows
are distinguished to avoid potential races with a PF reset occuring
simultaneously to .ndo_bpf callback from userspace. Third, the logic for
mapping XDP queues to vectors is fixed so that XDP state is restored for
XDP queues after a reconfiguration.

Sasha fixes reporting of Energy Efficient Ethernet support via ethtool in
the igc driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Fix formatting of return description in patch 3
- Link to v1: https://lore.kernel.org/r/20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com

---
Jacob Keller (2):
      ice: fix iteration of TLVs in Preserved Fields Area
      ice: fix reads from NVM Shadow RAM on E830 and E825-C devices

Larysa Zaremba (3):
      ice: remove af_xdp_zc_qps bitmap
      ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
      ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()

Sasha Neftin (1):
      igc: Fix Energy Efficient Ethernet support declaration

 drivers/net/ethernet/intel/ice/ice.h         |  44 +++++---
 drivers/net/ethernet/intel/ice/ice_base.c    |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c     |  29 ++----
 drivers/net/ethernet/intel/ice/ice_main.c    | 144 +++++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_nvm.c     | 116 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_type.h    |  14 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c     |  13 ++-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   4 +
 9 files changed, 258 insertions(+), 118 deletions(-)
---
base-commit: 6149db4997f582e958da675092f21c666e3b67b7
change-id: 20240530-net-2024-05-30-intel-net-fixes-bc5cd855d777

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


