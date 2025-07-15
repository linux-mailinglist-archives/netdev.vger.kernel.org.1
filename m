Return-Path: <netdev+bounces-207263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08391B067BD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28BE5042D7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68D2BF005;
	Tue, 15 Jul 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR6J6lvi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0602BE7D9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611411; cv=none; b=tkU4GJ/1CTx/0jfx0BrkIqF2E+pE/2ctPv8vZuA37hIjPULfPwK/1ws1oHzAj+xw+Qeh8ThpuBoo7mY/+q7YJzMSPgDHKU2fVJsovx9omRcFPTz4Tce2mHvR9qY0VzpSUjXYxsWSxd9+tDTQJgtxNuKfMiBj6H2wBZXeswcZH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611411; c=relaxed/simple;
	bh=+EZbieku3jQwHF444gDfC/CmkvoQGsIP3RWn3DAu1RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HyOdIC9g+JQzo6slUNqskPrB+B3s6VMrpsnXAwosP7C86N5vA37b5lvfp2UiiG+r97T4AUQwTJcXomJrMp5fDZB0T2/kfkjMm2gxbdtdBqSlq5qh9DOyBjviON1wzKrBvSiBlQWfYeRF2A7kcLf6oQiqmVDWwazhounly183DUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR6J6lvi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752611410; x=1784147410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+EZbieku3jQwHF444gDfC/CmkvoQGsIP3RWn3DAu1RM=;
  b=gR6J6lvif7yqHSWRinUrXWGI06rXcGMFCnVjNo4m7ja3RP25cnh07jhv
   TgNVzeE75++/SF5bpGLOUjvRFMApHtHJogORexwz3poJS4kCJVagDhyyT
   oYAmiVZ+ZzFMyoxl8UsYA0jtx8taLTjTg9GKfhQuF/7pepYdSKWE3Af6h
   g3lAKJ0Y6yr/iK/HsAhJfhVpuJmIkxlvkGmIjz8MYDHyA0ttSx0QiCRNj
   ZO1BA0AYbj2rZc94bxSKtxrevoJ95fRTAzK+bPFFppSzEHG/1NBBhv1K3
   V7mOGYUl2grXyUmavYUhJ+mIKuWZQMoNq6ReozZ1lOrr7Quy1aBrBcgJW
   Q==;
X-CSE-ConnectionGUID: LntwD756RnyEBqTmIRp44A==
X-CSE-MsgGUID: eM6D4R2UR1C6ktQ8efY+Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54699805"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54699805"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:29:58 -0700
X-CSE-ConnectionGUID: iR6M8i9gQKi2ZD4qoup3bQ==
X-CSE-MsgGUID: +7MhOC6+SCqLDYkGKNRYnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="194449513"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 15 Jul 2025 13:29:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-07-15 (ixgbe, fm10k, i40e, ice)
Date: Tue, 15 Jul 2025 13:29:43 -0700
Message-ID: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Arnd Bergmann resolves compile issues with large NR_CPUS for ixgbe, fm10k,
and i40e.

For ice:
Dave adds a NULL check for LAG netdev.

Michal corrects a pointer check in debugfs initialization.

The following are changes since commit 0e9418961f897be59b1fab6e31ae1b09a0bae902:
  selftests: net: increase inter-packet timeout in udpgro.sh
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arnd Bergmann (1):
  ethernet: intel: fix building with large NR_CPUS

Dave Ertman (1):
  ice: add NULL check in eswitch lag check

Michal Swiatkowski (1):
  ice: check correct pointer in fwlog debugfs

 drivers/net/ethernet/intel/fm10k/fm10k.h     | 3 ++-
 drivers/net/ethernet/intel/i40e/i40e.h       | 2 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_lag.c     | 3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h     | 3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.47.1


