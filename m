Return-Path: <netdev+bounces-25016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF651772A00
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA1280E9A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6703C111AC;
	Mon,  7 Aug 2023 16:01:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85611190
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:01:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89280E72
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691424097; x=1722960097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cUqjKer+5uwiSyBxYhhMd/RhPbu+D0VIVAEb66SA7io=;
  b=DIRE+6Q5KrGIvR7UYBqvXktm4hp/GnxWrrPx76xmwQOCnRt5Qskoh9vw
   ygro0lrag5UgYUOgOFFyjdce5oljiorrK/ooRTXDaMLS+F4yHS3i0VRzt
   SShGExW2RfG5JhzRo00NmPEHmH3jqcrPrhSWH4YBV5THU5RlgC7jPSpGS
   r7fDDaUbuJ5N2S8Ha/qig519eyrQZePuHw7DF7cHwQ/nqDapeO1tc+nZz
   EHb9syp1zG+XmOzOHq16xV5Fe94TLq7/sfwxU5y6zs9tdMoUq62s09C7V
   KOF5gU6RaY+VCPOXAJIQ9zRqICH5g+VjuFZb/XA1n3ajsNRHK69n7oqSa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="456967052"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="456967052"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 09:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796365562"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="796365562"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2023 09:01:34 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E64A3312D4;
	Mon,  7 Aug 2023 17:01:33 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 0/3] ice: split ice_aq_wait_for_event() func into two
Date: Mon,  7 Aug 2023 11:58:45 -0400
Message-Id: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mitigate race between registering on wait list and receiving
AQ Response from FW.

The first patch fixes bound check to be more inclusive;
the second one refactors code to make the third one smaller,
which is an actual fix for the race.

Thanks Simon Horman for pushing into split, it's easier to follow now.

v3: split into 3 commits

Przemek Kitszel (3):
  ice: ice_aq_check_events: fix off-by-one check when filling buffer
  ice: embed &ice_rq_event_info event into struct ice_aq_task
  ice: split ice_aq_wait_for_event() func into two

 drivers/net/ethernet/intel/ice/ice.h          |  21 +++-
 .../net/ethernet/intel/ice/ice_fw_update.c    |  45 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c     | 100 +++++++++---------
 3 files changed, 94 insertions(+), 72 deletions(-)


base-commit: 1efaa6ca8af14114dafb99924bc922daa135f870
-- 
2.40.1


