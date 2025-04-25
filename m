Return-Path: <netdev+bounces-186165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C226A9D575
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858C81BA484D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443F291166;
	Fri, 25 Apr 2025 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llNg7sgN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BF290088
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620007; cv=none; b=KsEpxyDqAHN6PzpIYBZu76AP5iBQQcRAVhdVU6ZTEiS3OC/oN/U30gaqkqtNgQVBN6ledztPXVZfF7IhACBV0BAcaQDwvcBaa4ivBQ6wm9mc9Z5chUPeY4HBDOmFlmlcqgW96OcJl2ONLkqzqKh4Z19ZFsCkQFlp64B93eR4zMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620007; c=relaxed/simple;
	bh=A2C87Ky7UsdyRFqD2zjjJTLxIzckqp4LSy1Nru/mwQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdQhZItej6Dwd1bGQFX56amzT0d/C3SU4h6M0BSwbzkTBTOePEydgigeI6ZQmo05uO26YkqoTbdkPsO7kcRVhu8Sk2UAHnDJxlP88ZasWUaro+/s8G2R51Q+Sdnxk+h57Fr/k1sVKDWDrienpWDYRmJaijLcojxe6PtGuUqsWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llNg7sgN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745620005; x=1777156005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A2C87Ky7UsdyRFqD2zjjJTLxIzckqp4LSy1Nru/mwQw=;
  b=llNg7sgNVXfzWQYSBLSABXjGdKrzX/UH5UqdxGnVmRp10W3EZnjWWqqp
   0Awo0x2LuvnYjXvcuQbSWqFJbwxvmRAJh5t2/tLbSATncZMd43wt1c/tu
   aLHGoy2afgBaQXxlczS2/oVkPISsRuVgTH23BCtUpYeHLfVFGnLCKQ39I
   1m3h4V8vY87RWMZKs7hXS8Y4v3DRzSymtSY8uffbwWMiczIZzQ4bNsDf9
   HvCx2nuyZ8gzMAhoUQlwslTpmMt3fhUki8pbU7e1FA/UYbA/9/+7NxwqM
   Fis3n7V/Lq2x1ybWnc9/5aSJB6Lah5xleHmWuj5Swuv4JvD7WeRwWZ7Kp
   g==;
X-CSE-ConnectionGUID: 9goMtTWFS3eESNIEnSEp3Q==
X-CSE-MsgGUID: aKE1My7wRP+EAOcqO3TT4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="50961367"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="50961367"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:26:45 -0700
X-CSE-ConnectionGUID: E1yKuTSISQmPou5QiP27Cw==
X-CSE-MsgGUID: CfcKjKuUTIm4EMrvi5WqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133533697"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Apr 2025 15:26:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 0/3][pull request] Intel Wired LAN Driver Updates 2025-04-22 (ice, idpf)
Date: Fri, 25 Apr 2025 15:26:30 -0700
Message-ID: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Paul removes setting of ICE_AQ_FLAG_RD in ice_get_set_tx_topo() on
E830 devices.

Xuanqiang Luo adds error check for NULL VF VSI.

For idpf:
Madhu fixes misreporting of, currently, unsupported encapsulated
packets.
---
v2:
- Remove, now, unused defines (patch 3)

v1: https://lore.kernel.org/netdev/20250422214822.882674-1-anthony.l.nguyen@intel.com/

The following are changes since commit 49ba1ca2e0cc6d2eb0667172f1144c8b85907971:
  Merge branch 'mlx5-misc-fixes-2025-04-23'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Madhu Chittim (1):
  idpf: fix offloads support for encapsulated packets

Paul Greenwalt (1):
  ice: fix Get Tx Topology AQ command error on E830

Xuanqiang Luo (1):
  ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

 drivers/net/ethernet/intel/ice/ice_ddp.c      | 10 ++--
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  5 ++
 drivers/net/ethernet/intel/idpf/idpf.h        | 18 +++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 57 +++++++------------
 4 files changed, 37 insertions(+), 53 deletions(-)

-- 
2.47.1


