Return-Path: <netdev+bounces-162663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD3A27900
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D154A18876AE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488682163BD;
	Tue,  4 Feb 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE4ozeCL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64047216384
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691576; cv=none; b=R6YVSfsU5OfKyH4P8051Vw+KYNRDojzRrdYME+o8JgwRCXnRe8khGFcl2G49jJ1EENbh0II0R0Q8HS4Mxidf6aEb7g/kLMLp3z5bHwg48HBBaO/D1HzOxm4unRjjax5RWtj5VeotzNFYy5kk9juRo5UIaS+qYIzyb8Ck+D3PN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691576; c=relaxed/simple;
	bh=R3ULIwP/uCyeb6P741G4EHVcpHj9peJZ1S1cKIQ1gG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqFR+v5lQETsb9AWRn7jsrzJhmxEwK8Q1AvWEf74GTMYAlrcQPYx8gnrWbI5kFsur2bT6mhC43WDtrJ40RVq8d1a5ciRxCZqzdaAItFh5UZ8HicmiETwtE0Ayn/uVBTrcEtR4/rFBhRrUcGVEqb4KiUVEH16HvlVeZOkEXmf7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE4ozeCL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691574; x=1770227574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3ULIwP/uCyeb6P741G4EHVcpHj9peJZ1S1cKIQ1gG4=;
  b=fE4ozeCLdZGYAwLSRc/wPuZngaOVm9RgKWqkq3AcLnQK8umWEuvanknp
   up6w/1dzdEuORvIWbC6X3kUBYyjwA2cGyNge90OUtgQTfg2+DDuk05w3X
   mZsGsz5gW8sz++3S/DmzFkEDY/WVa7Uo6ct+7vmO+e/VlZk3YChonaRmg
   ehzIjqXq1TjbMoFcA6K2vqjWMajyrX8jRntoaiyArECwU3mKWQU1qTczb
   vM9fvw5fu77RIlBD44NI9qCj79aSVGbAKTqirL6UKvzFuTzVmE2UTKRaD
   KJpzFpsBK7ycG9M5/5Ehrt2b40awyxXbKrs5o0iLzWfKstF7UVnqEuJTf
   w==;
X-CSE-ConnectionGUID: wYFrc4g2QEqLOMOY01MYAQ==
X-CSE-MsgGUID: eIPWFQYoR62mldPCuw2XaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371861"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:53 -0800
X-CSE-ConnectionGUID: ogTViO/gTVePo8VBMouD8g==
X-CSE-MsgGUID: PKb/aCafQ9ecy7C/sRsk6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652384"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2025 09:52:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	wander@redhat.com,
	rostedt@goodmis.org,
	clrkwllms@kernel.org,
	bigeasy@linutronix.de,
	jgarzik@redhat.com,
	yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling for PREEMPT_RT
Date: Tue,  4 Feb 2025 09:52:36 -0800
Message-ID: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wander Lairson Costa says:

This is the second attempt at fixing the behavior of igb_msix_other()
for PREEMPT_RT. The previous attempt [1] was reverted [2] following
concerns raised by Sebastian [3].

The initial approach proposed converting vfs_lock to a raw_spinlock,
a minor change intended to make it safe. However, it became evident
that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
which is unsafe in interrupt context on PREEMPT_RT systems.

To address this, the solution involves splitting igb_msg_task()
into two parts:

    * One part invoked from the IRQ context.
    * Another part called from the threaded interrupt handler.

To accommodate this, vfs_lock has been restructured into a double
lock: a spinlock_t and a raw_spinlock_t. In the revised design:

    * igb_disable_sriov() locks both spinlocks.
    * Each part of igb_msg_task() locks the appropriate spinlock for
    its execution context.

It is worth noting that the double lock mechanism is only active under
PREEMPT_RT. For non-PREEMPT_RT builds, the additional raw_spinlock_t
field is omitted.

If the extra raw_spinlock_t field can be tolerated under
!PREEMPT_RT (even though it remains unused), we can eliminate the
need for #ifdefs and simplify the code structure.

[1] https://lore.kernel.org/all/20240920185918.616302-2-wander@redhat.com/
[2] https://lore.kernel.org/all/20241104124050.22290-1-wander@redhat.com/
[3] https://lore.kernel.org/all/20241104110708.gFyxRFlC@linutronix.de/
---
IWL: https://lore.kernel.org/intel-wired-lan/20241204114229.21452-1-wander@redhat.com/

The following are changes since commit 4241a702e0d0c2ca9364cfac08dbf134264962de:
  rxrpc: Fix the rxrpc_connection attend queue handling
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Wander Lairson Costa (4):
  igb: narrow scope of vfs_lock in SR-IOV cleanup
  igb: introduce raw vfs_lock to igb_adapter
  igb: split igb_msg_task()
  igb: fix igb_msix_other() handling for PREEMPT_RT

 drivers/net/ethernet/intel/igb/igb.h      |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c | 160 +++++++++++++++++++---
 2 files changed, 148 insertions(+), 16 deletions(-)

-- 
2.47.1


