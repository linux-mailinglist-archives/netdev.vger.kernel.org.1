Return-Path: <netdev+bounces-156887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A99A08380
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D1F3A7F52
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B5204F9D;
	Thu,  9 Jan 2025 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnbD9SZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502B189BBB
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465484; cv=none; b=G2FH6dVA48qpDFLRbUyxZq4g7Vy1n3iwNFZmx+vq41+Dzo/Iowse/P1512eUgMQ+jRO6kShlUykyw9vYUrB38l1CyDbjCJw9ZYmv9quYzJso6lsn31erqW0EepFmJPZ2eEiPKhushVWUXfimmpufsoJ+yT3BCCaSyHZxG+8ThsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465484; c=relaxed/simple;
	bh=gwKLjM9Um+c1EtV0m7N+KQ5yVfvCVeVP8yakpHm8yRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ni3nVjR3tOlaGGGjR/bTYpD4FVw5kb3AwcnYkWuBVs3fNM5nLTWSL6kZTnuCocIUgg/HIS8mBd0z/XEzg8+3ZnFcTmynPXTCHx13/eCVPCe7l5HRwk1r+NJJn+p6oMTbtCqJboEny0M2+CxwymH2c5UhqLufDskBuPie9AVCqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnbD9SZ5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736465483; x=1768001483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gwKLjM9Um+c1EtV0m7N+KQ5yVfvCVeVP8yakpHm8yRs=;
  b=GnbD9SZ5i+z24s8IkQmHq9GUU28WUNzHrO/ec3YXAPyFKPLo4+92dD9G
   XB0J8u3d8hF1AH+6TaefALyHcFY8K7FZUrGGhuRCg7UaV9UQT74YYKbWw
   xgKTFddbMq4iiLiXXI8w7AQS9ry4kguS1Zb15Xd3eH0PPnb2+mnTS2ZGB
   wcqED12hBfhnmV/dubVsnw1VHRm9dboErT8G8OmvUhYbV4nXbG4qMFUA/
   vkzKqP39Mum4f5OIA96eqR4gRvQN6abpaFDdsnPbDdnQvNTo6AInZdgUv
   62mz5HF/78mvjNdLolRD/6YDsxYcdxuXcoqzCLCkk2zkOJ9BZZO/JoI5k
   A==;
X-CSE-ConnectionGUID: dC2/Q3sATyqlpP38uHa6Sg==
X-CSE-MsgGUID: TYuZsphwTRywl1G7ThNp6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47245094"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47245094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:22 -0800
X-CSE-ConnectionGUID: t1IqzDLVRfy/oDErVC9tcA==
X-CSE-MsgGUID: 40EVSXihQJWJNjBwZdsZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="134398933"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:15 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v4 0/6] net: napi: add CPU affinity to napi->config
Date: Thu,  9 Jan 2025 16:31:01 -0700
Message-ID: <20250109233107.17519-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
after reset. However, since there can only be one IRQ affinity notifier
for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
management in the core (which also registers separate IRQ affinity
notifiers).   

Move the IRQ affinity management to the napi struct. This way we can have
a unified IRQ notifier to re-apply the user-set affinity and also manage
the ARFS rmaps. Patches 1 and 2 move the ARFS rmap management to CORE.
Patch 3 adds the IRQ affinity mask to napi_config and re-applies the mask
after reset. Patches 4-6 use the new API for bnxt, ice and idpf drivers.

Tested on bnxt, ice and idpf.
v4:
    - Better introduction in the cover letter.
    - Fix Kernel build errors in ena_init_rx_cpu_rmap() (Patch 1)
    - Fix kernel test robot warnings reported by Dan Carpenter:
      https://lore.kernel.org/all/202501050625.nY1c97EX-lkp@intel.com/
    - Remove unrelated empty line in patch 4 (Kalesh Anakkur Purayil)
    - Fix a memleak (rmap was not freed) by calling cpu_rmap_put() in
      netif_napi_affinity_release() (patch 2).

v3:
    - https://lore.kernel.org/netdev/20250104004314.208259-1-ahmed.zaki@intel.com/
    - Assign one cpu per mask starting from local NUMA node (Shay Drori).
    - Keep the new ARFS and Affinity flags per nedev (Jakub).

v2:
    - https://lore.kernel.org/netdev/202412190454.nwvp3hU2-lkp@intel.com/T/
    - Also move the ARFS IRQ affinity management from drivers to core. Via
      netif_napi_set_irq(), drivers can ask the core to add the IRQ to the
      ARFS rmap (already allocated by the driver).

RFC -> v1:
    - https://lore.kernel.org/netdev/20241210002626.366878-1-ahmed.zaki@intel.com/
    - move static inline affinity functions to net/dev/core.c
    - add the new napi->irq_flags (patch 1)
    - add code changes to bnxt, mlx4 and ice.

Ahmed Zaki (6):
  net: move ARFS rmap management to core
  net: napi: add internal ARFS rmap management
  net: napi: add CPU affinity to napi_config
  bnxt: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity

 drivers/net/ethernet/amazon/ena/ena_netdev.c |  38 +----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  52 +------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h    |   2 -
 drivers/net/ethernet/intel/ice/ice.h         |   3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c    |  17 +--
 drivers/net/ethernet/intel/ice/ice_base.c    |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |   6 -
 drivers/net/ethernet/intel/ice/ice_main.c    |  47 +-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  22 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   6 +-
 include/linux/cpu_rmap.h                     |   1 +
 include/linux/netdevice.h                    |  23 ++-
 lib/cpu_rmap.c                               |   2 +-
 net/core/dev.c                               | 145 ++++++++++++++++++-
 15 files changed, 191 insertions(+), 181 deletions(-)

-- 
2.43.0


