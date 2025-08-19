Return-Path: <netdev+bounces-215057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FDB2CF40
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFD7B5436
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6231CA53;
	Tue, 19 Aug 2025 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnAt9t+V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B83054D8
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642006; cv=none; b=AYyenM2kl9fv5P5SR1Uwu2LGtpnwG5SwULg0NAL8s4y1YuJ3BcqHWJrZROkI4/HJ5B+oeIwXjuXj2LLzj3/rqXgqq2EhtaHkEXeWnHAoc/tDqBuNVWXpzAjt2B0AhovAGLZ8vVSGZ0Cgs+lIMdggkFvmFN6GBL+zneIbUkn5Lyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642006; c=relaxed/simple;
	bh=VaJyUYK3KtW+4VUKSErobAZddKClmLFBa4AA+AX57HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n213F8U/Svyyb2plo4AriLqolN4k+ESPUBZKks2h4Ylfs6BsLrx2Va/KTM7+DKf7drdzWaYu680Ut9TJrzqVEBezJGB9k47zsyyesQuFYxPNjR2kD+c3nmtnUhbiXXWvyUOUCB61Wiw3Q4vMQFgdonzp158QZ3Ei1jKw+tofGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnAt9t+V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755642005; x=1787178005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VaJyUYK3KtW+4VUKSErobAZddKClmLFBa4AA+AX57HM=;
  b=CnAt9t+V1s9WEp3JlHWeBVsaT7+CqbtSRhcG+PY7RwN7kv0w27LfC9wM
   Dd+iYbyXZo50ZY4k/7W4lzHWn8SN/xAU9kiEyT53K3pAdMMgPtqRdYuh9
   YllzccwFSEKkacE3or93Q85Clqq3fqlCS+JAkeiTDcbilKwY3NTjbCD2K
   vtCve2N+/7GgmMr49flegeO66pvH8+wVpjL0Ih22vLzltz8hWN4+OO+xK
   zHgqChbtnj4xR3mksgabjnPNejwBw3kSnnKM+/SxGJg2OQY7CPg5y3EJr
   tZb/bONdiIq5+vuWGTSzzpH9Kn4qZAl+ywZjrq+QlngRC9A+q3eQgFjLv
   w==;
X-CSE-ConnectionGUID: sJgZ1VHcT3GWbdqv0CK6zg==
X-CSE-MsgGUID: /cfDIL/NSOGfJVlOPy8moQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57829548"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57829548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:20:04 -0700
X-CSE-ConnectionGUID: jwWTXTjHRyGUSXi4EzE0VA==
X-CSE-MsgGUID: TuDSxFR7Siu2/r3k92elMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173202828"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2025 15:20:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 0/5][pull request] Intel Wired LAN Driver Updates 2025-08-15 (ice, ixgbe, igc)
Date: Tue, 19 Aug 2025 15:19:54 -0700
Message-ID: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
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

For ixgbe:
Jason Xing corrects a condition in which improper decrement can cause
improper budget value.

Maciej extends down states in which XDP cannot transmit and excludes XDP
rings from Tx hang checks.

For igc:
VladikSS moves setting of hardware device information to allow for proper
check of device ID.
---
v2:
- Drop patch 'ice: fix Rx page leak on multi-buffer frames'

v1: https://lore.kernel.org/netdev/20250815204205.1407768-1-anthony.l.nguyen@intel.com/

The following are changes since commit 01792bc3e5bdafa171dd83c7073f00e7de93a653:
  net: ti: icssg-prueth: Fix HSR and switch offload Enablement during firwmare reload.
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Emil Tantilov (2):
  ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
  ice: fix possible leak in ice_plug_aux_dev() error path

Jason Xing (1):
  ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Maciej Fijalkowski (1):
  ixgbe: fix ndo_xdp_xmit() workloads

ValdikSS (1):
  igc: fix disabling L1.2 PCI-E link substate on I226 on init

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c      | 29 +++++++++-------
 drivers/net/ethernet/intel/igc/igc_main.c     | 14 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 ++++++-------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  4 ++-
 5 files changed, 39 insertions(+), 43 deletions(-)

-- 
2.47.1


