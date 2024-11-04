Return-Path: <netdev+bounces-141703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693209BC0FD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200B41F22AFB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D81FA270;
	Mon,  4 Nov 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlZREX4C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6B1FC3
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759805; cv=none; b=pHHfsZ40O+f4vsY7RktZkBN5idx39eZ4QSWUENCjga4u9w/TljeqkndVOrJDXrtTGeUVmTUZkPUseZcaDcS2OCoXuuautiAWyfmtvN6VmPi4QYZn1MzzAKl+jV01stQRThmWjmgzqm8ppBhWYoUXLAfGw9NCVL99kpRbsIitIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759805; c=relaxed/simple;
	bh=tc6ZjkHeG8I14blDsR4Zp5Tia0eaAhW9tlNkvJOn49w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuIJWNxFkVDyhUK6mw5fbaKsZD6+U95w3rJgF3ZjjduWwAoIrA7CwEvtZMYFaFy+3ANpzfnXqj34vJWFN7aph6jkeDO763ZhNg0nTKjqjCoKWbBOcotd4KtniXifYfvaMZmX3NBcDOs34MasYruRhOa+6sBYM0J06/boDnPt9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlZREX4C; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730759803; x=1762295803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tc6ZjkHeG8I14blDsR4Zp5Tia0eaAhW9tlNkvJOn49w=;
  b=MlZREX4C+zoBRhSXzZwQk2TI8CKw9EpCaNMTSG7MHIP73+vEnsKuDSnN
   hkQvZShG/DmWKQJU7WFL3BQZ8d8hpHwvrezmP5x1ggBx94uaqmBWqIo3B
   GsS4K+0n6A9r+wOz+fF+AKLJuuPgxm8QptGI/TiZ32udmYkdQWdDmssKJ
   joI8160jSzWkM/ngv7mGVZoA1bKKotLSZ9p+So/CFK9vo+LAXxktWY5Ud
   BIIcwb5FazHli3cUEgCJjQum7nzqWakx8IboAm81qiYP75j3moTa44m7H
   yzNOo3xrv38lWUm19da0EXyynslhcnUlPE0y54xyvql4V7RR5kUKxBwps
   w==;
X-CSE-ConnectionGUID: oqpKEDGDSTatpHdXKUkv2A==
X-CSE-MsgGUID: tTL0Xx/rQ0q3IDZXbAiEJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29901633"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="29901633"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:36:43 -0800
X-CSE-ConnectionGUID: Pvup/QX3SCKMQgt0xR3AgA==
X-CSE-MsgGUID: FFIWrLBuQ+CUvRVeZuMgcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83316970"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2024 14:36:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2024-11-04 (ice, idpf, i40e, e1000e)
Date: Mon,  4 Nov 2024 14:36:28 -0800
Message-ID: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Marcin adjusts ordering of calls in ice_eswitch_detach() to resolve a
use after free issue.

Mateusz corrects variable type for Flow Director queue to fix issues
related to drop actions.

For idpf:

Pavan resolves issues related to reset on idpf; avoiding use of freed
vport and correctly unrolling the mailbox task.

For i40e:

Aleksandr fixes a race condition involving addition and deletion of VF
MAC filters.

For e1000e:

Vitaly reverts workaround for Meteor Lake causing regressions in power
management flows.

The following are changes since commit 5ccdcdf186aec6b9111845fd37e1757e9b413e2f:
  net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine starts
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Aleksandr Loktionov (1):
  i40e: fix race condition by adding filter's intermediate sync state

Marcin Szycik (1):
  ice: Fix use after free during unload with ports in bridge

Mateusz Polchlopek (1):
  ice: change q_index variable type to s16 to store -1 value

Pavan Kumar Linga (2):
  idpf: avoid vport access in idpf_get_link_ksettings
  idpf: fix idpf_vc_core_init error path

Vitaly Lifshits (1):
  e1000e: Remove Meteor Lake SMBUS workarounds

 drivers/net/ethernet/intel/e1000e/ich8lan.c     | 17 ++++-------------
 drivers/net/ethernet/intel/i40e/i40e.h          |  1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 12 ++++++++++--
 drivers/net/ethernet/intel/ice/ice_eswitch.c    |  3 ++-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c   |  3 ++-
 drivers/net/ethernet/intel/ice/ice_fdir.h       |  4 +++-
 drivers/net/ethernet/intel/idpf/idpf.h          |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c  | 11 +++--------
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  3 +--
 11 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.42.0


