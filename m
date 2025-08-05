Return-Path: <netdev+bounces-211816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8621B1BCB3
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B907F1884BFD
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDBA218ACC;
	Tue,  5 Aug 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYcHKOtP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851B125A9
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433313; cv=none; b=Ea8bYtMUdzsuO6L1+lsE8eCxSKkO4WN/3HsglIsj9v/N2adxOrxfPcEYuu0SIqDsKXmteNq0pWLOxP5GMy0FEKxAlpo8DVx62wiEtYnH4XXcPLbavbx6et9SYpWB+/ao6XCE+Z15cnZr5I+j9EHVo/G6ci5d8rRunoFXaTC5YqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433313; c=relaxed/simple;
	bh=RnDrd7R8M/ZSPDLJvIRNfEUFzTkz6b6V9ErayTmkPWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEdaDzMZJH1OsWJZxr1fupFp5QCeJd6tvzQoycjQYFK/8KSlaLg8wgcF3h4ZZxWyFD81wHx8e/vQLWDaxQl6A3yAaJOIl5rE2/8TAvekB8QjtDylQS2jqENluuYJQuSf25kbxjb8667ZRL1uw9Wx5+Ms7tbQ55sAuXsiwIW1P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYcHKOtP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754433311; x=1785969311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RnDrd7R8M/ZSPDLJvIRNfEUFzTkz6b6V9ErayTmkPWI=;
  b=nYcHKOtPZ+EgToNSgjxhdBRcEF3mcXEmJfFBS2Hnu64OS8cUQ6CWTq6f
   bCQDZ3FdTZjrfG/udIo/70bmd/773UBsMf7UWVSrpEs0m4F7juNUKspXJ
   xQbrHlHZ5sqMzbzj9EjqEzst4NV7FveuZlDIEmtXdUpAhEI5mYBWpD4lZ
   kxczD3aMEY8CuEg0QjtkadPGo+ykH5cYksYeLeJM1TjKma+wwpGhmG2sL
   hEj5TFAaPpr+JRYs61RejZIQ+W3eMEXZ78xUTDlSF8lXIeYLu1ma04MGS
   EkqnBi+keSnL3JTR7QBSJrQGZmeC51sBE5o6XolnShY9l3mEEc5bFWZ7+
   Q==;
X-CSE-ConnectionGUID: Y2PAKLxhQdeGtDjZCQAlNw==
X-CSE-MsgGUID: 0iiYZGx9Q8SDos3qJnwVjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56658093"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56658093"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:35:11 -0700
X-CSE-ConnectionGUID: Li9HrJL7TH6R2l4pBi16bQ==
X-CSE-MsgGUID: epcqx3jlSO+Yun8tL+xXKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164515363"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2025 15:33:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com
Subject: [PATCH net v2 0/2][pull request] ixgbe: bypass devlink phys_port_name generation
Date: Tue,  5 Aug 2025 15:33:40 -0700
Message-ID: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jedrzej adds option to skip phys_port_name generation and opts
ixgbe into it as some configurations rely on pre-devlink naming
which could end up broken as a result.
---
v2:
- use shorter flag name (no_phys_port_name)
- move compatibility comment to kdoc
- adjust commit messages and titles

v1: https://lore.kernel.org/netdev/20250801172240.3105730-1-anthony.l.nguyen@intel.com/

The following are changes since commit 4eabe4cc0958e28ceaf592bbb62c234339642e41:
  dpll: zl3073x: ZL3073X_I2C and ZL3073X_SPI should depend on NET
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 10GbE

Jedrzej Jagielski (2):
  devlink: let driver opt out of automatic phys_port_name generation
  ixgbe: prevent from unwanted interface name changes

 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 include/net/devlink.h                              | 5 ++++-
 net/devlink/port.c                                 | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.47.1


