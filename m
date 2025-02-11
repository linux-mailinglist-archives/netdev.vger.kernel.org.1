Return-Path: <netdev+bounces-165294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E9A31812
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9993A856D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A1268C5B;
	Tue, 11 Feb 2025 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WChAeFWU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543E267700
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310234; cv=none; b=UzYifpHreGpvkYNitG14lba280Yue3n7aQdMHsRX0F37mI97rvOCDnrKB/Bbq5hN8k2vCa7svPtIOX6gbZOCew4w59Uf8GRzKWnfz1H0JZtA3apHqxhmUP+TGBmIUpTNRuHtxyewk5D5EBJ/9arF4z6jp5ocQHqbZRbNmApkYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310234; c=relaxed/simple;
	bh=5bgUIaANeAsVQbT+PBP46N7bT8Xctv6xnY00/25RiwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFtQHFqkaNRhYxej57YrGg+NNEqN2r+4FqWKNsUPK1fvlkQSwyNPZ8Dqjr+QfsXv6KA6Sot604VHftNis14QE2AWF4T4IRXwEETCyEaYozAkn+tmJAS3jWjaiC0yflQpXy9RwuSE+ktJ+APlCyZwAl8BaoBzuBA8iNYUpUBvya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WChAeFWU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310229; x=1770846229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bgUIaANeAsVQbT+PBP46N7bT8Xctv6xnY00/25RiwQ=;
  b=WChAeFWUvLnk8cuJmW1w+RHvBLDH6cwVf+YYDN89U4ld+jrmAAIutIQU
   1S9t+/V+U+I3Lw2rjudc7L71Cl2bbU6MVYAvFpI727iZ3G5OzoPK78RKb
   R1TPKWpWlJRhcr27+dqTg1tMLf2F5o2weWvcYh5TqcpKcUS4GwhayYbAo
   V78mKghyGhX/eLaMei8vrDSxQkb0v9iihPpBIiSlJZDB0+8ixZs4e5Wev
   J/kQQcPvQH2I6PUtiL++srYh+P4z8dKUMKjRnoZ9uRlX9cDOqx0MwfpTo
   ix/N3jdWigWiblT5YwLAXKZMUiqTU2Jwqkiurq+vbD5C/Hr1VZTyYm6+M
   Q==;
X-CSE-ConnectionGUID: 6FZhou62RTCD0lrqr0m6gA==
X-CSE-MsgGUID: XWyCdRwwQ7+THq0R6j7NlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185221"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:48 -0800
X-CSE-ConnectionGUID: PeDgJluOQWCKG3bCfeNbdA==
X-CSE-MsgGUID: e8VrnI6NTg2hksv385f0Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478665"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 13:43:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2025-02-11 (idpf, ixgbe, igc)
Date: Tue, 11 Feb 2025 13:43:31 -0800
Message-ID: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:

Sridhar fixes a couple issues in handling of RSC packets.

Josh adds a call to set_real_num_queues() to keep queue count in sync.

For ixgbe:

Piotr removes missed IS_ERR() removal when ERR_PTR usage was removed.

For igc:

Zdenek Bouska fixes reporting of Rx timestamp with AF_XDP.

Siang sets buffer type on empty frame to ensure proper handling.

The following are changes since commit 44ce3511c21c6ba87a719a0b9f140822cc1cc00b:
  Merge tag 'batadv-net-pullrequest-20250207' of git://git.open-mesh.org/linux-merge
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Joshua Hay (1):
  idpf: call set_real_num_queues in idpf_open

Piotr Kwapulinski (1):
  ixgbe: Fix possible skb NULL pointer dereference

Song Yoong Siang (1):
  igc: Set buffer type for empty frames in igc_init_empty_frame

Sridhar Samudrala (2):
  idpf: fix handling rsc packet with a single segment
  idpf: record rx queue in skb for RSC packets

Zdenek Bouska (1):
  igc: Fix HW RX timestamp when passed by ZC XDP

 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  5 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  5 +----
 drivers/net/ethernet/intel/igc/igc_main.c     | 22 +++++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 4 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.47.1


