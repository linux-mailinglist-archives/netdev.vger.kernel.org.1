Return-Path: <netdev+bounces-82644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EEE88EEA6
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D59FB229CE
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113E14E2CC;
	Wed, 27 Mar 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+IPHt/+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0573A8E4
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565728; cv=none; b=AuB3G1506Ppts0n48RpHrUIf3zdkprPuOYSB/B7qmn4jiTkrYWHpZFUO+jEQtvZoUi3UAsO+L6+XwbFOPmZHvagDjfGfHcFXntDgzKIm8qepPTjyNjlh2gWW3s84LXoffaPWgv2VZa9v6U5OLjzq0ErUReSlWDG7FDpDmBdiUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565728; c=relaxed/simple;
	bh=B4j7DgJCFaLtmE6K1fcDBiShvPSMvPBPl8KjofgYPsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbubkhdZiR7Mi6rXDt2e9CxZsJXkCg98fjOhzOl687zgWSZcvx+3388gjCl3lSsj4tua82c2plpSyXXmwydtM193iTIySn0DNxgQY7IzgZt7t/04yGHAR4RGyh3Hdpz82BOtG3lnr2zG9sM+LWSRmDVSMgo9EIcF0Y5gbC0MmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+IPHt/+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711565728; x=1743101728;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4j7DgJCFaLtmE6K1fcDBiShvPSMvPBPl8KjofgYPsU=;
  b=E+IPHt/+l+MV406SyGnikWZo8qawwe3b1u6rjQ1wiRHL30xsnjlu+S4O
   TBqr+a5GpRxCzSOD+RKEaElNaAkDIxCFQwDSHEerrXaMuyZLpAvzmcwkA
   s5ny6ejn8vBbl/RvOq2lT9/5j2Q7I+M3uWy/KID6jIRMXDAsEe7vqNVO0
   LxzQ6pZbYgPw5U4//lWnZvliTUfRQ2pXq6VitNABkOiY+xcykpXUj0SzJ
   7n6U2ZfqSDMpcJdHesM0Si7+ZwM1fgqYQLRywk4DOf6ogNf5Y2oEpQaKN
   dFE3xKBeRtTNO9F8sfQI35EVRbhKeGUcMCsHqGngxAVreKo5wMNKGeE+h
   A==;
X-CSE-ConnectionGUID: mp21Hv9xRCyTheontm69bg==
X-CSE-MsgGUID: R87BfDfORgGbUB4FPBD43Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18122783"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18122783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16470599"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 11:55:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	sasha.neftin@intel.com,
	vitaly.lifshits@intel.com
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2024-03-27 (e1000e)
Date: Wed, 27 Mar 2024 11:55:11 -0700
Message-ID: <20240327185517.2587564-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to e1000e driver only.

Vitaly adds retry mechanism for some PHY operations to workaround MDI
error and moves SMBus configuration to avoid possible PHY loss.

The following are changes since commit afbf75e8da8ce8a0698212953d350697bb4355a6:
  selftests: netdevsim: set test timeout to 10 minutes
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Vitaly Lifshits (2):
  e1000e: Workaround for sporadic MDI error on Meteor Lake systems
  e1000e: move force SMBUS from enable ulp function to avoid PHY loss
    issue

 drivers/net/ethernet/intel/e1000e/hw.h      |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  38 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c  |  18 ++
 drivers/net/ethernet/intel/e1000e/phy.c     | 182 ++++++++++++--------
 drivers/net/ethernet/intel/e1000e/phy.h     |   2 +
 5 files changed, 161 insertions(+), 81 deletions(-)

-- 
2.41.0


