Return-Path: <netdev+bounces-15647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8E748EDE
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA501C20C19
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57754156F8;
	Wed,  5 Jul 2023 20:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C017156F9
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:24:46 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062D1988
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588685; x=1720124685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yr8sOTnRGYrh7jlFpcDR9hmCbTEyWBYbhEwyebuUTDg=;
  b=UyypK/ohh9w28LpYPWzoXixNsbpf75li+xH+q+hDfmp0/FyoZdap0lYZ
   3QRFGJaU2hjNib9AcoTrekPBPJcuXdkE+f+qErlQy+ool4mTSsV9yGkcb
   xekCWFcVVzXPlrA75gjSvbILSzRpyeoquTd+khQ/kpt08WB9zWg8beQ+W
   TIfk2Y57tn0TaI1FmIhCy2py2lVvozKv7Rlv2QeNcKiarUWX/V07LJ2vo
   fA6mZo32zeQns7vA92qSFiVNUfz/sk28MQVFKdESzZHBh//QFA9Fcmfuq
   slpsNimlZW5mzHm5c5Jf+E+AFYzQncclIdjFDr4qHtKObfMVOJ6+FW0Zm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362303202"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="362303202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809380419"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="809380419"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 13:24:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	sasha.neftin@intel.com
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2023-07-05 (igc)
Date: Wed,  5 Jul 2023 13:18:59 -0700
Message-Id: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
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

This series contains updates to igc driver only.

Husaini adds check to increment Qbv change error counter only on taprio
Qbvs. He also removes delay during Tx ring configuration and
resolves Tx hang that could occur when transmitting on a gate to be
closed.

Prasad Koya reports ethtool link mode as TP (twisted pair).

Tee Min corrects value for max SDU.

Aravindhan ensures that registers for PPS are always programmed to occur
in future.

The following are changes since commit c451410ca7e3d8eeb31d141fc20c200e21754ba4:
  Merge branch 'mptcp-fixes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Aravindhan Gunasekaran (1):
  igc: Handle PPS start time programming for past time values

Muhammad Husaini Zulkifli (3):
  igc: Add condition for qbv_config_change_errors counter
  igc: Remove delay during TX ring configuration
  igc: Fix TX Hang issue when QBV Gate is closed

Prasad Koya (1):
  igc: set TP bit in 'supported' and 'advertising' fields of
    ethtool_link_ksettings

Tan Tee Min (1):
  igc: Include the length/type field and VLAN tag in queueMaxSDU

 drivers/net/ethernet/intel/igc/igc.h         |  7 ++
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 74 ++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 25 ++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 42 +++++++----
 5 files changed, 118 insertions(+), 32 deletions(-)

-- 
2.38.1


