Return-Path: <netdev+bounces-99000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3FA8D3576
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A902874B1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B017A936;
	Wed, 29 May 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6heEzDv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44714A4C3
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981824; cv=none; b=INeZlmkHCkiNBa4JrT95ORs2wDiz83TB1i8NMVXvO8IffhHruaCsrYlplwKtaOik+QXxlMEYeqG6lBoLpfyP7tW/8afmj2+oS4qji+tOyEzIsXgDqChDkXWA4GMSr0RDeixiV1ir25LJPur5AsPhdH5SHH07uNQErGgBwCay8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981824; c=relaxed/simple;
	bh=FWMUQoO5gUNSL6Hs4/uH+Ck45jDQp1IuueH/k+fPzXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZVxSB+//tcbQH2nD0D4LRgYjskShWLVmq1nzD606mKEs4zlTo4GlnHF451lPDqli7VPXdPJAMph/xkJwVbSBRrBvGgXDVSIjLTUdDBgLsY3p39CtyzpELoXQI5cpazXL/yrH5d1VirIX5FbWdtCGsPBoxLC1HtYi+LOu1DIwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6heEzDv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981823; x=1748517823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FWMUQoO5gUNSL6Hs4/uH+Ck45jDQp1IuueH/k+fPzXM=;
  b=P6heEzDv/uL8CvlcpGPissWPByFWGJeRCp6eZaVFkGFqlkRhL23Dtrmb
   pXBOtTTo3H1HZOqkMd8tiU/TTW8i2UtOdc8CY3Zj6ZqIt0CtapJkD0UBM
   rhDZvrN5purC8xVyIUVyAvI6QXcYy0bWuG+S1Nb6D9nq60qQBO6ti3Uut
   hwx61WpVLJfN9p88PJTZUqa+4nzxSBAo4WMdIyMmBwmlENNXJ9RKso5/R
   iAIYP7nB7sJyuCj/wKvthkZq8Ns9IwU9k4f1rLkiiePU/EmbbpxE0Kk/1
   zUtadyeG7B8qO7ki5V66UlQkwrZ3Jclrs1PJLLN9OOpPCI3BiCq39/1gQ
   Q==;
X-CSE-ConnectionGUID: Cqp6KYq5Sl6ThxWxhEB+Nw==
X-CSE-MsgGUID: akPv68y1Q4iUUAEq06J3cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169218"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169218"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:42 -0700
X-CSE-ConnectionGUID: qI70jKXrR6qCqNQ1YN7fvA==
X-CSE-MsgGUID: M8dMU7+VR0Gb5TBr7Tp0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277164"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 0/8] ice: fix AF_XDP ZC timeout and concurrency issues
Date: Wed, 29 May 2024 13:23:29 +0200
Message-Id: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

changes included in this patchset address an issue that customer has
been facing when AF_XDP ZC Tx sockets were used in combination with flow
control and regular Tx traffic.

After executing:
ethtool --set-priv-flags $dev link-down-on-close on
ethtool -A $dev rx on tx on

launching multiple ZC Tx sockets on $dev + pinging remote interface (so
that regular Tx traffic is present) and then going through down/up of
$dev, Tx timeout occured and then most of the time ice driver was unable
to recover from that state.

These patches combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.

Thanks,
Maciej

v1->v2:
- fix kdoc issues in patch 6 and 8
- drop Larysa's patches for now


Maciej Fijalkowski (7):
  ice: don't busy wait for Rx queue disable in ice_qp_dis()
  ice: replace synchronize_rcu with synchronize_net
  ice: modify error handling when setting XSK pool in ndo_bpf
  ice: toggle netif_carrier when setting up XSK pool
  ice: improve updating ice_{t,r}x_ring::xsk_pool
  ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
  ice: xsk: fix txq interrupt mapping

Michal Kubiak (1):
  ice: respect netif readiness in AF_XDP ZC related ndo's

 drivers/net/ethernet/intel/ice/ice.h      |   6 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 150 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 6 files changed, 101 insertions(+), 71 deletions(-)

-- 
2.34.1


