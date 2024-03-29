Return-Path: <netdev+bounces-83406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C223289230B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BB41C211A8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAEF130AF3;
	Fri, 29 Mar 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ET+xXQz4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F513664E
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735000; cv=none; b=VaoOL6tntd3JVs4EIsBnjuzRy7wyPiJWS6wMuZTa3JMlPxTeFklu9D5QnrHfSqGuJSu4RlmidEpED0ZIEDTsky21kI2LtI4CqKhFcxcDDDxdDhN1j4iF2hmTofnEbEEAaBELzy18O0QHS8OR2jOW3tyGhTGuPwVOJXx8b90q8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735000; c=relaxed/simple;
	bh=B0J8vkgydgY6hjz5a7hDxWoIA655uUs7SqG77i58rzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoR0bMzn8PFdkp1A3ee+wfFJOYwjsH8Yybi3L+qt6/9I1dNaKjDxQDiXXM7wcyZSaJ9qRQum36CzIT6hZ0Gi2hyPzyWN1INF4JwXpBZMCKanBwRnfMPI24bParqL4df57X7t2mcs3Z+/LvR+b8YaRgFzSrPeFD1KGHJ4jetzwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ET+xXQz4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711734998; x=1743270998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B0J8vkgydgY6hjz5a7hDxWoIA655uUs7SqG77i58rzI=;
  b=ET+xXQz4KU6Y0sAaDugbCZlCAqZxIhNA4MWRQXi9QnMwMLzIf3VvY1Jo
   iLuJIRRujJHtF8Qggjjs2M4IZzzvfG3DQtl4Tf6+ilmP+8wL/W27ptXUb
   BNyMwrmIGvC3VsdN3mI60QSJXywFht2lfcjUoWsMvzyru6V+bjR6DoKwz
   sPACYC91o6LFqxBJX7YcynC9AU8dlRDS8d0V8dC4/wolvr4x2WM/hk1o/
   T0XIRdnqqyWrxLqJzrAmLmq2QUUZBBrL2jdQmOhrFY4krS6r5byOtCIY2
   RJWSQHE+ToCLozFsnv3dFyNL9O+4ZtumYY81TbfElmfU3+02bJksMS2CY
   w==;
X-CSE-ConnectionGUID: GxEFiz2ST5iZxEpPYN3u9A==
X-CSE-MsgGUID: vjP9j1XBQtKyWhch+rn7nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24422445"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24422445"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21499348"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 10:56:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2024-03-29 (net: intel)
Date: Fri, 29 Mar 2024 10:56:23 -0700
Message-ID: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to most Intel drivers.

Jesse moves declaration of pci_driver struct to remove need for forward
declarations in igb and converts Intel drivers to user newer power
management ops.

Sasha reworks power management flow on igc to avoid using rtnl_lock()
during those flows.

Maciej reorganizes i40e_nvm file to avoid forward declarations.

The following are changes since commit da493dbb1f2a156a1b6d8d8a447f2c3affe43678:
  Merge branch 'af_unix-rework-gc'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Jesse Brandeburg (2):
  igb: simplify pci ops declaration
  net: intel: implement modern PM ops declarations

Maciej Fijalkowski (1):
  i40e: avoid forward declarations in i40e_nvm.c

Sasha Neftin (1):
  igc: Refactor runtime power management flow

 drivers/net/ethernet/intel/e100.c             |    8 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |   14 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |   22 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 1050 ++++++++---------
 drivers/net/ethernet/intel/iavf/iavf_main.c   |    8 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   12 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   59 +-
 drivers/net/ethernet/intel/igbvf/netdev.c     |    6 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |    8 +-
 13 files changed, 602 insertions(+), 669 deletions(-)

-- 
2.41.0


