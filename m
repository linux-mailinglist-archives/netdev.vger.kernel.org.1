Return-Path: <netdev+bounces-35285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C97A8A70
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC247281B79
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684B1A59A;
	Wed, 20 Sep 2023 17:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A71A589
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:20:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293EAF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695230401; x=1726766401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dIMXniZpgLdpRRcdCCGYZ9veGviTLORLYa9ZzUmIDg4=;
  b=AtHw3Hez03Dfs2eagzWd+IEB4KOs/MyKEtBDRYVuBdUuXZmRdTmUhApq
   dBQRPNgnbpdT5g2KL6aJTHfNpKQFAuZa2LFUOt6WXuO7ckXyNGfiLQvbu
   DS1popQe0V4c+6AjOUVDYTWmzn8LRs9EdbeoWYF5bKLXZZtayolbalL93
   5raqwxhfVRWGN+Ya2dgXMG7Vphcy1ik7jv2UiUoqNtoSpaVG1QNYpPMZC
   /i/hVKIay45hK/4g4CT3OXrNv24jG9o9tcHEU63Xe4JiuRMYV17SsiiTO
   nVqK2lpwa0fmafqAlyMGi8OtErYXHPXVyyOrg9BEmArgAd/ZjaCZfuVEx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411234456"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411234456"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077543712"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077543712"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 10:19:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.michalik@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 0/4][pull request] ice: add PTP auxiliary bus support
Date: Wed, 20 Sep 2023 10:19:25 -0700
Message-Id: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
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

Michal Michalik says:

Auxiliary bus allows exchanging information between PFs, which allows
both fixing problems and simplifying new features implementation.
The auxiliary bus is enabled for all devices supported by ice driver.

The following are changes since commit b3af9c0e89ca721dfed95401c88c8c6e8067b558:
  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Michalik (4):
  ice: Auxbus devices & driver for E822 TS
  ice: Use PTP auxbus for all PHYs restart in E822
  ice: PTP: add clock domain number to auxiliary interface
  ice: Remove the FW shared parameters

 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  10 -
 drivers/net/ethernet/intel/ice/ice_common.c   |  75 ---
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 576 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  41 +-
 9 files changed, 483 insertions(+), 251 deletions(-)

-- 
2.38.1


