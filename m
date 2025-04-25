Return-Path: <netdev+bounces-186145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD4A9D488
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87ABF1B831E3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC5221FAE;
	Fri, 25 Apr 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/jZlKFi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635E208997
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617958; cv=none; b=pNJjZfAWcQ+gf3gSQYisgPOuq0FfEgOiuhcaTGnvar7nyt2ehUjn3/P6EH/g7+uFy2jyHo+USLLjYSVKfblB1EyAiDEgKXFxTTHUXmIr/KmfqZpw74s0muqMVuErhoKgicohqOhqAnALhQtATY6H17gDOVRHzfjjpeFSPjF5OGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617958; c=relaxed/simple;
	bh=YVecq58lW4gRo3t9zPb26pPzKJZpPVrVaSYx/uMYdCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuL4pZG3gpTSimx90LHuiw3Xjwgst1X5XslH/1b67maIwE90sBT1qWPiQYLUsZWf7NDWycCy6qQC1Se306kMXe4seAExh/MxIcZA2mDr2GwAua7HgjlkSp0Afpp5pzejxl/aWtOkzHO165q9vcQaE7/tcwP+ZOpWpsa9AjmhFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/jZlKFi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745617957; x=1777153957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YVecq58lW4gRo3t9zPb26pPzKJZpPVrVaSYx/uMYdCE=;
  b=K/jZlKFiBBO2YOsf6cLFVfQulVGw2lhXU063RsyBZfTyPDnCLF3eotu5
   X+FcqfVsnJsS7Kp3dkHg0gCo4MlUR2B0KDnnaNpDKei84wHJlUxKRqakq
   SaukA9BX1fV6nr44DK/Y6wIb0BIcG1MQcHAnY/M8Eqp6eF3DUaFL1LC/I
   tFlslW3/HloV8Pf9HmbPKlWS+ZhF0uh+vftE4q2jJNRZt3N8vBhet0qhy
   5F/g++dsl0GRVTbD2RQNwuNL8VJeY9H3+gagidY5q+saBJdqsNA+iwDLS
   RNR+F5cNeqbpKMlrmwJuWZTVqimtCkbnIzcd31kTyB2sCrKJUlyZLQEEv
   A==;
X-CSE-ConnectionGUID: KhKsV23oSkeF46xPZiqWEA==
X-CSE-MsgGUID: cTluSICdQEuXwXsUPYFxmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69784519"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="69784519"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:52:36 -0700
X-CSE-ConnectionGUID: 4StOXm13TRO9pdmHr12dOQ==
X-CSE-MsgGUID: Ma+jY+PERp+y8DUBWz/PyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="163973502"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2025 14:52:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	milena.olech@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP support
Date: Fri, 25 Apr 2025 14:52:14 -0700
Message-ID: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milena Olech says:

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
---
v2:
create a separate patch for cross timestamping, change patch order,
improve get device clock time latch mechanism, change timestamp
extension algorithm, use one lock for latches lists, allocate each
index latch separately during caps negotiation, fix virtchnl comment

v1: https://lore.kernel.org/netdev/20250318161327.2532891-1-anthony.l.nguyen@intel.com/

IWL: https://lore.kernel.org/intel-wired-lan/20250416122142.86176-2-milena.olech@intel.com/

The following are changes since commit 4acf6d4f6afc3478753e49c495132619667549d9:
  Merge branch 'fix-netdevim-to-correctly-mark-napi-ids'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

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
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 1023 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  379 ++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  171 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  161 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  672 +++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  314 ++++-
 18 files changed, 2933 insertions(+), 103 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c

-- 
2.47.1


