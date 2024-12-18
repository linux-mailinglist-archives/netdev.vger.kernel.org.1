Return-Path: <netdev+bounces-153073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE69F6BB6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFCB1892B1D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCC1F8AD2;
	Wed, 18 Dec 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVQK9BJh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6C1F9411
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541148; cv=none; b=JTOWvHTRYwJyxGrTCT20jO944LqMkC25sA0eqmErTgBWy3ipAI71wUaVbfJ5Pte4eTq3bvZDNP6CNntFBjn2D+rWCuWZcyiDHN9WC+OxAzpRiWCw1X9NhN/X+TpUX0C9RH7MWUxUcsJqWmF1Z5SlM1C9Yuxi17QsW9bBpbE9Dqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541148; c=relaxed/simple;
	bh=F2ReL54suNLF8b/FnV23UbubkmG90RPdFCGOxZvcdO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDxJO7BwrGlo75GT4HQM6B6QKt2Ldr2SiLT/ZKUT6Ordw/dVrUUCcxcu+65CNIntJRSZcHn58tVooZK+fYN8Ba2b7cv79SVPntB5V69i5voYtvqH6dwUoSlEljE7n+vu0VVON/j5XWUAErmRCS6wkOa8fFrCkr598xjQLKwJ5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVQK9BJh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541147; x=1766077147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F2ReL54suNLF8b/FnV23UbubkmG90RPdFCGOxZvcdO8=;
  b=OVQK9BJh5/6wH9207aLHDkom36WVR8uqub92NFb930RjEUvyrlUoVooe
   1vA3AkfSfPFejBE20QQO/Pq2UY0yBj0q22RbIAJ+CPkQcBUPQr412S6Tr
   kDRD+yeOA8rh4pVcd9Lz7veLzrX1RIFnoanRpoXTr/WswXGp5p5/wKP4R
   oo7P9D3cWWMqNpdlZ0SlpkCILcXHjHdy436VV4E01NVm8TiySSx1bYwA2
   2TgrqfLIdV6MDZWIygT7DNOc6ekOkg1aI+TIExiYhjhSWh7js+Yku23Pf
   U6h2nKt4TPNRzW8tmWVdnbfoILZz6n4xbuuMUhzWAUOtSbK/EDrruKGFf
   w==;
X-CSE-ConnectionGUID: ZhaSFQcRQ8KN056bA9StoA==
X-CSE-MsgGUID: 8YLGMWitT2ueuRSzkZVnoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415479"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:06 -0800
X-CSE-ConnectionGUID: kI4oOvCkQ5qYX1e65ntjOA==
X-CSE-MsgGUID: 5dKS172oQIWd9MwWJ3gi4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102531559"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:00 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v2 0/8] net: napi: add CPU affinity to napi->config 
Date: Wed, 18 Dec 2024 09:58:35 -0700
Message-ID: <20241218165843.744647-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the IRQ affinity management to the napi struct. All drivers that are
already using netif_napi_set_irq() are modified to the new API. Except
mlx5 because it is implementing IRQ pools and moving to the new API does
not seem trivial.

Tested on bnxt, ice and idpf.
---
Opens: is cpu_online_mask the best default mask? drivers do this differently 

v2:
    - Also move the ARFS IRQ affinity management from drivers to core. Via
      netif_napi_set_irq(), drivers can ask the core to add the IRQ to the
      ARFS rmap (already allocated by the driver).

RFC -> v1:
    - https://lore.kernel.org/netdev/20241210002626.366878-1-ahmed.zaki@intel.com/
    - move static inline affinity functions to net/dev/core.c
    - add the new napi->irq_flags (patch 1)
    - add code changes to bnxt, mlx4 and ice.

Ahmed Zaki (8):
  net: napi: add irq_flags to napi struct
  net: allow ARFS rmap management in core
  lib: cpu_rmap: allow passing a notifier callback
  net: napi: add CPU affinity to napi->config
  bnxt: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity
  mlx4: use napi's irq affinity

 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 21 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 51 +++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 -
 drivers/net/ethernet/broadcom/tg3.c           |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c   |  3 +-
 drivers/net/ethernet/google/gve/gve_utils.c   |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c     | 10 +--
 drivers/net/ethernet/intel/ice/ice_base.c     |  7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 14 +--
 drivers/net/ethernet/intel/ice/ice_main.c     | 44 ----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 19 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  6 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  8 +-
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 33 +------
 drivers/net/ethernet/mellanox/mlx4/eq.c       | 24 +----
 drivers/net/ethernet/mellanox/mlx4/main.c     | 42 +--------
 drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  1 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  3 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 28 +++---
 drivers/net/ethernet/sfc/falcon/efx.c         |  9 ++
 drivers/net/ethernet/sfc/falcon/nic.c         | 10 ---
 drivers/net/ethernet/sfc/nic.c                |  2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c |  9 ++
 drivers/net/ethernet/sfc/siena/nic.c          | 10 ---
 include/linux/cpu_rmap.h                      | 13 ++-
 include/linux/netdevice.h                     | 23 ++++-
 lib/cpu_rmap.c                                | 20 ++---
 net/core/dev.c                                | 87 ++++++++++++++++++-
 35 files changed, 215 insertions(+), 302 deletions(-)

-- 
2.43.0


