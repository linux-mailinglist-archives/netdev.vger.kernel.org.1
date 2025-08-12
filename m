Return-Path: <netdev+bounces-213094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A0B23A38
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 22:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8476189AFF6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CC2C21C4;
	Tue, 12 Aug 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LANAh1Oh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64C295511
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031956; cv=none; b=aQJEdMdqTAXtXelsi30LYiKpMTibd9KCMRb6/GnJHbgf5wzGIbIuHIV6276WDrdDuDjCwWjJG/M39IUoR6XwoC6CB03N04KuS3Mc8G/IbgCeuxSrQa9MtDqVMYkWSEUfJ9TtuahtqinWMom7U7pdVOSQwp6hutCetV4c3F8l8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031956; c=relaxed/simple;
	bh=aeVVyGmI2mUCBp0WJwbZKBOaWC8eR4mGT6SMByYoL/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5fwIWXqlYD1F+58L2nGHTqQdu6E4SOhzkjB97gJOLTrx1VAcYlj9Y4xEy2IyvK0Jjm8Szi7wm+b0ptXIPteY/EO1H44Y7BKD+ZRduOyCV21V5gsI/P3JPQ55+ezI+d7LR70VZqC7Y3j8QuzECjUZSvs/5IPVl1yzkVxOXcuFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LANAh1Oh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755031955; x=1786567955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aeVVyGmI2mUCBp0WJwbZKBOaWC8eR4mGT6SMByYoL/g=;
  b=LANAh1OhVs0wy7cFDRGT6EwHkMLocQM+iRq4CVm3uaQStLn2muS4Ncov
   5Wl3DM4e1kJLJBsVjVrJVk7sRjCULQHvPuoR3CZuCPtALhM2u0P0jWC4O
   uuosMt/eKwrMtw7SWQsJ4oo7sPFN1jpkyWRSF806/6ljCoymMhkxUILC8
   C7VywkYtBxyBzby358+w7gJJs0h1re01CoSA47ytvGYllfkmpGzGzKOfY
   JkhRp85s91dyS/5uUIRPUPalBd30YHaXLISDx0GaZKAau7dx6LqYtfy7V
   GJ8Htc1c8OLmY8roqx6VD2UZ5kxP1l96DP6AFG54VEbCg12khhiSGOmpa
   g==;
X-CSE-ConnectionGUID: MncQ6ddeTs+F9SZUff+IrA==
X-CSE-MsgGUID: +uPgwTRhQ4S+W5PWdAswIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68775076"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68775076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 13:52:35 -0700
X-CSE-ConnectionGUID: JzMadPrnTiOq41p/kbn5LA==
X-CSE-MsgGUID: pX11Di+HTAW+ohGWDZCX0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="203474832"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 12 Aug 2025 13:52:34 -0700
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
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com
Subject: [PATCH net v3 0/2][pull request] ixgbe: bypass devlink phys_port_name generation
Date: Tue, 12 Aug 2025 13:52:22 -0700
Message-ID: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
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
v3:
- return -EOPNOTSUPP when flag set
- wrap comment to 80 chars

v2: https://lore.kernel.org/netdev/20250805223346.3293091-1-anthony.l.nguyen@intel.com/
- use shorter flag name (no_phys_port_name)
- move compatibility comment to kdoc
- adjust commit messages and titles

v1: https://lore.kernel.org/netdev/20250801172240.3105730-1-anthony.l.nguyen@intel.com/

The following are changes since commit c04fdca8a98af5fc4eeb6569917f159cfa56b923:
  Merge tag 'ipsec-2025-08-11' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 10GbE

Jedrzej Jagielski (2):
  devlink: let driver opt out of automatic phys_port_name generation
  ixgbe: prevent from unwanted interface name changes

 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 include/net/devlink.h                              | 6 +++++-
 net/devlink/port.c                                 | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.47.1


