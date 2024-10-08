Return-Path: <netdev+bounces-133332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71541995B45
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B307B20D6E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA00215023;
	Tue,  8 Oct 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpXNobUG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608971E00A9
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428471; cv=none; b=TJRIW9W05ECTe564Xy5bHO2utX7O+/YES5GDxM7Z5aNg4iOeafQlD1OVeMZ2EfpIM8VRNE3S8l1Hv30Rj44LQPTZOCz1jXNQZZurdhBHKEpSuXXoTEQrXykJLUYUGqyHjv9cqWvzkfeyz/j4pXr+f6NGKsQ/QH/jPRxFfFfTNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428471; c=relaxed/simple;
	bh=7rrs//OidUG2+lzDVYvyWthw8DLbjZlS/pKTM/+4HvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6UoO0z2W6XkOqzjYGHFhpwqxoZseaW53CxIkf4+h+7UOMST/tbfHPFi5BRYmqIegQZKDHtM+JitbLlTpODME0iC86O5kYJelsummaIEbGlRMRVb05H/feGb01OFv1GjD6jVGtS3T/BsD7M5iV+MuhDh8G51/sh1xoqyNo2Lt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpXNobUG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428469; x=1759964469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7rrs//OidUG2+lzDVYvyWthw8DLbjZlS/pKTM/+4HvU=;
  b=hpXNobUGEP2jA4Tmdkl/oyBDGhoSRHimFMeDaPaExFxArBQnJSx++6no
   +rGZcFpAbq16V+4kD4CCPEpsupbxfq05rGWkTKlXSFqxpdAuf91Kk2WPX
   Sd7TY/7QlO/oc0f082iu9qQ+9qnxJogRpjOGh/JjjCMjU1LejcktgLJ1J
   kuBZzAx0zZ7vpktQJYFsGRIobcK2GkMgrLgHbD9UIt/QWaf+LuoqQTWG0
   HrPBmM1kRZxD+DpxsXK+afwJcgrqPHP1GOZhDjW1BJtMZnzDOE2ceVTjV
   KyOErJT61ybYCwX6bliBPVDc3E2ZD4wb0CaPOiaXWlOrk+Cb3xv96k6cI
   Q==;
X-CSE-ConnectionGUID: Rxu/OV0hTr2LZj69ueZBkA==
X-CSE-MsgGUID: 5u3heTgERP+q+ui73pgjlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302384"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:08 -0700
X-CSE-ConnectionGUID: k92zPG1aRHWzgWjj5eMtRg==
X-CSE-MsgGUID: aKKZKPoJTjyW245vM3Tmtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787565"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/7][pull request] Intel Wired LAN Driver Updates 2024-10-08 (ice, i40e, igb, e1000e)
Date: Tue,  8 Oct 2024 16:00:38 -0700
Message-ID: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice, i40e, igb, and e1000e drivers.

For ice:

Marcin allows driver to load, into safe mode, when DDP package is
missing or corrupted and adjusts the netif_is_ice() check to
account for when the device is in safe mode. He also fixes an
out-of-bounds issue when MSI-X are increased for VFs.

Wojciech clears FDB entries on reset to match the hardware state.

For i40e:

Aleksandr adds locking around MACVLAN filters to prevent memory leaks
due to concurrency issues.

For igb:

Mohamed Khalfella adds a check to not attempt to bring up an already
running interface on non-fatal PCIe errors.

For e1000e:

Vitaly changes board type for I219 to more closely match the hardware
and stop PHY issues.

The following are changes since commit 1fd9e4f257827d939cc627541f12fc4bdd979eb1:
  selftests: make kselftest-clean remove libynl outputs
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Aleksandr Loktionov (1):
  i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Marcin Szycik (3):
  ice: Fix entering Safe Mode
  ice: Fix netif_is_ice() in Safe Mode
  ice: Fix increasing MSI-X on VF

Mohamed Khalfella (1):
  igb: Do not bring the device up after non-fatal error

Vitaly Lifshits (1):
  e1000e: change I219 (19) devices to ADP

Wojciech Drewek (1):
  ice: Flush FDB entries before reset

 drivers/net/ethernet/intel/e1000e/hw.h        |  4 +--
 drivers/net/ethernet/intel/e1000e/netdev.c    |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 ++
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  5 ++-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 31 ++++---------------
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 11 +++++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  2 +-
 .../ethernet/intel/ice/ice_vf_lib_private.h   |  1 -
 drivers/net/ethernet/intel/igb/igb_main.c     |  4 +++
 11 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.42.0


