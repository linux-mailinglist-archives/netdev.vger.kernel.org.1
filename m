Return-Path: <netdev+bounces-214197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D265BB2874F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F51A25066
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C332BE03A;
	Fri, 15 Aug 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ+ndu0K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9973176FE
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290532; cv=none; b=iOf7tNC9rC3khlLQ1PGdYBuRHZsUCuDeqxHChkxvCluhwd2uyypbeHnE62iSuvc1eG9YnJ1+qqCi29TIwaUTr0q58/O19G07rK1ZVoqGmoqInD7SigOe5JNArqxx79dOVsBhLRFyHWCOs+BND58eAF17YiCgDFdMYUG/e50/60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290532; c=relaxed/simple;
	bh=RwtXte971gv5Z/k9ZWDso36Bm1aj3GRGAwq/3J0rwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mjgq1MG3LmoyejQp1Md2kgumiRpOS97CgZCZNNrfNN9aPzF7l19PkwcYE/Q20JNa2UIbdrGaLzRnBRKWabliOOo719l5hpHzSd8cxnsO/4YC2HJJ3zfn9lgFWOoGUMV1vA8kVfg/SUYLxnWz3IMA4VyHDsL7ekyxACQeTLAOCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ+ndu0K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755290531; x=1786826531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RwtXte971gv5Z/k9ZWDso36Bm1aj3GRGAwq/3J0rwD8=;
  b=oJ+ndu0KjaL5McfRfseTRDE243BqC6iwZkDrog4dLqQrd58CUck8JLa+
   0C+IO/RLcRUpXAEKpAVp+jZwh84ELyI+ZOjpKvgO/8MEgl3PFrqNXFNjy
   hvfMRsqL6cDNGIa9OQq4JuliLlT+Okdl/ixgvnaOHIhOMPpytanQ8PK6Q
   B+18Vn9XoYWsdQbencJCIJDVWriWypQ10jjRw6m+OV4KPgHUfUZCRNd1F
   NJ2+Rvg7SSsmb3M/01hjOpW7UZqyGRinjR0X3rX6P5RK5xev410MA4WZL
   vWIMhuHMf/G9UL6PwD1eP4rCIwurUaYpwCWRpKIrBEYwXlXSCpmwl92XA
   A==;
X-CSE-ConnectionGUID: yf6NLjfjTc+dhFf8nNqd4g==
X-CSE-MsgGUID: +tVBfkbQR9yk4GqJOo+A+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68320287"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68320287"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:42:10 -0700
X-CSE-ConnectionGUID: zknvWYMESBGh6bcmYD8qRA==
X-CSE-MsgGUID: Lyjqq4TOS6uE2Fqn+Bu1iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198084309"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 13:42:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2025-08-15 (ice, ixgbe, igc)
Date: Fri, 15 Aug 2025 13:41:56 -0700
Message-ID: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For ice:
Emil adds a check to ensure auxiliary device was created before
tear down to prevent NULL a pointer dereference and adds an unroll error
path on auxiliary device creation to stop a possible memory leak.

Jake fixes handling when hardware returns a 0 sized descriptor which can
cause pages to be leaked.

For ixgbe:
Jason Xing corrects a condition in which improper decrement can cause
improper budget value.

Maciej extends down states in which XDP cannot transmit and excludes XDP
rings from Tx hang checks.

For igc:
VladikSS moves setting of hardware device information to allow for proper
check of device ID.

The following are changes since commit 065c31f2c6915b38f45b1c817b31f41f62eaa774:
  rtase: Fix Rx descriptor CRC error bit definition
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Emil Tantilov (2):
  ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
  ice: fix possible leak in ice_plug_aux_dev() error path

Jacob Keller (1):
  ice: fix Rx page leak on multi-buffer frames

Jason Xing (1):
  ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Maciej Fijalkowski (1):
  ixgbe: fix ndo_xdp_xmit() workloads

ValdikSS (1):
  igc: fix disabling L1.2 PCI-E link substate on I226 on init

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c      | 29 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 81 ++++++++-----------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
 drivers/net/ethernet/intel/igc/igc_main.c     | 14 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 +++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  4 +-
 7 files changed, 72 insertions(+), 92 deletions(-)

-- 
2.47.1


