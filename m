Return-Path: <netdev+bounces-164334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D2A2D658
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 14:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C277A3DAF
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075F246354;
	Sat,  8 Feb 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtlYOnKr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C21B0434;
	Sat,  8 Feb 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739021888; cv=none; b=Dee4WTQ++TwV4IooV9jM7X+bdEc1lxgXHZdPRvPVUbU4WGPm8AwT8qOMBatZl/eh6CYPdqQ0LXuAAsWhtXMjzswXhCsuqJ0nAJmfwmgiuNo/OcGRrPcW8CliBY9txAFr66KwjlWOsqg0DXTb62VsnwR+ro2h50Mp32CUH3RfctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739021888; c=relaxed/simple;
	bh=9xCYQsWJ9XtnOZOIYs9liH1X4ipwXFUUSjZNOHqjUH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdi2DvkcIpGWT0EJkQxssC/DvF4XVlVtuPNxtJKSuxprF0xKlDlo8fe+ZoDvx3O1JHOaLWGA7XymWYe/usPW3raFGOLWKH9coy5SXXSopjGCTampyTld2h1WqcuxaKsQ301vRaXKz37E/GJ/STMAJ0rICLHiC67o7bmOZ3iKA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtlYOnKr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739021887; x=1770557887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9xCYQsWJ9XtnOZOIYs9liH1X4ipwXFUUSjZNOHqjUH8=;
  b=FtlYOnKrJMsvbnZ9wcUkc1KceZX0+g5AzIao1K2H/4H3exuE6c+KpmJJ
   XHAU7i0gmEhX/3x4Rd1D1kHs+p23oc/Pb6uH6EC9iLwHV2edn2WRzKaM1
   9hYL+nuj/41arlat2KquFr3sYWwkn9aVlbvD+NhcgxGqkTOLu9ow28D7R
   YJFbPUSvAFwTSIJml7AXyYofAsShlC5zr6bDzFbGLPgsBCjvJqZbabiGY
   FMkuqVZsUjsZApguGe+lTzkIp15aHjlf7sOyBbZXus36sCM25ngnRdHaT
   Hg1qGLPwx3znD+ENex9ARiWTfq3dixy1Ga7rCDdQkIBbf0yi9pM3GEvIR
   A==;
X-CSE-ConnectionGUID: JIcn7QxhSNC3/Qa6/o5GzA==
X-CSE-MsgGUID: I7c9Df9aSzufrpvSbpNl0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51084796"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51084796"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 05:38:06 -0800
X-CSE-ConnectionGUID: luwDg+C5QLOfSYr5X93OhA==
X-CSE-MsgGUID: FYwLAcshQJuk1QjJbraF9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116980853"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 08 Feb 2025 05:38:02 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B59B7312FD;
	Sat,  8 Feb 2025 13:38:00 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: [PATCH iwl-next v3 0/6] ice: LLDP support for VFs
Date: Sat,  8 Feb 2025 14:22:41 +0100
Message-ID: <20250208132251.1989365-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to:
* receive LLDP packets on a VF in legacy mode
* receive LLDP packets on a VF in switchdev mode
* transmit LLDP from a VF in switchdev mode

Many VSIs can receive LLDP packets, but only one VSI
per port can transmit LLDP, therefore LLDP TX from VF
requires adding an egress drop rule to the PF, this is
implemented in these series too.

There are no patches that explicitly address LLDP RX in
switchdev mode, because it just works after adding support
in legacy mode.

Usage

To receive LLDP packets on VF in legacy mode:
On host:
ip link set dev <pf_ifname> vf <n> trust on
On VM:
service lldpd restart

To receive LLDP packets on VF in switchdev mode (host config):
tc qdisc add dev <pf_ifname> clsact
tc filter add dev <pf_ifname> protocol lldp ingress \\
   flower skip_sw action mirred egress mirror dev <repr_ifname>

To transmit LLDP packets from VF (host config):
tc qdisc add dev <pf_ifname> clsact
tc qdisc add dev <repr_ifname> clsact
tc filter add dev <pf_ifname> egress protocol lldp \\
   flower skip_sw action drop
tc filter add dev <repr_ifname> ingress protocol lldp \\
   flower skip_sw action mirred egress redirect dev <pf_ifname>

For all abovementioned functionalities to work, private flag
fw-lldp-agent must be off.

v2->v3:
* fix sparse warning caused by part of .sw_act members being initialized
  inside the curly braces and others being initialized directly
* reorder members inside the rinfo initializer according to struct
  definition in ice_drop_vf_tx_lldp(), while fixing the warning above

v1->v2:
* get rid of sysfs control
* require switchdev for VF LLDP Tx
* in legacy mode, for VF LLDP Rx rely on configured MAC addresses

Larysa Zaremba (4):
  ice: do not add LLDP-specific filter if not necessary
  ice: remove headers argument from ice_tc_count_lkups
  ice: support egress drop rules on PF
  ice: enable LLDP TX for VFs through tc

Mateusz Pacuszka (2):
  ice: fix check for existing switch rule
  ice: receive LLDP on trusted VFs

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  71 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  56 +++-
 drivers/net/ethernet/intel/ice/ice_repr.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 243 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  17 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  26 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  48 +++-
 18 files changed, 449 insertions(+), 73 deletions(-)

-- 
2.43.0


