Return-Path: <netdev+bounces-153282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A688C9F78BB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EC418924CF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C469222588;
	Thu, 19 Dec 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipndYt67"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523752206BD
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601510; cv=none; b=ISNgLsKayAHQZUpi4Zkv8XHO8yGFJpUMp/emQdb5ZhTRuczgh5kG1Vd346HjTXqVvCsNLWJwCBPUNV11fw5FQ3mNwG108+iIdqtnaLRrbGKIXfRzNpuszypfDvk1vQn0tFqasDU4YfgLTfA1voWglUPBA8k8ZLPe1uwEogYtOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601510; c=relaxed/simple;
	bh=OnSysRNRDBcDQ6Qn1zB9z0uy94irNy8/o0/Qw3+wCH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5M/g2GQNO153LP/mJfvkb+a8dJB+rJDTS/UopfRFNGICuII1goEhXY2Yfi5xHkTvgv0n8YB8uQDEXyHkVluc20BGO47DvIJSbgBoZE5KFCNydwUK5ph90lL0KyrUdv6OTHQPvJk9f/x4HoQMZq9VSJ6SPNEy9dOPSAH46XpQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipndYt67; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734601508; x=1766137508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OnSysRNRDBcDQ6Qn1zB9z0uy94irNy8/o0/Qw3+wCH4=;
  b=ipndYt67RPsGCp5O31B5f8H73hLn+hZuke5NDiPCbb4axWuFAlCLKf5S
   tMzpZWQlIHcHjziFEjIDDAMjHFDcSMcUbTNqEx/gMGfLs/mQPSWOa2uaU
   aULYqo3be2AYmXOsaGYa449xacw9u9ZPqttl7d+22I++gX3BvIWmphfEM
   tmZ8ITmMtMhI7x9cefwRcqh2AWPg5+ZnSXF46V6uqIok+4dshaQoSVzl0
   8BJ7Z7Qy6DNVhoJDEihfRh0lpmqMVk03KphLqDRPDLGH9v4G1lB8ZHx4M
   h1lHIFFRvoFM9GGkA3aojZomE1U1kzrWNPEEkyFGWOn7MB2vpMLM9RrIk
   w==;
X-CSE-ConnectionGUID: vTY9iwwwTtOC4zYyfyLCag==
X-CSE-MsgGUID: jEGDdeJITs6wvfTzt2VJsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45702374"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="45702374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 01:45:08 -0800
X-CSE-ConnectionGUID: G8U2usm0TdCUttNmPADPdA==
X-CSE-MsgGUID: S8Ls4NAYQS6+osVTQr8ptA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="98206455"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa006.jf.intel.com with ESMTP; 19 Dec 2024 01:45:06 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v3 iwl-next 00/10] idpf: add initial PTP support
Date: Thu, 19 Dec 2024 10:44:02 +0100
Message-Id: <20241219094411.110082-1-milena.olech@intel.com>
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

v2 -> v3: fix minor issues, revert idpf_for_each_vport changes,
extend idpf_ptp_set_rx_tstamp, split tstamp statistics
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
 drivers/net/ethernet/intel/idpf/idpf.h        |  34 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |   3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  69 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  47 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 989 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 351 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 169 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 677 ++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 314 +++++-
 18 files changed, 2857 insertions(+), 101 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: 925d17a63a913ff2061aae2632d6f08ab6b07afc
-- 
2.31.1


