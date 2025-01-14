Return-Path: <netdev+bounces-158074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F47A1064B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9440C169D5F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5E236ED8;
	Tue, 14 Jan 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5yZCZob"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74EA236EB7
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856772; cv=none; b=gUsbfNd20WPd+cC9+3mK3rqM3IWOYXPj5NNVF1zTjiDLq9Gcwdzh7vP9648P7/briGKmR/O/onmkUZxCt/3rD+FiLFdwpuctYSWJ8WecJjTZijOlxtL/2VEOKJ0xA2UHDqUYjMQhT+B1brYVOWtAgQZ3oMaoRKlngDG8P+fCA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856772; c=relaxed/simple;
	bh=qRkOF5fCpEzHZoFUvAJ/xYq9Y4Isb0kQGSuYz3r/IZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAs4Aa53QNToiTl+N7JnFhTUDjRzTEJri28Ej0PXnkvsub7epoa07saJ5zrGRnxXEKOutvip9+HWl1y7ANbSUqjvpsJol4qpOAo2QbJIYAIsWczQ+nE3vTjEpgiLn7hO+TcEN4pQLkiuL+6E0HjsFcn748OMPhcwYgfz1xPJsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5yZCZob; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736856770; x=1768392770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qRkOF5fCpEzHZoFUvAJ/xYq9Y4Isb0kQGSuYz3r/IZc=;
  b=a5yZCZobWOkhIFGoyTKZPwc2zmEtWA2pdal97O+eoYfaWVxVuOi+q9ak
   wJgJFJz9q50ua40LGtdcWWHvsEkVEzSGBlvj+yPXq5V7yo0h9jSX6IABV
   m7e7DHjsUAQiJm9c48d/td+pZZPObmQAE6uXor9jv5s72DdxRWOTDl+mk
   2wHmsUcC7e5n3E0u6OA29PirvJHDc1/toPZ8lCRnPWsje4J3ZFG2pF9C5
   IhNukTIU50k0NiJWtqUd8HvTTaiggeGmu3cjKQsyGE9dsijfq8sylglVC
   DSyxSrVGvonRI23GCe1Y5wEO1aDE7cO+Wr8OzmdBMs+ZNgb+3wr2oqaV6
   Q==;
X-CSE-ConnectionGUID: OUDRNWUwQJ+TRTXfmMwCQQ==
X-CSE-MsgGUID: h6cSbP/KTxqgNQ1pbdqLSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59631735"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="59631735"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 04:12:50 -0800
X-CSE-ConnectionGUID: JrWPDgGQRWuKVxjI6/uOcQ==
X-CSE-MsgGUID: UIi7gdQTR36X9Z+osMQ9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104641742"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 14 Jan 2025 04:12:47 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v4 iwl-next 00/10] idpf: add initial PTP support
Date: Tue, 14 Jan 2025 13:10:54 +0100
Message-Id: <20250114121103.605288-1-milena.olech@intel.com>
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

v3 -> v4: change timestamp filters dependent on Tx timestamp cap,
rewrite function that extends Tx timestamp value, minor fixes
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
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  70 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  47 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 983 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 351 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 169 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 677 ++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 314 +++++-
 18 files changed, 2852 insertions(+), 102 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: 6db9491e57a016a19ea8e60a384e773fae3d5758
-- 
2.31.1


