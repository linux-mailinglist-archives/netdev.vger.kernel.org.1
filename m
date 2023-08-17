Return-Path: <netdev+bounces-28610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6A77FFE3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD21C214F4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B481B7E1;
	Thu, 17 Aug 2023 21:29:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EA37D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76CE4F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307775; x=1723843775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7RP3IE2zQfN8TtPaoYRUD13eDtN+3wyB/8U3kuDUa+0=;
  b=TCLmLdW+UDnmjS6lO2mPDF+fEqwprjPHaIIg6XPAMufBs3VPFrAFqh4A
   N6l5I1gvePrAY6pYkjOZk5qSTqGEELylqXvFaRe4QHv8+/74C1MfTfBX4
   takwZ2qo+OBQiywTyRDv+BqlIARlGAjkZRYbydq3cQCNfM8HzOdot88hy
   HXXW9fPw64RFkul7LgFAsw/xJmOR2FhzY28J4gWWpNqIp00OinzndMoIQ
   MUUE7oy4Ya1P3j11CueKeyjlzaINC8BoeFx7Aco+Bjz2oSRtGeVOg17sx
   qVeZzXpDjK3pQrNXdZQR6hS9ylX5NiuG4cVLZeRW5ZvGRrUD/DlJUe8eR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095033"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813689"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813689"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 00/15][pull request] Intel Wired LAN Driver Updates 2023-08-17 (ice)
Date: Thu, 17 Aug 2023 14:22:24 -0700
Message-Id: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Jan removes unused functions and refactors code to make, possible,
functions static.

Jake rearranges some functions to be logically grouped.

Marcin removes an unnecessary call to disable VLAN stripping.

Yang Yingliang utilizes list_for_each_entry() helper for a couple list
traversals.

Przemek removes some parameters from ice_aq_alloc_free_res() which were
always the same and reworks ice_aq_wait_for_event() to reduce chance of
race.
---
v2:
- Add patch to use assign_bit() in ice_vf_set_host_trust_cfg()

v1: https://lore.kernel.org/netdev/20230816204736.1325132-1-anthony.l.nguyen@intel.com/

The following are changes since commit f54a2a132a9d76c0e31fd1d5f569e84682563e54:
  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (1):
  ice: move E810T functions to before device agnostic ones

Jan Sokolowski (7):
  ice: remove unused methods
  ice: refactor ice_ddp to make functions static
  ice: refactor ice_lib to make functions static
  ice: refactor ice_vf_lib to make functions static
  ice: refactor ice_sched to make functions static
  ice: refactor ice_ptp_hw to make functions static
  ice: refactor ice_vsi_is_vlan_pruning_ena

Marcin Szycik (1):
  ice: Remove redundant VSI configuration in eswitch setup

Przemek Kitszel (4):
  ice: drop two params from ice_aq_alloc_free_res()
  ice: ice_aq_check_events: fix off-by-one check when filling buffer
  ice: embed &ice_rq_event_info event into struct ice_aq_task
  ice: split ice_aq_wait_for_event() func into two

Tony Nguyen (1):
  ice: Utilize assign_bit() helper

Yang Yingliang (1):
  ice: use list_for_each_entry() helper

 drivers/net/ethernet/intel/ice/ice.h          |  21 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  24 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   7 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 120 ++---
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  10 -
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   4 -
 .../net/ethernet/intel/ice/ice_fw_update.c    |  45 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  17 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  82 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  99 ++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 383 +++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   4 -
 drivers/net/ethernet/intel/ice/ice_sched.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_sched.h    |   4 -
 drivers/net/ethernet/intel/ice/ice_switch.c   |  64 +--
 drivers/net/ethernet/intel/ice/ice_switch.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 465 +++++++++---------
 .../ethernet/intel/ice/ice_vf_lib_private.h   |   2 -
 19 files changed, 624 insertions(+), 735 deletions(-)

-- 
2.38.1


