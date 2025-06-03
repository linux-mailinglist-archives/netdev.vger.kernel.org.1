Return-Path: <netdev+bounces-194807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C582ACCBD8
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7CD3A6E8B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562329D0D;
	Tue,  3 Jun 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3D+vfsF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475F1DFF8
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971039; cv=none; b=kXMAaZqIC37kRY4iEOkPGiw0XODzf9agEbDfb3b0G0TQyzKnmvphdumNglcwZSg5a2et+/mQhilrjPvWJDEEnHRI7xO4/UvJk3rUxLY9EG8nxf31O8NAF4YqS343p24FVoKsDbuc0BxWp33c3YlnYc2RB5gh3f1SIb3oC2xdgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971039; c=relaxed/simple;
	bh=m0u6Aj5tYP2fToGPmsXT2Di1G2k2a7kSuIecM/VyJDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAC8i6HKhsb88B8fUaqEO0hEtVp2mNzhXkO3v5YO4k0n5fpq868HxE1D/DpEodfaMCa9YVbNjHjwIBl4X5mDrXVmCJK0HAJ2gkHLYfCxkZ72gUHYiv85TtFAtuZAKhK0MAzVfgsmHYHozdv4DaSuPo60rdUTMpDbf57YfLccf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3D+vfsF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971038; x=1780507038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m0u6Aj5tYP2fToGPmsXT2Di1G2k2a7kSuIecM/VyJDU=;
  b=Y3D+vfsFK06ExHAvRMHL1Jk2WJ7FRUAfn3V4UD1fI262MYoTsPxfwE8Q
   /V3lGtXlrarC7srvvzXsToW7jchzASi6L0/VXeJIPFTizs3q7aO30TE4F
   DkB80KH/r+52PHwZwgnVeV5nYXZ8nkULK45N/PWa0CnL36pUooCMzDQwm
   /KnH3Y6MXEN++gxP0FTkP88dgrhAmlavXK1jbcTHjcnBmdB4wMqyZ31u/
   G2DuVuSg6Y9oxH9mW684FRRnK9Tp3xyH6g3fNFFAuLLyK1qYJMfvYpopO
   0CfDWJjiXWFhnewUGPlUDiyQgATCIUOefAx3LOA08sltMNxeDDu0Yp5NM
   A==;
X-CSE-ConnectionGUID: ly0lpJfqSOeBml0/FjeznA==
X-CSE-MsgGUID: VhkUhVxpTzOKOOCtb2UC0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73556755"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73556755"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:17:17 -0700
X-CSE-ConnectionGUID: M227iS37TfOM1Hxr8pi86Q==
X-CSE-MsgGUID: VmHxd3/ITHe9dy3GA19vbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145546402"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2025 10:17:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	sdf@fomichev.me
Subject: [PATCH net 0/6][pull request] iavf: get rid of the crit lock
Date: Tue,  3 Jun 2025 10:17:01 -0700
Message-ID: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek Kitszel says:

Fix some deadlocks in iavf, and make it less error prone for the future.

Patch 1 is simple and independent from the rest.
Patches 2, 3, 4 are strictly a refactor, but it enables the last patch
	to be much smaller.
	(Technically Jake given his RB tags not knowing I will send it to -net).
Patch 5 just adds annotations, this also helps prove last patch to be correct.
Patch 6 removes the crit lock, with its unusual try_lock()s.

I have more refactoring for scheduling done for -next, to be sent soon.

There is a simple test:
 add VF; decrease number of queueus; remove VF
that was way too hard to pass without this series :)
---
IWL: https://lore.kernel.org/intel-wired-lan/20250404102321.25846-1-przemyslaw.kitszel@intel.com/

The following are changes since commit b56bbaf8c9ffe02468f6ba8757668e95dda7e62c:
  Merge branch 'net-airoha-fix-ipv6-hw-acceleration'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Przemek Kitszel (6):
  iavf: iavf_suspend(): take RTNL before netdev_lock()
  iavf: centralize watchdog requeueing itself
  iavf: simplify watchdog_task in terms of adminq task scheduling
  iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
  iavf: sprinkle netdev_assert_locked() annotations
  iavf: get rid of the crit lock

 drivers/net/ethernet/intel/iavf/iavf.h        |   1 -
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  29 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 289 ++++++------------
 3 files changed, 96 insertions(+), 223 deletions(-)

-- 
2.47.1


