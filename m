Return-Path: <netdev+bounces-183271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E3A8B8CE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0DB7ADF04
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215A2356C9;
	Wed, 16 Apr 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0Fsj0Od"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90544221272
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806180; cv=none; b=QfFBs7M902j3gv0zzrybYiU9wxGX+hZm4g8IAdz00mGQJuqsVzNMFn1b8i6+odr0if3dmhU3o5o/bVO67VpNKXVYxKkhitCFihzlXKmsZ3owUg0pp/tZ6ZM50jDAIDwQYSPlQQtH94kKvJi6eDXmoaoWumg1JlXUgu0UF9iC3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806180; c=relaxed/simple;
	bh=O7ppKADWcPNedSeoi8dWIZcBDs/KP37bDVC2WFQKRlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyZMPq0Ho4tsCeN9Hfs8lORaHusO46AwXEDOYj8hsSsNNg2g88xmRr/Hn3Q7vTFo9YmHB/y5JpNKFErFlj4H3n4NiQJljYIesHxC+XMqDvZAv4ozdKutNqpnwIRx3PqZkrI7j1oMpi3BLWY7c5PfmuXnUAvOiKdC8HbpT/nTKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0Fsj0Od; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744806179; x=1776342179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O7ppKADWcPNedSeoi8dWIZcBDs/KP37bDVC2WFQKRlo=;
  b=m0Fsj0OdLdfaPu04tzWxkx2LNXNpc3uJ4HahCGavO52t2R2cW20PBKgB
   DoLnFJuPDmvtZqeNXyjCGNmQHZHx2ltAH/ogUSqwBoxjfe9X6DHEv2xQm
   x+FsoD9Es1iFzGl0iW315i1CE5lJc8LtkCj3UzuC1l2eMGFocuCZM3zxJ
   slbp9nJejh31VJqc3edKwZKtzS/PN11B6ElOlhvyjiW2nXXLo8A+9ZtOB
   Pz5ciOHkJpggH6oStqRYVKHaBKGYczP6JXVOYZfRzsQH5lzkbQc90qDMS
   W7kwIQTAYOhyvf9bRxfDg7ub2ob2pfxlcIKTxbe7KQF74EDvu6A7dLMOA
   g==;
X-CSE-ConnectionGUID: VXhreCYUQiyq9InXZlhV0w==
X-CSE-MsgGUID: hwEA5vzlRNe6ejbMom59jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63888911"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="63888911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:22:36 -0700
X-CSE-ConnectionGUID: 4eTuMUCKQECIJie+NFtlqw==
X-CSE-MsgGUID: XgSqlmdmSaaa3yxFLJ0kwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130477168"
Received: from gklab-003-014.igk.intel.com ([10.211.116.96])
  by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2025 05:22:35 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v12 iwl-next 00/11] idpf: add initial PTP support 
Date: Wed, 16 Apr 2025 14:18:58 +0200
Message-ID: <20250416122142.86176-2-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
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

v11 -> v12: restore missing v9 changes - fix Rx filters upscaling,
check if the link is up in idpf_hwtstamp_get/set 
v10 -> v11: change timestamp extension algorithm, use one lock for
latches lists, allocate each index latch separately during caps
negotiation, fix virtchnl comment
v9 -> v10: create a separate patch for cross timestamping, change the
order, improve get device clock time latch mechanism
v8 -> v9: fix Rx filters upscaling, check if the link is up in
idpf_hwtstamp_get/set, fix typo
v7 -> v8: split Tx and Rx timestamping enablement, refactor
idpf_for_each_vport
v6 -> v7: remove section about Tx timestamp limitation from cover letter
since it has been fixed, change preparing flow descriptor method
v5 -> v6: change locking mechanism in get_ts_info, clean timestamp
fields when preparing flow descriptor, add Rx filter
v4 -> v5: fix spin unlock when Tx timestamp index is requested
v3 -> v4: change timestamp filters dependent on Tx timestamp cap,
rewrite function that extends Tx timestamp value, minor fixes
v2 -> v3: fix minor issues, revert idpf_for_each_vport changes,
extend idpf_ptp_set_rx_tstamp, split tstamp statistics
v1 -> v2: add stats for timestamping, use ndo_hwtamp_get/set,
fix minor spelling issues

Milena Olech (11):
  idpf: change the method for mailbox workqueue allocation
  idpf: add initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilities and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add cross timestamping
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping

 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   35 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |    3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   75 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |    4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   57 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 1019 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  379 ++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  171 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  673 +++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  314 ++++-
 18 files changed, 2929 insertions(+), 103 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: ea9052a7d46c1d95f5af10b9ab907e5c5fa8a4f8
-- 
2.43.5


