Return-Path: <netdev+bounces-34813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228A7A5506
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CC1C20B6A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50228DC4;
	Mon, 18 Sep 2023 21:28:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8394450E8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A9A8E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072524; x=1726608524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+seCOmz/pMC74vvPj1O8t62OGRflZeTcMFmL3h1IpzQ=;
  b=fzFe/66Wik/tD7RuD9f5O1xy3Cb4oyNzAn6IKnmMmG9ZDEC9gi0cK+lF
   BXXo6ROLNpU/7FC0Uh3rf60iuBsm4ZyGcsAU9wZ9kilUqhzDzBpwvKZBR
   vB9EYYc+isy+yPyg/YcqSCjHLPHxa3c+PcNViXH2L925vN9OT1Y9gKHG4
   2xxVpUNzoFp1gpu1EQVbmOVxLPchn6moGgLNzHuZdNZUOEBx59exwko3E
   x/NRhvWaQ/We9SY11WDqLhs16sqvaA+Fs4I7NbJoTUU/eHgFDwwhGSAK6
   Xwo5ML9MqVgXxdE8Z8nRWk1JD8/03/KrL2X2UkzmaO1Q3uaGeJoY6dp48
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187224"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187224"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186194"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186194"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next v2 00/11][pull request] Intel Wired LAN Driver Updates 2023-09-18 (ice)
Date: Mon, 18 Sep 2023 14:28:03 -0700
Message-Id: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Sergey prepends ICE_ to PTP timer commands to clearly convey namespace
of commands.

Karol adds retrying to acquire hardware semaphore for cross-timestamping
and avoids writing to timestamp registers on E822 devices. He also
renames some defines to be more clear and align with the data sheet.
Additionally, a range check is moved in order to reduce duplicated code.

Jake adds cross-timestamping support for E823 devices as well as adds
checks against netlist to aid in determining support for GNSS. He also
corrects improper pin assignment for certain E810-T devices and
refactors/cleanups PTP related code such as adding PHY model to ease checks
for different needed implementations, removing unneeded EXTTS flag, and
adding macro to check for source timer owner.
---
v2:
- Rebased. Previous patches 11 & 12 dropped as changes were accepted in
another series:
https://lore.kernel.org/netdev/20230913204943.1051233-8-vadim.fedorenko@linux.dev/
- Add additional usage of ice_pf_src_tmr_owned() (Patch 10)

v1: https://lore.kernel.org/netdev/20230911180314.4082659-1-anthony.l.nguyen@intel.com/

The following are changes since commit a5ea26536e89d04485aa9e1c8f60ba11dfc5469e:
  Merge branch 'stmmac-devvm_stmmac_probe_config_dt-conversion'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (6):
  ice: Support cross-timestamping for E823 devices
  ice: introduce hw->phy_model for handling PTP PHY differences
  ice: remove ICE_F_PTP_EXTTS feature flag
  ice: fix pin assignment for E810-T without SMA control
  ice: introduce ice_pf_src_tmr_owned
  ice: check netlist before enabling ICE_F_GNSS

Karol Kolacinski (4):
  ice: retry acquiring hardware semaphore during cross-timestamp request
  ice: PTP: Clean up timestamp registers correctly
  ice: PTP: Rename macros used for PHY/QUAD port definitions
  ice: PTP: move quad value check inside ice_fill_phy_msg_e822

Sergey Temerkhanov (1):
  ice: prefix clock timer command enumeration values with ICE_PTP

 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  15 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_gnss.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 101 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 294 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  22 +-
 11 files changed, 308 insertions(+), 151 deletions(-)

-- 
2.38.1


