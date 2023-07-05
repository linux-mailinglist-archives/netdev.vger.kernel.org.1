Return-Path: <netdev+bounces-15644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75187748EBD
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3118B281120
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387C5156F1;
	Wed,  5 Jul 2023 20:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B205156EE
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:19:16 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8BE198B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588355; x=1720124355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GiLC6jl3PqfvKmVszzcd4P8BZSIaDp/GbPYLt7mSi84=;
  b=A6AO/CpCLCkZL0vdBJzo2mFYy419D2ANWIkBo7kDl8Qqa05Z+8HgVoo3
   W5yXj9eVmWiUixISNdJXgrbv6TXCSql7XdIID0AtXw7fmK0x9dzj1NVf/
   1cAXa+pvdp/h3Yd/b8o6w2gCLw1qKV4EaCkxzryBQv48nt4pQ4tewWhME
   EVKbl8X/UgZuSOHT8zHHGMd+/WoJJpVgsrNPY1ghEX8JDsAJPVQN7z3+j
   fr4RBe7Q/cT5MHa+cgmnLbO9u4fPEgJEaZYvNYEz7jaK2snzlwrMvcfAL
   gJVPfreGRbdcFlijA8I/DtwWcif58ZOT/EWtXwsCYU55N5bsykl5vLn+X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427117962"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="427117962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="965944740"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="965944740"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2023 13:19:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-07-05 (ice)
Date: Wed,  5 Jul 2023 13:13:44 -0700
Message-Id: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Sridhar fixes incorrect comparison of max Tx rate limit to occur against
each TC value rather than the aggregate. He also resolves an issue with
the wrong VSI being used when setting max Tx rate when TCs are enabled.

The following are changes since commit c451410ca7e3d8eeb31d141fc20c200e21754ba4:
  Merge branch 'mptcp-fixes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Sridhar Samudrala (2):
  ice: Fix max_rate check while configuring TX rate limits
  ice: Fix tx queue rate limit when TCs are configured

 drivers/net/ethernet/intel/ice/ice_main.c   | 23 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 22 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.38.1


