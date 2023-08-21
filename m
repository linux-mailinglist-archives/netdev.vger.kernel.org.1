Return-Path: <netdev+bounces-29372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC893782F53
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4941C2042B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119A8C0C;
	Mon, 21 Aug 2023 17:23:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B32F2B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:23:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42971F7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692638621; x=1724174621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t2cfsoLB2hbU4yPKTLPDHWY1Ks48M6c3Ajvp3jlxqPw=;
  b=ebhhGU4SFszE9Wig1uAPuDQ/Onklerjhj5vgJOFAoV/hTj5BKewdkPxz
   3dhhJGUDJ1N5Z/w5J1iZHLY8S3y4mh4buCG9swr8SKMMP2FkSdOuT/ovU
   IB/pZ25UxsOcsbSKRDIEIzTwMmlIBl5TblecsHNzUWrIsb4dVZvveAdNf
   sWnzyupVBv66r9Vhr5CDT1dzV7jTHSbESfS3h4Pkxd7k9fjOQ8wqZtmho
   DahikQhjV0DSG2/joU/sRMOkysTj0vCz2I+LyA+ctvlbFJxEf72Xz1Qv+
   TeKxUztC68pVt3izDoH5vYE8u6dkw65qBpM8bBBHLrON5n+XNrhGgr4zN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404658869"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="404658869"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 10:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="909782079"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="909782079"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 21 Aug 2023 10:23:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2023-08-21 (ice)
Date: Mon, 21 Aug 2023 10:16:30 -0700
Message-Id: <20230821171633.2203505-1-anthony.l.nguyen@intel.com>
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

This series contains updates to ice driver only.

Jesse fixes an issue on calculating buffer size.

Petr Oros reverts a commit that does not fully resolve VF reset issues
and implements one that provides a fuller fix.

The following are changes since commit d1cdbf66e18cd39dd749937221240ab97c06d9e6:
  MAINTAINERS: add entry for macsec
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jesse Brandeburg (1):
  ice: fix receive buffer size miscalculation

Petr Oros (2):
  Revert "ice: Fix ice VF reset during iavf initialization"
  ice: Fix NULL pointer deref during VF reset

 drivers/net/ethernet/intel/ice/ice_base.c     |  3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 34 +++++--------------
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
 5 files changed, 14 insertions(+), 33 deletions(-)

-- 
2.38.1


