Return-Path: <netdev+bounces-186335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07586A9E7E3
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ECE189AB3C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C6B1BD50C;
	Mon, 28 Apr 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Prd+p0o1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358B1B4257;
	Mon, 28 Apr 2025 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820205; cv=none; b=HVYklqh5qlmm/xTZzD4zrR6+2AUV8hvT6Y4l3LRw6fDyNhiiNctcRrfyMcXO/+QBYVWAkehhc7mMKdc9lWU4CpoODIZmm+zoty01auP4bNCwu2RTQZnNbulNqZJK7CksLEyr+SPSwy8+ll7qcF5AtglV7lAntL2vEDt2GR/+nZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820205; c=relaxed/simple;
	bh=MH7qkkrs4aXnrA4cGqJHHnCV2YqNebyCduBRyfcJJDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OqAVkLJEiZyGbI/IxwXaPmJU9QIKczZtgHUlklzkX+rq44Sx2amvCZeFuHiF3A+XE4cu6UiUkK+D8Idq4PNEsI/tu92LVceXoLLsCbhjazUegxtLuPJFlStf6ZJxTT7jXZNMD4D6ZYk/9o/plXxTMbKbGvnPxeqQShWTFO/iHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Prd+p0o1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820205; x=1777356205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MH7qkkrs4aXnrA4cGqJHHnCV2YqNebyCduBRyfcJJDw=;
  b=Prd+p0o1/SOkTR6pGWHneHoIW6XKnXFel1pZwA+SrMEiAxmyq2LcKVQ+
   uQ97crffpTT0Fj0N+/BXSTv2kv+/EXmOtQ36TLdvCt77v+2g2EdtTiU8L
   JiRr5J1P+prDzCtfnbvfqJlKnUzQU+XRebmjBoM+s5OOu3x4JNP5s618B
   8Fl8BDhhBi6NsRhwgCpPvCS69zq08mNWBgt/yia6bys93RtlTKhDJqL2m
   M7EGmADZUb0lDo6rR1xSzceW20E8X+OBLZfIVZ4jBriPWwleRvPNHJMyF
   YtTqXhsBd+bZOwF4TTBFuyqho/v66gq1GrExWpLf0zStHG4WPcxnYaEm+
   Q==;
X-CSE-ConnectionGUID: 0EVUq0EzSK+jboH42YM7Bw==
X-CSE-MsgGUID: Vp5J1Y7wRXqZmXKEELE2Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51064577"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51064577"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:03:24 -0700
X-CSE-ConnectionGUID: QwnkgDg3TZmBOdPMj32E0g==
X-CSE-MsgGUID: FwBJLuQDSP6m5cfGHcgwRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133340722"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2025 23:03:20 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v1 0/8] igc: harmonize queue priority and add preemptible queue support
Date: Mon, 28 Apr 2025 02:02:17 -0400
Message-Id: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MAC Merge support for frame preemption was previously added for igc:
https://patchwork.kernel.org/project/netdevbpf/patch/20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com/

This series builds on that work and adds support for:
- Harmonizing taprio and mqprio queue priority behavior, based on past
  discussions and suggestions:
  https://lore.kernel.org/all/20250214102206.25dqgut5tbak2rkz@skbuf/
- Enabling preemptible queue support for both taprio and mqprio, with
  priority harmonization as a prerequisite.

It is based on the iwl tree as the baseline for development.

Patch organization:
- Patches 1–3: Preparation work for patches 6 and 7
- Patches 4–5: Introduce queue priority harmonization
- Patches 6–8: Add preemptible queue support

The series depends on the following patches, which are currently in the
iwl tree and pending integration into netdev/net-next:
- igc: Change Tx mode for MQPRIO offloading
- igc: Limit netdev_tc calls to MQPRIO

Chwee-Lin Choong (1):
  igc: SW pad preemptible frames for correct mCRC calculation

Faizal Rahim (7):
  igc: move IGC_TXDCTL_QUEUE_ENABLE and IGC_TXDCTL_SWFLUSH
  igc: add TXDCTL prefix to related macros
  igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
  igc: assign highest TX queue number as highest priority in mqprio
  igc: add private flag to reverse TX queue priority in TSN mode
  igc: add preemptible queue support in taprio
  igc: add preemptible queue support in mqprio

 drivers/net/ethernet/intel/igc/igc.h         |  24 +++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   4 -
 drivers/net/ethernet/intel/igc/igc_defines.h |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  12 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  50 ++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 116 ++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   5 +
 7 files changed, 179 insertions(+), 33 deletions(-)

--
2.34.1


