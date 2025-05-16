Return-Path: <netdev+bounces-191104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74201ABA193
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4087A71B3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5033253350;
	Fri, 16 May 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ED0MSlnd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D38255F3B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415220; cv=none; b=HMjPqEbMI13eRqUetCLCfC+Gep/MltpjENUplRprR6LUI2Bm6wKTDthVZPXCwwsKF5TjfDpvTm+HtRJIKbg5e7XQMUP1qbgfRCcrhqt33jfejze+cs45pwNlpBXs78eSHt90srA59sQgJf14QYwCpuBW73hfW9ZxGCQnB0zqq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415220; c=relaxed/simple;
	bh=pOlwRxosMq9UkUol5aQcTjzBvA26Jw5XsXJ2USRDQM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIYv4ISfQdlWs6g8ZZ9YM62uJaIdJQ78n4bHtIjdLT9iDw/Cw+6suUlLWETDyjhKSKXaCkT4pT0b2TkhnIPIstFBeKoODI4Q7SZhYokbJj7gQAVc793igGqMIhWm7beXdDfNU+hNCWrSO5FmgFgkqbtvgK+cGMZzpC4DuQ3fzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ED0MSlnd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747415218; x=1778951218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pOlwRxosMq9UkUol5aQcTjzBvA26Jw5XsXJ2USRDQM8=;
  b=ED0MSlndz3kYNhO9oeXEh6UEBBCPm0d91SDgb5HS4Tbz8FsMp68KXhHP
   bE2JTTOQkRlVAVcAOTVwmD6vugCgxljHTAHRjhC+FePwK9D0qnakfJIaW
   uM/PbvzV8RVBsnJkhjKERA4OnYrKet35cHnNtr3iVIeUZEPpjcp//zcfa
   KxhbiX+knArvszvOwQ7Lh4DufZwo1KQeRJfK+ZrwcIN9x93i75u3SKeIK
   5c468qv2Ka7YhH5mLx4JVRa+rOObnBhMKv8MQUh/DPAbc1WCdddH42flg
   06INmeK7k4Tf9DRhqGOjJHX9VN3jGCU7R17AwwXNjBf8IozhCO8KFiR+B
   Q==;
X-CSE-ConnectionGUID: 3Ti9AMy2RT6nW5FwFRJjkg==
X-CSE-MsgGUID: NzsLnG6JQNukA8ObJWgUeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49270902"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49270902"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:06:53 -0700
X-CSE-ConnectionGUID: M+ehsmJASEWVkj2I5FnvDA==
X-CSE-MsgGUID: oKs4AbF6SGeoYPSHYzL9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="143868362"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 16 May 2025 10:06:52 -0700
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
Subject: [PATCH net-next v3 00/10][pull request] idpf: add initial PTP support
Date: Fri, 16 May 2025 10:06:34 -0700
Message-ID: <20250516170645.1172700-1-anthony.l.nguyen@intel.com>
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
v3:
remove cross timestamping support, remove Tx timestamping statistics,
change the spin lock mechanism for Tx timestamp latches handling

v2: https://lore.kernel.org/netdev/20250425215227.3170837-1-anthony.l.nguyen@intel.com/
create a separate patch for cross timestamping, change patch order,
improve get device clock time latch mechanism, change timestamp
extension algorithm, use one lock for latches lists, allocate each
index latch separately during caps negotiation, fix virtchnl comment

v1: https://lore.kernel.org/netdev/20250318161327.2532891-1-anthony.l.nguyen@intel.com/

IWL: https://lore.kernel.org/intel-wired-lan/20250416122142.86176-2-milena.olech@intel.com/

The following are changes since commit 894fbb55e60cab4ea740f6c65a08b5f8155221f4:
  net: stmmac: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Milena Olech (10):
  idpf: change the method for mailbox workqueue allocation
  idpf: add initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilities and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping

 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  19 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |   3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  67 ++
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  57 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 873 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 362 ++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 171 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 161 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 615 ++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 314 ++++++-
 18 files changed, 2686 insertions(+), 102 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c

-- 
2.47.1


