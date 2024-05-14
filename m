Return-Path: <netdev+bounces-96420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FE8C5B5F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A81C20B18
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB961E536;
	Tue, 14 May 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+1HNN3j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71F51C45
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712694; cv=none; b=esUbiqjLIOtj2mil1OGOVNKUbx6XL9I4nAZtKXPua1U+F88Z/dmU6lB3uVJXwg0ysfDzXj//ekdA4sq5S5tadQ9Uyk8KONl8tLsumIRrvl0CzbOF8ZvFdv4MqwDy2VUiXrWe+AQYGmNDmYM8KM3LL/OwAWB2UtXSgECc97dSF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712694; c=relaxed/simple;
	bh=1DiMECUS9vcJhiTz2SDIvLU5NAqQbnPohZ06Ek/KTyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZg5WGkogidCFZDsqMaqW1gxTuOgPV9ukEa96/84s1+/X6MVAPbaoQBl3kWLkULR8QRwomHWZyTmWJc2lKW4TI8lsi/Z/ZEAj72rvncxkr9IKs/Yy6KqbJ3QoaA5E1zfkbRo51H2H/NJnEjWNH+wQWts/2MNX87n0Y1NCHngFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+1HNN3j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715712692; x=1747248692;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=1DiMECUS9vcJhiTz2SDIvLU5NAqQbnPohZ06Ek/KTyc=;
  b=R+1HNN3jz3Xod/6nM8grUSVwZSz7G23E+Sh6flw3EdYfhA57RpFGtGac
   RgPWHZG5rqa8Qiz0zUWjo+K87lzGP96IDpjwrme1p/T7TKUmBmimxoXSk
   53k3H69tCvnxxv2K25w0+eeDyzkpirjfz4b4xG0xgyewANVtJTEkF8V6L
   kp6uCFXoZVoHAC+YPA89Okp18mGQ6yz/ycGoIUNTuGwOErNbew193w+vw
   DZP4g/3QeH43/QZJ+bVRfsWVtX2sAgDnQSqY6gLVa271nrcl4qjqS1Cwb
   /nXMyNcqDucsezi4RvtmHGJFqnLtSpVxG4IM3DGcwhW52sTm84VWBZcnL
   w==;
X-CSE-ConnectionGUID: wX5a4vp+RkCgjIRhAU2csQ==
X-CSE-MsgGUID: Z+g/FwcdR1Omi1PCCgtZJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29240325"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29240325"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:51:30 -0700
X-CSE-ConnectionGUID: +cUecXJoQj638x7nzQD5/w==
X-CSE-MsgGUID: 2nx2lXEESx+RwC9a+bpDDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30789934"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:51:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/2] intel: Interpret .set_channels() input differently
Date: Tue, 14 May 2024 11:51:11 -0700
Message-Id: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCyQ2YC/5WNQQ6CQAxFr0K6tmYGZoC48h6GBQ5FmuBgpgQ1h
 LtbuIHL9377/wpCiUngkq2QaGHhKSrYUwZhaOODkDtlyE3ujLcO+T1ipBl3gcajKlHcjyONgj1
 /SDD3dyp749q67EC7XomOQKtuoO/QqBxY5il9j+3FHtGfM4tFg3VRVLVpQ1W4/spxpvEcpic02
 7b9APQgeRrfAAAA
To: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, 
 Krishneil Singh <krishneil.k.singh@intel.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

The ice and idpf drivers can trigger a crash with AF_XDP due to incorrect
interpretation of the asymmetric Tx and Rx parameters in their
.set_channels() implementations:

1. ethtool -l <IFNAME> -> combined: 40
2. Attach AF_XDP to queue 30
3. ethtool -L <IFNAME> rx 15 tx 15
   combined number is not specified, so command becomes {rx_count = 15,
   tx_count = 15, combined_count = 40}.
4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
   new (combined_count + rx_count) to the old one, so from 55 to 40, check
   does not trigger.
5. the driver interprets `rx 15 tx 15` as 15 combined channels and deletes
   the queue that AF_XDP is attached to.

This is fundamentally a problem with interpreting a request for asymmetric
queues as symmetric combined queues.

Fix the ice and idpf drivers to stop interpreting such requests as a
request for combined queues. Due to current driver design for both ice and
idpf, it is not possible to support requests of the same count of Tx and Rx
queues with independent interrupts, (i.e. ethtool -L <IFNAME> rx 15 tx 15)
so such requests are now rejected.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Larysa Zaremba (2):
      ice: Interpret .set_channels() input differently
      idpf: Interpret .set_channels() input differently

 drivers/net/ethernet/intel/ice/ice_ethtool.c   | 22 ++++++----------------
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 21 ++++++---------------
 2 files changed, 12 insertions(+), 31 deletions(-)
---
base-commit: aea27a92a41dae14843f92c79e9e42d8f570105c
change-id: 20240514-iwl-net-2024-05-14-set-channels-fixes-25be6f04a86d

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


