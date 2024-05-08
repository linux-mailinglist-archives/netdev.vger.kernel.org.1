Return-Path: <netdev+bounces-94683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC38C0330
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE662820E4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0212AAE7;
	Wed,  8 May 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNCdjSlb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76439128815
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189633; cv=none; b=o+37audIVGjI74ta+UyF9J/VI8TlkRrWudGDAdcWtvUAQpOJk44TrVa5IWonHSk6hcxxTJuIF7Q3LyuLzyu1uI/LLAnvOoN1+Z3rY8f8u+ZkUS5riwRHGkVY++dXAmVEVtTD9qoe8cUMHdLdhqesrHdbn/EdK/f0jg0bu0hHMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189633; c=relaxed/simple;
	bh=CoZh6PDD3CdW+JLta9ATA7XPkcbhD9d6tqCPYv+f7DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPLBHU7GYy5BScMTDE2yhRStLb709LvDsx0b6h0QVMS/Re9JZArfFckpxPwu8V3Pi0TkOzsAdCTIaDNBlU8e/+uj7Q9BGfPJ4iExgB5UxuUWMR9F5JlktkztycwSn3PhVbu63DMWI9C8KwYQYIGaA4059m1ECO3hrHk97JoOEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNCdjSlb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189631; x=1746725631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CoZh6PDD3CdW+JLta9ATA7XPkcbhD9d6tqCPYv+f7DU=;
  b=HNCdjSlb4E2Sn0QyvsycdwNHiCZ1Qt1jvjQLoT5vRqlmPqH6gvaK7n5U
   84R23xsQlpUXlQCbVlFCIXxVFruZe1Zfat5epaPW7isg9l8/dtLiPvZxx
   4XfUjFcgR0mkeNMD3U9ux/K6q9+4bb3ID9mjCYdHrW74L0sd/1/L1D9Vs
   IY0P7dOqjBcNbVBAh2ozgw8g74wyc1wD4bWOjEKLdheXuH5lbp2vOOqwG
   +wldX94Ng4TOjhCgd/z6y5GPAuLVEmtACvKRlyJ0xbfjxawkkgPxFzEDX
   hX6E1ooF4vzTU1mUYiDV+hBsHiYXeREMC+Im5465HDVT2EC59ShqnVRRa
   g==;
X-CSE-ConnectionGUID: jueU9bSFS5mfIUKlmtToDw==
X-CSE-MsgGUID: /mirydP0QdOezsp6fvV2dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938937"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938937"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:51 -0700
X-CSE-ConnectionGUID: bIySVIKdTwKw/nUGS3wb4A==
X-CSE-MsgGUID: U7ZqoOsUTSGrcnAc8KCZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843704"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 10:33:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates 2024-05-08 (most Intel drivers)
Date: Wed,  8 May 2024 10:33:32 -0700
Message-ID: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to i40e, iavf, ice, igb, igc, e1000e, and ixgbe
drivers.

Asbjørn Sloth Tønnesen adds checks against supported flower control flags
for i40e, iavf, ice, and igb drivers.

Michal corrects filters removed during eswitch release for ice.

Corinna Vinschen defers PTP initialization to later in probe so that
netdev log entry is initialized on igc.

Ilpo Järvinen removes a couple of unused, duplicate defines on
e1000e and ixgbe.

The following are changes since commit 252aa6d53931381bd774acd06866ed0fb1976ead:
  test: hsr: Call cleanup_all_ns when hsr_redbox.sh script exits
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Asbjørn Sloth Tønnesen (4):
  i40e: flower: validate control flags
  iavf: flower: validate control flags
  ice: flower: validate control flags
  igb: flower: validate control flags

Corinna Vinschen (1):
  igc: fix a log entry using uninitialized netdev

Ilpo Järvinen (1):
  net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates

Michal Swiatkowski (1):
  ice: remove correct filters during eswitch release

 drivers/net/ethernet/intel/e1000e/defines.h   | 2 --
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++++
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 4 ++++
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 4 ++++
 drivers/net/ethernet/intel/igb/igb_main.c     | 3 +++
 drivers/net/ethernet/intel/igc/igc_main.c     | 5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 -
 8 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.41.0


