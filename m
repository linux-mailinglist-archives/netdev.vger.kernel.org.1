Return-Path: <netdev+bounces-186890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F21AA3CE1
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F259A662F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BE280329;
	Tue, 29 Apr 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij6qy7rt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952028032A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970421; cv=none; b=ZC6xPdUfpiwqqhPGxPhcz3BcakM7VrxKPYxELCCpz6DAw2qQIQVNVvDxzqAlPv7VRPe9vEXANBHI7i4HuY7BFqVQRjc7lmqCopkdlYm138Dv6BbvtJn5FLkcugfoybSkZBTFKmnjfJB+7BNLLv9LSIzGMAXsCB/02i/Du7QGnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970421; c=relaxed/simple;
	bh=23rCrl1l1cqsfGwZtcXRXYPrfteccZLphk5IA2D0fNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8OHJZTcKVwUuzFIjwC5K822fwDl771iOsIidHUoalMOsPGVtMjt5ixqGsEGVGZtvf+EFIN1+2pLDlO9dLLZ7vxeM/FP9p11qpaDNFoKmRna5kge0nfjx6RbR71EpbegeJ2pEG1rO00vv3DVJ/nOCbY4EWVq70u0v01hXVJKfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij6qy7rt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970420; x=1777506420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=23rCrl1l1cqsfGwZtcXRXYPrfteccZLphk5IA2D0fNs=;
  b=ij6qy7rt+11L/SefL7ItUiNX2vagCxsN4m0u8dhzAPTpnqLz0ix1Wj/7
   44KGSd1mGnE69rOj+pwYoQUJePkE7Yw9iD9TA4m0A17ITZpn1oEhUrtUc
   Rp9EO3upOj4duvWwFEAvwZEmYHBTREHMU3maNkun1mss/I6bI1rtfHyFo
   lXGxcjL7GKeC3+hdtymLrcTa9mkM6CWI9ybT8E/UkenzCjkEWbDLozweK
   BQWKs8BxvOsq92xlC+fRfLX1NWrv3dkbXdi8yhAsNYiOCbCkXNunLigVn
   lWiS883peYU5inI4SCZj9krcnayOrP88uDAp4Kmp5MZaffft6tvUHhHpF
   w==;
X-CSE-ConnectionGUID: YO8JwytQRwK15x0sWrkN/g==
X-CSE-MsgGUID: OSafCDWTRBSbjkDUzEkQEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990048"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990048"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:46:59 -0700
X-CSE-ConnectionGUID: ptJMla2ZQb+d69XMi8CNcw==
X-CSE-MsgGUID: LfwrDWhxQ9yeHgxEQ31gcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979604"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:46:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver Updates 2025-04-29 (igb, igc, ixgbe, idpf)
Date: Tue, 29 Apr 2025 16:46:35 -0700
Message-ID: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For igb:
Kurt Kanzenbach adds linking of IRQs and queues to NAPI instances and
adds persistent NAPI config. Lastly, he removes undesired IRQs that
occur while busy polling.

For igc:
Kurt Kanzenbach switches the Tx mode for MQPRIO offload to harmonize the
current implementation with TAPRIO.

For ixgbe:
Jedrzej adds separate ethtool ops for E610 devices to account for device
differences.

Slawomir adds devlink region support for E610 devices.

For idpf:
Mateusz assigns and utilizes the ptype field out of libeth_rqe_info.

Michal removes unreachable code.

The following are changes since commit ff61a4a5dfc27535227c0b2ead05a1a1afce76ec:
  Merge branch 'ip-improve-tcp-sock-multipath-routing'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Jedrzej Jagielski (4):
  ixgbe: create E610 specific ethtool_ops structure
  ixgbe: add support for ACPI WOL for E610
  ixgbe: apply different rules for setting FC on E610
  ixgbe: add E610 .set_phys_id() callback implementation

Kurt Kanzenbach (6):
  igb: Link IRQs to NAPI instances
  igb: Link queues to NAPI instances
  igb: Add support for persistent NAPI config
  igb: Get rid of spurious interrupts
  igc: Limit netdev_tc calls to MQPRIO
  igc: Change Tx mode for MQPRIO offloading

Mateusz Polchlopek (1):
  idpf: assign extracted ptype to struct libeth_rqe_info field

Michal Swiatkowski (1):
  idpf: remove unreachable code from setting mailbox

Slawomir Mrozowicz (1):
  ixgbe: devlink: add devlink region support for E610

 Documentation/networking/devlink/ixgbe.rst    |  49 +++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  18 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  25 +-
 drivers/net/ethernet/intel/igb/igb.h          |   5 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  78 ++++-
 drivers/net/ethernet/intel/igb/igb_xsk.c      |   1 +
 drivers/net/ethernet/intel/igc/igc.h          |   5 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  18 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c      |  39 +--
 drivers/net/ethernet/intel/ixgbe/Makefile     |   3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   2 +
 .../net/ethernet/intel/ixgbe/devlink/region.c | 290 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  29 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 171 ++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  13 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  14 +
 18 files changed, 667 insertions(+), 97 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/region.c

-- 
2.47.1


