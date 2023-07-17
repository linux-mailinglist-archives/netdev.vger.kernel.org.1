Return-Path: <netdev+bounces-18375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFAC756B15
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D84281250
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75619BA5D;
	Mon, 17 Jul 2023 17:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2C1878
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:18 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF2115
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616695; x=1721152695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pD+y6uCRG7ksjXGZoKtwzdepAiouX9KioBL6qfXJ6ss=;
  b=COT96EIKgs/0R8qeH6VEoroHl0HwT3AWrZZl091ayu8oMy3riVse6xxw
   Vo6Ic23ZCzOdN1IjJ6NI19/jXijE/ifKyM8gUmUj1Rj/1AZ1kmgcqL7rA
   ORIX2zXYDfQAqfi1/ihlWBi7M3qWFKlAs4k/aKv19aNdaDPGnxtcWewOu
   NPHHjnI3XxA1BKxMaDKOuZ23zaikV2U2k6+MkEZNT2ZN5AOUC4Pr3K9Hf
   gf838vrGNYGdQWb8MiDp1Ha6RDRSctNL+Irnm9k+IVH3SCHPBDZiqLwev
   0mCgcoCJy9JIVvoELLi+oTj70kwub4e/hUzpt/DPEcTvWljPtGyTDjAjU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172645"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172645"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294552"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294552"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 10:57:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2023-07-17 (iavf)
Date: Mon, 17 Jul 2023 10:51:57 -0700
Message-Id: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to iavf driver only.

Ding Hui fixes use-after-free issue by calling netif_napi_del() for all
allocated q_vectors. He also resolves out-of-bounds issue by not
updating to new values when timeout is encountered.

Marcin and Ahmed change the way resets are handled so that the callback
operating under the RTNL lock will wait for the reset to finish, the
rtnl_lock sensitive functions in reset flow will schedule the netdev update
for later in order to remove circular dependency with the critical lock.

The following are changes since commit 162d626f3013215b82b6514ca14f20932c7ccce5:
  r8169: fix ASPM-related problem for chip version 42 and 43
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Ahmed Zaki (3):
  iavf: use internal state to free traffic IRQs
  iavf: fix a deadlock caused by rtnl and driver's lock circular
    dependencies
  iavf: fix reset task race with iavf_remove()

Ding Hui (2):
  iavf: Fix use-after-free in free_netdev
  iavf: Fix out-of-bounds when setting channels on remove

Marcin Szycik (3):
  iavf: Wait for reset in callbacks which trigger it
  Revert "iavf: Detach device during reset task"
  Revert "iavf: Do not restart Tx queues after reset task failure"

 drivers/net/ethernet/intel/iavf/iavf.h        |   6 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  39 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 237 +++++++++++-------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   5 +-
 4 files changed, 176 insertions(+), 111 deletions(-)

-- 
2.38.1


