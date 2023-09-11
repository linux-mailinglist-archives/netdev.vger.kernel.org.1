Return-Path: <netdev+bounces-32893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C679AAB8
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79301281329
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D56156EA;
	Mon, 11 Sep 2023 18:11:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2523156E4
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C385F103
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455861; x=1725991861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E8SViSF5zkCh5m4hEqrpOE+M9sJQnwggns897f8RsQk=;
  b=J+Tl7LK7mf7Ml0SOQoZ9bwJHTsLTycdz2f/T2LWkxC+umE4ODyBiL4GP
   R0IHsaxNNYGFax8KkNbP/P/tC1ZchNi32vyqW4+iGfSkIwQ7tjz5/yz5L
   ql9hjFj4hVXNIE4ve6XZjvehwRDh5YpA0TWjknczSguBMj5t1mpMdrIZ/
   PTW328mVCSDZyMs6ZkAygFf4CBVScdueVxVHXuWD6la0or4H9EBy75xKO
   bqZDheDDxPFAJ3QvAYV8Z3WiudHfbiMA5yLh3Aya0Liu7EByrg/G6SyW7
   2p/S1CQDDOnxB0Ck0ZAKXcfKeFiWHhF1fsh+3lj9tN2htkNhYVt9olUey
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075595"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075595"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129919"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129919"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver Updates 2023-09-11 (ice)
Date: Mon, 11 Sep 2023 11:03:01 -0700
Message-Id: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
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
checks against netlist to aid in determining support for SMA and GNSS.
He also corrects improper pin assignment for certain E810-T devices and
refactors/cleanups PTP related code such as adding PHY model to ease checks
for different needed implementations, removing unneeded EXTTS flag, and
adding macro to check for source timer owner.

The following are changes since commit 73be7fb14e83d24383f840a22f24d3ed222ca319:
  Merge tag 'net-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (8):
  ice: Support cross-timestamping for E823 devices
  ice: introduce hw->phy_model for handling PTP PHY differences
  ice: remove ICE_F_PTP_EXTTS feature flag
  ice: fix pin assignment for E810-T without SMA control
  ice: introduce ice_pf_src_tmr_owned
  ice: don't enable PTP related capabilities on non-owner PFs
  ice: check the netlist before enabling ICE_F_SMA_CTRL
  ice: check netlist before enabling ICE_F_GNSS

Karol Kolacinski (4):
  ice: retry acquiring hardware semaphore during cross-timestamp request
  ice: PTP: Clean up timestamp registers correctly
  ice: PTP: Rename macros used for PHY/QUAD port definitions
  ice: PTP: move quad value check inside ice_fill_phy_msg_e822

Sergey Temerkhanov (1):
  ice: prefix clock timer command enumeration values with ICE_PTP

 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  77 +++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_gnss.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  11 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 101 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 294 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  22 +-
 11 files changed, 380 insertions(+), 156 deletions(-)

-- 
2.38.1


