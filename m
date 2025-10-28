Return-Path: <netdev+bounces-233636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988EC16C1B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A42A18973CD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78852BD59C;
	Tue, 28 Oct 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdqC5sIS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328A21D5B0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683124; cv=none; b=tE09Z3VL4Aw8FKYFrAPtFmMKdvKA+vnOsAzH5hLRUSHTVRmOsTZuyCMqHXoKCj+PL3WngrMv1K36ouHk+aXM8sy7f5qkgvZ8RJnP/nQLXlQgS9s7PrCGKsk3zoeJHNKv8jD+zAlT9QzBUCbxu/joqwIUqIPiNSns5QpSW44GIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683124; c=relaxed/simple;
	bh=Xi70oGj/LPSRXBpiVxBQDbD1wenV1opYVOibDp97Q0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCfjal/TAlonpJkI/6m2cOV3dOHmvBldv/ClfZ0KRuAs+AsxqApS9/WtdB6w61ThvPBwul/P4LMGxUXi7Oge59DUTV6wOqwzu+BSyjoXamAVtPMUlwuD5I+Cluua3JIZ0k7L8s8TMIZmFwhS6crjqX/VO7ZMeZAAsQjm/lORXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdqC5sIS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683123; x=1793219123;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xi70oGj/LPSRXBpiVxBQDbD1wenV1opYVOibDp97Q0Q=;
  b=gdqC5sISNBwGJrCZvf26HUWlXTT793NurA8TKrDh3epO9Q4RvwdfAM9e
   0cZWv5g5vty2tNWCrFyx7eZSudVtH3rdnmQ5b6Q6XX6RBuS/TWQhJbbpv
   Bnz3um3cMzpGnfjBURGRKWU/BylFVL3DkhZ4hkFNT9fwMVZBBcVVgpTEf
   AZLNJ23cxaaRAO2Lfvu+BQvTQh9rsucOdbx5Wbd02tu4gpgftk+txK1Dc
   SjtkGpGf8FuDC5QVvMfX1oCafLlU1lMkdiFRX/ftb0TDyW+5UiIrnvur5
   KLMBm5zcDEnwxXQLVZW+hB54LHr6RRlgBCRG44grQlLIRySQBo/rKuEyD
   w==;
X-CSE-ConnectionGUID: +uilc4MqTPilFpoquBgEFA==
X-CSE-MsgGUID: x9lP+JFpTN63Bj0Cph9aUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825145"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:22 -0700
X-CSE-ConnectionGUID: I+cZiujNSRauRYwwQ/bJ2A==
X-CSE-MsgGUID: w0bQ7BYbQpSmSiNqNJVtDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790141"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:22 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2025-10-28 (ice, ixgbe, igb, igc)
Date: Tue, 28 Oct 2025 13:25:05 -0700
Message-ID: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice, Grzegorz fixes setting of PHY lane number and logical PF ID for
E82x devices. He also corrects access of CGU (Clock Generation Unit) on
dual complex devices.

Kohei Enju resolves issues with error path cleanup for probe when in
recovery mode on ixgbe and ensures PHY is powered on for link testing
on igc. Lastly, he converts incorrect use of -ENOTSUPP to -EOPNOTSUPP
on igb, igc, and ixgbe.

The following are changes since commit 210b35d6a7ea415494ce75490c4b43b4e717d935:
  dt-bindings: net: sparx5: Narrow properly LAN969x register space windows
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Grzegorz Nitka (3):
  ice: fix lane number calculation
  ice: fix destination CGU for dual complex E825
  ice: fix usage of logical PF id

Kohei Enju (5):
  ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()
  igc: power up the PHY before the link test
  igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
  igc: use EOPNOTSUPP instead of ENOTSUPP in
    igc_ethtool_get_sset_count()
  ixgbe: use EOPNOTSUPP instead of ENOTSUPP in
    ixgbe_ptp_feature_enable()

 drivers/net/ethernet/intel/ice/ice_common.c   | 35 +++++++++++++++++--
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |  1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  5 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 7 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.47.1


