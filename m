Return-Path: <netdev+bounces-46305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD527E3261
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6BE280DC1
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9E17C3;
	Tue,  7 Nov 2023 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GODvtlxJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3E15A4
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:48:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D726129
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699318128; x=1730854128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2w/kg5l4NxOlGOaqGXtvBqq+HjHZHStTirHq6nobv4o=;
  b=GODvtlxJG4Ptc0loer6KPNM08SrhUiHY5x2OcG+QQPnqhdGIVED/i2NG
   I1h88f6im+Z3dYALTh5SsmMBVHq9+EHDwGD0bFAzLMf/EoCSgbeIeZfBW
   252v92S3vbG0XEDKUbUyc+BDKZrP5PaiT8rCZYGl7Xo45o42Tfqe8xjnm
   Zz13MDb1CTyi9Jglgb4fpFdStJNtGyA5gc4KE23OtWCBFG00CS/6MxFZj
   yZokN3sQyDrh6Koev4dQmCPuCedW4UBPrq+U5YLUX9qvjFDHG4u/8kh4E
   BW74BO9K0VQ/w4gdjMocGwR0JzhfPJMJUS7MreB818tR/dHmW2EQN/+d1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392270698"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="392270698"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762489652"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762489652"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2023 16:48:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2023-11-06 (ice)
Date: Mon,  6 Nov 2023 16:48:38 -0800
Message-ID: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Dave removes SR-IOV LAG attribute for only the interface being disabled
to allow for proper unwinding of all interfaces.

Michal Schmidt changes some LAG allocations from GFP_KERNEL to GFP_ATOMIC
due to non-allowed sleeping.

Aniruddha and Marcin fix redirection and drop rules for switchdev by
properly setting and marking egress/ingress type.

The following are changes since commit c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241:
  Merge branch 'smc-fixes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Aniruddha Paul (1):
  ice: Fix VF-VF filter rules in switchdev mode

Dave Ertman (1):
  ice: Fix SRIOV LAG disable on non-compliant aggregate

Marcin Szycik (1):
  ice: Fix VF-VF direction matching in drop rule in switchdev

Michal Schmidt (1):
  ice: lag: in RCU, use atomic allocation

 drivers/net/ethernet/intel/ice/ice_lag.c    |  18 ++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 114 +++++++++++++++-----
 2 files changed, 91 insertions(+), 41 deletions(-)

-- 
2.41.0


