Return-Path: <netdev+bounces-38543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEF7BB5E0
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2266282425
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A021BDF7;
	Fri,  6 Oct 2023 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JogsUdFV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C51642F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:05:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F345783
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696590330; x=1728126330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ND8R416ORbdhl7YpEgoz187sjPvI4B1VXPgdbfANzXo=;
  b=JogsUdFVMmVI5sI9OAF0iAgJ3Rk+Tkx9G2+42xEZ66qr1R/9nlfXysnc
   NjgaTQYU6LTlWm7s7819KJTOZ51t4dgtGeH/1DVMMZ23fipktyOvsT2wN
   fYtaPVssrAlce5W7A8TRNnekC12WQ9HYVrQ6yI5z58O66sO+U19+vegAF
   UIy1pHlZkuVSMnC4uhLnt2xttZ63YiFJDeL86/MGL3MIdIC5IxcIwwr7/
   ugfdMWTupRnIll6vMdPskrNXC6aWzjlkgEsLpoxNHt1R2rpvrqWrynqWz
   HrLcCmG6UwXMj/8sNKvuvHsJoEhwo8GMp0cIxXW90c5mahnFmUVgHYGYb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450222383"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450222383"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083413843"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083413843"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2023 04:05:28 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 24E1636345;
	Fri,  6 Oct 2023 12:05:28 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/5] ice: Support 5 layer Tx scheduler topology
Date: Fri,  6 Oct 2023 07:02:07 -0400
Message-Id: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For performance reasons there is a need to have support for selectable
Tx scheduler topology. Currently firmware supports only the default
9-layer and 5-layer topology. This patch series enables switch from
default to 5-layer topology, if user decides to opt-in.

---
v2:
- updated documentation
- reorder of variables list (default-init first)
- comments changed to be more descriptive
- added elseif's instead of few if's
- returned error when ice_request_fw fails
- ice_cfg_tx_topo() changed to take const u8 as parameter (get rid of copy
  buffer)
- renamed all "balance" occurences to the new one
- prevent fail of ice_aq_read_nvm() function
- unified variables names (int err instead of int status in few
  functions)
- some smaller fixes, typo fixes

v1: https://lore.kernel.org/netdev/20230523174008.3585300-1-anthony.l.nguyen@intel.com/
---

Lukasz Czapnik (1):
  ice: Add tx_scheduling_layers devlink param

Michal Wilczynski (2):
  ice: Enable switching default Tx scheduler topology
  ice: Document tx_scheduling_layers parameter

Raj Victor (2):
  ice: Support 5 layer topology
  ice: Adjust the VSI/Aggregator layers

 Documentation/networking/devlink/ice.rst      |  50 +++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 199 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   7 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 174 ++++++++++++++-
 .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
 .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  97 +++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_sched.c    |  37 ++--
 drivers/net/ethernet/intel/ice/ice_sched.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 14 files changed, 575 insertions(+), 45 deletions(-)

-- 
2.38.1


