Return-Path: <netdev+bounces-22369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBB767312
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8992824A6
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7925156D2;
	Fri, 28 Jul 2023 17:16:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2247156CB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:16:14 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C435B8
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690564573; x=1722100573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vKfJpfLtvfMryDTVw2ZgBdcHVIB3+3j2rujABNIReB0=;
  b=OyKEVQiqXDy6hjKmzeXCjHay9EqGjN8KPrhyU4PpbWdRIsOcOZd6Yuq4
   DeXDm5m47ykRRbaNz6/Z0P6Vrb0UiNNDc4mr79YCFXc7FQ/29BEc+boTB
   CuzKKiF409rnNIe3ZFYjUvu0PQ5RMto+Ky9gTvhnlqEprkBiktl9lv2I/
   Ze6ZWKWsQHMzJi5Q24ekf3Y67XOs+8hA+shiqp7NxoBLhrclCUAcp+Hiy
   zwHaK6qwNBUbOe/F2pKttwy3duIRxOD/TMG8ckvOLZ3mTpbhzTzjXbr4X
   Iv4eYCbpreU4BtF3Yj+8TKftM+68l9vTYaqWUrbHKftKo+JIbJOYDxXIE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368656688"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="368656688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870921128"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2023 10:16:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	muhammad.husaini.zulkifli@intel.com,
	sasha.neftin@intel.com
Subject: [PATCH net 0/2][pull request] igc: Enhance the tx-usecs coalesce setting implementation
Date: Fri, 28 Jul 2023 10:09:52 -0700
Message-Id: <20230728170954.2445592-1-anthony.l.nguyen@intel.com>
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

The following are changes since commit 5416d7925e6ee72bf1d35cad1957c9a194554da4:
  dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults/range in schema
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Muhammad Husaini Zulkifli (2):
  igc: Expose tx-usecs coalesce setting to user
  igc: Modify the tx-usecs coalesce setting

 drivers/net/ethernet/intel/igc/igc_ethtool.c | 46 +++++++++++++++-----
 1 file changed, 34 insertions(+), 12 deletions(-)

-- 
2.38.1


