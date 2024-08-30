Return-Path: <netdev+bounces-123857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCB7966B15
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E8281311
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE21BE259;
	Fri, 30 Aug 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0p1d5Mo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9713D60E
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051901; cv=none; b=f1h1YLdJMGhYvjd0aSK21i2x9jo+MZ6x0D/Woy5jMDWCxq3jGnavmtxpyxDxvi3mhZv3ZDNMxrhVRoLagWOBEMrtpeQ6AHefXDkYBzU9K4qfT2bGRtFvWUOWMRgKnIRKBNEVErXJp2fnVmxdCJfi3EdEJEkae22qZRPV7sAT/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051901; c=relaxed/simple;
	bh=tW6P1dEMWsBNM0bs9oQi0b5/43/iHyWoHM6oE8Qi1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjhgD3cNt4UUR/A9LbiQAcUw/t/udsGMMs6T3sJzZViSUnlAwjvzRIcgeLVsH7xIijHC2HjJ3AVra1SWstjl+675qeXyEbnRIy7yqTzDt+4+P/4ejtjhKkAI3wh/TtRmlBoWp3/svBZmEN6i/KQOi6hzQ8B5HxISfgqnY7OO+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0p1d5Mo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725051899; x=1756587899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tW6P1dEMWsBNM0bs9oQi0b5/43/iHyWoHM6oE8Qi1Q8=;
  b=d0p1d5MobG4TNRSQQtqdStt7amEKivTfYjMlITSA1BkS4/0E/wMyTIGU
   IKXuoUoMxnzkxYpdHj4/JPAcyYMeZ3C4xQWRAFr11I4FGn9n8jRgl7yFi
   nO3rDwM6MEypI12W1+umqMD3IBWrpH6QneTtgLLrf1vUtkuaRuiM5bP7/
   iNpAyfrY+yJaAy42W1oZAT4InVerwMxnsvoAyNiZtbJAjJ9L73zuuTKXW
   tsilTqz3THHnu7y0nW5eRvwt9Z5z4/cQIVsPuBxGP7Xv+xrq+YUTlh0T3
   p0apW0PfaJ4X4Kgn5Mnr6WJolEEG3wx8t/OugBoooZ89IpXKBhC5Pkihx
   Q==;
X-CSE-ConnectionGUID: ruHdX1jfT1u2oVmf5/vSew==
X-CSE-MsgGUID: CvpBCZ/5Sqqvoe0WpMX2lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13304253"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13304253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:04:59 -0700
X-CSE-ConnectionGUID: uVk8xlopSQyrpGxqaLzcWw==
X-CSE-MsgGUID: CxK2DwNeQZe759IE+w+/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63625239"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2024 14:04:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates 2024-08-30 (igc, e1000e, i40e)
Date: Fri, 30 Aug 2024 14:04:42 -0700
Message-ID: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to igc, e1000e, and i40 drivers.

Kurt Kanzenbach adds support for MQPRIO offloads and stops unintended,
excess interrupts on igc.

Sasha adds reporting of EEE (Energy Efficient Ethernet) ability and
moves a register define to a better suited file for igc.

Vitaly stops reporting errors on shutdown and suspend as they are not
fatal for e1000e.

Alex adds reporting of EEE to i40e.

The following are changes since commit fbdaffe41adca26cb9566e92060b97cd6dd87b60:
  Merge branch 'am-qt2025-phy-rust'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Aleksandr Loktionov (1):
  i40e: Add Energy Efficient Ethernet ability for X710 Base-T/KR/KX
    cards

Kurt Kanzenbach (2):
  igc: Add MQPRIO offload support
  igc: Get rid of spurious interrupts

Sasha Neftin (2):
  igc: Add Energy Efficient Ethernet ability
  igc: Move the MULTI GBT AN Control Register to _regs file

Vitaly Lifshits (1):
  e1000e: avoid failing the system during pm_suspend

 drivers/net/ethernet/intel/e1000e/netdev.c    | 19 ++--
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 36 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 24 ++++-
 drivers/net/ethernet/intel/igc/igc.h          | 11 ++-
 drivers/net/ethernet/intel/igc/igc_defines.h  | 22 ++++-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 77 ++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_main.c     | 99 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_phy.c      |  4 +-
 drivers/net/ethernet/intel/igc/igc_regs.h     | 12 +++
 drivers/net/ethernet/intel/igc/igc_tsn.c      | 67 +++++++++++++
 11 files changed, 347 insertions(+), 25 deletions(-)

-- 
2.42.0


