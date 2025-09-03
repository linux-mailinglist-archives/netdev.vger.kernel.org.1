Return-Path: <netdev+bounces-219690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7EB42ACF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E368918886D4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56822DF12F;
	Wed,  3 Sep 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6Fzebmg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843D2DE718
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931142; cv=none; b=ftShvOdzyO4BZoAVDLNai9z6wzgDm3g2ryk8CAzDXO2P5vbahziKjHOSt+nD0UbUGPFuJvGmIotJuIBiZsUx76NQFm9+MI+MAn5ColBKUTBBEIrBB+udvk6DEMsZm4JnWRPWlvsz3VaSmE7QIaMZVyJ5qGmHmmVW9annhX4N46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931142; c=relaxed/simple;
	bh=FbUebjzqGfjHXyXxgciosQwclhIcOAaKzW4O+Y9fsNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/aFhPuqRJijptNswYKt+Tck0v6jvREKBX270Thn4Gdj9vxBbjkX2Sdn54fS+n7SNoYu/r9geldJ4cMypq/lmk0NdbOseKEMCy/xJpNRpuS+/BHE/eBAyvmML+NteHRcFfaZRCUZ1zgVqj2riLtm8YIe9PILdbQ+G5aMDtFLy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6Fzebmg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931141; x=1788467141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FbUebjzqGfjHXyXxgciosQwclhIcOAaKzW4O+Y9fsNo=;
  b=l6FzebmgiQ8Iey6kDqWNiw7Cd2Wg0LFh1hydV4lH3+kkG5RVpWLulYNe
   agMhJtYfHUjMyoR7cMmuu6eozAykEiIgtW2yzlOLXfuwG/Ja0d4ApjsPs
   impWlZjP5IUwsg268pBK+cUjFIuWdZ2vgJ+y2RWhBgLe7qgUSxFAHsB8E
   3q4+WS7bYAE9crt2zOzByanuYs2WClrLJuoRuHuMU9GyMNiIPlDPGFQCK
   f27F29kInae9/cwQB3ou1pTHGDTdk1w7w/s+eTuO2DdHoxrja/spPkx9N
   f3PxDxIV3TXZdrugOz9hkAgC6EQ2keR2DbpqS8zrn+03O8qDqCt70/rC7
   g==;
X-CSE-ConnectionGUID: BGgjcRKfRwafFNJCfgLOEA==
X-CSE-MsgGUID: SWCBNTD8RsWUkHkMbbTtbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173000"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173000"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:40 -0700
X-CSE-ConnectionGUID: uY4uk5JMSQaQfPpIbzgGQg==
X-CSE-MsgGUID: y3OZ7CDcSWmUc1A7kkYWRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823439"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates 2025-09-03 (ixgbe, igbvf, e1000, e1000e, igb, igbvf, igc)
Date: Wed,  3 Sep 2025 13:25:26 -0700
Message-ID: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piotr allows for 2.5Gb and 5Gb autoneg for ixgbe E610 devices.

Jedrzej refactors reading of OROM data to be more efficient on ixgbe.

Kohei Enju adds reporting of loopback Tx packets and bytes on igbvf. He
also removes redundant reporting of Rx bytes.

Jacek Kowalski remove unnecessary u16 casts in e1000, e1000e, igb, igc,
and ixgbe drivers.

The following are changes since commit 1d8f0059091e757973324ae76253c2c059e0810f:
  Merge branch 'net-dsa-lantiq_gswip-prepare-for-supporting-maxlinear-gsw1xx'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Jacek Kowalski (5):
  e1000: drop unnecessary constant casts to u16
  e1000e: drop unnecessary constant casts to u16
  igb: drop unnecessary constant casts to u16
  igc: drop unnecessary constant casts to u16
  ixgbe: drop unnecessary casts to u16 / int

Jedrzej Jagielski (1):
  ixgbe: reduce number of reads when getting OROM data

Kohei Enju (2):
  igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
  igbvf: remove redundant counter rx_long_byte_count from ethtool
    statistics

Piotr Kwapulinski (1):
  ixgbe: add the 2.5G and 5G speeds in auto-negotiation for E610

 drivers/net/ethernet/intel/e1000/e1000.h      |  2 +-
 .../net/ethernet/intel/e1000/e1000_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c   |  4 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  3 +-
 drivers/net/ethernet/intel/e1000e/e1000.h     |  2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  4 +-
 drivers/net/ethernet/intel/e1000e/nvm.c       |  4 +-
 drivers/net/ethernet/intel/igb/e1000_82575.c  |  4 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c   |  2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c    |  4 +-
 drivers/net/ethernet/intel/igb/igb.h          |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  3 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c    |  5 +-
 drivers/net/ethernet/intel/igc/igc_i225.c     |  2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c      |  4 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 94 ++++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  4 +-
 20 files changed, 82 insertions(+), 73 deletions(-)

-- 
2.47.1


