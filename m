Return-Path: <netdev+bounces-224823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F6B8AD47
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF935A7B03
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18093218C3;
	Fri, 19 Sep 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1lnFe9X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B5221544
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304461; cv=none; b=JzHNZnLIlgX1Z8n/5G9RXtLFP6PJvLQyWKfYlHlMv+udaOhjywkWdHn9t1FeSutmsl1+X/QtRfQhzDHUtX9c7dw3lCU/1elaJ3dVuOwYFg0mwsHeRj61I+k0m5kJWo4DyGMMg47vUNw/IxE0JvLDzCUUQVp5unXaKkBmGA2psCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304461; c=relaxed/simple;
	bh=0ZpkICCE/srEmfYiGN9q74aXecmFsh+1quYvYkPa9lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7BUD+h/0mDvt02KWm4rfdxh5lUcdRtyKAsayXDuQhjTMTciHT2h3TmEFqU8fCirCurbHuPYNqixt5wuJTLpLzc8o7gmBn1Ynfi2oU0M9fU4gsYwUg1ZgfycSKTp7GkT0Gp+J9veAvhemEAKlFuHzV6GAHv4gYuWopZPRpcOOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1lnFe9X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304460; x=1789840460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ZpkICCE/srEmfYiGN9q74aXecmFsh+1quYvYkPa9lw=;
  b=D1lnFe9X75WiluL4l4JwqvqjsHtrmtWG/U/pOPodlc1R+g6VCIXvibZs
   7qkycH6KBrnZAjKIEA6fUaeXucDb9841DZVzW9Ycap5EucB6evhNnp8NB
   I4BE8rQgzHWsF7dnjhITIEZSCR+WHS4tvWrh1/eA31YyJaDpifrdOVMSb
   UgGznwQltyaIu3mb0Or9xz7NpKzSqvkitljE98fnWTeBVGoDn8QeUuOWg
   h3vIgwN3NW2JArXLkQiMWxEHTPAq7e5YBB73RIpmk1N2chL3DJkOucXaN
   0JAKwPIOrU9E+5yKMaZVkCQKjyQ5IRi8n2vQpRI2FgCHXyqaJB98EeeGG
   A==;
X-CSE-ConnectionGUID: G9eqPXVDSqSzBfkS8lfsDQ==
X-CSE-MsgGUID: 4bWhqMKDQBCnlacdDdJy5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097062"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097062"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:19 -0700
X-CSE-ConnectionGUID: njSlDXWMT9i1tdTT3BukEA==
X-CSE-MsgGUID: XrHEbRSFTqaDmacc4Tbf2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709473"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates 2025-09-19 (ice, idpf, iavf, ixgbevf, fm10k)
Date: Fri, 19 Sep 2025 10:54:03 -0700
Message-ID: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paul adds support for Earliest TxTime First (ETF) hardware offload
for E830 devices on ice. ETF is configured per-queue using tc-etf Qdisc;
a new Tx flow mechanism utilizes a dedicated timestamp ring alongside
the standard Tx ring. The timestamp ring contains descriptors that
specify when hardware should transmit packets; up to 2048 Tx queues can
be supported.

Additional info: https://lore.kernel.org/intel-wired-lan/20250818132257.21720-1-paul.greenwalt@intel.com/

Dave removes excess cleanup call to ice_lag_move_new_vf_nodes() in error
path.

Milena adds reporting of timestamping statistics to idpf.

Alex changes error variable type for code clarity for iavf and ixgbevf.

Brahmajit Das removes unused parameter from fm10k_unbind_hw_stats_q().

The following are changes since commit 3fb4f35a75e864ecf298b55259223bc984f63276:
  wan: framer: pef2256: use %pe in print format
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Loktionov (2):
  iavf: fix proper type for error code in iavf_resume()
  ixgbevf: fix proper type for error code in ixgbevf_resume()

Brahmajit Das (1):
  net: intel: fm10k: Fix parameter idx set but not used

Dave Ertman (1):
  ice: Remove deprecated ice_lag_move_new_vf_nodes() call

Milena Olech (1):
  idpf: add HW timestamping statistics

Paul Greenwalt (2):
  ice: move ice_qp_[ena|dis] for reuse
  ice: add E830 Earliest TxTime First Offload support

 .../net/ethernet/intel/fm10k/fm10k_common.c   |   5 +-
 .../net/ethernet/intel/fm10k/fm10k_common.h   |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c   |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  33 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  35 ++
 drivers/net/ethernet/intel/ice/ice_base.c     | 390 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_base.h     |   3 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  78 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  14 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_lag.c      |  55 ---
 drivers/net/ethernet/intel/ice/ice_lag.h      |   1 -
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  41 ++
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 109 ++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 173 +++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  15 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  14 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 153 +------
 drivers/net/ethernet/intel/ice/ice_xsk.h      |  22 +
 drivers/net/ethernet/intel/ice/virt/queues.c  |   4 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |  17 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  56 +++
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |  11 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |   4 +
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   2 +-
 29 files changed, 989 insertions(+), 264 deletions(-)

-- 
2.47.1


