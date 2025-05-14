Return-Path: <netdev+bounces-190296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE2EAB6181
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15FA4A2EBC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534318B47E;
	Wed, 14 May 2025 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghEE/WRV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143531DFDE;
	Wed, 14 May 2025 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197067; cv=none; b=ORiPynfY5Ap+N0nNqeoGO7n80NLNGrOUhHZB1eleGEBsfIAMxWpsxe3116aLDU4u/6X8/aj4hmX+5WkAUx97n1jc12SXJFas9l8gOSyWBnaK9jor5jCCq4WoIM5LlmpCJBhLXsEwdHT4XV6KA7DQKYtqQTmS3dxWe0Qqnta8imI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197067; c=relaxed/simple;
	bh=jescl6f+uybA68SsSMxRC4QbDzkbPdEF/STWwsg9JYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VGXGhKlau0fvpjES9Hbj05WumcNAMfc3u/2UtWpSKDGTn/lG7+9IYPofb/GRjyEvQf+far0BAoCgY4c6PHosjW/vxVMZe92ndP8uvjV0lvYloitlfr+jxUvpysr4nDv04Dum9R1fCWePHmouVQ+Dv+yWPoApcEB6P3F3kjg+z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghEE/WRV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197065; x=1778733065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jescl6f+uybA68SsSMxRC4QbDzkbPdEF/STWwsg9JYM=;
  b=ghEE/WRVjRWaxelmPI70HuUfydBExBilLjVIT938Cszwb0SuVkZNZGGk
   pGOXPNfYbwhR48/s1PwYcCA10UrNA+nbgrjnTU/rWPWTbmmaT7ersHf0K
   tHCU1R6T22m2oBlUj4zJdK+98cBYhH7mWUxZ3ae+cflEuHS8vWdIfYjr4
   yUtSQwa4J4ndGEw87zunNJcAaCf4hz7v94KjH5ZlDVCq2/bHb854oQU/j
   lD1T4kcTf3QJH57eLVe8lcnLNRW3Y7MTiVyNh8oODrGNZlLiSCArSR6BD
   obLaM4DnLGgjQtIMzQgaqMcnjBXfKltDPlG7QzoaqdHOgy1RmXYwif12+
   w==;
X-CSE-ConnectionGUID: 0xT+izzpQjOz6r697trrCQ==
X-CSE-MsgGUID: DvPMye6tTgWJHIDUc7r8Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36699061"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="36699061"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:31:04 -0700
X-CSE-ConnectionGUID: DHBPF/FdQXG07/G2fbxIjw==
X-CSE-MsgGUID: aHeTynuCSKKzAsZEw9nuzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142861732"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa004.jf.intel.com with ESMTP; 13 May 2025 21:31:01 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v2 0/8] igc: harmonize queue priority and add preemptible queue support
Date: Wed, 14 May 2025 00:29:37 -0400
Message-Id: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

MAC Merge support for frame preemption was previously added for igc:
https://patchwork.kernel.org/project/netdevbpf/patch/20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com/

This series builds on that work and adds support for:
- Harmonizing taprio and mqprio queue priority behavior, based on past
  discussions and suggestions:
  https://lore.kernel.org/all/20250214102206.25dqgut5tbak2rkz@skbuf/
- Enabling preemptible queue support for both taprio and mqprio, with
  priority harmonization as a prerequisite.

Patch organization:
- Patches 1–3: Preparation work for patches 6 and 7
- Patches 4–5: Queue priority harmonization
- Patches 6–8: Add preemptible queue support

v2 changes:
- v1: https://patchwork.kernel.org/project/netdevbpf/cover/20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com/
- Move RXDCTL macros for consistency with TXDCTL (Ruinskiy, Dima)
- Rename RX descriptor control macros with RXDCTL prefix (Ruinskiy, Dima)
- Add FPE acronym explanation in commit description (Loktionov, Aleksandr)
- Add Reviewed-by tag from Aleksandr for patch 6

Chwee-Lin Choong (1):
  igc: SW pad preemptible frames for correct mCRC calculation

Faizal Rahim (7):
  igc: move TXDCTL and RXDCTL related macros
  igc: add DCTL prefix to related macros
  igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
  igc: assign highest TX queue number as highest priority in mqprio
  igc: add private flag to reverse TX queue priority in TSN mode
  igc: add preemptible queue support in taprio
  igc: add preemptible queue support in mqprio

 drivers/net/ethernet/intel/igc/igc.h         |  33 +++++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   8 --
 drivers/net/ethernet/intel/igc/igc_defines.h |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  12 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  56 ++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 116 ++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   5 +
 7 files changed, 188 insertions(+), 43 deletions(-)

--
2.34.1


