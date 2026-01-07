Return-Path: <netdev+bounces-247501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259ECFB6C1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F253013556
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A310F2;
	Wed,  7 Jan 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMyA2nAv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5A3C2D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744415; cv=none; b=ZxL9PbWDlGwSRJ2EpKffyOlnrhlyvzu7PsSzPoI9eCQvWe7z9R45sdCdPYgKHbq3BbVwxgU1wOXAEsova7EGQ5/JxXiZoBCCXPmU4F29p7EWQ4J5Vfgpst5VgRSKdeHECyd3VWCLqc7xvYNrRmglN/W80eQgg+6PsGBbWG37+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744415; c=relaxed/simple;
	bh=qclWcBW0DEIMPqamIaFnW9ewHrVi/gN4zdPSuZky49k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1pQdO8/jT3/ofKwF8b5m30Ziqjgp08ME33GqEtzFXUI1WxkCrQM5H7PwfeaCRohWBWe1obkpk01ZE9OkNzt9+PVUQOqgxYDmMkb4Sthil3HoV3c+7wJraNfE3uaDIGm6op/MCBndRh2O+X2LhRkT7uvM6q7U8oG8LwNlehoz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMyA2nAv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744414; x=1799280414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qclWcBW0DEIMPqamIaFnW9ewHrVi/gN4zdPSuZky49k=;
  b=NMyA2nAv5/N5u3rhkk1nIWTg3ZMYyJXfuhio5EnBRo4Ld5eKBzm+YEfb
   IpyTXovcCFoyhWCg5qZHmZUB66iB+fgPp8B4xEiACMRydFhv00AoUVHwz
   zi8AmLiqZeSwaCuIkhTo1/m0tdFkP40YLhpelcMN6EahHoLMvwxDRF3do
   HGZhUQcQrVFUupDRnCUfOda/EYJFw8lwmf0DN4lc9NxrdcVu2feL5QvcV
   DSrj1RoNsVjTfPJzC16x6r9JU2ISkvQ1rArJ0WspyztdZUh+1RvwT5D/9
   5O4D/x4WosV5oq0v9aDUrVli4zJAmOpCqjfb1RBhiFyBwitnbG3VpxyPU
   g==;
X-CSE-ConnectionGUID: gEo5OmMSSgCEtqpGLH8NjQ==
X-CSE-MsgGUID: 6ywgHjGhRsGSWscecs0FiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161611"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161611"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:53 -0800
X-CSE-ConnectionGUID: 13Bp0/MoSyOHYAHfsK5WEQ==
X-CSE-MsgGUID: 9Y5H3YB5SnCkkUH7FKg4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841175"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	emil.s.tantilov@intel.com
Subject: [PATCH net 00/13][pull request] Intel Wired LAN Driver Updates 2026-01-06 (idpf)
Date: Tue,  6 Jan 2026 16:06:32 -0800
Message-ID: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to idpf driver only.

Emil fixes issues related to resets; among them timeouts, NULL pointer
dereferences, and memory leaks.

Sreedevi resolves issues around RSS; mainly involving operations when
the interface is down and resets. She also addresses some incomplete
cleanups for ntuple filters and interrupts.

Erik fixes incomplete output of ntuple filters.

Josh sets restriction of Rx buffer size to follow hardware restrictions.

Larysa adds check to prevent NULL pointer dereference when RDMA is not
enabled.
---
Note: Patch 3 may be flagged by AI review may as a possible NULL pointer
dereference on the netdev, however, with patch 1 and 5 the netdevs are not
passed to the service task as NULL [1].

[1] https://lore.kernel.org/intel-wired-lan/3e9dc8fd-9052-4c53-ba40-5904306d09fb@intel.com/

The following are changes since commit 238e03d0466239410b72294b79494e43d4fabe77:
  net: fix memory leak in skb_segment_list for GRO packets
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Emil Tantilov (5):
  idpf: keep the netdev when a reset fails
  idpf: detach and close netdevs while handling a reset
  idpf: fix memory leak in idpf_vport_rel()
  idpf: fix memory leak in idpf_vc_core_deinit()
  idpf: fix error handling in the init_task on load

Erik Gabriel Carrillo (1):
  idpf: fix issue with ethtool -n command display

Joshua Hay (1):
  idpf: cap maximum Rx buffer size

Larysa Zaremba (1):
  idpf: fix aux device unplugging when rdma is not supported by vport

Sreedevi Joshi (5):
  idpf: fix memory leak of flow steer list on rmmod
  idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
  idpf: Fix RSS LUT configuration on down interfaces
  idpf: Fix RSS LUT NULL ptr issue after soft reset
  idpf: Fix error handling in idpf_vport_open()

 drivers/net/ethernet/intel/idpf/idpf.h        |   7 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  92 ++++--
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 274 ++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  46 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   6 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  13 +-
 7 files changed, 256 insertions(+), 184 deletions(-)

-- 
2.47.1


