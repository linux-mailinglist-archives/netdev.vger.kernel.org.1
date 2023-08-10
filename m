Return-Path: <netdev+bounces-26516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3088777FDA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE181281CD1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3221D28;
	Thu, 10 Aug 2023 18:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208020FBF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:01:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B28D2702
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691690484; x=1723226484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sMSdxWWg1paUCw9DbOHpGMt97aDvrLTOkYtRjuTslPo=;
  b=JVttpRIHPYqGqe0oVgEaZcfzQavDApVEMFjq84E9dPzM+4+5+Dy7Uv6P
   QpPrFTwDIACR5KaZCf+/yVgs4GCtaFMN83I7SF4ghgQAqaIV3dr9UstMm
   XYa4q+/KUlVJk89T5WkXLqHU+OcUxz2ywa0/YZlyMExd616B1cp8oQel9
   JdSgMu66XspjkB0U/alxWh25S7KdRFXEwhYrf5zT85aei9BD7PPch0iWv
   YOZCcTEW/FUdWWbvGF6xANGSSGSWamHffFomMzFeQe/nWdCeVgkgiWZDX
   HJGpfVrfNzjncvpEu5+6OLDUhLmoHKDZn2TyeinMckbwgd0D4eh3oFFbR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361618464"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361618464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 11:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709253382"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="709253382"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 11:01:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/2][pull request] Intel Wired LAN Driver Updates 2023-08-10 (igb, e1000e)
Date: Thu, 10 Aug 2023 10:54:08 -0700
Message-Id: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
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

This series contains updates to igb and e1000e drivers.

Alessio Igor Bogani cleans up PTP related workqueues when it fails to
initialize on igb.

Kai-Heng Feng utilizes PME poll to workaround ACPI wake issues.

The following are changes since commit 29afcd69672a4e3d8604d17206d42004540d6d5c:
  Merge branch 'improve-the-taprio-qdisc-s-relationship-with-its-children'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Alessio Igor Bogani (1):
  igb: Stop PTP related workqueues if aren't necessary

Kai-Heng Feng (1):
  e1000e: Use PME poll to circumvent unreliable ACPI wake

 drivers/net/ethernet/intel/e1000e/netdev.c | 4 +++-
 drivers/net/ethernet/intel/igb/igb_ptp.c   | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.38.1


