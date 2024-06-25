Return-Path: <netdev+bounces-106582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB40916EBE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B61C218CC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A5172786;
	Tue, 25 Jun 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbRqrKNs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E462F56
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334985; cv=none; b=TcG/PwD0jogo2D2eiLwFLe2HWq21RJkDKAVSAcdTBXkrS6Nk4w3uatAbl8346viYrEEyaLIoZUiIF4vyErNWr2iAtw70Mt2NyFu81XdJeBU7IJvUqF8a6rsiED8vz33IBKTkzSVnz2aqbJdUyM+rf6uGwr2jAzr0hnYxJ1yX+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334985; c=relaxed/simple;
	bh=gmOwmSG7mgSUb84II4koyHa4CH3PJOovXLbcxeepTR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRpKDm9eGyAj2MAROxmhO4d5fH+oT17Q4SARjLgNapmBpBnvvijmKCRk+VSgceq8hrrEAWQdTtZGUe5hPqQF8uFN/mTBV1SOYJbIHetJKacSUA7EyXIUSFQCzVtJH2L7yvoOEq5RKOt60KE+YkCgzRh5t7isj1ccmKtO7XbmMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbRqrKNs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334984; x=1750870984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gmOwmSG7mgSUb84II4koyHa4CH3PJOovXLbcxeepTR0=;
  b=TbRqrKNsbcHjp/RC4cV5tsx+Hof8Mf0pyC9QOkMc7F68xL7ehNKkvE/3
   oES3vY+zgtbOMODK74+k+UjrUH1N9Qz39dccAt4k4iTm4we5Q/0FVLwHZ
   BuoFAd0w++Iq47/iX2xrXhiWxCBysXUxMRMlHSPVnPsP/taldCJ+qTsJU
   DxxvQXjVxDEI2s8Rnz6rzU3WFHbOx0AEFsuvXVuNwFW1sIbNaQef/0j8Q
   XCTRfu6PAnyhEIGDA2CuYWMkAnbY59oD4aUQ2wO43MQ/r9DLOLuYwJ9/4
   Ug7Ji2H9OSyxD604z5Bu2if/iARVwTr24Rt02yvUt4vRy6zMJdyk4rdxj
   g==;
X-CSE-ConnectionGUID: +l+YiLQ+Sseb4sOIdjogPQ==
X-CSE-MsgGUID: lM8vVl33QQauc+uC+FvcZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33825637"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="33825637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 10:02:54 -0700
X-CSE-ConnectionGUID: v7uCi4k1SaqwqsVYz9Vtow==
X-CSE-MsgGUID: P2EohHNJRTO1rydTsXepAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48893922"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2024 10:02:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-06-25 (ice)
Date: Tue, 25 Jun 2024 10:02:43 -0700
Message-ID: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Milena adds disabling of extts events when PTP is disabled.

Jake prevents possible NULL pointer by checking that timestamps are
ready before processing extts events and adds checks for unsupported
PTP pin configuration.

Petr Oros replaces _test_bit() with the correct test_bit() macro.

The following are changes since commit b1c4b4d45263241ec6c2405a8df8265d4b58e707:
  net: dsa: microchip: fix wrong register write when masking interrupt
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jacob Keller (2):
  ice: Don't process extts if PTP is disabled
  ice: Reject pin requests with unsupported flags

Milena Olech (1):
  ice: Fix improper extts handling

Petr Oros (1):
  ice: use proper macro for testing bit

 drivers/net/ethernet/intel/ice/ice_hwmon.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 132 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h   |   9 ++
 3 files changed, 112 insertions(+), 31 deletions(-)

-- 
2.41.0


