Return-Path: <netdev+bounces-23355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA076BB4D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034CB1C20752
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418423580;
	Tue,  1 Aug 2023 17:34:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897020F83
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:34:12 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583010F0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911250; x=1722447250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VXXP3zbNAtTqMvAQzjGSPCNUYCZpi4cQitTVpdXHSlc=;
  b=XAG8S/HXqyb4eH/+v8CbjhJ+Bd8DawcJvqk1aS56ehvFbQWLojAYB7cq
   hKAEmmN8AkEl/rGbMTXbDPdMWu9eihi5PzRPNCzI1XWOIuNIHtQ0xwqvu
   xQJrkPc0z3Y/F49sCp3WWt+YcR9kOoVN3BG8YbC9Ewdz3IQ1s2nQB+Ush
   bXzbX8f3H3UJyUU+LJcGqXQ0BLLfk37McpwTT4nKujK8bWN0CkgaMeoEG
   ecpL5ofArLjGPZs+zQNJ424+s79V91MzCs+YgWGkJo7b2a67234rr1izz
   MedWQtYrCBWKcynrwQxbWpXU3OV/yzGSZyUfANrTHsnyUAgdPfzcp+Atf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369363561"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="369363561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794273651"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="794273651"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 10:34:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	muhammad.husaini.zulkifli@intel.com,
	sasha.neftin@intel.com,
	horms@kernel.org
Subject: [PATCH net v2 0/2][pull request] igc: Enhance the tx-usecs coalesce setting implementation
Date: Tue,  1 Aug 2023 10:27:40 -0700
Message-Id: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
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

Muhammad Husaini Zulkifli says:

The current tx-usecs coalesce setting implementation in the driver code is
improved by this patch series. The implementation of the current driver code
may have previously been a copy of the legacy code i210.

Patch 1:
Allow the user to see the tx-usecs colease setting's current value when using
the ethtool command. The previous value was 0.

Patch 2:
Give the user the ability to modify the tx-usecs colease setting's value.
Previously, it was restricted to rx-usecs.
---
v2:
- Refactor the code, as Simon suggested, to make it more readable.

v1: https://lore.kernel.org/netdev/20230728170954.2445592-1-anthony.l.nguyen@intel.com/

The following are changes since commit 13d2618b48f15966d1adfe1ff6a1985f5eef40ba:
  bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Muhammad Husaini Zulkifli (2):
  igc: Expose tx-usecs coalesce setting to user
  igc: Modify the tx-usecs coalesce setting

 drivers/net/ethernet/intel/igc/igc_ethtool.c | 62 +++++++++++++-------
 1 file changed, 41 insertions(+), 21 deletions(-)

-- 
2.38.1


