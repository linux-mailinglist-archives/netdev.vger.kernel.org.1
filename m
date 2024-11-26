Return-Path: <netdev+bounces-147399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05969D9697
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784FC16181E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C89193407;
	Tue, 26 Nov 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9zxyTCT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BA17B506
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622024; cv=none; b=roZRSOkgP8+f2ccl3k2XhWmIeCuHLscy6eOZKtxLkBbOXvgHWYBJxyXmMUi+/OYbTVyEMZDV+OmayG52f0lIZ3hYfgl7wzxQ+vKLaEzAo1Vb/HwKN3w1bdM4ZWAM+WEvJG/6Q0ZZRusb0JuGwLAlgltVSATNrjZfitHT8rfRjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622024; c=relaxed/simple;
	bh=EIB3FtSRL8oTaqHLdbdcfjWMyd088jPawrHgcuTBnjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4FsScYLC9SAIgcAg+UQ9Umx9hO013jppRZWXcgvFn7HO207Z6kLPbsCIaZ8ujBHU6RJPGFfXj1Ugv1GB6f97O8lPe/6MlecX3S4iYSQ0wJzGqLkpp0bxka5+PNXwj+7SUPuLdj2iDK977PMRbuEWaZ2lpET31HQtYbGkzmseM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9zxyTCT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622022; x=1764158022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EIB3FtSRL8oTaqHLdbdcfjWMyd088jPawrHgcuTBnjM=;
  b=n9zxyTCTmRhM6BUWSj5L2WnvFeurVELS5ivQkuSzQk9QhhJpVExp27/L
   /z+Bu+RaoRMeeNm0p0l2iuKYNaHflxADu0pYv1B0H87rhKHS/xHNyGqDW
   l+6jii1ZyTeN/MrfHK6LrXnlvD0UEYtth3zvEP94UZ52zWs7nPtjEDskQ
   kuiCx1we6h31dMb6IoEDhvGKvRogroxY/JJslZZs4JYiy9CfK5rc1kQZH
   mKWQgVgqE0/ZA/9xjbCs9yz2MQMbSITs/yi+F1PrnPALbphY8rrFVAV9O
   1S1Sb9MkeHAfUluThT70ayPPCG9eu7bBT13Ka4tcALpQoFzS7Uj6n5gDv
   g==;
X-CSE-ConnectionGUID: Nx2OE00XRgmfnXJnpIS71A==
X-CSE-MsgGUID: lKHyN9rGTVmiRvhb+TIQDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="55276297"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="55276297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:53:41 -0800
X-CSE-ConnectionGUID: PMHGf35iTfO0ZYoCTw/LaA==
X-CSE-MsgGUID: 00XMoP9RQKmUnILe4YZwGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="91766664"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by fmviesa008.fm.intel.com with ESMTP; 26 Nov 2024 03:53:39 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v2 iwl-next 00/10] add initial PTP support
Date: Tue, 26 Nov 2024 04:58:40 +0100
Message-Id: <20241126035849.6441-1-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Precision Time Protocol (PTP) to
Intel(R) Infrastructure Data Path Function (IDPF) driver. PTP feature is
supported when the PTP capability is negotiated with the Control
Plane (CP). IDPF creates a PTP clock and sets a set of supported
functions.

During the PTP initialization, IDPF requests a set of PTP capabilities
and receives a writeback from the CP with the set of supported options.
These options are:
- get time of the PTP clock
- get cross timestamp
- set the time of the PTP clock
- adjust the PTP clock
- Tx timestamping

Each feature is considered to have direct access, where the operations
on PCIe BAR registers are allowed, or the mailbox access, where the
virtchnl messages are used to perform any PTP action. Mailbox access
means that PTP requests are sent to the CP through dedicated secondary
mailbox and the CP reads/writes/modifies desired resource - PTP Clock
or Tx timestamp registers.

Tx timestamp capabilities are negotiated only for vports that have
UPLINK_VPORT flag set by the CP. Capabilities provide information about
the number of available Tx timestamp latches, their indexes and size of
the Tx timestamp value. IDPF requests Tx timestamp by setting the
TSYN bit and the requested timestamp index in the context descriptor for
the PTP packets. When the completion tag for that packet is received,
IDPF schedules a worker to read the Tx timestamp value.

Current implementation of the IDPF driver does not allow to get stable
Tx timestamping, when more than 1 request per 1 second is sent to the
driver. Debug is in progress, however PTP feature seems to be affected by
the IDPF transmit flow, as the Tx timestamping relies on the completion
tag.

v1 -> v2: add stats for timestamping, use ndo_hwtamp_get/set,
fix minor spelling issues

Milena Olech (10):
  idpf: add initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilities and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping
  idpf: change the method for mailbox workqueue allocation

 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  30 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |   3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  65 ++
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  47 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 976 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 351 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 168 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  17 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 676 ++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 312 +++++-
 18 files changed, 2833 insertions(+), 99 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: be9bc5f29544142931d3958e972623a1db595af4
-- 
2.31.1


