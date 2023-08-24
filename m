Return-Path: <netdev+bounces-30509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83356787998
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1661C20EFA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81955666;
	Thu, 24 Aug 2023 20:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B67F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 20:51:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875A81BD9
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692910289; x=1724446289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GzgNykSY7+i/POKfZuHbEG7JRg/8KBsa7HA7z4EXbrw=;
  b=Ye2xY/KepbZJhQ8BGzFtNSVEFezeDTXcTabXVB4j6m6mISV4jCBG7crJ
   Wd3b+I3AsPf9m9igElN5brYPTztdY6LFc+hciLV/IU7EJ3/lbLoT7j0X+
   0z2MUWlF2hUefy7M2Az/1034r3mcYZJtJrs1QO6sfkzHF5N3czIvP3MXT
   vDNILrlhzgMUmBKLSr3049qXLNM/XFVpYLKJnaKMrOOoe/2cm1golIAIc
   SivhPJU3zE6QecMrymG5HwT/mN1tB8UKg64gTeIekQrwU7+Q5JLDktimW
   841R8dN4/8bEEkNzxsW5fkWOmDvHbRm0JYl7gv2j6Q5pyXw/TeRpO/NGV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364746202"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364746202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 13:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827312260"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827312260"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 13:51:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	sasha.neftin@intel.com
Subject: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates 2023-08-24 (igc, e1000e)
Date: Thu, 24 Aug 2023 13:44:15 -0700
Message-Id: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to igc and e1000e drivers.

Vinicius adds support for utilizing multiple PTP registers on igc.

Sasha reduces interval time for PTM on igc and adds new device support
on e1000e.

The following are changes since commit 35b4b6d0c53a3872e846dbcda9074117efdc078a:
  docs: netdev: recommend against --in-reply-to
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Sasha Neftin (2):
  igc: Decrease PTM short interval from 10 us to 1 us
  e1000e: Add support for the next LOM generation

Vinicius Costa Gomes (1):
  igc: Add support for multiple in-flight TX timestamps

 drivers/net/ethernet/intel/e1000e/ethtool.c  |   2 +
 drivers/net/ethernet/intel/e1000e/hw.h       |   3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c  |   7 +
 drivers/net/ethernet/intel/e1000e/netdev.c   |   4 +
 drivers/net/ethernet/intel/e1000e/ptp.c      |   1 +
 drivers/net/ethernet/intel/igc/igc.h         |  18 +-
 drivers/net/ethernet/intel/igc/igc_base.h    |   3 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  41 ++++-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 174 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_regs.h    |  12 ++
 11 files changed, 210 insertions(+), 64 deletions(-)

-- 
2.38.1


