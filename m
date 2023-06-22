Return-Path: <netdev+bounces-13157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63C73A85E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43CE1C211AF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFED200C9;
	Thu, 22 Jun 2023 18:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7C1E536
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:41:07 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7BF1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459266; x=1718995266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0jmZr63VzCqkcpoRv0OvDsCGuHAaxlHDxHYqdppSNGI=;
  b=aejDMCmTF54842sNEwlOc2NjZMdB2U+gt6GnwBBX81l8ctS4090Dner2
   Zo6LXk0T3hAV5A6VZ3PTOC7SiNuYc773jdq9UeBUOjpiE69mqyNUhCa5l
   W6I5dGz2JKn8bQW7xT/ITikGwZImahL6E3F22C6CP4NEpYzHZLLBYz1iE
   l9Zbolq0t+wFekfZTF+R2hxY5kxatuF1d1mz21H7Mi8s9NrzB92Q7jeHZ
   DpKEL/NAomaXfTXYmesE9kPh3GWRnFtkiBz6mYQ2Vj/xeNR9ZgTrW/qte
   GbIUhWwiDUsx4eq4zCTbO1MOn4qGKX2yqnx1VSRkkTeBCx3BzQYuBMliP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340917765"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340917765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961686974"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961686974"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 11:41:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates 2023-06-22 (ice)
Date: Thu, 22 Jun 2023 11:35:55 -0700
Message-Id: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Jake adds a slight wait on control queue send to reduce wait time for
responses that occur within normal times.

Maciej allows for hot-swapping XDP programs.

Przemek removes unnecessary checks when enabling SR-IOV and freeing
allocated memory.

Christophe Jaillet converts a managed memory allocation to a regular one.

The following are changes since commit 98e95872f2b818c74872d073eaa4c937579d41fc:
  Merge branch 'mptcp-expose-more-info-and-small-improvements'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Christophe JAILLET (1):
  ice: Remove managed memory usage in ice_get_fw_log_cfg()

Jacob Keller (1):
  ice: reduce initial wait for control queue messages

Maciej Fijalkowski (2):
  ice: allow hot-swapping XDP programs
  ice: use ice_down_up() where applicable

Przemek Kitszel (2):
  ice: clean up freeing SR-IOV VFs
  ice: remove null checks before devm_kfree() calls

 drivers/net/ethernet/intel/ice/ice_common.c   | 10 ++---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 12 ++++--
 drivers/net/ethernet/intel/ice/ice_controlq.h |  1 -
 drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
 drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
 drivers/net/ethernet/intel/ice/ice_main.c     | 37 ++++++----------
 drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  5 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
 9 files changed, 52 insertions(+), 108 deletions(-)

-- 
2.38.1


