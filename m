Return-Path: <netdev+bounces-28211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4177EB0D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E970F281C14
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B417AD9;
	Wed, 16 Aug 2023 20:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BF17E9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79039E69
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219271; x=1723755271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2WDRs1KH64mlN0PlL1uh8K0ZuBhk8P+U+tjvC8xJX4A=;
  b=HJzT2RlPsKm6k0XbIoj/EspfxHY7zC0i/sLGq4GWExAxtSdgjASibn8n
   PbENchj4dqjjDboI5fMordiESlWHsGmnHuOiQA9cBPvUYeIwAs6UfVY+5
   WuyomRCK7ZiKWjR+oeXUKAiF/Zwb/2o8tDhWw55swAWrew+A54XjKcxs+
   VEpPC14VvZx4FiXJdVB76A7jdF9vBvBduDmDRPxO6xzrT2OKZGqML1t3n
   aCCOGCInGAciVYCOJms83KQQZ/hBRthbhh/GMuU+Ou0eeNCWHffQYoUFb
   yfOSgbuiDuFaV1hlKtGKAoKilLHugB6YGzVc/nfKKZH0Vi3+8pekDZPAI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604749"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626371"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626371"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:30 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/14][pull request] Intel Wired LAN Driver Updates 2023-08-16 (ice)
Date: Wed, 16 Aug 2023 13:47:22 -0700
Message-Id: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

The following are changes since commit 950fe35831af0c1f9d87d4105843c3b7f1fbf09b:
  Merge branch 'ipv6-expired-routes'
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 383 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   4 -
 drivers/net/ethernet/intel/ice/ice_sched.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_sched.h    |   4 -
 drivers/net/ethernet/intel/ice/ice_switch.c   |  64 +--
 drivers/net/ethernet/intel/ice/ice_switch.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 468 +++++++++---------
 .../ethernet/intel/ice/ice_vf_lib_private.h   |   2 -
 19 files changed, 627 insertions(+), 735 deletions(-)

-- 
2.38.1


