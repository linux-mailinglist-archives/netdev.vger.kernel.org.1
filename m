Return-Path: <netdev+bounces-76695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2D86E8BB
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FF1B2EFF7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A839AF3;
	Fri,  1 Mar 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIC+y6V7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3139AE3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318947; cv=none; b=nsB4bjzfcD2EeNe33wDfoZb/nEqzCd3yAlBqrr1fvZGCl0otEZTU85/5C7RcEBe9iPUzeXoyxDKzhcJJ0ghBZ8NM9SR4PurXinAJmz8td1AvK33Y4OekB92YgpcxjE2qrisHuHy3tWuPRoF9a9kQH7/eyYtfUvK6y7Ob+2DdQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318947; c=relaxed/simple;
	bh=2lF0MSBLx/YAl5oiFheH1nxkcVZUNKuUKpLkuCxysXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEMTZj2Azo1DNQyaBflp1x/7M818D3j3C/2NJghNP+kcGRUDy/LNNJC7HCScBPaJQW7ihtoYaPflmM2g06yihrOwSjOO9OY8IVxD7wlpJT5qboLZgj031Bv4w2fqV65u0U6G0n2ntu2JMLU+U4dp7ypxqNPz722YkkkB9LFb8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIC+y6V7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709318945; x=1740854945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2lF0MSBLx/YAl5oiFheH1nxkcVZUNKuUKpLkuCxysXo=;
  b=IIC+y6V7Yq+XHNFDvHGU6YMCCCNxfwCUAQzlloh5XGu2Tn6rppJQtR4/
   3rwAoqmv0yrUjlX1Hehh9zJHDR4DEAz0fNE9sgSWGl4FCkmgtTa6Ia2J5
   qTmhl+IuPWg5SCtluGEZq9oyqtLPPQpPQQ40r6ilpu0Ym1hnGHkKpL3pn
   QKqLIr8EkfABfKDTH1JXpSqOkcTwpkbHS4iNwYfmSun84tD7lJVxxTBdh
   Zx92MQxW/T8vcrL4F7D5IgL1DhxhYMZUYKA4BeRyX4JU8SVeroP0noWU6
   4z5yTCqt4ChYpD/9VL6yaehYayx9m75urOOyJoGKStaPNwjx20YAC9IDA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15303319"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15303319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8205835"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Mar 2024 10:49:04 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver Updates 2024-02-28 (ixgbe, igc, igb, e1000e, e100)
Date: Fri,  1 Mar 2024 10:48:01 -0800
Message-ID: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ixgbe, igc, igb, e1000e, and e100
drivers.

Jon Maxwell makes module parameter values readable in sysfs for ixgbe,
igb, and e100.

Ernesto Castellotti adds support for 1000BASE-BX on ixgbe.

Arnd Bergmann fixes build failure due to dependency issues for igc.

Vitaly refactors error check to be more concise and prevent future
issues on e1000e.
---
v2:
- Restore missing portions from original patch (patch 2)

v1: https://lore.kernel.org/netdev/20240229004135.741586-1-anthony.l.nguyen@intel.com/

The following are changes since commit 4ac828960a604e2ae72af59ce44dafdc8b12675f:
  Merge branch 'eee-linkmode-bitmaps'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Arnd Bergmann (1):
  igc: fix LEDS_CLASS dependency

Ernesto Castellotti (1):
This series contains updates to

The following are changes since commit e960825709330cb199d209740326cec37e8c419d:
  Merge branch 'inet_dump_ifaddr-no-rtnl'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Arnd Bergmann (1):
  igc: fix LEDS_CLASS dependency

Ernesto Castellotti (1):
  ixgbe: Add 1000BASE-BX support

Jon Maxwell (1):
  intel: make module parameters readable in sys filesystem

Vitaly Lifshits (1):
  e1000e: Minor flow correction in e1000_shutdown function

 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/e100.c             |  4 +--
 drivers/net/ethernet/intel/e1000e/netdev.c    |  8 ++---
 drivers/net/ethernet/intel/igb/igb_main.c     |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  4 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 32 ++++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  3 ++
 10 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.41.0


