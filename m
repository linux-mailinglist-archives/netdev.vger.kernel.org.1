Return-Path: <netdev+bounces-84613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FE8979B0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCE428D4C6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A803155749;
	Wed,  3 Apr 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cahbM/fw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9751552FD
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175579; cv=none; b=nPmvSYhjJBparKwCacIT3k9ASAc2bMwdQedXzCbvhtYuXqJPU6gmhMqp6Q76y14xVy1mlu3xvR2Bd9blJQf/HBvegjj8LarAgUdXeHvg5J2BZPxq3IXjH7ojlKijHK1eI1LRPYtzmaqkfoZdz1mSq90gJRokkKORRajT9Hv53bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175579; c=relaxed/simple;
	bh=7lJN2wzz1zWnuNoemprhAkcYZD3uoLFS0tZwzhsoCRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INcTJQsOA8yiVFFG4Rw1QeBrVvg6C5m1QC/XS/ZMcB5fnQX0iWeupg/PdZc/SM9RRypOkH3u+m5czhSTKmYxPQjlJBuivxgrecR8vxMCaMlUnGnyhjVZFzyfYnwXWbNaJwRwimLR/7mVziCv+jdE57K9xz+IRtPB57tR35DKGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cahbM/fw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712175578; x=1743711578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7lJN2wzz1zWnuNoemprhAkcYZD3uoLFS0tZwzhsoCRc=;
  b=cahbM/fwqz8SGMcFMF8rhCeAGz1TNdL8zVybPbyrqI9gqHy6Xmk/9Egu
   LeJWrNHTepuMSlaDM3RRzOELoVDj/QUlUGETVlcig7pHUvE3nhNoxlsSL
   AaVtwDf25S58ZfyiDHoyR08LWkIUn4iH/v4Vuglp9qCb/qffUs0RfctNX
   uKpbmG3aI4LYyDDg/+RZ8YJsnN2kD1qK8zNyVTfWdWSaSE09M/uDUAInC
   nCHPG0Ot0kjQ6Hh4EARt2d4idcOE8SybsfgejCPvfpMFf2dbhlLe2na1g
   jzBS9RRQ9fr6FSHGicfV9F6zxkIGe4J1w4hNZWFjiXu3ULPbzNWaDPiu2
   Q==;
X-CSE-ConnectionGUID: Fke5Qk8YSkCzVocbsD+2rg==
X-CSE-MsgGUID: KSKPsXR3TDCimi/jDdwe/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18165799"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18165799"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:19:37 -0700
X-CSE-ConnectionGUID: Jgy7qbzgTpW4HrTd9yYYlA==
X-CSE-MsgGUID: vYnPWq31RrOWIq8ANeo8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18662687"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 13:19:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2024-04-03 (ice, idpf)
Date: Wed,  3 Apr 2024 13:19:25 -0700
Message-ID: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice and idpf drivers.

Dan Carpenter initializes some pointer declarations to NULL as needed for
resource cleanup on ice driver.

Petr Oros corrects assignment of VLAN operators to fix Rx VLAN filtering
in legacy mode for ice.

Joshua calls eth_type_trans() on unknown packets to prevent possible
kernel panic on idpf.

The following are changes since commit 0a6380cb4c6b5c1d6dad226ba3130f9090f0ccea:
  net: bcmgenet: Reset RBUF on first open
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Dan Carpenter (1):
  ice: Fix freeing uninitialized pointers

Joshua Hay (1):
  idpf: fix kernel panic on unknown packet types

Petr Oros (1):
  ice: fix enabling RX VLAN filtering

 drivers/net/ethernet/intel/ice/ice_common.c    | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c   |  2 +-
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   | 18 ++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c    |  4 ++--
 4 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.41.0


